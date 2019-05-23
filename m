Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD9427E2C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfEWNcn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 09:32:43 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:37014 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfEWNcn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 09:32:43 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,503,1549954800"; 
   d="scan'208";a="34165435"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 May 2019 06:32:42 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 23 May 2019 06:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXQzf1KR1m0hUezjv+c/snGMbZmrK3fOyZcizrn4AE8=;
 b=WcAcW0ifppYz/NlbkWnOE1bPN3SjGq8soVTGwD4Y4VvDzekm5bn5oNnXQbRiC5k+nBsNnQibvfaUlD+o1AIPTFxtRP7+UrzrgATkgtbJpX5QFu3wAh+/jgx7bbCGKKhFz/Hcuelh5iNoc8XRS06iVPaSWuYc9VpbM2dmZplxnUg=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB4052.namprd11.prod.outlook.com (10.255.129.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 23 May 2019 13:32:38 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::4cd5:b733:dc60:292f]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::4cd5:b733:dc60:292f%7]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 13:32:38 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 00/16] wilc1000: move out of staging
Thread-Topic: [PATCH 00/16] wilc1000: move out of staging
Thread-Index: AQHUwEbCCX3IcHjEkkah7YSVPvJ9TKYWSGkAgAABd3mAYw1+AA==
Date:   Thu, 23 May 2019 13:32:38 +0000
Message-ID: <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com>
References: <1549696298-9795-1-git-send-email-ajay.kathat@microchip.com>
 <5ac9d9bb-08e4-c46f-ce0a-40630e1d958e@microchip.com>
 <871s30pevc.fsf@codeaurora.org>
In-Reply-To: <871s30pevc.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0097.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::13)
 To BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.17.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b006dc00-9492-43a3-afa9-08d6df831f82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR11MB4052;
