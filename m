Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA53F5995
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 10:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhHXIBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 04:01:45 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:9184
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233910AbhHXIBm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 04:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZhApgoHcIAC69rO5/gse4COemh9rBQBDzHn5AS5nPHEolaM1jIFyiIUBrv5zCb/3qV1OJpe3oynGFVZT5F6AXpR/lI5xJlrPHLZ3kXdtp1aQT0qG4+mL2gJVI8vwa+x8xjGWUkH2kdbdb5YP9yNYnxIAT60YYp+0tRxr/oEkCEOqVR8LCS7SXVPFzbv2WvOVIHBGvXjzTox46vp6fWsf/0mhMHpAE+u25rDKJm3aGu3hSqgUHTNdJ864OHATuyq1DH0hYkX893ek0lfGjYoyG7AGHDn0rcwZA0Rs1eS83go9WAljO3JTYbgTN+LdZaRpQLFlduOMHt53K9oQg9W4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Foprh5Yyv1acjr9EcF5yQCSIgQ/99aNd8ooNEGfUDRc=;
 b=P2k0RF6MThqlIutZCe4VALoEB+JZgHgbmEWvvoAa4BPQWirRfk4lPYreeogrw5PQoh4sL/RI494ihBUAWPGWB4PNnKao4rQH6xHHqyqYzgcfY+vMc+4H0eNvT0IAkNYkro38CkljYVsOhH5lfYOXfcEEDH/jkd0CbdHarXDTWyCqE0SO3YVbDzjIuNqU4SNRrsxWYUsYGir34cnl3cCjBEvxAZAUmBy8kWx3DXNaFm0Sil7A5v5s80IC5Eu8grVwdmipmOJiIbNxjjeFCP7SetbqhZuM4ie5a7wxbPlyw/MPDUYqFawBQVPbd//+2puf1/mB/JrAmwDc19eltmzbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Foprh5Yyv1acjr9EcF5yQCSIgQ/99aNd8ooNEGfUDRc=;
 b=PHbC7uWEHP1g6To2MEnv6PyE5GOr8iTehTl2DtAyhHiV5tRyuDr5gF/Hq1PQ0MBz8g+sevhtqRzvEHdkdQK0zBL63QekTW60yo842xGeVBPr+sddRp20S6v5HbpBVVd/sBWv0/0ikoHa9SIbVJNs3eEWn/zW5Xq+GW+KqWqMUf8=
