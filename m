Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A73D3193BCE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 10:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCZJ1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 05:27:05 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:35328 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCZJ1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 05:27:05 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20200326092704usoutp022a417f2d2402ba8c733b04715b3b9bc4~-0HvgtGka0544205442usoutp02k;
        Thu, 26 Mar 2020 09:27:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20200326092704usoutp022a417f2d2402ba8c733b04715b3b9bc4~-0HvgtGka0544205442usoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585214824;
        bh=lO5pGm6qa17Mi45g4H9oQ+JaqGCbymwMtNrIyOAyRKk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YoY9fxSgPjPon/wjDXmqmxG/q5c2jwC19rSgIHZkQ4F4grYukYjPgKBIOSjPHYSl9
         6KYcanYVhOLCqK+KgqlQYt3c8y0rSdJLHxr9EP7ZT1LKdc5BX5r9DMOkciW9TBY5EK
         6cqiNzkB74y3hO65qaOuEeNbg7wsMlVpehrhffqE=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326092703uscas1p2ddacdbc6dd795c3f7cd767a34c2cecb8~-0Hu8f9t_1595815958uscas1p2a;
        Thu, 26 Mar 2020 09:27:03 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 56.CE.20299.7657C7E5; Thu,
        26 Mar 2020 05:27:03 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326092702uscas1p2aac384d0bc76246aacf20d742de9a2b6~-0Ht_MdwK1595915959uscas1p2w;
        Thu, 26 Mar 2020 09:27:02 +0000 (GMT)
X-AuditID: cbfec370-d21ff70000024f4b-f0-5e7c75671866
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 7D.4A.59698.6657C7E5; Thu,
        26 Mar 2020 05:27:02 -0400 (EDT)
Received: from SSI-EX4.ssi.samsung.com (105.128.2.229) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.1713.5; Thu, 26 Mar 2020 02:27:01 -0700
Received: from SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4]) by
        SSI-EX4.ssi.samsung.com ([fe80::d5ff:a0cf:b920:78a4%7]) with mapi id
        15.01.1713.004; Thu, 26 Mar 2020 02:27:01 -0700
From:   Geoffroy Letourneur <g.letourneur@samsung.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Matthias May <matthias.may@neratec.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
CC:     Gilles Mazars <g.mazars@samsung.com>,
        Martin Bourreau <m.bourreau@samsung.com>
Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
Thread-Topic: Geoffroy LETOURNEUR: Samsung AX200 system integration on
        Nvidia Nano.
Thread-Index: AQHWAr2wsmsOeqOOfECn+0wE7X7A4aha8ZSAgAAdewD//3tbYYAAl5+A
Date:   Thu, 26 Mar 2020 09:27:01 +0000
Message-ID: <E16BF92C-B26C-4219-B09B-1DEBF96A3911@samsung.com>
In-Reply-To: <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CFC8E964AF4A243AF93A7C2DE270F72@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djXc7rppTVxBotXKlp83PCJxeLNijvs
        Fp2bJzJadG/+yujA4rF4z0smj83/eDz6e7exeHzeJBfAEsVlk5Kak1mWWqRvl8CVsbTlDVPB
        AY6Kie0PWBoYl3B0MXJwSAiYSFx9qNrFyMUhJLCSUeLaz9fsEE4rk8TsFcdYuhg5wYoO3djH
        CpFYyygxu+ElVNVHRokz2++AVQkJHAByzleD2GxAHe+6PrOAFIkInGGUeHxqMitIglkgROLH
        1Z/MILYwkN015RsTiC0iECpx+eEJdgjbTeL5sf0sIPexCKhK/JgbARLmFbCTODC7lRHE5hTw
        k3jYfg2snFFAVuLawtUsEOPFJb4dXckMcbWgxKLZe6BsMYl/ux6yQdiKEve/gzzAAVSvKbF+
        lz5Eq53E+5UQJcxAJVO6H7JDrBWUODnzCTQgJCUOrrgB9paEQD+7xL9Pe5kgwegisfV9NkSN
        tMTV61Oh1rYzSix44gpRP4VRYuvkvUwQCWuJJ3tOs01gVJmF5OxZCCfNQnLSLCQnzUJy0gJG
        1lWM4qXFxbnpqcXGeanlesWJucWleel6yfm5mxiBCef0v8MFOxivL0k+xCjAwajEw7vBsjpO
        iDWxrLgy9xCjBAezkgjv08iaOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Dx69jBUSSE8sSc1O
        TS1ILYLJMnFwSjUw8k5azLbJaHdsqoFCzXenC5NXLj8zaZnPg5kiPwQ/1OqvvfX/xZM1/IcS
        zs7w7hHi1DEVWzpvdl6eSrDE9JS4Gf4Odoozn9aJRJyeKLju3wV718PyD6INP5k/Lzm8P/s9
        w2+3x2rWXR0TNv14du+48P9/ZY4fJyv+lrxVUJ01s+fYlWVPZ+34x6bEUpyRaKjFXFScCABY
        qINLNAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWS2cA0STettCbO4PE0eYuPGz6xWLxZcYfd
        onPzREaL7s1fGR1YPBbvecnksfkfj0d/7zYWj8+b5AJYorhsUlJzMstSi/TtErgylra8YSo4
        wFExsf0BSwPjEo4uRk4OCQETiUM39rF2MXJxCAmsZpToerOBEcL5yCixfG0jM0iVkMABRoln
        +41BbDagjnddn1lAikQETjFK/D9zmg0kwSwQIvHj6k+wBmEgu2vKNyYQW0QgVOLB18nsELab
        xPNj+4GaOThYBFQlfsyNAAnzCthJHJjdCrX4AJPE/rmTwOZwCvhJPGy/BtbLKCArcW3hahaI
        XeIS346uZIZ4QUBiyZ7zULaoxMvH/1ghbEWJ+99fsoPsYhbQlFi/Sx+i1U7i/cqHUCcrSkzp
        fsgOcYOgxMmZT1ggWiUlDq64wTKBUWIWkm2zECbNQjJpFpJJs5BMWsDIuopRvLS4ODe9otgw
        L7Vcrzgxt7g0L10vOT93EyMwXk//Oxy5g/HE6eRDjAIcjEo8vBssq+OEWBPLiitzDzFKcDAr
        ifA+jayJE+JNSaysSi3Kjy8qzUktPsQozcGiJM67XGxBlJBAemJJanZqakFqEUyWiYNTqoHR
        bcf9eIHscx937Dt7u565iXX23F0xIT7zQlubZ09Y9HDj5dgWZ0WlGU7m3WwB2W8eLN6R8MpO
        kjGvvZ95lc4Nc+NFqcyqHDW7rxzrkpgbY5/gc44rUtFO6HZH5eH1QfZHSnzkJm15/+DW1q9Z
        dSm/tiqa71Xd37n6u/uMv89Ut7MsMa0orD+lxFKckWioxVxUnAgAF8DIy9MCAAA=
