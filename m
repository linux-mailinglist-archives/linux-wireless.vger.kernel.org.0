Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB631666D0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 20:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgBTTEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 14:04:52 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:34073 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgBTTEv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 14:04:51 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: OB9DxjCZOsBcRH9cvkLWXWUiNvu1mk6Z6z99/JXa97z8drtzHt90Lw6oVxUkjcBItDokgBcm26
 GOqIb53+mptn3zd47MsqHkZadza4ECNSWLJF7Q8PpnEDOXllFoQn6NzVWdtCLQJC8C9MD4rJGN
 BfBAqCGLugA15/9b08gnBvlle7rF9tDm5Rm7r1LbLXJh3BXTZd+bFHw/Lb+l5e58k+GNXT6jT2
 sfGn7TBWNHraVUtRPH1jhNPb9l2Hmi86YyZI9F2YOyCCJqujdz6lLa0hvslnlE2oYS4nXrv7rq
 OrA=
X-IronPort-AV: E=Sophos;i="5.70,465,1574146800"; 
   d="scan'208";a="69248648"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2020 12:04:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Feb 2020 12:04:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 20 Feb 2020 12:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPaUkPmBj9YowijBozXdeKq5iKeOa76j91KayCYkhxk5wojECPVXDT0Fzsp+eSPBpg4cNQzV4cFVvfWRH5UzmGDSzGAs+mm8jdL1RGGPjnHvBkgoeLE7aY+AaEUzpiF8Hfv8u6Ut9k3eUjVpWKaEzcbO59fyNEvTJzhRxl5iwUbHA8WcdPpRBzv6qS8U2w8vZBNMCVRtarNeYjiuTiOMEr1EHpbGvJja5t9fW3zM0FDvx++ReCzVziJDKyNoDfv6GgbbMll3j2Nc8KMU+thMvMtFY/EPAEISM9s9R18kLW789yz3VXDn1iSUEUcp3NruVRPGTZk5C/og6BXNt420yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYOKLtPBY/Co06AXlSbpquOge1WefiPZjIxbfbY/vog=;
 b=dibb1rjdRN/2fJ+IqqTAxjsSx+GDdmp03YwTYMt2I4pC2qLNc69YIaDCDGA+bPwLVpubR1+YhWhJ7Xz2IbmhSRVv4lX4+eJN3LzGmmc6zOOOr7vIFo2U2/E+S8oChdbXlBclrZQCOPee7LUV3AT3elkuhHDJPGskN20x5GjDVYHUSzwuLrrm4MGs3xiPLtSc9XEzVAhC5uMjrhcG1x99qxVv9FdlMmZYjDkae1ZeGoj607JyyqBio1rFRgViXkYA6TTtEbfrlAVFWfoAUOaBGlJPdf8+n7tmCcZWOEXzlJMXWiwiaWvzsUijStS1tSLrWVIqdNRwS5gl+ouo00IUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYOKLtPBY/Co06AXlSbpquOge1WefiPZjIxbfbY/vog=;
 b=XcMBzpIK4HmZHiimplzl6I4go8odCguxzSyzRqqWutRU8o57KBIJQT1R/1ypcGV3V/Szfw4vHzMjk8S2LYHGXmbV3tbPybuh3XI5y31SNmBIUm5NPGR8zRFiHyyr1I42kDm4ZGe3H73Cc7S29v5bIU4buug3GAZxrj/c/5Smdjg=
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (52.132.252.145) by
 BY5PR11MB4356.namprd11.prod.outlook.com (52.132.253.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Thu, 20 Feb 2020 19:04:48 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::a96e:2a4a:a7:7bf0]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::a96e:2a4a:a7:7bf0%3]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 19:04:48 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <gustavo@embeddedor.com>, <gregkh@linuxfoundation.org>,
        <vaibhav.sr@gmail.com>, <mgreer@animalcreek.com>,
        <johan@kernel.org>, <elder@kernel.org>, <m.tretter@pengutronix.de>,
        <kernel@pengutronix.de>, <mchehab@kernel.org>,
        <Larry.Finger@lwfinger.net>, <florian.c.schilhabel@googlemail.com>,
        <Ajay.Kathat@microchip.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <greybus-dev@lists.linaro.org>, <linux-media@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] staging: Replace zero-length array with flexible-array
 member
