Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB207A9A62
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfIEGKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 02:10:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33581 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfIEGKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 02:10:48 -0400
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
IronPort-SDR: li7K5xyQXH7T4T2IzttzuZKlxl2s+0VfKNCDTmnCR3jJLT0D+jIOd8tJsuzhU3hVZHGclQJQD8
 MJInTg6I25sZRXnAKmOnjylAgkhzud01Nl6x/TpImRW01iO5zxwGmeChTIqkrQUOEym30eHM/h
 i4YrVgOD+T5EGVfdu9QsGMhut37uMh4YoKSfGpEdXLzn/LSqIpoR2HOMzcnu3cHEuscUUsPx0+
 elqCTXz46bKGRMwIgYs/b1Jo8Jb7PIFZc4OtPT6HqKH8rjbWxYNikE83RRzcrK2TiP0fyaPoS8
 FaM=
X-IronPort-AV: E=Sophos;i="5.64,469,1559545200"; 
   d="scan'208";a="47889691"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2019 23:09:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Sep 2019 23:09:47 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Sep 2019 23:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCeAXT7fsUTfPFjRPantadeDw3hsXII96eeHq5gSI0up3/YJWVzhXyud0/by9PbzwSCYO4O8tSDArmKlVaKhkSlXuxKaMcgKzzlG1sZRzDbyd1PVfWNiiwPTKDLPz7K950jp3uOrTi82QRDteQLlWk3VOq+xWkGMq9jeBPbMxf5KFGC6dNKguVu63gGX9ZrH/1hlBD3sNFN2vnZnrvBSaVG/gK4mG19++zWlB4rH5VVc2zm0ONm5A1Rh2LT3hYuEoziOKBE7EMtkNd116NNBbPnMVioIfKrQc4h3UfwFU+bXWQyEqDx7tRGdj2gpl2O3DT9EjmE4hu09m66y3n02tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Jchdmft8pFeZkDehWGyUyMTzlL/Vfjf4OCtO4tDuw=;
 b=MlQHuZSvcypZ8LktVfukx+sh+m4nVbtqBXpq125eekqV8gEGITanodQVSj9Ernp9uyjj2qlC51qk62SYeJ3xvjkJjsNro43scv4mcsCdmsVrABEP2hvrICfNI9KYHm5/+cPHeNGOP3HPNqGoF4q6Egdkp+UXAz0v/RwbdemdAZ4XWX0wGYL6ZAh4IvfbM+Hc9aPyBOuc131bEH9W1BlWPB/4IFwQC89B1U0c249e5p6TbsqyK/MYuExoTcfof/qzz7NiMUaxySyO9cDAYowhp3bHnW6u/0Xh5JtCYTSz9pQZoWRPATYTyg7QCnvjn0sAazWBAI8aW7L07ORdwz9FTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Jchdmft8pFeZkDehWGyUyMTzlL/Vfjf4OCtO4tDuw=;
 b=H9XIKxjzHSW9bUYLNRRwfre1j0862emGjcJzCY7Avs4iZg7MFG2k2WbX+C8kc3Ozc3W+MtKjG2vDxzbcq9kOoeul+dwAfAD92jq5aWV5s3xW/7Y8PMasd23ON0joUT4jAzCXeeLpbWpkdoPDStL5mMLOzdOcSuqTJC17umN+ZoM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 06:09:44 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83%4]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 06:09:43 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <Adham.Abozaeid@microchip.com>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Topic: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Index: AQHVYyVmBkghZ7w+IkiStodl6jvpxKccmquA
