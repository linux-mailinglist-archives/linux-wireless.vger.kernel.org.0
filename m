Return-Path: <linux-wireless+bounces-11485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07282953196
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FCF1F21D93
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0F19EEAA;
	Thu, 15 Aug 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0cEgGkT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E71714A1
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730156; cv=none; b=NcKSJGaIUhNhUNVHj4MrO0Vb8rCRncGIZtaUzSWQhgoylePQB+MBDIVsSI4oOFEFspibqBiSpadGs4NQYxsPUKqxfqiqb8A0ooTOr/6t74/qimVWthbBwZ7agLhm1h+SP+aYxaCAG94YqqftjL065ilMSJwdEDKcqkxxK+TQ6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730156; c=relaxed/simple;
	bh=MsSF0ZMUFFKBilcSHXDg3Wgfc1Du5Oe51UnolXkzzvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my2jMu9DEqmKogbUkiXsMTPPi80wgVDAyGvwoib8gtgaYQn0ax0nN30du6z2x2kAArElTD2rBz3lX6FP5mYSuK4i+Vg2bqvegy5hso7PVFDLHKeoOgxy7mcDNUtLO8u99FlEj5AfmAVl9TGsvQHsc9RTFYvPK2WGp1MDLCe8XaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0cEgGkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A75C4AF0D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730156;
	bh=MsSF0ZMUFFKBilcSHXDg3Wgfc1Du5Oe51UnolXkzzvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=P0cEgGkTVxCOyhlzQ3El8NHry3MfF+l32ATuun3K5VT+yqZ+3BDZj1AtK3PQnHV7D
	 4mE4GyGi7QUIGdVBG2CdxIteJQMiRUI9oGT+11M/cif9/FBFnOHinWGuhg04aAUhqZ
	 VzyFJZmCVD+xcyCMe6GyUwX4QwJSWGO9D+Uzn69Mta+YZH4nqX/PU9OuSloH79Lrps
	 dDlgYCSpAl5RWpS9EaKzI2q9+Bs1gviQBfh3snO2/E1lEKv3wSDVtvKcFgWvUqdScD
	 xD1MAmyzQ/63N7LGd1CMa3YB4iGqXZEXFghbpTfgat5rzIKLjY9v/4bGXXspyDJQw/
	 vniTpSjkR9wsg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66ca5e8cc51so9737967b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:55:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfgSeLahId6BI8PIp1GjhFMUfGLXQPpu6j1x9S4fd0WRNzX9x3ohOrkbqXHG5SJodE7TZmmrahWJJNouQ5hMcpg3TjW0zGZBTE1I6YdxU=
X-Gm-Message-State: AOJu0YwfePnttyxsnwz8zxFW2RrI8D42cnEx7Bfw8ieDUvtgSYNLOS0M
	FMFVT8X2qrrYBZHlUWgM+zUoAt2W49xuDZZusnAm3FKilkOpwrXHvJK0zlHKG8Ws32qfxvyAUIA
	7Spd8syNj8lge4LeCconJBbYe69w=
X-Google-Smtp-Source: AGHT+IE9g8Et9/7N9qT7VqtHIV42bP2F1ImRodlvjO4IZyU8D4JRPGtVEFXM1hFoSuCz+Mw4pNGd3uYxCaaPPr6u6k0=
X-Received: by 2002:a05:690c:fcb:b0:62f:37c9:77bc with SMTP id
 00721157ae682-6ac8fe09107mr83314787b3.0.1723730155534; Thu, 15 Aug 2024
 06:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cymc1iga.fsf@kernel.org>
In-Reply-To: <87cymc1iga.fsf@kernel.org>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 15 Aug 2024 09:55:44 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5M1vcSH2z41zQwBuv8pj89GG-wGkHApMOe=UiDmhHAkw@mail.gmail.com>
Message-ID: <CA+5PVA5M1vcSH2z41zQwBuv8pj89GG-wGkHApMOe=UiDmhHAkw@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath11k and ath12k firmware 20240813
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:44=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrot=
e:
>
> Hi,
>
> Here's a pull request for ath11k and ath12k. We have new ath11k hardware
> QCA2066 hw2.1 and usual smaller updates.
>
> Please let me know if there are any problems.
>
> Kalle
>
> The following changes since commit 594600762910b4bbe8a88d0dc6495521366c88=
0c:
>
>   Merge branch 'vpu' into 'main' (2024-08-09 13:02:09 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20240813

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/275

josh

>
> for you to fetch changes up to 82318c966fd1af87044299d34611751c76f70927:
>
>   ath12k: WCN7850 hw2.0: update board-2.bin (2024-08-13 19:36:13 +0300)
>
> ----------------------------------------------------------------
> Kalle Valo (6):
>       ath11k: IPQ5018 hw1.0: update to WLAN.HK.2.6.0.1-01291-QCAHKSWPL_SI=
LICONZ-1
>       ath11k: QCA2066 hw2.1: add board-2.bin
>       ath11k: QCA2066 hw2.1: add to WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_S=
ILICONZ_CE-2.52297.3
>       ath11k: WCN6855 hw2.0: update board-2.bin
>       ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V=
2_SILICONZ_LITE-3.6510.41
>       ath12k: WCN7850 hw2.0: update board-2.bin
>
>  WHENCE                           |    9 +-
>  ath11k/IPQ5018/hw1.0/m3_fw.b01   |  Bin 136 -> 136 bytes
>  ath11k/IPQ5018/hw1.0/m3_fw.b02   |  Bin 262144 -> 262144 bytes
>  ath11k/IPQ5018/hw1.0/m3_fw.mdt   |  Bin 284 -> 284 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b00   |  Bin 532 -> 532 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b01   |  Bin 520 -> 520 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b02   |  Bin 7552 -> 7552 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b04   |  Bin 86788 -> 86788 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b08   |  Bin 4096 -> 4096 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b09   |  Bin 2330624 -> 2334720 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b10   |  Bin 269028 -> 269220 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b11   |  Bin 99436 -> 99456 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b13   |  Bin 7024 -> 7072 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.mdt   |  Bin 1052 -> 1052 bytes
>  ath11k/QCA2066/hw2.1/Notice.txt  | 3658 ++++++++++++++++++++++++++++++++=
++++++
>  ath11k/QCA2066/hw2.1/amss.bin    |  Bin 0 -> 5349376 bytes
>  ath11k/QCA2066/hw2.1/board-2.bin |  Bin 0 -> 685144 bytes
>  ath11k/QCA2066/hw2.1/m3.bin      |  Bin 0 -> 266684 bytes
>  ath11k/WCN6855/hw2.0/amss.bin    |  Bin 4988928 -> 4988928 bytes
>  ath11k/WCN6855/hw2.0/board-2.bin |  Bin 6308684 -> 6429240 bytes
>  ath11k/WCN6855/hw2.0/m3.bin      |  Bin 266684 -> 266684 bytes
>  ath12k/WCN7850/hw2.0/board-2.bin |  Bin 382856 -> 1897968 bytes
>  22 files changed, 3665 insertions(+), 2 deletions(-)
>  create mode 100644 ath11k/QCA2066/hw2.1/Notice.txt
>  create mode 100644 ath11k/QCA2066/hw2.1/amss.bin
>  create mode 100644 ath11k/QCA2066/hw2.1/board-2.bin
>  create mode 100644 ath11k/QCA2066/hw2.1/m3.bin

