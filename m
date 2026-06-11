Return-Path: <linux-wireless+bounces-37673-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2TUbGge+KmoqwAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37673-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 15:54:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E56727C6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 15:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.it header.s=s2048 header.b=hZVpKO3m;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37673-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37673-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=yahoo.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9EFF3084872
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0213F99F4;
	Thu, 11 Jun 2026 13:54:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219953C10BE
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 13:54:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186052; cv=none; b=VFX5odWf/rtH8cxT+AhK7oGYRxEXjoqmLzDierCvYBBmznthQA0XlxFwhSVAqCtBV+RYNAUQ7dUXN5+K77SSLrDLmK6vJA3mZxraI3i7nq8+5zpOQnCwTKH2KCObZQgymowCp6ShK7wvD7pN8ifslMtnzGpau6rbu+oDfjYy0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186052; c=relaxed/simple;
	bh=QinLdydYFFzhfzCwGWVsMabc9s7iP5QrwIHt7oRNp5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyAK+3t/rYAh2F1mEzrCrQeZFhRO6nz7eVOMKvW7wQ2LhXL75ztG9k/ddptgn9ZFxIhKn3lXNu2Wm5xWgyIIj9ERC0mrP6KdgQ0NFVdrItxT08eX4H1ahwM336N7ho44ExOpAK/y46+7YrS7aUwMQHw0K3R7nf827jCWNC/Ngsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.it; spf=pass smtp.mailfrom=yahoo.it; dkim=pass (2048-bit key) header.d=yahoo.it header.i=@yahoo.it header.b=hZVpKO3m; arc=none smtp.client-ip=77.238.177.30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s2048; t=1781186043; bh=aVPPymS4lmAww1BY+GTvl9Z2HVdq0OQBfTx60YXSaGA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hZVpKO3mvFYg1O882lj4Izqcwo1T9Tl8eLw5zUH+t/bUJDJEUi574ueWIhzFE1i5MPtSpxeLkxQP7V/1JCfDKogAauyRYG3w/l1WLohMVVYhncAUKI4UuDHD7bBj1dlabgw0/Ir6GdKeagXnZcojNQVokJ73dZnT0QNVAS+VXetVpfHCsIf4Yca9zxxi1Z+dxCBKF4zxRX+76h2C1U193WkCIo4ceAJ+4+I5vvhBpy2rOdJSYZaWImIa5nYSQpUUaek6Z+Og+A1RybkrVWF/l2kzcG+sFEdkHzGP23gmxkv47lTTEcdUHk3innBz+St/AMcHtWmw6foWiOU15g5YXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781186043; bh=bWATXPZzBlzFynGIY/szF5kdEItWzbQHJF/q2pgd3dJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GFJQTmrg3X8xBWtAQT9FkTIPN8rz4ErBE9R+ec6BmNYFZuBTR0sMZbu/wfaon8BFvehXiP8aVcoJfl+K3x+ZIg/I9RezA/xB6wh/0OCJdPif6ib8m22EMAkzTRw/uiMpM935b0h6Ee2tyolxi4YWVXFrZ7566oa467p1W14X/+bCK86k4R3wL7HWRqb2EUrcEp79A6lo1NwjLYiAq/XimfVk4fq0YKLw+eQSq8mW1MXpB9cQayY8maMuAsnGK3Y6OwV9r4gGDKIPy1gZmfNSYHYQcQo1tKSCFAR6kzhXf1dEZVbaXKK6Rbh/HpN8nSzFy/JgD0+FEyjwBQHKKIYHUA==
