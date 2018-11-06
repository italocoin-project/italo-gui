#pragma once

#include <QObject>
#include <wallet/api/wallet2_api.h>

class NetworkType : public QObject
{
    Q_OBJECT

public:
    enum Type : uint8_t {
        MAINNET = Italo::MAINNET,
        TESTNET = Italo::TESTNET,
        STAGENET = Italo::STAGENET
    };
    Q_ENUM(Type)
};
