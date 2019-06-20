Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3A4DAC4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfFTTy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 15:54:59 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:38020 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFTTy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 15:54:59 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="36724349"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2019 12:54:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Jun 2019 12:54:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 20 Jun 2019 12:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Z4UgMpfpCbeIqfzjlM//meqZKB6DrXTSmesyWGAbE=;
 b=RIIIVfAmQ/gKNWSkFMhzUI89cXxI3KhEr74uP+FybJfnt+9ZspEiqLYCsAeZHUNkjdrUn3/vXnSbonP3saIzWjPnCGzheRSbzkVgBIrlIzVSU/tIRkTFO/+axMATWN0Ndx3k5OOe+3q6T1LbplfrTo3DDIe2j+xoHPxjI2nqrCU=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1870.namprd11.prod.outlook.com (10.175.53.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 20 Jun 2019 19:54:55 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::9ce9:4621:3c3f:a961]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::9ce9:4621:3c3f:a961%4]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 19:54:55 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: add passive scan support
Thread-Topic: [PATCH] staging: wilc1000: add passive scan support
Thread-Index: AQHVJ6IIPIn0BMAQSEeBPOpYbYNq0A==
Date:   Thu, 20 Jun 2019 19:54:55 +0000
Message-ID: <20190620195447.16060-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 716999d0-fd69-4c22-0d7c-08d6f5b92a91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1870;
x-ms-traffictypediagnostic: MWHPR11MB1870:
x-microsoft-antispam-prvs: <MWHPR11MB187032A75B2F922685B89FAD8DE40@MWHPR11MB1870.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(199004)(50226002)(1076003)(476003)(68736007)(6116002)(72206003)(8936002)(2616005)(14444005)(256004)(25786009)(478600001)(6486002)(71200400001)(71190400001)(14454004)(99286004)(36756003)(73956011)(86362001)(5660300002)(52116002)(64756008)(66556008)(66946007)(66476007)(66446008)(6916009)(2906002)(2351001)(26005)(6436002)(4326008)(3846002)(316002)(5640700003)(54906003)(186003)(102836004)(53936002)(7736002)(6512007)(486006)(107886003)(66066001)(81156014)(305945005)(2501003)(81166006)(6506007)(386003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1870;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u/OJaZEBeO686Nu9VN0ZQd3bHK6zyOE5LATs8odN2xbhAnwSYh/VgW2GDhYKQuver3e0yESdTOuKrCrsLMDeTnvwBS0ORrMTBOqpFHVrGlvjGmvCFOZ/zdI6gLClLYiznggmqbjRkt4xIq5I0zPIGmq77qksinkl98rreHI9D4pZdzHUBP1hav8DACqeXdlj9AsG9ObOM/lyNqLtRtQIsSPilJlSil6f9K2Rfu5g/n8dUayI8aS8n3jk2M/BAvEZZxHambjWoaD20FTpJ35zJuSz0PkD23Z3xI76H6OzzdIFQB6rgnoXuN1bOdmBBGeLOzZBuf/7YiUCV1sboVNNXc+ZSQEZGr3xfhzLOToS0r+wiyz6G+dx3JOJ7Mz4nB83p8yDg4LkGjy94QT6zaTYqKM5Qa6PYu+mU/jPlWUUdfc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 716999d0-fd69-4c22-0d7c-08d6f5b92a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 19:54:55.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1870
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWRoYW0gQWJvemFlaWQgPGFkaGFtLmFib3phZWlkQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBwYXNzaXZlIHNjYW4gc3VwcG9ydCB0byB0aGUgZHJpdmVyIGJ5IHBhc3NpbmcgdGhlIHNjYW4g
dHlwZSB0byB0aGUNCkhXIGFuZCBjb25maWd1cmUgdGhlIEhXIHNjYW4gdGltZSBpZiBjb25maWd1
cmVkIGJ5IHRoZSBjZmc4MDIxMS4NCg0KU2lnbmVkLW9mZi1ieTogQWRoYW0gQWJvemFlaWQgPGFk
aGFtLmFib3phZWlkQG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvd2lsYzEw
MDAvaG9zdF9pbnRlcmZhY2UuYyAgICAgIHwgMTggKysrKysrKysrKysrKysrLS0tDQogZHJpdmVy
cy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmggICAgICB8ICAxIC0NCiAuLi4vc3Rh
Z2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdvcGVyYXRpb25zLmMgIHwgMTIgKysrKysrKysrLS0t
DQogZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2xhbl9pZi5oICAgICAgICB8ICAyICst
DQogNCBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmMgYi9k
cml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuYw0KaW5kZXggZWQxNWJkMWJj
ZDU2Li4xM2M5OTE1MzU4ZDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAv
aG9zdF9pbnRlcmZhY2UuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50
ZXJmYWNlLmMNCkBAIC02LDcgKzYsNyBAQA0KIA0KICNpbmNsdWRlICJ3aWxjX3dmaV9uZXRkZXZp
Y2UuaCINCiANCi0jZGVmaW5lIFdJTENfSElGX1NDQU5fVElNRU9VVF9NUyAgICAgICAgICAgICAg
ICA0MDAwDQorI2RlZmluZSBXSUxDX0hJRl9TQ0FOX1RJTUVPVVRfTVMgICAgICAgICAgICAgICAg
NTAwMA0KICNkZWZpbmUgV0lMQ19ISUZfQ09OTkVDVF9USU1FT1VUX01TICAgICAgICAgICAgIDk1
MDANCiANCiAjZGVmaW5lIFdJTENfRkFMU0VfRlJNV1JfQ0hBTk5FTAkJMTAwDQpAQCAtMjM3LDcg
KzIzNyw3IEBAIGludCB3aWxjX3NjYW4oc3RydWN0IHdpbGNfdmlmICp2aWYsIHU4IHNjYW5fc291
cmNlLCB1OCBzY2FuX3R5cGUsDQogCWludCByZXN1bHQgPSAwOw0KIAlzdHJ1Y3Qgd2lkIHdpZF9s
aXN0WzVdOw0KIAl1MzIgaW5kZXggPSAwOw0KLQl1MzIgaTsNCisJdTMyIGksIHNjYW5fdGltZW91
dDsNCiAJdTggKmJ1ZmZlcjsNCiAJdTggdmFsdWVzaXplID0gMDsNCiAJdTggKnNlYXJjaF9zc2lk
X3ZhbHMgPSBOVUxMOw0KQEAgLTI5Myw2ICsyOTMsMTggQEAgaW50IHdpbGNfc2NhbihzdHJ1Y3Qg
d2lsY192aWYgKnZpZiwgdTggc2Nhbl9zb3VyY2UsIHU4IHNjYW5fdHlwZSwNCiAJd2lkX2xpc3Rb
aW5kZXhdLnZhbCA9IChzOCAqKSZzY2FuX3R5cGU7DQogCWluZGV4Kys7DQogDQorCWlmIChzY2Fu
X3R5cGUgPT0gV0lMQ19GV19QQVNTSVZFX1NDQU4gJiYgcmVxdWVzdC0+ZHVyYXRpb24pIHsNCisJ
CXdpZF9saXN0W2luZGV4XS5pZCA9IFdJRF9QQVNTSVZFX1NDQU5fVElNRTsNCisJCXdpZF9saXN0
W2luZGV4XS50eXBlID0gV0lEX1NIT1JUOw0KKwkJd2lkX2xpc3RbaW5kZXhdLnNpemUgPSBzaXpl
b2YodTE2KTsNCisJCXdpZF9saXN0W2luZGV4XS52YWwgPSAoczggKikmcmVxdWVzdC0+ZHVyYXRp
b247DQorCQlpbmRleCsrOw0KKw0KKwkJc2Nhbl90aW1lb3V0ID0gKHJlcXVlc3QtPmR1cmF0aW9u
ICogY2hfbGlzdF9sZW4pICsgNTAwOw0KKwl9IGVsc2Ugew0KKwkJc2Nhbl90aW1lb3V0ID0gV0lM
Q19ISUZfU0NBTl9USU1FT1VUX01TOw0KKwl9DQorDQogCXdpZF9saXN0W2luZGV4XS5pZCA9IFdJ
RF9TQ0FOX0NIQU5ORUxfTElTVDsNCiAJd2lkX2xpc3RbaW5kZXhdLnR5cGUgPSBXSURfQklOX0RB
VEE7DQogDQpAQCAtMzI2LDcgKzMzOCw3IEBAIGludCB3aWxjX3NjYW4oc3RydWN0IHdpbGNfdmlm
ICp2aWYsIHU4IHNjYW5fc291cmNlLCB1OCBzY2FuX3R5cGUsDQogDQogCWhpZl9kcnYtPnNjYW5f
dGltZXJfdmlmID0gdmlmOw0KIAltb2RfdGltZXIoJmhpZl9kcnYtPnNjYW5fdGltZXIsDQotCQkg
IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKFdJTENfSElGX1NDQU5fVElNRU9VVF9NUykpOw0K
KwkJICBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcyhzY2FuX3RpbWVvdXQpKTsNCiANCiBlcnJv
cjoNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZh
Y2UuaCBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9ob3N0X2ludGVyZmFjZS5oDQppbmRleCBh
OTA3YzZkMzMwMTIuLjRmY2M3YTNjMTUxZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93
aWxjMTAwMC9ob3N0X2ludGVyZmFjZS5oDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAv
aG9zdF9pbnRlcmZhY2UuaA0KQEAgLTExNSw3ICsxMTUsNiBAQCBzdHJ1Y3Qgd2lsY19yY3ZkX25l
dF9pbmZvIHsNCiAJc3RydWN0IGllZWU4MDIxMV9tZ210ICptZ210Ow0KIH07DQogDQotDQogc3Ry
dWN0IHdpbGNfdXNlcl9zY2FuX3JlcSB7DQogCXZvaWQgKCpzY2FuX3Jlc3VsdCkoZW51bSBzY2Fu
X2V2ZW50IGV2dCwNCiAJCQkgICAgc3RydWN0IHdpbGNfcmN2ZF9uZXRfaW5mbyAqaW5mbywgdm9p
ZCAqcHJpdik7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2Zp
X2NmZ29wZXJhdGlvbnMuYyBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdv
cGVyYXRpb25zLmMNCmluZGV4IGY2ODI1NzI3YmY3Ny4uYjBkYWExMTM2NjYzIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYw0KKysr
IGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYw0KQEAg
LTIyMSw2ICsyMjEsNyBAQCBzdGF0aWMgaW50IHNjYW4oc3RydWN0IHdpcGh5ICp3aXBoeSwgc3Ry
dWN0IGNmZzgwMjExX3NjYW5fcmVxdWVzdCAqcmVxdWVzdCkNCiAJdTMyIGk7DQogCWludCByZXQg
PSAwOw0KIAl1OCBzY2FuX2NoX2xpc3RbV0lMQ19NQVhfTlVNX1NDQU5ORURfQ0hdOw0KKwl1OCBz
Y2FuX3R5cGU7DQogDQogCWlmIChyZXF1ZXN0LT5uX2NoYW5uZWxzID4gV0lMQ19NQVhfTlVNX1ND
QU5ORURfQ0gpIHsNCiAJCW5ldGRldl9lcnIocHJpdi0+ZGV2LCAiUmVxdWVzdGVkIHNjYW5uZWQg
Y2hhbm5lbHMgb3ZlclxuIik7DQpAQCAtMjM1LDkgKzIzNiwxNCBAQCBzdGF0aWMgaW50IHNjYW4o
c3RydWN0IHdpcGh5ICp3aXBoeSwgc3RydWN0IGNmZzgwMjExX3NjYW5fcmVxdWVzdCAqcmVxdWVz
dCkNCiAJCXNjYW5fY2hfbGlzdFtpXSA9IGllZWU4MDIxMV9mcmVxdWVuY3lfdG9fY2hhbm5lbChm
cmVxKTsNCiAJfQ0KIA0KLQlyZXQgPSB3aWxjX3NjYW4odmlmLCBXSUxDX0ZXX1VTRVJfU0NBTiwg
V0lMQ19GV19BQ1RJVkVfU0NBTiwNCi0JCQlzY2FuX2NoX2xpc3QsIHJlcXVlc3QtPm5fY2hhbm5l
bHMsIGNmZ19zY2FuX3Jlc3VsdCwNCi0JCQkodm9pZCAqKXByaXYsIHJlcXVlc3QpOw0KKwlpZiAo
cmVxdWVzdC0+bl9zc2lkcykNCisJCXNjYW5fdHlwZSA9IFdJTENfRldfQUNUSVZFX1NDQU47DQor
CWVsc2UNCisJCXNjYW5fdHlwZSA9IFdJTENfRldfUEFTU0lWRV9TQ0FOOw0KKw0KKwlyZXQgPSB3
aWxjX3NjYW4odmlmLCBXSUxDX0ZXX1VTRVJfU0NBTiwgc2Nhbl90eXBlLCBzY2FuX2NoX2xpc3Qs
DQorCQkJcmVxdWVzdC0+bl9jaGFubmVscywgY2ZnX3NjYW5fcmVzdWx0LCAodm9pZCAqKXByaXYs
DQorCQkJcmVxdWVzdCk7DQogDQogCWlmIChyZXQpIHsNCiAJCXByaXYtPnNjYW5fcmVxID0gTlVM
TDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193bGFuX2lmLmgg
Yi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193bGFuX2lmLmgNCmluZGV4IGIxNWRlMzZl
MzJlMC4uYjg5ZDBlMGYwNGNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAw
L3dpbGNfd2xhbl9pZi5oDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193bGFu
X2lmLmgNCkBAIC02ODQsNyArNjg0LDcgQEAgZW51bSB7DQogCVdJRF9MT05HX1JFVFJZX0xJTUlU
CQk9IDB4MTAwMywNCiAJV0lEX0JFQUNPTl9JTlRFUlZBTAkJPSAweDEwMDYsDQogCVdJRF9NRU1P
UllfQUNDRVNTXzE2QklUCQk9IDB4MTAwOCwNCi0NCisJV0lEX1BBU1NJVkVfU0NBTl9USU1FICAg
ICAgICAgICA9IDB4MTAwRCwNCiAJV0lEX0pPSU5fU1RBUlRfVElNRU9VVAkJPSAweDEwMEYsDQog
CVdJRF9BU09DX1RJTUVPVVQJCT0gMHgxMDExLA0KIAlXSURfMTFJX1BST1RPQ09MX1RJTUVPVVQJ
PSAweDEwMTIsDQotLSANCjIuMTcuMQ0KDQo=
