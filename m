Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E931979EF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 12:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgC3KzF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 06:55:05 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11]:50242 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgC3KzF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 06:55:05 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20200330105504usoutp014d9b477c3f6b4b8ac0311e22af7ba147~BD5uG08QO2373523735usoutp01W;
        Mon, 30 Mar 2020 10:55:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20200330105504usoutp014d9b477c3f6b4b8ac0311e22af7ba147~BD5uG08QO2373523735usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585565704;
        bh=4o30bNIgu3OQhNHLyHUh+b7fEKdow+pkusCT8Rj5TrM=;
        h=From:To:Subject:Date:References:From;
        b=TGxmyroEYleja2y6jqdLL5GAO/lFnNqSKCJNDUW9O1rTlac+hKcwi8LboWlaRrGI0
         +DAhuIArx1Aw9cNN6Jx/bjkbjOkgUvR8182Rz6D6HTMPa22P4LV6F81+rCnE9fSM2Q
         QZUtMrA8RO9N67pvxKayFC1BL51pGGqf4uNFKFd8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200330105503uscas1p1e90a2cf6224d7ff2c9c115b07da899a5~BD5tpvJhY2152621526uscas1p1m;
        Mon, 30 Mar 2020 10:55:03 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 94.F4.20299.700D18E5; Mon,
        30 Mar 2020 06:55:03 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200330105502uscas1p156e5136d421b2238aad23dca466bf9ae~BD5siz9xa0294802948uscas1p1r;
        Mon, 30 Mar 2020 10:55:02 +0000 (GMT)
X-AuditID: cbfec370-d07ff70000024f4b-a6-5e81d0078104
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id D5.B3.60206.600D18E5; Mon,
        30 Mar 2020 06:55:02 -0400 (EDT)
Received: from SSI-EX4.ssi.samsung.com (105.128.2.229) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.1713.5; Mon, 30 Mar 2020 03:55:02 -0700
Received: from SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4]) by
        SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4%7]) with mapi id
        15.01.1713.004; Mon, 30 Mar 2020 03:55:02 -0700
From:   Geoffroy Letourneur <g.letourneur@samsung.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>,
        "dcbw@redhat.com" <dcbw@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Samsung Ax200 module client ac mode
Thread-Topic: Samsung Ax200 module client ac mode
Thread-Index: AQHWBoGpiEsGlBVJb0Cyuf+/De2kKQ==
Date:   Mon, 30 Mar 2020 10:55:01 +0000
Message-ID: <B128C1F9-CD70-4332-8A68-DBC1CD3F160A@samsung.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5505616C5FA8F47848938EB40283784@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djX87rsFxrjDJpvGlisn76G0eLjhk8s
        Fm9W3GG36Nw8kdGBxWPxnpdMHu/3XWXz6O/dxuLxeZNcAEsUl01Kak5mWWqRvl0CV8bMVfuY
        C6ZoVCzespypgXGCehcjJ4eEgInEzT1bmLoYuTiEBFYySvQsnsQM4bQySXTOuMQEU/X60EQW
        iMRaRonNhxdBOR8ZJfobv0M5BxglNkzcyQjSwgbU8q7rM1hCROAKo8SCS3NYQRLCAjoSx17/
        YwGxRQQMJbasPsEMYetJPPm+C2wfi4CqxOtpi8AG8QrYSez5tgWshlFAVuLawtVgvcwC4hLf
        jq5khrhPUGLR7D1QtpjEv10P2SBsRYn731+ydzFyANVrSqzfpQ/Raiex8nQ3O4StKDGl+yE7
        xCpBiZMzn7BAtEpKHFxxA+x+CYH3bBIfFnSwQyRcJN483M8KYUtLTF9zGaqhHejJJ64QDVMY
        JbZO3gsNPGuJJ3tOs0Fs45P4++sRI8hBEgK8Eh1tQhMYlWYheWcWwqmzkJw6C8mps5CcuoCR
        dRWjeGlxcW56arFxXmq5XnFibnFpXrpecn7uJkZg4jn973DBDsbrS5IPMQpwMCrx8H7Y3hAn
        xJpYVlyZe4hRgoNZSYSXzR8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfBo5exQgLpiSWp2amp
        BalFMFkmDk6pBsYZafxJyxMzuyXy9i7VW5azPKHGeqZG2WSHGvZkq++P2AqYUty1ipy6b313
        OH/8J+s+vSXrazcHc1i4HPMwvSfVl/et99Wc+6cKmGauMnZbv/LjzIX97BqVXTuW3FRZZnPV
        qec5T4bKuelz9nvGhhzfvid1QfI8LQaFy1NLUvSdkw9913n9bqsSS3FGoqEWc1FxIgDF0LVz
        OAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWS2cA0SZftQmOcwfM2TYv109cwWnzc8InF
        4s2KO+wWnZsnMjqweCze85LJ4/2+q2we/b3bWDw+b5ILYInisklJzcksSy3St0vgypi5ah9z
        wRSNisVbljM1ME5Q72Lk5JAQMJF4fWgiSxcjF4eQwGpGiRMHdzBBOB8ZJfZs2cQK4RxglJj2
        /BwzSAsbUMu7rs9gLSICVxglFlyawwqSEBbQkTj2+h8LiC0iYCixZfUJZghbT+LJ911MIDaL
        gKrE62mLGEFsXgE7iT3ftoDVMArISlxbuBqsl1lAXOLb0ZXMEPcJSCzZcx7KFpV4+fgfK4St
        KHH/+0v2LkYOoHpNifW79CFa7SRWnu5mh7AVJaZ0P2SHWCUocXLmExaIVkmJgytusExgFJ2F
        ZNsshEmzkEyahWTSLCSTFjCyrmIULy0uzk2vKDbOSy3XK07MLS7NS9dLzs/dxAiMtdP/Dsfs
        YLy7JPkQowAHoxIP74ytDXFCrIllxZW5hxglOJiVRHjZ/IFCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeVslFkQJCaQnlqRmp6YWpBbBZJk4OKUaGCsUWl5v0jqeavhje1zNGuGwpR9nOiz9ZNMp
        Mt8p0ubFZouE+KPxYlG8ose4wqf9/XCwdH9/djLntrWGT7ZfMriqw7G2P9Ri/39/ha7tdw4r
        WHzv+fb7t0tA6Ybowy3q69T77558uOfGnYauuRfqX05d//LtxzifsIKZETazFbbUX1HMu8Ai
        dkiJpTgj0VCLuag4EQAMOI2AsQIAAA==