Date:   Thu, 5 Sep 2019 06:09:43 +0000
Message-ID: <da5ea898-d8da-a6e2-97a0-4662b7d70b31@microchip.com>
References: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::20) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57e7ad0c-de26-488f-38a0-08d731c7a533
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1874;
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1874B5B2757A8968549B351BE3BB0@BN6PR11MB1874.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(366004)(346002)(189003)(199004)(2501003)(4326008)(8936002)(478600001)(107886003)(26005)(53936002)(186003)(66476007)(66446008)(64756008)(66556008)(14444005)(6246003)(256004)(386003)(53546011)(6506007)(6486002)(99286004)(102836004)(2906002)(25786009)(486006)(66066001)(6436002)(446003)(11346002)(36756003)(6512007)(2616005)(476003)(229853002)(305945005)(76176011)(7736002)(52116002)(66946007)(316002)(31696002)(14454004)(6116002)(3846002)(81156014)(110136005)(71200400001)(31686004)(71190400001)(86362001)(2201001)(5660300002)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1874;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TEEFEyENXafLyPKZIRb72VzxYl+XUZLUh4vKyrtmMoBL/qORe9H9jCp8mGcGyjtzuyPj4JD+/+AJ0EYXOmnaEdEVqOGvnWJ4nUnRBp1/bQnSMytFLlKFc8mF+0MyLwr56MGYtgrmLgflqlZngQXqPfi+3NdFXrXNR+7FZ+yfrkhZROJe6OUU3i0hrSx1C8UxapPSH8j0quBYAriv/yIJ5CRhzFHxK4rYwSL+uqxte7EXfKGtiDWGcVHKo0bAOZOrJF5kbPApYCaBwmVju8IMTHnS7TlDBnWUcv8ol/y7En41HH4Vf75EaoBttjnJM2Jg4e5PXX6o1y7M5j19bHnfA4Gh13rPRi19E1yMmmULF2RTeRGmxKhN9+HQstq6ffq0qA/+CYmk0ruwQOUofnt4t8GxB/Wlct+FMpdNZnMxxt0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1968281029C28F489BDA2B9F8869A1F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e7ad0c-de26-488f-38a0-08d731c7a533
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 06:09:43.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8e8Mmu1qVXvHtaYUbNZALbHJVLf/Qb9PtuicowWY8eTi+2vDnC+lgqAQxGK+494/JVaTFJkGAjHISz2Efl25DRNVqeaA9cZnhtZLKT31RlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRXVnZW4sDQoNCk9uIDA0LVNlcC0xOSA3OjAzIFBNLCBFdWdlbiBIcmlzdGV2IC0gTTE4Mjgy
IHdyb3RlOg0KPiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5j
b20+DQo+IA0KPiBBZGQgYmluZGluZ3MgZm9yIG9wdGlvbmFsIHJ0YyBjbG9jayBwaW4uDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5j
b20+DQoNClRoYW5rcyBmb3Igc2VuZGluZyB0aGUgcGF0Y2ggc2VyaWVzLiBUaGUgY2hhbmdlcyBp
biB0aGlzIHNlcmllcyBsb29rcw0KZ29vZCB0byBtZS4NCg0KQWNrZWQtYnk6IEFqYXkgU2luZ2gg
PGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQoNCg0KUmVnYXJkcywNCkFqYXkNCg0KPiAtLS0N
Cj4gIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9taWNyb2NoaXAsd2lsYzEwMDAsc2Rpby50eHQg
fCA4ICsrKysrKystDQo+ICBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvbWljcm9jaGlwLHdpbGMx
MDAwLHNwaS50eHQgIHwgOCArKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL21pY3JvY2hpcCx3aWxjMTAwMCxzZGlvLnR4dCBiL2RyaXZlcnMvc3RhZ2luZy93
aWxjMTAwMC9taWNyb2NoaXAsd2lsYzEwMDAsc2Rpby50eHQNCj4gaW5kZXggNGY3ZDFjMi4uZGE1
MjM1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL21pY3JvY2hpcCx3
aWxjMTAwMCxzZGlvLnR4dA0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvbWljcm9j
aGlwLHdpbGMxMDAwLHNkaW8udHh0DQo+IEBAIC0xMCw3ICsxMCw5IEBAIFJlcXVpcmVkIHByb3Bl
cnRpZXM6DQo+ICANCj4gIE9wdGlvbmFsOg0KPiAgLSBidXMtd2lkdGgJOglOdW1iZXIgb2YgZGF0
YSBsaW5lcyB3aXJlZCB1cCB0aGUgc2xvdC4gRGVmYXVsdCAxIGJpdC4NCj4gLQ0KPiArLSBydGNf
Y2xrCToJQ2xvY2sgY29ubmVjdGVkIG9uIHRoZSBydGMgY2xvY2sgbGluZS4gTXVzdCBiZSBhc3Np
Z25lZA0KPiArCQkJYSBmcmVxdWVuY3kgd2l0aCBhc3NpZ25lZC1jbG9ja3MgcHJvcGVydHksIGFu
ZCBtdXN0IGJlDQo+ICsJCQljb25uZWN0ZWQgdG8gYSBjbG9jayBwcm92aWRlci4NCj4gIA0KPiAg
RXhhbXBsZXM6DQo+ICBtbWMxOiBtbWNAZmMwMDAwMDAgew0KPiBAQCAtMjQsNiArMjYsMTAgQEAg
bW1jMTogbW1jQGZjMDAwMDAwIHsNCj4gIAkJd2lsY19zZGlvQDAgew0KPiAgCQkJY29tcGF0aWJs
ZSA9ICJtaWNyb2NoaXAsd2lsYzEwMDAtc2RpbyI7DQo+ICAJCQlpcnEtZ3Bpb3MgPSA8JnBpb0Mg
MjcgMD47DQo+ICsJCQljbG9ja3MgPSA8JnBjazE+Ow0KPiArCQkJY2xvY2stbmFtZXMgPSAicnRj
X2NsayI7DQo+ICsJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JnBjazE+Ow0KPiArCQkJYXNzaWduZWQt
Y2xvY2stcmF0ZXMgPSA8MzI3Njg+Ow0KPiAgCQkJc3RhdHVzID0gIm9rYXkiOw0KPiAgCQkJcmVn
ID0gPDA+Ow0KPiAgCQkJYnVzLXdpZHRoID0gPDQ+Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL3dpbGMxMDAwL21pY3JvY2hpcCx3aWxjMTAwMCxzcGkudHh0IGIvZHJpdmVycy9zdGFn
aW5nL3dpbGMxMDAwL21pY3JvY2hpcCx3aWxjMTAwMCxzcGkudHh0DQo+IGluZGV4IDg3ZGI4N2Iu
LjM0MjM2OTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9taWNyb2No
aXAsd2lsYzEwMDAsc3BpLnR4dA0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvbWlj
cm9jaGlwLHdpbGMxMDAwLHNwaS50eHQNCj4gQEAgLTksNiArOSwxMCBAQCBSZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KPiAgLSByZWcJCQk6IENoaXAgc2VsZWN0IGFkZHJlc3Mgb2YgZGV2aWNlDQo+ICAt
IGlycS1ncGlvcwkJOiBDb25uZWN0IHRvIGEgaG9zdCBJUlENCj4gIA0KPiArT3B0aW9uYWw6DQo+
ICstIHJ0Y19jbGsJOglDbG9jayBjb25uZWN0ZWQgb24gdGhlIHJ0YyBjbG9jayBsaW5lLiBNdXN0
IGJlIGFzc2lnbmVkDQo+ICsJCQlhIGZyZXF1ZW5jeSB3aXRoIGFzc2lnbmVkLWNsb2NrcyBwcm9w
ZXJ0eSwgYW5kIG11c3QgYmUNCj4gKwkJCWNvbm5lY3RlZCB0byBhIGNsb2NrIHByb3ZpZGVyLg0K
PiAgDQo+ICBFeGFtcGxlczoNCj4gIA0KPiBAQCAtMjEsNiArMjUsMTAgQEAgc3BpMTogc3BpQGZj
MDE4MDAwIHsNCj4gIAkJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDQ4MDAwMDAwPjsNCj4gIAkJCXJl
ZyA9IDwwPjsNCj4gIAkJCWlycS1ncGlvcyA9IDwmcGlvQyAyNyAwPjsNCj4gKwkJCWNsb2NrcyA9
IDwmcGNrMT47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJydGNfY2xrIjsNCj4gKwkJCWFzc2lnbmVk
LWNsb2NrcyA9IDwmcGNrMT47DQo+ICsJCQlhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwzMjc2OD47
DQo+ICAJCQlzdGF0dXMgPSAib2theSI7DQo+ICAJCX07DQo+ICB9Ow0KPiANCg==
