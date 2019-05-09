Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C034B187F7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEIJtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:49:11 -0400
Received: from mail-eopbgr770105.outbound.protection.outlook.com ([40.107.77.105]:31457
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfEIJtK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7GaokOwdqlR0groIxfixQzgum/YNpJeNIL9rhrUGr8=;
 b=fA0F29mjgvrPCtAt/YZhVWeAEapeVHwXQsYRugIZBz4kl4qkuZFw7PX2Al+lhcTOUcPc7Ud/gd3crptxuZKQ51sHW9ZQN5U827rUsD/tBG2n1kEhXIx/w2uwKKCBP0mxluGqFQtS+MllLB0viKZdxI4gMzmI/3kyg73iRikux5k=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB4777.namprd06.prod.outlook.com (20.176.112.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:49:06 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:49:06 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH V2 2/3] nl80211: add support for SAE authentication offload
Thread-Topic: [PATCH V2 2/3] nl80211: add support for SAE authentication
 offload
Thread-Index: AQHVBkxxgLQSiZ1pREysA5TSDvl90w==
Date:   Thu, 9 May 2019 09:49:06 +0000
Message-ID: <1557395332-41426-3-git-send-email-chi-hsien.lin@cypress.com>
References: <1557395332-41426-1-git-send-email-chi-hsien.lin@cypress.com>
In-Reply-To: <1557395332-41426-1-git-send-email-chi-hsien.lin@cypress.com>
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
x-ms-office365-filtering-correlation-id: 660eb1e8-88ec-400a-cf96-08d6d463939a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR06MB4777;
x-ms-traffictypediagnostic: DM6PR06MB4777:
x-microsoft-antispam-prvs: <DM6PR06MB4777B3C64E1708B5D06B765FBB330@DM6PR06MB4777.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(15594002)(189003)(199004)(25786009)(52116002)(66476007)(64756008)(66446008)(53936002)(6436002)(66066001)(14444005)(5640700003)(50226002)(66556008)(6512007)(3846002)(256004)(8936002)(66946007)(6486002)(99286004)(446003)(2906002)(107886003)(4326008)(2616005)(486006)(11346002)(476003)(478600001)(305945005)(76176011)(6916009)(7736002)(386003)(6506007)(71200400001)(71190400001)(54906003)(2501003)(2351001)(186003)(86362001)(14454004)(102836004)(8676002)(26005)(68736007)(6116002)(73956011)(36756003)(5660300002)(316002)(81156014)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4777;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SIDP/XY/LxsP5ym+OkE4UQNKMQ9S9dzwpZR3ymLRVpjZri94Nl1m+0QJv9y9FyVtE9b9ZDVnW1AXYiSXMvsTFTFwloH8WXdLh0LmrVlGRw3tAfVxv1suQuXufG/qEHQcA0iTVu6eTBOYMTU27G6kBpGYuduvokzibBxg0LLsBJnVw+SKqMn+Idqiasd0AiOfUQXX33GcQe8sSCXliOOHP+FfAo/t3iVC5sYHZY+Rl79mfaOhwwnS6So4VngxIH8EqBgB1qOIjPFf247qQxVT7/KxjHLv77P01qRFHtDqV/Iqp3OTui3/AHNlyc2tGXOVCGKSMN4u3Efc+g8oA9pHuNT0RomRDN5gsIfmhbD1dd32Aupp5iEn60iuwK1dVV6kekwhuTJ/bXiyVSbO3vGJhXtf3y6dPsSANk/KW5aG8Uo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660eb1e8-88ec-400a-cf96-08d6d463939a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:49:06.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4777
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQ2h1bmctSHNpZW4gSHN1IDxzdGFubGV5LmhzdUBjeXByZXNzLmNvbT4NCg0KTGV0IGRy
aXZlcnMgYWR2ZXJ0aXNlIHN1cHBvcnQgZm9yIHN0YXRpb24tbW9kZSBTQUUgYXV0aGVudGljYXRp
b24NCm9mZmxvYWQgd2l0aCBhIG5ldyBOTDgwMjExX0VYVF9GRUFUVVJFX1NBRV9PRkZMT0FEIGZs
YWcuDQoNClNpZ25lZC1vZmYtYnk6IENodW5nLUhzaWVuIEhzdSA8c3RhbmxleS5oc3VAY3lwcmVz
cy5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaGktSHNpZW4gTGluIDxjaGktaHNpZW4ubGluQGN5cHJl
c3MuY29tPg0KLS0tDQogaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaCAgICB8ICAxICsNCiBpbmNs
dWRlL25ldC9jZmc4MDIxMS5oICAgICAgIHwgIDUgKysrKysNCiBpbmNsdWRlL3VhcGkvbGludXgv
bmw4MDIxMS5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KIG5ldC93aXJlbGVzcy9ubDgwMjEx
LmMgICAgICAgfCAxNCArKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaCBiL2luY2x1
ZGUvbGludXgvaWVlZTgwMjExLmgNCmluZGV4IDYxZjBhMzE2YzZhYy4uNWRmZDk0OWFkZTI1IDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaA0KKysrIGIvaW5jbHVkZS9saW51
eC9pZWVlODAyMTEuaA0KQEAgLTI2MTIsNiArMjYxMiw3IEBAIGVudW0gaWVlZTgwMjExX2tleV9s
ZW4gew0KICNkZWZpbmUgRklMU19FUlBfTUFYX1JSS19MRU4JCTY0DQogDQogI2RlZmluZSBQTUtf
TUFYX0xFTgkJCTY0DQorI2RlZmluZSBTQUVfUEFTU1dPUkRfTUFYX0xFTgkJMTI4DQogDQogLyog
UHVibGljIGFjdGlvbiBjb2RlcyAoSUVFRSBTdGQgODAyLjExLTIwMTYsIDkuNi44LjEsIFRhYmxl
IDktMzA3KSAqLw0KIGVudW0gaWVlZTgwMjExX3B1Yl9hY3Rpb25jb2RlIHsNCmRpZmYgLS1naXQg
YS9pbmNsdWRlL25ldC9jZmc4MDIxMS5oIGIvaW5jbHVkZS9uZXQvY2ZnODAyMTEuaA0KaW5kZXgg
ODdkYWU4Njg3MDdlLi42ZDRjNGQ0ZmQ1NzEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL25ldC9jZmc4
MDIxMS5oDQorKysgYi9pbmNsdWRlL25ldC9jZmc4MDIxMS5oDQpAQCAtNzQyLDYgKzc0Miw5IEBA
IHN0cnVjdCBzdXJ2ZXlfaW5mbyB7DQogICoJQ0ZHODAyMTFfTUFYX1dFUF9LRVlTIFdFUCBrZXlz
DQogICogQHdlcF90eF9rZXk6IGtleSBpbmRleCAoMC4uMykgb2YgdGhlIGRlZmF1bHQgVFggc3Rh
dGljIFdFUCBrZXkNCiAgKiBAcHNrOiBQU0sgKGZvciBkZXZpY2VzIHN1cHBvcnRpbmcgNC13YXkt
aGFuZHNoYWtlIG9mZmxvYWQpDQorICogQHNhZV9wd2Q6IHBhc3N3b3JkIGZvciBTQUUgYXV0aGVu
dGljYXRpb24gKGZvciBkZXZpY2VzIHN1cHBvcnRpbmcgU0FFDQorICoJb2ZmbG9hZCkNCisgKiBA
c2FlX3B3ZF9sZW46IGxlbmd0aCBvZiBTQUUgcGFzc3dvcmQgKGZvciBkZXZpY2VzIHN1cHBvcnRp
bmcgU0FFIG9mZmxvYWQpDQogICovDQogc3RydWN0IGNmZzgwMjExX2NyeXB0b19zZXR0aW5ncyB7
DQogCXUzMiB3cGFfdmVyc2lvbnM7DQpAQCAtNzU3LDYgKzc2MCw4IEBAIHN0cnVjdCBjZmc4MDIx
MV9jcnlwdG9fc2V0dGluZ3Mgew0KIAlzdHJ1Y3Qga2V5X3BhcmFtcyAqd2VwX2tleXM7DQogCWlu
dCB3ZXBfdHhfa2V5Ow0KIAljb25zdCB1OCAqcHNrOw0KKwljb25zdCB1OCAqc2FlX3B3ZDsNCisJ
dTggc2FlX3B3ZF9sZW47DQogfTsNCiANCiAvKioNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
bGludXgvbmw4MDIxMS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L25sODAyMTEuaA0KaW5kZXggZTli
ZjNkNjlkODQ3Li44YjFlNDNmZWNkMjUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgv
bmw4MDIxMS5oDQorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvbmw4MDIxMS5oDQpAQCAtMjM1LDYg
KzIzNSwxNSBAQA0KICAqLw0KIA0KIC8qKg0KKyAqIERPQzogU0FFIGF1dGhlbnRpY2F0aW9uIG9m
ZmxvYWQNCisgKg0KKyAqIEJ5IHNldHRpbmcgQE5MODAyMTFfRVhUX0ZFQVRVUkVfU0FFX09GRkxP
QUQgZmxhZyBkcml2ZXJzIGNhbiBpbmRpY2F0ZSB0aGV5DQorICogc3VwcG9ydCBvZmZsb2FkaW5n
IFNBRSBhdXRoZW50aWNhdGlvbiBmb3IgV1BBMy1QZXJzb25hbCBuZXR3b3Jrcy4gSW4NCisgKiAl
Tkw4MDIxMV9DTURfQ09OTkVDVCB0aGUgcGFzc3dvcmQgZm9yIFNBRSBzaG91bGQgYmUgc3BlY2lm
aWVkIHVzaW5nDQorICogJU5MODAyMTFfQVRUUl9TQUVfUEFTU1dPUkQuDQorICovDQorDQorLyoq
DQogICogZW51bSBubDgwMjExX2NvbW1hbmRzIC0gc3VwcG9ydGVkIG5sODAyMTEgY29tbWFuZHMN
CiAgKg0KICAqIEBOTDgwMjExX0NNRF9VTlNQRUM6IHVuc3BlY2lmaWVkIGNvbW1hbmQgdG8gY2F0
Y2ggZXJyb3JzDQpAQCAtMjM0MSw2ICsyMzUwLDEwIEBAIGVudW0gbmw4MDIxMV9jb21tYW5kcyB7
DQogICoJc2hvdWxkIGJlIHBpY2tpbmcgdXAgdGhlIGxvd2VzdCB0eCBwb3dlciwgZWl0aGVyIHR4
IHBvd2VyIHBlci1pbnRlcmZhY2UNCiAgKglvciBwZXItc3RhdGlvbi4NCiAgKg0KKyAqIEBOTDgw
MjExX0FUVFJfU0FFX1BBU1NXT1JEOiBhdHRyaWJ1dGUgZm9yIHBhc3NpbmcgU0FFIHBhc3N3b3Jk
IG1hdGVyaWFsLiBJdA0KKyAqCWlzIHVzZWQgd2l0aCAlTkw4MDIxMV9DTURfQ09OTkVDVCB0byBw
cm92aWRlIHBhc3N3b3JkIGZvciBvZmZsb2FkaW5nDQorICoJU0FFIGF1dGhlbnRpY2F0aW9uIGZv
ciBXUEEzLVBlcnNvbmFsIG5ldHdvcmtzLg0KKyAqDQogICogQE5VTV9OTDgwMjExX0FUVFI6IHRv
dGFsIG51bWJlciBvZiBubDgwMjExX2F0dHJzIGF2YWlsYWJsZQ0KICAqIEBOTDgwMjExX0FUVFJf
TUFYOiBoaWdoZXN0IGF0dHJpYnV0ZSBudW1iZXIgY3VycmVudGx5IGRlZmluZWQNCiAgKiBAX19O
TDgwMjExX0FUVFJfQUZURVJfTEFTVDogaW50ZXJuYWwgdXNlDQpAQCAtMjc5NCw2ICsyODA3LDgg
QEAgZW51bSBubDgwMjExX2F0dHJzIHsNCiAJTkw4MDIxMV9BVFRSX1NUQV9UWF9QT1dFUl9TRVRU
SU5HLA0KIAlOTDgwMjExX0FUVFJfU1RBX1RYX1BPV0VSLA0KIA0KKwlOTDgwMjExX0FUVFJfU0FF
X1BBU1NXT1JELA0KKw0KIAkvKiBhZGQgYXR0cmlidXRlcyBoZXJlLCB1cGRhdGUgdGhlIHBvbGlj
eSBpbiBubDgwMjExLmMgKi8NCiANCiAJX19OTDgwMjExX0FUVFJfQUZURVJfTEFTVCwNCkBAIC01
NDIzLDYgKzU0MzgsOSBAQCBlbnVtIG5sODAyMTFfZmVhdHVyZV9mbGFncyB7DQogICogQE5MODAy
MTFfRVhUX0ZFQVRVUkVfU1RBX1RYX1BXUjogVGhpcyBkcml2ZXIgc3VwcG9ydHMgY29udHJvbGxp
bmcgdHggcG93ZXINCiAgKgl0byBhIHN0YXRpb24uDQogICoNCisgKiBATkw4MDIxMV9FWFRfRkVB
VFVSRV9TQUVfT0ZGTE9BRDogRGV2aWNlIHdhbnRzIHRvIGRvIFNBRSBhdXRoZW50aWNhdGlvbiBp
bg0KKyAqCXN0YXRpb24gbW9kZSAoU0FFIHBhc3N3b3JkIGlzIHBhc3NlZCBhcyBwYXJ0IG9mIHRo
ZSBjb25uZWN0IGNvbW1hbmQpLg0KKyAqDQogICogQE5VTV9OTDgwMjExX0VYVF9GRUFUVVJFUzog
bnVtYmVyIG9mIGV4dGVuZGVkIGZlYXR1cmVzLg0KICAqIEBNQVhfTkw4MDIxMV9FWFRfRkVBVFVS
RVM6IGhpZ2hlc3QgZXh0ZW5kZWQgZmVhdHVyZSBpbmRleC4NCiAgKi8NCkBAIC01NDY3LDYgKzU0
ODUsNyBAQCBlbnVtIG5sODAyMTFfZXh0X2ZlYXR1cmVfaW5kZXggew0KIAlOTDgwMjExX0VYVF9G
RUFUVVJFX1NDSEVEX1NDQU5fQkFORF9TUEVDSUZJQ19SU1NJX1RIT0xELA0KIAlOTDgwMjExX0VY
VF9GRUFUVVJFX0VYVF9LRVlfSUQsDQogCU5MODAyMTFfRVhUX0ZFQVRVUkVfU1RBX1RYX1BXUiwN
CisJTkw4MDIxMV9FWFRfRkVBVFVSRV9TQUVfT0ZGTE9BRCwNCiANCiAJLyogYWRkIG5ldyBmZWF0
dXJlcyBiZWZvcmUgdGhlIGRlZmluaXRpb24gYmVsb3cgKi8NCiAJTlVNX05MODAyMTFfRVhUX0ZF
QVRVUkVTLA0KZGlmZiAtLWdpdCBhL25ldC93aXJlbGVzcy9ubDgwMjExLmMgYi9uZXQvd2lyZWxl
c3Mvbmw4MDIxMS5jDQppbmRleCA4ZTQ3MDU5MWM0MjQuLmQ1MTAxNTQwNWU2ZiAxMDA2NDQNCi0t
LSBhL25ldC93aXJlbGVzcy9ubDgwMjExLmMNCisrKyBiL25ldC93aXJlbGVzcy9ubDgwMjExLmMN
CkBAIC01NDYsNiArNTQ2LDggQEAgY29uc3Qgc3RydWN0IG5sYV9wb2xpY3kgbmw4MDIxMV9wb2xp
Y3lbTlVNX05MODAyMTFfQVRUUl0gPSB7DQogCVtOTDgwMjExX0FUVFJfUEVFUl9NRUFTVVJFTUVO
VFNdID0NCiAJCU5MQV9QT0xJQ1lfTkVTVEVEKG5sODAyMTFfcG1zcl9hdHRyX3BvbGljeSksDQog
CVtOTDgwMjExX0FUVFJfQUlSVElNRV9XRUlHSFRdID0gTkxBX1BPTElDWV9NSU4oTkxBX1UxNiwg
MSksDQorCVtOTDgwMjExX0FUVFJfU0FFX1BBU1NXT1JEXSA9IHsgLnR5cGUgPSBOTEFfQklOQVJZ
LA0KKwkJCQkJLmxlbiA9IFNBRV9QQVNTV09SRF9NQVhfTEVOIH0sDQogfTsNCiANCiAvKiBwb2xp
Y3kgZm9yIHRoZSBrZXkgYXR0cmlidXRlcyAqLw0KQEAgLTQzOTcsNiArNDM5OSw4IEBAIHN0YXRp
YyBib29sIG5sODAyMTFfdmFsaWRfYXV0aF90eXBlKHN0cnVjdCBjZmc4MDIxMV9yZWdpc3RlcmVk
X2RldmljZSAqcmRldiwNCiAJCXJldHVybiB0cnVlOw0KIAljYXNlIE5MODAyMTFfQ01EX0NPTk5F
Q1Q6DQogCQlpZiAoIShyZGV2LT53aXBoeS5mZWF0dXJlcyAmIE5MODAyMTFfRkVBVFVSRV9TQUUp
ICYmDQorCQkgICAgIXdpcGh5X2V4dF9mZWF0dXJlX2lzc2V0KCZyZGV2LT53aXBoeSwNCisJCQkJ
CSAgICAgTkw4MDIxMV9FWFRfRkVBVFVSRV9TQUVfT0ZGTE9BRCkgJiYNCiAJCSAgICBhdXRoX3R5
cGUgPT0gTkw4MDIxMV9BVVRIVFlQRV9TQUUpDQogCQkJcmV0dXJuIGZhbHNlOw0KIA0KQEAgLTg5
MzYsNiArODk0MCwxNiBAQCBzdGF0aWMgaW50IG5sODAyMTFfY3J5cHRvX3NldHRpbmdzKHN0cnVj
dCBjZmc4MDIxMV9yZWdpc3RlcmVkX2RldmljZSAqcmRldiwNCiAJCXNldHRpbmdzLT5wc2sgPSBu
bGFfZGF0YShpbmZvLT5hdHRyc1tOTDgwMjExX0FUVFJfUE1LXSk7DQogCX0NCiANCisJaWYgKGlu
Zm8tPmF0dHJzW05MODAyMTFfQVRUUl9TQUVfUEFTU1dPUkRdKSB7DQorCQlpZiAoIXdpcGh5X2V4
dF9mZWF0dXJlX2lzc2V0KCZyZGV2LT53aXBoeSwNCisJCQkJCSAgICAgTkw4MDIxMV9FWFRfRkVB
VFVSRV9TQUVfT0ZGTE9BRCkpDQorCQkJcmV0dXJuIC1FSU5WQUw7DQorCQlzZXR0aW5ncy0+c2Fl
X3B3ZCA9DQorCQkJbmxhX2RhdGEoaW5mby0+YXR0cnNbTkw4MDIxMV9BVFRSX1NBRV9QQVNTV09S
RF0pOw0KKwkJc2V0dGluZ3MtPnNhZV9wd2RfbGVuID0NCisJCQlubGFfbGVuKGluZm8tPmF0dHJz
W05MODAyMTFfQVRUUl9TQUVfUEFTU1dPUkRdKTsNCisJfQ0KKw0KIAlyZXR1cm4gMDsNCiB9DQog
DQotLSANCjIuMS4wDQoNCg==
