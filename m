Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056F79652B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfHTPsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:48:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfHTPsu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:48:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3521961A61; Tue, 20 Aug 2019 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316128;
        bh=M6Z2vYzA+FzInUbmWRJhoOPEZREOKegiXczmmDfdcEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYE3L0hK18pRQ8HX1/JaW4N68U2rncU5M/XvkNld9LDKwcWmj8H+POdRA+kMcFBTz
         YgceWNSkSEFCKeRJpgZc4gxGEx6epJVCXtUZoWR9kRGyBJYqrItilBLeGmV3MgyoX4
         m50rZByuwCWVJvkFfaLV+2RuwDsfmT/VzmBLWmmI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B644460863;
        Tue, 20 Aug 2019 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316125;
        bh=M6Z2vYzA+FzInUbmWRJhoOPEZREOKegiXczmmDfdcEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVvVIAe/ln16ujNu/isvWLOT4XxMw3hFxPS2kNYjMaGYXJxmfWFSB13sKgGlZnExg
         NO5nYGTxyD+UL5W/FOi8rFkOhgz4Yww3IbF0hNXBGXPpAbECUs0GV4bqn9cHdIFRKA
         YvYqZDAOcNEJ6JKb38VYF3PsV28DbueRpbMzOwts=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B644460863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 11/49] ath11k: add debug.h
