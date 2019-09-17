Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143A2B482B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfIQHVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 03:21:14 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49706 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfIQHVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 03:21:13 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9KxwFA4X67yDbRzgEOBaz9Hs6Lvs36HBH8Rp+h6o9wzHo5/wOZh+CoF6KtHzXoi7OrCKBCknpt
 j8Iyp+ZFfN165J3V2wzIpjuC2mtNpYV6VZQG/RhOIlziem0r5QT8fJWbdIq3Yr2C17zXVFQt3L
 fuid53ly8eniyFNSf/nCQaWlhieM9J2AqmJNsMXnhG42NMd30hW/QFLxRE93L31aesOxGcxDc0
 DIiDpGL0MD2rVKgD0Lbzz9PsAkwIFnwkakyyUzl/ngFaB8sXi3lgugJQcz4tRLd7hQQHBrbanP
 51E=
X-IronPort-AV: E=Sophos;i="5.64,515,1559545200"; 
   d="scan'208";a="49341418"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 00:20:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 00:20:53 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 00:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOBqBHJO19qbkXqwAmf61uYKtMzuIyZVXENFjHJrfp0cWELgC2PLuJHbNyEtA2eaytLeklXRBlH5R+/7F5GKdAvLCkYyO5QojuCJnadF60pUn7U/979Thg6WCVcKH+qde+k4kYB9Xh+ID+swFRPRxsapCWUWcIwtovVrVGxAL3YvMzoS9iaJoU3wPYWwE8RZN2qbc2v0S7oU06cnGHe9U7ICTIZzsVvROTOyBxYtwtN1XHyF48L9jpY/D+dRUn6SKPYMAlrkFMnLuvz/iHMNLQu4Qy/zmZqdaR+5XLGNyK3TmM0kAO326k4uxWtlzLac0+BADSU0dNV+kfZK+ctU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPkEbHSkuiktmNPPptLKjATFU7nAs4QSaXHCSU9Alsw=;
 b=aMwpOsmH8t4TbhrwTYMiYcXt1agYSM376FWfBomrs/hhVprUaoMlQSwO86Y7bm6wgrzpX2fMBWg7JgEjgmkV2Mb2Y4ea7+szsOdPCcGf/c939b8l5IHd3FRyhmjOimFQBvCr6/ZhRRCFimSfkYDcQq9FUvm4krWnEae7ZJrtLKNsZfwPIqffiAflA7sjsnzk8TXFTz/riE6dSh1F4PEwazXQmY5ZF9/enbI2BnZYOOwVALPUNcpW+JRaCAdGPXTYgVpdVj5DaAO4BneB24+Iwo/O1Z10erNm183vnur8BPp44PX+vvAGlenxHtxHrQeZ3BOxR26v0NqOToyajgsrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPkEbHSkuiktmNPPptLKjATFU7nAs4QSaXHCSU9Alsw=;
 b=GCrZKF3Qvx83Wqf8NBd2X3NuHrr06aMN1BPGTkFaacmidM0w3bpVECtMDa1P12Gk41cuYKk0lnnYedntzeCT+s12tXDV/tJ6p/FP5+jZsD1sX2BJXRz7627QJmx6nSir8BYmXxA2VpO9rMORX66boJAk+ZrFcvcaycsuifRR+/Y=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1774.namprd11.prod.outlook.com (10.175.51.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 07:20:50 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::e1f5:745f:84b4:7c7c]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::e1f5:745f:84b4:7c7c%12]) with mapi id 15.20.2263.023; Tue, 17 Sep
 2019 07:20:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Adham.Abozaeid@microchip.com>, <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <Ajay.Kathat@microchip.com>,
        <gregkh@linuxfoundation.org>, <Eugen.Hristev@microchip.com>,
        <johannes@sipsolutions.net>
