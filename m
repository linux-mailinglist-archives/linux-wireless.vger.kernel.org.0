Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B812F1775E2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 13:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgCCM2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 07:28:15 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7206 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgCCM2P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 07:28:15 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: L1OlvvkVQZx8/8Vmr9raaEqiq2XFcIfG5Fy0U/vgfHewXw3fU0fBye6+H2hZkhgbhB5ELZJplH
 KFMHeNK9AVsyCogTTuR1/sSfD195PXopOjYZfPtevzMKZBxznG9l55h1EZwrzMKIgmHm0IwZ6E
 H8YTbcte/VM+6KJedv+VMuEvyjD0cnyjUNJK7Yz8aCQpKa6+p+IRw8O2sBN+ul+adDnzfX4PIt
 PXcOolx0dDT64Fuf0uYaMuBNbIdcio7MdDujPsgtT/sJHp5/OauehB5fqvHcYZf3pfphoqS5oo
 7AI=
X-IronPort-AV: E=Sophos;i="5.70,511,1574146800"; 
   d="scan'208";a="4309743"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2020 05:28:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Mar 2020 05:28:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 3 Mar 2020 05:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cayxk7D02K742c8mwFe8rXXr8ITAc6KHXiVu2O7+izlJ7Lk5aIbPH9JYDh/3FjxmVgfTN33CGEUBRFQMvDpLQR/sVFgrDqZLJUfGEgx9oatiGzLcvwTHh671SOgbEUSU8tvu/c9x+fX1Mk5nmtKCw57MA30R+9gC7HehuoWEz3C0HJ7Mb9k8n5xWzAt7Le8EiKtTDhLO9QQoyXo0LrxGYVLXwhRQK2/3zJJb4xYcu/afYkT0JiG6OHsWzMD7MW3w79kK9D3iR0eQXanMiGPvtcIDbyWTjHI7tw9hOjZyVN2umuXgCaBBV9+oSNN9ZhIZktnVGkq5ZxcNSmg1t36h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4UYHSQJTghL2axWoO+U0ypyro3tNhbjS2+pn7gwicc=;
 b=N4kUdbjSPfaSjb/Tc+1JVwgFtSe09XsV3mI46yZhdT6nDkeOGiifoG+0aR4t3v+Lx7yf6bFWsknSRieHKqB81VI8p5X/MlGL1r7z6zvf5/04btlfMxUdNgdMydE4tpND5NiH3P2bdU6IR//mM4gCsA8+FxTW/C+dKzBIy5T7t5Z0vwJVXW+CrUVgMmAJr8yOlUh/p8jRuD5ywK9+HGKvIeRImzxl8Ru0sZhammgK3TyGZge86YLtIEVKreiKo7sRmglLAS/7mP3hiIVjuxzKlC+dLVw9MnhV87rO+NBKJA5mQdCqHwlw/zOLEXA3nL9W/ONQ3pwWtgXW0/Xvd3sryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4UYHSQJTghL2axWoO+U0ypyro3tNhbjS2+pn7gwicc=;
 b=CsKyoEsIrceASe6K+Gufv0oYuBZcDHjo3LM+PzP/tz2L+bNZWuDGMmUTp7+ODCDwjnt3+GMr+mthe/Ro8KGqpfazHIft5N9j0EwPAJiJ29gMsF6mofjbGWzdH1aNxgwnHNjqGHH3Z3GwnTo4joLzLNEHYDayiDFmir1KQT5qQUE=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1281.namprd11.prod.outlook.com (2603:10b6:404:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 12:28:11 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 12:28:10 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v4 16/18] dt: bindings: net: add
 microchip,wilc1000,sdio.yaml
Thread-Topic: [PATCH v4 16/18] dt: bindings: net: add
 microchip,wilc1000,sdio.yaml
Thread-Index: AQHV8LB4evB5uOBIuUadeV/L9u3vJKg2HGIAgACwowA=
Date:   Tue, 3 Mar 2020 12:28:10 +0000
Message-ID: <3b22e640-bce1-7b09-8c75-f53d241cf9bc@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
 <20200302163414.4342-17-ajay.kathat@microchip.com>
 <20200303015558.GA6876@bogus>
