Return-Path: <linux-wireless+bounces-21789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6BA95063
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95CD1723C7
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5E1CAA62;
	Mon, 21 Apr 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk2nwUwR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1444C85
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236018; cv=none; b=dlYEbfMRBIfNILpi51UqWW1gxpeLItRM+3au6SI6BaaENeWmX4FvG8/qvQCpkxSNa0RIY4A6ZVcdPGFIc8/VkvG1KEX1ATg874ZDvNV76TIj2L1rjRLiXVGNqik7L8eYT3guo/ZU3upQLdFtE2urM2yxmdL3rBdG9jeulHhyDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236018; c=relaxed/simple;
	bh=kHDX0SfQfcnyppgaRjiTcmByKppkjWc1sKLsaBfPsxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXEoY4Pac/aTBIGwGKIMuxOQcNQFWvfeFT10yrtpHlXWblNk6yHQE2XpEEI2J6nv3Q2axvcpbo2u3lnGt/oSSGuAHDcqRumvJrbm9S3TIzlPeP7o20Kz/u210PFinkhxVest1TITIbrv1hFAFML/iwho7zDEs+MESeKZsjjYNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk2nwUwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FC1C4CEE4
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745236017;
	bh=kHDX0SfQfcnyppgaRjiTcmByKppkjWc1sKLsaBfPsxU=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=Jk2nwUwR5MGohupxhcKGMAFmOLE/uwRD1I17dZMNjdcnDJUHvOCsU0Ei9accq1YfT
	 yXDVO0MQPv9VctTKN7I2pEjAgRZvNaSBR1sFiNMinEZwCCeqlG3F9W8HwkedQX8Alg
	 daKAO9Zv30DhQnC+kfqYzRJqsgcV2fvxmQqdTlSmRJ4NdCwd/MDW4ssq/12akVjl/s
	 IClurqT7mHL6PyFfxSKcccU04FsKrIn0Eb6y5IQNjKZKSrkJfypZ1mZVyHu13RkX29
	 zMe7NFWfc+e3ijnkUlbeamMn7sWuUmemnoBRIujmZfcHvJhL22UiZxwQPU1Jvu/tqO
	 mmFz8yR9t0eew==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6df4507690so2957557276.0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 04:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4bKkRnGYd1o37gCggmSHwxpmDijiT5uHPkvb5jPtuAbU9ZlKv7LPE7gcSCzZo76sVsskpJg1C/gpP5raKnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+mXlcsoADS4hhUSRe0DEC1zPLdY2dA3VMf8pS04ue4Y9quKY
	+HLjWQtd0+KIW/27Rn88rImGuP4A2QWVr6qw6RM3JQFt0tl/xs5lhITsIV48l5hrWTlRTOFkR4h
	pZ5r38KpC4dck6wYp90uh7sMuYyQ=
X-Google-Smtp-Source: AGHT+IHGpCA2AadYSBmDOZcidoUNPXqcO48kTu98RodWual2KFAdSpX7qYjBCasXpzd7qjn87s/Zc7+hMyV00/y6xxc=
X-Received: by 2002:a05:6902:906:b0:e63:41cf:b600 with SMTP id
 3f1490d57ef6-e7294bcd0b3mr17375786276.24.1745236016714; Mon, 21 Apr 2025
 04:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27ec817e-4b99-445e-8bd5-f61a38b4746c@RTEXMBS04.realtek.com.tw>
In-Reply-To: <27ec817e-4b99-445e-8bd5-f61a38b4746c@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 21 Apr 2025 07:46:45 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6hR=B=tAgXWHZGmx8g_a=-mEB=cFuVWvp5uWM6MUpBfA@mail.gmail.com>
X-Gm-Features: ATxdqUEUIWBO7bRwVkGC2zoyTWieatPZEkOzsg3hX7csQUAweb8CPY9GfY0PR20
Message-ID: <CA+5PVA6hR=B=tAgXWHZGmx8g_a=-mEB=cFuVWvp5uWM6MUpBfA@mail.gmail.com>
Subject: Re: pull-request: update rtw89 firmware with rtw-fw-2025-04-16
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	kevin_yang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:27=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Hi,
>
> Because firmware v0.27.125.0 for RTL8852C changes the format, old driver
> can't recognize the new changes, causing failed to probe. To fix this,
> move the version from rtw89/rtw8852c_fw-1.bin to rtw89/rtw8852c_fw-2.bin.
>
> Others are to update elements related to TX power.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit 6a006cef10cebfaa282100a81cb45ad3a92127=
21:
>
>   Merge branch 'intel/guc_70441' into 'main' (2025-04-10 20:59:06 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-04-16

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/518

josh

>
> for you to fetch changes up to 4eeab443621fc045fa094b2f69de1cb8025aa414:
>
>   rtw89: 8922a: update element RF TXPWR to R40 (2025-04-16 09:41:56 +0800=
)
>
> ----------------------------------------------------------------
> Ping-Ke Shih (2):
>       Revert "rtw89: 8852c: update fw to v0.27.125.0"
>       rtw89: 8852c: add fw v0.27.125.0 with format version 2
>
> Zong-Zhe Yang (2):
>       rtw89: 8852c: update element RF TXPWR to R78
>       rtw89: 8922a: update element RF TXPWR to R40
>
>  WHENCE                  |   1 +
>  rtw89/rtw8852c_fw-1.bin | Bin 2399272 -> 2375560 bytes
>  rtw89/rtw8852c_fw-2.bin | Bin 0 -> 2411688 bytes
>  rtw89/rtw8922a_fw-3.bin | Bin 1188926 -> 1224798 bytes
>  4 files changed, 1 insertion(+)
>  create mode 100644 rtw89/rtw8852c_fw-2.bin

