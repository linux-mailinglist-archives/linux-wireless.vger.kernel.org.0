Return-Path: <linux-wireless+bounces-30305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516FCEF666
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 23:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE61D3019BB1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19442C1786;
	Fri,  2 Jan 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jnAL79Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3980274B39
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767391390; cv=none; b=NDlETe810WeuS0cjFIgsQfo6JfmugEYe/mGKolktKl2J1R2EeZ/4sLFdX7DM5S64rajdtXtX0sD3yyq3qHARZmX77ofisFH4RDTkgXMQDBxLMwC5P1CoX7VFzLwU25Qte2lUBk9W0WMwJuEr8rgiFzgD87pHfuDGSdYNf5yB4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767391390; c=relaxed/simple;
	bh=KEElVTQiil4rSM+tRziYGkB1nGYz7nHr4NjJkFgALMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWExAHjR0n5emN7yr555IVMv3rUh5rHf7Gsl4K4n973Ugl3HvTyLnN8KGvinM6Hb4Nt2TV8thXIf1AyDwISMlqjkOJZxJ2uo3hpkVAyQos3a5Qr0lcidegi2COzTAFbhhBB1rQI/pbpTLJ5atiPmnwlyYVvKsHP2IZUWOCsjHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jnAL79Z; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb2314f52so6977207f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767391387; x=1767996187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMdEky+3hic9xaOBKW4p+a1COGBiqV4KayGAxoytduY=;
        b=1jnAL79ZNlU2eoWwMg5NoggOGu0cDmglBH7PMDdpr0eOFI/B4ynywt9Obl9RDnidpy
         Emh1O+BR6VDLVGI60ieLsF0Pagyy2MX58WLEYL+yNszWJ2xoFq0b8bmk6uT/+klyLZ6Z
         Lm1toDgVQ7YTycsvi9Id+dy3WLaSIxrZphm+cE+GQeVhgWsBKbbQEUdQKbq0Iv/k/cMu
         ft164FxjBlxDVD6XthAUZwpCs2EO2L5xbGeWw3+gt922pc+HePjqlEfSZYeeiGiNothO
         z80q1blndPY59jJ1My/IDI4uzdDuFMsEYXf6/iqkZlp6DUBAzjBNCPfPmwDuB9nBCDuX
         ddlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767391387; x=1767996187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMdEky+3hic9xaOBKW4p+a1COGBiqV4KayGAxoytduY=;
        b=uW8LDhRDuA726zBsQ0F+q5Mw2fp+NwsjjJemoCl6DQOgD2DV/ziikKo6w4exWzE43r
         d5OYYoN53PVZp5cP0nGo2qei4ZC0i8o+uzv9LIyWcY3QnT1Wg16JqE+dLjRbA/kwVByt
         HNA59SoY7Bmaz5zPxE22hImdylhKL8KYKDiGdSgGAH8IK6/0nWmx7KWowQxhrOafrDpF
         KUwrr9uWsMqa+t3pz7EO0wzxwyM4LwTQL98NZJQf7rDw8aR/Pk5R7gMWrNcDD+ZU/aFj
         +Kn0DclrPC5Ta/RzgvhM2huv+LwXdgmRRmIoCrzrc4WeVC1Xk+UTE09BnWgW1D2Klzk9
         Q6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq0ixPZ3OfmMIxyRsHDoHz4P4YvHM8H8jjMLF8D2s6idKICaIh7Dvr0Pmd203gSnhweiHnN6kaWcUPqG+iuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiM1NI62nTzIbtcO9OAazkq5QN52lOz7KHc2a4I50XuyIKLzIJ
	ElubHDeb8claMkXXkEFV9uLvQVGbVd8yDlbUDMFC3W1j9s/i5EgzampJTrotKkd5SAEoHJF7Wm9
	WvgqRX7xxZQJghPXX4qEGT4UV8yTyj63JMLA6+ImsjPQI2mwyFu1vrQbGkJk=
