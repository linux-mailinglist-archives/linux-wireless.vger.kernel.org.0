Return-Path: <linux-wireless+bounces-22068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86972A9C908
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E821BA308E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2D1A08AF;
	Fri, 25 Apr 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVCQ2y/X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB15695
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745584549; cv=none; b=dYSwQMmlZSgCagG66NEjMSV/tO9DjS/GxqY2Q5BKEMktwhWhxqm33sO5nMeydnvHBXMnNbGOIVczzazQ9RG07WjWP2UScJ7KXJgXZ9Q4UnZvne6u19BS87q9b1g649MKMDihlyRj7gX8yWNA1g3IW+St1gYfDkQuqPbqeWeEfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745584549; c=relaxed/simple;
	bh=NBbf9gNE6rO2PKHGflXky6hJbsXpf3UmgCARwrP7qoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGHv6WxlybU+7XjrXaJUWoCkH4zCgKLYY8P2E/fx1SKNa8AICvp8CYEOF9M7fr+CBgcKU35oCvUqltoClrw+iz6wfmOfzdfgWn+Rx9jOoT3ECHkJGQZ/A+SPT4ctUJ5XBIoucSp/h+Q2MF4zSEMm6k2F9vttD1BI8Or7v12OXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVCQ2y/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87431C4CEE4
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745584548;
	bh=NBbf9gNE6rO2PKHGflXky6hJbsXpf3UmgCARwrP7qoM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=eVCQ2y/XOwPqYzsX8T1RtjqS959rQ/0CmG8oGelz/MVfkfPCnDhF99VHQZf8ZHCvH
	 uKP1lo6kgDz2AV/j8b2dgcC9UyRA3AfN8CT/yPfnpdU7ZgCLwy4gOZSAPM9hd4ehmr
	 VjoXsD9YZowYehiPapJHqGnrCR7/5KbwVPdSRJ3Euwjo3zSEgQqpXv003GX+1pQro2
	 +0nuE5Ph8rQGsWWRE08ddkiShYNbnViBxUlUnEMbn6gBlRfllMQPfej+Uwco/CPSX0
	 zBRJerf//fxCVuJa+wM1M3cYqgUVi0OzV7omcs9tlzuQT6qtg17JkBM9qmN4oby2Jx
	 NXI2TZah6L+7A==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70565ccf3bcso23913417b3.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 05:35:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWT+j05C1Jy2PHlIgTzIBu1/IpACRq+nc2wYnbWaHHCcGPWF/ErXzM0KrgG/W48Q1fXz8c3byyzTaK0+57/iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSDcHisJUptsMnJglwszq69Zq6pyWZGmaBS2QFdTE1XK3os2l
	TvIhMH6fjBLklU2d8K85QugDAqBf+GFuVNhSs5FAVQB7tipFqH9Awd8VRYt9j54BkF+75g5D1f+
	kaqsyFah+GvDPXdbXTsKB6c3YBCs=
X-Google-Smtp-Source: AGHT+IGDt9aoxGrxaGdyTTeDSrfXroJCvAtD1fdjtKXhnHKlHwfs/SCMm5fDkS5hkf5DjxqYAC/oNkBXKbPa4IJM9tY=
X-Received: by 2002:a05:690c:6d05:b0:702:d54:5794 with SMTP id
 00721157ae682-708541e9ffcmr27742027b3.31.1745584547796; Fri, 25 Apr 2025
 05:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <96b43d18-72e1-44a8-bf06-6a22fd012b07@oss.qualcomm.com>
In-Reply-To: <96b43d18-72e1-44a8-bf06-6a22fd012b07@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 25 Apr 2025 08:35:36 -0400
X-Gmail-Original-Message-ID: <CA+5PVA71-_a9nG-vULohgzbSfyFyWOB9RE1x4D4vdUbw4HAegg@mail.gmail.com>
X-Gm-Features: ATxdqUG-Y0F2Gdu0J4NLMD6PZcYoVIbFgR97YO-susRSEJJ3-yKT3qLEMaTQGWY
Message-ID: <CA+5PVA71-_a9nG-vULohgzbSfyFyWOB9RE1x4D4vdUbw4HAegg@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath11k and ath12k firmware 20250424
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:38=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> Hi,
> Here's a new pull request for ath11k and ath12k.
>
> For ath11k, update the firmware for IPQ5018 and update the board file
> for WCN6855. For ath12k, update the firmware for WCN7850 and update
> the board file for QCN9274.
>
> Please let me know if there are any problems.
>
> /jeff
>
> The following changes since commit 490c0af1d6b9ffca0523edcfad27ba483b9d6d=
a3:
>
>   Merge branch 'robot/pr-0-1745490027' into 'main' (2025-04-24 13:46:05 +=
0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250424

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/528

josh

>
> for you to fetch changes up to ce13d29c3933f77674cf45855668485c48d3eba0:
>
>   ath11k: WCN6855 hw2.0: update board-2.bin (2025-04-24 13:04:20 -0700)
>
> ----------------------------------------------------------------
> Jeff Johnson (4):
>       ath12k: QCN9274 hw2.0: update board-2.bin
>       ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V=
1.0_V2.0_SILICONZ-3
>       ath11k: IPQ5018 hw1.0: update to WLAN.HK.2.6.0.1-01300-QCAHKSWPL_SI=
LICONZ-1
>       ath11k: WCN6855 hw2.0: update board-2.bin
>
>  WHENCE                           |    4 +-
>  ath11k/IPQ5018/hw1.0/Notice.txt  | 3918 +++-----------------------------=
------
>  ath11k/IPQ5018/hw1.0/q6_fw.b00   |  Bin 532 -> 532 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b01   |  Bin 520 -> 520 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b04   |  Bin 86788 -> 86788 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b08   |  Bin 4096 -> 4096 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b09   |  Bin 2334720 -> 2334720 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b10   |  Bin 269220 -> 269252 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b11   |  Bin 99456 -> 99456 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.b13   |  Bin 7072 -> 7080 bytes
>  ath11k/IPQ5018/hw1.0/q6_fw.mdt   |  Bin 1052 -> 1052 bytes
>  ath11k/WCN6855/hw2.0/board-2.bin |  Bin 6429240 -> 6429240 bytes
>  ath12k/QCN9274/hw2.0/board-2.bin |  Bin 1308544 -> 2626240 bytes
>  ath12k/WCN7850/hw2.0/amss.bin    |  Bin 6000704 -> 6082624 bytes
>  ath12k/WCN7850/hw2.0/m3.bin      |  Bin 299660 -> 299660 bytes
>  15 files changed, 315 insertions(+), 3607 deletions(-)

