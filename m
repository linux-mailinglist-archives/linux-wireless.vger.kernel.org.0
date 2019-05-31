Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF7307E3
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 06:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfEaExi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 00:53:38 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49348 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaExi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 00:53:38 -0400
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
X-IronPort-AV: E=Sophos;i="5.60,533,1549954800"; 
   d="scan'208";a="35544206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2019 21:53:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 21:53:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 30 May 2019 21:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm3MfTgxumNcOvYyaTou0ADK1aAPgK6i318BkcHhAEs=;
 b=m9ghrqISscYQrPY1cK06g/O4No7ONg/QWGfswApakpeR7oDL4gu5Anr2cPKGm6iqcXFnLokGqL7nm1Aq8AfWFTvm2JsyN4Z7WpNlKi0Y9AgI6DaQ7JWL2+8Tk3+rZ/14/eqxWFVI1VXoJTvgBMdPJzJPqzsXzLUHRfOQ8Enexxs=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB2049.namprd11.prod.outlook.com (10.173.31.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 31 May 2019 04:53:35 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 04:53:35 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 00/16] wilc1000: move out of staging
Thread-Topic: [PATCH 00/16] wilc1000: move out of staging
Thread-Index: AQHUwEbCCX3IcHjEkkah7YSVPvJ9TKYWSGkAgAABd3mAYw1+AIAADAJigAApwICAC8uXgA==
Date:   Fri, 31 May 2019 04:53:35 +0000
Message-ID: <8e227b89-6068-266c-f41d-1c45664d57d1@microchip.com>
References: <1549696298-9795-1-git-send-email-ajay.kathat@microchip.com>
 <5ac9d9bb-08e4-c46f-ce0a-40630e1d958e@microchip.com>
 <871s30pevc.fsf@codeaurora.org>
 <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com>
 <87sgt5cl8q.fsf@kamboji.qca.qualcomm.com>
 <fb17fb6b-08d2-6871-d214-2fbcc1da73fb@microchip.com>
