Return-Path: <linux-wireless+bounces-8887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2909056C2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 17:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C507DB234A2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E617DE31;
	Wed, 12 Jun 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZDMhmzy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39693D388
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205908; cv=none; b=lI3TvSReqrVvQ1lwIYFlMu7xFkSQogQe2OKvmI8NUDtmszM0bVA9zdZXV/NoEze2gB92cLzlDYzqR5DNwLWOhokoc4wdcULNa6VVlSyG1cpy2XpPEK3RhjKb7GnBV7bE2szFMNWpFXZyomSY3DpLPr2UxsV3gnQTLBd+L0hKeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205908; c=relaxed/simple;
	bh=eQg3uh14gj+WgWNbBQFUtu/HSgcB2Ull3FrgSDti1kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5eSHSMshSaXDouzNklQKKAvrqE2Wa/bSsfnQARXO6Fu8wazw/3xmLzDjNB02lST0LbhnfYOxgC+t+XC0X4TEyrdTflVUJXX04z69y/jwF2db3dINHz1/+mwuaRwaS/gYcrwzpYjBNvgCpHKQJ5QibCHFuD0rpUoHp03A10G/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZDMhmzy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2c6277ef3so4509216a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718205906; x=1718810706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuGePof1hiKRYnfrj+HeTyUT4EQtuf2InlvtjgDnHVU=;
        b=RZDMhmzyTa2YMxgXRaNqcs4v/fzpDhtBy309AlPuhgspy/cTWpFTQIvb9lT9eI1q02
         P7Yyw7KK+6DTbSvn2qHg95ZPRIVNiVB1aklQI6mojsgozUahNoq5/IdgN5gGTzVjaU8w
         ZmpKEkbeRWEpWYVWzDAlcDePykTcfvywJI9fySOoPG6oMXNTxsrMLagNrNs+iB28dOEh
         05YQHQhh3IVmjIkhbFMEerL72zZ9qQBmaXhu7xzUWmz3p2jiuOH90s5IrtQtNwUdy658
         xq/FO9qpbGUfOx3JWmLPNnUmkJNFpHeb3D3C4l9JDEXp+GV1v6Mk+rhkWx2xuwRWnh5f
         1dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205906; x=1718810706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuGePof1hiKRYnfrj+HeTyUT4EQtuf2InlvtjgDnHVU=;
        b=f/Ul0bYPlsY/kD26cezjwHOINF1CLGclGku8foTf6GXA/Cf8sv6Ga6VLZnrOaq3qkN
         JfMCFN/AOyjQ9znAeJ8H+DWd3SjGSuqJ+l9HGr5oHAGpiP7R92N9iYTmhHjvl/7WYQWz
         Tv60dgIDJgrrS+QzHpgdmnW9bFKcwJ+Sk7lN0+ylRjPriPFEgf1YWiNfX+V4UXCyzzc9
         yb2svgttMhw9VM00ybiRcYmrO3kyBNbjKi4MGaWKQ/bsuIX29e7vQPWMaNLF65Mktajs
         hI6h7DOnVMVACeCTnF9U6kbvla0KX9xzd7NizT8xAdEJ/psgchuhQ262iXUaOv9/OhyV
         oEEQ==
X-Gm-Message-State: AOJu0YyC1VYKqSsdSH1UAqznU99HSqYJmbtZWS+qsnkN145MId9ejWjw
	UAa09FFyWyMTb0a0tHj7PFP1MgEVpxbnWoJB8FUXnpE3u34zvPeb+aTglTQm3TWX0cm3dotdR/D
	L4HsmFNDJpXJiXYPJqkJy5AxuVxk=
X-Google-Smtp-Source: AGHT+IHBJjNQOhMcmkUQxSS5tk5QHoAUKHTssG7MbK687qUID3WZ3vHHaY+S44q7wh33D5rLzfXhQDxqYe58+0WarT0=
X-Received: by 2002:a17:90a:b785:b0:2c4:aafe:75e9 with SMTP id
 98e67ed59e1d1-2c4aafe773amr2087633a91.0.1718205905894; Wed, 12 Jun 2024
 08:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
 <868343c920c24204972ddaa108e5d00e@realtek.com> <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
 <c5b42d8b818b4bd5ac8a6921a29f9f18@realtek.com> <CA+GA0_vHeYLNw88KCnD9NACofA5rPJppj0nWZi+v5FqZLmpomA@mail.gmail.com>
 <9bec9d852273467fbf66af68e3c4d325@realtek.com> <CA+GA0_v0ee_VCRzwd-bA+XqMFZcMWs0oG0s_jFk6CjC0vV82ww@mail.gmail.com>
