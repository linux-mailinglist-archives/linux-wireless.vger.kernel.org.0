Return-Path: <linux-wireless+bounces-26159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D8B1AEFF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 08:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5294E3A651B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 06:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85A224256;
	Tue,  5 Aug 2025 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRkIuO9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA021D3F1;
	Tue,  5 Aug 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377162; cv=none; b=f0tUXAApwXFzAkTBfKqVSVfL/C3/lRZJXtYxM1XAEdkz8622w1HTioRY9OAW9DOn/awBxbQ1e1RrTT9QVGxcysJS/eNoNwN4pjjcOlKS2ge/PG3WRb1sYIqsTPq0CJYryIZSTlugkFjOwOeCuzygqFZ83JW6iLSuyVFM0ATW0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377162; c=relaxed/simple;
	bh=PafDn0MY0id5KpSg3gQFMOi87guULm93+RWqibEPLc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/hOsBMDLhyL7qz6XNXut7bdzmR0VaFZZUkFlOcklNYHKXNA4DQfzvsIs4t0iwQwVJnWdfy97ZyGstfYwJcM5ZRSXKrx7OJLSFmX4C/ihYwkHYDuykdvKZMJPhNyS2yvXNb03NsgxGn98+W41wF18kOk0IgALZwAyATCRorqOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRkIuO9a; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32106b0930eso3976336a91.0;
        Mon, 04 Aug 2025 23:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754377156; x=1754981956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3z1vhFDjj89Av+ZDj+UBNRBdv57g+A31uU/e5tr7Iis=;
        b=GRkIuO9aw2QF0Cff/kF3j+dBXiPlyl2yBhgaiH+U1VWUYUH5hFsLD23VPFaWBRNNop
         3TNI+2PJFkXj39rtudBMyal3LGehQAv8qe3jqOpACH/hwMu2kOIRxuKkN5DzzQsQnAn7
         ZYFgtUsn9YftXb5EQ1VlTB7cgSAeRF6spkKUzNrThvpgfIrxGV36ZLn8tcDGbm6rq5iX
         4crQCusMPUj404fgn/+5ByykRa38dGjnneJTO6dwouiTfaxBvbmm5ljIbMFhERAtuoog
         XYPMUOuM8tdAZOgB1l0Dc803KqLtOELqLTxIYsOLbqAX+wKYY8wLAi4WZUHMjBh9kxkQ
         Uy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754377156; x=1754981956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z1vhFDjj89Av+ZDj+UBNRBdv57g+A31uU/e5tr7Iis=;
        b=hNFP3VX22+hi/5/et3zsEpR7mqfLxyUeAxhTt/t/yweaHQ29roTNJ1JSVLAcV0aPqL
         l2V8HedHWSsg5gmQbwkd5VPUAM0RkDTQuGGA17cQomK2Q0ekcoQavzvu+1cKi9LmC8Bv
         lJB+m5OI5rQPvKYnAdX9Z1uuGlPed7XN+rQ6aIyzNbK3d3HpMpSi0trg7Vh9IqHLB9M3
         H8sE73E4Xg8Kob4TS7ZBCQfqjFKi/tHOvmGAC+6JYbgv4YuV60My4LhC4KgGGtEunA82
         DQX0w63MgsrRpSPZGxK3OWMEaJMB0rgVKaqIB6/XIwc+c27Zfs8yxxUBRz2DqoHtS7H8
         rPEw==
X-Forwarded-Encrypted: i=1; AJvYcCXBhFIqtOLB70CFR19+ZnRBqD91Gw+RyS2/LKVRSRpDnyvEd85DQPP20kmJDyc0/InESkOhOLHP3OG7SRw=@vger.kernel.org, AJvYcCXgRvfsNge+72OsRboZlctq1rNtg1YuLw/Dk4FoIOsVgbpZtrS2qqc9fL7krfwLmZRal8AKgEee3m4R2dNiliI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXE+BQZk0iFeLh8xw+BFlQRmP1ig2FjgHJcgYAIZwLbSrhaJG
	gqIbttul5Cy7kwAc5HCMKabOqRmPq2KWixjx1xVj8LtZahZHZdK2lfNk+PaNlO1ybmfhtND2SDj
	Anv7MDMr8Vl+CaxXBYSqZa0B18k1JVeY=
X-Gm-Gg: ASbGncuKJhAZClRUAdLEva8Phw1iXsCmHmFI0rUKkIY3D7brkw43/rfEli1omvL0bgw
	3oHULqB/iiQbhh5KZAHavFII8WGYdSUFz+qbYIAtLyFwrymi2Dw/TjquCT/7BPq9pOK+OWdMKX2
	4mXrKryQMWXAHa7LaDPUtB+UZ3hG0CS4N6hkgF/FIOnrTWloidroZ2x+an2BjmqeW/cmrVQ/753
	1qaSg==
X-Google-Smtp-Source: AGHT+IF5xZ1m9L9pT/4m0FTSUTfP6TxNIOYI2sJJWzFE3IWCpfZYRPvlNOPGa1ryGDdTgXYuynbYUxsgWoQg+jeaeZ0=
X-Received: by 2002:a17:90b:3b92:b0:321:1a89:f692 with SMTP id
 98e67ed59e1d1-3211a89f6b2mr16547837a91.8.1754377156290; Mon, 04 Aug 2025
 23:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731075837.1969136-1-arnd@kernel.org>
In-Reply-To: <20250731075837.1969136-1-arnd@kernel.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 5 Aug 2025 08:59:05 +0200
X-Gm-Features: Ac12FXxUnbIHuYT86jzBVAeypGTXYEYh_3Euem7R2U5AZ5dt_NrMrOu3CkO1q-4
Message-ID: <CAMhs-H8zVcDtbeXQ32aw2gO2D8tkykwTOfoqxxK7PVwM_QPLiA@mail.gmail.com>
Subject: Re: [PATCH] net: wireless: rt2x00: fix CRC_CCITT dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Rosen Penev <rosenp@gmail.com>, 
	Johannes Berg <johannes.berg@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 9:58=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Compile-testing this driver on Arm platforms shows a link failure
> when the CRC functions are not part of the kernel:
>
> x86_64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in funct=
ion `rt2800_check_firmware':
> rt2800lib.c:(.text+0x20e5): undefined reference to `crc_ccitt'
>
> Move the select statement to the correct Kconfig symbol to match
> the call site.
>
> Fixes: 311b05e235cf ("wifi: rt2x00: add COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

