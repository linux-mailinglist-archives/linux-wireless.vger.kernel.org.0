Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C831945DF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 18:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZRyv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 13:54:51 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:50280 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZRyv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 13:54:51 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 13:54:50 EDT
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20200326174551usoutp01e063c20a70c7a541b71f6afcd0a5b55c~-67PuusMU3241932419usoutp01p;
        Thu, 26 Mar 2020 17:45:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20200326174551usoutp01e063c20a70c7a541b71f6afcd0a5b55c~-67PuusMU3241932419usoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585244751;
        bh=bj4LuvEBMOUIpH2UN27zWZUm6UmvefTczHjPyXrA4iU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mQRlJ96x2Auh6Wr69i0eKsU4n0629UZ/3m23gimXNbEkUwoPALeB1zjMRppxkyeBD
         pan1kueW7IgtLAkV5e0eCPBwwTY3lBMq/lQqrMKKnlm0U+Hbxo6rOTfSj0WCzZ/HTK
         a7LEEYUExawsc+MHp1tn0GGyPOE7fqSmYnbD1Wok=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326174551uscas1p1815adbbd1dd79d45aedc2b7e3371cf81~-67PffF_62146921469uscas1p17;
        Thu, 26 Mar 2020 17:45:51 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id D8.A3.20168.F4AEC7E5; Thu,
        26 Mar 2020 13:45:51 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326174551uscas1p2219038b2e97b7e91fc848ce01a127226~-67PArT0Q0206802068uscas1p2y;
        Thu, 26 Mar 2020 17:45:51 +0000 (GMT)
X-AuditID: cbfec36d-e19ff70000024ec8-7c-5e7cea4f9346
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 8A.DB.60206.E4AEC7E5; Thu,
        26 Mar 2020 13:45:51 -0400 (EDT)
Received: from SSI-EX4.ssi.samsung.com (105.128.2.229) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.1713.5; Thu, 26 Mar 2020 10:45:50 -0700
Received: from SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4]) by
        SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4%7]) with mapi id
        15.01.1713.004; Thu, 26 Mar 2020 10:45:50 -0700
From:   Duncan McDonald <d.mcdonald@samsung.com>
To:     Martin Bourreau <m.bourreau@samsung.com>,
        Dan Williams <dcbw@redhat.com>,
        Geoffroy Letourneur <g.letourneur@samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Matthias May <matthias.may@neratec.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
CC:     Gilles Mazars <g.mazars@samsung.com>,
        "Kitty (Xia) Lou" <kitty.lou@samsung.com>,
        Harris Warren <harris.w@samsung.com>,
        Raymond Chan <raymond.chan@samsung.com>,
        "Seshu (Leela Seshu Reddy) Cheedepudi" <seshu.reddy@samsung.com>
Subject: RE: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
Thread-Topic: Geoffroy LETOURNEUR: Samsung AX200 system integration on
        Nvidia Nano.
