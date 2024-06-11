Return-Path: <linux-wireless+bounces-8787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFE9039B7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761C91F26A32
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF920179951;
	Tue, 11 Jun 2024 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg3fYT7s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564B179957
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104239; cv=none; b=sEYwHV41PwWR6zbwD5MzdzZvsRVGsYU9azwa9Nh76BzpF/5cs9ITHbFUYeJzN8EEFJCJOikAGIkl995VBQyMHqf918EjasK69apJZ2GqMg7ILdT+rJuSB8G1YIlf9mWbT4kW6unBFGxnvKhizh0TX2HkXzqy8xdcsY+Wis1YlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104239; c=relaxed/simple;
	bh=X3pEPRDiKtKLYAsvWh/YawOU+IrtWfgRWDDXhLpydwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH4oV4CuoXA3VP9hQASoxw6/Mw5+kOygSZa+IQFNBoE3xZeIcRj3YNfrOmxHlIrIh6tbC2ZxSF+EqvsFqmjHB8syX26BqnsgijiEanerPvuW/i2pIl7R/K6CpMogqG8MJYIadfdqlDbIlrJW3LtY+SweZD2bMDhZQsSmEBZ15GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg3fYT7s; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c315b569c8so861453a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718104238; x=1718709038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3pEPRDiKtKLYAsvWh/YawOU+IrtWfgRWDDXhLpydwg=;
        b=Dg3fYT7semvHeJ6/W3YspZmmErPcC+WXEnRHQGiRYGps9wWhJ5eIFDg7WqV0TAu9Mz
         w7Pl3X1kqKSyKhbOoaRmmxUSbKRPEqIrRzUxDoxJSNLvy5EMmbWQ1EAgiphh1JV4Ks1e
         Vcclf+Be3RhgCUAR/vHKcllBqn1DaqnkwJ/IHJ/K3nVAfRf3iOXjdbVgO0A3v9vPqWDE
         WP0RNjeh4Gp4U6g1KnEL9/sEnTEYT3766X7gI38Fku37kFSq696tBP/HPTid+fEDI08e
         77cI9kvgCRHD7PTJ4S7gHo3RFwvMWDxYTFT6C8nTym4sO7btpqlyaEyAfGjLtpmrHmf9
         6Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718104238; x=1718709038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3pEPRDiKtKLYAsvWh/YawOU+IrtWfgRWDDXhLpydwg=;
        b=Y9pGQY4zpvLJD1UNzYE9O1P1ezQvnfONeQC1gG+0U6VH8F/VygSGNYFjiubw8ilXwN
         X0koLTBhMHax0xnMVJuNzcWTxyXUpBJ2u3adYMmStcd5hS51BnDZujGyafzLKi+wmbf+
         RHTgb2gklSV+ma5oWAp2KSCHUXI5MXfFXICDBW0iGsCdyMOFeITtLHmD6vW69FpYbQlc
         biQpPL5eZ0o1QE373OFlcjBQXF/xfZLykUpxMx9I/wXv+de3WkzkiNSmSd0cQw21+Nzo
         g7SuXj5BTWv6VOlPAzJwXWbwD1unrlnRs3DvxL7KxjpLNBSs8L1tzFJA0gmSPPvos5J5
         mrDA==
X-Gm-Message-State: AOJu0Ywt1PMMwLQgY3JKOHuaaZ1EI9rGu7X2Gm+gkJBYXDqIhRZYQoKL
	Z61XO1Ds8ltVnJlPg0197kInc9AU/owyAiR3COpIPc32djR5a1VONlRDbps8PmrQnOGyk3Xe41m
	pL5pplwgwRNTpYJwBR4JMiBQPfqypDw==
X-Google-Smtp-Source: AGHT+IHeM2bQyviQKPCRL9px6Dfso+fgSjsl3gMfx2pGCQEjLAlWnMp5/OLQBqRV9ByykiIMpEbzpwO0TAfZw1fdDUo=
X-Received: by 2002:a17:90b:1bc9:b0:2c3:16f8:b57b with SMTP id
 98e67ed59e1d1-2c316f8b5b1mr3486359a91.25.1718104237654; Tue, 11 Jun 2024
 04:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
 <868343c920c24204972ddaa108e5d00e@realtek.com>
In-Reply-To: <868343c920c24204972ddaa108e5d00e@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Tue, 11 Jun 2024 13:10:26 +0200
Message-ID: <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
Subject: Re: rtw88 multicast failure in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	=?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 11 cze 2024 o 04:32 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > Let's assume we have 3 systems: A and B use 8821CU chip, and C uses
> > another chip from a different vendor.
> >
> > If A is in AP mode and A and B use the rtw88 driver, pinging A from B
> > and C by local name doesn't work because name resolution fails: avahi
> > on B and C sends a multicast request to resolve A.local, A sees it and
> > responds, but neither B nor C sees the response.
> >
> > In the same situation, but with A and B using the rtl8821cu driver
> > (from https://github.com/morrownr/8821cu-20210916.git), everything
> > works - B and C see A's response and can resolve A.local.
> >
> > If C is in AP mode, resolving C from A and B also works.
> >
> > This leads me to believe there's something wrong with rtw88 when
> > sending multicast packets in AP mode.
>
> Have you captured air packets sent by C (AP mode)? (To check if TX proper=
ly.)

Yes, I see packets in both directions on both C and A if C is in AP mode.

> Have you tried non-secure connection? (To check if encryption properly.)

Nothing changes - rtw88 in AP mode sends multicast packets, but other
devices don't see them.