X-Gm-Gg: AY/fxX5KdWP9bDOTrjXtMq3VGXXiNZaFEhwlic7L51lQOmfz/6R1LIt94JrLgwKA11X
	7GLEL6obY1pcL5KOALZdSWFmKl3qot2uRVLaxsCDSAtkP2qtcAKwGSkUfHLiCDOrzKSoGNgI1Mq
	dQPOQ4Xp1UIbh/EiUB9gea1bwmG+WJYTFtDjea51jr/J606L9dk3449F3jIPdya6lnihLULQD1v
	+ZGGssJCcobXEJiYwcZvFmb863zB9Y7a5X41yhyLE52kR7tnf/+5CCyDiXrMRL0Tv27XY0drZyn
	2TRWb+disPhwF8VBk5cp5UhBjAMQnxU5PtJ8g6Ri/KxeQPc3PGNWv6DaxZO4
X-Google-Smtp-Source: AGHT+IEE74znwzrU23upkQ4/ePMQAytZYVhI7FPwRKp2B8sJhtH4bPhdd2rWZ7n+/64RzM6hiN6kck6bhw/LF78L95o=
X-Received: by 2002:a05:6000:25c1:b0:42f:bbc6:edaf with SMTP id
 ffacd0b85a97d-4324e504044mr55256601f8f.37.1767391386713; Fri, 02 Jan 2026
 14:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6955cbd5.050a0220.a1b6.032d.GAE@google.com> <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
In-Reply-To: <e062f6a0a7583ca99ab0449481119634f8b02a3d.camel@sipsolutions.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 2 Jan 2026 23:02:54 +0100
X-Gm-Features: AQt7F2q__RxoOnbEfzcMF5_1pO_EX9DaBL5nMVvOzcruEcuzm3v9yvo_Zzy7HGc
Message-ID: <CANp29Y6NNtie6ZTsFbYUfhubEYW2A-K44B0-TZC=b3+OZcz-Rg@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] WARNING in rfkill_unregister
To: Johannes Berg <johannes@sipsolutions.net>
Cc: syzbot <syzbot+16210d09509730207241@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 1:08=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> Hi,
>
> > ------------[ cut here ]------------
> > rtmutex deadlock detected
> > WARNING: kernel/locking/rtmutex.c:1674 at rt_mutex_handle_deadlock+0x21=
/0xb0 kernel/locking/rtmutex.c:1674, CPU#0: syz.7.2908/15923
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 15923 Comm: syz.7.2908 Not tainted syzkaller #0 PREE=
MPT_{RT,(full)}
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/25/2025
> > RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1=
674
> > Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f=
 85 86 00 00 00 48 89 f7 e8 a6 39 01 00 48 8d 3d af 7c 0a 04 <67> 48 0f b9 =
3a 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 10 b3 91 4c
> > RSP: 0018:ffffc90004617710 EFLAGS: 00010286
> > RAX: 0000000080000000 RBX: ffffc900046177a0 RCX: 0000000000000000
> > RDX: 0000000000000006 RSI: ffffffff8ce0bbf9 RDI: ffffffff8ede5760
> > RBP: ffffc900046178c0 R08: ffffffff8edb3477 R09: 1ffffffff1db668e
> > R10: dffffc0000000000 R11: fffffbfff1db668f R12: 1ffff920008c2ef0
> > R13: ffffffff8ad3d599 R14: ffffffff8eb910e0 R15: dffffc0000000000
> > FS:  0000000000000000(0000) GS:ffff888126cef000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000056422df5abe0 CR3: 000000005929c000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
> >  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
> >  rt_mutex_slowlock+0x666/0x6b0 kernel/locking/rtmutex.c:1800
> >  __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
> >  __mutex_lock_common kernel/locking/rtmutex_api.c:534 [inline]
> >  mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:552
> >  rfkill_unregister+0xd1/0x230 net/rfkill/core.c:1145
> >  nfc_unregister_device+0x96/0x300 net/nfc/core.c:1167
> >  virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:172
>
> NFC has been issues with this for *years*. Technically, Krzysztof is
> listed as a maintainer but I suspect that's mostly dead.
>
> Is there a way you could route rfkill issues to NFC (and have them
> ignored there) if NFC is involved?

It depends on the particular case. It should be fairly easy to do for
warnings (where there's just one clear stack trace) and potentially
very tricky for task hungs (e.g.
https://syzkaller.appspot.com/bug?extid=3Def8f802abdb9a32343fc).

>
> Clearly they're not useful if nobody is interested in fixing NFC, so
> maybe we should just disable the virtual NFC driver completely and just
> not have syzbot run on anything there...
>
> If this email doesn't wake anyone up, I'll do that on the next syzbot
> rfkill vs. NFC report I get :)
>
> johannes
>

