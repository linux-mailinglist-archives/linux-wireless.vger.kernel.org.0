Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF671177649
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 13:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgCCMpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 07:45:40 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39119 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgCCMpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 07:45:39 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0ELipmSpY0yuRvaB9U0IIrLeOSNRooDud7yjFirf26spJA+WmqE50oR1k9DZ7uJ0hs7JOSQPdc
 7RMS/ltBjGngUfF3Lzs3pXvLHIQ/9T6MTNGQAFyMyigyi0TSRsHYn0w9e5QDIupnHDzb3d/oqM
 pWYBtC11OHKu7Xhgsatoe76RpmgfpfgbQAv9i2+DD7/DNdnr9xTlzcDca/ry2alOGisGD3YlM8
 yCZ2qb0dIxbsZvv0lVdBDX1Dyvtrv9BXdb9k0Yjy8/HiDK4WLmV7yXHCZBJdCmfeL9qemsbygw
 o90=
X-IronPort-AV: E=Sophos;i="5.70,511,1574146800"; 
   d="scan'208";a="67700019"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2020 05:45:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Mar 2020 05:45:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 3 Mar 2020 05:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOWXmUalM6HMx3h5N9gGh0bl5GXNr3JrRWdPGtjre0ifk/9iFw6o6NfbRgwrY9ckwXVXJTKkkjGt0d/Y2gDJinjOITfE77FkcHITAhWsssDDvCHwacep4sUg3I9zZIfvDQL8AlcGTUrD7rijM1Y3NBg5CzvRfs/CCAPClesoUvmw//fnZUllYCqP2m/HRe/PG0P9DJcpcW0mz3F08jWWquqavSOleBJnrkOcG+BmMva13TYqE/luQS9Tj3FGpW6tevT5dCU0jUN6h9X18yXN6rXclJ7ARDG/Bf/2uiG788qFPOew3XCJMYqm9ZvbbNz4KAj020W9PLhWK8o+Zssvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxvc+zHjkHf/FXX1fc+LF33SgT1Z8D90I0RNo83tpwY=;
 b=JyvmyVH9Xmdrw+HOdcl+DdwbMIGGIXoTWeRfmILZl5MuIfj7mRWaz1OXiK57bWlLOJtG41W5R4hbZITI8N8Ry96emTadIRNJhmPq/HoeTnLH325Bld3/ND8LGG0s1o8E7Z9vq+m5WSQhSB8KJcxuoGR3yu11nVsM/GmxZwbs4IRV0GKqAa56F3QNFz1V0y28hPAJmWi1KLXBUSxoahcAssJzCTDJfQZX1I3DCheaR1//J4Ac1l/mZ5sEikLdOmhz3Hx5flKmD1zM8KATJwzUX7PvRRtX3gQBELtP7rd/f0VU8clZ2V3SVrIOwVuFHUSpwDdQXnlqlW8KETnNmbhH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxvc+zHjkHf/FXX1fc+LF33SgT1Z8D90I0RNo83tpwY=;
 b=Lv4RRlJddPBfXJwiPR2kjzLPiFiLpPvVOgoF1RR2BdJLrHz2DJxfM358MgGPkQOwMN7lDffujyy/+cL61JV7zRlJc00P/3hM3EYP1ZFymSRDr0dSjmIyOE58TElxEAoxx9h6HyK8TE7bnw9WkjmiLuEjmbXmN2NMxXt5kwvSFmM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1380.namprd11.prod.outlook.com (2603:10b6:404:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 12:45:36 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 12:45:36 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Venkateswara.Kaja@microchip.com>
Subject: Re: [PATCH v4 17/18] dt: bindings: net: add
 microchip,wilc1000,spi.yaml
Thread-Topic: [PATCH v4 17/18] dt: bindings: net: add
 microchip,wilc1000,spi.yaml
Thread-Index: AQHV8LB4yeo407y5WkaMy3sgQWSapKg2HjYAgACzr4A=
Date:   Tue, 3 Mar 2020 12:45:36 +0000
Message-ID: <e24e24b9-f099-88f7-b7bd-ed53bf0a6a9d@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
 <20200302163414.4342-18-ajay.kathat@microchip.com>
 <20200303020230.GA15543@bogus>
In-Reply-To: <20200303020230.GA15543@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 747839f3-e314-44c4-a20c-08d7bf70c580
x-ms-traffictypediagnostic: BN6PR11MB1380:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1380DE10BB05F727B237C839E3E40@BN6PR11MB1380.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(2906002)(81166006)(81156014)(6486002)(6916009)(6512007)(31686004)(966005)(8936002)(478600001)(31696002)(6506007)(8676002)(86362001)(36756003)(26005)(91956017)(53546011)(186003)(316002)(66476007)(64756008)(66446008)(54906003)(5660300002)(76116006)(66946007)(66556008)(4326008)(2616005)(71200400001)(107886003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1380;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbbudKWTW787spHnz0XTOYF7ryYrIy9IMGlp3zNphnUE8+nQbUih5w8Se3yVouNi80wmN+KgNT6qHrr2TlammR09zq5EdvSRITuIjOVDdmnZ55303U3slRvw3lNM/rcaqNki1fMyXNmJLZaWZIpIYUNY7cRh0zaCZAkFNuKv/oluGvaMY5wW0SFktVbBq/zqUE24KRyPm1uqYK8SbXj+fjUwHU5/5r4ALhprlVv67IvfxMRCxYUP+3h58zRPsQEUGAKO8LGWqDLivfvNLBSY+Kj8LcdXwEKmibGm3Zs+R/LFAFmL65YTmNSfoNFNxlYpmMdiXPWZuMpsVMCUUvzMsSlDIJfcGK8CUovWn6PO+aEO06f3mIcrrJdP6Su6XxSVRokWtK5PTXmVLd3YnrxHQ1cgocQnj4CZCLN8xbrU6TgD0+OPFvqGxHkuCYR0fvV4AZKv0fiLxwfvc4gdFZeD6lUbTbTkd7zcIrwlqqCyTtUG8w8UD4OaUcU6so/z1/+0heawmeGnqLdWD/Hk7rG5+YX+izVc64wCfiJ7av3WAAdeYQwZuroFesCC3f1pPWfx
x-ms-exchange-antispam-messagedata: w8YuVjzDixL46zB0QapalQuNwPq/oBCgAE1HBJugbDmbcSGbcg01yxrYeyblT0sPRvpUYmvNhRNc6Bou4vSo8+RuoaXAYIjszbRmXJCjoufmWowpmfALiLRARyfEJaFrlxs9tpSOhBkCsOHXWsLsVQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <35748BA7943C354FB3709C6521823519@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 747839f3-e314-44c4-a20c-08d7bf70c580
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 12:45:36.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9d74sUcEi2WlgXk9yokS4qxkY4Da2+2UYgNJ5y7kEmPqUjgYQ9x+i6KbHXtFqkMH3HOc/LJkjDjpeKWt20XuhO8m+O3q2WRzqPgGGDwHqaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1380
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDAzLzAzLzIwIDc6MzIgYW0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiANCj4gT24gTW9u
LCBNYXIgMDIsIDIwMjAgYXQgMDQ6MzQ6NDBQTSArMDAwMCwgQWpheS5LYXRoYXRAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEZyb206IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5j
b20+DQo+Pg0KPj4gTW92ZWQgJy9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvL21pY3JvY2hpcCx3
aWxjMTAwMCxzcGkueWFtbCcgdG8NCj4+ICdEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L3dpcmVsZXNzL21pY3JvY2hpcCx3aWxjMTAwMCxzcGkueWFtbCcuDQo+IA0KPiBOb3Qg
YSB1c2VmdWwgY2hhbmdlbG9nLg0KPiANCg0KU3VyZS4gSSB3aWxsIHVwZGF0ZSB0aGUgY2hhbmdl
bG9nLg0KDQo+IEkgdGhpbmsgdGhpcyBzaG91bGQgYmUgY29tYmluZWQgd2l0aCB0aGUgU0RJTyB2
ZXJzaW9uLiBEZXRhaWxzIGJlbG93Lg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBamF5IFNp
bmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgLi4uL25ldC93aXJl
bGVzcy9taWNyb2NoaXAsd2lsYzEwMDAsc3BpLnlhbWwgIHwgNjEgKysrKysrKysrKysrKysrKysr
Kw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWlj
cm9jaGlwLHdpbGMxMDAwLHNwaS55YW1sDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwLHdpbGMxMDAwLHNw
aS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9t
aWNyb2NoaXAsd2lsYzEwMDAsc3BpLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwMDAwMDAuLmNjOGVkNjRjZTYyNw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC93aXJlbGVzcy9taWNyb2No
aXAsd2lsYzEwMDAsc3BpLnlhbWwNCj4+IEBAIC0wLDAgKzEsNjEgQEANCj4+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFN
TCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL25l
dC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAsc3BpLnlhbWwjDQo+PiArJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0
bGU6IE1pY3JvY2hpcCBXSUxDIHdpcmVsZXNzIFNQSSBkZXZpY2V0cmVlIGJpbmRpbmdzDQo+PiAr
DQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIEFkaGFtIEFib3phZWlkIDxhZGhhbS5hYm96YWVp
ZEBtaWNyb2NoaXAuY29tPg0KPj4gKyAgLSBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2No
aXAuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgVGhlIHdpbGMxMDAwIGNoaXBz
IGNhbiBiZSBjb25uZWN0ZWQgdmlhIFNQSS4gVGhpcyBkb2N1bWVudCBkZXNjcmliZXMNCj4+ICsg
IHRoZSBiaW5kaW5nIGZvciB0aGUgU1BJIGNvbm5lY3RlZCBtb2R1bGUuDQo+PiArDQo+PiArcHJv
cGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGNvbnN0OiBtaWNyb2NoaXAsd2ls
YzEwMDAtc3BpDQo+IA0KPiBZb3UgY2FuIGRyb3AgJy1zcGknIChhbmQgJy1zZGlvJykuIFRoZXkg
ZG9uJ3QgbmVlZCB0byBiZSBkaWZmZXJlbnQNCj4gYmVjYXVzZSB0aGV5IGFscmVhZHkgc2l0IG9u
IGRpZmZlcmVudCBidXNlcy4NCj4gDQoNCkluIHRoYXQgY2FzZSwgd2Ugc2hvdWxkIHVzZSBvbmx5
IGEgc2luZ2xlIERUIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBhbmQNCmtlZXAgYm90aCBleGFtcGxl
IGluc2lkZSB0aGUgc2FtZSBmaWxlIGkuZSBXZSB3aWxsIGhhdmUgc2luZ2xlDQpwcm9wZXJ0aWVz
IGRlc2NyaXB0aW9ucyB3aXRoIDIgZXhhbXBsZXMoc2Rpby9zcGkpIGluIGEgc2luZ2xlIERUIGJp
bmRpbmcNCmRvY3VtZW50LiBJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/DQoNCj4+ICsNCj4+
ICsgIHNwaS1tYXgtZnJlcXVlbmN5Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogTWF4aW11bSBTUEkg
Y2xvY2tpbmcgc3BlZWQgb2YgZGV2aWNlIGluIEh6Lg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4g
Kw0KPj4gKyAgcmVnOg0KPj4gKyAgICBkZXNjcmlwdGlvbjogQ2hpcCBzZWxlY3QgYWRkcmVzcyBv
ZiBkZXZpY2UuDQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpcnEtZ3Bpb3M6DQo+
PiArICAgIGRlc2NyaXB0aW9uOiBUaGUgR1BJTyBwaGFuZGxlIGNvbm5lY3QgdG8gYSBob3N0IElS
US4NCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNsb2NrczoNCj4+ICsgICAgZGVz
Y3JpcHRpb246IHBoYW5kbGUgdG8gdGhlIGNsb2NrIGNvbm5lY3RlZCBvbiBydGMgY2xvY2sgbGlu
ZS4NCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29t
cGF0aWJsZQ0KPj4gKyAgLSBzcGktbWF4LWZyZXF1ZW5jeQ0KPiANCj4gVGhpcyBzaG91bGQgbm90
IGJlIHJlcXVpcmVkLg0KPiANCg0KT2suIEkgd2lsbCBkcm9wIHRoaXMuDQoNCj4+ICsgIC0gcmVn
DQo+PiArICAtIGlycS1ncGlvcw0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiAr
ICAgIHNwaTE6IHNwaUBmYzAxODAwMCB7DQo+PiArICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+PiArICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+PiArICAgICAgY3MtZ3Bpb3MgPSA8JnBp
b0IgMjEgMD47DQo+PiArICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4gKyAgICAgIHdpbGNfc3Bp
QDAgew0KPj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsd2lsYzEwMDAtc3BpIjsN
Cj4+ICsgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDQ4MDAwMDAwPjsNCj4+ICsgICAgICAg
IHJlZyA9IDwwPjsNCj4+ICsgICAgICAgIGlycS1ncGlvcyA9IDwmcGlvQyAyNyAwPjsNCj4+ICsg
ICAgICAgIGNsb2NrcyA9IDwmcGNrMT47DQo+PiArICAgICAgICBjbG9jay1uYW1lcyA9ICJydGNf
Y2xrIjsNCj4gDQo+IE5vdCBkb2N1bWVudGVkLiAnX2NsaycgaXMgcmVkdW5kYW50Lg0KPiANCg0K
T2suIEkgd2lsbCB1cGRhdGUgdGhlIGNsb2NrLW5hbWVzIGFuZCBhZGQgdGhlIGRlc2NyaXB0aW9u
Lg0KDQo+PiArICAgICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JnBjazE+Ow0KPj4gKyAgICAgICAg
YXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MzI3Njg+Ow0KPiANCj4gTm90IGRvY3VtZW50ZWQuDQo+
IA0KDQpPay4gSSB3aWxsIGFkZCB0aGUgZGVzY3JpcHRpb24uDQoNCg0KUmVnYXJkcywNCkFqYXk=
