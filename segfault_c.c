
void second() {
    int a[1];
    a[999999] = 5;
}

void first() {
    second();
}

int main(void) {

    first();

}

