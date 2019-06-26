Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075D956966
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFZMkt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 08:40:49 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3322 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZMkt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 08:40:49 -0400
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
   d="scan'208";a="37422369"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:40:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:41:58 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 05:41:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPQZ3ICmSUkvJ0fraY2jeUgwXtmfOjMYWzu3xWPfJjQ=;
 b=hXIZoRThNhuAIbLJFQsmTaqlh7PxhDG3/uPpGxAR2SpMt2BsUSyvfz3TN/Nhvfsm1mtH9WtgZmfUPpMVNp9gOchpaQJR2k/JduSlJh12Erk7CfXITJ9IRnRH5e7uflAePMtUE62WzF+akAxJ6Z2+fM3eoRX5MWsb4sG/+F3d8Qc=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB3987.namprd11.prod.outlook.com (10.255.128.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:40:45 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:40:45 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/8] staging: wilc1000: handle p2p operations in caller
 context
Thread-Topic: [PATCH 1/8] staging: wilc1000: handle p2p operations in caller
 context
Thread-Index: AQHVLBxfUqbQa+WO8EegtAG6KsyhlA==
Date:   Wed, 26 Jun 2019 12:40:45 +0000
Message-ID: <1561552810-8933-2-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 7abee900-4a5e-47fe-fb53-08d6fa33821a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3987;
x-ms-traffictypediagnostic: BN6PR11MB3987:
x-microsoft-antispam-prvs: <BN6PR11MB3987E333F0AFC3626E9C98C7E3E20@BN6PR11MB3987.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(3846002)(11346002)(305945005)(476003)(2616005)(5660300002)(99286004)(54906003)(25786009)(8676002)(486006)(81156014)(81166006)(8936002)(66066001)(7736002)(66476007)(66556008)(64756008)(66446008)(6116002)(66946007)(6486002)(50226002)(446003)(107886003)(68736007)(52116002)(73956011)(14444005)(256004)(4326008)(6436002)(316002)(478600001)(386003)(72206003)(53936002)(2906002)(102836004)(6512007)(2501003)(6916009)(76176011)(86362001)(186003)(6506007)(36756003)(71190400001)(78486014)(14454004)(26005)(2351001)(71200400001)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3987;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1f+mo6ICKu/6/p8YqRS7ojp4IUqdWmQEKRjnHgaR1RxBrwjH/p5sEOqWYehfwVOi2O9R3wiL87JKrX6/LUDIcbwnPGvh4PlPJwWkAfSOL4HrDZiJ/4Qm02+Rij/ly1F3BX5kCdD9vprj9J0fUp46CqiaxTaG4HSoC16I2vAohOkFN9L9NMzNi8dwY4dneyOG+77bNn/oDLPIfWic6BE3pWkvBerdeEDaM+kqWKfYEmKFnPJkrpoEFqEWbOQqnqiE9fTNMIrWiVxluA/K3OiJHwDS6v8d6DWH1yKMY3d+TU+LGTPm5Nv/SN8e+iWgbsNJVxnKdSL6Wrm0AZVlRkHBbgCqKtmb58peHA70CMFWHueIm1iNeL70MoV1ApgXKm8ImVBAJyFGvMxJaUzaINdK4DZdfjhNXaxWtaJEjPseJd0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abee900-4a5e-47fe-fb53-08d6fa33821a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:40:45.6534
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

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KTW92ZWQgdGhl
IGhhbmRsaW5nIG9mIHAycCByZWxhdGVkIG9wZXJhdGlvbiBpbiB0aGUgY2FsbGVyIGNvbnRleHQg
aW5zdGVhZA0Kb2YgdXNpbmcgd29ya3F1ZXVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBBamF5IFNpbmdo
IDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVycy9zdGFnaW5nL3dpbGMx
MDAwL2hvc3RfaW50ZXJmYWNlLmMgfCA0NiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmMgYi9k
cml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuYw0KaW5kZXggMTNjOTkxNTM1
Li5iNTA1OTkwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50
ZXJmYWNlLmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9ob3N0X2ludGVyZmFjZS5j
DQpAQCAtOTY1LDExICs5NjUsOCBAQCBzdGF0aWMgaW50IGhhbmRsZV9yZW1haW5fb25fY2hhbihz
dHJ1Y3Qgd2lsY192aWYgKnZpZiwNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIGhh
bmRsZV9saXN0ZW5fc3RhdGVfZXhwaXJlZChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQorc3Rh
dGljIGludCB3aWxjX2hhbmRsZV9yb2NfZXhwaXJlZChzdHJ1Y3Qgd2lsY192aWYgKnZpZiwgdTY0
IGNvb2tpZSkNCiB7DQotCXN0cnVjdCBob3N0X2lmX21zZyAqbXNnID0gY29udGFpbmVyX29mKHdv
cmssIHN0cnVjdCBob3N0X2lmX21zZywgd29yayk7DQotCXN0cnVjdCB3aWxjX3ZpZiAqdmlmID0g
bXNnLT52aWY7DQotCXN0cnVjdCB3aWxjX3JlbWFpbl9jaCAqaGlmX3JlbWFpbl9jaCA9ICZtc2ct
PmJvZHkucmVtYWluX29uX2NoOw0KIAl1OCByZW1haW5fb25fY2hhbl9mbGFnOw0KIAlzdHJ1Y3Qg
d2lkIHdpZDsNCiAJaW50IHJlc3VsdDsNCkBAIC05ODEsMTAgKzk3OCwxMCBAQCBzdGF0aWMgdm9p
ZCBoYW5kbGVfbGlzdGVuX3N0YXRlX2V4cGlyZWQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
IAkJd2lkLmlkID0gV0lEX1JFTUFJTl9PTl9DSEFOOw0KIAkJd2lkLnR5cGUgPSBXSURfU1RSOw0K
IAkJd2lkLnNpemUgPSAyOw0KLQkJd2lkLnZhbCA9IGttYWxsb2Mod2lkLnNpemUsIEdGUF9LRVJO
RUwpOw0KIA0KKwkJd2lkLnZhbCA9IGttYWxsb2Mod2lkLnNpemUsIEdGUF9LRVJORUwpOw0KIAkJ
aWYgKCF3aWQudmFsKQ0KLQkJCWdvdG8gZnJlZV9tc2c7DQorCQkJcmV0dXJuIC1FTk9NRU07DQog
DQogCQl3aWQudmFsWzBdID0gcmVtYWluX29uX2NoYW5fZmxhZzsNCiAJCXdpZC52YWxbMV0gPSBX
SUxDX0ZBTFNFX0ZSTVdSX0NIQU5ORUw7DQpAQCAtOTk0LDE4ICs5OTEsMjUgQEAgc3RhdGljIHZv
aWQgaGFuZGxlX2xpc3Rlbl9zdGF0ZV9leHBpcmVkKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykN
CiAJCWtmcmVlKHdpZC52YWwpOw0KIAkJaWYgKHJlc3VsdCAhPSAwKSB7DQogCQkJbmV0ZGV2X2Vy
cih2aWYtPm5kZXYsICJGYWlsZWQgdG8gc2V0IHJlbWFpbiBjaGFubmVsXG4iKTsNCi0JCQlnb3Rv
IGZyZWVfbXNnOw0KKwkJCXJldHVybiAtRUlOVkFMOw0KIAkJfQ0KIA0KIAkJaWYgKGhpZl9kcnYt
PnJlbWFpbl9vbl9jaC5leHBpcmVkKSB7DQogCQkJaGlmX2Rydi0+cmVtYWluX29uX2NoLmV4cGly
ZWQoaGlmX2Rydi0+cmVtYWluX29uX2NoLmFyZywNCi0JCQkJCQkgICAgICBoaWZfcmVtYWluX2No
LT5jb29raWUpOw0KKwkJCQkJCSAgICAgIGNvb2tpZSk7DQogCQl9DQogCX0gZWxzZSB7DQogCQlu
ZXRkZXZfZGJnKHZpZi0+bmRldiwgIk5vdCBpbiBsaXN0ZW4gc3RhdGVcbiIpOw0KIAl9DQogDQot
ZnJlZV9tc2c6DQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCB3aWxjX2hhbmRsZV9s
aXN0ZW5fc3RhdGVfZXhwaXJlZChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQorew0KKwlzdHJ1
Y3QgaG9zdF9pZl9tc2cgKm1zZyA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgaG9zdF9pZl9t
c2csIHdvcmspOw0KKw0KKwl3aWxjX2hhbmRsZV9yb2NfZXhwaXJlZChtc2ctPnZpZiwgbXNnLT5i
b2R5LnJlbWFpbl9vbl9jaC5jb29raWUpOw0KIAlrZnJlZShtc2cpOw0KIH0NCiANCkBAIC0xMDE5
LDcgKzEwMjMsNyBAQCBzdGF0aWMgdm9pZCBsaXN0ZW5fdGltZXJfY2Ioc3RydWN0IHRpbWVyX2xp
c3QgKnQpDQogDQogCWRlbF90aW1lcigmdmlmLT5oaWZfZHJ2LT5yZW1haW5fb25fY2hfdGltZXIp
Ow0KIA0KLQltc2cgPSB3aWxjX2FsbG9jX3dvcmsodmlmLCBoYW5kbGVfbGlzdGVuX3N0YXRlX2V4
cGlyZWQsIGZhbHNlKTsNCisJbXNnID0gd2lsY19hbGxvY193b3JrKHZpZiwgd2lsY19oYW5kbGVf
bGlzdGVuX3N0YXRlX2V4cGlyZWQsIGZhbHNlKTsNCiAJaWYgKElTX0VSUihtc2cpKQ0KIAkJcmV0
dXJuOw0KIA0KQEAgLTE4NDEsMzAgKzE4NDUsMTQgQEAgaW50IHdpbGNfcmVtYWluX29uX2NoYW5u
ZWwoc3RydWN0IHdpbGNfdmlmICp2aWYsIHU2NCBjb29raWUsDQogDQogaW50IHdpbGNfbGlzdGVu
X3N0YXRlX2V4cGlyZWQoc3RydWN0IHdpbGNfdmlmICp2aWYsIHU2NCBjb29raWUpDQogew0KLQlp
bnQgcmVzdWx0Ow0KLQlzdHJ1Y3QgaG9zdF9pZl9tc2cgKm1zZzsNCi0Jc3RydWN0IGhvc3RfaWZf
ZHJ2ICpoaWZfZHJ2ID0gdmlmLT5oaWZfZHJ2Ow0KLQ0KLQlpZiAoIWhpZl9kcnYpIHsNCisJaWYg
KCF2aWYtPmhpZl9kcnYpIHsNCiAJCW5ldGRldl9lcnIodmlmLT5uZGV2LCAiJXM6IGhpZiBkcml2
ZXIgaXMgTlVMTCIsIF9fZnVuY19fKTsNCiAJCXJldHVybiAtRUZBVUxUOw0KIAl9DQogDQotCWRl
bF90aW1lcigmaGlmX2Rydi0+cmVtYWluX29uX2NoX3RpbWVyKTsNCi0NCi0JbXNnID0gd2lsY19h
bGxvY193b3JrKHZpZiwgaGFuZGxlX2xpc3Rlbl9zdGF0ZV9leHBpcmVkLCBmYWxzZSk7DQotCWlm
IChJU19FUlIobXNnKSkNCi0JCXJldHVybiBQVFJfRVJSKG1zZyk7DQotDQotCW1zZy0+Ym9keS5y
ZW1haW5fb25fY2guY29va2llID0gY29va2llOw0KLQ0KLQlyZXN1bHQgPSB3aWxjX2VucXVldWVf
d29yayhtc2cpOw0KLQlpZiAocmVzdWx0KSB7DQotCQluZXRkZXZfZXJyKHZpZi0+bmRldiwgIiVz
OiBlbnF1ZXVlIHdvcmsgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQotCQlrZnJlZShtc2cpOw0KLQl9
DQorCWRlbF90aW1lcigmdmlmLT5oaWZfZHJ2LT5yZW1haW5fb25fY2hfdGltZXIpOw0KIA0KLQly
ZXR1cm4gcmVzdWx0Ow0KKwlyZXR1cm4gd2lsY19oYW5kbGVfcm9jX2V4cGlyZWQodmlmLCBjb29r
aWUpOw0KIH0NCiANCiB2b2lkIHdpbGNfZnJhbWVfcmVnaXN0ZXIoc3RydWN0IHdpbGNfdmlmICp2
aWYsIHUxNiBmcmFtZV90eXBlLCBib29sIHJlZykNCi0tIA0KMi43LjQNCg0K
