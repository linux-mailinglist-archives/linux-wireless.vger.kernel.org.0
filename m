Return-Path: <linux-wireless+bounces-26457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA81CB2C0CD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147521884758
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701032275C;
	Tue, 19 Aug 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzZI02B3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA431E100
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603800; cv=none; b=UU8VBXcGv98QTLbhS6i8yyfi1Jm3bZZ1XMeIrnBCataEIqswhrP+T8oEOSHPojpZ4jZkHUSuuUwcCPCqwOOTf6UmXx3UXiPXoQaZOe/vMs22fW4xrzU1A9y2iR8Y3hbrI8p40CrEsluPTS5QQezdfvNBDVzyCTbqP+KvdFzrTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603800; c=relaxed/simple;
	bh=BlOXYPYjLD3j4KMU3gsaZUwBw08LmwrHxCF7UXIztOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv1SnvrbnZRmdKJNL0R/sRR1p5dFh66E5HbR0ZFKeDMZyYqZtgbpbMQgiKToJBNkM8UTUmNUFfPnH/SG+pbFTl7gVcY5NgNc7P9dZnCgXnQ3qc1CltDni0xr+ScpM3pCw4BoCT3LCtn9eHmyFIZWpQuknjH420ai65FV4YSaFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzZI02B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC753C4CEF1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603799;
	bh=BlOXYPYjLD3j4KMU3gsaZUwBw08LmwrHxCF7UXIztOM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=NzZI02B3j1Uet+QWWSzyxnjUz6B3c2NIZdfSJOPlIMazvRtgCSTfJwGPgdam8Lt4m
	 LzsiHh3JsCiipj1WiEjEVLpWdqzfxfKpEyy+U6dlTUZJTSUG39eLHc879baX1lmDv8
	 h6RmAiMS1jXrK2yfd0um2DefyZf+oTMsTqXDQkJcrFs7Ew6A5XwANjzE2VEvS5Ff49
	 Y1Izpr0POqq/dYlqcqsAb5bEryehkOb+cXoa/W8KfE9/DhCziDGys2b+OgfKUpxkPE
	 18FeXjhIwrUpiAqvQJU3XzhIXCeld83RIaOcCIXjtGOwEGqvYPPhaPlR39C6RxzVR3
	 +tp+s0lSwGIgg==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e934c8f9751so2288637276.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 04:43:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqtTVRdQRxnUs4bnuf5SD5jzaDLNxh0C81K9vP7M4nOedCE9fKN1pBktP5xW8GaBkB5UlP30o0XAsbYg/KEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2KG6Chq/+AJh0ACH2s7oyguY67CxajycdapmPvSVe+St6Oqe
	i8pcIatGmf1eGA71daLBnSxlFXSvPjfKedsUO/RccWxcd2R4G/0FtK4rmaVCMUIGyl8RBmgSSq9
	lI0ab+OGiZwXvymlawPTXpQWaw35i3VU=
X-Google-Smtp-Source: AGHT+IHxvf2q9GY95Xcm4EFKN0PB79iVkmrO2tLPGLBBejNwDxNdwslQ2912KtHeehkUQhifHrrTQowoznIGDX62nZI=
X-Received: by 2002:a05:6902:728:b0:e93:3738:e0d4 with SMTP id
 3f1490d57ef6-e94e6152661mr2745832276.13.1755603799038; Tue, 19 Aug 2025
 04:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9761c994-0066-4de1-9b26-171a2baf3e0b@RTKEXHMBS06.realtek.com.tw>
In-Reply-To: <9761c994-0066-4de1-9b26-171a2baf3e0b@RTKEXHMBS06.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 19 Aug 2025 07:43:07 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7H922NYyNP_0RG6=1G-eRpdkJKwOaPRMX7U70brRdf+Q@mail.gmail.com>
X-Gm-Features: Ac12FXwS0wMFGYR06eNmNI7gVyF9YF6ca80KNqpRIgKu-f6SyYzVhzoCk0hTYKQ
Message-ID: <CA+5PVA7H922NYyNP_0RG6=1G-eRpdkJKwOaPRMX7U70brRdf+Q@mail.gmail.com>
Subject: Re: pull-request: update rtw firmware with tag rtw-fw-2025-08-15
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	damon.chen@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/648

josh

On Fri, Aug 15, 2025 at 4:36=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Update firmware of Realtwk WiFi driver rtw89. Main update is to correct
> WoWLAN feature.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit a312f85c8033086f0cdc96822453089da624c3=
28:
>
>   Merge branch 'rt1321' into 'main' (2025-08-14 16:48:34 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-08-15
>
> for you to fetch changes up to 61ae23e359c6dff2795701779cfb2b5994c47247:
>
>   rtw89: 8922a: update fw to v0.35.80.3 (2025-08-15 16:30:44 +0800)
>
> ----------------------------------------------------------------
> Kuan-Chung Chen (3):
>       rtw89: 8852c: update fw to v0.27.129.3
>       rtw89: 8852c: update fw to v0.27.129.4
>       rtw89: 8922a: update fw to v0.35.80.3
>
>  rtw89/rtw8852c_fw-2.bin | Bin 2463394 -> 2466994 bytes
>  rtw89/rtw8922a_fw-4.bin | Bin 1263938 -> 1263938 bytes
>  2 files changed, 0 insertions(+), 0 deletions(-)

