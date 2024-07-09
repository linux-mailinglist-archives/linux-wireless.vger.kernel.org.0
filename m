Return-Path: <linux-wireless+bounces-10099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534492B11B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8E6B20B62
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D05482E2;
	Tue,  9 Jul 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4UzD6tE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EC6F305;
	Tue,  9 Jul 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510317; cv=none; b=rqI0xeexE3vQtlVQ86YGlbl56XBqBxs8xJwMAsPdVy8te7ID5TMOd3dS9ZZR0Jx/bJKWikBX6otptCdwdIxGoW0SARiiX34J1N9E2iI3qthzc0cHS2Ze3jU6J+dqTzIXbfS1/XmIceWyamH1FW/UkVa9Yk1WLigqUJda4XiDMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510317; c=relaxed/simple;
	bh=tOLVytebM6kjmTjWDA4Ja4R2xGEMQnffElBDnEJ7wsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scNNhHIYP1us8ygNRSpJ2XpUJLJ1AVcUjTZ5BB2RbVPWg4YClGFSo+oOMDcRj2AajBCocgitYF30rFrpzD0XpuI2efJ+WbZ95YKpwSvHf9eJkwfYnRCIXZ/bRE8K4HRrWGj+CwOrA0T2ahDjc5w5aPZmQ4O4Ob5b57DLBGn/Tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4UzD6tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0754C3277B;
	Tue,  9 Jul 2024 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720510316;
	bh=tOLVytebM6kjmTjWDA4Ja4R2xGEMQnffElBDnEJ7wsY=;
	h=From:To:Cc:Subject:Date:From;
	b=J4UzD6tEXnPoolrRlbkm+09zsThJvA73SHeBDe+68+28HiqnYomNrq+97ptCL3FTr
	 V5gcr5rvOLM9Xl5sEMjC1vORw82foCIPUtC7JNmV4Uq5PiUoGBTvR1DDSf/LFsh6Qt
	 MghhjV3ZqvNv7wcSnNiQq52/OK5P9qgLSvmobZJuhXT+O1OnWnSmMQ8KrtUOrLLc05
	 UzPlpj+Sru3ntWQ8ekhIzQ1lJy2j42rDe8XgJU+UMsIb6ZmAuoq/FW1DEfmBTvjW1u
	 GWazb6ftAzj245PW1rJ9xOenOXC9sNJdOSJLMMFrtUoTbPV/49pZ+kj2T+hvSDK3tm
	 02XtA7qDT5RmA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sR5KT-000000002OW-21T0;
	Tue, 09 Jul 2024 09:32:02 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Wen Gong <quic_wgong@quicinc.com>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix soft lockup on suspend
Date: Tue,  9 Jul 2024 09:31:32 +0200
Message-ID: <20240709073132.9168-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ext interrupts are enabled when the firmware has been started, but
this may never happen, for example, if the board configuration file is
missing.

When the system is later suspended, the driver unconditionally tries to
disable interrupts, which results in an irq disable imbalance and causes
the driver to spin indefinitely in napi_synchronize().

Make sure that the interrupts have been enabled before attempting to
disable them.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org	# 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath12k/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 16af046c33d9..55fde0d33183 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -472,7 +472,8 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 {
 	int i;
 
-	clear_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+	if (!test_and_clear_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return;
 
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
-- 
2.44.1