In-Reply-To: <CA+GA0_v0ee_VCRzwd-bA+XqMFZcMWs0oG0s_jFk6CjC0vV82ww@mail.gmail.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Wed, 12 Jun 2024 17:24:54 +0200
Message-ID: <CA+GA0_vcUneM4Uo8fg0=4sCK049uhjv+NskotRbNg9Em0cnyUQ@mail.gmail.com>
Subject: Re: rtw88 multicast failure in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	=?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 12 cze 2024 o 08:59 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com=
> napisa=C5=82(a):
>
> =C5=9Br., 12 cze 2024 o 08:08 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=
=82(a):
> >
> > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > =C5=9Br., 12 cze 2024 o 03:30 Ping-Ke Shih <pkshih@realtek.com> napis=
a=C5=82(a):
> > > >
> > > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > > wt., 11 cze 2024 o 04:32 Ping-Ke Shih <pkshih@realtek.com> napisa=
=C5=82(a):
> > > > > >
> > > > > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > > > > Let's assume we have 3 systems: A and B use 8821CU chip, and =
C uses
> > > > > > > another chip from a different vendor.
> > > > > > >
> > > > > > > If A is in AP mode and A and B use the rtw88 driver, pinging =
A from B
> > > > > > > and C by local name doesn't work because name resolution fail=
s: avahi
> > > > > > > on B and C sends a multicast request to resolve A.local, A se=
es it and
> > > > > > > responds, but neither B nor C sees the response.
> > > > > > >
> > > > > > > In the same situation, but with A and B using the rtl8821cu d=
river
> > > > > > > (from https://github.com/morrownr/8821cu-20210916.git), every=
thing
> > > > > > > works - B and C see A's response and can resolve A.local.
> > > > > > >
> > > > > > > If C is in AP mode, resolving C from A and B also works.
> > > > > > >
> > > > > > > This leads me to believe there's something wrong with rtw88 w=
hen
> > > > > > > sending multicast packets in AP mode.
> > > > > >
> > > > > > Have you captured air packets sent by C (AP mode)? (To check if=
 TX properly.)
> > > > >
> > > > > Yes, I see packets in both directions on both C and A if C is in =
AP mode.
> > > > >
> > > > > > Have you tried non-secure connection? (To check if encryption p=
roperly.)
> > > > >
> > > > > Nothing changes - rtw88 in AP mode sends multicast packets, but o=
ther
> > > > > devices don't see them.
> > > >
> > > > How can you assert other devices don't see them? Receivers don't AC=
K
> > > > multicast/broadcast packets, so have you added debug log in A or B?
> > >
> > > Because I don't see them in tcpdump output.
> >
> > Multicast packets from A (in AP mode) didn't present in tcpdump output =
of B, but
> > multicast packets from C (in AP mode) did present in tcpdump output of =
B?
>
> Yes
>
> > > > Compare air packets in non-secure connection between what A and C p=
lays AP mode.
> > >
> > > I'm not sure what "air packets" mean. I don't have a radio sniffing
> > > tool to see what's
> > > going on,
> >
> > rtw88 can be a sniffer.
> >
> >   sudo iw dev wlan0 interface add mon0 type monitor
> >   sudo ifconfig mon0 up
> >   sudo wireshark  // select mon0, and switch channel by GUI toolbar
> >
> >
> > > and by the time packets are available in the driver, they were alread=
y
> > > processed and filtered by hardware, so they can't be considered "air"=
.
> > > If you have a specific place in the driver where you want me to put
> > > debugs, let me know.
> >
> > I didn't have a specific place. Just want to know how you confirmed
> > "AP sent packets" and "STA received packets". It seems like you didn't
> > capture packets in the air. So please setup rtw88 to do that. By the wa=
y,
> > monitor mode of rtw88 has broken [1] somehow. Please use older kernel t=
o
> > capture packets.
> >
> > [1] https://lore.kernel.org/linux-wireless/5318640d6eb74301b1fbf6d9385b=
a69e@realtek.com/T/#m6984dfc4a85b389511c253c2b97547a4148e83d9
>
> Ok, I'll try that.

I don't see any useful difference with that - for mon0, there's a lot
of spamming from other networks, but MDNS communication looks exactly
the same as with tcpdump on wlan0, both in the configurations where
communication works and where it doesn't.

One interesting observation - even ARP requests seem to be affected by
this bug - pinging A from C by IP doesn't work until A starts pinging
C (which advertises its IP address).

