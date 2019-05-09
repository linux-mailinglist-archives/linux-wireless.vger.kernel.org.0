Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05365187F5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfEIJtG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:49:06 -0400
Received: from mail-eopbgr770105.outbound.protection.outlook.com ([40.107.77.105]:31457
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfEIJtG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5n6Wjxi9m9EZyHgY25jYJJ8NWOZQzVnLQ9sfpG6lbc=;
 b=VusVkwKohS8yKJ1ugib5BrjtGYi+4/VwymrbHLrtBSxCS+dXhynzRu0qeMd9d/258uURfSmZ+fxoKwbBAJz67omfiLYhMoeMxxzDflhPPhJv/180ZiF/nESch/IVRVTqoFxDA4qloye03zswE5th1u0kS6jbN4PnJIPJGTllSQ0=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB4777.namprd06.prod.outlook.com (20.176.112.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:49:04 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:49:03 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH V2 0/3] nl80211: brcmfmac: add SAE authentication offload
Thread-Topic: [PATCH V2 0/3] nl80211: brcmfmac: add SAE authentication offload
Thread-Index: AQHVBkxvUw4uP2L020yyQH57mPWPQw==
Date:   Thu, 9 May 2019 09:49:03 +0000
Message-ID: <1557395332-41426-1-git-send-email-chi-hsien.lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [12.110.209.245]
x-clientproxiedby: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To DM6PR06MB5804.namprd06.prod.outlook.com
 (2603:10b6:5:1a6::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d4530d8-b7b2-4919-a193-08d6d46391c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR06MB4777;
x-ms-traffictypediagnostic: DM6PR06MB4777:
x-microsoft-antispam-prvs: <DM6PR06MB47778EAE43BED1AF541FEA9ABB330@DM6PR06MB4777.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(54534003)(25786009)(52116002)(66476007)(64756008)(66446008)(53936002)(6436002)(66066001)(5640700003)(50226002)(66556008)(6512007)(3846002)(256004)(8936002)(66946007)(6486002)(99286004)(2906002)(107886003)(4326008)(2616005)(486006)(476003)(478600001)(305945005)(6916009)(7736002)(386003)(6506007)(71200400001)(71190400001)(54906003)(2501003)(2351001)(186003)(86362001)(4744005)(14454004)(102836004)(8676002)(26005)(68736007)(6116002)(73956011)(36756003)(5660300002)(316002)(81156014)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4777;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M14f/mpCJYjms5NgmuipM0NBaWiH8v78g7bU574ezY+WLgK+KdpNLRJOg7Fm2A6+AyyjoCTyKCufbLuIeGBjed8Mjlkui/UBzC8ejSfe/mVCewjDVkgbG5O6QTC+9EOE5ly620D5sZiTbyUHKpFKaHLv4AGr1QeM8PPtIc2pNMPITyDisGQGF09x6lFTsZnSsFu/iN/gPCuAVeTwOZSoTQkLHL1SCPpJsl+l17gjVrkZhryFPkNTHa8HnzAW3kMRz3B9wsZbet3IhRiDD1UXxW3GNgEyIsRObuXboYzSvS022od3wC9+x9cqQtq7ad4x+6vCBarRNreuv0dtFF5M8o+N2RNg7xMw+c1yTJepPxs3TznHm1hLqRfKiOF+fqknRkPKubbhdaWRpqy+h1PlgXlc4Jn82ulu1piYpXOtxgk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4530d8-b7b2-4919-a193-08d6d46391c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:49:03.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4777
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkcyBTQUUgYXV0aGVudGljYXRpb24gb2ZmbG9hZC4NCg0KQ2hhbmdlbG9nOg0KVjI6DQogLSBD
aGFuZ2Ugc2FlX3B3ZF9sZW4gZnJvbSB1MTYgdG8gdTguDQogLSBNb3ZlIHRoZSBuZXcgYXR0cmli
dXRlIHRvIGJvdHRvbS4NCg0KQ2h1bmctSHNpZW4gSHN1ICgzKToNCiAgbmw4MDIxMTogYWRkIFdQ
QTMgZGVmaW5pdGlvbiBmb3IgU0FFIGF1dGhlbnRpY2F0aW9uDQogIG5sODAyMTE6IGFkZCBzdXBw
b3J0IGZvciBTQUUgYXV0aGVudGljYXRpb24gb2ZmbG9hZA0KICBicmNtZm1hYzogYWRkIHN1cHBv
cnQgZm9yIFNBRSBhdXRoZW50aWNhdGlvbiBvZmZsb2FkDQoNCiAuLi4vYnJvYWRjb20vYnJjbTgw
MjExL2JyY21mbWFjL2NmZzgwMjExLmMgICAgICAgICB8IDczICsrKysrKysrKysrKysrKysrKysr
LS0NCiAuLi4vYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmggICAgICAgICB8
ICAzICstDQogLi4uL3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9mZWF0dXJl
LmMgfCAgMSArDQogLi4uL3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9mZWF0
dXJlLmggfCAgNCArLQ0KIC4uLi9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvZndpbF90eXBl
cy5oICAgICAgIHwgMTMgKysrKw0KIC4uLi9icm9hZGNvbS9icmNtODAyMTEvaW5jbHVkZS9icmNt
dV93aWZpLmggICAgICAgIHwgIDIgKw0KIGluY2x1ZGUvbGludXgvaWVlZTgwMjExLmggICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIGluY2x1ZGUvbmV0L2NmZzgwMjExLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysNCiBpbmNsdWRlL3VhcGkvbGludXgvbmw4MDIx
MS5oICAgICAgICAgICAgICAgICAgICAgICB8IDIwICsrKysrKw0KIG5ldC93aXJlbGVzcy9ubDgw
MjExLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTcgKysrKy0NCiAxMCBmaWxlcyBj
aGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjEuMA0K
DQo=