Date:   Tue, 20 Aug 2019 18:47:37 +0300
Message-Id: <1566316095-27507-12-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/debug.h | 267 ++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
new file mode 100644
index 000000000000..fac6cb4aa597
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _ATH11K_DEBUG_H_
+#define _ATH11K_DEBUG_H_
+
+#include "hal_tx.h"
+#include "trace.h"
+
+enum ath11k_debug_mask {
+	ATH11K_DBG_AHB		= 0x00000001,
+	ATH11K_DBG_WMI		= 0x00000002,
+	ATH11K_DBG_HTC		= 0x00000004,
+	ATH11K_DBG_DP_HTT	= 0x00000008,
+	ATH11K_DBG_MAC		= 0x00000010,
+	ATH11K_DBG_BOOT		= 0x00000020,
+	ATH11K_DBG_QMI		= 0x00000040,
+	ATH11K_DBG_DATA		= 0x00000080,
+	ATH11K_DBG_MGMT		= 0x00000100,
+	ATH11K_DBG_REG		= 0x00000200,
+	ATH11K_DBG_TESTMODE	= 0x00000400,
+	ATH11k_DBG_HAL		= 0x00000800,
+	ATH11K_DBG_ANY		= 0xffffffff,
+};
+
+/* htt_dbg_ext_stats_type */
+enum ath11k_dbg_htt_ext_stats_type {
+	ATH11K_DBG_HTT_EXT_STATS_RESET                      =  0,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX                    =  1,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX                    =  2,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ                =  3,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED              =  4,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_ERROR                 =  5,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TQM                   =  6,
+	ATH11K_DBG_HTT_EXT_STATS_TQM_CMDQ                   =  7,
+	ATH11K_DBG_HTT_EXT_STATS_TX_DE_INFO                 =  8,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_RATE               =  9,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX_RATE               =  10,
+	ATH11K_DBG_HTT_EXT_STATS_PEER_INFO                  =  11,
+	ATH11K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO            =  12,
+	ATH11K_DBG_HTT_EXT_STATS_TX_MU_HWQ                  =  13,
+	ATH11K_DBG_HTT_EXT_STATS_RING_IF_INFO               =  14,
+	ATH11K_DBG_HTT_EXT_STATS_SRNG_INFO                  =  15,
+	ATH11K_DBG_HTT_EXT_STATS_SFM_INFO                   =  16,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_MU                 =  17,
+	ATH11K_DBG_HTT_EXT_STATS_ACTIVE_PEERS_LIST          =  18,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS             =  19,
+	ATH11K_DBG_HTT_EXT_STATS_TWT_SESSIONS               =  20,
+	ATH11K_DBG_HTT_EXT_STATS_REO_RESOURCE_STATS         =  21,
+	ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO           =  22,
+
+	/* keep this last */
+	ATH11K_DBG_HTT_NUM_EXT_STATS,
+};
+
+struct debug_htt_stats_req {
+	bool done;
+	u8 pdev_id;
+	u8 type;
+	u8 peer_addr[ETH_ALEN];
+	struct completion cmpln;
+	u32 buf_len;
+	u8 buf[0];
+};
+
+#define ATH11K_HTT_STATS_BUF_SIZE (1024 * 512)
+
+#define ATH11K_FW_STATS_BUF_SIZE (1024 * 1024)
+
+#define ATH11K_HTT_PKTLOG_MAX_SIZE 2048
+
+enum ath11k_pktlog_filter {
+	ATH11K_PKTLOG_RX		= 0x000000001,
+	ATH11K_PKTLOG_TX		= 0x000000002,
+	ATH11K_PKTLOG_RCFIND		= 0x000000004,
+	ATH11K_PKTLOG_RCUPDATE		= 0x000000008,
+	ATH11K_PKTLOG_EVENT_SMART_ANT	= 0x000000020,
+	ATH11K_PKTLOG_EVENT_SW		= 0x000000040,
+	ATH11K_PKTLOG_ANY		= 0x00000006f,
+};
+
+enum ath11k_pktlog_mode {
+	ATH11K_PKTLOG_MODE_LITE = 1,
+	ATH11K_PKTLOG_MODE_FULL = 2,
+};
+
+enum ath11k_pktlog_enum {
+	ATH11K_PKTLOG_TYPE_TX_CTRL      = 1,
+	ATH11K_PKTLOG_TYPE_TX_STAT      = 2,
+	ATH11K_PKTLOG_TYPE_TX_MSDU_ID   = 3,
+	ATH11K_PKTLOG_TYPE_RX_STAT      = 5,
+	ATH11K_PKTLOG_TYPE_RC_FIND      = 6,
+	ATH11K_PKTLOG_TYPE_RC_UPDATE    = 7,
+	ATH11K_PKTLOG_TYPE_TX_VIRT_ADDR = 8,
+	ATH11K_PKTLOG_TYPE_RX_CBF       = 10,
+	ATH11K_PKTLOG_TYPE_RX_STATBUF   = 22,
+	ATH11K_PKTLOG_TYPE_PPDU_STATS   = 23,
+	ATH11K_PKTLOG_TYPE_LITE_RX      = 24,
+};
+
+__printf(2, 3) void ath11k_info(struct ath11k_base *ab, const char *fmt, ...);
+__printf(2, 3) void ath11k_err(struct ath11k_base *ab, const char *fmt, ...);
+__printf(2, 3) void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...);
+
+extern unsigned int ath11k_debug_mask;
+
+#ifdef CONFIG_ATH11K_DEBUG
+__printf(3, 4) void __ath11k_dbg(struct ath11k_base *ab,
+				 enum ath11k_debug_mask mask,
+				 const char *fmt, ...);
+void ath11k_dbg_dump(struct ath11k_base *ab,
+		     enum ath11k_debug_mask mask,
+		     const char *msg, const char *prefix,
+		     const void *buf, size_t len);
+#else /* CONFIG_ATH11K_DEBUG */
+static inline int __ath11k_dbg(struct ath11k_base *ab,
+			       enum ath11k_debug_mask dbg_mask,
+			       const char *fmt, ...)
+{
+	return 0;
+}
+
+static inline void ath11k_dbg_dump(struct ath11k_base *ab,
+				   enum ath11k_debug_mask mask,
+				   const char *msg, const char *prefix,
+				   const void *buf, size_t len)
+{
+}
+#endif /* CONFIG_ATH11K_DEBUG */
+
+#ifdef CONFIG_ATH11K_DEBUGFS
+int ath11k_debug_soc_create(struct ath11k_base *ab);
+void ath11k_debug_soc_destroy(struct ath11k_base *ab);
+int ath11k_debug_register(struct ath11k *ar);
+void ath11k_debug_unregister(struct ath11k *ar);
+void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
+				      struct sk_buff *skb);
+void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
+
+void ath11k_debug_fw_stats_init(struct ath11k *ar);
+int ath11k_dbg_htt_stats_req(struct ath11k *ar);
+
+static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
+{
+	return (ar->debug.pktlog_mode == ATH11K_PKTLOG_MODE_LITE);
+}
+
+static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
+{
+	return (!ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode);
+}
+
+static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
+{
+	return (ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode &&
+		ether_addr_equal(addr, ar->debug.pktlog_peer_addr));
+}
+
+static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
+{
+	return ar->debug.extd_tx_stats;
+}
+
+static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
+{
+	return ar->debug.extd_rx_stats;
+}
+#else
+static inline int ath11k_debug_soc_create(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_debug_soc_destroy(struct ath11k_base *ab)
+{
+}
+
+static inline int ath11k_debug_register(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline void ath11k_debug_unregister(struct ath11k *ar)
+{
+}
+
+static inline void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
+						    struct sk_buff *skb)
+{
+}
+
+static inline void ath11k_debug_fw_stats_process(struct ath11k_base *ab,
+						 struct sk_buff *skb)
+{
+}
+
+static inline void ath11k_debug_fw_stats_init(struct ath11k *ar)
+{
+}
+
+static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline int ath11k_dbg_htt_stats_req(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
+{
+	return false;
+}
+
+static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
+{
+	return false;
+}
+
+static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
+{
+	return false;
+}
+#endif /* CONFIG_ATH11K_DEBUGFS */
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir);
+void
+ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
+				    struct ath11k_per_peer_tx_stats *peer_stats,
+				    u8 legacy_rate_idx);
+void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
+					       struct sk_buff *msdu,
+					       struct hal_tx_status *ts);
+#else /* !CONFIG_MAC80211_DEBUGFS */
+static inline void
+ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
+				    struct ath11k_per_peer_tx_stats *peer_stats,
+				    u8 legacy_rate_idx)
+{
+}
+
+static inline void
+ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
+					  struct sk_buff *msdu,
+					  struct hal_tx_status *ts)
+{
+}
+
+#endif /* CONFIG_MAC80211_DEBUGFS*/
+
+#define ath11k_dbg(ar, dbg_mask, fmt, ...)			\
+do {								\
+	if (ath11k_debug_mask & dbg_mask)			\
+		__ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#endif /* _ATH11K_DEBUG_H_ */

