Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4162E1945C7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZRsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 13:48:10 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:55451 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZRsJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 13:48:09 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 13:48:09 EDT
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20200326173849usoutp027b7c77dc2fede7b97bd40797b0960942~-61GugOMc0544505445usoutp02H;
        Thu, 26 Mar 2020 17:38:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20200326173849usoutp027b7c77dc2fede7b97bd40797b0960942~-61GugOMc0544505445usoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585244329;
        bh=zMznNEJRp/t2KdnNgSYa3aJ/0v6LHH5Do8QWzvK623E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=htNLXimNdiPpcslEB7z80+Czn9raWqXf8GTm5mkOe1OUKQPbEM37BA+Q9w8do1+/Z
         ClfpUZuBEX71cGaEJ90yDMfMbBBEDdAle+vh1ZqCc6fzKVee2oxARqs0+fImhZMLTy
         /xQTFkNfgMLrIHnEnzY6FPESrBbxDT3SdCObymjk=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326173849uscas1p219aa9d5427958cdf75a573dad34b8ecd~-61Gl9JZr2218122181uscas1p2Y;
        Thu, 26 Mar 2020 17:38:49 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 73.91.20299.9A8EC7E5; Thu,
        26 Mar 2020 13:38:49 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326173849uscas1p22920d6363951949192e9480125dd42bc~-61GLRNSD3267432674uscas1p2l;
        Thu, 26 Mar 2020 17:38:49 +0000 (GMT)
X-AuditID: cbfec370-d21ff70000024f4b-20-5e7ce8a9b662
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 33.CB.59630.9A8EC7E5; Thu,
        26 Mar 2020 13:38:49 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.1713.5; Thu, 26 Mar 2020 10:38:48 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::8114:6cd2:57f9:48de]) by
        SSI-EX1.ssi.samsung.com ([fe80::8114:6cd2:57f9:48de%7]) with mapi id
        15.01.1713.004; Thu, 26 Mar 2020 10:38:48 -0700
From:   Martin Bourreau <m.bourreau@samsung.com>
To:     Dan Williams <dcbw@redhat.com>,
        Geoffroy Letourneur <g.letourneur@samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Matthias May <matthias.may@neratec.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
CC:     Gilles Mazars <g.mazars@samsung.com>,
        "Kitty (Xia) Lou" <kitty.lou@samsung.com>,
        Harris Warren <harris.w@samsung.com>,
        Raymond Chan <raymond.chan@samsung.com>,
        Duncan McDonald <d.mcdonald@samsung.com>,
        "Seshu (Leela Seshu Reddy) Cheedepudi" <seshu.reddy@samsung.com>
Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
Thread-Topic: Geoffroy LETOURNEUR: Samsung AX200 system integration on
        Nvidia Nano.