Received: from HE1PR03MB3114.eurprd03.prod.outlook.com (2603:10a6:7:60::18) by
 HE1PR03MB3164.eurprd03.prod.outlook.com (2603:10a6:7:5d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 08:00:55 +0000
Received: from HE1PR03MB3114.eurprd03.prod.outlook.com
 ([fe80::7cc8:2d4:32b3:320f]) by HE1PR03MB3114.eurprd03.prod.outlook.com
 ([fe80::7cc8:2d4:32b3:320f%5]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 08:00:55 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Brian Norris <briannorris@chromium.org>,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Julian Calaby <julian.calaby@gmail.com>, svp <svpm@yandex.ru>,
        "felix+debian@gueux.org" <felix+debian@gueux.org>,
        Massimo Maggi <me@massimo-maggi.eu>
Subject: Re: Revert: ath: add support for special 0x0 regulatory domain
Thread-Topic: Revert: ath: add support for special 0x0 regulatory domain
Thread-Index: AQHXl3XA7B6urwS4+0SNCV8LjkYaTauBWEmAgAAxNoCAAA0dgIAAtssA
Date:   Tue, 24 Aug 2021 08:00:54 +0000
Message-ID: <4c44fdc2-8dde-8a98-8dd4-4b7e6b57a090@bang-olufsen.dk>
References: <YSJ//ki/A1EgfLga@skv.local>
 <CA+ASDXNzv6D1PthjUU-CVw6amT+JHmJP2mNSL=LVJKGm0zkEXw@mail.gmail.com>
 <YSQC32TygIq2SHJR@skv.local>
 <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
In-Reply-To: <CA+ASDXPi0RRd0gFYcON=XLu8ABwKKcRXf0j0QoCRnvDwGa0VyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none
 header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fa4cf23-50fc-4c66-9a65-08d966d54ccf
x-ms-traffictypediagnostic: HE1PR03MB3164:
x-microsoft-antispam-prvs: <HE1PR03MB31647CDB51980CC1D90CF93983C59@HE1PR03MB3164.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8MWjKL2rUdLcxx1jayWqEr7GxOyQRl5AuYv+YB3vv57BMJax0g6hOZJk9H+XlhqXa+fDBzFr4zEGqxAz3+gMqLrCcUSWZJZcOeXAfiZRnD7N3PoP32+v2GPrLGH1s7Ml1J/e1ZS4RUKbxYYdLqeP7kqwO76eQYrxx8IaEf7GKjYe5jtPokbIjMmTLNjT4Qqq1RfOhMM6HuDaStjjAWPZqGmTPJVAEmGnNeeC0GkyeIlJVxI3nyYb2Pb005Dj87GQwWWiLLkU6Jn3mWRyKhBJ+O2966sOKmnqXELSWObX+BmCZplb/7J2+BpIDIUkYDKnTaGI05fHYZOYvVcbNzhFdaxoRm23YHnQQpg4FWxVezi8P/XP1sjV5Rtqdkcvef/vr9nb2nzzyGULGxl8eC3UTwBlH7guQxJjfGhiJ/P9uhbLb1Mg39vzaXJlAplJ20pxvozz9U9+Y1VyWSgIkWkObIkTh2It6/n0qhkKeJKsLs1FrloKMTjPYjpkdBr9fwzR4107xwzIeQjiQCtWQ0+RNJtCLPPkKFLWQa+sgwyvD1NFC/ddeIwNhK1j5p/gS0Mw3ObDKHtho/tCixDJWeq/dDzgh8UmnSXlBQejWf0wKWku6sH9UCbJaAW2ExC1Si1PBMvi9x89CI8iigF6Le6RP1Uxr2Q0bjIKGlEqw26FEYU5XuwsHYBxihCg8Ji9QRvz0FDJiUdxm5IOGcP+wlxa5IaTJX1dmF8WBWkI3oXAL5RmOcGiYvzco8CkLzOuJAToEXPZJtrz7q7c9lG2LPwGTdsfmmDroRkkhidV/0M6lB9XH6E5MMLz/fyvqWKqhdRCSNs4dajtRPMeLj4st0OEv7x99Eo+DlYN0dYmwniqzXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3114.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(85202003)(4326008)(31686004)(8936002)(71200400001)(53546011)(6506007)(8976002)(8676002)(15650500001)(316002)(2906002)(31696002)(508600001)(85182001)(76116006)(26005)(6486002)(966005)(2616005)(186003)(83380400001)(6512007)(122000001)(38070700005)(66556008)(5660300002)(54906003)(66446008)(64756008)(38100700002)(66946007)(66476007)(91956017)(110136005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHZKTDh0WFplb2FBNlliY2NWei9hcHFVQ3FWeGFiVW5nSVk3dDBTdVc2V09n?=
 =?utf-8?B?VzV6bVFiRVUrT3BBV1lPcjRWR1dKVUFYcmVlUEZuUllOWWN6MW9JUEc4aG5O?=
 =?utf-8?B?Zkc2WExmVUpYZWpJazRyRGx6cm1uQndwK0JXTnBjTFN3MHYvSW00dmcvNmJL?=
 =?utf-8?B?NzcvWTZJSVBGRG8zeEVwQXUwUEo4RytMODdyZnFldE9tZ2xyREk3cXJPYTdJ?=
 =?utf-8?B?TGRPRE9ubXBDamVzRFhDMlB1b1pZUlpnRWhEc0ZQalZ1NTMrYlVqUmVSVHQv?=
 =?utf-8?B?enFxRW9WRW5wblhuYUxnaHdYNUJKL0F3Q1M5SGQ4VWVFNnVLek9sWjNWYTZJ?=
 =?utf-8?B?NFpRR1JwUEZDKzNLZUZJb21CeWxXZmNVVUk2L1V4Rzk3YXBiUVkxSENIZTFi?=
 =?utf-8?B?TVo0clJzVXd6b2IwSFJYUGhNbHpTS1BGYWxodjRMcURldm1RS1hWUXcyaW5H?=
 =?utf-8?B?UXpPQTNrL3k2dnNVbFNJWStxWTg1dkEydS9MRVVUSzZPUmVOUlRDSXlJVEJJ?=
 =?utf-8?B?Ky8wVTA1R0N5QXk4Q1dKcVFpaVVJRDU3UzkxTXJyVkUvOVk0QU4zejFTK1lq?=
 =?utf-8?B?T2JiaGpveDYxVlN4dHQyeGhhU2xvSE9hcDB0OENWakRFaDRyODlPVDZTRTBy?=
 =?utf-8?B?Z3JTZERrTXdtd1pPcGg4M3V3UUdYR3UySTZpT21iT3Urd3dmMWhKUmVNMnRT?=
 =?utf-8?B?cXBKUzc3MUM0NjZKMXFTcnc1d0Q4aThBNmJVaTVWeUlVTmhEQUtMdzNycHR6?=
 =?utf-8?B?MXVWRFpZNVJGYVQ2RFdIbkV5L1E5TER0My93MjRUK05rTnMzc21kSHV0N2dN?=
 =?utf-8?B?eSszNmZRN013VFpOOStKZXpXYjEzRnZFTFVJYnVMazRtd3N0QTBLUHpzN2Vm?=
 =?utf-8?B?UEZuLysxVkV4ZFBQZE9IbXBpNk50MXhNdHlhN2JiK1FVVC9rWmswUnQvM0Vu?=
 =?utf-8?B?NUNXemlOT2dVN0RIL2pBUFBEY3Y3V2FRZjNhYVVNRE1BNWRadWc1d1pmd0lV?=
 =?utf-8?B?NUtMOFFmL3ZkS1FmMWZFK2tGRFYyRnhDbFJlYW5DOHd3Ukh3RWdTdmhSaUpo?=
 =?utf-8?B?aWFkNlc2VjN1ejVFaEFpeVFKSjNYQWQ4Tk02bXgzbzBKNDQ3c3lxSTVqZHBW?=
 =?utf-8?B?d05TeERKSEF4RXlqTUpwUUtVSmlxTHQrUzByblNJTUlMRFJJUUNqSE1iSC9Z?=
 =?utf-8?B?cFZSQUc2MHlXWERqUlBSU3NiekhjRHUrM1VmTWJpak9GMnFVN0Qxc2lGSmNP?=
 =?utf-8?B?ZFVHTTR5cVhqRDBGdXh6R2kyUkg4bktVOTJLeVR6LzFEWFQxbnl2Ky9DOEtl?=
 =?utf-8?B?OEcwdVAvWnVBT1JkUUIyR0R2Vmt0MDFQNHpic3RYWnRSSFpEVC85TEFNbFZi?=
 =?utf-8?B?cm5WbUo0TWJTdEkzUEdhQzJYTVpEbVVWa3d0TFlOK1RNS0Q4ajVqL2pDWFJ6?=
 =?utf-8?B?SjdPSmdpb05EdzMzbHZMb2R5Y0haaHpEcisremRRL3F1SEUzSXpPWVBYdHow?=
 =?utf-8?B?dVQxd0pybWxHUTNNMlcramp5QklEZFV6SUZKSkkvVC9Idyt4K1hMWUR6Wm1B?=
 =?utf-8?B?dXhrV2VFd3YwRXRRYW4wZXpuTDVlYm1oTmNvV3lOK1VlT3FUcEhDQ1NadFZP?=
 =?utf-8?B?Q1J4SUxzNFpla0JYcWh6STAvQWhlM2RmaThWcWsyaE9rVDRpdnB4Z1lKTGNm?=
 =?utf-8?B?alBmelIvSTRVd2pqNDdwRkF0ZmNnSlF0Q3JES3R0TEZYVC9pRENXM2NidHNj?=
 =?utf-8?Q?nCw4noxLS6K46Vq2KW43xS39G69IXJAbfcXGmc6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D670AD28A0818443AE3005385599FEF6@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3114.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4cf23-50fc-4c66-9a65-08d966d54ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 08:00:54.9908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+P+4AV15JnBBddDaM0W0ZD8uH6WxhxNCSehY4/iEYdpCKEHGYErIUAHCWFhGMi4pLmjOHM+plIB15oUZnpp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3164
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gOC8yMy8yMSAxMTowNiBQTSwgQnJpYW4gTm9ycmlzIHdyb3RlOg0KPiBPbiBNb24sIEF1ZyAy
MywgMjAyMSBhdCAxOjE5IFBNIEFuZHJleSBTa3ZvcnRzb3YNCj4gPGFuZHJlai5za3ZvcnR6b3ZA
Z21haWwuY29tPiB3cm90ZToNCj4+IE9uIDIxLTA4LTIzIDEwOjIzLCBCcmlhbiBOb3JyaXMgd3Jv
dGU6DQo+Pj4gTWF5YmUgaXQgbmVlZHMgYW4gTnRoIHBlcnNvbiB0byBzdWJtaXQgYSByZXZlcnQ/
DQo+Pg0KPj4gTGF0ZXIgKERlYyAyMywgMjAyMCkgc2FpZCAiQWN0dWFsbHkgSSBkb24ndCBzZWUg
aG93IEkgY291bGQgYXBwbHkgdGhlDQo+PiByZXZlcnQgZHVlIHRvIHRoZSByZWd1bGF0b3J5IHBy
b2JsZW1zIGV4cGxhaW5lZCBieSBKb3VuaSIuIFsxXQ0KPj4gSSB0aGluayB0aGlzIGNvdWxkIGJl
IHRoZSBkYXRlIHdoZW4geW91ciBwYXRjaCB3YXMgbWFya2VkIGFzIFJlamVjdGVkLg0KPj4NCj4+
IDEuIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9hdGgxMGsvMjAyMC1EZWNl
bWJlci8wMTIzNzAuaHRtbD4+IA0KPiBPaCB3b3csIEkgYWxtb3N0IGZvcmdvdCBhYm91dCB0aGF0
Li4uIFRvbyBtYW55IHRocmVhZHMuIEkgYWxzbyBmb3Jnb3QNCj4gdGhhdCBJIGFscmVhZHkgcmVw
bGllZCwgZXhwcmVzc2luZyBteSBkaXNhZ3JlZW1lbnQ6DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL3BpcGVybWFpbC9hdGgxMGsvMjAyMC1EZWNlbWJlci8wMTIzNzIuaHRtbD4+IA0KPiBC
dXQgSSBndWVzcyBpdCdzIG5vdCByZWFsbHkgZXhwZWN0ZWQgdGhhdCBtYWlubGluZSBMaW51eCBy
ZWFsbHkgd29ya3MNCj4gYXMtaXMgb24gbW9zdCBwcm9kdWN0cywgdW5mb3J0dW5hdGVseSwgYW5k
IHRoZSBtYWludGFpbmVycyBkb24ndCBoYXZlDQo+IGVub3VnaCB0aW1lIG9yIGVuZXJneSB0byBw
cm92aWRlIGNvbnN0cnVjdGl2ZSBwYXRocyBmb3J3YXJkIG9uIHJlYWwNCj4gaXNzdWVzIGxpa2Ug
dGhpcyA6KA0KDQpKb3VuaSBnYXZlIGEgZ29vZCBleHBsYW5hdGlvbiBmb3Igd2h5IHRoZSBvZmZl
bmRpbmcgcGF0Y2ggaXMgY29ycmVjdCwgDQpidXQgaXQgaGluZ2VzIG9uIGFuIGludGVycHJldGF0
aW9uIG9mIGNvdW50cnkgY29kZSAweDAgd2hpY2ggc2VlbXMgdG8gYmUgDQppbmNvcnJlY3QuIEkg
Zm9sbG93ZWQgdXAgb24gdGhhdCBhbG1vc3QgYSB5ZWFyIGFnbyBoZXJlWzFdIGJ1dCB0aGUgDQp0
aHJlYWQgd2VudCBjb2xkIGFmdGVyIHRoYXQuDQoNCk51bWVyb3VzIHBlb3BsZSAtIG15c2VsZiBp
bmNsdWRlZCAtIGhhdmUgY2l0ZWQgc291cmNlcyBjbGVhcmx5IA0KaW5kaWNhdGluZyB0aGF0IDB4
MCA9IFVTLCBOT1QgdW5zZXQuIFNlZSB0aGUgc2FtZSBwb3N0WzFdIGZvciBtb3JlIGluZm8uDQoN
Ckkgc3RpbGwgdGhpbmsgdGhpcyBwYXRjaCBzaG91bGQgYmUgcmV2ZXJ0ZWQgdW5sZXNzIHNvbWVi
b2R5IGNhbiBwcm92aWRlIA0KYSBzb3VyY2UgdG8gdGhlIGNvbnRyYXJ5LCByZTogdGhlIG1lYW5p
bmcgb2YgMHgwLg0KDQpJdCdzIHVuZm9ydHVuYXRlIHRoYXQgdGhpcyBpcyBzdGlsbCBhZmZlY3Rp
bmcgdXNlcnMsIHBhcnRpY3VsYXJseSB3aGVuIA0KdGhlIG9yaWdpbmFsIGF1dGhvciBvZiB0aGUg
cGF0Y2ggZXZlbiBhc2tlZCBmb3IgaXQgdG8gYmUgcmV2ZXJ0ZWQuWzJdDQoNCglBbHZpbg0KDQpb
MV0gaHR0cHM6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9hdGgxMGsvMjAyMS1KYW51
YXJ5LzAxMjM3NC5odG1sDQpbMl0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hdGgxMGsvOWNj
N2VmYmIzYzliMjllNDU1M2E0MjdlNmY1ODcyNWZAY29kZWF1cm9yYS5vcmcv
