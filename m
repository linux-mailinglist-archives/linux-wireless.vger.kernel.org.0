Return-Path: <linux-wireless+bounces-28358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F42C1B8E6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2222D622699
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC52BDC3D;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbkteA2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43D26E719;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748000; cv=none; b=GaKghbP4G8xPSfI+6PT0o91k+Lh2Vp7UMK+hJmCh3oGuUY240ScxHCRukLYQdrYzc9okjKaAExMo3glV3Ji9NYWyPry/BCtEGIgh2wKWlg33fv5nw8UGPQTfRgpuhRD6erJB1hiIRAMbF+CIP032DPoyWAUTyKUV53AQGKG2/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748000; c=relaxed/simple;
	bh=UnCFoCnku8yVyQzP5inxRUrpnnVudgKfryjNsjn3tsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mBHFFH0pt2NOI/PMUllgCj9Sx7VKwiJP45xraeKdb7sVsYeWRN6vbUHEZIOmdz4sA4MucsqR3gsmGc/bixz6+DiLbsboZGOyL93cYihZNzc1i86tgFAMr5y90xDuHK0TWglxKSu/PEbI9DZSrxLpK3jaDzVrCwa5VmTX0WGNnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbkteA2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DF5CC4CEF7;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748000;
	bh=UnCFoCnku8yVyQzP5inxRUrpnnVudgKfryjNsjn3tsQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dbkteA2npjGfu+w5HuiJXLoMYUfTRNaf+FWjgrA1iJEcVi6iMQCmTmRCqfQovAtve
	 xySL+4wak4rrc7eWsL2NpGHulZZALqryTtzZxxljCaLPXEbmWqib+SNDV+ZGAeYbyL
	 Qt6YIDFrnsJ9OWw8E5TeaJZ8kqMaB/bZ6UITaOVFV0hzq8q8Ge23QAor+bWbrWDw1W
	 f1jA7L90bAvZzve+CKs82f5yKSjbIklHsCRWF1SoWP5gedpGIgA3T9Non+XX4+YgGU
	 P3qYTmFGTy5H7biZnUL171gKeUqwqJpRWu7AwDA0ZXCZjq1imx1upvwPMYZPRP6LLg
	 c9VRIIE3TOFwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CB7CCF9EE;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH 0/6] wifi: ath11k: Add support for QCN6122
Date: Wed, 29 Oct 2025 18:26:21 +0400
Message-Id: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA0kAmkC/x3MwQpAQBCA4VfRnG2ZWVa8ihwmBpNa7EpK3t3m+
 B3+/4EoQSVCmz0Q5NKom0/APINhYT+L0TEZqKAKC2oMnwviao7BOyQy9VhZy1yW7BykaA8y6f0
 Pu/59P6+nsdZgAAAA
X-Change-ID: 20251029-ath11k-qcn6122-7d533aa44a66
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761747997; l=2267;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=UnCFoCnku8yVyQzP5inxRUrpnnVudgKfryjNsjn3tsQ=;
 b=khlFtybL94Ksk1micyaAESgIiFeSykKJI1T1PK4DjQeDaaEqLTDeRC3rjlObASVjWDqqhcfxH
 oVwjXKuaOMuCDgLpEjM6jJAquDkPOrU1UXsfcE01gVcWSb/DXn88qda
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

QCN6122 is a PCIe based solution that is attached to and enumerated
by the WPSS (Wireless Processor SubSystem) Q6 processor.

Though it is a PCIe device, since it is not attached to APSS processor
(Application Processor SubSystem), APSS will be unaware of such a decice
so it is registered to the APSS processor as a platform device(AHB).
Because of this hybrid nature, it is called as a hybrid bus device as
introduced by WCN6750.

This chip is similar to WCN6750 and follows the same codepath as for
WCN6750 to bring up the radio and communicate with the firmware.

QCN6122 is an IPQ5018 SoC specific solution and uses shared
IPQ5018/QCN6122 firmware.

This patch series is a much simplified version of below vendor patch:
Download from https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/NHSS.QSDK.12.4.5.r2/mac80211/patches/232-ath11k-qcn6122-support.patch

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
George Moussalem (6):
      dt: bindings: net: add bindings for QCN6122
      wifi: ath11k: add hw params for QCN6122
      wifi: ath11k: add hw ring mask for QCN6122
      wifi: ath11k: update hif and pci ops for QCN6122
      wifi: ath11k: add multipd support for QCN6122
      wifi: ath11k: add QCN6122 device support

 .../bindings/net/wireless/qcom,ath11k.yaml         | 57 +++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.c              | 68 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.c             | 68 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h             |  5 ++
 drivers/net/wireless/ath/ath11k/hif.h              |  9 +++
 drivers/net/wireless/ath/ath11k/hw.c               | 37 ++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h               |  1 +
 drivers/net/wireless/ath/ath11k/pci.c              |  1 +
 drivers/net/wireless/ath/ath11k/pcic.c             |  9 +++
 drivers/net/wireless/ath/ath11k/qmi.c              |  2 +
 drivers/net/wireless/ath/ath11k/qmi.h              |  3 +-
 11 files changed, 258 insertions(+), 2 deletions(-)
---
base-commit: 88de08348af8ce15dc563e0ebb5553eddd821c06
change-id: 20251029-ath11k-qcn6122-7d533aa44a66

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



