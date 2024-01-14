Return-Path: <linux-wireless+bounces-1892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2B82D1B9
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15ED51F2128D
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7865D313;
	Sun, 14 Jan 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Ou6bG/I7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19EC8FF
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705253331; x=1705858131; i=fiona.klute@gmx.de;
	bh=mKKAOu+C7D851S7MYUpn0527QOm3purZG8J/TX4Zilk=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
	b=Ou6bG/I7F2fVlT0QwXrSsfJzyGCj3wDzEIXEVUVVqbl0CcvDMF33tUBMqtNkztbi
	 sWACJtnLRviWR+wvkbxnNtDmOP9mGbdZIVCkx96HNjE/a8V9PoDcsv9XHaMMM3tNe
	 mvdOMx8t/j6m+J9EFqunJRWBhqJAYUhPPwcNFqDPWvLlVrD1g6XuZeSUrpDwCYg3v
	 WAUAlty56KZ4PJXT3S7CgQo5UuloYTR38FWYK/FjUHfxE2g3NOQdDMf3DbyHYmr/k
	 wfKb0RywWCs+FZyR3k3JFWII9nkuWtjEX1mHNmYGk4D9RjWTvx4NDmfIwHCDOpMwJ
	 USp9/LrYW7b8hN7LTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.127.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1qtqXE3ItK-00fQLz; Sun, 14
 Jan 2024 18:28:50 +0100
Message-ID: <1154e0cc-4c37-4d69-8f2e-d81ae5b93624@gmx.de>
Date: Sun, 14 Jan 2024 18:28:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Subject: Extending rtw88 for rtl8723cs/rtl8703b SDIO chips
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EwFo0acik1rPNJpYvr2IsgOIUNPP0OVBvN6Y+NvVay6+id5YKrB
 8bi6Oyj9gmhLjR6ZhKJ9VB8iUO7bT29aiBzwWO6jbYRceexdNaptdRN7A6BTbdibLEKFEa6
 +43mFcx3wvnY4/QrKoTdwnMpIITLO2Srbp8Gm8xiJ909aDM+Eppj5DmwBBvTs1FrF6tRU9z
 BmXta0ZzTdR2c175izqpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kPZm2m72B8I=;S9nE6y2l3h29awww0KuTfmp+a05
 TwoYv39NQeORqbYIYDlVYyDdKA3RB1YxxL63d/h7A1xRqcAw/7LtlvfnB4VvO41AfnC65ASVK
 Nb9bWe1qrGxUwLUhp+0/BmeaDgY7npy+JagkFkk/SWpvgCi7lReFql2S3VcQnJPI+S80clrSu
 a4SmoZIF9+ZDsUN4jue7FCBb7j+E4Nm3uOS3o/JDMMdc6/aUtiQlsYgapjKxIHk/xJc1Ir0XG
 VALkCChLUaPEKmhSsvotiZes/hHd7B/Syo6WUp3hj+Hju4AyfCtOH3ZqoEWpqDpATHYtX2kqC
 0Hz0zUjA178AHWOvyT8DC/GLjewqzNyfY6B16RAnwpGRRbP26q52K+KJVjWiw2UWjVemc8vbC
 OHowIGGBVO5uTF0ElziUTPUBqQKlolizvhu9UzNo69LYPFgvuWmYkwEPbC5JLgGNy04Ryymxc
 e4MkrMOggTHi+uSWymT/LsJPA1WBVTidhW2qrtgkTbEx0lFau05POdT50Yb/aSOu9pU1pUKOi
 bP/Ld453tAg0xyon/rwO0O0K/9NUFptSv4BaYbm+aCkdpQB1MeKo4ecGPL7zH9B5SB5RvSgPg
 SvaBRgE61/jwyLZpVd5Mn98YNO4pHnoAsOWLdOujPfa69NVgFM2814rP3mlMacIDSEbUgLuWw
 Zmi8x50SyhKzPb6ULaL3MO37vV9ue1ANmxy5ZCjsnw7JW6YC5ECIxHG2+qRg0Um9fRNkYk0t9
 hy0J0mFQmsd868QpD1Ipjh89byWKoR86gDRsMIoCkoGCclCZPfbRPA3sgOADknVnqYKtpm+5E
 iF1jkRaok7pGpZ4ksJBX1Kf9wKzu8Xcb1t1HwV/BbGZu5ApDcJzzmJKEL5+TOdWIhuorZL+uy
 moSeG3N5/wKkQ8repnt89fwMtj5ts6V4egZVUJ2M2u6o8YhMHARAIlOGdu8enzxglY3DaWyn5
 Bxi0sviSVLUICSMBA/IsWtAPNJU=

Hi,

I'm trying to extend the rtw88 driver to support the rtl8723cs card used
in the Pinephone, with its rtl8703b chip. The code is far from ready for
review (I'm halfway into chip initialization so far, look at [1] if you
like), but I'd like to ask a few question to avoid wasting time.

1) The 8703b chip is pretty similar to the already supported 8723d, I
can directly reuse some functions defined in rtw8723d.c (e.g. efuse
parsing). Would moving those to a shared support module ("rtw88_87x3" or
similar) be acceptable? If not, what's the recommended approach?

2) I'm currently using firmware extracted from the (not in mainline and
likely never will be) rtl8723cs driver [2], where it's stored as u8
arrays in source with GPL license header. Do you know if that'd be
acceptable for linux-firmware? Ping-Ke, from your mail address I'm
guessing you work at Realtek, is there any chance to get 8703b firmware
released directly? As a fallback, could the driver be accepted if people
will still need to get firmware separately?

3) Finally, licensing: Are GPL-only module/chip drivers for rtw88
acceptable? A shared support module would of course stick with the
current dual license.

Thanks and best regards,
Fiona

[1]
https://github.com/airtower-luna/linux/tree/rtw88_8723cs/drivers/net/wirel=
ess/realtek/rtw88
[2]
https://codeberg.org/megi/linux/src/branch/orange-pi-6.7/drivers/staging/r=
tl8723cs

