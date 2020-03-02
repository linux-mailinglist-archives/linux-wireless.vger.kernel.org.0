Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBE1755FD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCBI2n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 03:28:43 -0500
Received: from mail-eopbgr80135.outbound.protection.outlook.com ([40.107.8.135]:22022
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbgCBI2m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 03:28:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiV8i3KUcrySPMzC5I+vsHQKtoged0QRMmgUQWGJ4GMaGZjOXnetHcksPmOzep/CG8vT/P2onS2Lp5EM5KgCJoYK17pfst84aY+Ifezi0yO15TNX7o6pVNagzHh/6Wg4z+xkRCCa7hzMvf2xAIdyEHgihGPrLiIz9JI3pAG1WpNi3MKI6OimR4D8G9uzswcRxIF9JSvQqux38y+tx2iubpPvD1h3D0lH+oV6ANnuKG/YgV9jfYSgOpf1c3abhfRaS4OzCLyIUUjvsR4Jr0ZtdEpSk+E+gnd40803KqZvISbrB94gOlUn1ie3h3ykzy/7luqlsePxzd9+v/4kD5D42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lpiku/yNV8G8UoRRtdYTa58+lHacdf1bb+WP19up8HI=;
 b=WiJp84CV1dEMLs3n2pkZrtVWU/yl1wjm+Xoin6fvf649t6F0Vh+2Skl6yFHGIFuKj/cyu61t62PlnAiU9ss5FgHYdYq49srHmCOjMbOTwdWKwjKq9JhgFjExMHbPXmTBntmJDA/XfRHSYQEnf9OPp6+XZYgsz0X1RQlsHxX/7+FC4pJaYs4nIYzqQoOFug7o31fQD3+geOkLtqeVkQCfolVNoxLoxS/ac29mphqD2+p8j6iipsA32W7xKukqdocQI2M1pOja+vIWodZmjZ0fGYUoaOc4qHGWpYkQFP38R7F2F3hje23fJSo8swoYedcGEDgzfs2wZqwGyMctLaXdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acksys.fr; dmarc=pass action=none header.from=acksys.fr;
 dkim=pass header.d=acksys.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector2-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lpiku/yNV8G8UoRRtdYTa58+lHacdf1bb+WP19up8HI=;
 b=G2mksFVNhjBfWShOuuf9ZsNKJhWxKb/CZHIf7e0T+rhtDjpzwcbd9FqKXFbvaIO0wIBxyo3QKBeEpAmsP1pAlnkLc1OAcdwCLM7to3oaxW70HzZPXwo/xdiBkWFtqhg/vmifhVw6H+EtRS8xWnQ3G51/c6byCW7NwfeGg8LfYn4=
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com (10.255.170.96) by
 DB8PR01MB6215.eurprd01.prod.exchangelabs.com (20.180.1.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 08:28:37 +0000
Received: from DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8955:bf34:da1e:cdb1]) by DB8PR01MB5529.eurprd01.prod.exchangelabs.com
 ([fe80::8955:bf34:da1e:cdb1%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 08:28:37 +0000
From:   Cedric VONCKEN <cedric.voncken@acksys.fr>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Steve deRosier <derosier@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [mac80211]: wds link and Radius authentication issue
Thread-Topic: [mac80211]: wds link and Radius authentication issue
Thread-Index: AdXth2dk69/BCqj0R+ekTWaEqaibqgACfSLgAAC+e3AAEHP8gAARId9oAJQ+JWA=
Date:   Mon, 2 Mar 2020 08:28:37 +0000
Message-ID: <DB8PR01MB552911EB44BBFD569694FF1990E70@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
References: <DB8PR01MB5529DDE77726C997EAAC3F3C90EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB55290E6894E532ABA3748A5590EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <DB8PR01MB5529D69C90706C78D3B66BA490EB0@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
         <CALLGbRJYAfa=5t46UTj8GT6yhMVUZkCeD6pqF+XVhLSdmoJ5wg@mail.gmail.com>
         (sfid-20200228_022737_077710_BB93474D)
 <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
In-Reply-To: <a7df3def1f3bbd80bf96ffb74f2da365ff578df7.camel@sipsolutions.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cedric.voncken@acksys.fr; 
x-originating-ip: [81.255.64.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb2c9c04-0ef9-4ce0-f953-08d7be83b4a0
x-ms-traffictypediagnostic: DB8PR01MB6215:
x-microsoft-antispam-prvs: <DB8PR01MB621597F2B3E5CEEDC318479190E70@DB8PR01MB6215.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(136003)(42606007)(396003)(189003)(199004)(5660300002)(86362001)(66574012)(52536014)(2906002)(66446008)(66946007)(71200400001)(64756008)(66556008)(66476007)(7696005)(55016002)(9686003)(316002)(76116006)(4326008)(508600001)(26005)(81156014)(8676002)(81166006)(6506007)(33656002)(186003)(53546011)(8936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB8PR01MB6215;H:DB8PR01MB5529.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpvbGzUYe+x8Hyzwp1y7hjqaNZEoOzgqNAnK7a/CJb8NOoz1R2/rzaNSOfSeNPDLImUCE03WIeRAojtWsLwBd7P6ZBeeQ1Xy6HRWj/yhtQYy53l5F8Gc5JB0RAJ0mP1ni++QRJxRIL4trOO3F0b/IUGok7rqDjDTrKXzGRp0mgH4RohkqPvMlItBaplLNhraprX7bz/Dw8WeDHFxfdXV8UQP4wMJqToyVMjni6NuA1Cs3fmCMg/pc2xqkqEGcIyJXoCr/z5TpReHG2Kp3NrqJN8t1yRcxnMdVpA0W0sLzV64kA4Y9XsJDe2TbvFeRFlSRZNWmO+mXyDWQ+777mHirgSftogmTqNxFTpTL9HVBWvydcn9nQAJxe0arUL27cbV250+VF9aVD12b5vFnr53GQgLF7YAgrqWR+nZAFDdxVDrheinaIrLWoG1bfu7f4TG
x-ms-exchange-antispam-messagedata: 38WR4BZf1e2DrBrKhhY8EwhJ6oncBaDe8zVRoOyBE+PVNcar6G9Ej+fURw14ulUpI56eM5hRf+7O32pYHS7LaeclnxmQdK0TqLRw3xEhXRldZL9DhiIeUrx4IqC1vlwsp3TXe0M4L72oB/YPot/Thw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2c9c04-0ef9-4ce0-f953-08d7be83b4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 08:28:37.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvjYvKnpxmMMIuvqEWr8EPFjzFQcQLivvMZsPBiGjK5ieHnQ0s6zK9T+yd57ZnWD6N5ZY5HQa/CXN52Do5/Y9ICaFYWvrBNjgqAn01qck7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6215
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WWVzIEknbSBydW5uaW5nIG1hYzgwMjExIG9uIGJvdGggc2lkZS4NCg0KSSBwcm9ncmVzcyBpbiB1
bmRlcnN0YW5kaW5nIHRvIHRoaXMgaXNzdWUuIEFmdGVyIGNoZWNrZWQsIHRoZSBpc3N1ZSBpcyBk
aWZmZXJlbnQgd2l0aCBkaWZmZXJlbnQgbWFjODAyMTEgdmVyc2lvbi4gV2l0aCB0aGUgYmFja3Bv
cnQgNS40LXJjOC0xLCB0aGUgZHJpdmVyIGxldmVsIHNlZW0gd29ya2VkIGNvcnJlY3RseS4gVGhl
IGhvc3RhcGQgKGluIEFQIHNpZGUpIGRpZG4ndCBpbmNsdWRlIHRoZSBzdGEgaW4gdGhlIGJyaWRn
ZSB3aGVuIHRoZSBzZWN1cml0eSBwb2xpY3kgaXMgV1BBLVBTSyBvciBXUEEtRUFQLiBXaXRoIG5v
bmUgcG9saWN5IHRoZSBzdGEgaXMgY29ycmVjdGx5IGluY2x1ZGVkLg0KDQpOb3cgSSdtIHNlYXJj
aGluZyBpbiBob3N0cGFkLg0KDQotLS0tLU1lc3NhZ2UgZCdvcmlnaW5lLS0tLS0NCkRlwqA6IEpv
aGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+IA0KRW52b3nDqcKgOiB2ZW5k
cmVkaSAyOCBmw6l2cmllciAyMDIwIDEwOjM3DQrDgMKgOiBTdGV2ZSBkZVJvc2llciA8ZGVyb3Np
ZXJAZ21haWwuY29tPjsgQ2VkcmljIFZPTkNLRU4gPGNlZHJpYy52b25ja2VuQGFja3N5cy5mcj4N
CkNjwqA6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KT2JqZXTCoDogUmU6IFttYWM4
MDIxMV06IHdkcyBsaW5rIGFuZCBSYWRpdXMgYXV0aGVudGljYXRpb24gaXNzdWUNCg0KT24gVGh1
LCAyMDIwLTAyLTI3IGF0IDE3OjI2IC0wODAwLCBTdGV2ZSBkZVJvc2llciB3cm90ZToNCj4gT24g
VGh1LCBGZWIgMjcsIDIwMjAgYXQgOTozNyBBTSBDZWRyaWMgVk9OQ0tFTiA8Y2VkcmljLnZvbmNr
ZW5AYWNrc3lzLmZyPiB3cm90ZToNCj4gPiBXaGVyZSBjYW4gSSBmb3VuZCBzb21lIGluZm9ybWF0
aW9uIG9uIGhvdyB0aGUgd2RzIHN5c3RlbSBzaG91bGQgDQo+ID4gd29yaz8gSSBsb29rZWQgaW4g
ODAyLjExLTIwMTIgc3RhbmRhcmQgYW5kIEkgZGlkbid0IGZvdW5kIGFueSANCj4gPiBpbmZvcm1h
dGlvbnMuDQo+ID4gDQo+IA0KPiBJIHRoaW5rIFdpa2lwZWRpYSBzYXlzIGl0IGJlc3Q6DQo+ICJX
RFMgbWF5IGJlIGluY29tcGF0aWJsZSBiZXR3ZWVuIGRpZmZlcmVudCBwcm9kdWN0cyAoZXZlbiBv
Y2Nhc2lvbmFsbHkgDQo+IGZyb20gdGhlIHNhbWUgdmVuZG9yKSBzaW5jZSB0aGUgSUVFRSA4MDIu
MTEtMTk5OSBzdGFuZGFyZCBkb2VzIG5vdCANCj4gZGVmaW5lIGhvdyB0byBjb25zdHJ1Y3QgYW55
IHN1Y2ggaW1wbGVtZW50YXRpb25zIG9yIGhvdyBzdGF0aW9ucyANCj4gaW50ZXJhY3QgdG8gYXJy
YW5nZSBmb3IgZXhjaGFuZ2luZyBmcmFtZXMgb2YgdGhpcyBmb3JtYXQuIFRoZSBJRUVFDQo+IDgw
Mi4xMS0xOTk5IHN0YW5kYXJkIG1lcmVseSBkZWZpbmVzIHRoZSA0LWFkZHJlc3MgZnJhbWUgZm9y
bWF0IHRoYXQgDQo+IG1ha2VzIGl0IHBvc3NpYmxlLiINCg0KSSB0aGluayByZWFsbHkgd2hhdCBD
ZWRyaWMgaXMgYXNraW5nIGlzIGhvdyB0aGlzIGlzL3Nob3VsZCBiZSBkb25lIHdpdGggbWFjODAy
MTEncyA0LWFkZHIgY2xpZW50L0FQIG1vZGUocyk/DQoNCkNlZHJpYywgYXJlIHlvdSBydW5uaW5n
IG1hYzgwMjExIG9uIGJvdGggc2lkZXMgb2YgdGhlIGxpbmssIHRoZSBBUCBhbmQgdGhlICg0LWFk
ZHIpIGNsaWVudD8NCg0Kam9oYW5uZXMNCg0K