X-CMS-MailID: 20200326092702uscas1p2aac384d0bc76246aacf20d742de9a2b6
CMS-TYPE: 301P
X-CMS-RootMailID: 20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
        <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
        <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
        <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com>
        <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGVsbG8gSm9oYW5uZXMsDQoNCldoYXQgeW91IG1lYW4gYnkgcmVndWxhdG9yeSByZXN0cmljdGlv
bnM/DQpIYXJkd2FyZSByZXN0cmljdGlvbiA/DQpTb2Z0d2FyZSByZXN0cmljdGlvbiA/DQpMYXcg
cmVzdHJpY3Rpb24gPw0KDQpCZXN0IHJlZ2FyZHMgR2VvDQoNCi0tDQpHZW9mZnJveSBMRVRPVVJO
RVVSDQpFbWJlZGRlZCBTb2Z0d2FyZSBFbmdpbmVlciwNClNTSUMsIFBhcmlzDQogDQpFbWFpbDog
Zy5sZXRvdXJuZXVyQHNhbXN1bmcuY29tDQpUZWw6ICszMyA2IDQ1IDE0IDI0IDMyDQogDQogDQog
DQoNCu+7v0xlIDI2LzAzLzIwMjAgMDk6MjQsIMKrIEpvaGFubmVzIEJlcmcgwrsgPGpvaGFubmVz
QHNpcHNvbHV0aW9ucy5uZXQ+IGEgw6ljcml0IDoNCg0KICAgIE9uIFRodSwgMjAyMC0wMy0yNiBh
dCAwODoxOSArMDAwMCwgR2VvZmZyb3kgTGV0b3VybmV1ciB3cm90ZToNCiAgICA+IEhlbGxvIE1h
dHRoaWFzLA0KICAgID4gDQogICAgPiBUaGUgQVgyMDAgbW9kdWxlIHNlZW1zIHRvIHN1cHBvcnQg
QVAgbW9kZSBpdCB3b3JrcyB3aXRoIDIuNEdIeiBXaWZpDQogICAgPiA4MDIuMTFuIG1vZGUsIEkg
dGVzdGVkIGl0LiBCdXQgbWF5YmUgaXQgY291bGQgbm90IHN1cHBvcnQgdGhpcyBtb2RlIGluDQog
ICAgPiA4MDIuMTFheC4gDQogICAgDQogICAgMi40IEdIeiBzaG91bGQgYmUgT0sgLSA1IEdIeiBp
cyBnZW5lcmFsbHkgbGltaXRlZCBvbiB0aG9zZSBkZXZpY2VzIGR1ZQ0KICAgIHRvIHJlZ3VsYXRv
cnkgcmVzdHJpY3Rpb25zLg0KICAgIA0KICAgIGpvaGFubmVzDQogICAgDQogICAgDQoNCg==