Thread-Index: AQHWAr2wsmsOeqOOfECn+0wE7X7A4aha8ZSAgAAdewD//3tbYYAAl5+AgABEjoCAADQVAP//i71Q
Date:   Thu, 26 Mar 2020 17:45:50 +0000
Message-ID: <495ebf129e8846e8a6952eee37f650e2@samsung.com>
In-Reply-To: <ECFB8F73-CA97-4100-9B89-029B4701884A@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djX87r+r2riDOZvlrdYP30No8XHDZ9Y
        LN6suMNu0bl5IqNF9+avjA6sHov3vGTy2PyPx+P9vqtsHv2921g8Pm+SC2CN4rJJSc3JLEst
        0rdL4Mr48nISe8E9yYpVr3ayNDB2SHYxcnBICJhIbPte3sXIxSEksJJR4tiZCUwQTiuTxNq3
        U1m6GDnBir5+OsoKkVjLKLHm9wl2COcjkHPgCwuEc4BRovHUZlaQFjYBPYnDcz+AzRIROMEk
        8fnjOzYQh1ngFaPEmckTmEGqhAVCJBoW7AGzRQRCJS4/BJkLYkdJbD3YxgRiswioSjw83MMI
        YvMKWEn07jgAdhSngL3Eq/MbwGoYBcQkvp9aA2YzC4hL3HoynwnicEGJRbMh5ksA1fzb9ZAN
        wlaUuP/9JTsoBJgFNCXW79KHaFWUmNL9kB1ilaDEyZlPoP6XlDi44gbYlxIC/ewS11/OZ4SE
        novErf8hEDXSEtPXXIaqn84ocXoOM0T9ekaJ9zdfskMkrCVOv2ligVjGJ/H31yPGCYzKs5Cc
        PQvhpFlITpqF5KQFjCyrGMVLi4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPO6X+Hc3cwHjmd
        fIhRgINRiYe3oa0mTog1say4MvcQowQHs5II79NIoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        B49exgoJpCeWpGanphakFsFkmTg4pRoYaxb0xv70zTz4PG7moqef/kuXTpox7bzakssWYikV
        O2/lPf2efdMkY/VLzwz3Owc/N01In6LyPu+d3KmzLyVWCKzxM+f/FbY9cGr77YsMr0347y0O
        81b9a6ld8f7QitgknjQWlVm+1aZ9mtOaZjw2avyysyKX9/ZHs60VnBd/vtHjOddrrT7RV4ml
        OCPRUIu5qDgRAMZ8kSo1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWS2cA0Udf/VU2cQbeaxfrpaxgtPm74xGLx
        ZsUddovOzRMZLbo3f2V0YPVYvOclk8fmfzwe7/ddZfPo793G4vF5k1wAaxSXTUpqTmZZapG+
        XQJXxpeXk9gL7klWrHq1k6WBsUOyi5GTQ0LAROLrp6OsXYxcHEICqxklnu67zALhfGSUOHpz
        NZRzgFFi1a2zbCAtbAJ6EofnfmACSYgInGCSmPr6EjuIwyzwilHizOQJzCBVwgIhEg0L9oDZ
        IgKhEg++TmaHsKMkth5sYwKxWQRUJR4e7mEEsXkFrCR6dxyAWveCWeJTZx9YEaeAvcSr8xvA
        bEYBMYnvp9aA2cwC4hK3nsxngvhCQGLJnvPMELaoxMvH/1ghbEWJ+99fAi3mAKrXlFi/Sx+i
        VVFiSvdDdoi9ghInZz5hgSiXlDi44gbLBEbxWUg2zELonoWkexaS7gWMLKsYxUuLi3PTK4qN
        81LL9YoTc4tL89L1kvNzNzEC4/L0v8MxOxjvLkk+xCjAwajEw9vQVhMnxJpYVlyZe4hRgoNZ
        SYT3aSRQiDclsbIqtSg/vqg0J7X4EKM0B4uSOG+rxIIoIYH0xJLU7NTUgtQimCwTB6dUAyP7
        NofyLYf3O87byHO8j+mSkPeGhEmPZmWdOnBhk+SHIsm9R4xmXz21SniZ0dZDv+d/370tQ3T3
        /19HLqXK8babtpwNXPVg29X6BYdqs1RyOphbvyUc/S1/7cKfpZe0rkgkzl967Lfp8Rru+QXh
        xclea5a8nrWfPdPPzH2lojLPzmlr42oW/zt1TYmlOCPRUIu5qDgRAD20xBLHAgAA
X-CMS-MailID: 20200326174551uscas1p2219038b2e97b7e91fc848ce01a127226
CMS-TYPE: 301P
X-CMS-RootMailID: 20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
        <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
        <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
        <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com>
        <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
        <E16BF92C-B26C-4219-B09B-1DEBF96A3911@samsung.com>
        <a70556a0cacc376826f38258156a0224d2f54b56.camel@redhat.com>
        <ECFB8F73-CA97-4100-9B89-029B4701884A@samsung.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TWFydGluLA0KDQpJbnRlcmVzdGluZy4gSSBrbmV3IHRoZXJlIHdlcmUgaXNzdWVzIGZvciA4MDIu
