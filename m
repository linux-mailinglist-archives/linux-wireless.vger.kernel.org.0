Return-Path: <linux-wireless+bounces-13384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41298C5AC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 20:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32109B22EF4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677E1CCB2C;
	Tue,  1 Oct 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwJmc9AC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726E1B86E6;
	Tue,  1 Oct 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808605; cv=none; b=F+LxX36+APL0zrHxPkI5/Xpx5P1/jM1rH8kLMvEniQhbGkIc82puNLTlQM1NnubNS4KoMoNd5binvilIlceBGWi38qldXnOL8rfuhSWhkitwgScQxxjVIp97Gd53wVvmBtDJA8PaszldhTRF7PoPN3fGZl0BAlr0UI8fyF0bfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808605; c=relaxed/simple;
	bh=tOitTbixOjaFk42YiQ07Kf5fzqQM0BjRKFquB/zGesw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP0onexO8V0R5F96TBixHJ/ph1MkjMXkE75WbmbJ7e/j6j7p6nqBdr3PTI63VqiGrPcWqWTgrp52DIrxtpOu74zxoYLQKgal4e1ify9Bw7tHcpYTLGJfVmrlcCsDh1TxpPNfMNYfc5aw9noPTC+A6iklJyyQ9CfAmQJ1dWxdZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwJmc9AC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2824ddc2so46232516d6.1;
        Tue, 01 Oct 2024 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808602; x=1728413402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOitTbixOjaFk42YiQ07Kf5fzqQM0BjRKFquB/zGesw=;
        b=SwJmc9ACTnIy4qM9Wn3byZaMk02bqY8cSiw/OSH8apyVaS/Ef+Dz13qVQ91Rm1ne24
         aGLaONsfz2Ha4NU8NMTYRqp0DpSRdHWEGqExL3j1ctDD2SCVr7GX5R/TBwOVKk/uR0oB
         /lEdDkeGOaemUEiw0/A65ysBGAB4QOu/dz7m+/dKesDiHh+coYc7DEaHP1dXDJiKk+a7
         IIpMBl6MX7HCJC5D5qGTMdC826fHslUAbRqcclTWLUR+mIWMH2lUC2EgyEag5O56fbCA
         rM0Qt2DLChsHwBD5ri5SmISUPV1qp32qOECvGiwz9em2FHWV2yEaCgPia3u4RJr+pG+y
         65iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808602; x=1728413402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOitTbixOjaFk42YiQ07Kf5fzqQM0BjRKFquB/zGesw=;
        b=wzIp/tsdSOrVD51BuJfRzJDnZSikP1zRjYKqoJ2FsLP/K27YPzhT04SEMEvlKDO/34
         eVvRX9mBNJmMbecPYw3l+lYenON3hZi3yMVlxrF/w5jYENcmd19e5aEsLqZAb//hIiVu
         iflzz29Sy4U72w03z7YN6hYRsqIxjjUf0oNIUEUTaUYOXr2BgaDoXFQNvgRLocxBrr5M
         0CMzJERM2uvR0m1KnNE9wWeIRZ9aYg3Xhs70PixxS/4rcAiwX30SkFzwEL4SJYzZuamK
         +t1r0vjWXjF7Yo/hIqnVBD3wSOhFr8auEQ07UnkCM9I2mMq27yyUqEoWjg6n3rkWuP1l
         mYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvKEwv7Y04ujDmvUjk6Gkhx2Z9PPvAPLUgLtL9qSIu3CHwFCCTL0gMfl5rwuZi2MN6EE2pNKw8sHjt/H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43Cf2xcnbwXJU7xxqOd9LaNb1p7LudUfOpydTEBD8LRrcr+e2
	+2zZHMKKtWD2cWLEOTG5etAC9EXFkd2dKDjMUWNVpSWsiqx/tp9XDveOSYcbmHCZljKrTAXsvvm
	aCdmv+K35SkF1g3XEAXxmT6TSYQ8=
X-Google-Smtp-Source: AGHT+IH2Wewvi7c/eZLHdmFI8+G/j86M17m1h35Fp4ydLZ+usZzR+X0pEBWx1CfoqGHWM9tHcQOUD3ixSB5wSiBwUZ0=
X-Received: by 2002:a05:6214:468e:b0:6c9:f733:4500 with SMTP id
 6a1803df08f44-6cb81a0edd0mr6511266d6.19.1727808602615; Tue, 01 Oct 2024
 11:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930230425.369534-1-rosenp@gmail.com> <87ttdwqlci.fsf@toke.dk>
In-Reply-To: <87ttdwqlci.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 1 Oct 2024 11:49:51 -0700
Message-ID: <CAKxU2N9XFJZaVJgQDVNWmsUoJ_WTHdv7ViTs9xFpFWKeY5Woaw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath9k: return by of_get_mac_address
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, nbd@nbd.name, 
	yangshiji66@outlook.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:27=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > It can return -EPROBE_DEFER when using NVMEM. return it so that it gets
> > forwarded to _init.
>
> What bug, if any, does this fix?
None that I've seen. But the goal is: if ath9k probes before NVMEM,
defer so that it can get an NVMEM mac address properly.

I think in OpenWrt there are hacks that force ath9k to probe later, I
think because of the GPIO driver situation there.
>
> -Toke

