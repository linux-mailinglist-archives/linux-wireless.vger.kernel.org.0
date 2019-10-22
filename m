Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93714E001E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfJVI5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 04:57:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbfJVI5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 04:57:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D93C6081C; Tue, 22 Oct 2019 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571734663;
        bh=P1gtfMzQ64P1I8hkPS69QXlX/oj3QD3ocmBAXcTD/gw=;
        h=From:To:Cc:Subject:Date:From;
        b=U4wDhOa2jowfb4Gyg7jq5c+VsZLcbdamql8N6rT/gTEFxbtQzO7ni0cnQrx1z35eP
         yiNbAEgMJpBXhomIwGD9Xrcxs1Hn0nqyzVcbna8BVyRAPvmAVc2ROgjLO09Kq9AOoH
         Wve195Bseh3x7GCe04zbdny3xHDVndhNUtS22PQY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from zhichen.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zhichen@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0ACA60159;
        Tue, 22 Oct 2019 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571734662;
        bh=P1gtfMzQ64P1I8hkPS69QXlX/oj3QD3ocmBAXcTD/gw=;
        h=From:To:Cc:Subject:Date:From;
        b=hvWS21AhsOHa0S0NnNO8mHlDU1gISUSMra4JdrrOJq+hWXMyTAPIgWmtLOGIEbBIO
         TyuMqiB4k5JndsiS/O+izJ/XmdbzFW7eIUlGef4swAqPz2tAqQ+ZYAc9/wfu5jo8Y0
         2kQtzjOq7Sn6Y6Ou+oE/6d1oImxnLYsu3scH9LKs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0ACA60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=zhichen@codeaurora.org
From:   Zhi Chen <zhichen@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>
Subject: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on multiple devices"
Date:   Tue, 22 Oct 2019 16:57:09 +0800
Message-Id: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
PCIe hung issue was observed on multiple platforms. The issue was reproduced
when DUT was configured as AP and associated with 50+ STAs.

With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
issue happened. It broke PCIe spec and caused PCIe stuck.

Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
         QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
         Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040

Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 35a3623..17f620b 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -753,7 +753,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
 #define TARGET_10X_MAX_FRAG_ENTRIES		0
 
 /* 10.2 parameters */
-#define TARGET_10_2_DMA_BURST_SIZE		0
+#define TARGET_10_2_DMA_BURST_SIZE		1
 
 /* Target specific defines for WMI-TLV firmware */
 #define TARGET_TLV_NUM_VDEVS			4
@@ -813,7 +813,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
 
 #define TARGET_10_4_TX_DBG_LOG_SIZE		1024
 #define TARGET_10_4_NUM_WDS_ENTRIES		32
-#define TARGET_10_4_DMA_BURST_SIZE		0
+#define TARGET_10_4_DMA_BURST_SIZE		1
 #define TARGET_10_4_MAC_AGGR_DELIM		0
 #define TARGET_10_4_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
 #define TARGET_10_4_VOW_CONFIG			0
-- 
2.7.4

