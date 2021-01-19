Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF19C2FC3B5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbhASOgj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 09:36:39 -0500
Received: from mail-eopbgr50109.outbound.protection.outlook.com ([40.107.5.109]:32892
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389419AbhASKEb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 05:04:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUB+nZAj7fX1lQpjrh7x2M8rmpgMup6D5ZPUkUZUh1ZoDetBwAYNcJWtw2etqeDV8UvfQbGosbZcPwI16uDWke+8upepKDUR05zjuooHJULUEig6Nly13RFhP1E9BOpRmEE04L23OeDG/sg8rVG9N5qsj9yI+5eViJltf5DHb07J/wChCrN7nYsiOwIlmlSyPKZxjNWO0ANuVmZWh5TWmuU4hqF2bdVsyEA95t+P6KhkhijBeBVlYB1QenEsCsh16ynb/G2By7HsfcuIt8tRpQDxZhsvVq928B7g5KuhJnzldyUgDl9ON4lt3RpASYQdnvWdNLphsA2b8WaGIzTpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEv7d1YdW2MIQzwr8BNrO7OT/QuOmKrLqSlMVBckxGg=;
 b=eglvDxl2ElbUewbualW2ingspvleSfRXt29cLiQSC5olHzM1kRmUlrubEwvIGKNnjjYxY1qt6Xeh6zIiCoeT3JF8eYpk3xicnhlEuiaYzivbTjg5E1k+E58MmTT2B+IzXlAKfbW7YC1d3UC7+BXvtDT/5t6b6lvDn+LIOVOwQUdcGzrnEIcbzvxlKgUBlUnSrCItJYmsAB6ZN++6ztzSKY7Qh+7EplGJXjpfwZHgArwMCp9qD7myZEHMPktSExZiHaLzxVKj+yvRJXlBQ231ohOaJX4yutqLs1xzJS9KinqWl7/jQTY7AyMajyxpaQlbbk4OCTG/Y/JsvWMraGGLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEv7d1YdW2MIQzwr8BNrO7OT/QuOmKrLqSlMVBckxGg=;
 b=AHHXhh7ozf05JkvjrZLmoCmhI8xZQBQugvpoqMaiAV7Y4AsI89CnTkiGmuFQQlHbBVOwX0O1qVicetKHzIbQeW3ebcM5Fxnx8k94US+m7f3uFS6B1dTas3gwheYQmW8wmCXRGSQM1mct03ctitgxYluLu78Haw7AJ6BCTdWvqCk=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR0302MB3424.eurprd03.prod.outlook.com (2603:10a6:803:1c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 10:03:18 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::41f1:9e49:1cd0:55c8]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::41f1:9e49:1cd0:55c8%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 10:03:18 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
Thread-Topic: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
Thread-Index: AQHW6pNzTQg04I/KVkmfDUZ99gM7aqoou1WAgAANGICABd0lgIAAGeSA
Date:   Tue, 19 Jan 2021 10:03:18 +0000
Message-ID: <57258d85-15da-896e-3570-e61c89a02b10@bang-olufsen.dk>
References: <20210114163641.2427591-1-alsi@bang-olufsen.dk>
 <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
 <3a7de182-b0c7-352c-323b-3e3cebb9ffa3@bang-olufsen.dk>
 <2b070521-b995-371f-d853-37cffc1a546a@broadcom.com>
In-Reply-To: <2b070521-b995-371f-d853-37cffc1a546a@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none
 header.from=bang-olufsen.dk;
x-originating-ip: [193.89.194.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d16dd95-56a2-4ce7-37ea-08d8bc61720f
x-ms-traffictypediagnostic: VI1PR0302MB3424:
x-microsoft-antispam-prvs: <VI1PR0302MB34245F1FEF46BCFF073CED9383A30@VI1PR0302MB3424.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJKsb/dDfEOS16zWhVn/cWoivtm3D4cLK7vs2wg9x4FSG47AsK8+JonDDhDNQUvZVhi8o5rnlxd5ugSQ5/Y1E2Q4nPNQsWi/whYeawBq9/95/QritEnJlPOl2wmTTLlcG5K9A3FJuhlBkY7aLOsldNqELY+t3tM26oR/veimhhIF0TqNSItcAp1cCEToJ0q77xgBu5FJ93qQ7DWjcBQry1aBBEQeg/7HiObo+H432yZ7cGeWqT2hxoEcui2jqTUO0Wrrs2Lfprp7bemtKP1XPXOK0n5/RWd/OHIoSqh+6zkD/wLRbehtik1EjqBz/ZQBoKdR890K5XYIflR+6pWmC8Apli55iSYk6EHrrkD8zjgwt9vC7k3l0bzwaxfl578ak3a0VAdv+E9WCBd63wN43/+dIuol+Nzh7XPE63dhTIShjG0u/BEKzHjQBA4CrLamDezKdmM7AfhhzL//99rhPs0+0CdircBa3wWWiRIF4wTvgUKDRuIWnnW3DaSbOPR9hLhjVGSNks9jCLll72zkuU83CyaZFBTe33swQ9g7EPcgB/EBDZ8iKOVOkYwZz+c3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(2616005)(110136005)(54906003)(7416002)(31696002)(8676002)(26005)(64756008)(66446008)(316002)(66556008)(86362001)(4326008)(36756003)(966005)(6506007)(6512007)(2906002)(5660300002)(66476007)(85182001)(478600001)(53546011)(6486002)(8936002)(8976002)(85202003)(83380400001)(186003)(76116006)(91956017)(66946007)(31686004)(66574015)(71200400001)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M2MyQ1JFQU4rWHoyclhIU3owY0swMmZKUXh0anQ2T2NqZHRaaDJxVDhsNXF1?=
 =?utf-8?B?RGFrSU04aTVQWHBmanlDK2RMdC9GdWdMTERsSzdPdHoxNHlFRENKTkRWRjVN?=
 =?utf-8?B?VnlsWTBBS2VkUzZsaWJpdHBEaWdLOGdHL0ZqVy9QMjUvMC9EUFZiaHhXQU0z?=
 =?utf-8?B?VGlkMm1hWUl2Y0p6ZDBWbGgxdDlBVUt0NVV4YUE4aUlPbnlGYTkwcGd4Rkxw?=
 =?utf-8?B?ODRJRi95bjluR0dXMm5uMUp4RnQvQTg5T0tQVU5KWU9XVUwrSnVXbnJmcjNJ?=
 =?utf-8?B?Um55aE1OL0QxSGtOanlFdVo1THNlbWJyeHFPMTFZa3ZRWEk0cmdKWjY5Vll5?=
 =?utf-8?B?SmhHem9ONENFb0pFcXRjcEFveVBEL0VoR2lFYUpWS05uVkZVZHpZbUdBbEdQ?=
 =?utf-8?B?OUhXRmVCeEtCa2IrM25aY0NQNW9BT3laVmF3RkJPZUUxQ2RHemJNYU9Mb09E?=
 =?utf-8?B?VW5sSXFpSVBCZnM5cnV5TUZVbFVrWnFQL3BSKzIrb0Y1M2EyVzZMMWtrdHBE?=
 =?utf-8?B?MEY5MVhYWjdzYzV5S2hPcG9IcVJ4Rk5YY2ZOYzZZTWpNcEV0NHFETXNYRWVX?=
 =?utf-8?B?MnRhcGlQRnJYSys0dzJhbjdFelkzWmRwaVBIQSsvYXE1eHBHQ0RYWmZpWW9q?=
 =?utf-8?B?TzZadWo0aVFoZmpIU2lWWldtb2VVcGNUL0wrelV1ZkJuMzBEeFBPZU5RRXlz?=
 =?utf-8?B?eFhINUVLemEvRDYzdzNRcVNtYURGY0VyYXZhck1mdXdCUFJYQWFyN0dSQmhx?=
 =?utf-8?B?cmFZK3c0S0V0WnNSVTBwZFppV2pIT0pOODVGQlhvSnAvN1BBT0JsMEZ2SXVm?=
 =?utf-8?B?V0xXY0lsSm1YSE41Y3h4S0l5MTVZdlliWjFMcmg4ejRZUm10bCsrSDZucXhX?=
 =?utf-8?B?M1BRQ3VrUVF0Z0lBeW9LcHJNdGlneGZJMXJhUjhQYVIzNXRtMlkyb0g0clRm?=
 =?utf-8?B?bXNZZXllblpYeVJsS0ZIM1VJdDF6UzdXQ0V5NmI4cnVLb2tURnlwNlBjZlZS?=
 =?utf-8?B?VTRGRnBRNVdBUHU1eHU4dU1oRDRaK0ZsVk9vMWVYSzdHOFZmaVRJT1F5Y01z?=
 =?utf-8?B?RUJyVmRSSFRYRk9MdjBZcXJSTmtPTzg0UjBaK2I2RFJMc2owaWRwQlZCYmYw?=
 =?utf-8?B?YS9acFNlUTNyeGR0Z3FDVTJJaEJDRVlCRnE0dmxRZElvcjd4c3NHVzk1VXY0?=
 =?utf-8?B?ek1OKzEya3pDQmM5dk1PWVZDalhpWXFpVTlpb2s2SFBUOCt1ZE1mNmxTelFq?=
 =?utf-8?B?eVJ3Mm52K0pmdndsL0htalJBbnhXUE9sODZjMml4ZkJIYUFvSnUwQjF4MGlK?=
 =?utf-8?Q?fQW9eJvjzjZouM/H+60H2jiW9rlgZ255Vu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <98F12F261481844D87833E92244CD246@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d16dd95-56a2-4ce7-37ea-08d8bc61720f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 10:03:18.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqHA5pAYtnZNpfn9jKyYd/Gzm0t8z96vhQGmys5p2CjkSh/79613+wu2ycy/O0mYp0adY3XqNhwJkgVl6nZVDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3424
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCk9uIDEvMTkvMjEgOTozMCBBTSwgQXJlbmQgVmFuIFNwcmllbCB3cm90ZToNCj4gT24g
MS8xNS8yMDIxIDM6NTcgUE0sIEFsdmluIMWgaXByYWdhIHdyb3RlOg0KPj4gSGkgQXJlbmQsDQo+
Pg0KPj4gT24gMS8xNS8yMSAzOjEwIFBNLCBBcmVuZCBWYW4gU3ByaWVsIHdyb3RlOg0KPj4+ICsg
Sm9oYW5uZXMNCj4+PiAtIG5ldGRldnMNCj4+Pg0KPj4+IE9uIDEvMTQvMjAyMSA1OjM2IFBNLCAn
QWx2aW4gxaBpcHJhZ2EnIHZpYSBCUkNNODAyMTEtREVWLUxJU1QsUERMIHdyb3RlOg0KPj4+PiBB
ZGQgc3VwcG9ydCBmb3IgQ1FNIFJTU0kgbWVhc3VyZW1lbnQgcmVwb3J0aW5nIGFuZCBhZHZlcnRp
c2UgdGhlDQo+Pj4+IE5MODAyMTFfRVhUX0ZFQVRVUkVfQ1FNX1JTU0lfTElTVCBmZWF0dXJlLiBU
aGlzIGVuYWJsZXMgYSB1c2Vyc3BhY2UNCj4+Pj4gc3VwcGxpY2FudCBzdWNoIGFzIGl3ZCB0byBi
ZSBub3RpZmllZCBvZiBjaGFuZ2VzIGluIHRoZSBSU1NJIGZvciANCj4+Pj4gcm9hbWluZw0KPj4+
PiBhbmQgc2lnbmFsIG1vbml0b3JpbmcgcHVycG9zZXMuDQo+Pj4NCj4+PiBUaGUgbW9yZSBJIGFt
IGxvb2tpbmcgaW50byB0aGlzIEFQSSB0aGUgbGVzcyBJIHVuZGVyc3RhbmQgaXQgb3IgYXQgbGVh
c3QNCj4+PiBpdCByYWlzZXMgYSBjb3VwbGUgb2YgcXVlc3Rpb25zLiBMb29raW5nIGludG8gbmw4
MDIxMV9zZXRfY3FtX3Jzc2koKSBbMV0NCj4+PiB0d28gYmVoYXZpb3JzIGFyZSBzdXBwb3J0ZWQ6
IDEpIGRyaXZlciBpcyBwcm92aXNpb25lZCB3aXRoIGEgdGhyZXNob2xkDQo+Pj4gYW5kIGh5c3Rl
cmVzaXMsIG9yIDIpIGRyaXZlciBpcyBwcm92aXNpb25lZCB3aXRoIGhpZ2ggYW5kIGxvdyANCj4+
PiB0aHJlc2hvbGQuID4NCj4+PiBUaGUgc2Vjb25kIGJlaGF2aW9yIGlzIHVzZWQgd2hlbiB0aGUg
ZHJpdmVyIGFkdmVydGlzZXMNCj4+PiBOTDgwMjExX0VYVF9GRUFUVVJFX0NRTV9SU1NJX0xJU1Qg
KmFuZCogdXNlci1zcGFjZSBwcm92aWRlcyBtb3JlIHRoYW4NCj4+PiBvbmUgUlNTSSB0aHJlc2hv
bGQuIEluIGJvdGggY2FzZXMgdGhlIHNhbWUgZHJpdmVyIGNhbGxiYWNrIGlzIGJlaW5nIHVzZWQN
Cj4+PiBzbyBJIHdvbmRlciB3aGF0IGlzIGV4cGVjdGVkIGZyb20gdGhlIGRyaXZlci4gU2VlbXMg
dG8gbWUgdGhlIGRyaXZlcg0KPj4+IHdvdWxkIG5lZWQgdG8gYmUgYWJsZSB0byBkaXN0aW5ndWlz
aCBiZXR3ZWVuIHRoZSB0d28gYmVoYXZpb3JhbA0KPj4+IHNjZW5hcmlvcy4gQXMgdGhlcmUgaXMg
bm8gb2J2aW91cyB3YXkgSSBhc3N1bWUgdGhlIGRyaXZlciBzaG91bGQgYmVoYXZlDQo+Pj4gdGhl
IHNhbWUgZm9yIGJvdGggY2FzZXMsIGJ1dCBhZ2FpbiBpdCBpcyB1bmNsZWFyIHRvIG1lIHdoYXQg
dGhhdA0KPj4+IGV4cGVjdGVkL3JlcXVpcmVkIGJlaGF2aW9yIGlzLg0KPj4NCj4+IEl0IHdpbGwg
b25seSBwcm92aXNpb24gdGhlIGRyaXZlciBhY2NvcmRpbmcgdG8gYmVoYXZpb3VyICgxKSBpZiAw
IG9yIDENCj4+IHRocmVzaG9sZHMgYXJlIGJlaW5nIHNldCBBTkQgdGhlIGRyaXZlciBpbXBsZW1l
bnRzDQo+PiBzZXRfY3FtX3Jzc2lfY29uZmlnKCkuIEJ1dCBpdCBzYXlzIGluIHRoZSBkb2N1bWVu
dGF0aW9uIGZvciB0aGUNCj4+IHNldF9jcW1fcnNzaV9yYW5nZV9jb25maWcoKSBjYWxsYmFja1sx
XSB0aGF0IGl0IHN1cGVyc2VkZXMNCj4+IHNldF9jcW1fcnNzaV9jb25maWcoKSAob3IgYXQgbGVh
c3QgdGhhdCB0aGVyZSBpcyBubyBwb2ludCBpbg0KPj4gaW1wbGVtZW50aW5nIF9jb25maWcgaWYg
cmFuZ2VfY29uZmlnIGlzIGltcGxlbWVudGVkKS4gSW4gdGhhdCBjYXNlLCBhbmQNCj4+IGlmIGp1
c3Qgb25lIHRocmVzaG9sZCBpcyBzdXBwbGllZCAod2l0aCBhIGh5c3RlcmVzaXMpLCB0aGVuIGEg
c3VpdGFibGUNCj4+IHJhbmdlIGlzIGNvbXB1dGVkIGJ5IGNmZzgwMjExX2NxbV9yc3NpX3VwZGF0
ZSgpIGFuZCBwcm92aWRlZCB0bw0KPj4gc2V0X2NxbV9yc3NpX3JhbmdlX2NvbmZpZygpLiBJIGd1
ZXNzIHRoZSBpbXBsaWNhdGlvbiBoZXJlIGlzIHRoYXQgdGhlDQo+PiB0d28gYmVoYXZpb3VycyBh
cmUgZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQuIEknbSBub3Qgc3VyZSBJIGNhbiBhcmd1ZSBmb3IN
Cj4+IG9yIGFnYWluc3QgdGhhdCBiZWNhdXNlIEkgZG9uJ3QgcmVhbGx5IGtub3cgd2hhdCB0aGUg
c2VtYW50aWNzIG9mIHRoZQ0KPj4gb3JpZ2luYWwgQVBJIHdlcmUgc3VwcG9zZWQgdG8gYmUsIGJ1
dCBpdCBzZWVtcyByZWFzb25hYmxlLg0KPj4NCj4+IEFzIGEgc3RhcnRpbmcgcG9pbnQgLSBhbmQg
c2luY2UgdGhlIGZpcm13YXJlIGJlaGF2aW91ciBpcyB2ZXJ5IGNsb3NlDQo+PiBhbHJlYWR5IC0g
SSBpbXBsZW1lbnRlZCBvbmx5IHNldF9jcW1fcnNzaV9yYW5nZSgpLiBJIGhhdmUgYmVlbiB0ZXN0
aW5nDQo+PiB3aXRoIGl3ZCwgd2hpY2ggYnkgZGVmYXVsdCBzZXRzIGp1c3QgYSBzaW5nbGUgdGhy
ZXNob2xkIGFuZCBoeXN0ZXJlc2lzLA0KPj4gYW5kIHRoZSBkcml2ZXIgd2FzIHNlbmRpbmcgbm90
aWZpY2F0aW9ucyBhcyB3b3VsZCBiZSBleHBlY3RlZC4NCj4gDQo+IE9LLiBJIG92ZXJsb29rZWQg
dGhhdCB0aGVyZSB3ZXJlIHR3byBkaWZmZXJlbnQgY2FsbGJhY2tzIGludm9sdmVkLiBTbyBJIA0K
PiB3aWxsIHJldmlldyB0aGUgcGF0Y2ggd2l0aCB0aGF0IGtub3dsZWRnZS4gV2hhdCB3aWZpIGNo
aXAgZGlkIHlvdSB0ZXN0IA0KPiB0aGlzIHdpdGggYW5kIG1vcmUgaW1wb3J0YW50bHkgd2hpY2gg
ZmlybXdhcmUgdmVyc2lvbj8NCg0KQWxsIHRlc3Rpbmcgd2FzIGRvbmUgd2l0aCBhIFBDSWUgQ3lw
cmVzcyBDWVc4ODM1OSAoTXVyYXRhIFR5cGUgMVZBKS4NCg0KSSB0ZXN0ZWQgd2l0aCB0d28gZmly
bXdhcmVzOg0KDQoxLiBBIGN1c3RvbSBmaXJtd2FyZSBmcm9tIEN5cHJlc3Mgd2l0aCBzb21lIHZl
bmRvci1zcGVjaWZpYyBmZWF0dXJlczoNCiAgICB2ZXJzaW9uIDkuNDAuOTguMTkgKHI3MjcxNTQg
Q1kpIEZXSUQgMDEtMWZmMWMzMA0KDQoyLiBUaGUgbGF0ZXN0IHB1YmxpYyBmaXJtd2FyZSByZWxl
YXNlIGZyb20gTXVyYXRhWzFdIGZvciB0aGlzIGNoaXA6DQogICAgdmVyc2lvbiA5LjQwLjEzMCAo
cjcyNDg1NSBDWSkgRldJRCAwMS05YWUyY2Q2ZA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoN
ClsxXSBodHRwczovL2dpdGh1Yi5jb20vbXVyYXRhLXdpcmVsZXNzL2N5dy1mbWFjLWZ3DQoNCktp
bmQgcmVnYXJkcywNCkFsdmlu