Thread-Index: AQHWAr2wsmsOeqOOfECn+0wE7X7A4aha8ZSAgAAdewD//3tc7IAAhtqAgABVUoCAAETYgA==
Date:   Thu, 26 Mar 2020 17:38:48 +0000
Message-ID: <ECFB8F73-CA97-4100-9B89-029B4701884A@samsung.com>
In-Reply-To: <a70556a0cacc376826f38258156a0224d2f54b56.camel@redhat.com>
Accept-Language: en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CD26076FADC154289B33B5659F03F5B@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djX87orX9TEGSxZrW6xfvoaRouPGz6x
        WLxZcYfdonPzREaL7s1fGR1YPRbvecnksfkfj8f7fVfZPPp7t7F4fN4kF8AaxWWTkpqTWZZa
        pG+XwJVx5+FRtoJtAhUn1r9kaWBsEOhi5OSQEDCR2LDiM1sXIxeHkMBKRonmxn0sEE4rk8Sf
        e/fZYKoaWr+zQiTWMkqsnvKOHcL5yCgxc810qP4DjBKP9m5hBWlhE9CTWP73DhOILSIwj0mi
        52A2iM0sMIVJ4tz8YhBbWCBEomvKN6iaUInLD0+wQ9hhEnOmzQGzWQRUJT5P6WMBsXkF7CTm
        Hp8FNp9TwEPi7MXdzCA2o4CYxPdTa5gg5otLfDu6khnibEGJRbP3QNliEv92PYR6R1Hi/veX
        QPM5gOo1Jdbv0odotZN4NvMyG4StKDGl+yE7xFpBiZMzn7BAtEpKHFxxAxxEEgLz2CV2dCxl
        BJkjIeAi8eY+N0SNtMTfu8uYIOxuRon/qzgh6qcwSnQ2N0HdYy3xcO98pgmMKrOQnD0L4aRZ
        SE6aheSkWUhOWsDIuopRvLS4ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwEZ3+d7hgB+P1JcmH
        GAU4GJV4eBvaauKEWBPLiitzDzFKcDArifA+jQQK8aYkVlalFuXHF5XmpBYfYpTmYFES533w
        6GWskEB6YklqdmpqQWoRTJaJg1OqgbEgN+vIkbtqE9IKZ5tvLw06Mv+P//Mv27aEzDstpDCh
        hifXw6B44uQHjCvab1+9tf+v70azD646a3WW7WisWfbr0/LFO8Q+5by6HfG+vfvcHsGKTd2t
        R0unnE+ymMclV71EcWXV2Qs6x0IkBXujlognPWxVbq9nUmi8HX/v3VetWa/f7fxYKqauxFKc
        kWioxVxUnAgA6guXmEADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWS2cA0SXfli5o4g47pvBbrp69htPi44ROL
        xZsVd9gtOjdPZLTo3vyV0YHVY/Gel0wem//xeLzfd5XNo793G4vH501yAaxRXDYpqTmZZalF
        +nYJXBl3Hh5lK9gmUHFi/UuWBsYGgS5GTg4JAROJhtbvrF2MXBxCAqsZJZZ+ewXlfGSUuHp6
        KpRzgFGifUE/K0gLm4CexPK/d5hAEiICc5gkfqzoZwJJMAtMYZI4N78YxBYWCJHomvINLC4i
        ECrx4Otkdgg7TGLOtDlgNouAqsTnKX0sIDavgJ3E3OOzwBYICWxmlni+iAvE5hTwkDh7cTcz
        iM0oICbx/dQaqF3iEt+OrmSG+EFAYsme81C2qMTLx/9YIWxFifvfXwLt4gCq15RYv0sfotVO
        4tnMy2wQtqLElO6H7BAnCEqcnPmEBaJVUuLgihssExglZiHZNgth0iwkk2YhmTQLyaQFjKyr
        GMVLi4tz0yuKjfJSy/WKE3OLS/PS9ZLzczcxAqP49L/D0TsYby5JPsQowMGoxMPb0FYTJ8Sa
        WFZcmXuIUYKDWUmE92kkUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvufiCKCGB9MSS1OzU1ILU
        IpgsEwenVAPj1jZ2qZYJdq4ievEvXjJcOHAjzp359Xpt2yeJwg8Wv7607HODgVFBve/T8Ltq
        /I7lt7sLRG7EBb042BI1xcTsQOxu3ucvVfeuk9rTlcnC3OppcUV+wfT2XXYmnZJ6ln/PWKQZ
        h2elvDPTkVtSoh2bdpipUj3958MPamYbrLQEfawTrI0CryixFGckGmoxFxUnAgAFGOlE3gIA
        AA==
X-CMS-MailID: 20200326173849uscas1p22920d6363951949192e9480125dd42bc
CMS-TYPE: 301P
X-CMS-RootMailID: 20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
        <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
        <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
        <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com>
        <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
        <E16BF92C-B26C-4219-B09B-1DEBF96A3911@samsung.com>
        <a70556a0cacc376826f38258156a0224d2f54b56.camel@redhat.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkaW5nIHBlb3BsZSBmb3IgYXdhcmVuZXNzIG9mIHRoZSBjb252ZXJzYXRpb24uIA0KDQrvu79M
