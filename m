Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED8187F6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2019 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEIJtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 May 2019 05:49:09 -0400
Received: from mail-eopbgr770105.outbound.protection.outlook.com ([40.107.77.105]:31457
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfEIJtI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 May 2019 05:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ovxiVdpP/ywtD16o8mFoyqWBJYb1bxlvBLbTQBRMdE=;
 b=S53Hjp5oTD6A1joNIUglcmzyW93iku2/NTAclnUqePJCbFsSa7Xq0a/YkqVm48PW9aKR9UkcILlpqs/t4ylsDiRz1woJCnQ8z7PM/Mbc8pqBFCvLbOQyy+NndA2jBtofIgCKaVcA1DXYKnew8uNr/Ul+29xmqMFQRctkH0wsg8I=
Received: from DM6PR06MB5804.namprd06.prod.outlook.com (20.179.161.141) by
 DM6PR06MB4777.namprd06.prod.outlook.com (20.176.112.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Thu, 9 May 2019 09:49:05 +0000
Received: from DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c]) by DM6PR06MB5804.namprd06.prod.outlook.com
 ([fe80::e08f:7f34:9d7d:5a7c%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 09:49:05 +0000
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
Subject: [PATCH V2 1/3] nl80211: add WPA3 definition for SAE authentication
Thread-Topic: [PATCH V2 1/3] nl80211: add WPA3 definition for SAE
 authentication
Thread-Index: AQHVBkxwfJ5nEm0ck0ukLW6pn3CIxg==
Date:   Thu, 9 May 2019 09:49:05 +0000
Message-ID: <1557395332-41426-2-git-send-email-chi-hsien.lin@cypress.com>
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
x-ms-office365-filtering-correlation-id: 7c285cf9-3eae-4499-8352-08d6d46392a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR06MB4777;
x-ms-traffictypediagnostic: DM6PR06MB4777:
x-microsoft-antispam-prvs: <DM6PR06MB4777226D7A628CF54EFE0D7CBB330@DM6PR06MB4777.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(25786009)(52116002)(66476007)(64756008)(66446008)(53936002)(6436002)(66066001)(14444005)(5640700003)(50226002)(66556008)(6512007)(3846002)(256004)(8936002)(66946007)(6486002)(99286004)(446003)(2906002)(107886003)(4326008)(2616005)(486006)(11346002)(476003)(478600001)(305945005)(76176011)(6916009)(7736002)(386003)(6506007)(71200400001)(71190400001)(54906003)(2501003)(2351001)(186003)(86362001)(14454004)(102836004)(8676002)(26005)(68736007)(6116002)(73956011)(36756003)(5660300002)(316002)(81156014)(81166006)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4777;H:DM6PR06MB5804.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rdm59bZC7K8SldGwQ1K4vriR2OBu0mSR5OTvZEk14511eJAbLfdYhAzwilRjqZXbzdnhxehVSZZraLXsu3Yl/OU+vkwCE+cdlq6+RNVBLGxlN5c5p7Wn1JkQUBhz538R4+X703q9vdiT1EDqGdImVTdh8zcsjiK3EaUjZ9B1QiMk+QY5XyuliEJR108LiZVMWBTKv7fSNJxRtAR2xUStzhc1H7PUkGvwoMNIaBK46o0NqBkJL62ZmSX0KBMwRqeb7pWcyOpvdgaGEVuP9hZ9OxIpYFI6oWhKuWBOyiwDyOgYxqK8/Ucou+JGHWHfvdnITsXO1mZOh48lPVUE4qCMeA9RA7z/o7x95qBLayd91uRo1/OSt2Koj0iek8DTJlwNOh3HGZ1n2y6MOSHA7BsvtofUrqAOb52gD7KmFLrj90o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c285cf9-3eae-4499-8352-08d6d46392a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 09:49:05.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4777
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQ2h1bmctSHNpZW4gSHN1IDxzdGFubGV5LmhzdUBjeXByZXNzLmNvbT4NCg0KQWRkIGRl
ZmluaXRpb24gb2YgV1BBIHZlcnNpb24gMyBmb3IgU0FFIGF1dGhlbnRpY2F0aW9uLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZy1Ic2llbiBIc3UgPHN0YW5sZXkuaHN1QGN5cHJlc3MuY29tPg0KU2ln
bmVkLW9mZi1ieTogQ2hpLUhzaWVuIExpbiA8Y2hpLWhzaWVuLmxpbkBjeXByZXNzLmNvbT4NCi0t
LQ0KIGluY2x1ZGUvdWFwaS9saW51eC9ubDgwMjExLmggfCAxICsNCiBuZXQvd2lyZWxlc3Mvbmw4
MDIxMS5jICAgICAgIHwgMyArKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L25sODAyMTEu
aCBiL2luY2x1ZGUvdWFwaS9saW51eC9ubDgwMjExLmgNCmluZGV4IDZmMDlkMTUwMDk2MC4uZTli
ZjNkNjlkODQ3IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L25sODAyMTEuaA0KKysr
IGIvaW5jbHVkZS91YXBpL2xpbnV4L25sODAyMTEuaA0KQEAgLTQ0MDYsNiArNDQwNiw3IEBAIGVu
dW0gbmw4MDIxMV9tZnAgew0KIGVudW0gbmw4MDIxMV93cGFfdmVyc2lvbnMgew0KIAlOTDgwMjEx
X1dQQV9WRVJTSU9OXzEgPSAxIDw8IDAsDQogCU5MODAyMTFfV1BBX1ZFUlNJT05fMiA9IDEgPDwg
MSwNCisJTkw4MDIxMV9XUEFfVkVSU0lPTl8zID0gMSA8PCAyLA0KIH07DQogDQogLyoqDQpkaWZm
IC0tZ2l0IGEvbmV0L3dpcmVsZXNzL25sODAyMTEuYyBiL25ldC93aXJlbGVzcy9ubDgwMjExLmMN
CmluZGV4IGZmZmU0YjM3MWUyMy4uOGU0NzA1OTFjNDI0IDEwMDY0NA0KLS0tIGEvbmV0L3dpcmVs
ZXNzL25sODAyMTEuYw0KKysrIGIvbmV0L3dpcmVsZXNzL25sODAyMTEuYw0KQEAgLTg2OTksNyAr
ODY5OSw4IEBAIHN0YXRpYyBpbnQgbmw4MDIxMV9kdW1wX3N1cnZleShzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLCBzdHJ1Y3QgbmV0bGlua19jYWxsYmFjayAqY2IpDQogc3RhdGljIGJvb2wgbmw4MDIxMV92
YWxpZF93cGFfdmVyc2lvbnModTMyIHdwYV92ZXJzaW9ucykNCiB7DQogCXJldHVybiAhKHdwYV92
ZXJzaW9ucyAmIH4oTkw4MDIxMV9XUEFfVkVSU0lPTl8xIHwNCi0JCQkJICBOTDgwMjExX1dQQV9W
RVJTSU9OXzIpKTsNCisJCQkJICBOTDgwMjExX1dQQV9WRVJTSU9OXzIgfA0KKwkJCQkgIE5MODAy
MTFfV1BBX1ZFUlNJT05fMykpOw0KIH0NCiANCiBzdGF0aWMgaW50IG5sODAyMTFfYXV0aGVudGlj
YXRlKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQotLSANCjIu
MS4wDQoNCg==