MTFheCBpbiB0aGUgSVNNIGJhbmQgb3V0c2lkZSBvZiB0aGUgb25lcyBjdXJyZW50bHkgdXNlZCBm
b3Igd2lmaSwgYnV0IGl0IHNlZW1zIHRoZSBpc3N1ZXMgZXh0ZW5kIHRvIHRoZSBjdXJyZW50IDVH
SHogYmFuZCBhcyB3ZWxsLg0KDQpEdW5jYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IE1hcnRpbiBCb3VycmVhdSANClNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyNiwgMjAyMCAx
MDozOSBBTQ0KVG86IERhbiBXaWxsaWFtcyA8ZGNid0ByZWRoYXQuY29tPjsgR2VvZmZyb3kgTGV0
b3VybmV1ciA8Zy5sZXRvdXJuZXVyQHNhbXN1bmcuY29tPjsgSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD47IE1hdHRoaWFzIE1heSA8bWF0dGhpYXMubWF5QG5lcmF0ZWMu
Y29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eHdpZmlAaW50ZWwuY29t
DQpDYzogR2lsbGVzIE1hemFycyA8Zy5tYXphcnNAc2Ftc3VuZy5jb20+OyBLaXR0eSAoWGlhKSBM
b3UgPGtpdHR5LmxvdUBzYW1zdW5nLmNvbT47IEhhcnJpcyBXYXJyZW4gPGhhcnJpcy53QHNhbXN1
bmcuY29tPjsgUmF5bW9uZCBDaGFuIDxyYXltb25kLmNoYW5Ac2Ftc3VuZy5jb20+OyBEdW5jYW4g
TWNEb25hbGQgPGQubWNkb25hbGRAc2Ftc3VuZy5jb20+OyBTZXNodSAoTGVlbGEgU2VzaHUgUmVk
ZHkpIENoZWVkZXB1ZGkgPHNlc2h1LnJlZGR5QHNhbXN1bmcuY29tPg0KU3ViamVjdDogUmU6IEdl
b2Zmcm95IExFVE9VUk5FVVI6IFNhbXN1bmcgQVgyMDAgc3lzdGVtIGludGVncmF0aW9uIG9uIE52
aWRpYSBOYW5vLg0KDQpBZGRpbmcgcGVvcGxlIGZvciBhd2FyZW5lc3Mgb2YgdGhlIGNvbnZlcnNh
dGlvbi4gDQoNCu+7v0xlIDI2LzAzLzIwMjAgMTU6MzIsIMKrIERhbiBXaWxsaWFtcyDCuyA8ZGNi
d0ByZWRoYXQuY29tPiBhIMOpY3JpdCA6DQoNCiAgICBPbiBUaHUsIDIwMjAtMDMtMjYgYXQgMDk6
MjcgKzAwMDAsIEdlb2Zmcm95IExldG91cm5ldXIgd3JvdGU6DQogICAgPiBIZWxsbyBKb2hhbm5l
cywNCiAgICA+IA0KICAgID4gV2hhdCB5b3UgbWVhbiBieSByZWd1bGF0b3J5IHJlc3RyaWN0aW9u
cz8NCiAgICA+IEhhcmR3YXJlIHJlc3RyaWN0aW9uID8NCiAgICA+IFNvZnR3YXJlIHJlc3RyaWN0
aW9uID8NCiAgICA+IExhdyByZXN0cmljdGlvbiA/DQogICAgDQogICAgVGhlcmUgYXJlIGxlZ2Fs
IHJlc3RyaWN0aW9ucyBvbiBzcGVjdHJ1bSB1c2UsIGVzcGVjaWFsbHkgaW4gdGhlIDVHaHoNCiAg
ICByYW5nZS4gV2hpY2ggbWVhbnMgYWRkaXRpb25hbCBlZmZvcnQgbXVzdCBiZSBwdXQgaW50byBi
b3RoIGhhcmR3YXJlIGFuZA0KICAgIHNvZnR3YXJlIHRvIHNhdGlzZnkgdGhvc2UgcmVzdHJpY3Rp
b25zLiBBbmQgcGVyaGFwcyB0aGF0IGVmZm9ydCB3YXMgbm90DQogICAgY29uc2lkZXJlZCBjb3N0
IGVmZmVjdGl2ZSBmb3IgdGhlIEFYMjAwLg0KICAgIA0KICAgIERhbg0KICAgIA0KICAgID4gQmVz
dCByZWdhcmRzIEdlbw0KICAgID4gDQogICAgPiAtLQ0KICAgID4gR2VvZmZyb3kgTEVUT1VSTkVV
Ug0KICAgID4gRW1iZWRkZWQgU29mdHdhcmUgRW5naW5lZXIsDQogICAgPiBTU0lDLCBQYXJpcw0K
ICAgID4gIA0KICAgID4gRW1haWw6IGcubGV0b3VybmV1ckBzYW1zdW5nLmNvbQ0KICAgID4gVGVs
OiArMzMgNiA0NSAxNCAyNCAzMg0KICAgID4gIA0KICAgID4gIA0KICAgID4gIA0KICAgID4gDQog
ICAgPiBMZSAyNi8wMy8yMDIwIDA5OjI0LCDCqyBKb2hhbm5lcyBCZXJnIMK7IDxqb2hhbm5lc0Bz
aXBzb2x1dGlvbnMubmV0PiBhDQogICAgPiDDqWNyaXQgOg0KICAgID4gDQogICAgPiAgICAgT24g
VGh1LCAyMDIwLTAzLTI2IGF0IDA4OjE5ICswMDAwLCBHZW9mZnJveSBMZXRvdXJuZXVyIHdyb3Rl
Og0KICAgID4gICAgID4gSGVsbG8gTWF0dGhpYXMsDQogICAgPiAgICAgPiANCiAgICA+ICAgICA+
IFRoZSBBWDIwMCBtb2R1bGUgc2VlbXMgdG8gc3VwcG9ydCBBUCBtb2RlIGl0IHdvcmtzIHdpdGgg
Mi40R0h6DQogICAgPiBXaWZpDQogICAgPiAgICAgPiA4MDIuMTFuIG1vZGUsIEkgdGVzdGVkIGl0
LiBCdXQgbWF5YmUgaXQgY291bGQgbm90IHN1cHBvcnQgdGhpcw0KICAgID4gbW9kZSBpbg0KICAg
ID4gICAgID4gODAyLjExYXguIA0KICAgID4gICAgIA0KICAgID4gICAgIDIuNCBHSHogc2hvdWxk
IGJlIE9LIC0gNSBHSHogaXMgZ2VuZXJhbGx5IGxpbWl0ZWQgb24gdGhvc2UNCiAgICA+IGRldmlj
ZXMgZHVlDQogICAgPiAgICAgdG8gcmVndWxhdG9yeSByZXN0cmljdGlvbnMuDQogICAgPiAgICAg
DQogICAgPiAgICAgam9oYW5uZXMNCiAgICA+ICAgICANCiAgICA+ICAgICANCiAgICA+IA0KICAg
IA0KICAgIA0KDQo=
