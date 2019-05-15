Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1F1FA51
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEOTI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 15:08:57 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:31463
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbfEOTI5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 15:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bowerswilkins.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hntLkJMhwM4hkzqBfWhnbannNEOpGGgC5nNM7gZLwLM=;
 b=EEkzgYNhQdnAisSgzVqZw32nu/pY4ptgk6EBiNlLNhdnvE5/kSJRmZdCq5WPnJbO01tRufEquVD/hfQwqk7CoCvIxRfp+tHQaW5TScbUqTRzObKTrLKbeBufEimJ4cQhU15p/DpisXy3gbC1ZjXnKzXgjBtu8yKcqBagfbicZN8=
Received: from AM0PR04MB6065.eurprd04.prod.outlook.com (20.179.32.150) by
 AM0PR04MB6162.eurprd04.prod.outlook.com (20.179.36.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 19:08:54 +0000
Received: from AM0PR04MB6065.eurprd04.prod.outlook.com
 ([fe80::485d:efe5:102e:2989]) by AM0PR04MB6065.eurprd04.prod.outlook.com
 ([fe80::485d:efe5:102e:2989%3]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 19:08:54 +0000
From:   Peter Oh <peter.oh@bowerswilkins.com>
To:     Seth Forshee <seth.forshee@canonical.com>, suchan <abnoeh@mail.com>
CC:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [wireless-regdb] [PATCH v2] wireless-regdb: Update regulatory
 rules for South Korea
Thread-Topic: [wireless-regdb] [PATCH v2] wireless-regdb: Update regulatory
 rules for South Korea
Thread-Index: AQHU/HdqZsgsxQxLTEqJEz6hK6qIkKZsREuAgAAjYACAABP2AIAALrIA
Date:   Wed, 15 May 2019 19:08:54 +0000
Message-ID: <75c8361c-616b-314f-5efe-6092ca43ac11@bowerswilkins.com>
References: <1556314283-17842-1-git-send-email-peter.oh@bowerswilkins.com>
 <20190515130339.GY4357@ubuntu-xps13>
 <a2fa616d-7829-137c-7f48-6c59974cfa46@mail.com>
 <20190515162142.GC4357@ubuntu-xps13>
In-Reply-To: <20190515162142.GC4357@ubuntu-xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::35) To AM0PR04MB6065.eurprd04.prod.outlook.com
 (2603:10a6:208:139::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.oh@bowerswilkins.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.244.182.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 447a3cd8-c840-4f67-dafe-08d6d968c5d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR04MB6162;
x-ms-traffictypediagnostic: AM0PR04MB6162:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB61622DB538CB52F128825F1499090@AM0PR04MB6162.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(81166006)(81156014)(305945005)(71200400001)(2906002)(71190400001)(8676002)(11346002)(2616005)(186003)(446003)(102836004)(53546011)(6116002)(3846002)(8936002)(14454004)(52116002)(36756003)(256004)(44832011)(68736007)(4326008)(966005)(476003)(110136005)(54906003)(486006)(6506007)(386003)(76176011)(99286004)(25786009)(7736002)(6512007)(66556008)(229853002)(6306002)(66476007)(73956011)(66946007)(5660300002)(66066001)(316002)(53936002)(26005)(6246003)(478600001)(86362001)(64756008)(31696002)(66446008)(31686004)(6486002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6162;H:AM0PR04MB6065.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: bowerswilkins.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g1God7HOOhMQ0IJ4QBPTXkzpnNfibXZplUSWpl/njnqlm5VHGBI2D2HWDpjqN+R5u12+aEep/YnYWVPnLAHaZBTajOidtGFj0NZmFRtsLjzmECq6aJnu4r0xjpiMW9HjYPNzEy535VZBfrWeuddMzksmCCbmBH3/sgJI9dmnqV02u5YAmKYrilvybl66Ij5mTmC2DZUQDnS/w6a1UzklwbjeHMdt2bzCIm2Y2vUNHBeL6whggWht6xIp0wrfgdQxszZPBmuavrGHAQnTor+sIGl3ssswcAQoPyJTsR3B/Ug4oNaTj98eaDt+sodNHXPPsPnyZyaGBsVZ4dQz0fCOKMyn/NAvvoLeWPfjBZucMH0cXKy98VhOiUbQXXZfegnztoeKvWQFLvhVwe0RejbyfKG1y+9s42Z+RCM+VZ1vbfE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8968AA5363F148418B2445075064D949@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bowerswilkins.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447a3cd8-c840-4f67-dafe-08d6d968c5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 19:08:54.1033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a75a45bb-4772-448f-a2c6-9d2413d86410
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6162
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDA1LzE1LzIwMTkgMDk6MjEgQU0sIFNldGggRm9yc2hlZSB3cm90ZToNCj4gWW91IGRy
b3BwZWQgUGV0ZXIgYW5kIHRoZSBsaW51eC13aXJlbGVzcyBsaXN0IGZyb20geW91ciByZXBseSwg
YWRkaW5nDQo+IHRoZW0gYmFjay4NCj4NCj4gT24gVGh1LCBNYXkgMTYsIDIwMTkgYXQgMTI6MTA6
MTZBTSArMDkwMCwgc3VjaGFuIHdyb3RlOg0KPj4gMjAxOS0wNS0xNSAxMDowM1BNIGF0IFNldGgg
Rm9yc2hlZSB3cm90ZToNCj4+PiBJcyB0aGVyZSBhbnkgbWVudGlvbiBvZiB0cmFuc21pdCBwb3dl
ciBjb250cm9sIGluIHRoZSBkb2N1bWVudD8gVGhlIGZhY3QNCj4+PiB0aGF0IHNvbWUgb2YgdGhl
IG9sZCBsaW1pdHMgYXJlIGV4YWN0bHkgaGFsZiBvZiB0aGV5IHZhbHVlcyB5b3UndmUgZ2l2ZW4N
Cj4+PiBtYWtlcyBtZSB3b25kZXIgaWYgdGhleSB3ZXJlbid0IHNldCBsb3dlciBmb3IgVFBDLCBl
c3BlY2lhbGx5IGZvcg0KPj4+IDUyNTAtNTM1MCBNSHogd2hlcmUgVFBDIGlzIGNvbW1vbi4NCj4+
Pg0KPj4+IFNpbmNlIHlvdSdyZSBjaGFuZ2luZyB0aGVzZSBydWxlcywgSSdkIGFsc28gbGlrZSB0
byBzZWUgdGhlIGZyZXF1ZW5jeQ0KPj4+IHJhbmdlcyBjaGFuZ2VkIHRvIG1hdGNoIHRoZSBkb2N1
bWVudGVkIHJhbmdlcywgaS5lLjoNCj4+Pg0KPj4+ICAgIDI0MDAgLSAyNDgzLjUNCj4+PiAgICA1
MTUwIC0gNTI1MA0KPj4+ICAgIDUyNTAgLSA1MzUwDQo+Pj4gICAgNTQ3MCAtIDU3MTANCj4+PiAg
ICA1NzM1IC0gNTg1MA0KPj4+DQo+Pj4gSSBsZWZ0IHRoZSBnYXAgaW4gdGhlIDU0NzAtNTg1MCBN
SHogcmFuZ2Ugc2luY2UgSSBjYW4ndCB0ZWxsIGV4YWN0bHkNCj4+PiB3aGVyZSB0aGUgREZTIHJl
cXVpcmVtZW50IGVuZHMuIFVzdWFsbHkgaXQgc2VlbXMgdG8gYmUgNTcyNSBNSHosIGJ1dA0KPj4+
IHRoYXQgaXMgbm90IHVuaXZlcnNhbC4gSWYgeW91IGNhbiBkZXRlcm1pbmUgd2hlcmUgdGhlIGJy
ZWFrIGlzIHRob3NlDQo+Pj4gcmFuZ2VzIGNvdWxkIGFsc28gYmUgZXhwYW5kZWQuDQo+Pj4NCj4+
PiBUaGFua3MsDQo+Pj4gU2V0aA0KPj4+DQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCj4+PiB3aXJlbGVzcy1yZWdkYiBtYWlsaW5nIGxpc3QNCj4+
PiB3aXJlbGVzcy1yZWdkYkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby93aXJlbGVzcy1yZWdkYg0KPj4gZnJvbSBzYW1l
IGRvY3VtZW50LCBqdXN0IHVuZGVyIHRoZSB0YWJsZSBmb3Igd2lmaSByYW5nZSBpdHNlbGYgNTI1
MOKIvDUzNTANCj4+IE1IeiBhbmQgNTQ3MOKIvDU3MjUgTUh6IG5lZWQgVFBDIGFuZCBERlMNCj4+
DQo+PiBUUEMgcnVsZSBpcyBpZiBwb3dlciBleGNlZWRzIDI1bVcvTUh6ICh0aGlzIGluY2x1ZGVz
IGFudGVubmEgZ2FpbiksIGl0DQo+PiBoYXMgZG8gYmUgYWJsZSB0byByZWR1Y2UgaXQgdW5kZXIg
MTIuNW1XL01oei4NCj4+DQo+PiBERlMgcnVsZSBpdHNlbGYgKERGUy1KUCkgbG9va3MgcmlnaHQu
DQpERlMgYmFuZHdpZHRoIGlzIGNvcnJlY3QgYWx0aG91Z2ggdGhlIHJ1bGVzKHJhZGFyIHR5cGVz
IGFuZCBldGMuKSBhcmUgDQpkaWZmZXJlbnQgZnJvbSBKUCwgYnV0IG5vIHBsYW4geWV0IHRvIGFk
ZCBLUiBydWxlcyB0byBERlMgKHJlcXVpcmVzIA0Ka2VybmVsIHNwYWNlIHBhdGNoZXMpLg0KPiBU
aGFua3MhIEJhc2VkIG9uIHRoYXQgSSB0aGluayB0aGlzIGlzIHByb2JhYmx5IHdoYXQgd2UgbmVl
ZDoNCj4NCj4gICAoMjQwMCAtIDI0ODMuNSBAIDQwKSwgKDIzKQ0KPiAgICg1MTUwIC0gNTI1MCBA
IDgwKSwgKDIzKSwgQVVUTy1CVw0KPiAgICg1MjUwIC0gNTM1MCBAIDgwKSwgKDIwKSwgREZTLCBB
VVRPLUJXDQo+ICAgKDU0NzAgLSA1NzI1IEAgMTYwKSwgKDIwKSwgREZTDQo+ICAgKDU3MjUgLSA1
ODM1IEAgODApLCAoMjMpDQo+DQo+IFBldGVyLCBpZiB0aGF0IGxvb2tzIGdvb2QgdG8geW91IHBs
ZWFzZSBzZW5kIGEgdjMgcGF0Y2guDQpJdCBsb29rcyBnb29kIHRvIG1lLCB0b28uIEknbGwgZG8g
djMuDQoNClRoYW5rcywNClBldGVyDQo=