X-YMail-OSG: SrEcXyYVM1lFX3z1r73VM_ycb7gDGeEIp_Mph53lqH9BEDhFPAPgXZwGJyO9Dxa
 lOsaS96VL5wCBA7izgjkPpszO4tpa.b4pQ79ZAjemLy8Y357ebaA.utd2LIyxEBKKxXpbc1b7.W.
 Mq3AlpX8hqh2aPPS4pSMT2m1p1IDZbcfvlf5Qz5SqJQAfVsXKIsPlkP4v9sHebWEDDiTB1oQuf8e
 0XbNTUTEJsRg.GlrDFbUzGgfcbMHHvksfWf8YUhQZCNBY2jfi5EyfhVJEmLA7NbpYs8Q0Wlz6xbY
 A8yE7db48ArCxGCUmx7gWU.FPeXkUT4Yrhc8Byf6wKpkYoPIpmxaCpFxuhLtV2i7gCGcK5k_Klft
 B3dsBUoZYCBAYeYWs8r37HudBiZcZM.uULVYHXQ6udiioAy68txzH_lSB.p_0G2xX0eCVTAimqqO
 lhwFtz1VAo8xsryXQxFbk2TapoRboHuUE0QRa6MF99ry81BF8vACUWxeo8K5uvWLr4PlyPgQmi0W
 VwAxj7NOliJbFNARsJQWiFBhAw9kRMkhhEhy2QT1j0IoQdcYqitnl3VTd5ArNvPoKzYEQV4ai13w
 TyDMoZJnEz2dHXTyDh0FQ1TbPL7tjLcWyVctfM3enfN0KuenMlLB.30xOCnW9JZHrGP3yNG.pzHO
 iPPqTleSCdwvOq.gT8Gmgww1TQsTji1KQT9rjS84nQH3BgfuII8GnHvNZKqDrVufjFVnUyNx2cjJ
 uzZdbR4tj0zGR.d4y2NlJAfg0yZDqKTMZdAm0LfqQD8ut.F_P6Q52kJytsmbU6w2AMyS5Z7aQWuv
 x1JySvyhbbXzQNxgpKWFjlWOmPahJUtcw1TiHeaj35uBiCBuDT3oEGWvXNaGLCsXwhiYhuTN8fgZ
 J9ZetMmaUVeX3.9Ks2MMaJxst6MozsI1TZZHP5c_M882hKT1vBgqU2WvR8bTiNocEb9ktOLuF4Ou
 KsulfHWBrCSY7hGQYtEjUd7B95De5Gkgp2.UKZH8eVLjyvj9v7vgtRjutbaYoAzOlXwosb.Hu2wc
 vwirXTFDRJSCJk0Xrcd1loJkqFguASeKHiLmRnMEy6l4epcQ2K.jvrch2GBdgTGzwf6EaJ8uSWAJ
 1gKvr7T2y6eqwBZsdvfBByKhFe7UQiSirj54LeTNIFhbe6ijKlWa09NMBBNMcYh8QirWGrOKUTDT
 4fXAZaeRqS0C2vnJ8mVN3JRhAFv86Z1vH3rkugaC2VEdhvoj2WshsQWRjjkwY68Osuxm_t.B.ZGN
 DdOWDlaHa_.OStV8S24VD3G4FZTneuuU64cC5CjXwZ.CmjMMDd6NA.cd7suz05j5NyAM.ta3pynn
 CEdrvOTPj_gEAqmlzm51d2VTuzX.jEJZzadUWLJrkpFhtNUyBbq851YyWtgGc.ELU2.qpwAHiifx
 idl3PubAb_Z_BmVos4P8tV5FRYMWNLvdHsx1oVV03ACnv6pEnAoxMizxKo09IToCG5lBhl5P47Ym
 VRBK7Du4l7lcXytotGXlzlXZkskHmk9GCn6iMpGgxy5PGVi1m2odmZYONaFS67urnZZqVGRhzPEt
 SsTUe1qSCE79yvUT4Y.BLnyIGbo1cgvR5ImHVWwL5yGcTBesiu505JMHKmiuNqB88zf7r4ee6Xwb
 .rDYEKokTOsNfKP3nBtEndRNSPXSkoJBUdzNEGg7YIOlvTfg4zOTG3up6.DSc98Wnl4Vco7ocK88
 tEJcq5YxVOCSNAZZ46n63AJOGGFvMvZvSX52TO.HZNBdYnkDPcbHVtgzAOwO1uY9kvYcsYhmbApf
 5nU51aNl2qHQHMwiO5y5uEfYsvPQIODgUs31y3kk7MWeid4vvIFdMxeZzXY5JRaFqel4gAtFBO2v
 3A53IF9u.OnhpS2iUzZ.W5py2CMMxW.btEMUb9TddX4n9bhL1y7pCAVCRJ8w0sNK60PrWE9yUFL1
 euwT1Tv6lIBbbkepbIQCSW.axbdrqaPCFL8bGFu0O_EnnbvZ66dLbe2xJPwZbLl005fMjPKohEtB
 1josW5v.akdn6i1YaTo1fSy.8YImDYVREnGAmflR2MumRA36jUIKabe2Ms0.9I5Hh23ezMoxCRjM
 AsSiPbHoTYhjhcop8umObPBPevxjnvoOYQmWPQqhrTm7Q1BQa_y3heBG7wKVjHsbza5jNJzwCt3R
 3gNDEuRF4qtSdu4LxK.FqM.6z3tVzly4Qm8ywWzypwPr2lfthvdKEpHouhLnGXojyEf7Ov.swD3B
 GCjlQerwjBhprGJEMxgz.odYDk0mOAoaUOH5742WKgvUTwXSYquAJthQQtK.1168i5pP5Rozc5Ge
 WeGP7A79.DKRzArohqFY-
