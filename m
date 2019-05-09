Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA68187EF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfEIJsa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:48:30 -0400
Received: from mail-eopbgr770125.outbound.protection.outlook.com ([40.107.77.125]:3652
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfEIJsa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=764ztgpPqZzvLAu6819qsXRTvAaPnddYUzZaZrAIi2w=;
 b=n5QIwhGMN3q1dCn9yqOCmFUqt70pJc/lGmmSyEUWXUhqBm00RU72usD8i2W22Uc1XDDdJZAGHQ3KKgjoteslazJui0h+PcnWnN/T2lv+Eagct9s+Mjq8bxFTR681W7Vwg3kNNA5lVqvHDjekbiWFvoUlrYohTX1vAy4+3THvxcg=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB4777.namprd06.prod.outlook.com (20.176.112.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:48:26 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:48:26 +0000
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
Subject: [PATCH V2 2/2] brcmfmac: send port authorized event for FT-802.1X
Thread-Topic: [PATCH V2 2/2] brcmfmac: send port authorized event for
 FT-802.1X
Thread-Index: AQHVBkxZ7FED872LG0e0ghLGDfDOXw==
Date:   Thu, 9 May 2019 09:48:26 +0000
Message-ID: <1557395289-41133-3-git-send-email-chi-hsien.lin@cypress.com>
References: <1557395289-41133-1-git-send-email-chi-hsien.lin@cypress.com>
In-Reply-To: <1557395289-41133-1-git-send-email-chi-hsien.lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [12.110.209.245]
x-clientproxiedby: SN2PR01CA0012.prod.exchangelabs.com (2603:10b6:804:2::22)
 To DM6PR06MB5804.namprd06.prod.outlook.com (2603:10b6:5:1a6::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faffa0a9-7f1d-46eb-b141-08d6d4637bbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR06MB4777;
x-ms-traffictypediagnostic: DM6PR06MB4777:
x-microsoft-antispam-prvs: <DM6PR06MB4777581AF783F0755EB222DBBB330@DM6PR06MB4777.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(25786009)(52116002)(66476007)(64756008)(66446008)(53936002)(6436002)(66066001)(14444005)(5640700003)(50226002)(66556008)(6512007)(3846002)(256004)(8936002)(66946007)(6486002)(99286004)(446003)(2906002)(107886003)(4326008)(2616005)(486006)(11346002)(476003)(478600001)(305945005)(76176011)(6916009)(7736002)(386003)(6506007)(71200400001)(71190400001)(54906003)(2501003)(2351001)(186003)(86362001)(14454004)(102836004)(8676002)(26005)(68736007)(6116002)(73956011)(36756003)(5660300002)(316002)(81156014)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4777;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1xghtTqrFKHKyjwwHLoPYCRyr8TSfcbibPZFHH3RditfBUoNB/RIiLMGq6R5JOIga6etze6s6t+sSki0BklLd8txGPPZ2KZzoOg15iMwqQJaR2ql0rQ1hZdLy4cGY+xHN7Qzzl/TpTJImRLM6nw9n+L5eZPebAt38IsRLU/ORbL3C3bNILMNRAAqp+/q8chw9ZRG2C2nnAJ0XAUA624Es1R8vsNgcf6tOFRdYogPBsboVpN20a0mteqFhc9wpt6ojOuF6F7vDovtqE+IQvWO4V/mnzBi60VshpA/EmWgiHT7rEp5rvDT6ErBkRjU4Ln926agFR8utybOFUk+NOHzoY4N24LdzvSECCRcLuimOLJTM5e7sbZLbU6UYcUIABLuyMNuY2lIF6Qsjwywyc7k5XV8+fFsm+c0Zb8ZwnDGPjE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faffa0a9-7f1d-46eb-b141-08d6d4637bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:48:26.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4777
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQ2h1bmctSHNpZW4gSHN1IDxzdGFubGV5LmhzdUBjeXByZXNzLmNvbT4NCg0KV2l0aCBG
VC04MDIuMVgsIGRyaXZlciBzaG91bGQgc2VuZCBhIHBvcnQgYXV0aG9yaXplZCBldmVudCByaWdo
dCBhZnRlcg0Kc2VuZGluZyBhIHJvYW1lZCBldmVudC4gSXQgaXMgdXNlZCB0byBpbmRpY2F0ZSB0
aGF0IGEgbmV3IEFQIGlzIGFscmVhZHkNCmF1dGhvcml6ZWQgc28gODAyLjFYIGlzIG5vdCByZXF1
aXJlZC4NCg0KQWNrZWQtYnk6IEFyZW5kIHZhbiBTcHJpZWwgPGFyZW5kLnZhbnNwcmllbEBicm9h
ZGNvbS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZy1Ic2llbiBIc3UgPHN0YW5sZXkuaHN1QGN5
cHJlc3MuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hpLUhzaWVuIExpbiA8Y2hpLWhzaWVuLmxpbkBj
eXByZXNzLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIx
MS9icmNtZm1hYy9jZmc4MDIxMS5jIHwgOCArKysrKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5oIHwgMSArDQogMiBmaWxlcyBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmMNCmluZGV4IDhl
ZThhZjRlN2VjNC4uNTQ5ZWZiOTE5MzNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmMNCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5jDQpAQCAt
MTYzNCw2ICsxNjM0LDcgQEAgYnJjbWZfc2V0X2tleV9tZ210KHN0cnVjdCBuZXRfZGV2aWNlICpu
ZGV2LCBzdHJ1Y3QgY2ZnODAyMTFfY29ubmVjdF9wYXJhbXMgKnNtZSkNCiAJdTE2IGNvdW50Ow0K
IA0KIAlwcm9maWxlLT51c2VfZndzdXAgPSBCUkNNRl9QUk9GSUxFX0ZXU1VQX05PTkU7DQorCXBy
b2ZpbGUtPmlzX2Z0ID0gZmFsc2U7DQogDQogCWlmICghc21lLT5jcnlwdG8ubl9ha21fc3VpdGVz
KQ0KIAkJcmV0dXJuIDA7DQpAQCAtMTY3OCwxMSArMTY3OSwxMyBAQCBicmNtZl9zZXRfa2V5X21n
bXQoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBjZmc4MDIxMV9jb25uZWN0X3BhcmFt
cyAqc21lKQ0KIAkJCWJyZWFrOw0KIAkJY2FzZSBXTEFOX0FLTV9TVUlURV9GVF84MDIxWDoNCiAJ
CQl2YWwgPSBXUEEyX0FVVEhfVU5TUEVDSUZJRUQgfCBXUEEyX0FVVEhfRlQ7DQorCQkJcHJvZmls
ZS0+aXNfZnQgPSB0cnVlOw0KIAkJCWlmIChzbWUtPndhbnRfMXgpDQogCQkJCXByb2ZpbGUtPnVz
ZV9md3N1cCA9IEJSQ01GX1BST0ZJTEVfRldTVVBfMVg7DQogCQkJYnJlYWs7DQogCQljYXNlIFdM
QU5fQUtNX1NVSVRFX0ZUX1BTSzoNCiAJCQl2YWwgPSBXUEEyX0FVVEhfUFNLIHwgV1BBMl9BVVRI
X0ZUOw0KKwkJCXByb2ZpbGUtPmlzX2Z0ID0gdHJ1ZTsNCiAJCQlicmVhazsNCiAJCWRlZmF1bHQ6
DQogCQkJYnBoeV9lcnIoZHJ2ciwgImludmFsaWQgY2lwaGVyIGdyb3VwICglZClcbiIsDQpAQCAt
NTU1Nyw2ICs1NTYwLDExIEBAIGJyY21mX2Jzc19yb2FtaW5nX2RvbmUoc3RydWN0IGJyY21mX2Nm
ZzgwMjExX2luZm8gKmNmZywNCiAJY2ZnODAyMTFfcm9hbWVkKG5kZXYsICZyb2FtX2luZm8sIEdG
UF9LRVJORUwpOw0KIAlicmNtZl9kYmcoQ09OTiwgIlJlcG9ydCByb2FtaW5nIHJlc3VsdFxuIik7
DQogDQorCWlmIChwcm9maWxlLT51c2VfZndzdXAgPT0gQlJDTUZfUFJPRklMRV9GV1NVUF8xWCAm
JiBwcm9maWxlLT5pc19mdCkgew0KKwkJY2ZnODAyMTFfcG9ydF9hdXRob3JpemVkKG5kZXYsIHBy
b2ZpbGUtPmJzc2lkLCBHRlBfS0VSTkVMKTsNCisJCWJyY21mX2RiZyhDT05OLCAiUmVwb3J0IHBv
cnQgYXV0aG9yaXplZFxuIik7DQorCX0NCisNCiAJc2V0X2JpdChCUkNNRl9WSUZfU1RBVFVTX0NP
Tk5FQ1RFRCwgJmlmcC0+dmlmLT5zbWVfc3RhdGUpOw0KIAlicmNtZl9kYmcoVFJBQ0UsICJFeGl0
XG4iKTsNCiAJcmV0dXJuIGVycjsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9i
cm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuaCBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5oDQppbmRleCA5YTYyODdm
MDg0YTkuLjZhN2RlYzkwOGI2ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jy
b2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9jZmc4MDIxMS5oDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvY2ZnODAyMTEuaA0KQEAgLTEzMyw2
ICsxMzMsNyBAQCBzdHJ1Y3QgYnJjbWZfY2ZnODAyMTFfcHJvZmlsZSB7DQogCXN0cnVjdCBicmNt
Zl9jZmc4MDIxMV9zZWN1cml0eSBzZWM7DQogCXN0cnVjdCBicmNtZl93c2VjX2tleSBrZXlbQlJD
TUZfTUFYX0RFRkFVTFRfS0VZU107DQogCWVudW0gYnJjbWZfcHJvZmlsZV9md3N1cCB1c2VfZndz
dXA7DQorCWJvb2wgaXNfZnQ7DQogfTsNCiANCiAvKioNCi0tIA0KMi4xLjANCg0K
