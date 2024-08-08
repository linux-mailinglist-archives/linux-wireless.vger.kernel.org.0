Return-Path: <linux-wireless+bounces-11127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C582F94BC9A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 13:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B46C28470A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27F187854;
	Thu,  8 Aug 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmAKh2dT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7F4A33
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118111; cv=none; b=GKKFjEAXuWYlvX9ztJIYLnIutvJBWknevPKtTL2Qoqu22gQ+CH/qx5LD5mDiWt+O5qyZu3wCM8W50mWm7SAVxIU3BOWefNtXifI/4TBbYOTgmp+MJQBZqL9DqemxMh/mT6jo2NezgNCLF+4lMjGA6/if1GJdJ0rmvnTohhoDhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118111; c=relaxed/simple;
	bh=xSKSefyu2JIZwNPbODT8Q+4ar5m3IfPGumVk0YnRGZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDdmNBPdvHXulM5Qr3PKbzlLoqRn3Nez4lLaERTcv58ZI3cdU7N26pWY1uzPkE+baLCsa7H1ALext1Y8miZE5gaEkj6N7eVWNCexomwLrAIKD3ivLGSYM4xlY56g5U7Vuy5cRiM1YDcJtEwixBc23q1rxxyy6QW+8kRSyuXcU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmAKh2dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281F4C4AF09
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723118111;
	bh=xSKSefyu2JIZwNPbODT8Q+4ar5m3IfPGumVk0YnRGZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=cmAKh2dTDdHihsehI4oTOOYIrSj40HS+sTEad7o0zQfrdKWkjLfoXZuzeeVpgLVTK
	 P5h4lNAT7jgW9abIVinl+zOAlO+Lk3Lp5AZmZ5zvKohBCm3pW3hCYf61PGCrNdfecn
	 +rS5IwbYRGdS2GbY/hYwch7FibZzFskn7KBq0T+QKNGxtThmmOc/uBZdbkDgnH1qh5
	 QP2tS89xgQniIvLuLSIhIdJMk+0AdNqPYkvGC2E2PvwzPhSNtTHgueS93fJN7N7Zvk
	 xubhWX3dHgG5h/I9ys9QCwxMmmU+4mToGIuRgihcMXy5dE7tiH7BXIq0HpOLk2PzKw
	 ArhqwziaMu43g==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-691c85525ebso8055937b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2024 04:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6GFCI0ziK6zH06CrqVSE5JYKAM3uvm3RPsPTZ5XzbzL4C1cQih2YTo9XEzWMIHGSGjfApVJPzs88XKVLuxzO8oJUinzZlP0jCpNBzRpk=
X-Gm-Message-State: AOJu0YxeYSYC/k/dqcomtkUI8ZrHiabzv+4KFDBz57SDixKIeecV+X6Q
	3TPgvltaENdAb2RKHJ8joi8DiZv/9fxAYQ3YS//4fpdagFyDL3NZB3D/h3xPdp8u8T+h84yrQk/
	Fb1eC13nOEwvMkcg2uWxJZBQRPMM=
X-Google-Smtp-Source: AGHT+IFvxXJxn87rf5Vo+OU9A+/f4BWSdjFh+gxHFI/KzRbgzXNtsvQv36jYXRJuYC+NVChkzzHqmw0J0kVhm/kirwY=
X-Received: by 2002:a05:690c:e1f:b0:65f:e4f0:8347 with SMTP id
 00721157ae682-69bf7924043mr18248087b3.13.1723118110388; Thu, 08 Aug 2024
 04:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f6b548ef4c1a2404dc1f7a497c24a82c9247a3bd.camel@realtek.com>
In-Reply-To: <f6b548ef4c1a2404dc1f7a497c24a82c9247a3bd.camel@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 8 Aug 2024 07:54:59 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4OTOzD6fZdPdeTEzanSh2pFe7DgWb1M2hrqfA91-vfRw@mail.gmail.com>
Message-ID: <CA+5PVA4OTOzD6fZdPdeTEzanSh2pFe7DgWb1M2hrqfA91-vfRw@mail.gmail.com>
Subject: Re: pull request: rtw89: add firmware of 8852bt v0.29.91.0 and 8852c v0.27.97.0
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Timlee <timlee@realtek.com>, 
	Damon Chen <damon.chen@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:53=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Hi,
>
> Add RTL8852BT and RTL8852C-1 firmware of rtw89 driver.
>
> Thank you
> Ping-Ke
>
> ---
> The following changes since commit e131a437050360bf31b0ad7b69667432947acb=
ab:
>
>   Merge branch 'intel-20240805' into 'main' (2024-08-05 11:41:14 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-08-08

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/268


josh

>
> for you to fetch changes up to 1a0cbeb75372e047920bb17ba12a1d5f8ca59066:
>
>   rtw89: 8852c: add fw format-1 v0.27.97.0 (2024-08-08 09:40:40 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8852c: add fw format-1 v0.27.97.0
>
> Ping-Ke Shih (1):
>       rtw89: 8852bt: add firmware 0.29.91.0
>
>  WHENCE                  |   4 +++-
>  rtw89/rtw8852bt_fw.bin  | Bin 0 -> 897512 bytes
>  rtw89/rtw8852c_fw-1.bin | Bin 0 -> 2180616 bytes
>  3 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 rtw89/rtw8852bt_fw.bin
>  create mode 100644 rtw89/rtw8852c_fw-1.bin
>

