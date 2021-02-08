Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FD7312F36
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 11:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhBHKkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 05:40:43 -0500
Received: from mail-eopbgr80124.outbound.protection.outlook.com ([40.107.8.124]:10113
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232654AbhBHKi3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 05:38:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUafPdFA+/ppVzpRp8wqFoMAokXDN6K9Wu6qsOK/MBgj5zlDWfAI1YQ+AVqChJxE90UyBJcg6fGQgc6DyJtTs1vLB0k6Iz4ic0+QvdNfU6jclhEpW1ugEKPFdpJGvOxr9SIeGTP1ym9q2pI9oZOEbi2LI6YVsJpXS9u4uOC0cmrI/BNWJhrArnwrq+JxJa20pWmMOtsDcxMdBgEePzmPPgwRXnjVjbklNkeQkyH/H0BKboJUVNDmf3jtkW+OV+Wzh1KNQeF6oMcF9LlGiB+SwKMW+XWlq1M3r3cqMFQYwG1U0HLol98rHsxCM0Hj5PL1A6/jbTJZymgUibo/XViCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwDjS5BDF8UZafJl6aBW/DfaBWnOPugWUiv1cpl7Oy4=;
 b=JSg4X8gmuZcX4dL7OrvQibVQMf7569JvqXQZ8cmHKuvHJmYKuTjBTd65EyCARAGFAuat4rtGYu9kqZswJb0yLHqc5N5f+2jGiFHNZuZZoUmhMG9pdHjWzczDGKldMsIMIifYjZN4ook4ZaBAIJFrIZNh6Tq6eUFU7kOeuuqWlwrVc2+ehjteZKY8kPn+E41S1LXpftQngdmDpOSbjkkEMXQQBcHxOD9T2vH8CH+uYkZD9TkUsXDWqY7ULvF8rlSXhbA11uxZFTGDFkupJ6NgV1zazHyV5QoXwbYF5xF3+ZL3GphvqkNoWmDBZ/c4RuwTqBXHrPm/B2SzTqMpMs5KgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwDjS5BDF8UZafJl6aBW/DfaBWnOPugWUiv1cpl7Oy4=;
 b=mxQbIEAG/a9k5GERa1WJtnWIURXD5Q3eZViCgTLGHcjJ7bD69IlUgrrgdd05D6IW4viCDASDteASsOfwC08vNvZBZq2MK1vtd9YF5/AF1juzyS60NOnMqcfu/dsKLAGXndZwyjoIvQrzGgNRjdHtppDPaFiZ22aYbvMQLrHiOjc=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB4510.eurprd03.prod.outlook.com (2603:10a6:803:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 10:37:40 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::41f1:9e49:1cd0:55c8]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::41f1:9e49:1cd0:55c8%6]) with mapi id 15.20.3805.028; Mon, 8 Feb 2021
 10:37:40 +0000
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
Thread-Index: AQHW6pNzTQg04I/KVkmfDUZ99gM7aqoou1WAgAANGICABd0lgIAAGeSAgB94O4A=
Date:   Mon, 8 Feb 2021 10:37:40 +0000
Message-ID: <ea33613a-6ac9-ad80-4bfc-192bf5ddc722@bang-olufsen.dk>
References: <20210114163641.2427591-1-alsi@bang-olufsen.dk>
 <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
 <3a7de182-b0c7-352c-323b-3e3cebb9ffa3@bang-olufsen.dk>
 <2b070521-b995-371f-d853-37cffc1a546a@broadcom.com>
 <57258d85-15da-896e-3570-e61c89a02b10@bang-olufsen.dk>