X-Sonic-MF: <giovannisantini93@yahoo.it>
X-Sonic-ID: dabd766f-5f74-40af-bf73-06a68c4b29e2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Thu, 11 Jun 2026 13:54:03 +0000
Received: by hermes--production-ir2-89844b765-gkszj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c4171e10cdbfd69951135a50765e3e49;
          Thu, 11 Jun 2026 13:11:27 +0000 (UTC)
Message-ID: <02e09f1a-2807-4fec-aacf-1bc4bbb1ccd1@yahoo.it>
Date: Thu, 11 Jun 2026 15:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: WiFi card is not offloaded properly when suspending the OS
To: Ping-Ke Shih <pkshih@realtek.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
References: <10da4c45-74ed-4deb-8c88-6d0b803465ba.ref@yahoo.it>
 <10da4c45-74ed-4deb-8c88-6d0b803465ba@yahoo.it>
 <efae0a4db2ab4b6193922b393d3dcdd6@realtek.com>
Content-Language: en-US
From: Giovanni Santini <giovannisantini93@yahoo.it>
Autocrypt: addr=giovannisantini93@yahoo.it; keydata=
 xjMEaH5G6BYJKwYBBAHaRw8BAQdAZnF+SJD511cVwFnagEObR10TvHEDWiUkXn55qPW4mEPN
 LUdpb3Zhbm5pIFNhbnRpbmkgPGdpb3Zhbm5pc2FudGluaTkzQHlhaG9vLml0PsKTBBMWCgA7
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEsZlH+Qx7w0bL59UyBjXtZomc07YFAmh+
 UU4CGQEACgkQBjXtZomc07aqRAD/dTapfdaiXcED3umK46Ef4oj+4yMmgvILQvAzbTWCW8oB
 AMbcBT7PaB6GuHTLiM0mZwLaB8koObNKxw3XtV7kMw4HzjgEaH5G6BIKKwYBBAGXVQEFAQEH
 QI7SNDV1L0Dq0IjkhOsUDwU7Wzr+AunkhuOy1hUDbY1UAwEIB8J4BBgWCgAgFiEEsZlH+Qx7
 w0bL59UyBjXtZomc07YFAmh+RugCGwwACgkQBjXtZomc07YxZQD9GgcfEawEgJeUijTqZtoq
 /knXol2L++0rMJkdr1SODwYA/07vSweYeVzo00XbyjcQ1le1Y852Ktp6A7O+DZsQJZoG
