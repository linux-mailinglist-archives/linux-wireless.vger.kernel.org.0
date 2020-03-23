Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB7318EF07
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 06:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCWFH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 01:07:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:36464 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCWFH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 01:07:58 -0400
IronPort-SDR: r3eX6wQeqobn4Vij2XRtnaEkFMctDP057dry/cvBVbyCmcS1GL3QwpsstJ+3jrqlA0P+JMpFZU
 nycCK1ti9D0Vij88u5yoK+iaSvgb3I/HZ7xO+4YiOR1Iv92YVDT8kC+DwPf1S1bzbnRU6YajAG
 7SrPW7UFCtILCykElojmgEPThWb8akXeOa8iBnEBLJzGXmUwbofIUIg6h6QAH17s7ZX9LO1pFi
 BmPGf68UzxoO/xrzg1335LyrSYTvUT4t16yceuF0NDyVqFcQO6PFn1x11beva67hYD3uyCmyHy
 ZgY=
X-IronPort-AV: E=Sophos;i="5.72,295,1580799600"; 
   d="scan'208";a="68052307"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Mar 2020 22:07:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Mar 2020 22:07:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 22 Mar 2020 22:07:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmvrHVHLF79k44itUfw+XFFpc+nrPAh4TEccZmqFM9zjrKDFPV6UFgPBZS5be2FNAic2DkKLWEBrxOcV5qSbv3OncLuap9VWkwjF0TAsvn2O67rESUo6Wx/Hw4lU7v4zLjmd/aklWl4HLuoaU02dGXzgfGh9Mje0Ii2GfTvhiO/rTOIA/t1587yeSVLrEdKG+WUdApoDcXwalnCftqrYWoP0a6fSns+YABCScSb3VrkI/QCcyr58UZBzcl9hK55LDpvyz0X5wF1CfFULiqNrBcwLC8jd4lWsyS7oeEIKUqNK9/29yMfMrtwFv7RQAOik1P2VRQf0VCxph99s10cl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhGAP5MYnL58O5L4fEW2/H/Gn9JYp4UDx4jVxcGQN/g=;
 b=MTn5Y551S9bQUDR2AndD0WbvgO8otgXCFBi/YVpcfzP/oHZIW8JjCR9g9nHtm/xtxSTXm/bbcBQjOL6yrAHhF9rNHkj4SCFBNEYIQ2z7ucy6sdv6cVDf9tmvBspDSS4C/JIL0haLsHkROXclHlCvTeL+3+Oo0wIp9I7ss0pmABuIr2kMARiO06vD8D7xEPOjRwGdl+hEC6qoBo0gSxZ3j6Ik6EAOce9UHKDjoCXDPt3NSJ8jimxdjsfi2oLPKoivprKiyRfn+jLN5vRT7f6bNWbNd3Fnsp7w25JdHMkpGdeKgkdLfZxfWtzy8HjBuvsGvhQGRsRGt6nPiea72RccMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhGAP5MYnL58O5L4fEW2/H/Gn9JYp4UDx4jVxcGQN/g=;
 b=SwbRUs1X9lFYftHQJm5X95bSypFYcEWuatzbwh4qcEFDT6Jl9m6besqW6tb0yOsTOpMZPx1T8RcVldNaLZoM+DHGjOAcavp+IEwyI3e79RQCsOkJxitgDNxdKCeYOso43J1oC5kJhVzURvDlL0wl7+Nsq9xx/CuMTVNYjYnNIYM=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2645.namprd11.prod.outlook.com (2603:10b6:a02:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 05:07:55 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 05:07:55 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v5 16/17] dt: bindings: net: add microchip,wilc1000.yaml
Thread-Topic: [PATCH v5 16/17] dt: bindings: net: add microchip,wilc1000.yaml
Thread-Index: AQHV9585ZPX9+wP3gkivIpFS8gVFT6hR01AAgAPfdIA=
Date:   Mon, 23 Mar 2020 05:07:55 +0000
Message-ID: <6c9f2819-30bb-9e7f-ff26-0b59a22624e6@microchip.com>
References: <20200311121809.5610-1-ajay.kathat@microchip.com>
 <20200311121809.5610-17-ajay.kathat@microchip.com>
 <20200320175920.GA31641@bogus>
