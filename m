Return-Path: <linux-wireless+bounces-8270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38E8D3B78
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601A11C22BEE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAA181315;
	Wed, 29 May 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aInQg98I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2F21A19
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998032; cv=none; b=kLhtqS48JZ5yCPUWgJ0dxIs5ZhG/QU5JJc73KkoN1foKce/3owKZozFVWmV5LAZTHbLvlnbZDt4n8AKVpjhqHLJhdbd1IyjmExOlCiePy6d8pzlAw+rh9qpL+k/3FNmoaxhElO7lv2il45i6Zja8lDeKu4Ydr/c682Hyz1Ad6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998032; c=relaxed/simple;
	bh=SB0Uv3+j62mYmXxN38x+vhYcxsFH1OBzbAoRl4YOltA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNluO5tk5rrjbgAJDYwUJmCStviVs+8TboNbm7sIgxhZCsBsOSygL11PXrnKDZmnXFTnYao5aMsACJpK7hEgDHiva1iMNdh6ZeSDFTe8oEWlDC1mn/bs3OqCr2Pa0GwJ9ZQ/H/y03l4rK6oi/eyHpzRhsDpSpmvEamabGp0/iVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aInQg98I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681a4427816so1720029a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716998031; x=1717602831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB0Uv3+j62mYmXxN38x+vhYcxsFH1OBzbAoRl4YOltA=;
        b=aInQg98IpsbBdpouPmuh6FyGW79fiZpxv8XdgNuVafJ+wkyRI+nIQFJcTN+aP+EGm+
         Bbl8VaKiXsBvLfoNsmNAAdyl6MVYo2TRifHRbYVzKdj6IQaQL0LklLCo7f0LM+ChfJtk
         nml3k9Lph3dvZFKj0LVaXPsMEofhaDrgcninvosoOE46/iOdsq7NZmh7u4yPb5mGg/tx
         3TM9OIAVlik+GDD6FB98vWFpu0901hZZARWOiEM0cSyE8rYzN8uZFy6g6BWQ55l2K8wo
         5Q2Veo8E3nH3XhUSgh/iLhetbIpe5bVBCEZa8aivCkcfhO6GcD08u2zanV0URDR2bIOP
         r6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998031; x=1717602831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB0Uv3+j62mYmXxN38x+vhYcxsFH1OBzbAoRl4YOltA=;
        b=ctCW7WSjoY3d9i3wpUBsyFFuJLXubOYultPdko9R4KKfLth6GVNPKv+IQb0Oem1C9+
         68RnREyWQzcUNHyr/6BTzy2bmitj6elf9JXXOQHFmxa759eILSMm+AGOu5lM9M7qnOkh
         HKHFIJSITYDb/GtYMFDgqtG/K3aQaoHAg7VK7S5MbvX4VqPmcuW9tEJIj0keQnA6+YVY
         Cfh9zQzmhbVl+O4rsjEevik3dAbV4REx5Uq4cxgt9NJ0rc07iwIABE4ZIOEjzY1DkEtq
         zsPQ88JbCmVnRQo57BV1VnYecg4Q4Tu0pPYUp6Tj7j6C2s1gGkMdwfBbMm/A3pJLhzTs
         Gamg==
X-Gm-Message-State: AOJu0YwWQv2ItB3x+cFoyPfW/tIAMU7NwrwvQxJa8lg9BZyZTpECnhZO
	xjaJhL/yQ2QWoQodtMiwPMe9sG28p40LPy5tVQDbod2RqybyYNNe3A+piAvYatE3jowBqnTpTHD
	tclu2Cd7C1i2OJO5Vk/BPESewhyyhVQ==
X-Google-Smtp-Source: AGHT+IFpBcAGwOjbjyvgMveWbKVd2b969ovwLQeQcQPMxtfei95C3cDpD1sL8O6Lmt8xSVg7NofrG8IqdF4qWRRqByY=
X-Received: by 2002:a17:90b:3e8b:b0:2bf:c0b7:45b1 with SMTP id
 98e67ed59e1d1-2bfc0b746e6mr8800962a91.15.1716998030670; Wed, 29 May 2024
 08:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com> <CA+GA0_sQ_Bnp8CUq1Pmxf7zut1Kocaxbw4iXT4hYC5_ceXb7WQ@mail.gmail.com>
 <3cc9cc75468d487c988dbacd8dfc5f57@realtek.com>
In-Reply-To: <3cc9cc75468d487c988dbacd8dfc5f57@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Wed, 29 May 2024 17:53:39 +0200
Message-ID: <CA+GA0_tUy0EuXm0CGYa8SsS78oRNHUanBNwRf_BLXERa1=MYdg@mail.gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 29 maj 2024 o 03:52 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=
=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > wt., 28 maj 2024 o 05:52 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82=
(a):
> > >
> > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > >
> > > > I found out that the reason for those hangs is a power-off+on seque=
nce that's
> > > > triggered by the above steps.
> > >
> > > To avoid power-off/on sequence once device becomes idle, I would like=
 to add
> > > a ips_disabled helper. Please revert your changes and apply my attach=
ed patch.
> >
> > My first attempt was very similar, and it fixed some cases but not all =
of them.
> >
> > This is due to the existence of a second source of power-offs - rtw_ops=
_stop,
> > which is called, e.g., on downing the interface (ifconfig wlan0 down).
>
> Please try attached v2 patch. I would like to have an explicit helper
> (i.e. always_power_on in v2) to have this fix, so days later people can b=
e easy
> to understand how it works. Not prefer adjusting existing flags to implic=
itly
> have behavior you want.

So, do you think this is a chip issue, not just some driver misconfiguratio=
n?

I'm asking because if we are going in this direction, there's something
more to fix... With your v2, very frequently, I hit WARN_ON(!local->started=
) in
ieee80211_rx_napi (in wireless-next, the code was moved to ieee80211_rx_lis=
t).

With my patch, I checked and hit that WARN_ON, too, but very occasionally.

I think the difference is in what happens in rtw_ips_enter - I disabled onl=
y
the power_off, but you also disabled everything else, including the cancela=
tion
of work_structs.

The warning itself sounds harmless, but I think users should never see such
warnings, so this needs to be fixed somehow. Probably some additional
work_struct(s) need to be canceled?

Marcin