In-Reply-To: <efae0a4db2ab4b6193922b393d3dcdd6@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25942 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.it,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.it:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.it];
	TAGGED_FROM(0.00)[bounces-37673-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:stable@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:regressions@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[giovannisantini93@yahoo.it,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giovannisantini93@yahoo.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.it:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,yahoo.it:dkim,yahoo.it:email,yahoo.it:mid,yahoo.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B34E56727C6

Hi Ping-Ke,

In short I should build the LTS kernel using the provided source with 
all the module patches applied one by one, correct?

If so, should I also set the modprobe.d options plus disable IOMMU?

After I know this I can start testing.


Small update: the .35 LTS kernel has no issues for me, while 7.0.11 works.

I was able to get my laptop to sleep a few times, but at a certain point 
the issue happened.

It is a bit hard to replicate the issue, so I will try my best.


On 2026-06-08 03:32, Ping-Ke Shih wrote:
> Giovanni Santini <giovannisantini93@yahoo.it> wrote:
>> Jun 02 17:25:33 archlinux-tug kernel: rtw88_8822ce 0000:03:00.0: failed
>> to send h2c command
>> Jun 02 17:25:33 archlinux-tug kernel: rtw88_8822ce 0000:03:00.0: failed
>> to send h2c command
>> Jun 02 17:25:33 archlinux-tug kernel: rtw88_8822ce 0000:03:00.0: failed
>> to send h2c command
>> Jun 02 17:25:33 archlinux-tug kernel: rtw88_8822ce 0000:03:00.0: failed
>> to send h2c command
>> Jun 02 17:25:36 archlinux-tug kernel: rtw88_8822ce 0000:03:00.0: failed
>> to poll offset=0x5 mask=0x2 value=0x0
>> Jun 02 17:25:36 archlinux-tug kernel: ------------[ cut here ]------------
>> Jun 02 17:25:36 archlinux-tug kernel: failed to read DBI register,
>> addr=0x0719
> Add these below to see if it can help.
>
> sudo nano /etc/modprobe.d/rtw88.conf
> options rtw88_core disable_lps_deep=y
> options rtw88_pci disable_aspm=y
>
> After cold reboot, check /sys/modules/rtw88_*/paramters/* to see if
> the modification takes effect.
>
>> I'm attaching the full boot log, if you need a fresh one I can provide it.
> Before "failed to poll ..." log, I also see
>
> Jun 02 17:25:02 archlinux-tug kernel: rtw88_8822ce 0000:03:00.0: AMD-Vi:
>   Event logged [IO_PAGE_FAULT domain=0x000e address=0xae9668bc flags=0x0000]
>
> Please try to turn off IOMMU by editing /etc/default/grub
> GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amd_iommu=off iommu=off"
>
> And then update-grub
>
>> I run ArchLinux with KDE Plasma, for networking I use NetworkManager and
>> wpa_supplicant.
>>
>> If you would like me to run tests with e.g. just iwd I can do so, just
>> let me know what setup you would like me to have.
>>
>> I do not have this issue with the LTS kernel 6.18.34. This affects 7.0
>> and 7.1.
>> I believe this issue was not present in < 7 kernels, but I cannot guarantee.
>> I can however downgrade to previous kernels to understand where the
>> issue was introduced.
> The commits between 6.18.34 ~ 7.0.10 are quite few, and I can't find the
> one that can affect the behavior. Please switch your kernel back to 6.18.34,
> and apply rtw88's patches added until 7.0.10.
>
> Since the last commit of 6.18 is fce6fee0817b8899e0ee38ab6b98f0d7e939ceed
>
> Please use below commands to get the (20) patches:
> drivers/net/wireless/realtek/rtw88$ git format-patch v7.0.10...fce6fee0817b8899e0ee38ab6b98f0d7e939ceed -- ./
>
> Then you can add them one by one to see which one is the cause.
>
> The git repository you need is:
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>
>
> Ping-Ke
>
>
-- 
Giovanni Santini