X-CMS-MailID: 20200330105502uscas1p156e5136d421b2238aad23dca466bf9ae
CMS-TYPE: 301P
X-CMS-RootMailID: 20200330105502uscas1p156e5136d421b2238aad23dca466bf9ae
References: <CGME20200330105502uscas1p156e5136d421b2238aad23dca466bf9ae@uscas1p1.samsung.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGVsbG8sDQoNClNvbWUgbmV3cyBhYm91dCB0aGUgQVgyMDAgbW9kdWxlIGluIEFDIG1vZGUuDQoN
CkkgZm91bmQgc29tZSBpbmZvcm1hdGlvbiBvbiBmb3J1bToNCklmIHlvdSB3YW50IHJlbGlhYmxl
IHdpZmksIGJldHRlciBsb29rIGF0IHRlc3RlZCA4MDIuMTFhYyBzb2x1dGlvbnMgcmF0aGVyIHRo
YW4gYXQgSW50ZWwgb25lcyB0aGF0IHNlZSB2ZXJ5IGZldyB1c2UgaW4gQVAgbW9kZS4NCkZyb20g
SW50ZWwncyBwcm9kdWN0IHBhZ2UsIHRoZSBBWDIwMCBpcyBub3QgYXggY2VydGlmaWVkIGVpdGhl
cg0KKGl0IGNsZWFybHkgc2F5cyAnV2lGaSA2IHByZScgLSBJIGhhdmUgbm8gaWRlYSBpZiB0aGUg
ODAyLjExYXggc3BlYyBpdHNlbGYgaXMgZmluYWxpc2VkIGJ5IG5vdzsgYnV0IEkgd291bGRuJ3Qg
cHV0IG15IG1vbmV5IG9uIHByZS1jZXJ0aWZpY2F0aW9uIGhhcmR3YXJlKS4NCldlYnNpdGUgLT4g
aHR0cHM6Ly9mb3J1bS5vcGVud3J0Lm9yZy90L2tlcm5lbC1yZXBsYWNlbWVudC1mb3ItYXgyMDAv
NDA5MTUNCg0KSXMgaXQgdHJ1ZSA/DQoNCk9uIG15IHNpZGUgSSB0ZXN0ZWQgdGhlIG1vZHVsZSB3
aXRoIGlwZXJmIGJ1dCBub3QgaW4gaG9zdGFwZC4NCkZvciB0aGUgdGVzdCBJIHVzZWQgYSBTMTAr
IGNvbXBhdGlibGUgQUMgbW9kZSBhbmQgYSBBc3VzIEFDIHJvdXRlciBhbmQgYSBKZXRzb24gTmFu
byB3aXRoIEFYMjAwIG1vZHVsZS4gTmFubyBhbmQgUzEwKyBhcmUgY29ubmVjdGVkIHRvIHRoZSBB
c3VzIHJvdXRlciBpbiA1R2h6IEFDIG1vZGUuIFNvIEkganVzdCB0cnkgdG8gdGVzdCB0aGUgQUMg
KHdpZmk1IG1vZGUpIGFuZCBmb3Jnb3QgdGhlIEFYICh3aWZpNiBtb2RlKQ0KDQpNeSByZXN1bHRz
Og0KSXBlcmYgLXMgb24gdGhlIG5hbm8gc2lkZSBhbmQgUzEwKyBpbiBjbGllbnQNCg0KQ21kIG5h
bm86IGlwZXJmIC1zIC1pIDEgKGlwIG5hbm8gMTkyLjE2OC4xLjUwKSAobmFubyBpcyBpbiBsaXN0
ZW5pbmcgbW9kZSBUQ1ApDQpDbWQgczEwKzogaXBlcmYgLWMgMTkyLjE2OC4xLjUwIChpcCBTMTAr
IDE5Mi4xNjguMS40NykNCg0KUmVzdWx0IG9uIG5hbm86DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClNlcnZlciBsaXN0ZW5pbmcg
b24gVENQIHBvcnQgNTAwMQ0KVENQIHdpbmRvdyBzaXplOiA4NS4zIEtCeXRlIChkZWZhdWx0KQ0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpbICA0XSBsb2NhbCAxOTIuMTY4LjEuNTAgcG9ydCA1MDAxIGNvbm5lY3RlZCB3aXRoIDE5
Mi4xNjguMS40NyBwb3J0IDQ5OTYwDQpbIElEXSBJbnRlcnZhbCAgICAgICBUcmFuc2ZlciAgICAg
QmFuZHdpZHRoDQpbICA0XSAgMC4wLSAxLjAgc2VjICA1Ni4yIE1CeXRlcyAgIDQ3MSBNYml0cy9z
ZWMNClsgIDRdICAxLjAtIDIuMCBzZWMgIDE1LjEgTUJ5dGVzICAgMTI3IE1iaXRzL3NlYw0KWyAg
NF0gIDIuMC0gMy4wIHNlYyAgOS4xMCBNQnl0ZXMgIDc2LjQgTWJpdHMvc2VjDQpbICA0XSAgMy4w
LSA0LjAgc2VjICAyMy44IE1CeXRlcyAgIDIwMCBNYml0cy9zZWMNClsgIDRdICA0LjAtIDUuMCBz
ZWMgIDYzLjcgTUJ5dGVzICAgNTM0IE1iaXRzL3NlYw0KWyAgNF0gIDUuMC0gNi4wIHNlYyAgNjcu
NSBNQnl0ZXMgICA1NjYgTWJpdHMvc2VjDQpbICA0XSAgNi4wLSA3LjAgc2VjICA2OC4xIE1CeXRl
cyAgIDU3MSBNYml0cy9zZWMNClsgIDRdICA3LjAtIDguMCBzZWMgIDcwLjAgTUJ5dGVzICAgNTg3
IE1iaXRzL3NlYw0KWyAgNF0gIDguMC0gOS4wIHNlYyAgNzEuMSBNQnl0ZXMgICA1OTcgTWJpdHMv
c2VjDQpbICA0XSAgOS4wLTEwLjAgc2VjICA2Ny4xIE1CeXRlcyAgIDU2MyBNYml0cy9zZWMNClsg
IDRdICAwLjAtMTAuMCBzZWMgICA1MTIgTUJ5dGVzICAgNDI5IE1iaXRzL3NlYw0KDQoNCklmIEkg
Y2hhbmdlIHRoZSBjbGllbnQgYW5kIHRoZSBzZXJ2ZXIgdGhlIGJhbmR3aWR0aCBjaGFuZ2UuDQoN
CkNtZCBuYW5vOiBpcGVyZiAtYyAxOTIuMTY4LjEuNDcgLUkgMSAoaXAgMTkyLjE2OC4xLjUwKSAo
bmFubyBpcyBpbiBsaXN0ZW5pbmcgbW9kZSBUQ1ApDQpDbWQgczEwKzogaXBlcmYgLXMgLWkNClJl
c3VsdCBvbiBuYW5vOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpDbGllbnQgY29ubmVjdGluZyB0byAxOTIuMTY4LjEuNDcsIFRD
UCBwb3J0IDUwMDENClRDUCB3aW5kb3cgc2l6ZTogODUuMCBLQnl0ZSAoZGVmYXVsdCkNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
WyAgM10gbG9jYWwgMTkyLjE2OC4xLjUwIHBvcnQgNTAxNjggY29ubmVjdGVkIHdpdGggMTkyLjE2
OC4xLjQ3IHBvcnQgNTAwMQ0KWyBJRF0gSW50ZXJ2YWwgICAgICAgVHJhbnNmZXIgICAgIEJhbmR3
aWR0aA0KWyAgM10gIDAuMC0gMS4wIHNlYyAgMjEuOSBNQnl0ZXMgICAxODQgTWJpdHMvc2VjDQpb
ICAzXSAgMS4wLSAyLjAgc2VjICAxLjc0IE1CeXRlcyAgMTQuNiBNYml0cy9zZWMNClsgIDNdICAy
LjAtIDMuMCBzZWMgIDAuMDAgQnl0ZXMgIDAuMDAgYml0cy9zZWMNClsgIDNdICAzLjAtIDQuMCBz
ZWMgIDAuMDAgQnl0ZXMgIDAuMDAgYml0cy9zZWMNClsgIDNdICA0LjAtIDUuMCBzZWMgIDAuMDAg
Qnl0ZXMgIDAuMDAgYml0cy9zZWMNClsgIDNdICA1LjAtIDYuMCBzZWMgIDcuMTIgTUJ5dGVzICA1
OS44IE1iaXRzL3NlYw0KWyAgM10gIDYuMC0gNy4wIHNlYyAgMTYuNSBNQnl0ZXMgICAxMzggTWJp
dHMvc2VjDQpbICAzXSAgNy4wLSA4LjAgc2VjICAxNS42IE1CeXRlcyAgIDEzMSBNYml0cy9zZWMN
ClsgIDNdICA4LjAtIDkuMCBzZWMgIDE1LjQgTUJ5dGVzICAgMTI5IE1iaXRzL3NlYw0KWyAgM10g
IDkuMC0xMC4wIHNlYyAgMjEuOSBNQnl0ZXMgICAxODQgTWJpdHMvc2VjDQpbICAzXSAgMC4wLTEw
LjEgc2VjICAgMTAwIE1CeXRlcyAgODMuMSBNYml0cy9zZWMNCg0KTXkgY29uY2x1c2lvbiB0aGUg
bW9kdWxlIEFYMjAwIHNlZW1zIHRvIHdvcmsgaW4gQUMganVzdCBpbiBSWCBtb2RlLiBUaGUgVFgg
bW9kZSBzZWVtcyB0byBiZSBidWdnZWQuDQpLZXJuZWwgdXNlZDogNC45LjE0MC10ZWdyYQ0KDQpG
aXJtd2FyZSBvZiB0aGUgQVgyMDAgbW9kdWxlOiAgaXdsd2lmaS1jYy1hMC00OC51Y29kZQ0KRHJp
dmVyOg0KZ2l0IGNsb25lIC0tc2luZ2xlLWJyYW5jaCAtLWJyYW5jaCByZWxlYXNlL2NvcmU0NSBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2Jh
Y2twb3J0LWl3bHdpZmkuZ2l0DQpjZCBiYWNrcG9ydC1pd2x3aWZpLw0KbWFrZSBkZWZjb25maWct
aXdsd2lmaS1wdWJsaWMNCnNlZCAtaSAncy9DUFRDRkdfSVdMTVZNX1ZFTkRPUl9DTURTPXkvIyBD
UFRDRkdfSVdMTVZNX1ZFTkRPUl9DTURTIGlzIG5vdCBzZXQvJyAuY29uZmlnDQptYWtlIC1qNA0K
bWFrZSBpbnN0YWxsDQpDb3VsZCB5b3UgaGVscCBtZSB0byByZXNvbHZlIHRoaXMgaXNzdWUgPyBC
dXQgbWF5YmUgdGhlcmUgaXMgbm8gc29sdXRpb27igKYNCg0KDQpCZXN0IHJlZ2FyZHMgR2VvDQot
LQ0KR2VvZmZyb3kgTEVUT1VSTkVVUg0KRW1iZWRkZWQgU29mdHdhcmUgRW5naW5lZXIsDQpTU0lD
LCBQYXJpcw0KDQpFbWFpbDogZy5sZXRvdXJuZXVyQHNhbXN1bmcuY29tPG1haWx0bzpnLmxldG91
cm5ldXJAc2Ftc3VuZy5jb20+DQpUZWw6ICszMyA2IDQ1IDE0IDI0IDMyDQoNCg0KDQo=
