Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031515696C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfFZMlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 08:41:02 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:54780 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfFZMlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 08:41:02 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="40484320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:41:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:40:58 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 26 Jun 2019 05:40:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy33CSw+7u77x+NQDpbjg1syGyTJ17R6D5wqBo+efn8=;
 b=eZZAu7ENPhUy3wyfKTQYUAVcb1G5s0OVaIU1hk5I0sQWEqfuURnqGQE8TVQ/kfXKvXHSLTbIR0CLg8HuBjk020MAVEIfBbHRhOjEDsMW8nXylZ0/VCyn9iMObP8yu7Uq7seXZ3OLUcze2oXNK1AquT6lU+vK1jzVvewTzy9QHdw=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB3987.namprd11.prod.outlook.com (10.255.128.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:40:58 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:40:58 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 5/8] staging: wilc1000: remove unnecessary loop to traverse
 vif interfaces
Thread-Topic: [PATCH 5/8] staging: wilc1000: remove unnecessary loop to
 traverse vif interfaces
Thread-Index: AQHVLBxnrn5pJlgqbEqjXpIzd+Cikw==
Date:   Wed, 26 Jun 2019 12:40:58 +0000
Message-ID: <1561552810-8933-6-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 2a30a280-cfd6-459b-6e09-08d6fa3389b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3987;
x-ms-traffictypediagnostic: BN6PR11MB3987:
x-microsoft-antispam-prvs: <BN6PR11MB3987EA55E5A0A01CF5611D74E3E20@BN6PR11MB3987.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(3846002)(11346002)(305945005)(476003)(2616005)(5660300002)(99286004)(54906003)(25786009)(8676002)(486006)(81156014)(81166006)(8936002)(66066001)(7736002)(66476007)(66556008)(64756008)(66446008)(6116002)(66946007)(6486002)(50226002)(446003)(107886003)(68736007)(52116002)(73956011)(256004)(4326008)(6436002)(316002)(478600001)(386003)(72206003)(53936002)(2906002)(102836004)(6512007)(2501003)(6916009)(76176011)(86362001)(186003)(6506007)(36756003)(71190400001)(78486014)(14454004)(26005)(2351001)(71200400001)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3987;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9v+uceWvaTbKvrcp5//6/OGtGuFSh31+dY6hpLkmwdsMLXR4XwszIlwfBLIcVQqN9V0N2LxO4BWBMedq2iDa8cmAKDdSS8WV9mPrh7i4kwXM0yJf2FrLAIqA8uYIp4leMmh4+0u/98GeOb24/RvBmz82zszTpTBPokeBrWoudRvsq09ioRCzEK5aAD9IXqIRdDroYtmc5HDTAWp0Zf7PBF4W0fn4ee2iR6568KM11kFW8fhl6fI72LI382O+kGH4Ig45YdizuzmbBoHkj9/1BgY4YpUZCFMdk0aBkGyvXHlf4rfDS5CMimbN+rFDkNV4rZTyM3WMTpMWRTLaQ5AtS79OzoHfiQlvtonJXC0MLKHTIdyW4H6L9lAH0sU3zDizk16fbAt2BYl3oJGCnr5aS7r0ak1oVZhY5MP9K4GkSgo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a30a280-cfd6-459b-6e09-08d6fa3389b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:40:58.3260
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

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KQ2xlYW51cCBw
YXRjaCB0byBhdm9pZCBsb29wIHRvIHRyYXZlcnNlIHRoZSBpbnRlcmZhY2VzIGluc3RlYWQgbWFr
ZSB1c2UNCm9mIHZpZiByZWNlaXZlZCBmcm9tIG5ldF9kZXZpY2UgcHJpdiBkYXRhLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KLS0tDQog
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmMgfCAgNyArLS0tLS0tDQog
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfbmV0ZGV2LmMgICAgfCAxNiArKysrKy0tLS0t
LS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNl
LmMgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuYw0KaW5kZXggMzg5
ZjlmOGMuLjM2ODgwODggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9z
dF9pbnRlcmZhY2UuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJm
YWNlLmMNCkBAIC0xNjM0LDE5ICsxNjM0LDE0IEBAIGludCB3aWxjX2luaXQoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwgc3RydWN0IGhvc3RfaWZfZHJ2ICoqaGlmX2Rydl9oYW5kbGVyKQ0KIAlzdHJ1
Y3QgaG9zdF9pZl9kcnYgKmhpZl9kcnY7DQogCXN0cnVjdCB3aWxjX3ZpZiAqdmlmID0gbmV0ZGV2
X3ByaXYoZGV2KTsNCiAJc3RydWN0IHdpbGMgKndpbGMgPSB2aWYtPndpbGM7DQotCWludCBpOw0K
IA0KIAloaWZfZHJ2ICA9IGt6YWxsb2Moc2l6ZW9mKCpoaWZfZHJ2KSwgR0ZQX0tFUk5FTCk7DQog
CWlmICghaGlmX2RydikNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KIAkqaGlmX2Rydl9oYW5kbGVy
ID0gaGlmX2RydjsNCi0JZm9yIChpID0gMDsgaSA8IHdpbGMtPnZpZl9udW07IGkrKykNCi0JCWlm
IChkZXYgPT0gd2lsYy0+dmlmW2ldLT5uZGV2KSB7DQotCQkJd2lsYy0+dmlmW2ldLT5oaWZfZHJ2
ID0gaGlmX2RydjsNCi0JCQlicmVhazsNCi0JCX0NCiANCisJdmlmLT5oaWZfZHJ2ID0gaGlmX2Ry
djsNCiAJdmlmLT5vYnRhaW5pbmdfaXAgPSBmYWxzZTsNCiANCiAJaWYgKHdpbGMtPmNsaWVudHNf
Y291bnQgPT0gMCkNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY19u
ZXRkZXYuYyBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX25ldGRldi5jDQppbmRleCBh
ZDA0NzQ0Li4wYWY2MGIyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dp
bGNfbmV0ZGV2LmMNCisrKyBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX25ldGRldi5j
DQpAQCAtNjE0LDcgKzYxNCw2IEBAIHN0YXRpYyBpbnQgd2lsY19tYWNfb3BlbihzdHJ1Y3QgbmV0
X2RldmljZSAqbmRldikNCiAJc3RydWN0IHdpbGNfcHJpdiAqcHJpdiA9IHdkZXZfcHJpdih2aWYt
Pm5kZXYtPmllZWU4MDIxMV9wdHIpOw0KIAl1bnNpZ25lZCBjaGFyIG1hY19hZGRbRVRIX0FMRU5d
ID0gezB9Ow0KIAlpbnQgcmV0ID0gMDsNCi0JaW50IGkgPSAwOw0KIA0KIAlpZiAoIXdsIHx8ICF3
bC0+ZGV2KSB7DQogCQluZXRkZXZfZXJyKG5kZXYsICJkZXZpY2Ugbm90IHJlYWR5XG4iKTsNCkBA
IC02MzMsMTkgKzYzMiwxNCBAQCBzdGF0aWMgaW50IHdpbGNfbWFjX29wZW4oc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYpDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQotCWZvciAoaSA9IDA7IGkgPCB3
bC0+dmlmX251bTsgaSsrKSB7DQotCQlpZiAobmRldiA9PSB3bC0+dmlmW2ldLT5uZGV2KSB7DQot
CQkJd2lsY19zZXRfd2ZpX2Rydl9oYW5kbGVyKHZpZiwgd2lsY19nZXRfdmlmX2lkeCh2aWYpLA0K
LQkJCQkJCSB2aWYtPmlmdHlwZSwgdmlmLT5pZHgpOw0KLQkJCXdpbGNfc2V0X29wZXJhdGlvbl9t
b2RlKHZpZiwgdmlmLT5pZnR5cGUpOw0KLQkJCWJyZWFrOw0KLQkJfQ0KLQl9DQorCXdpbGNfc2V0
X3dmaV9kcnZfaGFuZGxlcih2aWYsIHdpbGNfZ2V0X3ZpZl9pZHgodmlmKSwgdmlmLT5pZnR5cGUs
DQorCQkJCSB2aWYtPmlkeCk7DQorCXdpbGNfc2V0X29wZXJhdGlvbl9tb2RlKHZpZiwgdmlmLT5p
ZnR5cGUpOw0KIA0KIAl3aWxjX2dldF9tYWNfYWRkcmVzcyh2aWYsIG1hY19hZGQpOw0KIAluZXRk
ZXZfZGJnKG5kZXYsICJNYWMgYWRkcmVzczogJXBNXG4iLCBtYWNfYWRkKTsNCi0JbWVtY3B5KHds
LT52aWZbaV0tPnNyY19hZGRyLCBtYWNfYWRkLCBFVEhfQUxFTik7DQotCW1lbWNweShuZGV2LT5k
ZXZfYWRkciwgd2wtPnZpZltpXS0+c3JjX2FkZHIsIEVUSF9BTEVOKTsNCisJbWVtY3B5KHZpZi0+
c3JjX2FkZHIsIG1hY19hZGQsIEVUSF9BTEVOKTsNCisJbWVtY3B5KG5kZXYtPmRldl9hZGRyLCB2
aWYtPnNyY19hZGRyLCBFVEhfQUxFTik7DQogDQogCWlmICghaXNfdmFsaWRfZXRoZXJfYWRkcihu
ZGV2LT5kZXZfYWRkcikpIHsNCiAJCW5ldGRldl9lcnIobmRldiwgIldyb25nIE1BQyBhZGRyZXNz
XG4iKTsNCi0tIA0KMi43LjQNCg0K