Subject: Re: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Topic: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Index: AQHVbScl6jIVhd9+50ifu++xL1vFiacvdoSA
Date:   Tue, 17 Sep 2019 07:20:50 +0000
Message-ID: <46ffef84-26cf-bc60-3dae-87fd919d6822@microchip.com>
References: <20190916193701.20755-1-adham.abozaeid@microchip.com>
 <33c095f7-57a8-1d80-02af-0195f317bc39@microchip.com>
In-Reply-To: <33c095f7-57a8-1d80-02af-0195f317bc39@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0089.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::33) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917102041067
x-originating-ip: [86.120.236.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e448c25-eacc-4594-0e4f-08d73b3f9145
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1774;
x-ms-traffictypediagnostic: MWHPR11MB1774:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17742ABF844FEBC2D3123220878F0@MWHPR11MB1774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(110136005)(66476007)(478600001)(8936002)(256004)(64756008)(31686004)(66446008)(66556008)(31696002)(14444005)(66066001)(186003)(446003)(76176011)(66946007)(476003)(11346002)(36756003)(2616005)(81166006)(8676002)(81156014)(486006)(52116002)(4326008)(99286004)(316002)(71190400001)(7736002)(6116002)(6486002)(86362001)(3846002)(5660300002)(966005)(54906003)(25786009)(2501003)(6436002)(6512007)(6506007)(305945005)(53546011)(102836004)(71200400001)(6306002)(386003)(2906002)(229853002)(14454004)(6246003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1774;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wfBrwIcaxxUlnN71Esr1qM66sOyyfWPbD8QGVC1i0NM8uYM8h02xPexHTMkpp7jyi9FhA4BbFw4C/1ARY6wmyob+2aHUUgmNG8tVHQzOWGBBxD6sdE/AAK+NIzdhoWkT01Lx9SxLLrjMGDwnNmr+czasHN9KNwFiI8KHW0yAizHE9iC6/0VYb8t0FQ1jjhVJ5GjjL2ObCTa1zQcxtan0eAQD2eziDuDhCWLWIRgxvDbJz1avKYmjpCQhaslIYYYyCmTmWBN+/JWf/HdZqsYOv1lWRVmPC0kIHz91C8r07VE87axUAe1AgAvaDNeeNqOoraonE03Qr5tnDRGmzfa26bovfBv3Q/XmYhAi9MdfXH9zLGSf8EMOY9Roeqe9AngA6lz1i+uO5kTQi6j3QEAjgPlDvpA9jotzHA6NPi+2Hjg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <095183B0227BF14FAC0B8AE39D290D0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e448c25-eacc-4594-0e4f-08d73b3f9145
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 07:20:50.4513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bejdBYKnrWPgDF2gW4WoBKzH9irduNMKnUh59hq8DHuSTxfy9WkfMrJNxw1vlZWJBurHNZAliqnxW0ghDSAsaZB7TDT9kMNTu0NwuDrZNBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1774
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tm93IEkgc2VlIHRoYXQgeW91ciBwYXRjaCBpcyBmb3IgU1BJIGludGVyZmFjZSwgc28sIGl0IG1h
eSBiZSBuZWNlc3NhcnkuDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNCk9uIDE3LjA5LjIwMTkg
MTA6MTEsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IFRoaXMgaXMgYWxy
ZWFkeSBwcmVzZW50IGluIHN0YWdpbmctbmV4dCAoc2VlIFsxXSBhbmQgWzJdKQ0KPiANCj4gWzFd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdraC9z
dGFnaW5nLmdpdC9jb21taXQvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwP2g9c3RhZ2luZy1uZXh0
JmlkPTg2OTJiMDQ3ZTg2Y2ZmNDQ4YWYxNTY0YThiZGRhNzcwZDJkZWI1NjcNCj4gWzJdIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2dyZWdraC9zdGFnaW5n
LmdpdC9jb21taXQvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwP2g9c3RhZ2luZy1uZXh0JmlkPWFl
ODc3OWUxOTgzZDYzNjE2MjBmMWY2ZDNmNzYwNjRlZGVlNzMzYzANCj4gDQo+IE9uIDE2LjA5LjIw
MTkgMjI6MzcsIEFkaGFtLkFib3phZWlkQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBFeHRlcm5h
bCBFLU1haWwNCj4+DQo+Pg0KPj4gRnJvbTogQWRoYW0gQWJvemFlaWQgPGFkaGFtLmFib3phZWlk
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gSWYgcnRjX2NsayBpcyBwcm92aWRlZCBmcm9tIERULCB1
c2UgaXQgYW5kIGVuYWJsZSBpdC4NCj4+IFRoaXMgaXMgb3B0aW9uYWwuDQo+PiBUaGUgc2lnbmFs
IG1heSBiZSBoYXJkY29kZWQgYW5kIG5vIG5lZWQgdG8gYmUgcmVxdWVzdGVkLA0KPj4gYnV0IGlm
IERUIHByb3ZpZGVzIGl0LCB1c2UgaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWRoYW0gQWJv
emFlaWQgPGFkaGFtLmFib3phZWlkQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJz
L3N0YWdpbmcvd2lsYzEwMDAvd2lsY19zcGkuYyB8IDExICsrKysrKysrKysrDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL3dpbGMxMDAwL3dpbGNfc3BpLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2ls
Y19zcGkuYw0KPj4gaW5kZXggM2MxYWU5ZTlmOWFhLi4xNjY0NTVhOTY5YmYgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY19zcGkuYw0KPj4gKysrIGIvZHJpdmVy
cy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfc3BpLmMNCj4+IEBAIC00LDYgKzQsNyBAQA0KPj4gICAq
IEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+PiAgICovDQo+PiAgDQo+PiArI2luY2x1ZGUgPGxpbnV4
L2Nsay5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9zcGkvc3BpLmg+DQo+PiAgDQo+PiAgI2luY2x1
ZGUgIndpbGNfd2ZpX25ldGRldmljZS5oIg0KPj4gQEAgLTEzMiw2ICsxMzMsMTIgQEAgc3RhdGlj
IGludCB3aWxjX2J1c19wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPj4gIAl3aWxjLT5i
dXNfZGF0YSA9IHNwaV9wcml2Ow0KPj4gIAl3aWxjLT5ncGlvX2lycSA9IGdwaW87DQo+PiAgDQo+
PiArCXdpbGMtPnJ0Y19jbGsgPSBkZXZtX2Nsa19nZXQoJnNwaS0+ZGV2LCAicnRjX2NsayIpOw0K
Pj4gKwlpZiAoUFRSX0VSUl9PUl9aRVJPKHdpbGMtPnJ0Y19jbGspID09IC1FUFJPQkVfREVGRVIp
DQo+PiArCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4+ICsJZWxzZSBpZiAoIUlTX0VSUih3aWxj
LT5ydGNfY2xrKSkNCj4+ICsJCWNsa19wcmVwYXJlX2VuYWJsZSh3aWxjLT5ydGNfY2xrKTsNCj4+
ICsNCj4+ICAJcmV0dXJuIDA7DQo+PiAgfQ0KPj4gIA0KPj4gQEAgLTE0Miw2ICsxNDksMTAgQEAg
c3RhdGljIGludCB3aWxjX2J1c19yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4+ICAJ
LyogZnJlZSB0aGUgR1BJTyBpbiBtb2R1bGUgcmVtb3ZlICovDQo+PiAgCWlmICh3aWxjLT5ncGlv
X2lycSkNCj4+ICAJCWdwaW9kX3B1dCh3aWxjLT5ncGlvX2lycSk7DQo+PiArDQo+PiArCWlmICgh
SVNfRVJSKHdpbGMtPnJ0Y19jbGspKQ0KPj4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHdpbGMt
PnJ0Y19jbGspOw0KPj4gKw0KPj4gIAl3aWxjX25ldGRldl9jbGVhbnVwKHdpbGMpOw0KPj4gIAly
ZXR1cm4gMDsNCj4+ICB9DQo+Pg0K