ZSAyNi8wMy8yMDIwIDE1OjMyLCDCqyBEYW4gV2lsbGlhbXMgwrsgPGRjYndAcmVkaGF0LmNvbT4g
YSDDqWNyaXQgOg0KDQogICAgT24gVGh1LCAyMDIwLTAzLTI2IGF0IDA5OjI3ICswMDAwLCBHZW9m
ZnJveSBMZXRvdXJuZXVyIHdyb3RlOg0KICAgID4gSGVsbG8gSm9oYW5uZXMsDQogICAgPiANCiAg
ICA+IFdoYXQgeW91IG1lYW4gYnkgcmVndWxhdG9yeSByZXN0cmljdGlvbnM/DQogICAgPiBIYXJk
d2FyZSByZXN0cmljdGlvbiA/DQogICAgPiBTb2Z0d2FyZSByZXN0cmljdGlvbiA/DQogICAgPiBM
YXcgcmVzdHJpY3Rpb24gPw0KICAgIA0KICAgIFRoZXJlIGFyZSBsZWdhbCByZXN0cmljdGlvbnMg
b24gc3BlY3RydW0gdXNlLCBlc3BlY2lhbGx5IGluIHRoZSA1R2h6DQogICAgcmFuZ2UuIFdoaWNo
IG1lYW5zIGFkZGl0aW9uYWwgZWZmb3J0IG11c3QgYmUgcHV0IGludG8gYm90aCBoYXJkd2FyZSBh
bmQNCiAgICBzb2Z0d2FyZSB0byBzYXRpc2Z5IHRob3NlIHJlc3RyaWN0aW9ucy4gQW5kIHBlcmhh
cHMgdGhhdCBlZmZvcnQgd2FzIG5vdA0KICAgIGNvbnNpZGVyZWQgY29zdCBlZmZlY3RpdmUgZm9y
IHRoZSBBWDIwMC4NCiAgICANCiAgICBEYW4NCiAgICANCiAgICA+IEJlc3QgcmVnYXJkcyBHZW8N
CiAgICA+IA0KICAgID4gLS0NCiAgICA+IEdlb2Zmcm95IExFVE9VUk5FVVINCiAgICA+IEVtYmVk
ZGVkIFNvZnR3YXJlIEVuZ2luZWVyLA0KICAgID4gU1NJQywgUGFyaXMNCiAgICA+ICANCiAgICA+
IEVtYWlsOiBnLmxldG91cm5ldXJAc2Ftc3VuZy5jb20NCiAgICA+IFRlbDogKzMzIDYgNDUgMTQg
MjQgMzINCiAgICA+ICANCiAgICA+ICANCiAgICA+ICANCiAgICA+IA0KICAgID4gTGUgMjYvMDMv
MjAyMCAwOToyNCwgwqsgSm9oYW5uZXMgQmVyZyDCuyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5l
dD4gYQ0KICAgID4gw6ljcml0IDoNCiAgICA+IA0KICAgID4gICAgIE9uIFRodSwgMjAyMC0wMy0y
NiBhdCAwODoxOSArMDAwMCwgR2VvZmZyb3kgTGV0b3VybmV1ciB3cm90ZToNCiAgICA+ICAgICA+
IEhlbGxvIE1hdHRoaWFzLA0KICAgID4gICAgID4gDQogICAgPiAgICAgPiBUaGUgQVgyMDAgbW9k
dWxlIHNlZW1zIHRvIHN1cHBvcnQgQVAgbW9kZSBpdCB3b3JrcyB3aXRoIDIuNEdIeg0KICAgID4g
V2lmaQ0KICAgID4gICAgID4gODAyLjExbiBtb2RlLCBJIHRlc3RlZCBpdC4gQnV0IG1heWJlIGl0
IGNvdWxkIG5vdCBzdXBwb3J0IHRoaXMNCiAgICA+IG1vZGUgaW4NCiAgICA+ICAgICA+IDgwMi4x
MWF4LiANCiAgICA+ICAgICANCiAgICA+ICAgICAyLjQgR0h6IHNob3VsZCBiZSBPSyAtIDUgR0h6
IGlzIGdlbmVyYWxseSBsaW1pdGVkIG9uIHRob3NlDQogICAgPiBkZXZpY2VzIGR1ZQ0KICAgID4g
ICAgIHRvIHJlZ3VsYXRvcnkgcmVzdHJpY3Rpb25zLg0KICAgID4gICAgIA0KICAgID4gICAgIGpv
aGFubmVzDQogICAgPiAgICAgDQogICAgPiAgICAgDQogICAgPiANCiAgICANCiAgICANCg0K