Thread-Topic: [PATCH] staging: Replace zero-length array with flexible-array
 member
Thread-Index: AQHV5/FisuIUszicxUSSYVUlxy5Pn6gkcUmA
Date:   Thu, 20 Feb 2020 19:04:48 +0000
Message-ID: <d331cd9c-ec57-b686-d977-c48e70415ae1@microchip.com>
References: <20200220132908.GA30501@embeddedor>
In-Reply-To: <20200220132908.GA30501@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-originating-ip: [198.175.253.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee8c7169-2b0e-4af4-6e23-08d7b637c19b
x-ms-traffictypediagnostic: BY5PR11MB4356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4356D4162B675A7A8A62DE018D130@BY5PR11MB4356.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(478600001)(186003)(966005)(76116006)(86362001)(5660300002)(26005)(2906002)(66556008)(31696002)(66946007)(66476007)(66446008)(53546011)(6506007)(64756008)(31686004)(2616005)(4326008)(81156014)(81166006)(6512007)(8676002)(6486002)(71200400001)(54906003)(7416002)(8936002)(316002)(110136005)(36756003)(6636002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4356;H:BY5PR11MB4306.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ak/YAiaRyGRA5FAR8zXrIgRanNQuz8ug54nJT9mJkjUNPw7Eb8ChlyBSEz4WMIXXPjZYebiIxWuZCq5aWsaGB+ku4g4fCyiwjh+WR8yhaIIvuvEgNDxI3gpoFzpn5+uEOdtpBw0GWxma4CCLFHhtkR2YYR1SE5N+wOVnuoTr9trlY92tEcZcWilferCtn5slod/LbYmnyu+5OoNaQtvw3Su1wckb2nSn5o1pbXY1SWoDxtINa1C7CV2SEkzoSJkaV/xbwKXt20rUX2IQJpfZoc196CDkD+fKPvRF4z1KipXyT2JG7gVPcirBHD6odCi78JhvvaA9Y75W6FWfYVQOGwZChrGFt/hDy+Y/cHVpLrfyR5S+o4cq6rfLyWJlweh4IsinDow6AJZnQqoIX3IbK9ZdMgbv41P66R9cBGHtCmWtsezY7S2jG/MI/khNP8J+0iYohEEhBS4VneUv3GsOX/3Xxw5hnr8HWMmt8CgVW1rJyQPXC0jKgO5mOhnTvfFlJH/WxORqMRDsf+7McPrZzYJjNod357WAURwQBkFu4/uiLgcWoM4v4KbCzG8yz8WhPvTc4S6Pfzx96B4I8rqdTw==
x-ms-exchange-antispam-messagedata: s2e5bVvWSNMSvF23POdscdaNpv3GjWtToHPCTCJ/2UY+3PcVOTZs4CxbR90h1LQPoAJphw3m40xVWm+lJWfZvg2oQiFYmfDZLZLEjw4bBTHJAWmh5+KQ+lsdFSqvsz0zupGjLwRBl4nRtLILQzk3WQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A67F79FF2067B34FBA073A18D0F5673C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8c7169-2b0e-4af4-6e23-08d7b637c19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 19:04:48.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9js7nio4/uHbNu0aD86A3IHpj2ZrgVy7LSUNo2F1XvCKOYLAuGTkY+2KGHajrSKgJ0/393KZIWdai3vGlOs2SCYkNICReA+KoyHkGRQU/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4356
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR3VzdGF2bw0KDQpPbiAyLzIwLzIwIDY6MjkgQU0sIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3Jv
dGU6DQo+IFRoZSBjdXJyZW50IGNvZGViYXNlIG1ha2VzIHVzZSBvZiB0aGUgemVyby1sZW5ndGgg
YXJyYXkgbGFuZ3VhZ2UNCj4gZXh0ZW5zaW9uIHRvIHRoZSBDOTAgc3RhbmRhcmQsIGJ1dCB0aGUg
cHJlZmVycmVkIG1lY2hhbmlzbSB0byBkZWNsYXJlDQo+IHZhcmlhYmxlLWxlbmd0aCB0eXBlcyBz
dWNoIGFzIHRoZXNlIG9uZXMgaXMgYSBmbGV4aWJsZSBhcnJheSBtZW1iZXJbMV1bMl0sDQo+IGlu
dHJvZHVjZWQgaW4gQzk5Og0KPg0KPiBzdHJ1Y3QgZm9vIHsNCj4gICAgICAgICBpbnQgc3R1ZmY7
DQo+ICAgICAgICAgc3RydWN0IGJvbyBhcnJheVtdOw0KPiB9Ow0KPg0KPiBCeSBtYWtpbmcgdXNl
IG9mIHRoZSBtZWNoYW5pc20gYWJvdmUsIHdlIHdpbGwgZ2V0IGEgY29tcGlsZXIgd2FybmluZw0K
PiBpbiBjYXNlIHRoZSBmbGV4aWJsZSBhcnJheSBkb2VzIG5vdCBvY2N1ciBsYXN0IGluIHRoZSBz
dHJ1Y3R1cmUsIHdoaWNoDQo+IHdpbGwgaGVscCB1cyBwcmV2ZW50IHNvbWUga2luZCBvZiB1bmRl
ZmluZWQgYmVoYXZpb3IgYnVncyBmcm9tIGJlaW5nDQo+IGluYWR2ZXJ0ZW50bHkgaW50cm9kdWNl
ZFszXSB0byB0aGUgY29kZWJhc2UgZnJvbSBub3cgb24uDQo+DQo+IEFsc28sIG5vdGljZSB0aGF0
LCBkeW5hbWljIG1lbW9yeSBhbGxvY2F0aW9ucyB3b24ndCBiZSBhZmZlY3RlZCBieQ0KPiB0aGlz
IGNoYW5nZToNCj4NCj4gIkZsZXhpYmxlIGFycmF5IG1lbWJlcnMgaGF2ZSBpbmNvbXBsZXRlIHR5
cGUsIGFuZCBzbyB0aGUgc2l6ZW9mIG9wZXJhdG9yDQo+IG1heSBub3QgYmUgYXBwbGllZC4gQXMg
YSBxdWlyayBvZiB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gb2YNCj4gemVyby1sZW5ndGgg
YXJyYXlzLCBzaXplb2YgZXZhbHVhdGVzIHRvIHplcm8uIlsxXQ0KPg0KPiBUaGlzIGlzc3VlIHdh
cyBmb3VuZCB3aXRoIHRoZSBoZWxwIG9mIENvY2NpbmVsbGUuDQo+DQo+IFsxXSBodHRwczovL2dj
Yy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL1plcm8tTGVuZ3RoLmh0bWwNCj4gWzJdIGh0dHBzOi8v
Z2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy8yMQ0KPiBbM10gY29tbWl0IDc2NDk3NzMyOTMy
ZiAoImN4Z2IzL2wydDogRml4IHVuZGVmaW5lZCBiZWhhdmlvdXIiKQ0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KPg0KPiAg
c3RhdGljIHZvaWQgY2ZnX3NjYW5fcmVzdWx0KGVudW0gc2Nhbl9ldmVudCBzY2FuX2V2ZW50LA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3NwaS5jIGIvZHJpdmVycy9z
dGFnaW5nL3dpbGMxMDAwL3NwaS5jDQo+IGluZGV4IDQ0ZjdkNDg4NTFiNS4uMTE2NTNhYzExOGNk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvc3BpLmMNCj4gKysrIGIv
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3NwaS5jDQo+IEBAIC0xMzksNyArMTM5LDcgQEAgc3Ry
dWN0IHdpbGNfc3BpX3JlYWRfcnNwX2RhdGEgew0KPiAgICAgICAgIHU4IHN0YXR1czsNCj4gICAg
ICAgICB1OCByZXNwX2hlYWRlcjsNCj4gICAgICAgICB1OCByZXNwX2RhdGFbNF07DQo+IC0gICAg
ICAgdTggY3JjWzBdOw0KPiArICAgICAgIHU4IGNyY1tdOw0KPiAgfSBfX3BhY2tlZDsNCm1vcmUg
emVyby1sZW5ndGggYXJyYXlzIGluIHdpbGMxMDAwLCBzcGkuYywgc3RydWN0IHdpbGNfc3BpX2Nt
ZCwgYW5kIGluIGZ3Lmg=
