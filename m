Return-Path: <linux-wireless+bounces-1147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C747A81B974
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 15:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D791C23EAF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7806736085;
	Thu, 21 Dec 2023 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0KZNngN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D06336084
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 14:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6DAC433C7;
	Thu, 21 Dec 2023 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703168593;
	bh=VJVm9sAChmhhS6GxWESn6J/w+ak9YS7aw1uRnA4naCM=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=F0KZNngNNerCSpNgXx08zdCJ7MWD3cQz2V7WGtrDChd5eGMN6wktSGBsL1swgycGC
	 EVPB4u9Ui87pncDv3e6pp2p8U8NPrplg/Ad6F7YgWT6itHfn9jU2nATIlIDkhYCgBQ
	 liMCaFOqhuVdu1kKCKHDN/GFE2HHafnxw6D7w02WotV1s8BYm6BXp1jaqqMC51LNIb
	 G8l5x8WxH51g13VlzUmPE0I/XBaN4eBfVuS+X+ESmTpo/6s53Hf7bFXHDtR73b6ZZn
	 hmtApyxWPU6ZOTWUad7haCHdhS2wgRxzYuaO0ZMCHr2x5rE0GoZSQqPaf5MyjQVqxT
	 TPxqpfPS3D06A==
From: Kalle Valo <kvalo@kernel.org>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware 2023-12-21
Date: Thu, 21 Dec 2023 16:23:10 +0200
Message-ID: <878r5nprch.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Here's a new pull request for ath10k, ath11k and ath12k. We have a new
driver ath12k and the first firmware for WCN7850. And as usual firmware
and board files to other hardware.

Please let me know if there are any problems.

Kalle

The following changes since commit c156e6be6d4a0a2290e7059bc74fb0612aa19693:

  Merge branch 'robot/pr-0-1702625169' into 'main' (2023-12-15 12:16:57 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git ath10k-20231221

for you to fetch changes up to 17509e53b97baaefeb287b98d3358da8a6e1c199:

  ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36 (2023-12-21 16:13:58 +0200)

----------------------------------------------------------------
Kalle Valo (9):
      ath12k: add new driver and firmware for WCN7850
      ath10k: QCA6174 hw3.0: update firmware-6.bin to WLAN.RM.4.4.1-00309-
      ath10k: QCA4019 hw1.0: update board-2.bin
      ath10k: QCA9888 hw2.0: update board-2.bin
      ath10k: WCN3990 hw1.0: update board-2.bin
      ath11k: IPQ8074 hw2.0: update board-2.bin
      ath11k: WCN6750 hw1.0: update board-2.bin
      ath11k: WCN6855 hw2.0: update board-2.bin
      ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.36

 WHENCE                              |   16 +-
 ath10k/QCA4019/hw1.0/board-2.bin    |  Bin 1798148 -> 1822336 bytes
 ath10k/QCA6174/hw3.0/firmware-6.bin |  Bin 706004 -> 706360 bytes
 ath10k/QCA9888/hw2.0/board-2.bin    |  Bin 206444 -> 218596 bytes
 ath10k/WCN3990/hw1.0/board-2.bin    |  Bin 513892 -> 670116 bytes
 ath11k/IPQ8074/hw2.0/board-2.bin    |  Bin 1311380 -> 1442536 bytes
 ath11k/WCN6750/hw1.0/board-2.bin    |  Bin 843548 -> 843548 bytes
 ath11k/WCN6855/hw2.0/amss.bin       |  Bin 4980736 -> 4988928 bytes
 ath11k/WCN6855/hw2.0/board-2.bin    |  Bin 6278772 -> 6308684 bytes
 ath12k/WCN7850/hw2.0/Notice.txt     | 3386 +++++++++++++++++++++++++++++++++++
 ath12k/WCN7850/hw2.0/amss.bin       |  Bin 0 -> 6000704 bytes
 ath12k/WCN7850/hw2.0/board-2.bin    |  Bin 0 -> 382856 bytes
 ath12k/WCN7850/hw2.0/m3.bin         |  Bin 0 -> 299660 bytes
 13 files changed, 3400 insertions(+), 2 deletions(-)
 create mode 100644 ath12k/WCN7850/hw2.0/Notice.txt
 create mode 100644 ath12k/WCN7850/hw2.0/amss.bin
 create mode 100644 ath12k/WCN7850/hw2.0/board-2.bin
 create mode 100644 ath12k/WCN7850/hw2.0/m3.bin

