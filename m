Return-Path: <linux-wireless+bounces-1287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7081E976
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Dec 2023 20:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF64B20D6F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Dec 2023 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10F44C6F;
	Tue, 26 Dec 2023 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwfI6OsJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1B4C6D
	for <linux-wireless@vger.kernel.org>; Tue, 26 Dec 2023 19:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED38C433C9
	for <linux-wireless@vger.kernel.org>; Tue, 26 Dec 2023 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703619729;
	bh=yGkxVhUKDayFNUEMyL0TaOj2LLfx+FpjFxb7WILnJbY=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=iwfI6OsJ0OSxBbcvHbcN4T0NHFQfRqMgnKIX0Ccsw8L4R+erCnvUyZoRYgRJcZIvs
	 1COiuDN02x1HsjoHI/JFPmnmVj1XVgHvQYbCSQMg5ZfWkQxhB+CJg/B23hlVHwx1ki
	 Rz2DFM2DqfyYJJjrnahFvePUdSAv57S7olZwQpfIQxSAM7JYVbAhsOTj8pyTfRXDdh
	 5NqRTgaVdSdYanhwgF0JhDlQ9tloZXWIUeaJt7KAWCdt6p7IOmJq0i+4jIr2LzTKCc
	 CiTjs+Kit+VvOSyeu5aLMqI+WEk/akp9+3gNa8pk1FiK0xieCctuBNr/hI3nMgTfyk
	 dmjOqFxm+aDDQ==
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd721384c0so3630128276.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 Dec 2023 11:42:09 -0800 (PST)
X-Gm-Message-State: AOJu0YzQymzCX5q335AlEl9iDmNEhRCuIEAmPVSoC09Ukd+QPdcQxyNf
	NsG7+7c5hLUp2xlYDHAW0oCC2o+xrWsJieFA+sA=
X-Google-Smtp-Source: AGHT+IFo/cnUZqxRCUv6aDluCoe4zPRLbzZCTXYsyfOwSZNJkt8jQ+OdNEVJMSTHLE0aGXkcw+bftFtMW163Y8A/HDM=
X-Received: by 2002:a25:8583:0:b0:d9a:cd62:410c with SMTP id
 x3-20020a258583000000b00d9acd62410cmr2895754ybk.4.1703619728414; Tue, 26 Dec
 2023 11:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878r5nprch.fsf@kernel.org>
In-Reply-To: <878r5nprch.fsf@kernel.org>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 26 Dec 2023 14:41:57 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5CAbLESXMZY-b7j2A4P2fjeH6upxQkStw_VTDyok-V2g@mail.gmail.com>
Message-ID: <CA+5PVA5CAbLESXMZY-b7j2A4P2fjeH6upxQkStw_VTDyok-V2g@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware 2023-12-21
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:23=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Hi,
>
> Here's a new pull request for ath10k, ath11k and ath12k. We have a new
> driver ath12k and the first firmware for WCN7850. And as usual firmware
> and board files to other hardware.
>
> Please let me know if there are any problems.
>
> Kalle
>
> The following changes since commit c156e6be6d4a0a2290e7059bc74fb0612aa196=
93:
>
>   Merge branch 'robot/pr-0-1702625169' into 'main' (2023-12-15 12:16:57 +=
0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git =
ath10k-20231221

Pulled and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/103

josh

>
> for you to fetch changes up to 17509e53b97baaefeb287b98d3358da8a6e1c199:
>
>   ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SI=
LICONZ_LITE-3.6510.36 (2023-12-21 16:13:58 +0200)
>
> ----------------------------------------------------------------
> Kalle Valo (9):
>       ath12k: add new driver and firmware for WCN7850
>       ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00309=
-
>       ath10k: QCA4019 hw1.0: update board-2.bin
>       ath10k: QCA9888 hw2.0: update board-2.bin
>       ath10k: WCN3990 hw1.0: update board-2.bin
>       ath11k: IPQ8074 hw2.0: update board-2.bin
>       ath11k: WCN6750 hw1.0: update board-2.bin
>       ath11k: WCN6855 hw2.0: update board-2.bin
>       ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V=
2_SILICONZ_LITE-3.6510.36
>
>  WHENCE                              |   16 +-
>  ath10k/QCA4019/hw1.0/board-2.bin    |  Bin 1798148 -> 1822336 bytes
>  ath10k/QCA6174/hw3.0/firmware-6.bin |  Bin 706004 -> 706360 bytes
>  ath10k/QCA9888/hw2.0/board-2.bin    |  Bin 206444 -> 218596 bytes
>  ath10k/WCN3990/hw1.0/board-2.bin    |  Bin 513892 -> 670116 bytes
>  ath11k/IPQ8074/hw2.0/board-2.bin    |  Bin 1311380 -> 1442536 bytes
>  ath11k/WCN6750/hw1.0/board-2.bin    |  Bin 843548 -> 843548 bytes
>  ath11k/WCN6855/hw2.0/amss.bin       |  Bin 4980736 -> 4988928 bytes
>  ath11k/WCN6855/hw2.0/board-2.bin    |  Bin 6278772 -> 6308684 bytes
>  ath12k/WCN7850/hw2.0/Notice.txt     | 3386 +++++++++++++++++++++++++++++=
++++++
>  ath12k/WCN7850/hw2.0/amss.bin       |  Bin 0 -> 6000704 bytes
>  ath12k/WCN7850/hw2.0/board-2.bin    |  Bin 0 -> 382856 bytes
>  ath12k/WCN7850/hw2.0/m3.bin         |  Bin 0 -> 299660 bytes
>  13 files changed, 3400 insertions(+), 2 deletions(-)
>  create mode 100644 ath12k/WCN7850/hw2.0/Notice.txt
>  create mode 100644 ath12k/WCN7850/hw2.0/amss.bin
>  create mode 100644 ath12k/WCN7850/hw2.0/board-2.bin
>  create mode 100644 ath12k/WCN7850/hw2.0/m3.bin

