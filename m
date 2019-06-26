Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA256974
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfFZMlP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 08:41:15 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3372 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfFZMlO (ORCPT
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
   d="scan'208";a="37422550"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:41:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:41:02 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 26 Jun 2019 05:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuXSpzFFEK7FE9a63lak2HOt+3mC9TVEOLZpbKUSljo=;
 b=RlharDH2yGBK3Jvipp7eKxmBcYOdeEff1P7rLNCJgbHCj9mvt2GO8KKb+rx16rx/BAbg3O68QenQ/YxNXJ2NCXIiJdziId6Ej2WIClsU49VW7Bv6o4AsG/kEFTSddb2NO9mbJXOFWSl4f4I0Xk6PyXTtt5bL+4Q+UNJh3Wadr2k=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB3907.namprd11.prod.outlook.com (10.255.131.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:41:01 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:41:01 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 6/8] staging: wilc1000: remove use of 'src_addr' element in
 'wilc_vif' struct
Thread-Topic: [PATCH 6/8] staging: wilc1000: remove use of 'src_addr' element
 in 'wilc_vif' struct
Thread-Index: AQHVLBxpYcTsK5l4nUGdYRa+dEU9BA==
Date:   Wed, 26 Jun 2019 12:41:01 +0000
Message-ID: <1561552810-8933-7-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8876f0ab-30ed-4c9d-a838-08d6fa338b77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3907;
x-ms-traffictypediagnostic: BN6PR11MB3907:
x-microsoft-antispam-prvs: <BN6PR11MB3907EA4A51A90281811FEF7CE3E20@BN6PR11MB3907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(476003)(14454004)(54906003)(81166006)(8936002)(2616005)(446003)(486006)(81156014)(6506007)(6436002)(6512007)(386003)(186003)(11346002)(5640700003)(102836004)(36756003)(316002)(6116002)(3846002)(26005)(2906002)(72206003)(478600001)(66066001)(50226002)(66446008)(2501003)(5660300002)(6486002)(107886003)(66556008)(64756008)(2351001)(86362001)(25786009)(6916009)(4326008)(8676002)(71190400001)(71200400001)(7736002)(76176011)(256004)(99286004)(68736007)(305945005)(52116002)(78486014)(53936002)(66476007)(73956011)(66946007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3907;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +uwoNsY5SKKEBj5l3S8upq9aHh26D9a755vJxdghaKYINGwdHN9K3cWhqTq84hICF72YcvsugJBGlxYZs8nSUPxFTz81utzwJ5cXYwzT0ZVZGKVEnwx+cCGU+ROtypJwnHKcvTeCSVgdOIMbxxdHJSQ3UR9j8ULadVxbzX6r9uz7qu8FEFGXWASx8zyv0Yld8AkEHG/x1ra3JIB9uOmjX6e3xq7t1jrOUbthqUpUZ8sw4x4Xnyx0+3dGGQIg4OtPQIFiyK7Zen+kvlupknH3j16yzlUJQVTlkUQd8uKyXYtOmRY0T+jawlCAgLs4bw0bZjWOqrcumK+IywI5+amUaUU1gHxSpvkILtPzS/ZUDN1YCZFdb5CSThmHZ/lJ9zOL09MnhXl/2ikhRr8gBfjPSPsDrsnNZVY0Rv/DRGOQ+U4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8876f0ab-30ed-4c9d-a838-08d6fa338b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:41:01.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3907
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KUmVtb3ZlIHVz
ZSBvZiAnc3JjX2FkZHInIGVsZW1lbnQgaW4gd2lsY192aWYsIGFzIHRoZSBzYW1lIGluZm9ybWF0
aW9uDQphbHJlYWR5IGNvcGllZCB0byBuZXRfZGV2aWNlLT5kZXZfYWRkci4NCg0KU2lnbmVkLW9m
Zi1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX25ldGRldi5jICAgICAgICAgICAgfCAzICstLQ0KIGRy
aXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdvcGVyYXRpb25zLmMgfCAyICstDQog
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oICAgICB8IDEgLQ0K
IDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfbmV0ZGV2LmMgYi9kcml2ZXJz
L3N0YWdpbmcvd2lsYzEwMDAvd2lsY19uZXRkZXYuYw0KaW5kZXggMGFmNjBiMi4uNTY1ZTJiNSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX25ldGRldi5jDQorKysg
Yi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY19uZXRkZXYuYw0KQEAgLTYzOCw4ICs2Mzgs
NyBAQCBzdGF0aWMgaW50IHdpbGNfbWFjX29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQog
DQogCXdpbGNfZ2V0X21hY19hZGRyZXNzKHZpZiwgbWFjX2FkZCk7DQogCW5ldGRldl9kYmcobmRl
diwgIk1hYyBhZGRyZXNzOiAlcE1cbiIsIG1hY19hZGQpOw0KLQltZW1jcHkodmlmLT5zcmNfYWRk
ciwgbWFjX2FkZCwgRVRIX0FMRU4pOw0KLQltZW1jcHkobmRldi0+ZGV2X2FkZHIsIHZpZi0+c3Jj
X2FkZHIsIEVUSF9BTEVOKTsNCisJZXRoZXJfYWRkcl9jb3B5KG5kZXYtPmRldl9hZGRyLCBtYWNf
YWRkKTsNCiANCiAJaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKG5kZXYtPmRldl9hZGRyKSkgew0K
IAkJbmV0ZGV2X2VycihuZGV2LCAiV3JvbmcgTUFDIGFkZHJlc3NcbiIpOw0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdvcGVyYXRpb25zLmMgYi9kcml2
ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfY2Znb3BlcmF0aW9ucy5jDQppbmRleCAxNTgw
OTA5Li5kNzJmZGQzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNf
d2ZpX2NmZ29wZXJhdGlvbnMuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNf
d2ZpX2NmZ29wZXJhdGlvbnMuYw0KQEAgLTE0OTksNyArMTQ5OSw3IEBAIHN0YXRpYyBpbnQgc3Rh
cnRfYXAoc3RydWN0IHdpcGh5ICp3aXBoeSwgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCiAJaWYg
KHJldCAhPSAwKQ0KIAkJbmV0ZGV2X2VycihkZXYsICJFcnJvciBpbiBzZXR0aW5nIGNoYW5uZWxc
biIpOw0KIA0KLQl3aWxjX3dsYW5fc2V0X2Jzc2lkKGRldiwgdmlmLT5zcmNfYWRkciwgV0lMQ19B
UF9NT0RFKTsNCisJd2lsY193bGFuX3NldF9ic3NpZChkZXYsIGRldi0+ZGV2X2FkZHIsIFdJTENf
QVBfTU9ERSk7DQogCXdpbGNfc2V0X3Bvd2VyX21nbXQodmlmLCAwLCAwKTsNCiANCiAJcmV0dXJu
IHdpbGNfYWRkX2JlYWNvbih2aWYsIHNldHRpbmdzLT5iZWFjb25faW50ZXJ2YWwsDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oIGIvZHJp
dmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oDQppbmRleCBkNWQ4MzBk
Li5lMjhjOGRlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2Zp
X25ldGRldmljZS5oDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfbmV0
ZGV2aWNlLmgNCkBAIC0xOTgsNyArMTk4LDYgQEAgc3RydWN0IHdpbGNfdmlmIHsNCiAJc3RydWN0
IGZyYW1lX3JlZyBmcmFtZV9yZWdbTlVNX1JFR19GUkFNRV07DQogCXN0cnVjdCBuZXRfZGV2aWNl
X3N0YXRzIG5ldHN0YXRzOw0KIAlzdHJ1Y3Qgd2lsYyAqd2lsYzsNCi0JdTggc3JjX2FkZHJbRVRI
X0FMRU5dOw0KIAl1OCBic3NpZFtFVEhfQUxFTl07DQogCXN0cnVjdCBob3N0X2lmX2RydiAqaGlm
X2RydjsNCiAJc3RydWN0IG5ldF9kZXZpY2UgKm5kZXY7DQotLSANCjIuNy40DQoNCg==