In-Reply-To: <57258d85-15da-896e-3570-e61c89a02b10@bang-olufsen.dk>
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
x-ms-office365-filtering-correlation-id: acf88aae-9ca1-4c78-0fa6-08d8cc1d8f4d
x-ms-traffictypediagnostic: VI1PR03MB4510:
x-microsoft-antispam-prvs: <VI1PR03MB4510D00FDC89696BA681D456838F9@VI1PR03MB4510.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUquWbUvLu+Q4Z/K6Jw6Vh4DC1ACSzo1seuI1kLAtIfsEjV9nq4IHMM1NHdF7oE4nHy9+8vI8c5+Z/fWlxgKAEzQ+drD7li3a/o0K5tBzLSyAYsmGMlnw+yLuoEuJEn6NCjdmaa2mq6yJqBo9tLuql30jlO1NixUkr/o1qzgt6NHxncbFl+VO+uKDYurUrUs86rU3cLjx0D2Zr8wC3Qra0WST6mAK+cEhAY9mX75qMk2hru+Nuyeg8KhHqmOFo2KiPH90RQQosNxqLd8jRqRUVUJKFaYsoQrIw3YKipPsnp6NhSjwDA8HZZosodz4FoovHaqP5YVkQgco684/zWGhBysMc3p1RvazXfI7VjAqI/WWNd5pbYRl3nPA/uQN8buJSXDok0ACIPfDp7Iar6CVndtcfl8KN1j17SZ9yAJ4inqlX8iY/8OA7F7rZdwCktUdIi0y/yC+vzD+AOdKB+7vK3Nm7jfN0xxYNivPtksIWg8XAlrK/PLoHMgD0KRyz5xqj1svnxssQOG7uFLIcQvIZYNauvoTqAMXNFInYAPIg0TibgInIiBGiZOKUG27VFZ4pCI8J7e6Gf6eYccVw97sa2YejS7aCMLVwXMSKZzXmBBNw94gPTMLBI59XU9SWmQjgnmTR15DtvmuLhz7fWYtPvnJsWmTx90LqVMpTlj1EjFZORZp/x6hlysLfT7/HQR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(136003)(366004)(376002)(31686004)(5660300002)(91956017)(76116006)(66446008)(66556008)(64756008)(66476007)(66946007)(8676002)(66574015)(85202003)(8976002)(8936002)(36756003)(6486002)(6512007)(83380400001)(4326008)(86362001)(15650500001)(110136005)(54906003)(26005)(31696002)(6506007)(53546011)(186003)(2906002)(966005)(71200400001)(7416002)(85182001)(2616005)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NVNka3dXSmc5SlM4eWdnYVF3SWh0aGlRWWd6dUx0aDVZNzBlVWZVOWJhUEdR?=
 =?utf-8?B?VWhjR3B6RmlqL0d4REJWY21jQVYxaXJiWGJ0aUZBZUhXRWVDKy95UTg2SVRN?=
 =?utf-8?B?ZmNKMGpBOVVXYXUveDBkTEVCbFc2Rm1kUkg0V1I0MkloNkloNlNMTkhqSG9l?=
 =?utf-8?B?NjI1OFcyeDRmTGM4VWtXc3YySGhvZlpPdVZBK1d5cXVtVWVxR3FlU0ZTUlVV?=
 =?utf-8?B?eUdOQkZRdHZzSFh2Q1VDV1FFOUNDU1o2bE5CcVpoMit0VVk2VU1yUXA0eW1B?=
 =?utf-8?B?aDRyL093RHB2dTd0MkR3NnJJRXlsdVg1eW5zQ2xRUDJkc0FGNnJ0MEIwaTIw?=
 =?utf-8?B?eW5OV2Voc0FiTEhoS1JSWW1ZallqNjZPaWt0U2pFUTlLMXJOZXJYWFZQenVo?=
 =?utf-8?B?Vnc3TlhRU3pnaFB3aWxxSzJKeGZseVdGcXM5OVR1bTNLQmw5QVRzVXgrSE5w?=
 =?utf-8?B?cVZwclV5MU5qamZuRFFyZlhvWC9ia01ZY3YyMUVlUEpNa05UUHgrNGFjcTJq?=
 =?utf-8?B?dDA2V2w1UDh1SktwcVFVSGhhSm9ZYTB6RXp5UHdrK0FQd0Nvc0JvUXdMRGlV?=
 =?utf-8?B?TXErSEhSL2NQYzVrdzRTV0Q3SXRVc0tTZXlRYXN5OHRCd2g3NUFEK0lTTk5E?=
 =?utf-8?B?Wmdab3RoR0t6RDE5S2ZiSHFlVFlHNnBuUDVWR3RRMHIrM1YvNG1kTlVRdi91?=
 =?utf-8?B?SFJwY2xnRjljTkpDSWo3aTZIM2o0OHMrUTQvaFIrZm9INUY3QndMRGFNS3pZ?=
 =?utf-8?B?RzFjN3dDZUhHeHpqUEY3b1ZmK0RDbmhuem5jQVBmS29DYXJ6ZktsdG9xenl1?=
 =?utf-8?B?WnFGK0ZhcElXaVE1KzVCVWNpQ01kYTRHWm5CQm9FZXRZOTJtblJTL1R5QjNL?=
 =?utf-8?B?WXE5MWFkVFdYOG9MTWdMcG5jK2ptZXZPSFBlMU13Skk3QkQ3VUQvNVlnR21M?=
 =?utf-8?B?bXkwR1k0R3RiZDJEQXJuM1RKdFB6Qm5NTEIyQzJ2WWhnYXBaYVZLdDRkaWFk?=
 =?utf-8?B?cmRhSk9FdC8rZFJlOG1OanJRSUYxSTYrWTU4c2c5aTRlbElxVG1KN29tRFJH?=
 =?utf-8?B?MEhSUEhEMGRjaDE1aWwwRHdjbHN2UGdPUDVQbWpOL2Z5VnY3Uk1BR2o1RUds?=
 =?utf-8?B?S3lwRjh4UGQvOGR4cldxOGhmV0Q3TDBHTzUyejJRRG91WjdadGdtKy9NN1pu?=
 =?utf-8?B?RkpFUUZ3cUdmSHVjMVZKbXJQN21jbmhSQnBCL0NlWDFVbnY5MXJuY25JWHZm?=
 =?utf-8?B?SEtRTjlRYUZ6eWJ2Q1QzQzhtMWtTa0ppMEY2V092SnU2QkkxUDVuOU9rQkJm?=
 =?utf-8?B?eDNNSEpWVTdvdWtGLzVndUlOWldjQm1HcWU3dHMySTFaZ3pzYzhNdUZjVTN2?=
 =?utf-8?B?S0lUcjltb2J3ZXpXWXh5MWovaitFMXltRytTNjBWdU1SNkhoVytPT1p3UUtP?=
 =?utf-8?B?YVBCZGh4YjB2N1liUC96OEtpVnNOOXFTS01NNXFERi9taEhQWUlIcHhuSUI4?=
 =?utf-8?B?bSsvTWFMRUtBaVJpSFBlVm9pN1VyTldHNjZxSkVZdVlsWEhYcjRNVTBXYXpl?=
 =?utf-8?B?MFFSS21wMyt2LzhJWEQ1RnZBNk5kVVBKcFdVczBzZDFkYndVMmJ0ZCtCOGw1?=
 =?utf-8?B?dU4rWk84REo0RXJRNmltdCtVNnNUMllsNHdsK1FvS1lVM3pjVXoyS1FNcVFx?=
 =?utf-8?B?emc3SG1kUDI5d1U5ampQekkzT3hiOFRFVDM5dTlIN21ISitvZVVkaFlrWVh4?=
 =?utf-8?Q?0M04zR8GogRqWPECzVIfnIB8qY9RYrPp5e1Tns8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D05740311013FA46B6340112213EEC83@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf88aae-9ca1-4c78-0fa6-08d8cc1d8f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 10:37:40.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULuPviETxISmaRJXr3iyhWAfwia8MfsnOiOLhZnAGA+9Po3Hqtbu9n+syplaH4EG+Btnm9mdpK4vxxMqT8CNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4510
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQXJlbmQsDQoNCk9uIDEvMTkvMjEgMTE6MDMgQU0sIEFsdmluIMWgaXByYWdhIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIDEvMTkvMjEgOTozMCBBTSwgQXJlbmQgVmFuIFNwcmllbCB3cm90ZToN
Cj4+IE9uIDEvMTUvMjAyMSAzOjU3IFBNLCBBbHZpbiDFoGlwcmFnYSB3cm90ZToNCj4+PiBIaSBB
cmVuZCwNCj4+Pg0KPj4+IE9uIDEvMTUvMjEgMzoxMCBQTSwgQXJlbmQgVmFuIFNwcmllbCB3cm90
ZToNCj4+Pj4gKyBKb2hhbm5lcw0KPj4+PiAtIG5ldGRldnMNCj4+Pj4NCj4+Pj4gT24gMS8xNC8y
MDIxIDU6MzYgUE0sICdBbHZpbiDFoGlwcmFnYScgdmlhIEJSQ004MDIxMS1ERVYtTElTVCxQREwg
d3JvdGU6DQo+Pj4+PiBBZGQgc3VwcG9ydCBmb3IgQ1FNIFJTU0kgbWVhc3VyZW1lbnQgcmVwb3J0
aW5nIGFuZCBhZHZlcnRpc2UgdGhlDQo+Pj4+PiBOTDgwMjExX0VYVF9GRUFUVVJFX0NRTV9SU1NJ
X0xJU1QgZmVhdHVyZS4gVGhpcyBlbmFibGVzIGEgdXNlcnNwYWNlDQo+Pj4+PiBzdXBwbGljYW50
IHN1Y2ggYXMgaXdkIHRvIGJlIG5vdGlmaWVkIG9mIGNoYW5nZXMgaW4gdGhlIFJTU0kgZm9yDQo+
Pj4+PiByb2FtaW5nDQo+Pj4+PiBhbmQgc2lnbmFsIG1vbml0b3JpbmcgcHVycG9zZXMuDQo+Pj4+
DQo+Pj4+IFRoZSBtb3JlIEkgYW0gbG9va2luZyBpbnRvIHRoaXMgQVBJIHRoZSBsZXNzIEkgdW5k
ZXJzdGFuZCBpdCBvciBhdCBsZWFzdA0KPj4+PiBpdCByYWlzZXMgYSBjb3VwbGUgb2YgcXVlc3Rp
b25zLiBMb29raW5nIGludG8gbmw4MDIxMV9zZXRfY3FtX3Jzc2koKSBbMV0NCj4+Pj4gdHdvIGJl
aGF2aW9ycyBhcmUgc3VwcG9ydGVkOiAxKSBkcml2ZXIgaXMgcHJvdmlzaW9uZWQgd2l0aCBhIHRo
cmVzaG9sZA0KPj4+PiBhbmQgaHlzdGVyZXNpcywgb3IgMikgZHJpdmVyIGlzIHByb3Zpc2lvbmVk
IHdpdGggaGlnaCBhbmQgbG93DQo+Pj4+IHRocmVzaG9sZC4gPg0KPj4+PiBUaGUgc2Vjb25kIGJl
aGF2aW9yIGlzIHVzZWQgd2hlbiB0aGUgZHJpdmVyIGFkdmVydGlzZXMNCj4+Pj4gTkw4MDIxMV9F
WFRfRkVBVFVSRV9DUU1fUlNTSV9MSVNUICphbmQqIHVzZXItc3BhY2UgcHJvdmlkZXMgbW9yZSB0
aGFuDQo+Pj4+IG9uZSBSU1NJIHRocmVzaG9sZC4gSW4gYm90aCBjYXNlcyB0aGUgc2FtZSBkcml2
ZXIgY2FsbGJhY2sgaXMgYmVpbmcgdXNlZA0KPj4+PiBzbyBJIHdvbmRlciB3aGF0IGlzIGV4cGVj
dGVkIGZyb20gdGhlIGRyaXZlci4gU2VlbXMgdG8gbWUgdGhlIGRyaXZlcg0KPj4+PiB3b3VsZCBu
ZWVkIHRvIGJlIGFibGUgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiB0aGUgdHdvIGJlaGF2aW9yYWwN
Cj4+Pj4gc2NlbmFyaW9zLiBBcyB0aGVyZSBpcyBubyBvYnZpb3VzIHdheSBJIGFzc3VtZSB0aGUg
ZHJpdmVyIHNob3VsZCBiZWhhdmUNCj4+Pj4gdGhlIHNhbWUgZm9yIGJvdGggY2FzZXMsIGJ1dCBh
Z2FpbiBpdCBpcyB1bmNsZWFyIHRvIG1lIHdoYXQgdGhhdA0KPj4+PiBleHBlY3RlZC9yZXF1aXJl
ZCBiZWhhdmlvciBpcy4NCj4+Pg0KPj4+IEl0IHdpbGwgb25seSBwcm92aXNpb24gdGhlIGRyaXZl
ciBhY2NvcmRpbmcgdG8gYmVoYXZpb3VyICgxKSBpZiAwIG9yIDENCj4+PiB0aHJlc2hvbGRzIGFy
ZSBiZWluZyBzZXQgQU5EIHRoZSBkcml2ZXIgaW1wbGVtZW50cw0KPj4+IHNldF9jcW1fcnNzaV9j
b25maWcoKS4gQnV0IGl0IHNheXMgaW4gdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZQ0KPj4+IHNl
dF9jcW1fcnNzaV9yYW5nZV9jb25maWcoKSBjYWxsYmFja1sxXSB0aGF0IGl0IHN1cGVyc2VkZXMN
Cj4+PiBzZXRfY3FtX3Jzc2lfY29uZmlnKCkgKG9yIGF0IGxlYXN0IHRoYXQgdGhlcmUgaXMgbm8g
cG9pbnQgaW4NCj4+PiBpbXBsZW1lbnRpbmcgX2NvbmZpZyBpZiByYW5nZV9jb25maWcgaXMgaW1w
bGVtZW50ZWQpLiBJbiB0aGF0IGNhc2UsIGFuZA0KPj4+IGlmIGp1c3Qgb25lIHRocmVzaG9sZCBp
cyBzdXBwbGllZCAod2l0aCBhIGh5c3RlcmVzaXMpLCB0aGVuIGEgc3VpdGFibGUNCj4+PiByYW5n
ZSBpcyBjb21wdXRlZCBieSBjZmc4MDIxMV9jcW1fcnNzaV91cGRhdGUoKSBhbmQgcHJvdmlkZWQg
dG8NCj4+PiBzZXRfY3FtX3Jzc2lfcmFuZ2VfY29uZmlnKCkuIEkgZ3Vlc3MgdGhlIGltcGxpY2F0
aW9uIGhlcmUgaXMgdGhhdCB0aGUNCj4+PiB0d28gYmVoYXZpb3VycyBhcmUgZnVuY3Rpb25hbGx5
IGVxdWl2YWxlbnQuIEknbSBub3Qgc3VyZSBJIGNhbiBhcmd1ZSBmb3INCj4+PiBvciBhZ2FpbnN0
IHRoYXQgYmVjYXVzZSBJIGRvbid0IHJlYWxseSBrbm93IHdoYXQgdGhlIHNlbWFudGljcyBvZiB0
aGUNCj4+PiBvcmlnaW5hbCBBUEkgd2VyZSBzdXBwb3NlZCB0byBiZSwgYnV0IGl0IHNlZW1zIHJl
YXNvbmFibGUuDQo+Pj4NCj4+PiBBcyBhIHN0YXJ0aW5nIHBvaW50IC0gYW5kIHNpbmNlIHRoZSBm
aXJtd2FyZSBiZWhhdmlvdXIgaXMgdmVyeSBjbG9zZQ0KPj4+IGFscmVhZHkgLSBJIGltcGxlbWVu
dGVkIG9ubHkgc2V0X2NxbV9yc3NpX3JhbmdlKCkuIEkgaGF2ZSBiZWVuIHRlc3RpbmcNCj4+PiB3
aXRoIGl3ZCwgd2hpY2ggYnkgZGVmYXVsdCBzZXRzIGp1c3QgYSBzaW5nbGUgdGhyZXNob2xkIGFu
ZCBoeXN0ZXJlc2lzLA0KPj4+IGFuZCB0aGUgZHJpdmVyIHdhcyBzZW5kaW5nIG5vdGlmaWNhdGlv
bnMgYXMgd291bGQgYmUgZXhwZWN0ZWQuDQo+Pg0KPj4gT0suIEkgb3Zlcmxvb2tlZCB0aGF0IHRo
ZXJlIHdlcmUgdHdvIGRpZmZlcmVudCBjYWxsYmFja3MgaW52b2x2ZWQuIFNvIEkNCj4+IHdpbGwg
cmV2aWV3IHRoZSBwYXRjaCB3aXRoIHRoYXQga25vd2xlZGdlLiBXaGF0IHdpZmkgY2hpcCBkaWQg
eW91IHRlc3QNCj4+IHRoaXMgd2l0aCBhbmQgbW9yZSBpbXBvcnRhbnRseSB3aGljaCBmaXJtd2Fy
ZSB2ZXJzaW9uPw0KDQpEaWQgeW91IGhhdmUgYSBjaGFuY2UgdG8gcmV2aWV3PyBEbyB5b3UgcmVx
dWlyZSBhbnkgbW9yZSBpbmZvcm1hdGlvbiANCmZyb20gbXkgZW5kPyBXZSBoYXZlIGJlZW4gdXNp
bmcgdGhpcyBwYXRjaCBmb3Igc29tZSB0aW1lIG5vdyBhbmQgaXQgDQpjb250aW51ZXMgdG8gZnVu
Y3Rpb24gYXMgZXhwZWN0ZWQuDQoNClRoYW5rcyBpbiBhZHZhbmNlLg0KDQpLaW5kIHJlZ2FyZHMs
DQpBbHZpbg0KDQo+IA0KPiBBbGwgdGVzdGluZyB3YXMgZG9uZSB3aXRoIGEgUENJZSBDeXByZXNz
IENZVzg4MzU5IChNdXJhdGEgVHlwZSAxVkEpLg0KPiANCj4gSSB0ZXN0ZWQgd2l0aCB0d28gZmly
bXdhcmVzOg0KPiANCj4gMS4gQSBjdXN0b20gZmlybXdhcmUgZnJvbSBDeXByZXNzIHdpdGggc29t
ZSB2ZW5kb3Itc3BlY2lmaWMgZmVhdHVyZXM6DQo+ICAgICAgdmVyc2lvbiA5LjQwLjk4LjE5IChy
NzI3MTU0IENZKSBGV0lEIDAxLTFmZjFjMzANCj4gDQo+IDIuIFRoZSBsYXRlc3QgcHVibGljIGZp
cm13YXJlIHJlbGVhc2UgZnJvbSBNdXJhdGFbMV0gZm9yIHRoaXMgY2hpcDoNCj4gICAgICB2ZXJz
aW9uIDkuNDAuMTMwIChyNzI0ODU1IENZKSBGV0lEIDAxLTlhZTJjZDZkDQo+IA0KPiBUaGFua3Mg
Zm9yIHRoZSByZXZpZXcuDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL211cmF0YS13aXJl
bGVzcy9jeXctZm1hYy1mdw0KPiANCj4gS2luZCByZWdhcmRzLA0KPiBBbHZpbg0KPiA=
