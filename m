Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE5956973
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfFZMlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 08:41:14 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3372 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfFZMlO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 08:41:14 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="37422547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:41:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:40:58 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 26 Jun 2019 05:40:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nCJI/rgtVq/KqGaD5Y+kR2337kzNuJJz/c1iWiab1M=;
 b=vrokxWGasDHxL9j1YVnxPPLMdzLYqea3mEQQrglp5Uci/PeRdwuFxcyUIGaXUY+UGBvyfGSIdNF8pVT/vMqEPhAQaPFMyO8AdPV0H79FAt67t7UN/PbPJx4oXHzkrqY6YzjURHNsYRoYtABf1ZlimHCvTlVGMW5jfl7K7wkKSjE=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB3987.namprd11.prod.outlook.com (10.255.128.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:40:55 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:40:55 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/8] staging: wilc1000: remove use of driver_handler_id &
 ifc_id
Thread-Topic: [PATCH 4/8] staging: wilc1000: remove use of driver_handler_id &
 ifc_id
Thread-Index: AQHVLBxlHlm9afpX8UOh8ujpJQZS5Q==
Date:   Wed, 26 Jun 2019 12:40:55 +0000
Message-ID: <1561552810-8933-5-git-send-email-ajay.kathat@microchip.com>
References: <1561552810-8933-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1561552810-8933-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::28) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.16.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f72d73e-a6bd-46ab-b0bc-08d6fa3387be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3987;
x-ms-traffictypediagnostic: BN6PR11MB3987:
x-microsoft-antispam-prvs: <BN6PR11MB3987830DC132811F2EB78E7FE3E20@BN6PR11MB3987.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(3846002)(11346002)(305945005)(476003)(2616005)(5660300002)(99286004)(54906003)(25786009)(8676002)(486006)(81156014)(81166006)(8936002)(66066001)(7736002)(66476007)(66556008)(64756008)(66446008)(6116002)(66946007)(6486002)(50226002)(446003)(107886003)(68736007)(52116002)(73956011)(256004)(4326008)(6436002)(316002)(478600001)(386003)(72206003)(53936002)(2906002)(102836004)(6512007)(2501003)(6916009)(76176011)(86362001)(186003)(6506007)(36756003)(71190400001)(78486014)(14454004)(26005)(2351001)(71200400001)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3987;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hOiw4OcAmT/jRTeP0u0mk5//oZ1QeCZRY39YDh+Ago37Le8JO+bwz0R3rl32kmqUv7OJeIjwHSvEUvNJT9ut4odqjNzJW0v1HXaBTNLGICU70fHT/aB5ahUmPFtVsHMzFlgAOB/I2ZD6CsVfGP07kY74kj6DHsR+9PU/cB7l1efRidzdAfGFLxzRHlQxKiQHH9/PMoOffvBIsw1yw1ATOolizJTKW4PhqKb2PrZ/i6lEDL6QZ4bNFCoFm1WZr/Txolb/t8LJ6gn4oHFW3RDaSiuVp1Gl7ouXfyL2UZ2dvecMJ4toRtuMLJvrncesr+eCoP1k2JfsnqUwCnOZytrSxbXGzhO+vOVrzYnr2TuIKmdlT/T09uuIW1Nle7NXTou8/EW/gRYen4ugEtwnda/so38P2UmuaG1Fy6ZcG3+wNKg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f72d73e-a6bd-46ab-b0bc-08d6fa3387be
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:40:55.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3987
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KUmVtb3ZlZCB0
aGUgJ2RyaXZlcl9oYW5kbGVyX2lkJyAmICdpZmNfaWQnIGVsZW1lbnRzIGFuZCB1c2VkICdpZHgn
IHRvDQppZGVudGlmeSB0aGUgaGFuZGxlci4NCg0KU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8
YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAw
MC9ob3N0X2ludGVyZmFjZS5jICAgICAgICAgfCAzICstLQ0KIGRyaXZlcnMvc3RhZ2luZy93aWxj
MTAwMC9ob3N0X2ludGVyZmFjZS5oICAgICAgICAgfCAxIC0NCiBkcml2ZXJzL3N0YWdpbmcvd2ls
YzEwMDAvd2lsY19uZXRkZXYuYyAgICAgICAgICAgIHwgMyArLS0NCiBkcml2ZXJzL3N0YWdpbmcv
d2lsYzEwMDAvd2lsY193ZmlfY2Znb3BlcmF0aW9ucy5jIHwgNSArKy0tLQ0KIGRyaXZlcnMvc3Rh
Z2luZy93aWxjMTAwMC93aWxjX3dmaV9uZXRkZXZpY2UuaCAgICAgfCAxIC0NCiA1IGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3RhZ2luZy93aWxjMTAwMC9ob3N0X2ludGVyZmFjZS5jIGIvZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmMNCmluZGV4IGI1MDU5OTAuLjM4OWY5ZjhjIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmMNCisrKyBi
L2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9ob3N0X2ludGVyZmFjZS5jDQpAQCAtMTQ3Miw3ICsx
NDcyLDcgQEAgaW50IHdpbGNfc2V0X3dmaV9kcnZfaGFuZGxlcihzdHJ1Y3Qgd2lsY192aWYgKnZp
ZiwgaW50IGluZGV4LCB1OCBtb2RlLA0KIAlkcnYubW9kZSA9IChpZmNfaWQgfCAobW9kZSA8PCAx
KSk7DQogDQogCXJlc3VsdCA9IHdpbGNfc2VuZF9jb25maWdfcGt0KHZpZiwgV0lMQ19TRVRfQ0ZH
LCAmd2lkLCAxLA0KLQkJCQkgICAgICBoaWZfZHJ2LT5kcml2ZXJfaGFuZGxlcl9pZCk7DQorCQkJ
CSAgICAgIHdpbGNfZ2V0X3ZpZl9pZHgodmlmKSk7DQogCWlmIChyZXN1bHQpDQogCQluZXRkZXZf
ZXJyKHZpZi0+bmRldiwgIkZhaWxlZCB0byBzZXQgZHJpdmVyIGhhbmRsZXJcbiIpOw0KIA0KQEAg
LTE2NDQsNyArMTY0NCw2IEBAIGludCB3aWxjX2luaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwg
c3RydWN0IGhvc3RfaWZfZHJ2ICoqaGlmX2Rydl9oYW5kbGVyKQ0KIAlmb3IgKGkgPSAwOyBpIDwg
d2lsYy0+dmlmX251bTsgaSsrKQ0KIAkJaWYgKGRldiA9PSB3aWxjLT52aWZbaV0tPm5kZXYpIHsN
CiAJCQl3aWxjLT52aWZbaV0tPmhpZl9kcnYgPSBoaWZfZHJ2Ow0KLQkJCWhpZl9kcnYtPmRyaXZl
cl9oYW5kbGVyX2lkID0gaSArIDE7DQogCQkJYnJlYWs7DQogCQl9DQogDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmggYi9kcml2ZXJzL3N0YWdp
bmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuaA0KaW5kZXggNGZjYzdhMy4uYmUxZDI0OSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9ob3N0X2ludGVyZmFjZS5oDQorKysg
Yi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuaA0KQEAgLTE2Niw3ICsx
NjYsNiBAQCBzdHJ1Y3QgaG9zdF9pZl9kcnYgew0KIAlzdHJ1Y3Qgd2lsY192aWYgKnJlbWFpbl9v
bl9jaF90aW1lcl92aWY7DQogDQogCWJvb2wgaWZjX3VwOw0KLQlpbnQgZHJpdmVyX2hhbmRsZXJf
aWQ7DQogCXU4IGFzc29jX3Jlc3BbV0lMQ19NQVhfQVNTT0NfUkVTUF9GUkFNRV9TSVpFXTsNCiB9
Ow0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX25ldGRldi5j
IGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfbmV0ZGV2LmMNCmluZGV4IDkwMDYxMTEu
LmFkMDQ3NDQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY19uZXRk
ZXYuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfbmV0ZGV2LmMNCkBAIC02
MzYsNyArNjM2LDcgQEAgc3RhdGljIGludCB3aWxjX21hY19vcGVuKHN0cnVjdCBuZXRfZGV2aWNl
ICpuZGV2KQ0KIAlmb3IgKGkgPSAwOyBpIDwgd2wtPnZpZl9udW07IGkrKykgew0KIAkJaWYgKG5k
ZXYgPT0gd2wtPnZpZltpXS0+bmRldikgew0KIAkJCXdpbGNfc2V0X3dmaV9kcnZfaGFuZGxlcih2
aWYsIHdpbGNfZ2V0X3ZpZl9pZHgodmlmKSwNCi0JCQkJCQkgdmlmLT5pZnR5cGUsIHZpZi0+aWZj
X2lkKTsNCisJCQkJCQkgdmlmLT5pZnR5cGUsIHZpZi0+aWR4KTsNCiAJCQl3aWxjX3NldF9vcGVy
YXRpb25fbW9kZSh2aWYsIHZpZi0+aWZ0eXBlKTsNCiAJCQlicmVhazsNCiAJCX0NCkBAIC05OTUs
NyArOTk1LDYgQEAgc3RydWN0IHdpbGNfdmlmICp3aWxjX25ldGRldl9pZmNfaW5pdChzdHJ1Y3Qg
d2lsYyAqd2wsIGNvbnN0IGNoYXIgKm5hbWUsDQogCW5kZXYtPm5lZWRzX2ZyZWVfbmV0ZGV2ID0g
dHJ1ZTsNCiAJdmlmLT5pZnR5cGUgPSB2aWZfdHlwZTsNCiAJdmlmLT53aWxjLT52aWZbd2wtPnZp
Zl9udW1dID0gdmlmOw0KLQl2aWYtPmlmY19pZCA9IHdsLT52aWZfbnVtOw0KIAl2aWYtPmlkeCA9
IHdsLT52aWZfbnVtOw0KIAl3bC0+dmlmX251bSArPSAxOw0KIAl2aWYtPm1hY19vcGVuZWQgPSAw
Ow0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdvcGVy
YXRpb25zLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfY2Znb3BlcmF0aW9u
cy5jDQppbmRleCAwMTJlMzI1Li4xNTgwOTA5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYw0KQEAgLTE0NjIsNyArMTQ2Miw3IEBA
IHN0YXRpYyBpbnQgY2hhbmdlX3ZpcnR1YWxfaW50ZihzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LA0KIA0KIAkJaWYgKHdsLT5pbml0aWFsaXplZCkgew0KIAkJCXdp
bGNfc2V0X3dmaV9kcnZfaGFuZGxlcih2aWYsIHdpbGNfZ2V0X3ZpZl9pZHgodmlmKSwNCi0JCQkJ
CQkgMCwgdmlmLT5pZmNfaWQpOw0KKwkJCQkJCSAwLCB2aWYtPmlkeCk7DQogCQkJd2lsY19zZXRf
b3BlcmF0aW9uX21vZGUodmlmLCBXSUxDX0FQX01PREUpOw0KIAkJCXdpbGNfc2V0X3Bvd2VyX21n
bXQodmlmLCAwLCAwKTsNCiAJCX0NCkBAIC0xNjkzLDExICsxNjkzLDEwIEBAIHN0YXRpYyBpbnQg
ZGVsX3ZpcnR1YWxfaW50ZihzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1Y3Qgd2lyZWxlc3NfZGV2
ICp3ZGV2KQ0KIAkJCXdsLT52aWZbaV0gPSBOVUxMOw0KIAkJfSBlbHNlIHsNCiAJCQl2aWYgPSB3
bC0+dmlmW2kgKyAxXTsNCi0JCQl2aWYtPmlmY19pZCA9IGk7DQogCQkJdmlmLT5pZHggPSBpOw0K
IAkJCXdsLT52aWZbaV0gPSB2aWY7DQogCQkJd2lsY19zZXRfd2ZpX2Rydl9oYW5kbGVyKHZpZiwg
d2lsY19nZXRfdmlmX2lkeCh2aWYpLA0KLQkJCQkJCSB2aWYtPmlmdHlwZSwgdmlmLT5pZmNfaWQp
Ow0KKwkJCQkJCSB2aWYtPmlmdHlwZSwgdmlmLT5pZHgpOw0KIAkJfQ0KIAl9DQogCXdsLT52aWZf
bnVtLS07DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25l
dGRldmljZS5oIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5o
DQppbmRleCBmY2EzMzgwLi5kNWQ4MzBkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dp
bGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEw
MDAvd2lsY193ZmlfbmV0ZGV2aWNlLmgNCkBAIC0yMDMsNyArMjAzLDYgQEAgc3RydWN0IHdpbGNf
dmlmIHsNCiAJc3RydWN0IGhvc3RfaWZfZHJ2ICpoaWZfZHJ2Ow0KIAlzdHJ1Y3QgbmV0X2Rldmlj
ZSAqbmRldjsNCiAJdTggbW9kZTsNCi0JdTggaWZjX2lkOw0KIAlzdHJ1Y3QgdGltZXJfbGlzdCBk
dXJpbmdfaXBfdGltZXI7DQogCWJvb2wgb2J0YWluaW5nX2lwOw0KIAlzdHJ1Y3QgdGltZXJfbGlz
dCBwZXJpb2RpY19yc3NpOw0KLS0gDQoyLjcuNA0KDQo=
