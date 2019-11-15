Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA38FD851
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKOJDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:03:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOJDD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:03:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ADC0861160; Fri, 15 Nov 2019 09:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573808582;
        bh=Z4gPf030YPBEPaOKFiD6fmUGZ+QzaliCYIEtwsTmnzc=;
        h=From:To:Cc:Subject:Date:From;
        b=gdABsYvKvpmQGgZy4Arkdy10T8QomNmjGYl4WcxeHzkG1XeRopdwFVrF7S6SemFgv
         r1IgYLkfjaj5/t99oat7lb7SpuOnuU3GHAHBGZwTeNcrlT1YRPUpLJ/+L49BozZkyc
         OCprlGjKb7HU5IF6zBbSB9HxTgAufGZ3JyO7OySg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 669B560F39;
        Fri, 15 Nov 2019 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573808582;
        bh=Z4gPf030YPBEPaOKFiD6fmUGZ+QzaliCYIEtwsTmnzc=;
        h=From:To:Cc:Subject:Date:From;
        b=gdABsYvKvpmQGgZy4Arkdy10T8QomNmjGYl4WcxeHzkG1XeRopdwFVrF7S6SemFgv
         r1IgYLkfjaj5/t99oat7lb7SpuOnuU3GHAHBGZwTeNcrlT1YRPUpLJ/+L49BozZkyc
         OCprlGjKb7HU5IF6zBbSB9HxTgAufGZ3JyO7OySg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 669B560F39
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=zhichen@codeaurora.org
From:   Zhi Chen <zhichen@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>
Subject: [PATCH RFC,v2] Revert "ath10k: fix DMA related firmware crashes on multiple devices"
Date:   Fri, 15 Nov 2019 17:02:53 +0800
Message-Id: <1573808573-12159-1-git-send-email-zhichen@codeaurora.org>
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
v2: revert 10.4 only because old chips have different AXI RD/WR CFG
---
 drivers/net/wireless/ath/ath10k/hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 35a3623..59a9a58 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
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

