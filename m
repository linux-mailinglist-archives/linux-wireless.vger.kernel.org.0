Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6142B241D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 19:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKMS4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 13:56:20 -0500
Received: from mail1.nippynetworks.com ([91.220.24.129]:56396 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMS4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 13:56:19 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 13:56:18 EST
Received: from Eds-Mac.local (unknown [94.228.36.46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4CXnZZ5J2gzTgWR;
        Fri, 13 Nov 2020 18:49:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1605293387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDOxE/QYSIDmquLpxTzlBELSiRSur5tED2eSsbOZwV8=;
        b=F/CG2iqk0YMEvsevQWsKpPjjO0Us8Qvwjba6lJ4/11APmGjpI/4jThkqeResnb7/Cf5QSL
        SzNu7xwQnar7utElCtAWYauaCHkukTcuRHnqlKGerIyEKwoqap+/vYuQB+VXGIfgf9b75t
        YvSGWAkcHZjfRzkFP6I7+v2KQsVQunA=
Subject: Re: [wireless-regdb] Correction of wireless-regdb for GB
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
 <20201106214446.GG6125@ubuntu-x1>
From:   Ed W <lists@wildgooses.com>
Message-ID: <2a710032-f2ec-d55b-5da4-d881089fe0cd@wildgooses.com>
Date:   Fri, 13 Nov 2020 18:49:40 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201106214446.GG6125@ubuntu-x1>
Content-Type: multipart/mixed;
 boundary="------------702AFDA4ECAA478A81F0AAB2"
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------702AFDA4ECAA478A81F0AAB2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Seth

Thanks for patching this. Can I also bring a later patch that I posted to=
 your attention, the actual
patch is now out of date, but I'm posting verbatim since I think there is=
 a 25Mhz discrepancy (?)
and also my patch is almost certainly wrong, so I'm after your guidance!!=
 :-)

Essentially there has been a recent result of a consultation in the UK (G=
B) to expand wifi into 6Ghz
*AND* to NOT require DFS on high 5Ghz channels.

So in summary, the change you just made (sorry) can now be set to *NOT* n=
eed DFS in the high
channels around 5.7Ghz. More details in the links below.

In particular one of the additional frequency ranges (6Ghz) has an intend=
ed use of indoor where it
has large power outputs (and encouraged to use larger powers by request o=
f Intel), but it is *ALSO*
allowed to be used outdoor with very low power requirements (possibly it =
will later fall under the
UK's allowance to use higher output power if you buy a =C2=A350 licence?)=
=2E I've marked it as INDOOR-ONLY
since that seems safest - I'm unclear how to mark something for dual use?=


These changes significantly expand the available 5Ghz space in the UK, so=
 would be nice to get
upstream for general use


Notes:

https://www.ofcom.org.uk/__data/assets/pdf_file/0036/198927/6ghz-statemen=
t.pdf

https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf

Thanks if you might make this second change!

Ed W


On 06/11/2020 21:44, Seth Forshee wrote:
> Sorry for not responding sooner. I had started to look into this when
> you sent the message, but I had to set it aside and then forgot to pick=

> it back up.


--------------702AFDA4ECAA478A81F0AAB2
Content-Type: text/plain; charset=UTF-8;
 name="0001-Update-regulatory-rules-for-UK-GB.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Update-regulatory-rules-for-UK-GB.patch"

RnJvbSBlZTBhYWQ0NTY2YjIwNmYzMTNlOTJhYjRhZTk4Zjc4Njc2Nzg5MmNkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiByb290IDxyb290QHR3b2N1YmVkLm5pcHB5bmV0d29y
a3MubGFuPgpEYXRlOiBUaHUsIDE3IFNlcCAyMDIwIDEzOjMxOjE4ICswMDAwClN1YmplY3Q6
IFtQQVRDSF0gVXBkYXRlIHJlZ3VsYXRvcnkgcnVsZXMgZm9yIFVLIChHQikKTUlNRS1WZXJz
aW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRl
bnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoZSBJUi0yMDMwIGRvY3VtZW50IG9uIHA0
NyBjbGFyaWZpZXMgYSBkaWZmZXJlbmNlIGZvciB0aGUgVUsgb24KNTcyNS01ODUwTWh6IGZy
b20gdGhlIHJlc3Qgb2YgdGhlIFVLLiBQb3dlciBsZXZlbHMgYXJlIGhpZ2hlciBhbmQgaXQn
cwpwb3NzaWJsZSB0byByYWlzZSB0aGVzZSBmdXJ0aGVyIGJ5IHB1cmNoYXNpbmcgYSA1MCBH
QlAgcmFkaW8gbGljZW5jZS4KClNpbmNlIEphbiAyMDIwIE9mY29tIGhhcyBzb2xpY2l0ZWQg
Y29tbWVudHMgb24gZnVydGhlciBkZXJlZ3VsYXRpbmcgdGhpcwpiYW5kIHRvIGJyaW5nIGl0
IGludG8gZ2xvYmFsIGFsaWdubWVudC4gREZTIHJlcXVpcmVtZW50cyBoYXZlIGJlZW4KcmVt
b3ZlZCBhbmQgYSBuZXcgYmFuZCBpbiB0aGUgNkdoeiBzcGFjZSBoYXMgYmVlbiBtYWRlIGF2
YWlsYWJsZSB3aXRoCjI1MG1XIHBvd2VyIGxldmVscyAoaW5kb29yLCAyNW1XIG91dGRvb3Ip
LCBhbHNvIHdpdGggbm8gREZTIHJlcXVpcmVtZW50LgoKU2lnbmVkLW9mZi1ieTogRWQgV2ls
ZGdvb3NlIDxsaXN0c0B3aWxkZ29vc2VzLmNvbT4KLS0tCiBkYi50eHQgfCA3ICsrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZGIudHh0IGIvZGIudHh0CmluZGV4IGFjMzI0ODMuLmNjNWZmZDAgMTAwNjQ0
Ci0tLSBhL2RiLnR4dAorKysgYi9kYi50eHQKQEAgLTU4OCwxMyArNTg4LDE2IEBAIGNvdW50
cnkgRlI6IERGUy1FVFNJCiAjIEdCOiBodHRwczovL3d3dy5vZmNvbS5vcmcudWsvX19kYXRh
L2Fzc2V0cy9wZGZfZmlsZS8wMDE5LzEzNjAwOS9PZmNvbS1JbmZvcm1hdGlvbi1TaGVldC01
LUdIei1STEFOcy5wZGYKICMgR0I6IGh0dHBzOi8vd3d3Lm9mY29tLm9yZy51ay9fX2RhdGEv
YXNzZXRzL3BkZl9maWxlLzAwMjgvODQ5NzAvaXItMjAzMC5wZGYKICMgR0I6IGh0dHBzOi8v
d3d3Lm9mY29tLm9yZy51ay9fX2RhdGEvYXNzZXRzL3BkZl9maWxlLzAwMTMvMTI2MTIxL1N0
YXRlbWVudF9JbXBsZW1lbnRpbmctT2Zjb21zLWRlY2lzaW9uLW9uLXRoZS01Ny03MUdIei1i
YW5kLnBkZgorIyBHQjogaHR0cHM6Ly93d3cub2Zjb20ub3JnLnVrL19fZGF0YS9hc3NldHMv
cGRmX2ZpbGUvMDAzNi8xOTg5MjcvNmdoei1zdGF0ZW1lbnQucGRmCiBjb3VudHJ5IEdCOiBE
RlMtRVRTSQogCSgyNDAwIC0gMjQ4My41IEAgNDApLCAoMTAwIG1XKQogCSg1MTUwIC0gNTI1
MCBAIDgwKSwgKDIwMCBtVyksIE5PLU9VVERPT1IsIEFVVE8tQlcsIHdtbXJ1bGU9RVRTSQog
CSg1MjUwIC0gNTM1MCBAIDgwKSwgKDEwMCBtVyksIE5PLU9VVERPT1IsIERGUywgQVVUTy1C
Vywgd21tcnVsZT1FVFNJCi0JKDU0NzAgLSA1NzI1IEAgMTYwKSwgKDUwMCBtVyksIERGUywg
d21tcnVsZT1FVFNJCisJKDU0NzAgLSA1NzMwIEAgMTYwKSwgKDUwMCBtVyksIERGUywgd21t
cnVsZT1FVFNJCiAJIyBzaG9ydCByYW5nZSBkZXZpY2VzIChFVFNJIEVOIDMwMCA0NDAtMSkK
LQkoNTcyNSAtIDU4NzUgQCA4MCksICgyNSBtVykKKwkjIFNlZSBVSyBzcGVjaWZpYyBub3Rl
cyBpbiBpci0yMDMwLnBkZiwgcDQ3CisJKDU3MjUgLSA1ODUwIEAgODApLCAoMjAwIG1XKSwg
QVVUTy1CVywgd21tcnVsZT1FVFNJCisJKDU5MjUgLSA2NDI1IEAgMTYwKSwgKDI1MCBtVyks
IE5PLU9VVERPT1IsIEFVVE8tQlcsIHdtbXJ1bGU9RVRTSQogCSMgNjAgR0h6IGJhbmQgY2hh
bm5lbHMgMS02CiAJKDU3MDAwIC0gNzEwMDAgQCAyMTYwKSwgKDQwKQogCi0tIAoyLjI2LjIK
Cg==
--------------702AFDA4ECAA478A81F0AAB2--
