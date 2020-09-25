Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016DF27835F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIYI51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 04:57:27 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:60600 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYI51 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 04:57:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601024247; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=88pFpd65Wmc4+zQ5Bh8fM+NEbGAa1nsZO5GrKUrj658=; b=Q9OSOy0D3Fb+bCX89gvLxWldg/PoIsTR06XOtM0fZdh/HsIEXB/IvDRckmjTuc0zgDq8545o
 ju/zxCyzWyF6VcFpPaEoEOzgh8blzYQRxZE8fCHpc9Mt+Z9jeAEsdFn8bcqWvXmtEOyPBnJH
 rQRDhf2ntwMQk3eeHolwl1NgfFk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f6db0f6b51786209c5c82bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 08:57:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3E454C433FF; Fri, 25 Sep 2020 08:57:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3798C433CB;
        Fri, 25 Sep 2020 08:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3798C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: fix undefined reference to 'ath11k_debugfs_htt_ext_stats_handler'
Date:   Fri, 25 Sep 2020 11:57:21 +0300
Message-Id: <1601024241-16594-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kbuild bot reported than link fails when CONFIG_ATH11K_DEBUGFS is disabled:

drivers/net/wireless/ath/ath11k/dp_rx.c:1662: undefined reference to `ath11k_debugfs_htt_ext_stats_handler'

This was because I had missed to move the static inline version of the function
(which are used when CONFIG_ATH11K_DEBUGFS is disabled) to debufs_htt_stats.h.
Also move ath11k_debugfs_htt_stats_req() at the same time. And create a stub
also for ath11k_debugfs_htt_stats_init() for consistency, even if it's not
needed.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 568f06036ee2 ("ath11k: debugfs: move some function declarations to correct header files")
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs.h           | 10 ----------
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index d1ed2e72e5d1..e5346af71f24 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -173,11 +173,6 @@ static inline void ath11k_debugfs_unregister(struct ath11k *ar)
 {
 }
 
-static inline void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
-						    struct sk_buff *skb)
-{
-}
-
 static inline void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab,
 						   struct sk_buff *skb)
 {
@@ -197,11 +192,6 @@ static inline int ath11k_debugfs_is_extd_rx_stats_enabled(struct ath11k *ar)
 	return 0;
 }
 
-static inline int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
-{
-	return 0;
-}
-
 static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
 	return false;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index a36a4fed8800..74b2086eed9d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -1685,9 +1685,29 @@ struct htt_ring_backpressure_stats_tlv {
 	u32 backpressure_hist[5];
 };
 
+#ifdef CONFIG_ATH11K_DEBUGFS
+
 void ath11k_debugfs_htt_stats_init(struct ath11k *ar);
 void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
 					  struct sk_buff *skb);
 int ath11k_debugfs_htt_stats_req(struct ath11k *ar);
 
+#else /* CONFIG_ATH11K_DEBUGFS */
+
+static inline void ath11k_debugfs_htt_stats_init(struct ath11k *ar)
+{
+}
+
+static inline void ath11k_debugfs_htt_ext_stats_handler(struct ath11k_base *ab,
+							struct sk_buff *skb)
+{
+}
+
+static inline int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ATH11K_DEBUGFS */
+
 #endif
-- 
2.7.4

