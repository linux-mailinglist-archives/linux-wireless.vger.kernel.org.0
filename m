Return-Path: <linux-wireless+bounces-34108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bzV+C9j6x2mIfwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 16:59:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A238F34F0D8
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 16:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB63330059A4
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD43644C5;
	Sat, 28 Mar 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM7a02V0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA4376472
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774713557; cv=none; b=aMErAfEffib7xUuVPav4rjp45zGmkgbjLDM2l/YAnGZjCUq+JmiMQWvVSPD4PcUOAOMuJgee/Y5Ub7OJFAuAz1Y130eX+5EZY4tl4qypnScWd2/Yad3s6qXXPBnAY216pGHe6u6hRK2+6sKL79EMJumkS8+H3bQ2Wv2b2lPOUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774713557; c=relaxed/simple;
	bh=DvZxylFcHruvbPeEYKBDnW4krrtPrW1e6CzdanuSK0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSX2+h8vr69fa2OJwhW0Ol97Dn3TdZsFDZJkNtPI08iHPldT70sbvNX8DlnuJYp/9R/pxxSJyrDry8vaerWdqxwLgUhYvDscLxNVFinokwP+54UMYbXjn26MmMUxsFXGaTNoP5VvUujLA21koxrYhRjWZ8W7ybpQoh+CJ8WCxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dM7a02V0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66b941ebe79so566979a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774713554; x=1775318354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5H8gCTp/IRDQQxZGW/iIFZfQLZCVS/4MhsWoyOCHpA=;
        b=dM7a02V0ruEaOrp4TG3DuJsdBHdw9OJGoHYRkcAfRc8uTJ3h2ovHVoX+3anJtzbJev
         hNvRrmaE7DKrFp+2dSHo2OV1hpFgz2Md1plE2c1xG3XTfjHXzVIQr/NLxfha06WgK3s6
         8UFAKGExOZiazefYMlDv/hQO+bIYA+0VWuW7xi6kR2+pOAhpm5JnQpWWwSSdpN9l5khT
         bhGUvGsxf+xJv3Ig7xg1eui+iEHiDXmdseJBh+ld0uh2VdO0fmWLMxqQmYt2zAHJsVTk
         G05iz+lQbsDHIOLWj4DfNHRmJyyw8HIab5tPN+Onan41WUgZOFhM6Cv/1OeejZLQ8TFH
         HNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774713554; x=1775318354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5H8gCTp/IRDQQxZGW/iIFZfQLZCVS/4MhsWoyOCHpA=;
        b=LhT+QLiYBiNuthYM7w9mMl+Y1uzeovHQLOw7iQexPmkzWssp+b19E6ii40WZZBwo3m
         YFbMtSLlA+RGNicXzL1LsaKq2Rpi91OIf7v1frM+qsCCREFHJgb8xUog0GqaB5U6SeqX
         D1m2mYtaPsvK95kv7UY09SPRh12wh5AJKpEkGUQXjCsgGcOtCsY1FW1v+uAQmMGCEIQq
         q9MTyXs1MaJrg+fdcIv2YhUZidPu89yR6NMeGFaIxgNu8goMlX1v/OwNs9A5R4llSpQO
         6KFXCFjOyDn+crZPlsj+HoXaTHASqrK8NILdK5tsnLazUM7KT7iReC8EPRDFY/TKxbs9
         CF8w==
X-Forwarded-Encrypted: i=1; AJvYcCUxR/zCoxyy1zTObnVjjY9nW+fk706IvL9srAN3KNIw9o12G3GAEy9Udhb0IWtCFLq4K4CEFOWqVb/BcYJz/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdolaVxTI2ZWoNkiTXU40SQkXq+wAb8Vnxv4wPP1hl7PZXjk2v
	X9xZjoKJ64LMtS/ptRUm3w4Zg2MaM0c3NaNL+7vXaK4m1PckzqFG9b6/czZs3g==