In-Reply-To: <20200303015558.GA6876@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01bc8272-0059-498c-ed78-08d7bf6e561c
x-ms-traffictypediagnostic: BN6PR11MB1281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1281093C1F22F9EF693E08B5E3E40@BN6PR11MB1281.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(6512007)(36756003)(6486002)(26005)(498600001)(966005)(66946007)(2616005)(71200400001)(31696002)(86362001)(66446008)(66556008)(76116006)(186003)(91956017)(66476007)(64756008)(4326008)(31686004)(8936002)(8676002)(53546011)(81166006)(81156014)(5660300002)(6506007)(6916009)(54906003)(107886003)(2906002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1281;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fby7MNgNfaBWB+dMuwE4vPWoUn2zLbf5tyFuLNEdoUUTUhQVrSE391grWGRRSpN3FP4zUZ/WAxzKmx3vFysQjqHeOgwGJ6ZFRfl3FuUUolcvJppk9GSWcVsp6MCBwbwP44fYzLYvoIXE7nb0Rgef+wgo5Q6l7NjFGjq8ZS4xavH39W7Q9U+JKxccM4qQecDC1wIdWKa5OSI1h/p3OseXyMvbUpUylUFoLK/wU2/S7aGg4tDxAFyYptJ6Q/8CeN7CkeFrn1QTiJH/C/SP42VlJgpcIe37Z9d94IMKb7ZdE45gi4UCkbmOg/6ggN5wpCHkWe8e4FDeQHAddx64CasHDDwFkkYlvgAvXTIEdqRqJRrxttli0vGJ5MYzwiK1kmbXb4vokwIF7I5y/z4caKolNoNE2/Fu9iNbqN0KBZ7H2T8M/8d/9/mG0Blf+2vIgInnl2YNE+Zj6GyMXz98qE/fh2dwMk8sLI5nYIGvs1u1P37QfTilvGphTPnbhxDAmi9G3c6b+RenkuJehf913Aw0Lxt8Djl75Bz38n7gQNmRpLY5zt7REWPKHh/z/YfvL5GG
x-ms-exchange-antispam-messagedata: 5QJ28rpgWo1rfL6mjTNtqb1twmq7a+K4XJHZ5JsKA4YPbVUTz3cF+Oi8/4+4Udq89Yr295b8YFxt2FhxRf0OXx9RsUekwBd446Jgwn4iNs1QXQYGmpZKOjCHTS23t0aHF4/NmopC/kGK1dWmxPuLEA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <38F2A6F8940ABB42821B0F2AEA36D234@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bc8272-0059-498c-ed78-08d7bf6e561c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 12:28:10.6439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xwTtuC5zOd8JQxY6Tk1MqStVUz7NueAXGJjZlE+Ih25PqvTFyV6l4TRFwT1rbN7tydry5Z3U6teMT3IIIIYvP+KneNv6Xrqnrw2gakkrEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1281
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHJldmlld2luZy4NCg0KT24gMDMvMDMvMjAgNzoyNSBhbSwg
Um9iIEhlcnJpbmcgd3JvdGU6DQo+IA0KPiBPbiBNb24sIE1hciAwMiwgMjAyMCBhdCAwNDozNDo0
MFBNICswMDAwLCBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogQWph
eSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBNb3ZlZCAnL2RyaXZl
cnMvc3RhZ2luZy93aWxjMTAwMC9taWNyb2NoaXAsd2lsYzEwMDAsc2Rpby55YW1sJyB0bw0KPj4g
J0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWljcm9jaGlw
LHdpbGMxMDAwLHNkaW8ueWFtbCcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8
YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwLHdpbGMxMDAwLHNkaW8ueWFtbCB8IDY4ICsrKysrKysrKysrKysrKysrKysNCj4+
ICAxIGZpbGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cCx3aWxjMTAwMCxzZGlvLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAsc2Rpby55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9taWNy
b2NoaXAsd2lsYzEwMDAsc2Rpby55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5iMzM4ZjU2OWY3ZTINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWljcm9jaGlw
LHdpbGMxMDAwLHNkaW8ueWFtbA0KPj4gQEAgLTAsMCArMSw2OCBAQA0KPj4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1M
IDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0
L3dpcmVsZXNzL21pY3JvY2hpcCx3aWxjMTAwMCxzZGlvLnlhbWwjDQo+PiArJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0
bGU6IE1pY3JvY2hpcCBXSUxDIHdpcmVsZXNzIFNESU8gZGV2aWNldHJlZSBiaW5kaW5ncw0KPj4g
Kw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBBZGhhbSBBYm96YWVpZCA8YWRoYW0uYWJvemFl
aWRAbWljcm9jaGlwLmNvbT4NCj4+ICsgIC0gQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9j
aGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZSB3aWxjMTAwMCBjaGlw
cyBjYW4gYmUgY29ubmVjdGVkIHZpYSBTRElPLiBUaGUgbm9kZSBpcyB1c2VkIHRvDQo+PiArICBz
cGVjaWZ5IGNoaWxkIG5vZGUgdG8gdGhlIFNESU8gY29udHJvbGxlciB0aGF0IGNvbm5lY3RzIHRo
ZSBkZXZpY2UNCj4+ICsgIHRvIHRoZSBzeXN0ZW0uDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+
ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGNvbnN0OiBtaWNyb2NoaXAsd2lsYzEwMDAtc2Rpbw0K
Pj4gKw0KPj4gKyAgaXJxLWdwaW9zOg0KPiANCj4gVW5sZXNzIHlvdSBuZWVkIEdQSU8gY29udHJv
bCBvZiB0aGUgbGluZSwgdXNlICdpbnRlcnJ1cHRzJyBpbnN0ZWFkLg0KDQpJIHdpbGwgY2hlY2sg
dGhpcy4NCg0KPiANCj4+ICsgICAgZGVzY3JpcHRpb246IFRoZSBHUElPIHBoYW5kbGUgY29ubmVj
dCB0byBhIGhvc3QgSVJRLg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgcmVnOg0K
Pj4gKyAgICBkZXNjcmlwdGlvbjogU2xvdCBJRCB1c2VkIGluIHRoZSBjb250cm9sbGVyLg0KPiAN
Cj4gTm8sIGl0J3MgdGhlIGZ1bmN0aW9uIG51bWJlci4gQnV0IHlvdSBjYW4ganVzdCBkcm9wIHRo
aXMuDQo+IA0KDQpPay4gSSB3aWxsIGRyb3AgdGhpcyBkZXNjcmlwdGlvbi4NCg0KPj4gKyAgICBt
YXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2tzOg0KPj4gKyAgICBkZXNjcmlwdGlvbjogcGhh
bmRsZSB0byB0aGUgY2xvY2sgY29ubmVjdGVkIG9uIHJ0YyBjbG9jayBsaW5lLg0KPj4gKyAgICBt
YXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgYnVzLXdpZHRoOg0KPiANCj4gSSBiZWxpZXZlIHRoaXMg
aXMgZGVmaW5lZCB0byBnbyBpbiB0aGUgcGFyZW50IG5vZGUuDQo+IA0KDQpJbiB0aGF0IGNhc2Us
IEkgdGhpbmsgd2UgY2FuIGRyb3AgdGhpcyBkZXNjcmlwdGlvbiBoZXJlIGJ5IG1vdmluZyBpdCB0
bw0KcGFyZW50IG5vZGUuIHJpZ2h0Pw0KDQo+PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgbnVtYmVy
IG9mIGRhdGEgbGluZXMgd2lyZWQgdXAgdGhlIHNsb3QuDQo+PiArICAgIGFsbE9mOg0KPj4gKyAg
ICAgIC0gJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+PiAr
ICAgICAgLSBlbnVtOiBbMSwgNCwgOF0NCj4+ICsgICAgICAtIGRlZmF1bHQ6IDENCj4+ICsNCj4+
ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSBpcnEtZ3Bpb3MNCj4+ICsg
IC0gcmVnDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgbW1jMTogbW1j
QGZjMDAwMDAwIHsNCj4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAj
c2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
Pj4gKyAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9tbWMxX2Nsa19jbWRfZGF0MCAmcGluY3Ry
bF9tbWMxX2RhdDFfMz47DQo+PiArICAgICAgbm9uLXJlbW92YWJsZTsNCj4+ICsgICAgICB2bW1j
LXN1cHBseSA9IDwmdmNjX21tYzFfcmVnPjsNCj4+ICsgICAgICB2cW1tYy1zdXBwbHkgPSA8JnZj
Y18zdjNfcmVnPjsNCj4+ICsgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiBEb24ndCBzaG93
ICdzdGF0dXMnIGluIGV4YW1wbGVzLg0KPiANCg0KT0suIEkgd2lsbCByZW1vdmUgdGhpcy4NCg0K
Pj4gKyAgICAgIHdpbGNfc2Rpb0AwIHsNCj4gDQo+IHdpZmlAMA0KPiANCj4+ICsgICAgICAgIGNv
bXBhdGlibGUgPSAibWljcm9jaGlwLHdpbGMxMDAwLXNkaW8iOw0KPj4gKyAgICAgICAgICBpcnEt
Z3Bpb3MgPSA8JnBpb0MgMjcgMD47DQo+PiArICAgICAgICAgIHJlZyA9IDwwPjsNCj4+ICsgICAg
ICAgICAgY2xvY2tzID0gPCZwY2sxPjsNCj4+ICsgICAgICAgICAgY2xvY2stbmFtZXMgPSAicnRj
X2NsayI7DQo+PiArICAgICAgICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmcGNrMT47DQo+PiArICAg
ICAgICAgIGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDMyNzY4PjsNCj4+ICsgICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KDQpJIHdpbGwgcmVtb3ZlICdzdGF0dXMnIGhlcmUgYWxzby4NCg0KPj4g
KyAgICAgICAgICBidXMtd2lkdGggPSA8ND47DQoNCkkgd2lsbCBtb3ZlIHRoaXMgcHJvcGVydHkg
dG8gcGFyZW50IG5vZGUuDQoNCj4+ICsgICAgICAgIH07DQo+PiArICAgIH07DQo+PiAtLQ0KPj4g
Mi4yNC4w
