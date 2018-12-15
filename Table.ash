/////////////
/* Records */
/////////////

record CellBuilder {
	string data;
};

record RowBuilder {
	CellBuilder [int] cells;
	int size;
};

record TableBuilder {
	RowBuilder [int] rows;
	int width;
};

////////////
/* Adders */
////////////


RowBuilder addCell(RowBuilder builder, CellBuilder cellBuilder) {
	int nextCell = count(builder.cells);
	if (builder.size <= nextCell) {
		abort("Cannot add additional cell, over size limit");
	}
	builder.cells[nextCell] = cellBuilder;
	return builder;
}

RowBuilder addCell(RowBuilder builder, string data) {
	CellBuilder cBuilder;
	cBuilder.data = data;
	return builder.addCell(cBuilder);
}

TableBuilder addRow(TableBuilder builder, RowBuilder rowBuilder) {
	if (rowBuilder.size != builder.width) {
		abort("Cannot add row of different size to table");
	}
	int nextRow = count(builder.rows);
	builder.rows[nextRow] = rowBuilder;
	return builder;
}

//////////////////////
/* Builder creators */
//////////////////////

CellBuilder cellBuilder(string data) {
	CellBuilder builder;
	builder.data = data;
	return builder;
}

RowBuilder rowBuilder(int size) {
	RowBuilder builder;
	builder.size = size;
	return builder;
}

TableBuilder tableBuilder(int width) {
	TableBuilder builder;
	builder.width = width;
	return builder;
}

//////////////////////////
/* toString() functions */
//////////////////////////

string toString(CellBuilder builder) {
	return "<td>" + builder.data + "</td>";
}

string toString(RowBuilder builder) {
	string row = "<tr>";
	foreach cell in builder.cells {
		row += builder.cells[cell].toString();
	}
	row += "</tr>";

	return row;
}

string toString(TableBuilder builder) {
	string table = "<table width=95%>";
	foreach row in builder.rows {
		table += builder.rows[row].toString();
	}
	table += "</table>";

	return table;
}