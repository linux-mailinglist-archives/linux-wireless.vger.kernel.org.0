Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A347B900
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 04:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhLUDaR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 22:30:17 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:21079 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhLUDaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 22:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1640057415; x=1640662215;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=14c63VZ3Utd6INoHBURLAma2HdlQaFKV7ctOo1LqU0o=;
  b=cBUI2wu3gyY1CXrn4yRPD6X6rQPJYlDPXR43qazL/sVLMCxo4VJGHjlJ
   Ep1MwzGAadEx8mEDQOrAXi7O1KhvyAzIEfM2DLmiBpsf1PHnSqhQCQUVk
   8yPPQkbBCEQsoXd3uRhloQZ6G3oLyzOzUmVb+X8dBO9WalPfXOx6nxw3b
   E=;
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 03:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxYU12F+Hf4+Ft/5wvrgDyiU5M4uj2ucGeZ4JFtppCXBaWSkpV6B2C68DahQiX1QvaMlSjrLk0XEL6Zrtrfxco83IAWL2kYerxxVZYy6Xr1zZtRzzLVZPfzA5J+0FI9xCjm40naNaKul4BFoYkBJfISxOVkGszBLFFINMMBf1iUHS3qPS/a8vqRY3Efu8ogSkBlgKW2EPAi3P7PipT9sXn1fME21/qHp5H8271yK4VxYUevPIjqtvtgZOVEDbpEDTmhOfjpbFLgELCF50P7mxbdmQZH0LZ0I/aIXIYEPrJ08iw3qmrgNcili4VIR7S58PkNmMlf8XDm3i2ggVCuDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14c63VZ3Utd6INoHBURLAma2HdlQaFKV7ctOo1LqU0o=;
 b=RS6/VFGJKsCBBzR2Xq9A2Tvmmwp0rrqMaYnu+ARa78cRMzCDfj07S+1FbUmEplPHTD8Vu9BNDQD9AAXrq8tLHqxrNIOU3HAxV9AUgqV5mLXHb/7z2vQKhcpzKW17jWYBTjxjUC+8pb+gIMA+wf773exNh9WHMleVYFV1qNsmSte5T0saZEgoyOzCTsaC1o1i2RmplsbL+gyOAnP0iLIrIADRw/Cn9Me7YqZaN9eV0TgVteRt0FNIZYpyYr8HI9KXlYd+nCjFhw8NlS2vQXnD3zHX4u4alfwtn7rtQ8J/tdMmsmD3Xunas1q5WrRJK0eX/SWOeBDy6jOORzumKoOWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by SN6PR02MB4237.namprd02.prod.outlook.com (2603:10b6:805:35::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.18; Tue, 21 Dec
 2021 03:30:12 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::497f:dddd:6fee:bc80]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::497f:dddd:6fee:bc80%6]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 03:30:12 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC v2] mac80211: Mesh Fast xmit support
Thread-Topic: [RFC v2] mac80211: Mesh Fast xmit support
Thread-Index: AQHX6XXqVd7PVr7lNUWtGL+Ymnnsrqw7RfAAgAEZVqA=
Date:   Tue, 21 Dec 2021 03:30:11 +0000
Message-ID: <SN6PR02MB4334E308AB7BE417CE05E22FF77C9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1638667044-7031-1-git-send-email-quic_srirrama@quicinc.com>
 <835682b648d506212da46653404b9ccaf7f35cb0.camel@sipsolutions.net>
