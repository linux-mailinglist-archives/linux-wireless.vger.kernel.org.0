Return-Path: <linux-wireless+bounces-11360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F57950AAE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE58B1C20B72
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF491A2C36;
	Tue, 13 Aug 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgWj1/f4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B61A2C21
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567449; cv=none; b=lJX7YOri8f4/9HpxG5IsYddc/y+VhCndZpPCwTWtyBW8Rxaj6by+qCbhHlwRpLDL2tr+gC7E2neajxuc2dzNtj9w1Ll1JjFJmEQuRB6nDGAFSDFIYLE672PlKitgB+jeMjCW2gXsVO6ShdJyQ5GTo0I/0q3EWLd8j2fAMEso3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567449; c=relaxed/simple;
	bh=xYyT1jdZW9+VRI9b3mmRuSwMQCc/AU1cbEeq1xxXdqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nl1/RCNsSQ76ETjR01TgY9f8bhugfNMNWlR8fpn2J85caAi56csj7j7j0dQa7YQ+bNLFcvmOgETv0BoNETpvvhCXpvbIBIUi8bYHsqqdStmRWZVX6F9VrvXjz6yLJCcVRrpLxMZrsUvk5/zaFgvJSrsJF5N50v21CCEgokID2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgWj1/f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF08C4AF0B;
	Tue, 13 Aug 2024 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723567448;
	bh=xYyT1jdZW9+VRI9b3mmRuSwMQCc/AU1cbEeq1xxXdqI=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=qgWj1/f45FsiBjyvxVIsvfiyZWbOjDa2zUWIhvZ8wCjDognaZpO446u7f0K2jaE9l
	 Fc9Q2Kt4IZK424bqFSkFOKwOrN7s8DLNUZfanTCnqgzYP/XKdl5aFSljtqWuEEssiK
	 V01sE5wu4vA/8BuHln3NO22OcPbDgjj1Wiun485ZEsBsuDU/YGkXi1DOTcjKvCX2t2
	 Dp/YTovZxaUpcoOiYKV9xqcfASuhBfRDftzakYDNqJJ+QkVf+2EX+av4AEFQ+/IXE7
	 6u0AjyjyQB4OQllQA9L0z5yHXfjnLnLcncNEHWrPFEIcIwdJRrv9CkE2IF5TQ0Fgqb
	 HdnueSfdk/v/w==
From: Kalle Valo <kvalo@kernel.org>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
    Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PULL linux-firmware] ath11k and ath12k firmware 20240813
Date: Tue, 13 Aug 2024 19:44:05 +0300
Message-ID: <87cymc1iga.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Here's a pull request for ath11k and ath12k. We have new ath11k hardware
QCA2066 hw2.1 and usual smaller updates.

Please let me know if there are any problems.

Kalle

The following changes since commit 594600762910b4bbe8a88d0dc6495521366c880c:

  Merge branch 'vpu' into 'main' (2024-08-09 13:02:09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20240813

for you to fetch changes up to 82318c966fd1af87044299d34611751c76f70927:

  ath12k: WCN7850 hw2.0: update board-2.bin (2024-08-13 19:36:13 +0300)

----------------------------------------------------------------
Kalle Valo (6):
      ath11k: IPQ5018 hw1.0: update to WLAN.HK.2.6.0.1-01291-QCAHKSWPL_SILICONZ-1
      ath11k: QCA2066 hw2.1: add board-2.bin
      ath11k: QCA2066 hw2.1: add to WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.3
      ath11k: WCN6855 hw2.0: update board-2.bin
      ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
      ath12k: WCN7850 hw2.0: update board-2.bin

 WHENCE                           |    9 +-
 ath11k/IPQ5018/hw1.0/m3_fw.b01   |  Bin 136 -> 136 bytes
 ath11k/IPQ5018/hw1.0/m3_fw.b02   |  Bin 262144 -> 262144 bytes
 ath11k/IPQ5018/hw1.0/m3_fw.mdt   |  Bin 284 -> 284 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b00   |  Bin 532 -> 532 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b01   |  Bin 520 -> 520 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b02   |  Bin 7552 -> 7552 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b04   |  Bin 86788 -> 86788 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b08   |  Bin 4096 -> 4096 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b09   |  Bin 2330624 -> 2334720 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b10   |  Bin 269028 -> 269220 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b11   |  Bin 99436 -> 99456 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.b13   |  Bin 7024 -> 7072 bytes
 ath11k/IPQ5018/hw1.0/q6_fw.mdt   |  Bin 1052 -> 1052 bytes
 ath11k/QCA2066/hw2.1/Notice.txt  | 3658 ++++++++++++++++++++++++++++++++++++++
 ath11k/QCA2066/hw2.1/amss.bin    |  Bin 0 -> 5349376 bytes
 ath11k/QCA2066/hw2.1/board-2.bin |  Bin 0 -> 685144 bytes
 ath11k/QCA2066/hw2.1/m3.bin      |  Bin 0 -> 266684 bytes
 ath11k/WCN6855/hw2.0/amss.bin    |  Bin 4988928 -> 4988928 bytes
 ath11k/WCN6855/hw2.0/board-2.bin |  Bin 6308684 -> 6429240 bytes
 ath11k/WCN6855/hw2.0/m3.bin      |  Bin 266684 -> 266684 bytes
 ath12k/WCN7850/hw2.0/board-2.bin |  Bin 382856 -> 1897968 bytes
 22 files changed, 3665 insertions(+), 2 deletions(-)
 create mode 100644 ath11k/QCA2066/hw2.1/Notice.txt
 create mode 100644 ath11k/QCA2066/hw2.1/amss.bin
 create mode 100644 ath11k/QCA2066/hw2.1/board-2.bin
 create mode 100644 ath11k/QCA2066/hw2.1/m3.bin