x-ms-traffictypediagnostic: BN6PR11MB4052:
x-microsoft-antispam-prvs: <BN6PR11MB4052BAC28C6CE83E3626BAF8E3010@BN6PR11MB4052.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(52116002)(66066001)(78486014)(486006)(76176011)(446003)(11346002)(229853002)(68736007)(6436002)(2616005)(476003)(71190400001)(71200400001)(14454004)(14444005)(36756003)(86362001)(5660300002)(256004)(316002)(72206003)(54906003)(81156014)(73956011)(66446008)(64756008)(66556008)(66476007)(81166006)(66946007)(305945005)(8936002)(8676002)(478600001)(7736002)(31696002)(6512007)(386003)(102836004)(25786009)(4326008)(6506007)(53546011)(26005)(6916009)(6486002)(31686004)(53936002)(2906002)(186003)(3846002)(6116002)(107886003)(99286004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4052;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1FJvI3ssUkOuPs5xt0j3nPSY45vLAIm4UCeeDOpqyeNupHZAzXrQiutMG99efZ0h8ljgLMB0HGrDxEpJnrRzK1IiszJtRAn75xGbOnXwO2mESQ5R7he1A4YOjDVfabo59Fzefh05SiSdvc2NvNpUetQ8/XZzCEy1jd9vlA3KbB+uIAjbz8RL4dA85TiIS1VMuVoAOnBrgbisKh1v6plgJPnr9QvQNUpZSFWshZ2LBrxvUmDFz0+LEKA4/V6kq2bA3mwGrkRKaFpm2PJM++x1Q4iPAHLgAmKj0OngvMLrXZQF81zlqD9eR30Or4iGcqcgFvcV8oNUEGZkbl8fetPEN/wxRw/+uW6+/YI8cgf44J1NsPqM/1tFEgj/ZSPf5oSDXoKaBftuVHgkbtgVxrH44MM5vd2FvD5l9ZZYItv4sqE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6AE4279F5729B45875A3DA7E562383B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b006dc00-9492-43a3-afa9-08d6df831f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 13:32:38.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4052
X-OriginatorOrg: microchip.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDMvMjEvMjAxOSA2OjI0IFBNLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiAN
Cj4gPEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20+IHdyaXRlczoNCj4gDQo+PiBIaSBLYWxsZS9K
b2hhbm5lcywNCj4+DQo+PiBPbiAyLzkvMjAxOSAxMjo0MiBQTSwgQWpheSBLYXRoYXQgLSBJMTU0
ODEgd3JvdGU6DQo+Pj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNv
bT4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIHRvIHJldmlldyBhbmQgbW92ZSB3aWxj
MTAwMCBkcml2ZXIgb3V0IG9mIHN0YWdpbmcuDQo+Pj4gSW1wbGVtZW50ZWQgdGhlIGluaXRpYWwg
cmVjZWl2ZWQgcmV2aWV3IGNvbW1lbnRzWzFdIGFuZCBzdWJtaXR0aW5nIHRoZQ0KPj4+IGRyaXZl
ciBhZ2Fpbi4gRHVyaW5nIHRoaXMgY2xlYW51cCBkZWxldGVkIGFyb3VuZCAzLjNrIGxpbmVzIG9m
IGNvZGUuDQo+Pj4NCj4+PiBCZWxvdyBhcmUgdGhlIG1ham9yIGl0ZW1zIGZpeGVkIGluIHJlY2Vu
dCBjbGVhbnVwOg0KPj4+ICAtIHJlbW92ZSB1c2Ugb2Ygc2hhZG93IGJ1ZmZlciB0byBrZWVwIHNj
YW4gcmVzdWx0Lg0KPj4+ICAtIHJlbW92ZSBpbnRlcm5hbCBtZXNzYWdpbmcgZmxvdyB0byBoYW5k
bGUgY2ZnODAyMTFfb3BzLg0KPj4+ICAtIG1ha2UgdXNlIG9mIGNmZzgwMjExIHByb3ZpZGVkIEFQ
SS4NCj4+PiAgLSB1c2Ugc3RydWN0dXJlIGZvciBwYWNraW5nIGZpcm13YXJlIGNvbW1hbmRzLg0K
Pj4+ICAtIG1ha2UgdXNlIG9mIGtlcm5lbCBwcm92aWRlZCBBUEkgYW5kIG1hY3Jvcy4NCj4+PiAg
LSByZW1vdmUgdW5uZWNlc3NhcnkgbG9ncyBtZXNzYWdlcy4NCj4+Pg0KPj4+IFBlbmRpbmcgYWN0
aW9uIGl0ZW06DQo+Pj4gIC0gZHluYW1pY2FsbHkgYWRkL3JlbW92ZSBwMnAgaW50ZXJmYWNlLg0K
Pj4+DQo+Pj4gIFRoaXMgaXRlbSB3aWxsIHRha2Ugc29tZSB0aW1lLCB3ZSBhcmUgcGxhbm5pbmcg
dG8gdGFrZSBpdCB1cCBhZnRlcg0KPj4+ICBtYWlubGluZS4NCj4+Pg0KPj4+ICBXZSBob3BlIGl0
IGNhbiBiZSBtb3ZlIG91dCBzdGFnaW5nIGluIHY1LjEuDQo+Pj4gIFBsZWFzZSByZXZpZXcgYW5k
IGNvbmZpcm0gaWYgaXQgaXMgZ29vZCB0byBtb3ZlIG91dC4NCj4+DQo+PiBEbyB5b3UgaGF2ZSBh
bnkgdXBkYXRlIGZvciB0aGlzIHNlcmllcy4gUGxlYXNlIHByb3ZpZGUgeW91ciBpbnB1dHMgZm9y
DQo+PiBuZXh0IHN0ZXAuDQo+IA0KPiBydHc4OCBpcyB0YWtpbmcgcHJpb3JpdHkgaW4gdGhlIG5l
dyBkcml2ZXJzICJxdWV1ZSIgc28gSSBkb3VidCBJIGNhbg0KPiB0YWtlIGEgbG9vayBhdCB0aGlz
IGluIHRoZSBuZXh0IGZldyB3ZWVrcy4NCj4gDQoNCklzIHRoZXJlIGFueSB1cGRhdGUgZm9yIHdp
bGMxMDAwIGRyaXZlciByZXZpZXcuIFBsZWFzZSBsZXQgbWUga25vdyB5b3VyDQppbnB1dHMuDQoN
ClJlZ2FyZHMsDQpBamF5DQo=