In-Reply-To: <20200320175920.GA31641@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.16.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77ac9c18-b571-45cb-3e15-08d7cee825a0
x-ms-traffictypediagnostic: BYAPR11MB2645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26456F33DB8E8C221063D391E3F00@BYAPR11MB2645.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(54906003)(966005)(6512007)(6916009)(4326008)(5660300002)(71200400001)(26005)(107886003)(478600001)(316002)(186003)(91956017)(76116006)(6506007)(53546011)(66476007)(66556008)(64756008)(66446008)(31686004)(6486002)(66946007)(2616005)(31696002)(81166006)(81156014)(2906002)(36756003)(86362001)(8936002)(8676002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2645;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MpiSVrv7IpQ82rjKvIamJxWqxic+zuUajD3jjdMZcvZiI85pwWK9uvSpLTKB652PPg+3YVkJewtVl/H0Otf0dmwh8J8wSfKW+Sj0OItiDnfZ2HLmRpybgYt9CnoFOqfk7PBdiXZG0sr8ZFGW6kW0N7FiW0xeJK9d4gLvLbJU31R7qMeO/eEiLNztTab8km6bW1D/Xo0UtOUXYtfAyv5MRid/StGHy7qf0IVypmMK4aYm+AflJcz8gff48zhj0KksyIXWBNyAIM6GyPE8sdMIA8MMcDf002LAKK8Gj4lsrzZADIdVEwQkK3hxPRF/5ktGJ+XA/id3iIP6svruMFT+6MLNFVt6zQovMT5EcVIt4RvvgyzBWLZ05xyLUOVb0ZTEOeKlubmamsKXMFV1Zq7fylaT8Y6Bn39IXkin61N8X1kBuyP0gAR6/MrvsHBUsvXE3qnaAXyuoLeqxaoRYP/QXEdr0TcKc+eP1S1/gTW3ThU6/HSAv9qPs+eyhSQNIpQnErEsYjN6Wy6xHilZNUtgIesocn6FAm7SrYoVsJ1oAkUdzTDhD9M+bXJ0P+T29x7
x-ms-exchange-antispam-messagedata: NwGHcWU8IPcU+90VDSYTiYzpPPjX+w4ZTYeNLZYooD18JIFfalHLIK1Le3jZZUv3l+vlcdriPk3C3Wiq+4BwwmVZWVNB8gQFQMoUUFzHuBgczwtIV2/lXE1sXHqP96J84FgOrTh3wSY/rxzgELUS9g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DBF9AC3451B224EA21393AB69E13A52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ac9c18-b571-45cb-3e15-08d7cee825a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 05:07:55.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i14tk9i/CcgETbaB76Px+UtNnC9DmvOkbOtSObAhlyvfB+kqhFrNm5X5RiAojh/XokF0QiufDAiEVcN31kpuO6MCVCa4ZYnuRPWWPZc0e1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2645
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMC8wMy8yMCAxMToyOSBwbSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IA0K
PiBPbiBXZWQsIE1hciAxMSwgMjAyMCBhdCAxMjoxODo1MFBNICswMDAwLCBBamF5LkthdGhhdEBt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWlj
cm9jaGlwLmNvbT4NCj4+DQo+PiBUaGlzIGZpbGUgZGVzY3JpYmVzIHRoZSBiaW5kaW5nIGRldGFp
bHMgdG8gY29ubmVjdCB3aWxjMTAwMCBkZXZpY2UuIEl0J3MNCj4+IG1vdmVkIGZyb20gc3RhZ2lu
ZyB0byAnRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcycNCj4+
IHBhdGguDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWlj
cm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9uZXQvd2lyZWxlc3MvbWljcm9jaGlwLHdpbGMx
MDAwLnlhbWwgICAgICB8IDcyICsrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNzIgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21pY3JvY2hpcCx3aWxjMTAwMC55YW1s
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvd2lyZWxlc3MvbWljcm9jaGlwLHdpbGMxMDAwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNzL21pY3JvY2hpcCx3aWxjMTAwMC55YW1sDQo+PiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iYzZjYzVkM2YzNDcN
Cj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwLHdpbGMxMDAwLnlhbWwNCj4+IEBAIC0wLDAgKzEs
NzIgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJT
RC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL25ldC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAueWFtbCMN
Cj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCMNCj4+ICsNCj4+ICt0aXRsZTogTWljcm9jaGlwIFdJTEMgd2lyZWxlc3MgZGV2aWNldHJlZSBi
aW5kaW5ncw0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBBZGhhbSBBYm96YWVpZCA8
YWRoYW0uYWJvemFlaWRAbWljcm9jaGlwLmNvbT4NCj4+ICsgIC0gQWpheSBTaW5naCA8YWpheS5r
YXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZSB3
aWxjMTAwMCBjaGlwcyBjYW4gYmUgY29ubmVjdGVkIHZpYSBTUEkgb3IgU0RJTy4gVGhpcyBkb2N1
bWVudA0KPj4gKyAgZGVzY3JpYmVzIHRoZSBiaW5kaW5nIHRvIGNvbm5lY3Qgd2lsYyBkZXZpY2Vz
Lg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBjb25z
dDogbWljcm9jaGlwLHdpbGMxMDAwDQo+PiArDQo+PiArICBzcGktbWF4LWZyZXF1ZW5jeTogdHJ1
ZQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+
ICsgIGNsb2NrczoNCj4+ICsgICAgZGVzY3JpcHRpb246IHBoYW5kbGUgdG8gdGhlIGNsb2NrIGNv
bm5lY3RlZCBvbiBydGMgY2xvY2sgbGluZS4NCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+
ICsgIGNsb2NrLW5hbWVzOg0KPj4gKyAgICBjb25zdDogcnRjDQo+PiArDQo+PiArcmVxdWlyZWQ6
DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKw0KPj4gK2V4YW1w
bGVzOg0KPj4gKyAgLSB8DQo+PiArICAgIHNwaTE6IHNwaUBmYzAxODAwMCB7DQo+IA0KPiBzcGkg
ew0KPiANCj4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4+ICsgICAgICBjcy1ncGlvcyA9IDwmcGlvQiAyMSAwPjsNCj4gDQo+IERy
b3AgdGhpcy4gTm90IHJlbGV2YW50IHRvIHRoZSBleGFtcGxlLg0KDQpPay4NCg0KPiANCj4+ICsg
ICAgICB3aWZpQDAgew0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsd2lsYzEw
MDAiOw0KPj4gKyAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8NDgwMDAwMDA+Ow0KPj4gKyAg
ICAgICAgcmVnID0gPDA+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGlvQz47
DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDI3IDA+Ow0KPj4gKyAgICAgICAgY2xvY2tzID0g
PCZwY2sxPjsNCj4+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gInJ0YyI7DQo+PiArICAgICAgfTsN
Cj4+ICsgICAgfTsNCj4+ICsNCj4+ICsgIC0gfA0KPj4gKyAgICBtbWMxOiBtbWNAZmMwMDAwMDAg
ew0KPiANCj4gRHJvcCB0aGUgbGFiZWwuIEVpdGhlciBkcm9wIHRoZSB1bml0IGFkZHJlc3Mgb3Ig
YWRkIGEgJ3JlZycgcHJvcGVydHkgdG8NCj4gbWF0Y2guDQoNCk9rLiBJIHdpbGwgZHJvcCB0aGUg
bGFiZWwgYW5kIHVuaXQgYWRkcmVzcyBpbiB0aGlzLg0KDQoNClJlZ2FyZHMsDQpBamF5
