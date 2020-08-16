Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7524561D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgHPFbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:31:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63395 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbgHPFbs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:31:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555907; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UHKJ52mXL/JCSAEGYgqMQT2C/oMKTfVyN1a6vIXS/jU=; b=PRhN/Y2HACnuIIuq5PLpIHCkWg1KRMzRB8RoUpjsDV01zjxWVqKs6do7qeUSiRZ1P4NGuGi3
 J4xEJ5GqRX5JRceKodSFFyJ071M0UzvzZIs/WWG84ZjyvHijQpvk5zlC5lu70my/rKRkOIHr
 dfS4sNPSvqEAEXmZhluEMZxcLzA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f38c4c2ba4c2cd367b6afe6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F3FFC433CA; Sun, 16 Aug 2020 05:31:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0306AC43391;
        Sun, 16 Aug 2020 05:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0306AC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] ath11k: use TCL_DATA_RING_0 for QCA6390
Date:   Sun, 16 Aug 2020 08:31:30 +0300
Message-Id: <1597555891-26112-9-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, wbm2sw1 is used for other purpose rather than
tx completion ring. So use TCL_DATA_RING 0 only for QCA6390.

Add MISC_CAPS_TCL_0_ONLY to control it.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  |  2 ++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 10 ++++++++--
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a279450438bb..4e397664d1b9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -42,6 +42,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
+		.tcl_0_only = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -66,6 +67,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
+		.tcl_0_only = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 953c435ef3b3..a9632b774304 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -110,7 +110,12 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 tcl_ring_sel:
 	tcl_ring_retry = false;
-	ti.ring_id = ring_selector % DP_TCL_NUM_RING_MAX;
+	/* For some chip, it can only use tcl0 to tx */
+	if (ar->ab->hw_params.tcl_0_only)
+		ti.ring_id = 0;
+	else
+		ti.ring_id = ring_selector % DP_TCL_NUM_RING_MAX;
+
 	ring_map |= BIT(ti.ring_id);
 
 	tx_ring = &dp->tx_ring[ti.ring_id];
@@ -221,7 +226,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
 		 */
-		if (ring_map != (BIT(DP_TCL_NUM_RING_MAX) - 1)) {
+		if (ring_map != (BIT(DP_TCL_NUM_RING_MAX) - 1) &&
+		    !ar->ab->hw_params.tcl_0_only) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 500060b36fb4..d15fa7fd6d5d 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -151,6 +151,7 @@ struct ath11k_hw_params {
 	bool rx_mac_buf_ring;
 	bool vdev_start_delay;
 	bool htt_peer_map_v2;
+	bool tcl_0_only;
 };
 
 struct ath11k_hw_ops {
-- 
2.7.4