In-Reply-To: <fb17fb6b-08d2-6871-d214-2fbcc1da73fb@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.18.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee89a8a-e309-40ae-d248-08d6e583f03b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB2049;
x-ms-traffictypediagnostic: BN6PR11MB2049:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB20495FA15AE1841B70D1EF53E3190@BN6PR11MB2049.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(66066001)(26005)(71200400001)(78486014)(6916009)(5640700003)(1730700003)(71190400001)(102836004)(478600001)(186003)(11346002)(6486002)(305945005)(99286004)(53936002)(316002)(486006)(6436002)(2351001)(2616005)(81166006)(86362001)(36756003)(476003)(229853002)(446003)(4326008)(2501003)(31696002)(81156014)(14454004)(52116002)(72206003)(8676002)(14444005)(76176011)(256004)(68736007)(3846002)(8936002)(6246003)(386003)(31686004)(5660300002)(6506007)(53546011)(66946007)(66556008)(66476007)(6512007)(64756008)(66446008)(6116002)(73956011)(966005)(54906003)(107886003)(2906002)(25786009)(6306002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2049;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CePpUra7LUXtkKyTXCov7G+vsx0ZBzTofnunwyQ472vXpfjK3ttZRNBImSxEmX4cUlCQAQiL0p9OzS39gTC3LIHnSQ2CkPjI7/+4AzeezNbgYVp4xsrdSFUJixYivEru/Yd8syCq3nVAXpqeh1KYYJ2sH+MFRbsGQ1ueU3Nyd0n2VlvPfkEqBdblo1u0TN3CBePJNnQNuCV9Z6ltt9vEl7GJMWLywyMNS105+FPU89fbyfOYHasf8cvLm1RGYmU3lZ+pTjFQkDlzeKfElxxlxF4Aq7iAeV/iUHfmZImgfE8XWtM2uMRtRLGvCtkkL32udptYC4Lk6Ez2/XNHcK3E9fvmo7HqHifx2uwe5YsrwFgqHmBmgDV6PLtQ8ageXxGzp/gdWNt1xVmpIgAaNLVo5+8GIREUF58BVcK7u8rABfA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BF31EE9415C8240AC42C35FC4317AB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee89a8a-e309-40ae-d248-08d6e583f03b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 04:53:35.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2049
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDUvMjMvMjAxOSAxMDoxNSBQTSwgQWpheS5LYXRoYXRAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4gSGkgS2FsbGUsDQo+IA0KPiBPbiA1LzIzLzIwMTkgNzo0MyBQTSwgS2Fs
bGUgVmFsbyB3cm90ZToNCj4+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tPiB3cml0ZXM6DQo+
Pg0KPj4+IEhpIEthbGxlLA0KPj4+DQo+Pj4gT24gMy8yMS8yMDE5IDY6MjQgUE0sIEthbGxlIFZh
bG8gd3JvdGU6DQo+Pj4+DQo+Pj4+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tPiB3cml0ZXM6
DQo+Pj4+DQo+Pj4+PiBIaSBLYWxsZS9Kb2hhbm5lcywNCj4+Pj4+DQo+Pj4+PiBPbiAyLzkvMjAx
OSAxMjo0MiBQTSwgQWpheSBLYXRoYXQgLSBJMTU0ODEgd3JvdGU6DQo+Pj4+Pj4gRnJvbTogQWph
eSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMg
cGF0Y2ggc2VyaWVzIGlzIHRvIHJldmlldyBhbmQgbW92ZSB3aWxjMTAwMCBkcml2ZXIgb3V0IG9m
IHN0YWdpbmcuDQo+Pj4+Pj4gSW1wbGVtZW50ZWQgdGhlIGluaXRpYWwgcmVjZWl2ZWQgcmV2aWV3
IGNvbW1lbnRzWzFdIGFuZCBzdWJtaXR0aW5nIHRoZQ0KPj4+Pj4+IGRyaXZlciBhZ2Fpbi4gRHVy
aW5nIHRoaXMgY2xlYW51cCBkZWxldGVkIGFyb3VuZCAzLjNrIGxpbmVzIG9mIGNvZGUuDQo+Pj4+
Pj4NCj4+Pj4+PiBCZWxvdyBhcmUgdGhlIG1ham9yIGl0ZW1zIGZpeGVkIGluIHJlY2VudCBjbGVh
bnVwOg0KPj4+Pj4+ICAtIHJlbW92ZSB1c2Ugb2Ygc2hhZG93IGJ1ZmZlciB0byBrZWVwIHNjYW4g
cmVzdWx0Lg0KPj4+Pj4+ICAtIHJlbW92ZSBpbnRlcm5hbCBtZXNzYWdpbmcgZmxvdyB0byBoYW5k
bGUgY2ZnODAyMTFfb3BzLg0KPj4+Pj4+ICAtIG1ha2UgdXNlIG9mIGNmZzgwMjExIHByb3ZpZGVk
IEFQSS4NCj4+Pj4+PiAgLSB1c2Ugc3RydWN0dXJlIGZvciBwYWNraW5nIGZpcm13YXJlIGNvbW1h
bmRzLg0KPj4+Pj4+ICAtIG1ha2UgdXNlIG9mIGtlcm5lbCBwcm92aWRlZCBBUEkgYW5kIG1hY3Jv
cy4NCj4+Pj4+PiAgLSByZW1vdmUgdW5uZWNlc3NhcnkgbG9ncyBtZXNzYWdlcy4NCj4+Pj4+Pg0K
Pj4+Pj4+IFBlbmRpbmcgYWN0aW9uIGl0ZW06DQo+Pj4+Pj4gIC0gZHluYW1pY2FsbHkgYWRkL3Jl
bW92ZSBwMnAgaW50ZXJmYWNlLg0KPj4+Pj4+DQo+Pj4+Pj4gIFRoaXMgaXRlbSB3aWxsIHRha2Ug
c29tZSB0aW1lLCB3ZSBhcmUgcGxhbm5pbmcgdG8gdGFrZSBpdCB1cCBhZnRlcg0KPj4+Pj4+ICBt
YWlubGluZS4NCj4+Pj4+Pg0KPj4+Pj4+ICBXZSBob3BlIGl0IGNhbiBiZSBtb3ZlIG91dCBzdGFn
aW5nIGluIHY1LjEuDQo+Pj4+Pj4gIFBsZWFzZSByZXZpZXcgYW5kIGNvbmZpcm0gaWYgaXQgaXMg
Z29vZCB0byBtb3ZlIG91dC4NCj4+Pj4+DQo+Pj4+PiBEbyB5b3UgaGF2ZSBhbnkgdXBkYXRlIGZv
ciB0aGlzIHNlcmllcy4gUGxlYXNlIHByb3ZpZGUgeW91ciBpbnB1dHMgZm9yDQo+Pj4+PiBuZXh0
IHN0ZXAuDQo+Pj4+DQo+Pj4+IHJ0dzg4IGlzIHRha2luZyBwcmlvcml0eSBpbiB0aGUgbmV3IGRy
aXZlcnMgInF1ZXVlIiBzbyBJIGRvdWJ0IEkgY2FuDQo+Pj4+IHRha2UgYSBsb29rIGF0IHRoaXMg
aW4gdGhlIG5leHQgZmV3IHdlZWtzLg0KPj4+Pg0KPj4+DQo+Pj4gSXMgdGhlcmUgYW55IHVwZGF0
ZSBmb3Igd2lsYzEwMDAgZHJpdmVyIHJldmlldy4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXINCj4+
PiBpbnB1dHMuDQo+Pg0KPj4gU28gaXMgdGhlIGRyaXZlciBpbiBnb29kIHNoYXBlIG5vdz8gSSBy
ZWFsbHkgZG8gbm90IHdhbnQgdG8gdXNlIGEgbG90IG9mDQo+PiB0aW1lIHJldmlld2luZyBpdCBq
dXN0IHRvIGZpbmQgb3V0IHRoYXQgdGhlcmUncyBhIGxvdCBvZiB3b3JrIHRvIGRvLiBGb3INCj4+
IGV4YW1wbGUsIGhhcyBzb21lb25lIGVsc2UgcmV2aWV3ZWQgaXQ/DQo+Pg0KPiANCj4gVGhlIGZp
cnN0IHNlcmllcyBmb3IgY29tcGxldGUgZHJpdmVyIHJldmlldyB3YXMgc3VibWl0dGVkIGVhcmxp
ZXIgWzFdLg0KPiBJdCB3YXMgcmV2aWV3ZWQgYnkgSm9oYW5uZXMgYW5kIGhlIGxvb2tlZCBpbnRv
IGRyaXZlciBpbnRlZ3JhdGlvbiB3aXRoDQo+IHRoZSBjZmc4MDIxMSBzdGFjayBwYXJ0LiBXZSB3
b3JrZWQgb24gdGhlIHJldmlldyBjb21tZW50cyBhbmQgc3VibWl0dGVkDQo+IHRoZSBjaGFuZ2Vz
IHRvIHN0YWdpbmcuDQo+IA0KPiBXZSBuZWVkIGZ1cnRoZXIgcmV2aWV3IHRvIGlkZW50aWZ5IGlm
IHRoZXJlIGlzIGFueSBibG9ja2VyIHRvIG1vdmUgdG8NCj4gbWFpbmxpbmUuDQo+IA0KPiBbMV0u
IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXdpcmVsZXNzL21zZzE3Nzg3OC5o
dG1sDQo+IA0KDQpKdXN0IGEgZ2VudGxlIG1haWwgdG8gY2hlY2sgaWYgd2lsYzEwMDAgZHJpdmVy
IGlzIHBpY2tlZC11cCBmb3IgcmV2aWV3DQphbmQgd2hhdCBpcyB0aGUgbmV4dCBzdGVwLg0KDQoN
ClJlZ2FyZHMsDQpBamF5DQo=