In-Reply-To: <835682b648d506212da46653404b9ccaf7f35cb0.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7a0f508-af9e-4970-a439-08d9c4323250
x-ms-traffictypediagnostic: SN6PR02MB4237:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB42371A6EF62C7F85DB58B5BC8B7C9@SN6PR02MB4237.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qg545vB4o2488JsYaskP55319r9AsUdWU2Q3d9gzbVAOwFAdC3yyghwBQMy8oPvIzNo0L8zmw0YC1rmUa6hjlxC5XF6oMwOQ3wM0ZnEBqXCzxiKx4QOPo+XOrvhE0f40fcT162zPonuIWoyflKOx69Dkxc62oVfAPyiFq6UIRdUnN1x6K5DNK/jelmf6uErCUQktaAGC5hn0rkahfMtgA3975O6htHkNFT61zPAJBBkVRnM/dj+0CH8+Tg9Ip6wYa+RJIrfat7RE3Q8AhvjGc3ClbcLMY8m64YGvPUN7E/oOJGub6dpEOWlH3qr8PgWr6hQNgFTCQpbdJEHRIuu2DxaqfwZzf5WPCA6RPw0oNt+tn9zM/ahfMJxBsXc/kTQIHx1U7bmBPAGeEDdaNaTVxwJ5+D2UWowi4jThDLuqmsh62a6IGcvvpi/iFOyqbwBhBpiluCIMfy8blLSpbVAO0EEwFuYU6JqojKzkcIcHXF0c7r5u7LmgbC++qoaoCoB4WxN5H5spcfmZ0iKIQRRwJmO3ycWfql2t76FGDY1uvONifFm2E037qSK/4TLtd/wNSuvCh72hfMEglY/5kYezNIlgl1x726S2YsLfwdxNVt98EwNX236TPQPy9yiMQV0K1Q6WqqMBpPHQjdCxD8pknjQ4aJFrTnebuGfXOYDpD/LKoSnBPMCC2LlGc1B3CzAiRAfj6RS28hujjjm0/F4wsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66476007)(66946007)(66446008)(64756008)(38100700002)(83380400001)(66556008)(122000001)(8676002)(55016003)(5660300002)(7696005)(52536014)(8936002)(86362001)(110136005)(26005)(71200400001)(6506007)(38070700005)(33656002)(508600001)(53546011)(316002)(186003)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmhiYS9jQUgyZmQ1WG04U0hYQ0ViQVM2VS9pOElTTnFmQUNCS1NYMUtmWUZB?=
 =?utf-8?B?a214QzZad3Q4R0ZWOThtMVRZWFRmUGxhaDN0YXFSZEJDbnVidm1lRUVTTk1o?=
 =?utf-8?B?WitVaUpEOFFzSnV5UkE1NnNtQ3hvQmJ2Z0pDbXFidHdxQmE2NmtzaHF4eElw?=
 =?utf-8?B?TzRXNWQzZURMYnRpTGhPYVM4ZjZtV3NNOHUvRENjYVBhS0VjT3hnWUJ1WFdL?=
 =?utf-8?B?ZlFhRUpjeHQxbVhFRHpHTVgxaWp0Zm5VSzVYVFFiaEwwejZrUmhuY29wK2g1?=
 =?utf-8?B?T1hMejV5U3ZmMVloWElFaGxqZFpTZCtxYTJwOXdVVFZKTjVrbXBDMnpDd2tF?=
 =?utf-8?B?VjM1bmFlR0ViV2ZCN1B2aUljNHJWWmJYU29tQkZEWCtKK0Z5ZmxjcllsU0Nz?=
 =?utf-8?B?bWZCb2luc3oyMUkyNXczeUR2dFY1Tm1HR1NNN3JQZ2NVZEJFU1hyc3hnd2Nz?=
 =?utf-8?B?WEdzdE8vVWx2dC9ZTWZ5QWJTUnVpV1lpV0tLWjM1Z3hLM3Vpc00zRjZNREV6?=
 =?utf-8?B?c2ZVRDNrMC91RHcwZTdQWFBkK2NGU1hWWUVKUUZ6YS84emNCeVdOdXY3SUpy?=
 =?utf-8?B?VDBxVm51bytCaitxclNwK3RRRk1CMnVwTG1wZUNpZkhjbW5HSXdOVmdHY2tj?=
 =?utf-8?B?aEhIMmdqWjlTekd4UjBIUG5waURRQmlCUksxWVZkOXZrdHFUYlFPWTBDcWZY?=
 =?utf-8?B?ajJWcDFBeGx4SkZEalZheEFNVWVjZ0xpcFE4NzJMYkZnWXR4TXNUZUFTRzUx?=
 =?utf-8?B?NTRnM3ZuWUdGOWo2cFNJVFZ4SXE0dUs4NTROVE9JMmYvUFdzNGlBRVVUUDJn?=
 =?utf-8?B?UDF5bE5jcmtDZEdORVErWDFiRGhlaFdiT1BMVFhmTGNoNW84NG5VVWh2YWNx?=
 =?utf-8?B?d0xaaVVDbU1BQnVuSGR5ZVpWYzdYTjlqNGkwQWtTSXNwOXJac1JoVnRtWmFv?=
 =?utf-8?B?NlJuL2pOS1liVURKMHl4dEpBcmxkYll0QVQrYjhiZEFuejEwMUVxdUZGNFM3?=
 =?utf-8?B?U1I5QS9OMDdWTUtSVXczenpPTnpQYXpPUE0zeEtTMm94Z25taUJ1SElpQ3cy?=
 =?utf-8?B?WFlvTEx4a0h1RW11bVdWZ3F4cXM3OVdvL0U3OUwvRkNnTFRvYXVmaWNJMXJx?=
 =?utf-8?B?WGRtSlV6ZnRLTXgvZEdROGJuYWtSZWwzdTFNSFVNb3RBT2QzYjZWKzNPOGZF?=
 =?utf-8?B?N3J1dkxySThwYUloWHlYZGlvV0x3TXY1Lys0SmMrdUJxdDRzd0FxcXBEODIx?=
 =?utf-8?B?WW1qQ3VIQUtlakVVY055dm5ZOW5SSnVpbFdkdytrREtNanFFUjQzanRRaUFM?=
 =?utf-8?B?OUtFdWR2S2oxVnF0Q2U1cThSdnMrWkJpdnNxNFZ2T0hlV0tZeXR2a0I4dXc4?=
 =?utf-8?B?anVRZTA0Zm45L092ZXRyWEdaOFc5cGliN1RBTWliOWx3OE9XZUhzaUVyTDhs?=
 =?utf-8?B?NHphV0h1Q2hTeEF2STdRSVR1REJjNXFYMVR2TXJzemRSVDNxZW9ObkkraE5M?=
 =?utf-8?B?dGsrUVZqdDdIbEVNbWlrdzFDUmlndkl4MXk4Uk1VMnEzMUU0Wm80Q2VpeEo0?=
 =?utf-8?B?YUhGa2JxcUJMZllzQ0tVQ3lFeU5ZeUtqaDE0N1RTSnFMeXM4ejFnRUU2R2JJ?=
 =?utf-8?B?Y0c4K0p6bTErVFdKNmgwMlY5dlBxVUNUUnhLbDZZT0liU2VNZDF2aGpzUERY?=
 =?utf-8?B?NldsY292TkZKNCtocHlQSkZJMGE1MDVWYmxoYVd0RTE2L2tESFhnbnRVTU5z?=
 =?utf-8?B?VE9oUE5XTHhVbkZYNElINEpTWUhwOUpPZVUrTExmU0FBQURsZVQzRFJqc3Zw?=
 =?utf-8?B?aHhnUUVEV0lFZnR2dE1NTjNnREVOZ3IvMmtMR3FhajlkSW5yZGplM0MyaVNz?=
 =?utf-8?B?UHl6Q2RydjZraWxNVllFUzc2UkRZVENSQ1dWRHVTcnpndUU3Q29paXM4Y2F4?=
 =?utf-8?B?bmZBUUNZTWVLbG5HNTkreDREWVlkSFNGNkRBODY4TmJ1ZmJxd0xRZjZZUzlp?=
 =?utf-8?B?aC9ibEMvSXkwNWZNYTRPNkZoRmVlMFp3RXBqTVR1eDVYUzl6NjFnWFVYOVNJ?=
 =?utf-8?B?azEwS0NQMloyZjJOMnFtVWYwTGZYaDlaMlpob1FoeFZLM3NRRUNFeVRRYTRD?=
 =?utf-8?B?UkZqTHNQMWNsZGhPa28rRElEdmVuMXMyZHBVOXVkaDBzQW94eTJCdENGUEI4?=
 =?utf-8?B?MVZWajA2S3Rzdk9mRHFUNGZvN09YU2lQNVpndUJFZU9mUEtNYlNkOExZL1Fw?=
 =?utf-8?B?Ni9xaFRnVC9nL0g0R2RMeWdaeWtRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a0f508-af9e-4970-a439-08d9c4323250
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 03:30:12.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2kHlPBtLhumAfGdkEWCQAr8CCHjENkjLSxa6hb/8hQUzUEROmirXMmdQ7Fmk9d4EeekarLZ3UkmxEIwAm78u58sBeIz/eDakeomsr89LCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4237
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDIwLCAyMDIx
IDM6NTkgUE0NCj4gVG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNv
bT47IGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtS
RkMgdjJdIG1hYzgwMjExOiBNZXNoIEZhc3QgeG1pdCBzdXBwb3J0DQo+IA0KPiBXQVJOSU5HOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUg
d2FyeQ0KPiBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1h
Y3Jvcy4NCj4gDQo+IE9uIFN1biwgMjAyMS0xMi0wNSBhdCAwNjo0NyArMDUzMCwgU3JpcmFtIFIg
d3JvdGU6DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvbWFjODAyMTEuaCBiL2lu
Y2x1ZGUvbmV0L21hYzgwMjExLmggaW5kZXgNCj4gPiA3NzVkYmI5Li4wODlmYmI3IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbmV0L21hYzgwMjExLmgNCj4gPiArKysgYi9pbmNsdWRlL25ldC9t
YWM4MDIxMS5oDQo+ID4gQEAgLTg2OCw2ICs4NjgsOCBAQCBlbnVtIG1hYzgwMjExX3R4X2luZm9f
ZmxhZ3Mgew0KPiA+ICAgKiBASUVFRTgwMjExX1RYX0NUUkxfRE9OVF9SRU9SREVSOiBUaGlzIGZy
YW1lIHNob3VsZCBub3QgYmUNCj4gcmVvcmRlcmVkDQo+ID4gICAqICAgcmVsYXRpdmUgdG8gb3Ro
ZXIgZnJhbWVzIHRoYXQgaGF2ZSB0aGlzIGZsYWcgc2V0LCBpbmRlcGVuZGVudA0KPiA+ICAgKiAg
IG9mIHRoZWlyIFFvUyBUSUQgb3Igb3RoZXIgcHJpb3JpdHkgZmllbGQgdmFsdWVzLg0KPiA+ICsg
KiBASUVFRTgwMjExX1RYX0NUUkxfQ0hFQ0tfRkFTVF9NRVNIOiBEdXJpbmcgTWVzaCB4bWl0LCB0
aGUNCj4gaGVhZGVyIG9mIHRoaXMNCj4gPiArICogICBmcmFtZSBjYW4gYmUgY2FjaGVkIGZvciBm
YXN0ZXIgbG9va3VwIGxhdGVyLg0KPiA+ICAgKg0KPiA+ICAgKiBUaGVzZSBmbGFncyBhcmUgdXNl
ZCBpbiB0eF9pbmZvLT5jb250cm9sLmZsYWdzLg0KPiA+ICAgKi8NCj4gPiBAQCAtODgxLDYgKzg4
Myw3IEBAIGVudW0gbWFjODAyMTFfdHhfY29udHJvbF9mbGFncyB7DQo+ID4gICAgICAgSUVFRTgw
MjExX1RYX0lOVENGTF9ORUVEX1RYUFJPQ0VTU0lORyAgID0gQklUKDYpLA0KPiA+ICAgICAgIElF
RUU4MDIxMV9UWF9DVFJMX05PX1NFUU5PICAgICAgICAgICAgICA9IEJJVCg3KSwNCj4gPiAgICAg
ICBJRUVFODAyMTFfVFhfQ1RSTF9ET05UX1JFT1JERVIgICAgICAgICAgPSBCSVQoOCksDQo+ID4g
KyAgICAgSUVFRTgwMjExX1RYX0NUUkxfQ0hFQ0tfRkFTVF9NRVNIICAgICAgID0gQklUKDkpLA0K
PiANCj4gSXQgd291bGQgYmUgbmljZSBpZiB3ZSBjb3VsZCBnZXQgYXdheSB3aXRob3V0IHRoaXMs
IGFuZCBzaG91bGRuJ3QgaXQgYW55d2F5IGJlDQo+IGFuIGludGVybmFsIGZsYWcgb3Igc28sIG5v
dCBzdXJlIHdoeSB0aGUgZHJpdmVyIG5lZWRzIHRvIGtub3c/DQpZZXMgU3VyZSwgSSdsbCByZW1v
dmUgdGhpcyBmbGFnIGFuZCByZXBsYWNlIHdpdGggbmVjZXNzYXJ5IGNoZWNrcyBpbiB0aGUgZW50
cnkgYWRkaXRpb24gZnVuY3Rpb24gaXRzZWxmLg0KPiANCj4gDQo+ID4gKy8qKg0KPiA+ICsgKiBz
dHJ1Y3QgbWVzaF9oZHJfY2FjaGUNCj4gDQo+IHNob3VsZCBoYXZlIGEgZGVzY3JpcHRpb24gdGhl
cmUsIGlmIGl0J3Mga2VybmVsLWRvYy4NCkknbGwgdXBkYXRlIGl0Lg0KPiANCj4gPiArICogQHJo
ZWFkOiB0aGUgcmhhc2h0YWJsZSBjb250YWluaW5nIGhlYWRlciBjYWNoZSBlbnRyaWVzDQo+ID4g
KyAqIEB3YWxrX2hlYWQ6IGxpbmtlZCBsaXN0IGNvbnRhaW5pbmcgYWxsIGNhY2hlZCBoZWFkZXIg
ZW50cmllcw0KPiA+ICsgKiBAd2Fsa19sb2NrOiBsb2NrIHByb3RlY3Rpbmcgd2Fsa19oZWFkDQo+
ID4gKyAqIEBzaXplOiBudW1iZXIgb2YgZW50cmllcyBpbiB0aGUgaGVhZGVyIGNhY2hlICAqLyBz
dHJ1Y3QNCj4gPiArbWVzaF9oZHJfY2FjaGUgew0KPiA+ICsgICAgIHN0cnVjdCByaGFzaHRhYmxl
IHJoZWFkOw0KPiA+ICsgICAgIHN0cnVjdCBobGlzdF9oZWFkIHdhbGtfaGVhZDsNCj4gPiArICAg
ICAvKiBwcm90ZWN0cyBoZWFkZXIgaGxpc3QgKi8NCj4gPiArICAgICBzcGlubG9ja190IHdhbGtf
bG9jazsNCj4gPiArICAgICBhdG9taWNfdCBzaXplOw0KPiA+ICt9Ow0KPiANCj4gSG93ZXZlciwg
aXMgaXQgZXZlbiB3b3J0aCBrZWVwaW5nIHRoZSBmZXcgdmFyaWFibGVzIGhlcmUgaW4gYSBzZXBh
cmF0ZQ0KPiBhbGxvY2F0aW9uPw0KPiANCj4gTWVzaCBtaWdodCBub3QgZXZlbiBiZSB0aGUgbGFy
Z2VzdCB1c2VyIG9mIHNwYWNlIGluIHRoZSBpbnRlcmZhY2UgdW5pb24sIHNvDQo+IHBlcmhhcHMg
aW5saW5pbmcgdGhlIHN0cnVjdCBtYWtlcyBzZW5zZT8NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIG1l
c2hfaGRyX2NhY2hlX2luaXQoc3RydWN0IGllZWU4MDIxMV9zdWJfaWZfZGF0YSAqc2RhdGEpDQo+
ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgaWVlZTgwMjExX2xvY2FsICpsb2NhbCA9IHNkYXRhLT5s
b2NhbDsNCj4gPiArICAgICBzdHJ1Y3QgbWVzaF9oZHJfY2FjaGUgKmNhY2hlOw0KPiA+ICsNCj4g
PiArICAgICBzZGF0YS0+dS5tZXNoLmhkcl9jYWNoZSA9IE5VTEw7DQo+ID4gKw0KPiA+ICsgICAg
IGlmICghaWVlZTgwMjExX2h3X2NoZWNrKCZsb2NhbC0+aHcsIFNVUFBPUlRfRkFTVF9YTUlUKSkN
Cj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgY2FjaGUgPSBrbWFs
bG9jKHNpemVvZigqY2FjaGUpLCBHRlBfQVRPTUlDKTsNCj4gDQo+IEFuZCBpZiB3ZSBrZWVwIHRo
aXMgb3V0c2lkZSwgc3VyZWx5IHRoYXQgbmVlZCBub3QgYmUgR0ZQX0FUT01JQz8NClN1cmUsIGFn
cmVlIEpvaGFubmVzLCBpdCBzZWVtcyB1bm5lY2Vzc2FyeSB0byBoYXZlIHNlcGFyYXRlIGFsbG9j
YXRpb24sIEknbGwgbW92ZSB0byB0aGUgbWVzaCBzdHJ1Y3QuDQo+IA0KPiA+DQo+ID4gKyAgICAg
c3Bpbl9sb2NrX2JoKCZjYWNoZS0+d2Fsa19sb2NrKTsNCj4gPiArICAgICBobGlzdF9hZGRfaGVh
ZCgmbWhkci0+d2Fsa19saXN0LCAmY2FjaGUtPndhbGtfaGVhZCk7DQo+ID4gKyAgICAgc3Bpbl91
bmxvY2tfYmgoJmNhY2hlLT53YWxrX2xvY2spOw0KPiA+ICsNCj4gPiArICAgICBhdG9taWNfaW5j
KCZjYWNoZS0+c2l6ZSk7DQo+IA0KPiBUaGVyZSdzIG5vIHBvaW50IGluIGtlZXBpbmcgY2FjaGUt
PnNpemUgYXMgYW4gYXRvbWljX3QsIHlvdSBhbHdheXMgYWNjZXNzIGl0DQo+IHZlcnkgbmVhciB0
aGUgc3BpbmxvY2suIEJldHRlciBqdXN0IG1vdmUgaXQgdW5kZXIgdGhlIHNwaW5sb2NrLg0KUmln
aHQsIEkganVzdCByZXZpZXdlZCBhbmQgaXQgc2VlbXMgZXZlcnl3aGVyZSBpdHMgZWl0aGVyIGlu
c2lkZSBvciBqdXN0IG91dHNpZGUgdGhlIGxvY2suDQo+IA0KPiBBbHNvIGFyZSB5b3Ugc3VyZSB5
b3UgZG9uJ3QgaGF2ZSB0byBwdXQgdGhlIHJoYXNodGFibGUgY2hhbmdlIHVuZGVyIHRoZQ0KPiBz
cGlubG9jaz8/DQpUaGFua3MsIEkgbWlzc2VkIGl0LCBzaG91bGQgYmUgdW5kZXIgdGhlIGxvY2su
DQo+IA0KPiANCj4gPiBAQCAtNDI1LDYgKzgwOCw3IEBAIHN0cnVjdCBtZXNoX3BhdGggKm1lc2hf
cGF0aF9hZGQoc3RydWN0DQo+IGllZWU4MDIxMV9zdWJfaWZfZGF0YSAqc2RhdGEsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzaF9yaHRfcGFy
YW1zKTsNCj4gPiAgICAgICBpZiAoIW1wYXRoKQ0KPiA+ICAgICAgICAgICAgICAgaGxpc3RfYWRk
X2hlYWQoJm5ld19tcGF0aC0+d2Fsa19saXN0LCAmdGJsLT53YWxrX2hlYWQpOw0KPiA+ICsNCj4g
PiAgICAgICBzcGluX3VubG9ja19iaCgmdGJsLT53YWxrX2xvY2spOw0KPiANCj4gVW5yZWxhdGVk
IGNoYW5nZQ0KPiANCj4gPiArICAgICAvKiBUT0RPIHJlZHVjZS9jb21iaW5lIG11bHRpcGxlIGNo
ZWNrcyB3aGljaCBhcmVuJ3QgcGVyIHBhY2tldCAqLw0KPiA+ICsgICAgIGlmIChpZm1zaC0+bXNo
Y2ZnLmRvdDExTWVzaE5vbGVhcm4pDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ID4gKw0KPiA+ICsgICAgIGlmICghaWVlZTgwMjExX2h3X2NoZWNrKCZsb2NhbC0+aHcsIFNVUFBP
UlRfRkFTVF9YTUlUKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArDQo+
ID4gKyAgICAgaWYgKHNkYXRhLT5ub2Fja19tYXApDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+IA0KPiBZZWFoLCBqdXN0IGRvbid0IGNyZWF0ZSBjYWNoZSBlbnRyaWVzIGluIHRo
b3NlIGNhc2VzPw0KPiANCj4gU2F2ZXMgbWVtb3J5IChmb3IgdGhlIG1vcmUgaW50ZXJlc3Rpbmcg
Y2FzZXMpIHRvby4NClJpZ2h0LCBJJ2xsIGhhdmUgdGhlc2UgY2hlY2tzIHdoaWxlIGNhY2hpbmcg
dG9vLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIFdpbGwgYWRkcmVzcyB0aGVzZSBjb21tZW50
cyBhbG9uZyB3aXRoIHN1Z2dlc3Rpb25zIHByb3ZpZGVkIGJ5IEZlbGl4LCBhbmQNCmlmIHRoZXJl
IGFyZSBhbnkgb3RoZXIgY29tbWVudHMvY29uY2VybnMgZnJvbSBvdGhlcnMgd2l0aCB0aGlzIFJG
QyB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KU3JpcmFtLlINCj4gDQo+IGpvaGFubmVzDQo=
