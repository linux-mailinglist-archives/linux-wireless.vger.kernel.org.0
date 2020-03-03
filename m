Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32D717715B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 09:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCCIgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 03:36:45 -0500
Received: from mail-eopbgr20104.outbound.protection.outlook.com ([40.107.2.104]:56942
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbgCCIgo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 03:36:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqBdakO/YJsvRXSKAbg0jd3yit0436CjWc6cnEboXTHeEyUTPG0WqIpSYqcr0rVMfXpyVq75gWkrOYQ92/YhY/g9yAgNZxbUW9q3pFJ2H47UueCms++PkUfH4iD1nohJciEmoMmorGAOyleUlUK430EF/keRVFJ24OcQAya6nmuVun4rJVe+KZJ/h9XJgROzpPVB6CCL/cEkdvEyVgq8JlZmrKCbcA8rVet8Jofice3F8aqbI5jHVIYN1Xv4aS169rgrL77eZdD41abr9AiSMw4M7omnJwcAOcjnMerfzbop0KhHwzFFrTpA6OhRFqM/AODR+IudfHePHNlcuivI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR8u4282qNj6ralAwV1tTwcbo9aRzU4tGkHD9CXCFY0=;
 b=C6PVWxkAQjvjBciLYgKy4H2Oo1ynadIvjALgGrKvppj6knVF6nspe64VtkO1u75gpfj6LCx58l6ikopvBGjFji8I2TiYWmP+iwFp8sVDO9YqzQ2HytjA730X/ed+/iibM7c0R9RN/HqWfrFRPsD1/DC8NREhJyJAZzcSxXQtAV9vu5cPYPchzmcDbsQB8iu+xUiyuU8G5AfLAah+/xo70F0bX79j1fTj5fGpZm/a9KCpLTig47dtg9ZGBzjc8WWMRyj7SVSt/9WtrTIhhKt+5TVyz8hf/mMWsQUJXfrl0lDNGIOkDorjL+AcGET2zcskkahb5aOHeH+ffTc0NFxCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR8u4282qNj6ralAwV1tTwcbo9aRzU4tGkHD9CXCFY0=;
 b=gAWklQ9X/iFqiKmUQyqep8eG9R7/og3vq83wVxuqNrf60xQnYU//APt6/aKX7cRTbNMwGqn1pwP7a/cFg7/K46tMjMVvXxABEKjyD6LHlC2hED7xQNrfKM8quNy7Dgl6aYcbmnkOQNIhWsSR4LrNMY2dNza/JtPlJpyJpaOQkWY=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB6296.eurprd01.prod.exchangelabs.com (20.180.3.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 08:36:37 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8955:bf34:da1e:cdb1]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8955:bf34:da1e:cdb1%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 08:36:37 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Steve deRosier <derosier@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [mac80211]: wds link and Radius authentication issue
Thread-Topic: [mac80211]: wds link and Radius authentication issue
Thread-Index: AdXth2dk69/BCqj0R+ekTWaEqaibqgACfSLgAAC+e3AAEHP8gAARId9oAJQ+JWAAD5TH4AADmZygAAVUBAAAGhSjYA==
Date:   Tue, 3 Mar 2020 08:36:37 +0000
Message-ID: <DB8PR01MB5529C93C4FA5B570DC57F88F90E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
         (sfid-20200228_022737_077710_BB93474D)
 <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
         <DB8PR01MB552911EB44BBFD569694FF1990E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55292C768759D14699CC5BAE90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55298F5D3E6D1A111EB5AE6C90E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
 <ad70a65c0c113f86ee7d5f12b8483ab2bfa32257.camel@sipsolutions.net>
In-Reply-To: <ad70a65c0c113f86ee7d5f12b8483ab2bfa32257.camel@sipsolutions.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c94f45f9-184a-4e01-1b65-08d7bf4dfd08
x-ms-traffictypediagnostic: DB8PR01MB6296:
x-microsoft-antispam-prvs: <DB8PR01MB629606DD6F77F1CA41668F3C90E40@DB8PR01MB6296.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(199004)(189003)(8936002)(110136005)(76116006)(4326008)(508600001)(81166006)(66946007)(66556008)(81156014)(26005)(52536014)(66476007)(66446008)(8676002)(33656002)(7696005)(71200400001)(186003)(5660300002)(64756008)(55016002)(9686003)(86362001)(2906002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB6296;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EewmxV59dmn/JJO1ibHLQ9k54redP/KGTnT7BpUyt6eDdAwEeqc7EKupTzHE6IrNN+68pxMKjmqvr1bISU3Q0WhdOo2tILPbmNNlVi9ZeEFUY8t8LVdCX//QcAw4oJCyln0YtsGBcINFix6ebTOS/qU3Nr8p6cGIDR42pyiX56JTaY+vFGmY+WlUuzDAZ8clvxykaJQxZfUKsrvL0bzKkQv5oSWC2DBq4Ff3L9zrecMeMLAJa+jvLFig5S3CuQIfVYWF928XXcDecTpA+sTBT9Bl0dBIvdNtUtBx83uEHYjcO4Jk+agNS912uyWFzMxb9wqG2p8Xy5cM7F3Xc6qZQcYWXojfOY7Nj8lHbpJ6zYPYQ02FkBIM9SgZjbQUffc/2A/ovSA1QUnX3ltEGFBE3age/1M05xH6YvDfEVSa/wxOvKvUkbkee3MFfVU4LLgw
x-ms-exchange-antispam-messagedata: 2ZRk4kE5KBqWWe5qlD4vhcMC14xDR6tpDpAWWykj77JdCrVsa51BNRHLO7Yx4RneBJaDhWXXy/hIiLTgtdl+E7E2NnmNdxJ3pNtCjoi7pgtbtaQ/ftKpBuY1ubLh1rsl6enu+kavxO0V/JWX8yCvrw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: c94f45f9-184a-4e01-1b65-08d7bf4dfd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 08:36:37.3998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZW122n61zKaQE0fOrkc5WJmeSzZB6kwPzEK0GJJbGdWUw/vfD6U9kD0KRnzUsXdSOwq3rAS6Gg2Wlm+CZx7NE7wQZ3Yn2tSu+qtBrFM5k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6296
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gDQo+IAlNeSBBUCBoYXZlIDMgYnNzaWQsIHRoZSB3bGFuMCBpcyBzZXQgaW4gV1BBLUVB
UCwgdGhlIHdsYW4wXzEgaXMgc2V0IA0KPiBpbiBXUEEtUFNLIGFuZCB0aGUgbGF0ZXN0IHdsYW4w
XzIgaXMgd2l0aG91dCBzZWN1cml0eS4gSXQgaXMgdXNlZnVsIA0KPiBmb3IgbXkgdGVzdCwgSSBv
bmx5IG5lZWQgdG8gY2hhbmdlIHRoZSBzdGEgY29uZmlndXJhdGlvbi4NCj4gDQo+IAlJIGFkZGVk
IHNvbWUgZGVidWcgaW4gIG5ldC9tYWM4MDIxMS90eC5jDQo+IA0KPiAJV2hlbiBJIHVzZSB0aGUg
QlNTSUQgc2V0IGluIFdQQS1QU0sgKHRoaXMgY2FzZSB3b3JrcyksIHRoZSBicm9hZGNhc3QgDQo+
IGZyYW1lcyBhcmUgc2VudCB0aHJvdWdoIHRoZSBuZXRkZXYgd2xhbjBfMS5zdGExLg0KPiAJV2hl
biBJIHVzZSB0aGUgQlNTSUQgc2V0IGluIFdQQS1FQVAgKHRoaXMgY2FzZSBkb2Vzbid0IHdvcmsp
IHRoZSANCj4gYnJvYWRjYXN0IGZyYW1lcyBhcmUgc2VudCB0aHJvdWdoIHRoZSBuZXRkZXYgd2xh
bjAgKHVzZSBmYXN0X3htaXQgDQo+IHBhdGgpLiBCdXQgdGhlIHdsYW4wLnN0YTEgbmV0ZGV2IGlz
IGNyZWF0ZWQgaW4gdGhlIHN5c3RlbSwgYWRkZWQgdG8gDQo+IHRoZSBicmlkZ2UsIGFuZCByZWNl
aXZlZCB0aGUgZnJhbWUgZnJvbSB0aGUgYnJpZGdlLiBCdXQgaW4gdGhpcyBjYXNlIA0KPiB0aGUg
ZnVuY3Rpb24gaWVlZTgwMjExX2xvb2t1cF9yYV9zdGEgIHJldHVybiBFTk9MSU5LIGZvciB3bGFu
MC5zdGExIA0KPiBhbmQgdGhlIGZyYW1lIGlzIGRyb3BwZWQuDQo+IA0KPiAJU28gSSB0aGluayB0
aGUgaXNzdWUgaXMgaW4gdHJhbnNtaXQgc2lkZSwgSSBkb24ndCB3aHksIGJ1dCB3aXRoIA0KPiBX
UEEtRUFQIHRoZSBtYWM4MDIxMSBzdGF0ZSBzZWVtIGRpZmZlcmVudCBhbmQgdGhlIFdEUyBkb2Vz
bid0IHdvcmsuDQo+IA0KPiAJRG8geW91IGhhdmUgYW55IGV4cGxhbmF0aW9uIG9yIGlkZWEgdG8g
bG9jYXRlIHRoZSBvcmlnaW4gPw0KDQpOb3QgcmVhbGx5LiBUaGUgY29kZSB0aGVyZSBpcyBqdXN0
DQoNCiAgICAgICAgc3dpdGNoIChzZGF0YS0+dmlmLnR5cGUpIHsNCiAgICAgICAgY2FzZSBOTDgw
MjExX0lGVFlQRV9BUF9WTEFOOg0KICAgICAgICAgICAgICAgIHN0YSA9IHJjdV9kZXJlZmVyZW5j
ZShzZGF0YS0+dS52bGFuLnN0YSk7DQogICAgICAgICAgICAgICAgaWYgKHN0YSkgew0KICAgICAg
ICAgICAgICAgICAgICAgICAgKnN0YV9vdXQgPSBzdGE7DQogICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gMDsNCiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHNkYXRhLT53ZGV2LnVzZV80
YWRkcikgew0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9MSU5LOw0KICAgICAg
ICAgICAgICAgIH0NCg0KYXMgZmFyIGFzIEkgY2FuIHRlbGwsIHJpZ2h0Pw0KPiBZZXMNClNvIGlm
IHlvdSBnb3QgaW50byB0aGUgLUVOT0xJTksgY2FzZSwgdGhlbiBpdCBtZWFucyB0aGF0IHVzZXJz
cGFjZSBkaWRuJ3QgYWRkIHRoZSByaWdodCBzdGF0aW9uIHRvIHRoZSA0LWFkZHIgVkxBTiBpbnRl
cmZhY2UsIHdoaWNoIEkgZ3Vlc3Mgd2FzICJ3bGFuMC5zdGExIj8gTm90IHN1cmUgaG93IHRoYXQn
ZCBoYXBwZW4uDQo+IFRoZSB3bGFuMC5zdGExIG5ldCBkZXYgd2FzIGNyZWF0ZWQgYnkgaG9zdGFw
ZCB0byBtYW5hZ2UgdGhlIHdkcyBzdGEuIFRoaXMgbmV0ZGV2IHR5cGUgaXMgQVAgVkxBTi4gVGhl
IGZ1bmN0aW9uIGllZWU4MDIxMV9sb29rdXBfcmFfc3RhIHJldHVybg0KPi1FTk9MSU5LIGJlY2F1
c2UgdGhlIHBvaW50ZXIgc2RhdGEtPnUudmxhbi5zdGEgd2FzIG5vdCBkZWZpbmVkLg0KPkluIG1h
YzgwMjExLCB3aGVyZSB0aGlzIHJjdSBwb2ludGVyIGlzIGFsbG9jYXRlZD8gV2hpY2ggTkwgbWVz
c2FnZSB0aGUgdXNlciBzcGFjZSB1c2UgPw0KDQoNCg==
