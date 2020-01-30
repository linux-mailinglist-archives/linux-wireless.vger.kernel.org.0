Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB7414DD62
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA3Ozj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:55:39 -0500
Received: from mail-eopbgr50102.outbound.protection.outlook.com ([40.107.5.102]:62633
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbgA3Ozj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:55:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELBEERdEE2m69jMwsn42eLT2V0evsG1diDbgfi43c+0NkQKi7A4aWdmmLV5oefxjtJjrUl210tcMxhy2r3vNPxqLX1R3HIn4BHHpIv4xD3edyfhSixIioc8tNoAVLb5mSOZZ9cC4pfZu8Pvo51RaIn8mQY+ytGvdq9wAKk2HXhk4ccLDOlC2iQ71/FUkiGiKyecWYhgZSm2oGeXpCGgtVoOYz1d1UrTrDnpG9qoWnJGu/DVlus/orWo/00m+eUz3qoofHVNg6dIfb1ww6rPSXmEOrggfYSkzdkAg4h8z3jnJh5p4ISxIL7+buuRzDEJagNVQXaMg+a/cTU61DEKdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyD/U8rgy57IkdZ4Kvxzs5/s7wOr85yV4QBGLvIylY4=;
 b=jv2zfxjPImO5laj0fdSpagF8gWN6yhFZqSj71zGxaiossh7XWPJnOc1TsITVuNPFj69QD+3Yn2mdKF9P2gz8D9IbNEY0k4jXNqKJLbqPb2R1sUO+cNc5i8hmUtwkzzc6W0gtooimYrSV12KY0Yw2ElL3X3W8UE3wrS1/TFps3N+qh2IuHPxeBKdI5FezHi/bKP/KnHksn/5oqUKvD0k5gA0XfK5qmqFQBkM6Zm/O1iM3EHtY9n6ABYEsCa9m85W++2ybYVmSPevViTRh78Qc2MOzi0De3hciCzK3UO5iaeccNgaKroXn+E+MQq8tZLMfNLqZdNAgtt7G6qAtX3AhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyD/U8rgy57IkdZ4Kvxzs5/s7wOr85yV4QBGLvIylY4=;
 b=rQ7TxA4LUyCJkpNB9syDYIPCTMw2ceUii/DyGLk/rDJXOPDX5iZtDvuF76DWB3IpWhDWygjbmMpVWte71uPrOyZzy6jjwnXiCAzWoPQt89AxHdqloSIek6sSraPKIy7kZQs9lO7dyWFd8yyH6hYeY8LsuCp+ix9y/syMU0a9zo0=
Received: from AM0PR01MB4387.eurprd01.prod.exchangelabs.com (52.135.144.17) by
 AM0PR01MB5409.eurprd01.prod.exchangelabs.com (20.178.112.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 14:55:34 +0000
Received: from AM0PR01MB4387.eurprd01.prod.exchangelabs.com
 ([fe80::9ce5:c1ea:4a3:5da0]) by AM0PR01MB4387.eurprd01.prod.exchangelabs.com
 ([fe80::9ce5:c1ea:4a3:5da0%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 14:55:34 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     Marlon Smith <marlon.smith10@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Strange performance issue when using two devices at once
Thread-Topic: Strange performance issue when using two devices at once
Thread-Index: AQHV1tOHPy+FkRE7eUGDblIhHCg1OqgDSrig
Date:   Thu, 30 Jan 2020 14:55:34 +0000
Message-ID: <AM0PR01MB43879C1D5C9FF8744B5ADDD1E4040@AM0PR01MB4387.eurprd01.prod.exchangelabs.com>
References: <1580323191.26012.48.camel@gmail.com>
In-Reply-To: <1580323191.26012.48.camel@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jp.tosoni@acksys.fr; 
x-originating-ip: [62.193.53.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea50708-46ee-4bce-4adf-08d7a59475a8
x-ms-traffictypediagnostic: AM0PR01MB5409:
x-microsoft-antispam-prvs: <AM0PR01MB5409FCC4D2D5BC8327146909E4040@AM0PR01MB5409.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(199004)(189003)(8936002)(52536014)(66446008)(9686003)(64756008)(55016002)(110136005)(86362001)(81166006)(8676002)(81156014)(508600001)(33656002)(2906002)(66556008)(66476007)(5660300002)(26005)(7696005)(186003)(6506007)(71200400001)(66946007)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR01MB5409;H:AM0PR01MB4387.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZ3Kr46PnGijYO0Uk5FgXjXuEwwIr+70QMGQHJm9Ci2fhJjLNHBSp3MhxIbEKiK0N3YN8jegmjsgNBx6WYIyqYFMfoquiK3wV32lxdGx1pfPfCiEr5zxp7wd5ZTgE5XGyDRhHVQIXe0LRnQdLxBITlPf8H/7mQNgoTsU4UTec7I+QsO83EcrB2JxPeOt95kPELgwBQ/GcIBiVpWCwm7ZssF6aqpWC0BGXB6pwZeAJ9AhERHgw6iYgUan2hpC03f0n/K+SkrpvYpHGMOlugVhQApufo/bnCq0Y+aeepWAAhSzXNqUIg9TToqKuYxw/oLHhTPXyEuM33stbPerGtxcOJISkoirQe68TGETOsH9oW7QQXf3F3MJHL8Zsg2jrqzHywe3QdI1g+ORBWWOeylhNNPSmva8TSlEZ2y4sEYZhSoJqM6n6eLHI9ysmPRNSJlW
x-ms-exchange-antispam-messagedata: l9qoUiTp3fEtNpo/0UwCYqbgrgBNoiOtJfE9jnJ6axP6iRRCxDtMOoeYIwu64kUNMNAcbu/n5oR8i8PC6nLm6gHwDQkNpBeuUK1fwgDlVXy07hJwDf6hcRP7bz9cH8h1rY4iHQTkHUm2S+FpCKuu3A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea50708-46ee-4bce-4adf-08d7a59475a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 14:55:34.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pw8zYpzE5aJKginXkUlUUiGAC8Ko15ud92JjDAkoF8opPXwlMoIeIDi5kPNXMPORfgoJKgd/McILmgnQ4S5jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB5409
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TWF5YmUgeW91IG5lZWQgdG8gcHV0IHNvbWUgZGlzdGFuY2UgYmV0d2VlbiB0aGUgMyBkZXZpY2Vz
Lg0KV2UgZXhwZXJpZW5jZWQgdGhpcyBraW5kIG9mIHByb2JsZW0gb24gcmFkaW9zIGNsb3NlIHRv
IGVhY2ggb3RoZXIgKGFyb3VuZCAxMGNtKS4NCkl0IHdhcyBkdWUgdG8gcmFkaW8gc2lnbmFscyBp
bmR1Y2luZyB0aGVtc2VsdmVzIGluIHRoZSBQQ0Igb2YgYW5vdGhlcg0KbmVhcmJ5IHJhZGlvLCBj
YXVzaW5nIHRoZSBvdGhlciByYWRpbyB0byBiYWRseSB0cmFuc21pdCBhbmQgcmVjZWl2ZS4NCg0K
PiAtLS0tLU1lc3NhZ2UgZCdvcmlnaW5lLS0tLS0NCj4gRGXCoDogbGludXgtd2lyZWxlc3Mtb3du
ZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtd2lyZWxlc3Mtb3duZXJAdmdlci5rZXJu
ZWwub3JnXSBEZSBsYSBwYXJ0IGRlDQo+IE1hcmxvbiBTbWl0aA0KPiBFbnZvecOpwqA6IG1lcmNy
ZWRpIDI5IGphbnZpZXIgMjAyMCAxOTo0MA0KPiDDgMKgOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtl
cm5lbC5vcmcNCj4gT2JqZXTCoDogU3RyYW5nZSBwZXJmb3JtYW5jZSBpc3N1ZSB3aGVuIHVzaW5n
IHR3byBkZXZpY2VzIGF0IG9uY2UNCj4gDQo+IEhpIGV2ZXJ5b25lLA0KPiANCj4gSSBoYXZlIHR3
byBSVDUzNzAgZGV2aWNlcyBjb25uZWN0ZWQgdG8gdGhlIHNhbWUgYWNjZXNzIHBvaW50LiBCb3Ro
DQo+IGRldmljZXMgYXJlIHZlcnkgc2xvdywgYnV0IHRoZSBpbnN0YW50IEkgZGlzY29ubmVjdCBv
bmUgZGV2aWNlLCB0aGUNCj4gb3RoZXIgc3BlZWRzIHVwIGJ5IGEgZmFjdG9yIG9mIDEwLg0KPiAN
Cj4gVGhlIHJlYWxseSBzdHJhbmdlIHBhcnQgaXMgdGhhdCBvbmUgZGV2aWNlIHdpbGwgcGVyZm9y
bSBzbG93bHkgZXZlbiBpZg0KPiB0aGUgb3RoZXIgZGV2aWNlIGlzIGJhc2ljYWxseSBpZGxlISBJ
J3ZlIGNvbmZpcm1lZCB0aGlzIHdpdGggYSBwYWNrZXQNCj4gc25pZmZlci4NCj4gDQo+IEkndmUg
YmVlbiB0cnlpbmcgdG8gZG8gc29tZSBkZWJ1Z2dpbmcsIGFuZCBJJ3ZlIGZvdW5kIHRoYXQgd2hl
biBib3RoDQo+IGRldmljZXMgYXJlIGNvbm5lY3RlZCB0byB0aGUgYWNjZXNzIHBvaW50LCB0aGV5
IHJlcG9ydCBhIGxhcmdlIG51bWJlcg0KPiBvZiBkdXBsaWNhdGUgZnJhbWVzLiBJIGFkZGVkIHNv
bWUgZGVidWcgb3V0cHV0DQo+IGluwqBpZWVlODAyMTFfcnhfaF9jaGVja19kdXAoKSB0byBjb25m
aXJtIHRoYXQgdGhpcyBvbmx5IGhhcHBlbnMgd2hpbGUNCj4gYm90aCBkZXZpY2VzIGFyZSBjb25u
ZWN0ZWQuIFRoZSBwYWNrZXQgc25pZmZlciBhbHNvIHNob3dzIGEgbGFyZ2UNCj4gbnVtYmVyIG9m
IHJldHJpZXMgd2hpbGUgdGhpcyBpcyBvY2N1cnJpbmcuDQo+IA0KPiBVc2luZyBiYWNrcG9ydHMg
NS4zLXJjNCBmb3IgdGhpcywgYnV0IGFsc28gdGVzdGVkIG9uIDQuMTQtcmMyLg0KPiANCj4gSSBk
aWQgcG9zdCBhYm91dCB0aGlzIHByZXZpb3VzbHkgb24gdGhpcyBtYWlsaW5nIGxpc3QgKFJUNTM3
MA0KPiBwZXJmb3JtYW5jZSBpc3N1ZXMpLCBidXQgSSB0aG91Z2h0IEknZCBwb3N0IGFnYWluIHdp
dGggdGhpcyBuZXcNCj4gaW5mb3JtYXRpb24gYW5kIG1vcmUgZGVzY3JpcHRpdmUgdGl0bGUuIEkn
bSBhIGxpdHRsZSBiaXQgc3R1Y2sgb24gdGhpcw0KPiBmb3IgYSB3aGlsZSBub3csIHNvIGFueSBp
ZGVhcyBhcmUgbXVjaCBhcHByZWNpYXRlZC4NCj4gDQo+IFRoYW5rcyENCj4gDQo+IE1hcmxvbg0K
