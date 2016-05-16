/****************************************************************************
** Meta object code from reading C++ file 'trikMotors.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "trikMotors.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'trikMotors.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_SuperCosmoGyroIntegrator3000[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      48,   30,   29,   29, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_SuperCosmoGyroIntegrator3000[] = {
    "SuperCosmoGyroIntegrator3000\0\0"
    "reading,eventTime\0"
    "onNewData(QVector<int>,trikKernel::TimeVal)\0"
};

void SuperCosmoGyroIntegrator3000::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        SuperCosmoGyroIntegrator3000 *_t = static_cast<SuperCosmoGyroIntegrator3000 *>(_o);
        switch (_id) {
        case 0: _t->onNewData((*reinterpret_cast< const QVector<int>(*)>(_a[1])),(*reinterpret_cast< const trikKernel::TimeVal(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData SuperCosmoGyroIntegrator3000::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject SuperCosmoGyroIntegrator3000::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_SuperCosmoGyroIntegrator3000,
      qt_meta_data_SuperCosmoGyroIntegrator3000, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &SuperCosmoGyroIntegrator3000::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *SuperCosmoGyroIntegrator3000::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *SuperCosmoGyroIntegrator3000::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_SuperCosmoGyroIntegrator3000))
        return static_cast<void*>(const_cast< SuperCosmoGyroIntegrator3000*>(this));
    return QObject::qt_metacast(_clname);
}

int SuperCosmoGyroIntegrator3000::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