X-Gm-Gg: ATEYQzzkWKdqHkm0sDzMKs4rul49rWEMp5gaXw2mBWUGfOwfcAkzXKDZtnxHe/WxysO
	3HoUln2Dbd754t+GQLWvab1D6igYyzU0QITTY1zseAx9TfwFUYEfzTGZDxtYSXlowjyRzEmv0i/
	9jL8a23/LuqIpueDHvx3rzyJDyJ/XygG88YYjpBHcgqpxqc5bAHCIB2uokifitrQWEMyJlfEgGf
	cQswqdlodOOXtxje1sJNMTWt/x+AETRc/ltiTD+msdyA4fOf+wT/gdOxhdSBmCkpnwgh25DnD8J
	xFsV3mh8RvbNo1GTE9QxAQB51IlJZGYvzCsm+ZLMtCcwFjarmQUcWWlEWtGSxwb50doV1TOisQE
	YO2Uka4+fdBCVu27URQdUw+TzMJk+ct/aGTl60QpcOZ/rZeZTkEew+wP61ETC3bXee/ks0Qq0ph
	aLXzM+CICBMn2iWpugx3rGHuk2nOdJQQ==
X-Received: by 2002:a05:600c:8485:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-48727d77c8fmr103560685e9.15.1774703228845;
        Sat, 28 Mar 2026 06:07:08 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm204120235e9.0.2026.03.28.06.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 06:07:08 -0700 (PDT)
Message-ID: <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
Date: Sat, 28 Mar 2026 15:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: LB F <goainwo@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com>
 <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34108-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A238F34F0D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/03/2026 13:41, LB F wrote:
> Hi Bitterblue,
> 
> Apologies for the delayed response. I applied your diagnostic patch
> right away but held off on replying because the NULL pointer crash
> has not reproduced since — it has been over 36 hours now with no
> oops, which is unusual (previously it occurred in 4 out of 7 boots,
> typically within 2 minutes to 24 hours).
> 
> I wanted to wait and collect the hex dumps from the crash-time burst
> (the 50+ "unused phy status page" events that always preceded the
> oops), as those would be the most valuable. Unfortunately, the crash
> hasn't happened yet during this session. If/when it does, I will
> follow up immediately with those dumps.
> 
> In the meantime, here is what I have so far. The patch is working
> and producing output. I collected 76 "unused phy status page" events
> during this boot, with the following time distribution:
> 
>   14:01       1 event  (isolated)
>   16:33       1 event
>   16:57-17:00 73 events (burst over ~3 minutes, no crash followed)
>   00:03       1 event  (isolated)
> 
> Page number distribution (no page 0 or 1, all are "garbage" pages):
> 
>   page 10: 10    page  7:  8    page  8:  7    page 13:  7
>   page 11:  7    page  9:  6    page 15:  6    page 12:  6
>   page  4:  5    page  2:  5    page 14:  4    page  5:  2
>   page  3:  2    page  6:  1
> 
> Here are representative hex dumps. I'm showing the byte-level dump
> (second print_hex_dump) since it is easier to read:
> 
> Isolated event (page 9):
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (9)
>   00000000: c7 5e 9c 9d 91 69 4d dc b0 67 c2 09 84 33 00 00  .^...iM..g...3..
>   00000010: 00 1e fe 3f cf f2 f0 08 01 29 00 00 00 11 2a 01  ...?.....)....*.
>   00000020: 0e 00 00 00 00 00 00 20                           .......
> 
> Burst event (page 14):
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (14)
>   00000000: bd 2c e0 3d 00 00 00 11 87 0a 40 80 88 33 00 00  .,.=......@..3..
>   00000010: 00 1e fe 3f 3e b6 9b 44 01 2e 00 00 00 11 2a 01  ...?>..D......*.
>   00000020: 20 00 00 00 00 00 00 20                            ......
> 
> Burst event (page 12) — byte 0x10 is 0x7e instead of usual 0x00:
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (12)
>   00000000: 1c b3 7f 15 d1 94 95 7e 70 5e f4 e3 b4 a1 bf 10  .......~p^......
>   00000010: 7e 1e fe 3f 2e f1 62 44 01 2c 00 00 00 11 2a 01  ~..?..bD.,....*.
>   00000020: 14 00 00 00 00 00 00 20                           .......
> 
> Burst event (page 2) — contains MAC addresses:
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (2)
>   00000000: 88 55 51 95 d1 66 ad 50 2f 25 3f 89 ae 35 ef 77  .UQ..f.P/%?..5.w
>   00000010: 00 1e fe 3f 89 68 62 4d 88 42 40 00 8c c8 4b 68  ...?.hbM.B@...Kh
>   00000020: d1 63 6c 68 a4 1c 97 5b                           .clh...[
> 
>   Note: bytes 0x1a-0x1f are 8c:c8:4b:68:d1:63 — my adapter's MAC.
>         bytes 0x20-0x25 are 6c:68:a4:1c:97:5b — the AP's BSSID (partially,
>         the dump is only 40 bytes so it cuts off after 0x25).
> 
> Burst event (page 15) — completely random, no recognizable structure:
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (15)
>   00000000: c6 a1 92 1c a7 68 6b 97 12 bd ad 89 30 98 ab 94  .....hk.....0...
>   00000010: 00 1e fe 3f ec 3f 3e 44 1f c2 91 41 0e 9b 54 5f  ...?.?>D...A..T_
>   00000020: 30 eb 40 18 6f d3 25 62                           0.@.o.%b
> 
> Burst event (page 10) — offset 0x10 is completely different pattern:
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (10)
>   00000000: cb 1c 2a df f1 69 d0 05 58 c0 e8 0e d0 59 87 6e  ..*..i..X....Y.n
>   00000010: 63 7e 56 f0 95 fa b8 d3 d5 4b 3e fa b0 0c 0e be  c~V......K>.....
>   00000020: 42 28 14 89 15 c1 fd ad                           B(......
> 
> Last isolated event (page 4):
> 
>   rtw_8821ce 0000:13:00.0: unused phy status page (4)
>   00000000: 97 ee fa 4e 04 90 00 21 c0 0f 89 80 b3 33 00 00  ...N...!.....3..
>   00000010: 00 1e fe 3f 97 7e 64 90 5d 3e 74 fa 70 e0 39 65  ...?.~d.]>t.p.9e
>   00000020: 48 a4 40 d3 de a9 85 15                           H.@.....
> 
> Observations:
> 
>   - Bytes at offset 0x0e-0x0f are usually 00 00 or have low values
>     in most dumps, but some are completely random.
>   - Bytes 0x11-0x13 are almost always 1e fe 3f (with byte 0x10
>     being 00 or 7e), suggesting this is a consistent part of the
>     RX descriptor that is not corrupted.
>   - The "page 2" dump at 17:00:23 clearly contains the adapter
>     and AP MAC addresses, confirming this is real RX frame data.
>   - Some dumps (page 10, page 5, page 15) have completely random
>     data with no recognizable RX descriptor structure at all.
>   - The 73-event burst at 16:57-17:00 happened over ~3 minutes but
>     did NOT result in a crash this time. Previously, similar bursts
>     of 50+ events within ~1 second always led to the NULL pointer
>     dereference in rtw_fw_c2h_cmd_handle+0x127.
> 
> I will keep monitoring and will send the crash-time dumps as soon as
> the oops reproduces.
> 
> Thanks for looking into this.
> 
> Best regards,
> Oleksandr Havrylov

The other print_hex_dump is important too, so please attach the
full dmesg.

You don't need to wait for a crash. It appears to be caused by
random data, so I don't expect those dumps to be more useful than
these. Of course, adding a NULL check like you said before is a
good idea.

The one dump that contains your MAC addresses has them 24 bytes
lower than they are supposed to be.

