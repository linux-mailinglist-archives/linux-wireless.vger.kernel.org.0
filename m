Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828B156965
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfFZMke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 08:40:34 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:3639 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfFZMke (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 08:40:34 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="39093108"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:40:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:40:31 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 26 Jun 2019 05:40:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6TEyjXAe11M6QTznQZcw9zAHOP5ycGBCD+4DtzCpkw=;
 b=R4slYfyY88FABGzG1x5qDn0PSeuWu179LJXGF7aBp+pQOM88zbNYzc91VBCjsS5j+U4IlGmC6KO/GL8092Mw7rwCLXAEGPASVz2XKjXjHsePiob7WLSac9La7lutremardbwJxiqaS/4vLtAcgSuRPOsvMkiA8j4C7q22fnwdnM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB3987.namprd11.prod.outlook.com (10.255.128.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:40:31 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:40:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 0/8] staging: wilc1000: dynamically add/delete interfaces &
 cleanup fixes
Thread-Topic: [PATCH 0/8] staging: wilc1000: dynamically add/delete interfaces
 & cleanup fixes
Thread-Index: AQHVLBxXkxhpZkFBX0af1rGv2CzVXg==
Date:   Wed, 26 Jun 2019 12:40:31 +0000
Message-ID: <1561552810-8933-1-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3f0113a8-ed83-4f01-69d1-08d6fa337960
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3987;
x-ms-traffictypediagnostic: BN6PR11MB3987:
x-microsoft-antispam-prvs: <BN6PR11MB3987F280A9CABB89949A6815E3E20@BN6PR11MB3987.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(3846002)(305945005)(476003)(2616005)(5660300002)(99286004)(54906003)(25786009)(8676002)(486006)(81156014)(81166006)(8936002)(66066001)(7736002)(66476007)(66556008)(64756008)(66446008)(6116002)(66946007)(6486002)(50226002)(107886003)(68736007)(52116002)(73956011)(14444005)(256004)(4326008)(6436002)(316002)(478600001)(386003)(72206003)(53936002)(2906002)(102836004)(6512007)(2501003)(6916009)(86362001)(186003)(6506007)(36756003)(71190400001)(78486014)(14454004)(26005)(2351001)(71200400001)(5640700003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3987;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +34mowvPaiZUdIzOTM4sIIfL1TGeTEbaAs9TRSJHCvPBTrLvmGnZdGz5IrNAcEaGhqQqkDrJu/KP7vazicoMCRvIITl7p0tKSRNcaYCNWCp7x8w33pFkYrE0PbS6WdF/DQeACpIEfzAXh2QkXPsKW1IXAhn7lfXPBwJ8mTDsn0Nfuq85+JkLrtAhM16M+OGBv5Wn5NpCHC6N7YijLwyeuHwQW56YoR92O1tS8DMpq3+J8EpePwxQdYBZWkjsosp0pTNJR++ARrUJSh3yYN4zUlcFSC40bLht0/dDi7iI4L2M8KoaGJzPN+7guBFacf7awDf9RymKz3qRMyD+w2j7AF+EycYOmDe6iNpolvyOhNVVqy3vDr9aFz9deNnS8owlLj/R0oXFi3nLz9XP6wdGfIkIadjqDgf+qY9c0uxk4Kc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0113a8-ed83-4f01-69d1-08d6fa337960
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:40:31.0259
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

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KVGhpcyBwYXRj
aCBzZXJpZXMgbWFpbmx5IGNvbnRhaW5zIHRoZSBjaGFuZ2VzIHRvIHN1cHBvcnQgdGhlDQphZGQv
ZGVsZXRlIG9mIHdsYW4wL3AycDAgbmV0d29yayBpbnRlcmZhY2VzIGR5bmFtaWNhbGx5LiBUaGUg
ZHJpdmVyDQp3aWxsIGJlIGxvYWRlZCB3aXRoIGEgc2luZ2xlIGRlZmF1bHQgaW50ZXJmYWNlIGFu
ZCBsYXRlciBuZXcgaW50ZXJmYWNlcw0KY2FuIGJlIGFkZGVkIG9yIHJlbW92ZWQuDQpBbHNvIGlu
Y2x1ZGVkIGZldyBjbGVhbnVwIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMuDQoNCkFqYXkgU2luZ2gg
KDgpOg0KICBzdGFnaW5nOiB3aWxjMTAwMDogaGFuZGxlIHAycCBvcGVyYXRpb25zIGluIGNhbGxl
ciBjb250ZXh0DQogIHN0YWdpbmc6IHdpbGMxMDAwOiBmaXggZXJyb3IgcGF0aCBjbGVhbnVwIGlu
IHdpbGNfd2xhbl9pbml0aWFsaXplKCkNCiAgc3RhZ2luZzogd2lsYzEwMDA6IGFkZGVkIHN1cHBv
cnQgdG8gZHluYW1pY2FsbHkgYWRkL3JlbW92ZSBpbnRlcmZhY2VzDQogIHN0YWdpbmc6IHdpbGMx
MDAwOiByZW1vdmUgdXNlIG9mIGRyaXZlcl9oYW5kbGVyX2lkICYgaWZjX2lkDQogIHN0YWdpbmc6
IHdpbGMxMDAwOiByZW1vdmUgdW5uZWNlc3NhcnkgbG9vcCB0byB0cmF2ZXJzZSB2aWYgaW50ZXJm
YWNlcw0KICBzdGFnaW5nOiB3aWxjMTAwMDogcmVtb3ZlIHVzZSBvZiAnc3JjX2FkZHInIGVsZW1l
bnQgaW4gJ3dpbGNfdmlmJw0KICAgIHN0cnVjdA0KICBzdGFnaW5nOiB3aWxjMTAwMDogcmVtb3Zl
IGV4dHJhIGFyZ3VtZW50IHBhc3NpbmcgdG8NCiAgICB3aWxjX3NlbmRfY29uZmlnX3BrdCgpDQog
IHN0YWdpbmc6IHdpbGMxMDAwOiByZW5hbWUgJ2hvc3RfaW50ZXJmYWNlJyBzb3VyY2UgYW5kIGhl
YWRlcg0KDQogZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgfCAgIDIgKy0NCiAuLi4vd2lsYzEwMDAve2hvc3RfaW50ZXJmYWNlLmMgPT4gd2lsY19oaWYu
Y30gICAgICB8IDE3MCArKystLS0tDQogLi4uL3dpbGMxMDAwL3tob3N0X2ludGVyZmFjZS5oID0+
IHdpbGNfaGlmLmh9ICAgICAgfCAgIDEgLQ0KIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxj
X21vbi5jICAgICAgICAgICAgICAgIHwgICA5ICstDQogZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAw
L3dpbGNfbmV0ZGV2LmMgICAgICAgICAgICAgfCAyOTMgKysrKy0tLS0tLS0NCiBkcml2ZXJzL3N0
YWdpbmcvd2lsYzEwMDAvd2lsY19zZGlvLmMgICAgICAgICAgICAgICB8ICAgNyArLQ0KIGRyaXZl
cnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3NwaS5jICAgICAgICAgICAgICAgIHwgICAzICstDQog
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYyAgfCA1MzYg
KysrKysrKysrKysrKy0tLS0tLS0tDQogZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2Zp
X2NmZ29wZXJhdGlvbnMuaCAgfCAgMTMgKy0NCiBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2ls
Y193ZmlfbmV0ZGV2aWNlLmggICAgICB8ICAyNCArLQ0KIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAw
MC93aWxjX3dsYW4uYyAgICAgICAgICAgICAgIHwgIDIzICstDQogZHJpdmVycy9zdGFnaW5nL3dp
bGMxMDAwL3dpbGNfd2xhbi5oICAgICAgICAgICAgICAgfCAgIDggKy0NCiAxMiBmaWxlcyBjaGFu
Z2VkLCA1NjAgaW5zZXJ0aW9ucygrKSwgNTI5IGRlbGV0aW9ucygtKQ0KIHJlbmFtZSBkcml2ZXJz
L3N0YWdpbmcvd2lsYzEwMDAve2hvc3RfaW50ZXJmYWNlLmMgPT4gd2lsY19oaWYuY30gKDkxJSkN
CiByZW5hbWUgZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3tob3N0X2ludGVyZmFjZS5oID0+IHdp
bGNfaGlmLmh9ICg5OSUpDQoNCi0tIA0KMi43LjQNCg0K
