Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0B26CA4A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 21:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgIPTxq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 15:53:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50292 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgIPTxX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 15:53:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600285973; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UOjv8Pu321v5rHlt3/apZ1rkVWQh9GQcaKgSoETxdWo=; b=sIkV2kZ95XqDWgPna16Fcn2OP4iZDP/sxpvcLTmObzngi5SVcA6l5dI8WAaaGTtzyxLg8LDI
 aYbEbtTS2ja0u2xyAe5GP71GmDT2/IRPTGDzQHCPWcfyCbsGTJsp8LTCJCrC3fbP3E+mDh9i
 i0hWXMgRxDIjh+skfNe5L65nPfU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f62196e8c5513c18272a6b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 13:55:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A228C433CA; Wed, 16 Sep 2020 13:55:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3242C433F1;
        Wed, 16 Sep 2020 13:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3242C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] ath11k: rename debug_htt_stats.[c|h] to debugfs_htt_stats.[c|h]
Date:   Wed, 16 Sep 2020 16:55:22 +0300
Message-Id: <1600264523-12939-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
References: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For consistency with debugfs.c rename debug_htt_stats files and functions to
debugfs_htt_stats.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Makefile           |    2 +-
 drivers/net/wireless/ath/ath11k/debug_htt_stats.c  | 4598 --------------------
 drivers/net/wireless/ath/ath11k/debug_htt_stats.h  | 1690 -------
 drivers/net/wireless/ath/ath11k/debugfs.c          |    4 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    | 4598 ++++++++++++++++++++
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    | 1690 +++++++
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |    2 +-
 7 files changed, 6292 insertions(+), 6292 deletions(-)
 delete mode 100644 drivers/net/wireless/ath/ath11k/debug_htt_stats.c
 delete mode 100644 drivers/net/wireless/ath/ath11k/debug_htt_stats.h
 create mode 100644 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
 create mode 100644 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index bb57d0e2dd9f..c41d87bd025a 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -18,7 +18,7 @@ ath11k-y += core.o \
 	    dbring.o \
 	    hw.o
 
-ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debug_htt_stats.o debugfs_sta.o
+ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
deleted file mode 100644
index ad3f08a5b031..000000000000
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
+++ /dev/null
@@ -1,4598 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause-Clear
-/*
- * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- */
-
-#include <linux/vmalloc.h>
-#include "core.h"
-#include "dp_tx.h"
-#include "dp_rx.h"
-#include "debug.h"
-#include "debug_htt_stats.h"
-
-#define HTT_DBG_OUT(buf, len, fmt, ...) \
-			scnprintf(buf, len, fmt "\n", ##__VA_ARGS__)
-
-#define HTT_MAX_STRING_LEN 256
-#define HTT_MAX_PRINT_CHAR_PER_ELEM 15
-
-#define HTT_TLV_HDR_LEN 4
-
-#define ARRAY_TO_STRING(out, arr, len)							\
-	do {										\
-		int index = 0; u8 i;							\
-		for (i = 0; i < len; i++) {						\
-			index += scnprintf(out + index, HTT_MAX_STRING_LEN - index,	\
-					  " %u:%u,", i, arr[i]);			\
-			if (index < 0 || index >= HTT_MAX_STRING_LEN)			\
-				break;							\
-		}									\
-	} while (0)
-
-static inline void htt_print_stats_string_tlv(const void *tag_buf,
-					      u16 tag_len,
-					      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_stats_string_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u8  i;
-	u16 index = 0;
-	char data[HTT_MAX_STRING_LEN] = {0};
-
-	tag_len = tag_len >> 2;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:");
-
-	for (i = 0; i < tag_len; i++) {
-		index += scnprintf(&data[index],
-				HTT_MAX_STRING_LEN - index,
-				"%.*s", 4, (char *)&(htt_stats_buf->data[i]));
-		if (index >= HTT_MAX_STRING_LEN)
-			break;
-	}
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "data = %s\n", data);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf,
-						   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_queued = %u",
-			   htt_stats_buf->hw_queued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_reaped = %u",
-			   htt_stats_buf->hw_reaped);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun = %u",
-			   htt_stats_buf->underrun);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_paused = %u",
-			   htt_stats_buf->hw_paused);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_flush = %u",
-			   htt_stats_buf->hw_flush);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_filt = %u",
-			   htt_stats_buf->hw_filt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort = %u",
-			   htt_stats_buf->tx_abort);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_requeued = %u",
-			   htt_stats_buf->mpdu_requed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_xretry = %u",
-			   htt_stats_buf->tx_xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "data_rc = %u",
-			   htt_stats_buf->data_rc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_dropped_xretry = %u",
-			   htt_stats_buf->mpdu_dropped_xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "illegal_rate_phy_err = %u",
-			   htt_stats_buf->illgl_rate_phy_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cont_xretry = %u",
-			   htt_stats_buf->cont_xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_timeout = %u",
-			   htt_stats_buf->tx_timeout);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_resets = %u",
-			   htt_stats_buf->pdev_resets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_underrun = %u",
-			   htt_stats_buf->phy_underrun);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_ovf = %u",
-			   htt_stats_buf->txop_ovf);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_posted = %u",
-			   htt_stats_buf->seq_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_failed_queueing = %u",
-			   htt_stats_buf->seq_failed_queueing);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_completed = %u",
-			   htt_stats_buf->seq_completed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_restarted = %u",
-			   htt_stats_buf->seq_restarted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_seq_posted = %u",
-			   htt_stats_buf->mu_seq_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_switch_hw_paused = %u",
-			   htt_stats_buf->seq_switch_hw_paused);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "next_seq_posted_dsr = %u",
-			   htt_stats_buf->next_seq_posted_dsr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_posted_isr = %u",
-			   htt_stats_buf->seq_posted_isr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_ctrl_cached = %u",
-			   htt_stats_buf->seq_ctrl_cached);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_count_tqm = %u",
-			   htt_stats_buf->mpdu_count_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_count_tqm = %u",
-			   htt_stats_buf->msdu_count_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_removed_tqm = %u",
-			   htt_stats_buf->mpdu_removed_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_removed_tqm = %u",
-			   htt_stats_buf->msdu_removed_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_sw_flush = %u",
-			   htt_stats_buf->mpdus_sw_flush);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_hw_filter = %u",
-			   htt_stats_buf->mpdus_hw_filter);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_truncated = %u",
-			   htt_stats_buf->mpdus_truncated);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_ack_failed = %u",
-			   htt_stats_buf->mpdus_ack_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_expired = %u",
-			   htt_stats_buf->mpdus_expired);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_seq_hw_retry = %u",
-			   htt_stats_buf->mpdus_seq_hw_retry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
-			   htt_stats_buf->ack_tlv_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "coex_abort_mpdu_cnt_valid = %u",
-			   htt_stats_buf->coex_abort_mpdu_cnt_valid);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "coex_abort_mpdu_cnt = %u",
-			   htt_stats_buf->coex_abort_mpdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_total_ppdus_tried_ota = %u",
-			   htt_stats_buf->num_total_ppdus_tried_ota);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_tried_ota = %u",
-			   htt_stats_buf->num_data_ppdus_tried_ota);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_ctrl_mgmt_enqued = %u",
-			   htt_stats_buf->local_ctrl_mgmt_enqued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_ctrl_mgmt_freed = %u",
-			   htt_stats_buf->local_ctrl_mgmt_freed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_data_enqued = %u",
-			   htt_stats_buf->local_data_enqued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_data_freed = %u",
-			   htt_stats_buf->local_data_freed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_tried = %u",
-			   htt_stats_buf->mpdu_tried);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "isr_wait_seq_posted = %u",
-			   htt_stats_buf->isr_wait_seq_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_active_dur_us_low = %u",
-			   htt_stats_buf->tx_active_dur_us_low);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_active_dur_us_high = %u\n",
-			   htt_stats_buf->tx_active_dur_us_high);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_urrn_tlv_v(const void *tag_buf,
-				   u16 tag_len,
-				   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_urrn_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char urrn_stats[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_URRN_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_URRN_TLV_V:");
-
-	ARRAY_TO_STRING(urrn_stats, htt_stats_buf->urrn_stats, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "urrn_stats = %s\n", urrn_stats);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_flush_tlv_v(const void *tag_buf,
-				    u16 tag_len,
-				    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_flush_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char flush_errs[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_FLUSH_REASON_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_FLUSH_TLV_V:");
-
-	ARRAY_TO_STRING(flush_errs, htt_stats_buf->flush_errs, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_errs = %s\n", flush_errs);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_sifs_tlv_v(const void *tag_buf,
-				   u16 tag_len,
-				   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_sifs_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sifs_status[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_SIFS_TLV_V:");
-
-	ARRAY_TO_STRING(sifs_status, htt_stats_buf->sifs_status, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_status = %s\n",
-			   sifs_status);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_phy_err_tlv_v(const void *tag_buf,
-				      u16 tag_len,
-				      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_phy_err_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char phy_errs[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_PHY_ERR_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_PHY_ERR_TLV_V:");
-
-	ARRAY_TO_STRING(phy_errs, htt_stats_buf->phy_errs, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_sifs_hist_tlv_v(const void *tag_buf,
-					u16 tag_len,
-					struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_sifs_hist_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sifs_hist_status[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_SIFS_HIST_TLV_V:");
-
-	ARRAY_TO_STRING(sifs_hist_status, htt_stats_buf->sifs_hist_status, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_hist_status = %s\n",
-			   sifs_hist_status);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_tx_ppdu_stats_tlv_v(const void *tag_buf,
-					    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_tx_ppdu_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_TX_PPDU_STATS_TLV_V:");
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_legacy_su = %u",
-			   htt_stats_buf->num_data_ppdus_legacy_su);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ac_su = %u",
-			   htt_stats_buf->num_data_ppdus_ac_su);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ax_su = %u",
-			   htt_stats_buf->num_data_ppdus_ax_su);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ac_su_txbf = %u",
-			   htt_stats_buf->num_data_ppdus_ac_su_txbf);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ax_su_txbf = %u\n",
-			   htt_stats_buf->num_data_ppdus_ax_su_txbf);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
-						  u16 tag_len,
-						  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tried_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
-	u32  num_elements = ((tag_len - sizeof(htt_stats_buf->hist_bin_size)) >> 2);
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_TRIED_MPDU_CNT_HIST_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u",
-			   htt_stats_buf->hist_bin_size);
-
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(tried_mpdu_cnt_hist,
-				htt_stats_buf->tried_mpdu_cnt_hist,
-				num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "tried_mpdu_cnt_hist = %s\n",
-				   tried_mpdu_cnt_hist);
-	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER\n");
-	}
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_hw_stats_intr_misc_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_hw_stats_intr_misc_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN + 1] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_INTR_MISC_TLV:");
-	memcpy(hw_intr_name, &(htt_stats_buf->hw_intr_name[0]),
-	       HTT_STATS_MAX_HW_INTR_NAME_LEN);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_intr_name = %s ", hw_intr_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mask = %u",
-			   htt_stats_buf->mask);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
-			   htt_stats_buf->count);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_hw_stats_wd_timeout_tlv(const void *tag_buf,
-				  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_hw_stats_wd_timeout_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN + 1] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_WD_TIMEOUT_TLV:");
-	memcpy(hw_module_name, &(htt_stats_buf->hw_module_name[0]),
-	       HTT_STATS_MAX_HW_MODULE_NAME_LEN);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_module_name = %s ",
-			   hw_module_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u",
-			   htt_stats_buf->count);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_hw_stats_pdev_errs_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_hw_stats_pdev_errs_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_PDEV_ERRS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort = %u",
-			   htt_stats_buf->tx_abort);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort_fail_count = %u",
-			   htt_stats_buf->tx_abort_fail_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_abort = %u",
-			   htt_stats_buf->rx_abort);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_abort_fail_count = %u",
-			   htt_stats_buf->rx_abort_fail_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "warm_reset = %u",
-			   htt_stats_buf->warm_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cold_reset = %u",
-			   htt_stats_buf->cold_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_flush = %u",
-			   htt_stats_buf->tx_flush);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_glb_reset = %u",
-			   htt_stats_buf->tx_glb_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_txq_reset = %u",
-			   htt_stats_buf->tx_txq_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_timeout_reset = %u\n",
-			   htt_stats_buf->rx_timeout_reset);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_msdu_flow_stats_tlv(const void *tag_buf,
-						 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_msdu_flow_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_MSDU_FLOW_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_update_timestamp = %u",
-			   htt_stats_buf->last_update_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_add_timestamp = %u",
-			   htt_stats_buf->last_add_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_remove_timestamp = %u",
-			   htt_stats_buf->last_remove_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_processed_msdu_count = %u",
-			   htt_stats_buf->total_processed_msdu_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cur_msdu_count_in_flowq = %u",
-			   htt_stats_buf->cur_msdu_count_in_flowq);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_flow_no = %u",
-			   htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xF0000) >>
-			   16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "drop_rule = %u",
-			   (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0x100000) >>
-			   20);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_enqueue_count = %u",
-			   htt_stats_buf->last_cycle_enqueue_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_dequeue_count = %u",
-			   htt_stats_buf->last_cycle_dequeue_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_drop_count = %u",
-			   htt_stats_buf->last_cycle_drop_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_drop_th = %u\n",
-			   htt_stats_buf->current_drop_th);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_tid_stats_tlv(const void *tag_buf,
-					      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tid_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TID_STATS_TLV:");
-	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sched_pending = %u",
-			   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ppdu_in_hwq = %u",
-			   (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
-			   0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_flags = 0x%x",
-			   htt_stats_buf->tid_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_queued = %u",
-			   htt_stats_buf->hw_queued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_reaped = %u",
-			   htt_stats_buf->hw_reaped);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_hw_filter = %u",
-			   htt_stats_buf->mpdus_hw_filter);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_bytes = %u",
-			   htt_stats_buf->qdepth_bytes);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_msdu = %u",
-			   htt_stats_buf->qdepth_num_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_mpdu = %u",
-			   htt_stats_buf->qdepth_num_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_scheduled_tsmp = %u",
-			   htt_stats_buf->last_scheduled_tsmp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_module_id = %u",
-			   htt_stats_buf->pause_module_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_module_id = %u\n",
-			   htt_stats_buf->block_module_id);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_tid_stats_v1_tlv(const void *tag_buf,
-						 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tid_stats_v1_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TID_STATS_V1_TLV:");
-	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sched_pending = %u",
-			   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ppdu_in_hwq = %u",
-			   (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
-			   0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_flags = 0x%x",
-			   htt_stats_buf->tid_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_qdepth_bytes = %u",
-			   htt_stats_buf->max_qdepth_bytes);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_qdepth_n_msdus = %u",
-			   htt_stats_buf->max_qdepth_n_msdus);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rsvd = %u",
-			   htt_stats_buf->rsvd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_bytes = %u",
-			   htt_stats_buf->qdepth_bytes);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_msdu = %u",
-			   htt_stats_buf->qdepth_num_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_mpdu = %u",
-			   htt_stats_buf->qdepth_num_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_scheduled_tsmp = %u",
-			   htt_stats_buf->last_scheduled_tsmp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_module_id = %u",
-			   htt_stats_buf->pause_module_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_module_id = %u",
-			   htt_stats_buf->block_module_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "allow_n_flags = 0x%x",
-			   htt_stats_buf->allow_n_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sendn_frms_allowed = %u\n",
-			   htt_stats_buf->sendn_frms_allowed);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_rx_tid_stats_tlv(const void *tag_buf,
-					      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_tid_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_TID_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_in_reorder = %u",
-			   htt_stats_buf->dup_in_reorder);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_past_outside_window = %u",
-			   htt_stats_buf->dup_past_outside_window);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_past_within_window = %u",
-			   htt_stats_buf->dup_past_within_window);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdesc_err_decrypt = %u\n",
-			   htt_stats_buf->rxdesc_err_decrypt);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_counter_tlv(const void *tag_buf,
-					 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_counter_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char counter_name[HTT_MAX_STRING_LEN] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_COUNTER_TLV:");
-
-	ARRAY_TO_STRING(counter_name,
-			htt_stats_buf->counter_name,
-			HTT_MAX_COUNTER_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "counter_name = %s ", counter_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
-			   htt_stats_buf->count);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_peer_stats_cmn_tlv(const void *tag_buf,
-						struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_peer_stats_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PEER_STATS_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ppdu_cnt = %u",
-			   htt_stats_buf->ppdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt = %u",
-			   htt_stats_buf->mpdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_cnt = %u",
-			   htt_stats_buf->msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_bitmap = %u",
-			   htt_stats_buf->pause_bitmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_bitmap = %u",
-			   htt_stats_buf->block_bitmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_rssi = %d",
-			   htt_stats_buf->rssi);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueued_count = %llu",
-			   htt_stats_buf->peer_enqueued_count_low |
-			   ((u64)htt_stats_buf->peer_enqueued_count_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dequeued_count = %llu",
-			   htt_stats_buf->peer_dequeued_count_low |
-			   ((u64)htt_stats_buf->peer_dequeued_count_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dropped_count = %llu",
-			   htt_stats_buf->peer_dropped_count_low |
-			   ((u64)htt_stats_buf->peer_dropped_count_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "transmitted_ppdu_bytes = %llu",
-			   htt_stats_buf->ppdu_transmitted_bytes_low |
-			   ((u64)htt_stats_buf->ppdu_transmitted_bytes_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ttl_removed_count = %u",
-			   htt_stats_buf->peer_ttl_removed_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "inactive_time = %u\n",
-			   htt_stats_buf->inactive_time);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_peer_details_tlv(const void *tag_buf,
-					      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_peer_details_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PEER_DETAILS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_type = %u",
-			   htt_stats_buf->peer_type);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "vdev_id = %u",
-			   htt_stats_buf->vdev_pdev_ast_idx & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
-			   (htt_stats_buf->vdev_pdev_ast_idx & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ast_idx = %u",
-			   (htt_stats_buf->vdev_pdev_ast_idx & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "mac_addr = %02x:%02x:%02x:%02x:%02x:%02x",
-			   htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF,
-			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF00) >> 8,
-			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF0000) >> 16,
-			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF000000) >> 24,
-			   (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF),
-			   (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_flags = 0x%x",
-			   htt_stats_buf->peer_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qpeer_flags = 0x%x\n",
-			   htt_stats_buf->qpeer_flags);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_peer_rate_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-	char *tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
-	u8 j;
-
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		tx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!tx_gi[j])
-			goto fail;
-	}
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PEER_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_ldpc = %u",
-			   htt_stats_buf->tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_rssi = %u",
-			   htt_stats_buf->ack_rssi);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_su_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_su_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mu_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mu_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf,
-			htt_stats_buf->tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf,
-			htt_stats_buf->tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_stbc,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_pream,
-			HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
-
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j],
-				htt_stats_buf->tx_gi[j],
-				HTT_TX_PEER_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
-				j, tx_gi[j]);
-	}
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf,
-			htt_stats_buf->tx_dcm,
-			HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-
-fail:
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++)
-		kfree(tx_gi[j]);
-}
-
-static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_peer_rate_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u8 j;
-	char *rssi_chain[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS] = {NULL};
-	char *rx_gi[HTT_RX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
-		rssi_chain[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rssi_chain[j])
-			goto fail;
-	}
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		rx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rx_gi[j])
-			goto fail;
-	}
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PEER_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "nsts = %u",
-			   htt_stats_buf->nsts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ldpc = %u",
-			   htt_stats_buf->rx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_mgmt = %u",
-			   htt_stats_buf->rssi_mgmt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_data = %u",
-			   htt_stats_buf->rssi_data);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_comb = %u",
-			   htt_stats_buf->rssi_comb);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_mcs,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_nss,
-			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_dcm,
-			HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_stbc,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_bw,
-			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
-		ARRAY_TO_STRING(rssi_chain[j], htt_stats_buf->rssi_chain[j],
-				HTT_RX_PEER_STATS_NUM_BW_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
-				   j, rssi_chain[j]);
-	}
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->rx_gi[j],
-				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
-				j, rx_gi[j]);
-	}
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_pream,
-			HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s\n", str_buf);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-
-fail:
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++)
-		kfree(rssi_chain[j]);
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++)
-		kfree(rx_gi[j]);
-}
-
-static inline void
-htt_print_tx_hwq_mu_mimo_sch_stats_tlv(const void *tag_buf,
-				       struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_mu_mimo_sch_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_SCH_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_posted = %u",
-			   htt_stats_buf->mu_mimo_sch_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_failed = %u",
-			   htt_stats_buf->mu_mimo_sch_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n",
-			   htt_stats_buf->mu_mimo_ppdu_posted);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_mu_mimo_mpdu_stats_tlv(const void *tag_buf,
-					struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_mu_mimo_mpdu_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_MU_MIMO_MPDU_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_queued_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_queued_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_tried_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_tried_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_failed_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_failed_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_requeued_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_requeued_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_err_no_ba_usr = %u",
-			   htt_stats_buf->mu_mimo_err_no_ba_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdu_underrun_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdu_underrun_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ampdu_underrun_usr = %u\n",
-			   htt_stats_buf->mu_mimo_ampdu_underrun_usr);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_mu_mimo_cmn_stats_tlv(const void *tag_buf,
-				       struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_mu_mimo_cmn_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__hwq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwq_id = %u\n",
-			   (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_stats_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	/* TODO: HKDBG */
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__hwq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwq_id = %u",
-			   (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "xretry = %u",
-			   htt_stats_buf->xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun_cnt = %u",
-			   htt_stats_buf->underrun_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cnt = %u",
-			   htt_stats_buf->flush_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "filt_cnt = %u",
-			   htt_stats_buf->filt_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "null_mpdu_bmap = %u",
-			   htt_stats_buf->null_mpdu_bmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "user_ack_failure = %u",
-			   htt_stats_buf->user_ack_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
-			   htt_stats_buf->ack_tlv_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_id_proc = %u",
-			   htt_stats_buf->sched_id_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "null_mpdu_tx_count = %u",
-			   htt_stats_buf->null_mpdu_tx_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_bmap_not_recvd = %u",
-			   htt_stats_buf->mpdu_bmap_not_recvd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_bar = %u",
-			   htt_stats_buf->num_bar);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts = %u",
-			   htt_stats_buf->rts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cts2self = %u",
-			   htt_stats_buf->cts2self);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_null = %u",
-			   htt_stats_buf->qos_null);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_tried_cnt = %u",
-			   htt_stats_buf->mpdu_tried_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queued_cnt = %u",
-			   htt_stats_buf->mpdu_queued_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_ack_fail_cnt = %u",
-			   htt_stats_buf->mpdu_ack_fail_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_filt_cnt = %u",
-			   htt_stats_buf->mpdu_filt_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "false_mpdu_ack_count = %u",
-			   htt_stats_buf->false_mpdu_ack_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txq_timeout = %u\n",
-			   htt_stats_buf->txq_timeout);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_difs_latency_stats_tlv_v(const void *tag_buf,
-					  u16 tag_len,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_difs_latency_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u16 data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS);
-	char difs_latency_hist[HTT_MAX_STRING_LEN] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_DIFS_LATENCY_STATS_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hist_intvl = %u",
-			htt_stats_buf->hist_intvl);
-
-	ARRAY_TO_STRING(difs_latency_hist, htt_stats_buf->difs_latency_hist,
-			data_len);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "difs_latency_hist = %s\n",
-			difs_latency_hist);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_cmd_result_stats_tlv_v(const void *tag_buf,
-					u16 tag_len,
-					struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_cmd_result_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u16 data_len;
-	char cmd_result[HTT_MAX_STRING_LEN] = {0};
-
-	data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_RESULT_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_CMD_RESULT_STATS_TLV_V:");
-
-	ARRAY_TO_STRING(cmd_result, htt_stats_buf->cmd_result, data_len);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_result = %s\n", cmd_result);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_cmd_stall_stats_tlv_v(const void *tag_buf,
-				       u16 tag_len,
-				       struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_cmd_stall_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u16 num_elems;
-	char cmd_stall_status[HTT_MAX_STRING_LEN] = {0};
-
-	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_STALL_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_CMD_STALL_STATS_TLV_V:");
-
-	ARRAY_TO_STRING(cmd_stall_status, htt_stats_buf->cmd_stall_status, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_stall_status = %s\n",
-			   cmd_stall_status);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_fes_result_stats_tlv_v(const void *tag_buf,
-					u16 tag_len,
-					struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_fes_result_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u16 num_elems;
-	char fes_result[HTT_MAX_STRING_LEN] = {0};
-
-	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_FES_RESULT_STATS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_FES_RESULT_STATS_TLV_V:");
-
-	ARRAY_TO_STRING(fes_result, htt_stats_buf->fes_result, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fes_result = %s\n", fes_result);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
-					   u16 tag_len,
-					   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_tried_mpdu_cnt_hist_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tried_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
-	u32  num_elements = ((tag_len -
-			    sizeof(htt_stats_buf->hist_bin_size)) >> 2);
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_TRIED_MPDU_CNT_HIST_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u",
-			   htt_stats_buf->hist_bin_size);
-
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(tried_mpdu_cnt_hist,
-				htt_stats_buf->tried_mpdu_cnt_hist,
-				num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "tried_mpdu_cnt_hist = %s\n",
-				   tried_mpdu_cnt_hist);
-	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER ");
-	}
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(const void *tag_buf,
-					  u16 tag_len,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_hwq_txop_used_cnt_hist_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char txop_used_cnt_hist[HTT_MAX_STRING_LEN] = {0};
-	u32 num_elements = tag_len >> 2;
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_TXOP_USED_CNT_HIST_TLV_V:");
-
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(txop_used_cnt_hist,
-				htt_stats_buf->txop_used_cnt_hist,
-				num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_used_cnt_hist = %s\n",
-				   txop_used_cnt_hist);
-	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER ");
-	}
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_sounding_stats_tlv(const void *tag_buf,
-						   struct debug_htt_stats_req *stats_req)
-{
-	s32 i;
-	const struct htt_tx_sounding_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	const u32 *cbf_20 = htt_stats_buf->cbf_20;
-	const u32 *cbf_40 = htt_stats_buf->cbf_40;
-	const u32 *cbf_80 = htt_stats_buf->cbf_80;
-	const u32 *cbf_160 = htt_stats_buf->cbf_160;
-
-	if (htt_stats_buf->tx_sounding_mode == HTT_TX_AC_SOUNDING_MODE) {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "\nHTT_TX_AC_SOUNDING_STATS_TLV:\n");
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u ",
-				   cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-
-		for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS; i++) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u ",
-					   i,
-					   htt_stats_buf->sounding[0],
-					   htt_stats_buf->sounding[1],
-					   htt_stats_buf->sounding[2],
-					   htt_stats_buf->sounding[3]);
-		}
-	} else if (htt_stats_buf->tx_sounding_mode == HTT_TX_AX_SOUNDING_MODE) {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "\nHTT_TX_AX_SOUNDING_STATS_TLV:\n");
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u ",
-				   cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-
-		for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS; i++) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u ",
-					   i,
-					   htt_stats_buf->sounding[0],
-					   htt_stats_buf->sounding[1],
-					   htt_stats_buf->sounding[2],
-					   htt_stats_buf->sounding[3]);
-		}
-	}
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_selfgen_cmn_stats_tlv(const void *tag_buf,
-				   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_selfgen_cmn_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "su_bar = %u",
-			   htt_stats_buf->su_bar);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts = %u",
-			   htt_stats_buf->rts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cts2self = %u",
-			   htt_stats_buf->cts2self);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_null = %u",
-			   htt_stats_buf->qos_null);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_1 = %u",
-			   htt_stats_buf->delayed_bar_1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_2 = %u",
-			   htt_stats_buf->delayed_bar_2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_3 = %u",
-			   htt_stats_buf->delayed_bar_3);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_4 = %u",
-			   htt_stats_buf->delayed_bar_4);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_5 = %u",
-			   htt_stats_buf->delayed_bar_5);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_6 = %u",
-			   htt_stats_buf->delayed_bar_6);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_7 = %u\n",
-			   htt_stats_buf->delayed_bar_7);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf,
-				  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_selfgen_ac_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndpa = %u",
-			   htt_stats_buf->ac_su_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndp = %u",
-			   htt_stats_buf->ac_su_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndpa = %u",
-			   htt_stats_buf->ac_mu_mimo_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndp = %u",
-			   htt_stats_buf->ac_mu_mimo_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_1 = %u",
-			   htt_stats_buf->ac_mu_mimo_brpoll_1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_2 = %u",
-			   htt_stats_buf->ac_mu_mimo_brpoll_2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_3 = %u\n",
-			   htt_stats_buf->ac_mu_mimo_brpoll_3);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf,
-				  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_selfgen_ax_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndpa = %u",
-			   htt_stats_buf->ax_su_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndp = %u",
-			   htt_stats_buf->ax_su_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndpa = %u",
-			   htt_stats_buf->ax_mu_mimo_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndp = %u",
-			   htt_stats_buf->ax_mu_mimo_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_1 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_2 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_3 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_3);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_4 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_4);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_5 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_5);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_6 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_6);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_7 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_7);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_basic_trigger = %u",
-			   htt_stats_buf->ax_basic_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_bsr_trigger = %u",
-			   htt_stats_buf->ax_bsr_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_bar_trigger = %u",
-			   htt_stats_buf->ax_mu_bar_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_rts_trigger = %u\n",
-			   htt_stats_buf->ax_mu_rts_trigger);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_selfgen_ac_err_stats_tlv(const void *tag_buf,
-				      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_selfgen_ac_err_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_ERR_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndp_err = %u",
-			   htt_stats_buf->ac_su_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndpa_err = %u",
-			   htt_stats_buf->ac_su_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndpa_err = %u",
-			   htt_stats_buf->ac_mu_mimo_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndp_err = %u",
-			   htt_stats_buf->ac_mu_mimo_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp1_err = %u",
-			   htt_stats_buf->ac_mu_mimo_brp1_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp2_err = %u",
-			   htt_stats_buf->ac_mu_mimo_brp2_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp3_err = %u\n",
-			   htt_stats_buf->ac_mu_mimo_brp3_err);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_selfgen_ax_err_stats_tlv(const void *tag_buf,
-				      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_selfgen_ax_err_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_ERR_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndp_err = %u",
-			   htt_stats_buf->ax_su_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndpa_err = %u",
-			   htt_stats_buf->ax_su_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndpa_err = %u",
-			   htt_stats_buf->ax_mu_mimo_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndp_err = %u",
-			   htt_stats_buf->ax_mu_mimo_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp1_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp1_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp2_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp2_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp3_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp3_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp4_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp4_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp5_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp5_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp6_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp6_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp7_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp7_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_basic_trigger_err = %u",
-			   htt_stats_buf->ax_basic_trigger_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_bsr_trigger_err = %u",
-			   htt_stats_buf->ax_bsr_trigger_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_bar_trigger_err = %u",
-			   htt_stats_buf->ax_mu_bar_trigger_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_rts_trigger_err = %u\n",
-			   htt_stats_buf->ax_mu_rts_trigger_err);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_mu_mimo_sch_stats_tlv(const void *tag_buf,
-					struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_mu_mimo_sch_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u8 i;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_MU_MIMO_SCH_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_posted = %u",
-			   htt_stats_buf->mu_mimo_sch_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_failed = %u",
-			   htt_stats_buf->mu_mimo_sch_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n",
-			   htt_stats_buf->mu_mimo_ppdu_posted);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "11ac MU_MIMO SCH STATS:");
-
-	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_mu_mimo_sch_nusers_%u = %u",
-				   i, htt_stats_buf->ac_mu_mimo_sch_nusers[i]);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n11ax MU_MIMO SCH STATS:");
-
-	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_mu_mimo_sch_nusers_%u = %u",
-				   i, htt_stats_buf->ax_mu_mimo_sch_nusers[i]);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n11ax OFDMA SCH STATS:");
-
-	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_ofdma_sch_nusers_%u = %u",
-				   i, htt_stats_buf->ax_ofdma_sch_nusers[i]);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(const void *tag_buf,
-					 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_mpdu_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_MIMO_AC) {
-		if (!htt_stats_buf->user_index)
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "HTT_TX_PDEV_MU_MIMO_AC_MPDU_STATS:\n");
-
-		if (htt_stats_buf->user_index <
-		    HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_queued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_queued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_tried_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_tried_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_failed_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_failed_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_requeued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_requeued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_err_no_ba_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->err_no_ba_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdu_underrun_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdu_underrun_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_ampdu_underrun_usr_%u = %u\n",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->ampdu_underrun_usr);
-		}
-	}
-
-	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_MIMO_AX) {
-		if (!htt_stats_buf->user_index)
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "HTT_TX_PDEV_MU_MIMO_AX_MPDU_STATS:\n");
-
-		if (htt_stats_buf->user_index <
-		    HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_queued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_queued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_tried_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_tried_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_failed_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_failed_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_requeued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_requeued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_err_no_ba_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->err_no_ba_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdu_underrun_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdu_underrun_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_ampdu_underrun_usr_%u = %u\n",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->ampdu_underrun_usr);
-		}
-	}
-
-	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_OFDMA_AX) {
-		if (!htt_stats_buf->user_index)
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "HTT_TX_PDEV_AX_MU_OFDMA_MPDU_STATS:\n");
-
-		if (htt_stats_buf->user_index < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_queued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_queued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_tried_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_tried_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_failed_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_failed_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_requeued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_requeued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_err_no_ba_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->err_no_ba_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdu_underrun_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdu_underrun_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_ampdu_underrun_usr_%u = %u\n",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->ampdu_underrun_usr);
-		}
-	}
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_sched_txq_cmd_posted_tlv_v(const void *tag_buf,
-				     u16 tag_len,
-				     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sched_txq_cmd_posted_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_cmd_posted[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV_V:");
-
-	ARRAY_TO_STRING(sched_cmd_posted, htt_stats_buf->sched_cmd_posted,
-			num_elements);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_posted = %s\n",
-			   sched_cmd_posted);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_sched_txq_cmd_reaped_tlv_v(const void *tag_buf,
-				     u16 tag_len,
-				     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sched_txq_cmd_reaped_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_cmd_reaped[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV_V:");
-
-	ARRAY_TO_STRING(sched_cmd_reaped, htt_stats_buf->sched_cmd_reaped,
-			num_elements);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_reaped = %s\n",
-			   sched_cmd_reaped);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_sched_txq_sched_order_su_tlv_v(const void *tag_buf,
-					 u16 tag_len,
-					 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sched_txq_sched_order_su_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_order_su[HTT_MAX_STRING_LEN] = {0};
-	/* each entry is u32, i.e. 4 bytes */
-	u32 sched_order_su_num_entries =
-		min_t(u32, (tag_len >> 2), HTT_TX_PDEV_NUM_SCHED_ORDER_LOG);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV_V:");
-
-	ARRAY_TO_STRING(sched_order_su, htt_stats_buf->sched_order_su,
-			sched_order_su_num_entries);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_order_su = %s\n",
-			   sched_order_su);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_sched_txq_sched_ineligibility_tlv_v(const void *tag_buf,
-					      u16 tag_len,
-					      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sched_txq_sched_ineligibility_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_ineligibility[HTT_MAX_STRING_LEN] = {0};
-	/* each entry is u32, i.e. 4 bytes */
-	u32 sched_ineligibility_num_entries = tag_len >> 2;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_SCHED_TXQ_SCHED_INELIGIBILITY_V:");
-
-	ARRAY_TO_STRING(sched_ineligibility, htt_stats_buf->sched_ineligibility,
-			sched_ineligibility_num_entries);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_ineligibility = %s\n",
-			   sched_ineligibility);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_pdev_stats_sched_per_txq_tlv(const void *tag_buf,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_stats_sched_per_txq_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__txq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txq_id = %u",
-			   (htt_stats_buf->mac_id__txq_id__word & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_policy = %u",
-			   htt_stats_buf->sched_policy);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "last_sched_cmd_posted_timestamp = %u",
-			   htt_stats_buf->last_sched_cmd_posted_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "last_sched_cmd_compl_timestamp = %u",
-			   htt_stats_buf->last_sched_cmd_compl_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_2_tac_lwm_count = %u",
-			   htt_stats_buf->sched_2_tac_lwm_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_2_tac_ring_full = %u",
-			   htt_stats_buf->sched_2_tac_ring_full);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_post_failure = %u",
-			   htt_stats_buf->sched_cmd_post_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_active_tids = %u",
-			   htt_stats_buf->num_active_tids);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ps_schedules = %u",
-			   htt_stats_buf->num_ps_schedules);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmds_pending = %u",
-			   htt_stats_buf->sched_cmds_pending);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tid_register = %u",
-			   htt_stats_buf->num_tid_register);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tid_unregister = %u",
-			   htt_stats_buf->num_tid_unregister);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_qstats_queried = %u",
-			   htt_stats_buf->num_qstats_queried);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qstats_update_pending = %u",
-			   htt_stats_buf->qstats_update_pending);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_qstats_query_timestamp = %u",
-			   htt_stats_buf->last_qstats_query_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tqm_cmdq_full = %u",
-			   htt_stats_buf->num_tqm_cmdq_full);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_de_sched_algo_trigger = %u",
-			   htt_stats_buf->num_de_sched_algo_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_rt_sched_algo_trigger = %u",
-			   htt_stats_buf->num_rt_sched_algo_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tqm_sched_algo_trigger = %u",
-			   htt_stats_buf->num_tqm_sched_algo_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_sched = %u\n",
-			   htt_stats_buf->notify_sched);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dur_based_sendn_term = %u\n",
-			   htt_stats_buf->dur_based_sendn_term);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_stats_tx_sched_cmn_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_stats_tx_sched_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_TX_SCHED_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_timestamp = %u\n",
-			   htt_stats_buf->current_timestamp);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_tqm_gen_mpdu_stats_tlv_v(const void *tag_buf,
-				      u16 tag_len,
-				      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_gen_mpdu_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char gen_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elements = min_t(u16, (tag_len >> 2),
-				 HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV_V:");
-
-	ARRAY_TO_STRING(gen_mpdu_end_reason, htt_stats_buf->gen_mpdu_end_reason,
-			num_elements);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_end_reason = %s\n",
-			   gen_mpdu_end_reason);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_tqm_list_mpdu_stats_tlv_v(const void *tag_buf,
-				       u16 tag_len,
-				       struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_list_mpdu_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char list_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_TQM_LIST_MPDU_STATS_TLV_V:");
-
-	ARRAY_TO_STRING(list_mpdu_end_reason, htt_stats_buf->list_mpdu_end_reason,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_end_reason = %s\n",
-			   list_mpdu_end_reason);
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_tqm_list_mpdu_cnt_tlv_v(const void *tag_buf,
-				     u16 tag_len,
-				     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_list_mpdu_cnt_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char list_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2),
-			      HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:");
-
-	ARRAY_TO_STRING(list_mpdu_cnt_hist, htt_stats_buf->list_mpdu_cnt_hist,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist = %s\n",
-			   list_mpdu_cnt_hist);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_tqm_pdev_stats_tlv_v(const void *tag_buf,
-				  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_pdev_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_PDEV_STATS_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_count = %u",
-			   htt_stats_buf->msdu_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_count = %u",
-			   htt_stats_buf->mpdu_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu = %u",
-			   htt_stats_buf->remove_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu = %u",
-			   htt_stats_buf->remove_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_ttl = %u",
-			   htt_stats_buf->remove_msdu_ttl);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_bar = %u",
-			   htt_stats_buf->send_bar);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "bar_sync = %u",
-			   htt_stats_buf->bar_sync);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu = %u",
-			   htt_stats_buf->notify_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sync_cmd = %u",
-			   htt_stats_buf->sync_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "write_cmd = %u",
-			   htt_stats_buf->write_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_trigger = %u",
-			   htt_stats_buf->hwsch_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
-			   htt_stats_buf->ack_tlv_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_cmd = %u",
-			   htt_stats_buf->gen_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_list_cmd = %u",
-			   htt_stats_buf->gen_list_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_cmd = %u",
-			   htt_stats_buf->remove_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_tried_cmd = %u",
-			   htt_stats_buf->remove_mpdu_tried_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u",
-			   htt_stats_buf->mpdu_queue_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_head_info_cmd = %u",
-			   htt_stats_buf->mpdu_head_info_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u",
-			   htt_stats_buf->msdu_flow_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_cmd = %u",
-			   htt_stats_buf->remove_msdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_ttl_cmd = %u",
-			   htt_stats_buf->remove_msdu_ttl_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cache_cmd = %u",
-			   htt_stats_buf->flush_cache_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_mpduq_cmd = %u",
-			   htt_stats_buf->update_mpduq_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueue = %u",
-			   htt_stats_buf->enqueue);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueue_notify = %u",
-			   htt_stats_buf->enqueue_notify);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu_at_head = %u",
-			   htt_stats_buf->notify_mpdu_at_head);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu_state_valid = %u",
-			   htt_stats_buf->notify_mpdu_state_valid);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_udp_notify1 = %u",
-			   htt_stats_buf->sched_udp_notify1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_udp_notify2 = %u",
-			   htt_stats_buf->sched_udp_notify2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_nonudp_notify1 = %u",
-			   htt_stats_buf->sched_nonudp_notify1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_nonudp_notify2 = %u\n",
-			   htt_stats_buf->sched_nonudp_notify2);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_tqm_cmn_stats_tlv(const void *tag_buf,
-						  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_cmn_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_cmdq_id = %u",
-			   htt_stats_buf->max_cmdq_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist_intvl = %u",
-			   htt_stats_buf->list_mpdu_cnt_hist_intvl);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "add_msdu = %u",
-			   htt_stats_buf->add_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_empty = %u",
-			   htt_stats_buf->q_empty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_not_empty = %u",
-			   htt_stats_buf->q_not_empty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "drop_notification = %u",
-			   htt_stats_buf->drop_notification);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "desc_threshold = %u\n",
-			   htt_stats_buf->desc_threshold);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_tqm_error_stats_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_error_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_ERROR_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_empty_failure = %u",
-			   htt_stats_buf->q_empty_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_not_empty_failure = %u",
-			   htt_stats_buf->q_not_empty_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "add_msdu_failure = %u\n",
-			   htt_stats_buf->add_msdu_failure);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_tqm_cmdq_status_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_tqm_cmdq_status_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_CMDQ_STATUS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__cmdq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmdq_id = %u\n",
-			   (htt_stats_buf->mac_id__cmdq_id__word & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sync_cmd = %u",
-			   htt_stats_buf->sync_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "write_cmd = %u",
-			   htt_stats_buf->write_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_cmd = %u",
-			   htt_stats_buf->gen_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u",
-			   htt_stats_buf->mpdu_queue_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_head_info_cmd = %u",
-			   htt_stats_buf->mpdu_head_info_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u",
-			   htt_stats_buf->msdu_flow_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_cmd = %u",
-			   htt_stats_buf->remove_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_cmd = %u",
-			   htt_stats_buf->remove_msdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cache_cmd = %u",
-			   htt_stats_buf->flush_cache_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_mpduq_cmd = %u",
-			   htt_stats_buf->update_mpduq_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_msduq_cmd = %u\n",
-			   htt_stats_buf->update_msduq_cmd);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_eapol_packets_stats_tlv(const void *tag_buf,
-					struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_eapol_packets_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m1_packets = %u",
-			   htt_stats_buf->m1_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m2_packets = %u",
-			   htt_stats_buf->m2_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m3_packets = %u",
-			   htt_stats_buf->m3_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m4_packets = %u",
-			   htt_stats_buf->m4_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "g1_packets = %u",
-			   htt_stats_buf->g1_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "g2_packets = %u\n",
-			   htt_stats_buf->g2_packets);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_classify_failed_stats_tlv(const void *tag_buf,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_classify_failed_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ap_bss_peer_not_found = %u",
-			   htt_stats_buf->ap_bss_peer_not_found);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ap_bcast_mcast_no_peer = %u",
-			   htt_stats_buf->ap_bcast_mcast_no_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sta_delete_in_progress = %u",
-			   htt_stats_buf->sta_delete_in_progress);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ibss_no_bss_peer = %u",
-			   htt_stats_buf->ibss_no_bss_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_vdev_type = %u",
-			   htt_stats_buf->invalid_vdev_type);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_ast_peer_entry = %u",
-			   htt_stats_buf->invalid_ast_peer_entry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_entry_invalid = %u",
-			   htt_stats_buf->peer_entry_invalid);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ethertype_not_ip = %u",
-			   htt_stats_buf->ethertype_not_ip);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "eapol_lookup_failed = %u",
-			   htt_stats_buf->eapol_lookup_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qpeer_not_allow_data = %u",
-			   htt_stats_buf->qpeer_not_allow_data);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_tid_override = %u",
-			   htt_stats_buf->fse_tid_override);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ipv6_jumbogram_zero_length = %u",
-			   htt_stats_buf->ipv6_jumbogram_zero_length);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_to_non_qos_in_prog = %u\n",
-			   htt_stats_buf->qos_to_non_qos_in_prog);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_classify_stats_tlv(const void *tag_buf,
-				   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_classify_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_CLASSIFY_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "arp_packets = %u",
-			   htt_stats_buf->arp_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "igmp_packets = %u",
-			   htt_stats_buf->igmp_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dhcp_packets = %u",
-			   htt_stats_buf->dhcp_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_inspected = %u",
-			   htt_stats_buf->host_inspected);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_included = %u",
-			   htt_stats_buf->htt_included);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_mcs = %u",
-			   htt_stats_buf->htt_valid_mcs);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_nss = %u",
-			   htt_stats_buf->htt_valid_nss);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_preamble_type = %u",
-			   htt_stats_buf->htt_valid_preamble_type);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_chainmask = %u",
-			   htt_stats_buf->htt_valid_chainmask);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_guard_interval = %u",
-			   htt_stats_buf->htt_valid_guard_interval);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_retries = %u",
-			   htt_stats_buf->htt_valid_retries);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_bw_info = %u",
-			   htt_stats_buf->htt_valid_bw_info);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_power = %u",
-			   htt_stats_buf->htt_valid_power);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_key_flags = 0x%x",
-			   htt_stats_buf->htt_valid_key_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_no_encryption = %u",
-			   htt_stats_buf->htt_valid_no_encryption);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_entry_count = %u",
-			   htt_stats_buf->fse_entry_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_be = %u",
-			   htt_stats_buf->fse_priority_be);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_high = %u",
-			   htt_stats_buf->fse_priority_high);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_low = %u",
-			   htt_stats_buf->fse_priority_low);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_be = %u",
-			   htt_stats_buf->fse_traffic_ptrn_be);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_over_sub = %u",
-			   htt_stats_buf->fse_traffic_ptrn_over_sub);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_bursty = %u",
-			   htt_stats_buf->fse_traffic_ptrn_bursty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_interactive = %u",
-			   htt_stats_buf->fse_traffic_ptrn_interactive);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_periodic = %u",
-			   htt_stats_buf->fse_traffic_ptrn_periodic);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_alloc = %u",
-			   htt_stats_buf->fse_hwqueue_alloc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_created = %u",
-			   htt_stats_buf->fse_hwqueue_created);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_send_to_host = %u",
-			   htt_stats_buf->fse_hwqueue_send_to_host);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mcast_entry = %u",
-			   htt_stats_buf->mcast_entry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "bcast_entry = %u",
-			   htt_stats_buf->bcast_entry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_update_peer_cache = %u",
-			   htt_stats_buf->htt_update_peer_cache);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_learning_frame = %u",
-			   htt_stats_buf->htt_learning_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_invalid_peer = %u",
-			   htt_stats_buf->fse_invalid_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mec_notify = %u\n",
-			   htt_stats_buf->mec_notify);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_classify_status_stats_tlv(const void *tag_buf,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_classify_status_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "eok = %u",
-			   htt_stats_buf->eok);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "classify_done = %u",
-			   htt_stats_buf->classify_done);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "lookup_failed = %u",
-			   htt_stats_buf->lookup_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_dhcp = %u",
-			   htt_stats_buf->send_host_dhcp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_mcast = %u",
-			   htt_stats_buf->send_host_mcast);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_unknown_dest = %u",
-			   htt_stats_buf->send_host_unknown_dest);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host = %u",
-			   htt_stats_buf->send_host);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "status_invalid = %u\n",
-			   htt_stats_buf->status_invalid);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_enqueue_packets_stats_tlv(const void *tag_buf,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_enqueue_packets_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueued_pkts = %u",
-			htt_stats_buf->enqueued_pkts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "to_tqm = %u",
-			htt_stats_buf->to_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "to_tqm_bypass = %u\n",
-			htt_stats_buf->to_tqm_bypass);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_enqueue_discard_stats_tlv(const void *tag_buf,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_enqueue_discard_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "discarded_pkts = %u",
-			   htt_stats_buf->discarded_pkts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_frames = %u",
-			   htt_stats_buf->local_frames);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "is_ext_msdu = %u\n",
-			   htt_stats_buf->is_ext_msdu);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_de_compl_stats_tlv(const void *tag_buf,
-						   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_compl_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_COMPL_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl_dummy_frame = %u",
-			   htt_stats_buf->tcl_dummy_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_dummy_frame = %u",
-			   htt_stats_buf->tqm_dummy_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_notify_frame = %u",
-			   htt_stats_buf->tqm_notify_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw2wbm_enq = %u",
-			   htt_stats_buf->fw2wbm_enq);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_bypass_frame = %u\n",
-			   htt_stats_buf->tqm_bypass_frame);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_fw2wbm_ring_full_hist_tlv(const void *tag_buf,
-					  u16 tag_len,
-					  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_fw2wbm_ring_full_hist_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw2wbm_ring_full_hist[HTT_MAX_STRING_LEN] = {0};
-	u16  num_elements = tag_len >> 2;
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_FW2WBM_RING_FULL_HIST_TLV");
-
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(fw2wbm_ring_full_hist,
-				htt_stats_buf->fw2wbm_ring_full_hist,
-				num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "fw2wbm_ring_full_hist = %s\n",
-				   fw2wbm_ring_full_hist);
-	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER ");
-	}
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_tx_de_cmn_stats_tlv(const void *tag_buf, struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_de_cmn_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl2fw_entry_count = %u",
-			   htt_stats_buf->tcl2fw_entry_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "not_to_fw = %u",
-			   htt_stats_buf->not_to_fw);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_pdev_vdev_peer = %u",
-			   htt_stats_buf->invalid_pdev_vdev_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl_res_invalid_addrx = %u",
-			   htt_stats_buf->tcl_res_invalid_addrx);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm2fw_entry_count = %u",
-			   htt_stats_buf->wbm2fw_entry_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_pdev = %u\n",
-			   htt_stats_buf->invalid_pdev);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
-					       struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_ring_if_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char low_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
-	char high_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RING_IF_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr = %u",
-			   htt_stats_buf->base_addr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "elem_size = %u",
-			   htt_stats_buf->elem_size);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_elems = %u",
-			   htt_stats_buf->num_elems__prefetch_tail_idx & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "prefetch_tail_idx = %u",
-			   (htt_stats_buf->num_elems__prefetch_tail_idx &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "head_idx = %u",
-			   htt_stats_buf->head_idx__tail_idx & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tail_idx = %u",
-			   (htt_stats_buf->head_idx__tail_idx & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "shadow_head_idx = %u",
-			   htt_stats_buf->shadow_head_idx__shadow_tail_idx & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "shadow_tail_idx = %u",
-			   (htt_stats_buf->shadow_head_idx__shadow_tail_idx &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tail_incr = %u",
-			   htt_stats_buf->num_tail_incr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "lwm_thresh = %u",
-			   htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwm_thresh = %u",
-			   (htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "overrun_hit_count = %u",
-			   htt_stats_buf->overrun_hit_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun_hit_count = %u",
-			   htt_stats_buf->underrun_hit_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "prod_blockwait_count = %u",
-			   htt_stats_buf->prod_blockwait_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cons_blockwait_count = %u",
-			   htt_stats_buf->cons_blockwait_count);
-
-	ARRAY_TO_STRING(low_wm_hit_count, htt_stats_buf->low_wm_hit_count,
-			HTT_STATS_LOW_WM_BINS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "low_wm_hit_count = %s ",
-			   low_wm_hit_count);
-
-	ARRAY_TO_STRING(high_wm_hit_count, htt_stats_buf->high_wm_hit_count,
-			HTT_STATS_HIGH_WM_BINS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "high_wm_hit_count = %s\n",
-			   high_wm_hit_count);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_ring_if_cmn_tlv(const void *tag_buf,
-					     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_ring_if_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RING_IF_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
-			   htt_stats_buf->num_records);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_sfm_client_user_tlv_v(const void *tag_buf,
-						   u16 tag_len,
-						   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sfm_client_user_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char dwords_used_by_user_n[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = tag_len >> 2;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV_V:");
-
-	ARRAY_TO_STRING(dwords_used_by_user_n,
-			htt_stats_buf->dwords_used_by_user_n,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dwords_used_by_user_n = %s\n",
-			   dwords_used_by_user_n);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_sfm_client_tlv(const void *tag_buf,
-					    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sfm_client_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "client_id = %u",
-			   htt_stats_buf->client_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_min = %u",
-			   htt_stats_buf->buf_min);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_max = %u",
-			   htt_stats_buf->buf_max);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_busy = %u",
-			   htt_stats_buf->buf_busy);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_alloc = %u",
-			   htt_stats_buf->buf_alloc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_avail = %u",
-			   htt_stats_buf->buf_avail);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_users = %u\n",
-			   htt_stats_buf->num_users);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_sfm_cmn_tlv(const void *tag_buf,
-					 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sfm_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_total = %u",
-			   htt_stats_buf->buf_total);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mem_empty = %u",
-			   htt_stats_buf->mem_empty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "deallocate_bufs = %u",
-			   htt_stats_buf->deallocate_bufs);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
-			   htt_stats_buf->num_records);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_sring_stats_tlv(const void *tag_buf,
-					     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sring_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SRING_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ring_id = %u",
-			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "arena = %u",
-			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ep = %u",
-			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0x1000000) >> 24);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr_lsb = 0x%x",
-			   htt_stats_buf->base_addr_lsb);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr_msb = 0x%x",
-			   htt_stats_buf->base_addr_msb);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ring_size = %u",
-			   htt_stats_buf->ring_size);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "elem_size = %u",
-			   htt_stats_buf->elem_size);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_avail_words = %u",
-			   htt_stats_buf->num_avail_words__num_valid_words & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_valid_words = %u",
-			   (htt_stats_buf->num_avail_words__num_valid_words &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "head_ptr = %u",
-			   htt_stats_buf->head_ptr__tail_ptr & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tail_ptr = %u",
-			   (htt_stats_buf->head_ptr__tail_ptr & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "consumer_empty = %u",
-			   htt_stats_buf->consumer_empty__producer_full & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "producer_full = %u",
-			   (htt_stats_buf->consumer_empty__producer_full &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "prefetch_count = %u",
-			   htt_stats_buf->prefetch_count__internal_tail_ptr & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "internal_tail_ptr = %u\n",
-			   (htt_stats_buf->prefetch_count__internal_tail_ptr &
-			   0xFFFF0000) >> 16);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_sring_cmn_tlv(const void *tag_buf,
-					   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_sring_cmn_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SRING_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
-			   htt_stats_buf->num_records);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_tx_pdev_rate_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u8 j;
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-	char *tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
-
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		tx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!tx_gi[j])
-			goto fail;
-	}
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_ldpc = %u",
-			   htt_stats_buf->tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_ldpc = %u",
-			   htt_stats_buf->ac_mu_mimo_tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_ldpc = %u",
-			   htt_stats_buf->ax_mu_mimo_tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_ldpc = %u",
-			   htt_stats_buf->ofdma_tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_success = %u",
-			   htt_stats_buf->rts_success);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_rssi = %u",
-			   htt_stats_buf->ack_rssi);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "Legacy CCK Rates: 1 Mbps: %u, 2 Mbps: %u, 5.5 Mbps: %u, 11 Mbps: %u",
-			   htt_stats_buf->tx_legacy_cck_rate[0],
-			   htt_stats_buf->tx_legacy_cck_rate[1],
-			   htt_stats_buf->tx_legacy_cck_rate[2],
-			   htt_stats_buf->tx_legacy_cck_rate[3]);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "Legacy OFDM Rates: 6 Mbps: %u, 9 Mbps: %u, 12 Mbps: %u, 18 Mbps: %u\n"
-			   "                   24 Mbps: %u, 36 Mbps: %u, 48 Mbps: %u, 54 Mbps: %u",
-			   htt_stats_buf->tx_legacy_ofdm_rate[0],
-			   htt_stats_buf->tx_legacy_ofdm_rate[1],
-			   htt_stats_buf->tx_legacy_ofdm_rate[2],
-			   htt_stats_buf->tx_legacy_ofdm_rate[3],
-			   htt_stats_buf->tx_legacy_ofdm_rate[4],
-			   htt_stats_buf->tx_legacy_ofdm_rate[5],
-			   htt_stats_buf->tx_legacy_ofdm_rate[6],
-			   htt_stats_buf->tx_legacy_ofdm_rate[7]);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_bw = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_bw = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_bw = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_stbc,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_pream,
-			HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u",
-			   htt_stats_buf->tx_he_ltf[1],
-			   htt_stats_buf->tx_he_ltf[2],
-			   htt_stats_buf->tx_he_ltf[3]);
-
-	/* SU GI Stats */
-	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
-	}
-
-	/* AC MU-MIMO GI Stats */
-	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ac_mu_mimo_tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_mu_mimo_tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
-	}
-
-	/* AX MU-MIMO GI Stats */
-	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ax_mu_mimo_tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_mu_mimo_tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
-	}
-
-	/* DL OFDMA GI Stats */
-	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ofdma_tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
-	}
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_dcm,
-			HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-fail:
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++)
-		kfree(tx_gi[j]);
-}
-
-static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_pdev_rate_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	u8 i, j;
-	u16 index = 0;
-	char *rssi_chain[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS] = {NULL};
-	char *rx_gi[HTT_RX_PDEV_STATS_NUM_GI_COUNTERS] = {NULL};
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-	char *rx_pilot_evm_db[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS] = {NULL};
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		rssi_chain[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rssi_chain[j])
-			goto fail;
-	}
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		rx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rx_gi[j])
-			goto fail;
-	}
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		rx_pilot_evm_db[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rx_pilot_evm_db[j])
-			goto fail;
-	}
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "nsts = %u",
-			   htt_stats_buf->nsts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ldpc = %u",
-			   htt_stats_buf->rx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_mgmt = %u",
-			   htt_stats_buf->rssi_mgmt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_data = %u",
-			   htt_stats_buf->rssi_data);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_comb = %u",
-			   htt_stats_buf->rssi_comb);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_in_dbm = %d",
-			   htt_stats_buf->rssi_in_dbm);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_mcs,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_nss,
-			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_dcm,
-			HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_stbc,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_bw,
-			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_nss_count = %u",
-			htt_stats_buf->nss_count);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_pilot_count = %u",
-			htt_stats_buf->pilot_count);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		index = 0;
-
-		for (i = 0; i < HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS; i++)
-			index += scnprintf(&rx_pilot_evm_db[j][index],
-					  HTT_MAX_STRING_LEN - index,
-					  " %u:%d,",
-					  i,
-					  htt_stats_buf->rx_pilot_evm_db[j][i]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB[%u] = %s ",
-				   j, rx_pilot_evm_db[j]);
-	}
-
-	index = 0;
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
-		index += scnprintf(&str_buf[index],
-				  HTT_MAX_STRING_LEN - index,
-				  " %u:%d,", i, htt_stats_buf->rx_pilot_evm_db_mean[i]);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB_mean = %s ", str_buf);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		ARRAY_TO_STRING(rssi_chain[j], htt_stats_buf->rssi_chain[j],
-				HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
-				   j, rssi_chain[j]);
-	}
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->rx_gi[j],
-				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
-				   j, rx_gi[j]);
-	}
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_pream,
-			HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s", str_buf);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_su_ext = %u",
-			   htt_stats_buf->rx_11ax_su_ext);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ac_mumimo = %u",
-			   htt_stats_buf->rx_11ac_mumimo);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_mumimo = %u",
-			   htt_stats_buf->rx_11ax_mumimo);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_ofdma = %u",
-			   htt_stats_buf->rx_11ax_ofdma);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txbf = %u",
-			   htt_stats_buf->txbf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_legacy_cck_rate,
-			HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_cck_rate = %s ",
-			   str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_legacy_ofdm_rate,
-			HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_ofdm_rate = %s ",
-			   str_buf);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_active_dur_us_low = %u",
-			   htt_stats_buf->rx_active_dur_us_low);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_active_dur_us_high = %u",
-			htt_stats_buf->rx_active_dur_us_high);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u",
-			htt_stats_buf->rx_11ax_ul_ofdma);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_mcs,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_mcs = %s ", str_buf);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->ul_ofdma_rx_gi[j],
-				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u] = %s ",
-				   j, rx_gi[j]);
-	}
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_nss,
-			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_nss = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_bw,
-			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_bw = %s ", str_buf);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u",
-			htt_stats_buf->ul_ofdma_rx_stbc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u",
-			htt_stats_buf->ul_ofdma_rx_ldpc);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_non_data_ppdu,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu = %s ",
-			   str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_data_ppdu,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_data_ppdu = %s ",
-			   str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_mpdu_ok,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok = %s ", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_mpdu_fail,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail = %s",
-			   str_buf);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		index = 0;
-		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-		for (i = 0; i < HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
-			index += scnprintf(&str_buf[index],
-					  HTT_MAX_STRING_LEN - index,
-					  " %u:%d,",
-					  i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "rx_ul_fd_rssi: nss[%u] = %s", j, str_buf);
-	}
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "per_chain_rssi_pkt_type = %#x",
-			   htt_stats_buf->per_chain_rssi_pkt_type);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		index = 0;
-		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
-			index += scnprintf(&str_buf[index],
-					  HTT_MAX_STRING_LEN - index,
-					  " %u:%d,",
-					  i,
-					  htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "rx_per_chain_rssi_in_dbm[%u] = %s ", j, str_buf);
-	}
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n");
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-
-fail:
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
-		kfree(rssi_chain[j]);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
-		kfree(rx_pilot_evm_db[j]);
-
-	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; i++)
-		kfree(rx_gi[i]);
-}
-
-static inline void htt_print_rx_soc_fw_stats_tlv(const void *tag_buf,
-						 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_soc_fw_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_SOC_FW_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_reo_ring_data_msdu = %u",
-			   htt_stats_buf->fw_reo_ring_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_to_host_data_msdu_bcmc = %u",
-			   htt_stats_buf->fw_to_host_data_msdu_bcmc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_to_host_data_msdu_uc = %u",
-			   htt_stats_buf->fw_to_host_data_msdu_uc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_remote_data_buf_recycle_cnt = %u",
-			   htt_stats_buf->ofld_remote_data_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_remote_free_buf_indication_cnt = %u",
-			   htt_stats_buf->ofld_remote_free_buf_indication_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_buf_to_host_data_msdu_uc = %u",
-			   htt_stats_buf->ofld_buf_to_host_data_msdu_uc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "reo_fw_ring_to_host_data_msdu_uc = %u",
-			   htt_stats_buf->reo_fw_ring_to_host_data_msdu_uc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_sw_ring_reap = %u",
-			   htt_stats_buf->wbm_sw_ring_reap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_forward_to_host_cnt = %u",
-			   htt_stats_buf->wbm_forward_to_host_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_target_recycle_cnt = %u",
-			   htt_stats_buf->wbm_target_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "target_refill_ring_recycle_cnt = %u",
-			   htt_stats_buf->target_refill_ring_recycle_cnt);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_soc_fw_refill_ring_empty_tlv_v(const void *tag_buf,
-					    u16 tag_len,
-					    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_soc_fw_refill_ring_empty_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char refill_ring_empty_cnt[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV_V:");
-
-	ARRAY_TO_STRING(refill_ring_empty_cnt,
-			htt_stats_buf->refill_ring_empty_cnt,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_empty_cnt = %s\n",
-			   refill_ring_empty_cnt);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(const void *tag_buf,
-						    u16 tag_len,
-						    struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v *htt_stats_buf =
-		tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char rxdma_err_cnt[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_RXDMA_MAX_ERR_CODE);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV_V:");
-
-	ARRAY_TO_STRING(rxdma_err_cnt,
-			htt_stats_buf->rxdma_err,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdma_err = %s\n",
-			   rxdma_err_cnt);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(const void *tag_buf,
-						  u16 tag_len,
-						  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_soc_fw_refill_ring_num_reo_err_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char reo_err_cnt[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_REO_MAX_ERR_CODE);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV_V:");
-
-	ARRAY_TO_STRING(reo_err_cnt,
-			htt_stats_buf->reo_err,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "reo_err = %s\n",
-			   reo_err_cnt);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_reo_debug_stats_tlv_v(const void *tag_buf,
-				   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_reo_resource_stats_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_REO_RESOURCE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sample_id = %u",
-			   htt_stats_buf->sample_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_max = %u",
-			   htt_stats_buf->total_max);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_avg = %u",
-			   htt_stats_buf->total_avg);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_sample = %u",
-			   htt_stats_buf->total_sample);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "non_zeros_avg = %u",
-			   htt_stats_buf->non_zeros_avg);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "non_zeros_sample = %u",
-			   htt_stats_buf->non_zeros_sample);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_max = %u",
-			   htt_stats_buf->last_non_zeros_max);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_min %u",
-			   htt_stats_buf->last_non_zeros_min);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_avg %u",
-			   htt_stats_buf->last_non_zeros_avg);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_sample %u\n",
-			   htt_stats_buf->last_non_zeros_sample);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(const void *tag_buf,
-						 u16 tag_len,
-						 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_soc_fw_refill_ring_num_refill_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char refill_ring_num_refill[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV_V:");
-
-	ARRAY_TO_STRING(refill_ring_num_refill,
-			htt_stats_buf->refill_ring_num_refill,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_num_refill = %s\n",
-			   refill_ring_num_refill);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
-						  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_pdev_fw_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw_ring_mgmt_subtype[HTT_MAX_STRING_LEN] = {0};
-	char fw_ring_ctrl_subtype[HTT_MAX_STRING_LEN] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ppdu_recvd = %u",
-			   htt_stats_buf->ppdu_recvd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u",
-			   htt_stats_buf->mpdu_cnt_fcs_ok);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt_fcs_err = %u",
-			   htt_stats_buf->mpdu_cnt_fcs_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcp_msdu_cnt = %u",
-			   htt_stats_buf->tcp_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcp_ack_msdu_cnt = %u",
-			   htt_stats_buf->tcp_ack_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "udp_msdu_cnt = %u",
-			   htt_stats_buf->udp_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "other_msdu_cnt = %u",
-			   htt_stats_buf->other_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u",
-			   htt_stats_buf->fw_ring_mpdu_ind);
-
-	ARRAY_TO_STRING(fw_ring_mgmt_subtype,
-			htt_stats_buf->fw_ring_mgmt_subtype,
-			HTT_STATS_SUBTYPE_MAX);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mgmt_subtype = %s ",
-			   fw_ring_mgmt_subtype);
-
-	ARRAY_TO_STRING(fw_ring_ctrl_subtype,
-			htt_stats_buf->fw_ring_ctrl_subtype,
-			HTT_STATS_SUBTYPE_MAX);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ctrl_subtype = %s ",
-			   fw_ring_ctrl_subtype);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u",
-			   htt_stats_buf->fw_ring_mcast_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u",
-			   htt_stats_buf->fw_ring_bcast_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ucast_data_msdu = %u",
-			   htt_stats_buf->fw_ring_ucast_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_null_data_msdu = %u",
-			   htt_stats_buf->fw_ring_null_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_drop = %u",
-			   htt_stats_buf->fw_ring_mpdu_drop);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofld_local_data_ind_cnt = %u",
-			   htt_stats_buf->ofld_local_data_ind_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_local_data_buf_recycle_cnt = %u",
-			   htt_stats_buf->ofld_local_data_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "drx_local_data_ind_cnt = %u",
-			   htt_stats_buf->drx_local_data_ind_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "drx_local_data_buf_recycle_cnt = %u",
-			   htt_stats_buf->drx_local_data_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_nondata_ind_cnt = %u",
-			   htt_stats_buf->local_nondata_ind_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_nondata_buf_recycle_cnt = %u",
-			   htt_stats_buf->local_nondata_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_status_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->fw_status_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_status_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->fw_status_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_pkt_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->fw_pkt_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_pkt_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->fw_pkt_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_link_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->fw_link_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_link_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->fw_link_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_pkt_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->host_pkt_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_pkt_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->host_pkt_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_pkt_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->mon_pkt_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_pkt_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->mon_pkt_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "mon_status_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->mon_status_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_status_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->mon_status_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_desc_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->mon_desc_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_desc_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->mon_desc_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_dest_ring_update_cnt = %u",
-			   htt_stats_buf->mon_dest_ring_update_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_dest_ring_full_cnt = %u",
-			   htt_stats_buf->mon_dest_ring_full_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_suspend_cnt = %u",
-			   htt_stats_buf->rx_suspend_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_suspend_fail_cnt = %u",
-			   htt_stats_buf->rx_suspend_fail_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_resume_cnt = %u",
-			   htt_stats_buf->rx_resume_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_resume_fail_cnt = %u",
-			   htt_stats_buf->rx_resume_fail_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ring_switch_cnt = %u",
-			   htt_stats_buf->rx_ring_switch_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ring_restore_cnt = %u",
-			   htt_stats_buf->rx_ring_restore_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_flush_cnt = %u",
-			   htt_stats_buf->rx_flush_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_recovery_reset_cnt = %u\n",
-			   htt_stats_buf->rx_recovery_reset_cnt);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(const void *tag_buf,
-					 struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_pdev_fw_ring_mpdu_err_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw_ring_mpdu_err[HTT_MAX_STRING_LEN] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV_V:");
-
-	ARRAY_TO_STRING(fw_ring_mpdu_err,
-			htt_stats_buf->fw_ring_mpdu_err,
-			HTT_RX_STATS_RXDMA_MAX_ERR);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_err = %s\n",
-			   fw_ring_mpdu_err);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_pdev_fw_mpdu_drop_tlv_v(const void *tag_buf,
-				     u16 tag_len,
-				     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_pdev_fw_mpdu_drop_tlv_v *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw_mpdu_drop[HTT_MAX_STRING_LEN] = {0};
-	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_FW_DROP_REASON_MAX);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV_V:");
-
-	ARRAY_TO_STRING(fw_mpdu_drop,
-			htt_stats_buf->fw_mpdu_drop,
-			num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_mpdu_drop = %s\n", fw_mpdu_drop);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf,
-				       struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_rx_pdev_fw_stats_phy_err_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char phy_errs[HTT_MAX_STRING_LEN] = {0};
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id__word = %u",
-			   htt_stats_buf->mac_id__word);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_phy_err_nct = %u",
-			   htt_stats_buf->total_phy_err_cnt);
-
-	ARRAY_TO_STRING(phy_errs,
-			htt_stats_buf->phy_err,
-			HTT_STATS_PHY_ERR_MAX);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_pdev_cca_stats_hist_tlv(const void *tag_buf,
-				  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_pdev_cca_stats_hist_v1_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\nHTT_PDEV_CCA_STATS_HIST_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "chan_num = %u",
-			   htt_stats_buf->chan_num);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u",
-			   htt_stats_buf->num_records);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "valid_cca_counters_bitmap = 0x%x",
-			   htt_stats_buf->valid_cca_counters_bitmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "collection_interval = %u\n",
-			   htt_stats_buf->collection_interval);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)");
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "|  tx_frame|   rx_frame|   rx_clear| my_rx_frame|        cnt| med_rx_idle| med_tx_idle_global|   cca_obss|");
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf,
-				      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_pdev_stats_cca_counters_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "|%10u| %10u| %10u| %11u| %10u| %11u| %18u| %10u|",
-			   htt_stats_buf->tx_frame_usec,
-			   htt_stats_buf->rx_frame_usec,
-			   htt_stats_buf->rx_clear_usec,
-			   htt_stats_buf->my_rx_frame_usec,
-			   htt_stats_buf->usec_cnt,
-			   htt_stats_buf->med_rx_idle_usec,
-			   htt_stats_buf->med_tx_idle_global_usec,
-			   htt_stats_buf->cca_obss_usec);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_hw_stats_whal_tx_tlv(const void *tag_buf,
-						  struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_hw_stats_whal_tx_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_WHAL_TX_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_unpause_ppdu_id = %u",
-			   htt_stats_buf->last_unpause_ppdu_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_unpause_wait_tqm_write = %u",
-			   htt_stats_buf->hwsch_unpause_wait_tqm_write);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_dummy_tlv_skipped = %u",
-			   htt_stats_buf->hwsch_dummy_tlv_skipped);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "hwsch_misaligned_offset_received = %u",
-			   htt_stats_buf->hwsch_misaligned_offset_received);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_reset_count = %u",
-			   htt_stats_buf->hwsch_reset_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_dev_reset_war = %u",
-			   htt_stats_buf->hwsch_dev_reset_war);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_delayed_pause = %u",
-			   htt_stats_buf->hwsch_delayed_pause);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_long_delayed_pause = %u",
-			   htt_stats_buf->hwsch_long_delayed_pause);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_rx_ppdu_no_response = %u",
-			   htt_stats_buf->sch_rx_ppdu_no_response);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_selfgen_response = %u",
-			   htt_stats_buf->sch_selfgen_response);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_rx_sifs_resp_trigger= %u\n",
-			   htt_stats_buf->sch_rx_sifs_resp_trigger);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_pdev_stats_twt_sessions_tlv(const void *tag_buf,
-				      struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_pdev_stats_twt_sessions_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSIONS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
-			   htt_stats_buf->pdev_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sessions = %u\n",
-			   htt_stats_buf->num_sessions);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_pdev_stats_twt_session_tlv(const void *tag_buf,
-				     struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_pdev_stats_twt_session_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSION_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "vdev_id = %u",
-			   htt_stats_buf->vdev_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "peer_mac = %02x:%02x:%02x:%02x:%02x:%02x",
-			   htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF,
-			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF00) >> 8,
-			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF0000) >> 16,
-			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF000000) >> 24,
-			   (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF),
-			   (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flow_id_flags = %u",
-			   htt_stats_buf->flow_id_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dialog_id = %u",
-			   htt_stats_buf->dialog_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wake_dura_us = %u",
-			   htt_stats_buf->wake_dura_us);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wake_intvl_us = %u",
-			   htt_stats_buf->wake_intvl_us);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sp_offset_us = %u\n",
-			   htt_stats_buf->sp_offset_us);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void
-htt_print_pdev_obss_pd_stats_tlv_v(const void *tag_buf,
-				   struct debug_htt_stats_req *stats_req)
-{
-	const struct htt_pdev_obss_pd_stats_tlv *htt_stats_buf = tag_buf;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "OBSS Tx success PPDU = %u",
-			   htt_stats_buf->num_obss_tx_ppdu_success);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "OBSS Tx failures PPDU = %u\n",
-			   htt_stats_buf->num_obss_tx_ppdu_failure);
-
-	if (len >= buf_len)
-		buf[buf_len - 1] = 0;
-	else
-		buf[len] = 0;
-
-	stats_req->buf_len = len;
-}
-
-static inline void htt_print_backpressure_stats_tlv_v(const u32 *tag_buf,
-						      u8 *data)
-{
-	struct debug_htt_stats_req *stats_req =
-			(struct debug_htt_stats_req *)data;
-	struct htt_ring_backpressure_stats_tlv *htt_stats_buf =
-			(struct htt_ring_backpressure_stats_tlv *)tag_buf;
-	int i;
-	u8 *buf = stats_req->buf;
-	u32 len = stats_req->buf_len;
-	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
-			   htt_stats_buf->pdev_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_head_idx = %u",
-			   htt_stats_buf->current_head_idx);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_tail_idx = %u",
-			   htt_stats_buf->current_tail_idx);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_htt_msgs_sent = %u",
-			   htt_stats_buf->num_htt_msgs_sent);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "backpressure_time_ms = %u",
-			   htt_stats_buf->backpressure_time_ms);
-
-	for (i = 0; i < 5; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "backpressure_hist_%u = %u",
-				   i + 1, htt_stats_buf->backpressure_hist[i]);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "============================");
-
-	if (len >= buf_len) {
-		buf[buf_len - 1] = 0;
-		stats_req->buf_len = buf_len - 1;
-	} else {
-		buf[len] = 0;
-		stats_req->buf_len = len;
-	}
-}
-
-static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
-					  u16 tag, u16 len, const void *tag_buf,
-					  void *user_data)
-{
-	struct debug_htt_stats_req *stats_req = user_data;
-
-	switch (tag) {
-	case HTT_STATS_TX_PDEV_CMN_TAG:
-		htt_print_tx_pdev_stats_cmn_tlv(tag_buf, stats_req);
-		break;
-	case HTT_STATS_TX_PDEV_UNDERRUN_TAG:
-		htt_print_tx_pdev_stats_urrn_tlv_v(tag_buf, len, stats_req);
-		break;
-	case HTT_STATS_TX_PDEV_SIFS_TAG:
-		htt_print_tx_pdev_stats_sifs_tlv_v(tag_buf, len, stats_req);
-		break;
-	case HTT_STATS_TX_PDEV_FLUSH_TAG:
-		htt_print_tx_pdev_stats_flush_tlv_v(tag_buf, len, stats_req);
-		break;
-	case HTT_STATS_TX_PDEV_PHY_ERR_TAG:
-		htt_print_tx_pdev_stats_phy_err_tlv_v(tag_buf, len, stats_req);
-		break;
-	case HTT_STATS_TX_PDEV_SIFS_HIST_TAG:
-		htt_print_tx_pdev_stats_sifs_hist_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_PDEV_TX_PPDU_STATS_TAG:
-		htt_print_tx_pdev_stats_tx_ppdu_stats_tlv_v(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_PDEV_TRIED_MPDU_CNT_HIST_TAG:
-		htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(tag_buf, len,
-								  stats_req);
-		break;
-
-	case HTT_STATS_STRING_TAG:
-		htt_print_stats_string_tlv(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_CMN_TAG:
-		htt_print_tx_hwq_stats_cmn_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_DIFS_LATENCY_TAG:
-		htt_print_tx_hwq_difs_latency_stats_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_CMD_RESULT_TAG:
-		htt_print_tx_hwq_cmd_result_stats_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_CMD_STALL_TAG:
-		htt_print_tx_hwq_cmd_stall_stats_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_FES_STATUS_TAG:
-		htt_print_tx_hwq_fes_result_stats_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_TRIED_MPDU_CNT_HIST_TAG:
-		htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_TXOP_USED_CNT_HIST_TAG:
-		htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(tag_buf, len, stats_req);
-		break;
-	case HTT_STATS_TX_TQM_GEN_MPDU_TAG:
-		htt_print_tx_tqm_gen_mpdu_stats_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_TQM_LIST_MPDU_TAG:
-		htt_print_tx_tqm_list_mpdu_stats_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG:
-		htt_print_tx_tqm_list_mpdu_cnt_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_TQM_CMN_TAG:
-		htt_print_tx_tqm_cmn_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_TQM_PDEV_TAG:
-		htt_print_tx_tqm_pdev_stats_tlv_v(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_TQM_CMDQ_STATUS_TAG:
-		htt_print_tx_tqm_cmdq_status_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_EAPOL_PACKETS_TAG:
-		htt_print_tx_de_eapol_packets_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_CLASSIFY_FAILED_TAG:
-		htt_print_tx_de_classify_failed_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_CLASSIFY_STATS_TAG:
-		htt_print_tx_de_classify_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_CLASSIFY_STATUS_TAG:
-		htt_print_tx_de_classify_status_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG:
-		htt_print_tx_de_enqueue_packets_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG:
-		htt_print_tx_de_enqueue_discard_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_FW2WBM_RING_FULL_HIST_TAG:
-		htt_print_tx_de_fw2wbm_ring_full_hist_tlv(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_CMN_TAG:
-		htt_print_tx_de_cmn_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RING_IF_TAG:
-		htt_print_ring_if_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG:
-		htt_print_tx_pdev_mu_mimo_sch_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_SFM_CMN_TAG:
-		htt_print_sfm_cmn_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_SRING_STATS_TAG:
-		htt_print_sring_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RX_PDEV_FW_STATS_TAG:
-		htt_print_rx_pdev_fw_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RX_PDEV_FW_RING_MPDU_ERR_TAG:
-		htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RX_PDEV_FW_MPDU_DROP_TAG:
-		htt_print_rx_pdev_fw_mpdu_drop_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_RX_SOC_FW_STATS_TAG:
-		htt_print_rx_soc_fw_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RX_SOC_FW_REFILL_RING_EMPTY_TAG:
-		htt_print_rx_soc_fw_refill_ring_empty_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_RX_SOC_FW_REFILL_RING_NUM_REFILL_TAG:
-		htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(
-				tag_buf, len, stats_req);
-		break;
-	case HTT_STATS_RX_REFILL_RXDMA_ERR_TAG:
-		htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(
-				tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_RX_REFILL_REO_ERR_TAG:
-		htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(
-				tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_RX_REO_RESOURCE_STATS_TAG:
-		htt_print_rx_reo_debug_stats_tlv_v(
-				tag_buf, stats_req);
-		break;
-	case HTT_STATS_RX_PDEV_FW_STATS_PHY_ERR_TAG:
-		htt_print_rx_pdev_fw_stats_phy_err_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_PDEV_RATE_STATS_TAG:
-		htt_print_tx_pdev_rate_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RX_PDEV_RATE_STATS_TAG:
-		htt_print_rx_pdev_rate_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG:
-		htt_print_tx_pdev_stats_sched_per_txq_tlv(tag_buf, stats_req);
-		break;
-	case HTT_STATS_TX_SCHED_CMN_TAG:
-		htt_print_stats_tx_sched_cmn_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_PDEV_MPDU_STATS_TAG:
-		htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG:
-		htt_print_sched_txq_cmd_posted_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_RING_IF_CMN_TAG:
-		htt_print_ring_if_cmn_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_SFM_CLIENT_USER_TAG:
-		htt_print_sfm_client_user_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_SFM_CLIENT_TAG:
-		htt_print_sfm_client_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_TQM_ERROR_STATS_TAG:
-		htt_print_tx_tqm_error_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG:
-		htt_print_sched_txq_cmd_reaped_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_SRING_CMN_TAG:
-		htt_print_sring_cmn_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_SOUNDING_STATS_TAG:
-		htt_print_tx_sounding_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG:
-		htt_print_tx_selfgen_ac_err_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_SELFGEN_CMN_STATS_TAG:
-		htt_print_tx_selfgen_cmn_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_SELFGEN_AC_STATS_TAG:
-		htt_print_tx_selfgen_ac_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_SELFGEN_AX_STATS_TAG:
-		htt_print_tx_selfgen_ax_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_SELFGEN_AX_ERR_STATS_TAG:
-		htt_print_tx_selfgen_ax_err_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_MUMIMO_SCH_STATS_TAG:
-		htt_print_tx_hwq_mu_mimo_sch_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_MUMIMO_MPDU_STATS_TAG:
-		htt_print_tx_hwq_mu_mimo_mpdu_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_HWQ_MUMIMO_CMN_STATS_TAG:
-		htt_print_tx_hwq_mu_mimo_cmn_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_HW_INTR_MISC_TAG:
-		htt_print_hw_stats_intr_misc_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_HW_WD_TIMEOUT_TAG:
-		htt_print_hw_stats_wd_timeout_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_HW_PDEV_ERRS_TAG:
-		htt_print_hw_stats_pdev_errs_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_COUNTER_NAME_TAG:
-		htt_print_counter_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_TID_DETAILS_TAG:
-		htt_print_tx_tid_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_TID_DETAILS_V1_TAG:
-		htt_print_tx_tid_stats_v1_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_RX_TID_DETAILS_TAG:
-		htt_print_rx_tid_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PEER_STATS_CMN_TAG:
-		htt_print_peer_stats_cmn_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PEER_DETAILS_TAG:
-		htt_print_peer_details_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PEER_MSDU_FLOWQ_TAG:
-		htt_print_msdu_flow_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PEER_TX_RATE_STATS_TAG:
-		htt_print_tx_peer_rate_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PEER_RX_RATE_STATS_TAG:
-		htt_print_rx_peer_rate_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_TX_DE_COMPL_STATS_TAG:
-		htt_print_tx_de_compl_stats_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PDEV_CCA_1SEC_HIST_TAG:
-	case HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG:
-	case HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG:
-		htt_print_pdev_cca_stats_hist_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
-		htt_print_pdev_stats_cca_counters_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_WHAL_TX_TAG:
-		htt_print_hw_stats_whal_tx_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PDEV_TWT_SESSIONS_TAG:
-		htt_print_pdev_stats_twt_sessions_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_PDEV_TWT_SESSION_TAG:
-		htt_print_pdev_stats_twt_session_tlv(tag_buf, stats_req);
-		break;
-
-	case HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG:
-		htt_print_sched_txq_sched_order_su_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG:
-		htt_print_sched_txq_sched_ineligibility_tlv_v(tag_buf, len, stats_req);
-		break;
-
-	case HTT_STATS_PDEV_OBSS_PD_TAG:
-		htt_print_pdev_obss_pd_stats_tlv_v(tag_buf, stats_req);
-		break;
-	case HTT_STATS_RING_BACKPRESSURE_STATS_TAG:
-		htt_print_backpressure_stats_tlv_v(tag_buf, user_data);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
-				      struct sk_buff *skb)
-{
-	struct ath11k_htt_extd_stats_msg *msg;
-	struct debug_htt_stats_req *stats_req;
-	struct ath11k *ar;
-	u32 len;
-	u64 cookie;
-	int ret;
-	bool send_completion = false;
-	u8 pdev_id;
-
-	msg = (struct ath11k_htt_extd_stats_msg *)skb->data;
-	cookie = msg->cookie;
-
-	if (FIELD_GET(HTT_STATS_COOKIE_MSB, cookie) != HTT_STATS_MAGIC_VALUE) {
-		ath11k_warn(ab, "received invalid htt ext stats event\n");
-		return;
-	}
-
-	pdev_id = FIELD_GET(HTT_STATS_COOKIE_LSB, cookie);
-	rcu_read_lock();
-	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
-	rcu_read_unlock();
-	if (!ar) {
-		ath11k_warn(ab, "failed to get ar for pdev_id %d\n", pdev_id);
-		return;
-	}
-
-	stats_req = ar->debug.htt_stats.stats_req;
-	if (!stats_req)
-		return;
-
-	spin_lock_bh(&ar->debug.htt_stats.lock);
-
-	stats_req->done = FIELD_GET(HTT_T2H_EXT_STATS_INFO1_DONE, msg->info1);
-	if (stats_req->done)
-		send_completion = true;
-
-	spin_unlock_bh(&ar->debug.htt_stats.lock);
-
-	len = FIELD_GET(HTT_T2H_EXT_STATS_INFO1_LENGTH, msg->info1);
-	ret = ath11k_dp_htt_tlv_iter(ab, msg->data, len,
-				     ath11k_dbg_htt_ext_stats_parse,
-				     stats_req);
-	if (ret)
-		ath11k_warn(ab, "Failed to parse tlv %d\n", ret);
-
-	if (send_completion)
-		complete(&stats_req->cmpln);
-}
-
-static ssize_t ath11k_read_htt_stats_type(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	char buf[32];
-	size_t len;
-
-	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.type);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
-}
-
-static ssize_t ath11k_write_htt_stats_type(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	u8 type;
-	int ret;
-
-	ret = kstrtou8_from_user(user_buf, count, 0, &type);
-	if (ret)
-		return ret;
-
-	if (type >= ATH11K_DBG_HTT_NUM_EXT_STATS)
-		return -E2BIG;
-
-	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET ||
-	    type == ATH11K_DBG_HTT_EXT_STATS_PEER_INFO)
-		return -EPERM;
-
-	ar->debug.htt_stats.type = type;
-
-	ret = count;
-
-	return ret;
-}
-
-static const struct file_operations fops_htt_stats_type = {
-	.read = ath11k_read_htt_stats_type,
-	.write = ath11k_write_htt_stats_type,
-	.open = simple_open,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-static int ath11k_prep_htt_stats_cfg_params(struct ath11k *ar, u8 type,
-					    const u8 *mac_addr,
-					    struct htt_ext_stats_cfg_params *cfg_params)
-{
-	if (!cfg_params)
-		return -EINVAL;
-
-	switch (type) {
-	case ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ:
-	case ATH11K_DBG_HTT_EXT_STATS_TX_MU_HWQ:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_HWQS;
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_TXQS;
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_TQM_CMDQ:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_CMDQS;
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_PEER_INFO:
-		cfg_params->cfg0 = HTT_STAT_PEER_INFO_MAC_ADDR;
-		cfg_params->cfg0 |= FIELD_PREP(GENMASK(15, 1),
-					HTT_PEER_STATS_REQ_MODE_FLUSH_TQM);
-		cfg_params->cfg1 = HTT_STAT_DEFAULT_PEER_REQ_TYPE;
-		cfg_params->cfg2 |= FIELD_PREP(GENMASK(7, 0), mac_addr[0]);
-		cfg_params->cfg2 |= FIELD_PREP(GENMASK(15, 8), mac_addr[1]);
-		cfg_params->cfg2 |= FIELD_PREP(GENMASK(23, 16), mac_addr[2]);
-		cfg_params->cfg2 |= FIELD_PREP(GENMASK(31, 24), mac_addr[3]);
-		cfg_params->cfg3 |= FIELD_PREP(GENMASK(7, 0), mac_addr[4]);
-		cfg_params->cfg3 |= FIELD_PREP(GENMASK(15, 8), mac_addr[5]);
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_RING_IF_INFO:
-	case ATH11K_DBG_HTT_EXT_STATS_SRNG_INFO:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_RINGS;
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_ACTIVE_PEERS_LIST:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ACTIVE_PEERS;
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_CCA_CUMULATIVE;
-		break;
-	case ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO:
-		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-int ath11k_dbg_htt_stats_req(struct ath11k *ar)
-{
-	struct debug_htt_stats_req *stats_req = ar->debug.htt_stats.stats_req;
-	u8 type = stats_req->type;
-	u64 cookie = 0;
-	int ret, pdev_id = ar->pdev->pdev_id;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
-
-	init_completion(&stats_req->cmpln);
-
-	stats_req->done = false;
-	stats_req->pdev_id = pdev_id;
-
-	cookie = FIELD_PREP(HTT_STATS_COOKIE_MSB, HTT_STATS_MAGIC_VALUE) |
-		 FIELD_PREP(HTT_STATS_COOKIE_LSB, pdev_id);
-
-	ret = ath11k_prep_htt_stats_cfg_params(ar, type, stats_req->peer_addr,
-					       &cfg_params);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to set htt stats cfg params: %d\n", ret);
-		return ret;
-	}
-
-	ret = ath11k_dp_tx_htt_h2t_ext_stats_req(ar, type, &cfg_params, cookie);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
-		return ret;
-	}
-
-	while (!wait_for_completion_timeout(&stats_req->cmpln, 3 * HZ)) {
-		spin_lock_bh(&ar->debug.htt_stats.lock);
-		if (!stats_req->done) {
-			stats_req->done = true;
-			spin_unlock_bh(&ar->debug.htt_stats.lock);
-			ath11k_warn(ar->ab, "stats request timed out\n");
-			return -ETIMEDOUT;
-		}
-		spin_unlock_bh(&ar->debug.htt_stats.lock);
-	}
-
-	return 0;
-}
-
-static int ath11k_open_htt_stats(struct inode *inode, struct file *file)
-{
-	struct ath11k *ar = inode->i_private;
-	struct debug_htt_stats_req *stats_req;
-	u8 type = ar->debug.htt_stats.type;
-	int ret;
-
-	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET)
-		return -EPERM;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
-
-	if (ar->debug.htt_stats.stats_req) {
-		ret = -EAGAIN;
-		goto err_unlock;
-	}
-
-	stats_req = vzalloc(sizeof(*stats_req) + ATH11K_HTT_STATS_BUF_SIZE);
-	if (!stats_req) {
-		ret = -ENOMEM;
-		goto err_unlock;
-	}
-
-	ar->debug.htt_stats.stats_req = stats_req;
-	stats_req->type = type;
-
-	ret = ath11k_dbg_htt_stats_req(ar);
-	if (ret < 0)
-		goto out;
-
-	file->private_data = stats_req;
-
-	mutex_unlock(&ar->conf_mutex);
-
-	return 0;
-out:
-	vfree(stats_req);
-	ar->debug.htt_stats.stats_req = NULL;
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-
-	return ret;
-}
-
-static int ath11k_release_htt_stats(struct inode *inode, struct file *file)
-{
-	struct ath11k *ar = inode->i_private;
-
-	mutex_lock(&ar->conf_mutex);
-	vfree(file->private_data);
-	ar->debug.htt_stats.stats_req = NULL;
-	mutex_unlock(&ar->conf_mutex);
-
-	return 0;
-}
-
-static ssize_t ath11k_read_htt_stats(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct debug_htt_stats_req *stats_req = file->private_data;
-	char *buf;
-	u32 length = 0;
-
-	buf = stats_req->buf;
-	length = min_t(u32, stats_req->buf_len, ATH11K_HTT_STATS_BUF_SIZE);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, length);
-}
-
-static const struct file_operations fops_dump_htt_stats = {
-	.open = ath11k_open_htt_stats,
-	.release = ath11k_release_htt_stats,
-	.read = ath11k_read_htt_stats,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-static ssize_t ath11k_read_htt_stats_reset(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	char buf[32];
-	size_t len;
-
-	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.reset);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
-}
-
-static ssize_t ath11k_write_htt_stats_reset(struct file *file,
-					    const char __user *user_buf,
-					    size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	u8 type;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
-	int ret;
-
-	ret = kstrtou8_from_user(user_buf, count, 0, &type);
-	if (ret)
-		return ret;
-
-	if (type >= ATH11K_DBG_HTT_NUM_EXT_STATS ||
-	    type == ATH11K_DBG_HTT_EXT_STATS_RESET)
-		return -E2BIG;
-
-	mutex_lock(&ar->conf_mutex);
-	cfg_params.cfg0 = HTT_STAT_DEFAULT_RESET_START_OFFSET;
-	cfg_params.cfg1 = 1 << (cfg_params.cfg0 + type);
-	ret = ath11k_dp_tx_htt_h2t_ext_stats_req(ar,
-						 ATH11K_DBG_HTT_EXT_STATS_RESET,
-						 &cfg_params,
-						 0ULL);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
-		mutex_unlock(&ar->conf_mutex);
-		return ret;
-	}
-
-	ar->debug.htt_stats.reset = type;
-	mutex_unlock(&ar->conf_mutex);
-
-	ret = count;
-
-	return ret;
-}
-
-static const struct file_operations fops_htt_stats_reset = {
-	.read = ath11k_read_htt_stats_reset,
-	.write = ath11k_write_htt_stats_reset,
-	.open = simple_open,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-void ath11k_debug_htt_stats_init(struct ath11k *ar)
-{
-	spin_lock_init(&ar->debug.htt_stats.lock);
-	debugfs_create_file("htt_stats_type", 0600, ar->debug.debugfs_pdev,
-			    ar, &fops_htt_stats_type);
-	debugfs_create_file("htt_stats", 0400, ar->debug.debugfs_pdev,
-			    ar, &fops_dump_htt_stats);
-	debugfs_create_file("htt_stats_reset", 0600, ar->debug.debugfs_pdev,
-			    ar, &fops_htt_stats_reset);
-}
diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.h b/drivers/net/wireless/ath/ath11k/debug_htt_stats.h
deleted file mode 100644
index 682a6ff222bd..000000000000
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.h
+++ /dev/null
@@ -1,1690 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause-Clear */
-/*
- * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- */
-
-#ifndef DEBUG_HTT_STATS_H
-#define DEBUG_HTT_STATS_H
-
-#define HTT_STATS_COOKIE_LSB    GENMASK_ULL(31, 0)
-#define HTT_STATS_COOKIE_MSB    GENMASK_ULL(63, 32)
-#define HTT_STATS_MAGIC_VALUE   0xF0F0F0F0
-
-enum htt_tlv_tag_t {
-	HTT_STATS_TX_PDEV_CMN_TAG                           = 0,
-	HTT_STATS_TX_PDEV_UNDERRUN_TAG                      = 1,
-	HTT_STATS_TX_PDEV_SIFS_TAG                          = 2,
-	HTT_STATS_TX_PDEV_FLUSH_TAG                         = 3,
-	HTT_STATS_TX_PDEV_PHY_ERR_TAG                       = 4,
-	HTT_STATS_STRING_TAG                                = 5,
-	HTT_STATS_TX_HWQ_CMN_TAG                            = 6,
-	HTT_STATS_TX_HWQ_DIFS_LATENCY_TAG                   = 7,
-	HTT_STATS_TX_HWQ_CMD_RESULT_TAG                     = 8,
-	HTT_STATS_TX_HWQ_CMD_STALL_TAG                      = 9,
-	HTT_STATS_TX_HWQ_FES_STATUS_TAG                     = 10,
-	HTT_STATS_TX_TQM_GEN_MPDU_TAG                       = 11,
-	HTT_STATS_TX_TQM_LIST_MPDU_TAG                      = 12,
-	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG                  = 13,
-	HTT_STATS_TX_TQM_CMN_TAG                            = 14,
-	HTT_STATS_TX_TQM_PDEV_TAG                           = 15,
-	HTT_STATS_TX_TQM_CMDQ_STATUS_TAG                    = 16,
-	HTT_STATS_TX_DE_EAPOL_PACKETS_TAG                   = 17,
-	HTT_STATS_TX_DE_CLASSIFY_FAILED_TAG                 = 18,
-	HTT_STATS_TX_DE_CLASSIFY_STATS_TAG                  = 19,
-	HTT_STATS_TX_DE_CLASSIFY_STATUS_TAG                 = 20,
-	HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG                 = 21,
-	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG                 = 22,
-	HTT_STATS_TX_DE_CMN_TAG                             = 23,
-	HTT_STATS_RING_IF_TAG                               = 24,
-	HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG                 = 25,
-	HTT_STATS_SFM_CMN_TAG                               = 26,
-	HTT_STATS_SRING_STATS_TAG                           = 27,
-	HTT_STATS_RX_PDEV_FW_STATS_TAG                      = 28,
-	HTT_STATS_RX_PDEV_FW_RING_MPDU_ERR_TAG              = 29,
-	HTT_STATS_RX_PDEV_FW_MPDU_DROP_TAG                  = 30,
-	HTT_STATS_RX_SOC_FW_STATS_TAG                       = 31,
-	HTT_STATS_RX_SOC_FW_REFILL_RING_EMPTY_TAG           = 32,
-	HTT_STATS_RX_SOC_FW_REFILL_RING_NUM_REFILL_TAG      = 33,
-	HTT_STATS_TX_PDEV_RATE_STATS_TAG                    = 34,
-	HTT_STATS_RX_PDEV_RATE_STATS_TAG                    = 35,
-	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG           = 36,
-	HTT_STATS_TX_SCHED_CMN_TAG                          = 37,
-	HTT_STATS_TX_PDEV_MUMIMO_MPDU_STATS_TAG             = 38,
-	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG                  = 39,
-	HTT_STATS_RING_IF_CMN_TAG                           = 40,
-	HTT_STATS_SFM_CLIENT_USER_TAG                       = 41,
-	HTT_STATS_SFM_CLIENT_TAG                            = 42,
-	HTT_STATS_TX_TQM_ERROR_STATS_TAG                    = 43,
-	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG                  = 44,
-	HTT_STATS_SRING_CMN_TAG                             = 45,
-	HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG               = 46,
-	HTT_STATS_TX_SELFGEN_CMN_STATS_TAG                  = 47,
-	HTT_STATS_TX_SELFGEN_AC_STATS_TAG                   = 48,
-	HTT_STATS_TX_SELFGEN_AX_STATS_TAG                   = 49,
-	HTT_STATS_TX_SELFGEN_AX_ERR_STATS_TAG               = 50,
-	HTT_STATS_TX_HWQ_MUMIMO_SCH_STATS_TAG               = 51,
-	HTT_STATS_TX_HWQ_MUMIMO_MPDU_STATS_TAG              = 52,
-	HTT_STATS_TX_HWQ_MUMIMO_CMN_STATS_TAG               = 53,
-	HTT_STATS_HW_INTR_MISC_TAG                          = 54,
-	HTT_STATS_HW_WD_TIMEOUT_TAG                         = 55,
-	HTT_STATS_HW_PDEV_ERRS_TAG                          = 56,
-	HTT_STATS_COUNTER_NAME_TAG                          = 57,
-	HTT_STATS_TX_TID_DETAILS_TAG                        = 58,
-	HTT_STATS_RX_TID_DETAILS_TAG                        = 59,
-	HTT_STATS_PEER_STATS_CMN_TAG                        = 60,
-	HTT_STATS_PEER_DETAILS_TAG                          = 61,
-	HTT_STATS_PEER_TX_RATE_STATS_TAG                    = 62,
-	HTT_STATS_PEER_RX_RATE_STATS_TAG                    = 63,
-	HTT_STATS_PEER_MSDU_FLOWQ_TAG                       = 64,
-	HTT_STATS_TX_DE_COMPL_STATS_TAG                     = 65,
-	HTT_STATS_WHAL_TX_TAG                               = 66,
-	HTT_STATS_TX_PDEV_SIFS_HIST_TAG                     = 67,
-	HTT_STATS_RX_PDEV_FW_STATS_PHY_ERR_TAG              = 68,
-	HTT_STATS_TX_TID_DETAILS_V1_TAG                     = 69,
-	HTT_STATS_PDEV_CCA_1SEC_HIST_TAG                    = 70,
-	HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG                 = 71,
-	HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG              = 72,
-	HTT_STATS_PDEV_CCA_COUNTERS_TAG                     = 73,
-	HTT_STATS_TX_PDEV_MPDU_STATS_TAG                    = 74,
-	HTT_STATS_PDEV_TWT_SESSIONS_TAG                     = 75,
-	HTT_STATS_PDEV_TWT_SESSION_TAG                      = 76,
-	HTT_STATS_RX_REFILL_RXDMA_ERR_TAG                   = 77,
-	HTT_STATS_RX_REFILL_REO_ERR_TAG                     = 78,
-	HTT_STATS_RX_REO_RESOURCE_STATS_TAG                 = 79,
-	HTT_STATS_TX_SOUNDING_STATS_TAG                     = 80,
-	HTT_STATS_TX_PDEV_TX_PPDU_STATS_TAG                 = 81,
-	HTT_STATS_TX_PDEV_TRIED_MPDU_CNT_HIST_TAG           = 82,
-	HTT_STATS_TX_HWQ_TRIED_MPDU_CNT_HIST_TAG            = 83,
-	HTT_STATS_TX_HWQ_TXOP_USED_CNT_HIST_TAG             = 84,
-	HTT_STATS_TX_DE_FW2WBM_RING_FULL_HIST_TAG           = 85,
-	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG              = 86,
-	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG         = 87,
-	HTT_STATS_PDEV_OBSS_PD_TAG                          = 88,
-	HTT_STATS_HW_WAR_TAG				    = 89,
-	HTT_STATS_RING_BACKPRESSURE_STATS_TAG		    = 90,
-
-	HTT_STATS_MAX_TAG,
-};
-
-#define HTT_STATS_MAX_STRING_SZ32            4
-#define HTT_STATS_MACID_INVALID              0xff
-#define HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS     10
-#define HTT_TX_HWQ_MAX_CMD_RESULT_STATS      13
-#define HTT_TX_HWQ_MAX_CMD_STALL_STATS       5
-#define HTT_TX_HWQ_MAX_FES_RESULT_STATS      10
-
-enum htt_tx_pdev_underrun_enum {
-	HTT_STATS_TX_PDEV_NO_DATA_UNDERRUN           = 0,
-	HTT_STATS_TX_PDEV_DATA_UNDERRUN_BETWEEN_MPDU = 1,
-	HTT_STATS_TX_PDEV_DATA_UNDERRUN_WITHIN_MPDU  = 2,
-	HTT_TX_PDEV_MAX_URRN_STATS                   = 3,
-};
-
-#define HTT_TX_PDEV_MAX_FLUSH_REASON_STATS     71
-#define HTT_TX_PDEV_MAX_SIFS_BURST_STATS       9
-#define HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS  10
-#define HTT_TX_PDEV_MAX_PHY_ERR_STATS          18
-#define HTT_TX_PDEV_SCHED_TX_MODE_MAX          4
-#define HTT_TX_PDEV_NUM_SCHED_ORDER_LOG        20
-
-#define HTT_RX_STATS_REFILL_MAX_RING         4
-#define HTT_RX_STATS_RXDMA_MAX_ERR           16
-#define HTT_RX_STATS_FW_DROP_REASON_MAX      16
-
-/* Bytes stored in little endian order */
-/* Length should be multiple of DWORD */
-struct htt_stats_string_tlv {
-	u32 data[0]; /* Can be variable length */
-} __packed;
-
-/* == TX PDEV STATS == */
-struct htt_tx_pdev_stats_cmn_tlv {
-	u32 mac_id__word;
-	u32 hw_queued;
-	u32 hw_reaped;
-	u32 underrun;
-	u32 hw_paused;
-	u32 hw_flush;
-	u32 hw_filt;
-	u32 tx_abort;
-	u32 mpdu_requed;
-	u32 tx_xretry;
-	u32 data_rc;
-	u32 mpdu_dropped_xretry;
-	u32 illgl_rate_phy_err;
-	u32 cont_xretry;
-	u32 tx_timeout;
-	u32 pdev_resets;
-	u32 phy_underrun;
-	u32 txop_ovf;
-	u32 seq_posted;
-	u32 seq_failed_queueing;
-	u32 seq_completed;
-	u32 seq_restarted;
-	u32 mu_seq_posted;
-	u32 seq_switch_hw_paused;
-	u32 next_seq_posted_dsr;
-	u32 seq_posted_isr;
-	u32 seq_ctrl_cached;
-	u32 mpdu_count_tqm;
-	u32 msdu_count_tqm;
-	u32 mpdu_removed_tqm;
-	u32 msdu_removed_tqm;
-	u32 mpdus_sw_flush;
-	u32 mpdus_hw_filter;
-	u32 mpdus_truncated;
-	u32 mpdus_ack_failed;
-	u32 mpdus_expired;
-	u32 mpdus_seq_hw_retry;
-	u32 ack_tlv_proc;
-	u32 coex_abort_mpdu_cnt_valid;
-	u32 coex_abort_mpdu_cnt;
-	u32 num_total_ppdus_tried_ota;
-	u32 num_data_ppdus_tried_ota;
-	u32 local_ctrl_mgmt_enqued;
-	u32 local_ctrl_mgmt_freed;
-	u32 local_data_enqued;
-	u32 local_data_freed;
-	u32 mpdu_tried;
-	u32 isr_wait_seq_posted;
-
-	u32 tx_active_dur_us_low;
-	u32 tx_active_dur_us_high;
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_pdev_stats_urrn_tlv_v {
-	u32 urrn_stats[0]; /* HTT_TX_PDEV_MAX_URRN_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_pdev_stats_flush_tlv_v {
-	u32 flush_errs[0]; /* HTT_TX_PDEV_MAX_FLUSH_REASON_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_pdev_stats_sifs_tlv_v {
-	u32 sifs_status[0]; /* HTT_TX_PDEV_MAX_SIFS_BURST_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_pdev_stats_phy_err_tlv_v {
-	u32  phy_errs[0]; /* HTT_TX_PDEV_MAX_PHY_ERR_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_pdev_stats_sifs_hist_tlv_v {
-	u32 sifs_hist_status[0]; /* HTT_TX_PDEV_SIFS_BURST_HIST_STATS */
-};
-
-struct htt_tx_pdev_stats_tx_ppdu_stats_tlv_v {
-	u32 num_data_ppdus_legacy_su;
-	u32 num_data_ppdus_ac_su;
-	u32 num_data_ppdus_ax_su;
-	u32 num_data_ppdus_ac_su_txbf;
-	u32 num_data_ppdus_ax_su_txbf;
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size .
- *
- *  Tried_mpdu_cnt_hist is the histogram of MPDUs tries per HWQ.
- *  The tries here is the count of the  MPDUS within a PPDU that the
- *  HW had attempted to transmit on  air, for the HWSCH Schedule
- *  command submitted by FW.It is not the retry attempts.
- *  The histogram bins are  0-29, 30-59, 60-89 and so on. The are
- *   10 bins in this histogram. They are defined in FW using the
- *  following macros
- *  #define WAL_MAX_TRIED_MPDU_CNT_HISTOGRAM 9
- *  #define WAL_TRIED_MPDU_CNT_HISTOGRAM_INTERVAL 30
- */
-struct htt_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v {
-	u32 hist_bin_size;
-	u32 tried_mpdu_cnt_hist[]; /* HTT_TX_PDEV_TRIED_MPDU_CNT_HIST */
-};
-
-/* == SOC ERROR STATS == */
-
-/* =============== PDEV ERROR STATS ============== */
-#define HTT_STATS_MAX_HW_INTR_NAME_LEN 8
-struct htt_hw_stats_intr_misc_tlv {
-	/* Stored as little endian */
-	u8 hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN];
-	u32 mask;
-	u32 count;
-};
-
-#define HTT_STATS_MAX_HW_MODULE_NAME_LEN 8
-struct htt_hw_stats_wd_timeout_tlv {
-	/* Stored as little endian */
-	u8 hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN];
-	u32 count;
-};
-
-struct htt_hw_stats_pdev_errs_tlv {
-	u32    mac_id__word; /* BIT [ 7 :  0] : mac_id */
-	u32    tx_abort;
-	u32    tx_abort_fail_count;
-	u32    rx_abort;
-	u32    rx_abort_fail_count;
-	u32    warm_reset;
-	u32    cold_reset;
-	u32    tx_flush;
-	u32    tx_glb_reset;
-	u32    tx_txq_reset;
-	u32    rx_timeout_reset;
-};
-
-struct htt_hw_stats_whal_tx_tlv {
-	u32 mac_id__word;
-	u32 last_unpause_ppdu_id;
-	u32 hwsch_unpause_wait_tqm_write;
-	u32 hwsch_dummy_tlv_skipped;
-	u32 hwsch_misaligned_offset_received;
-	u32 hwsch_reset_count;
-	u32 hwsch_dev_reset_war;
-	u32 hwsch_delayed_pause;
-	u32 hwsch_long_delayed_pause;
-	u32 sch_rx_ppdu_no_response;
-	u32 sch_selfgen_response;
-	u32 sch_rx_sifs_resp_trigger;
-};
-
-/* ============ PEER STATS ============ */
-struct htt_msdu_flow_stats_tlv {
-	u32 last_update_timestamp;
-	u32 last_add_timestamp;
-	u32 last_remove_timestamp;
-	u32 total_processed_msdu_count;
-	u32 cur_msdu_count_in_flowq;
-	u32 sw_peer_id;
-	u32 tx_flow_no__tid_num__drop_rule;
-	u32 last_cycle_enqueue_count;
-	u32 last_cycle_dequeue_count;
-	u32 last_cycle_drop_count;
-	u32 current_drop_th;
-};
-
-#define MAX_HTT_TID_NAME 8
-
-/* Tidq stats */
-struct htt_tx_tid_stats_tlv {
-	/* Stored as little endian */
-	u8     tid_name[MAX_HTT_TID_NAME];
-	u32 sw_peer_id__tid_num;
-	u32 num_sched_pending__num_ppdu_in_hwq;
-	u32 tid_flags;
-	u32 hw_queued;
-	u32 hw_reaped;
-	u32 mpdus_hw_filter;
-
-	u32 qdepth_bytes;
-	u32 qdepth_num_msdu;
-	u32 qdepth_num_mpdu;
-	u32 last_scheduled_tsmp;
-	u32 pause_module_id;
-	u32 block_module_id;
-	u32 tid_tx_airtime;
-};
-
-/* Tidq stats */
-struct htt_tx_tid_stats_v1_tlv {
-	/* Stored as little endian */
-	u8 tid_name[MAX_HTT_TID_NAME];
-	u32 sw_peer_id__tid_num;
-	u32 num_sched_pending__num_ppdu_in_hwq;
-	u32 tid_flags;
-	u32 max_qdepth_bytes;
-	u32 max_qdepth_n_msdus;
-	u32 rsvd;
-
-	u32 qdepth_bytes;
-	u32 qdepth_num_msdu;
-	u32 qdepth_num_mpdu;
-	u32 last_scheduled_tsmp;
-	u32 pause_module_id;
-	u32 block_module_id;
-	u32 tid_tx_airtime;
-	u32 allow_n_flags;
-	u32 sendn_frms_allowed;
-};
-
-struct htt_rx_tid_stats_tlv {
-	u32 sw_peer_id__tid_num;
-	u8 tid_name[MAX_HTT_TID_NAME];
-	u32 dup_in_reorder;
-	u32 dup_past_outside_window;
-	u32 dup_past_within_window;
-	u32 rxdesc_err_decrypt;
-	u32 tid_rx_airtime;
-};
-
-#define HTT_MAX_COUNTER_NAME 8
-struct htt_counter_tlv {
-	u8 counter_name[HTT_MAX_COUNTER_NAME];
-	u32 count;
-};
-
-struct htt_peer_stats_cmn_tlv {
-	u32 ppdu_cnt;
-	u32 mpdu_cnt;
-	u32 msdu_cnt;
-	u32 pause_bitmap;
-	u32 block_bitmap;
-	u32 current_timestamp;
-	u32 peer_tx_airtime;
-	u32 peer_rx_airtime;
-	s32 rssi;
-	u32 peer_enqueued_count_low;
-	u32 peer_enqueued_count_high;
-	u32 peer_dequeued_count_low;
-	u32 peer_dequeued_count_high;
-	u32 peer_dropped_count_low;
-	u32 peer_dropped_count_high;
-	u32 ppdu_transmitted_bytes_low;
-	u32 ppdu_transmitted_bytes_high;
-	u32 peer_ttl_removed_count;
-	u32 inactive_time;
-};
-
-struct htt_peer_details_tlv {
-	u32 peer_type;
-	u32 sw_peer_id;
-	u32 vdev_pdev_ast_idx;
-	struct htt_mac_addr mac_addr;
-	u32 peer_flags;
-	u32 qpeer_flags;
-};
-
-enum htt_stats_param_type {
-	HTT_STATS_PREAM_OFDM,
-	HTT_STATS_PREAM_CCK,
-	HTT_STATS_PREAM_HT,
-	HTT_STATS_PREAM_VHT,
-	HTT_STATS_PREAM_HE,
-	HTT_STATS_PREAM_RSVD,
-	HTT_STATS_PREAM_RSVD1,
-
-	HTT_STATS_PREAM_COUNT,
-};
-
-#define HTT_TX_PEER_STATS_NUM_MCS_COUNTERS        12
-#define HTT_TX_PEER_STATS_NUM_GI_COUNTERS          4
-#define HTT_TX_PEER_STATS_NUM_DCM_COUNTERS         5
-#define HTT_TX_PEER_STATS_NUM_BW_COUNTERS          4
-#define HTT_TX_PEER_STATS_NUM_SPATIAL_STREAMS      8
-#define HTT_TX_PEER_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
-
-struct htt_tx_peer_rate_stats_tlv {
-	u32 tx_ldpc;
-	u32 rts_cnt;
-	u32 ack_rssi;
-
-	u32 tx_mcs[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
-	u32 tx_su_mcs[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
-	u32 tx_mu_mcs[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
-	/* element 0,1, ...7 -> NSS 1,2, ...8 */
-	u32 tx_nss[HTT_TX_PEER_STATS_NUM_SPATIAL_STREAMS];
-	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
-	u32 tx_bw[HTT_TX_PEER_STATS_NUM_BW_COUNTERS];
-	u32 tx_stbc[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
-	u32 tx_pream[HTT_TX_PEER_STATS_NUM_PREAMBLE_TYPES];
-
-	/* Counters to track number of tx packets in each GI
-	 * (400us, 800us, 1600us & 3200us) in each mcs (0-11)
-	 */
-	u32 tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS][HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
-
-	/* Counters to track packets in dcm mcs (MCS 0, 1, 3, 4) */
-	u32 tx_dcm[HTT_TX_PEER_STATS_NUM_DCM_COUNTERS];
-
-};
-
-#define HTT_RX_PEER_STATS_NUM_MCS_COUNTERS        12
-#define HTT_RX_PEER_STATS_NUM_GI_COUNTERS          4
-#define HTT_RX_PEER_STATS_NUM_DCM_COUNTERS         5
-#define HTT_RX_PEER_STATS_NUM_BW_COUNTERS          4
-#define HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS      8
-#define HTT_RX_PEER_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
-
-struct htt_rx_peer_rate_stats_tlv {
-	u32 nsts;
-
-	/* Number of rx ldpc packets */
-	u32 rx_ldpc;
-	/* Number of rx rts packets */
-	u32 rts_cnt;
-
-	u32 rssi_mgmt; /* units = dB above noise floor */
-	u32 rssi_data; /* units = dB above noise floor */
-	u32 rssi_comb; /* units = dB above noise floor */
-	u32 rx_mcs[HTT_RX_PEER_STATS_NUM_MCS_COUNTERS];
-	/* element 0,1, ...7 -> NSS 1,2, ...8 */
-	u32 rx_nss[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS];
-	u32 rx_dcm[HTT_RX_PEER_STATS_NUM_DCM_COUNTERS];
-	u32 rx_stbc[HTT_RX_PEER_STATS_NUM_MCS_COUNTERS];
-	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
-	u32 rx_bw[HTT_RX_PEER_STATS_NUM_BW_COUNTERS];
-	u32 rx_pream[HTT_RX_PEER_STATS_NUM_PREAMBLE_TYPES];
-	/* units = dB above noise floor */
-	u8 rssi_chain[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS]
-		     [HTT_RX_PEER_STATS_NUM_BW_COUNTERS];
-
-	/* Counters to track number of rx packets in each GI in each mcs (0-11) */
-	u32 rx_gi[HTT_RX_PEER_STATS_NUM_GI_COUNTERS]
-		 [HTT_RX_PEER_STATS_NUM_MCS_COUNTERS];
-};
-
-enum htt_peer_stats_req_mode {
-	HTT_PEER_STATS_REQ_MODE_NO_QUERY,
-	HTT_PEER_STATS_REQ_MODE_QUERY_TQM,
-	HTT_PEER_STATS_REQ_MODE_FLUSH_TQM,
-};
-
-enum htt_peer_stats_tlv_enum {
-	HTT_PEER_STATS_CMN_TLV       = 0,
-	HTT_PEER_DETAILS_TLV         = 1,
-	HTT_TX_PEER_RATE_STATS_TLV   = 2,
-	HTT_RX_PEER_RATE_STATS_TLV   = 3,
-	HTT_TX_TID_STATS_TLV         = 4,
-	HTT_RX_TID_STATS_TLV         = 5,
-	HTT_MSDU_FLOW_STATS_TLV      = 6,
-
-	HTT_PEER_STATS_MAX_TLV       = 31,
-};
-
-/* =========== MUMIMO HWQ stats =========== */
-/* MU MIMO stats per hwQ */
-struct htt_tx_hwq_mu_mimo_sch_stats_tlv {
-	u32 mu_mimo_sch_posted;
-	u32 mu_mimo_sch_failed;
-	u32 mu_mimo_ppdu_posted;
-};
-
-struct htt_tx_hwq_mu_mimo_mpdu_stats_tlv {
-	u32 mu_mimo_mpdus_queued_usr;
-	u32 mu_mimo_mpdus_tried_usr;
-	u32 mu_mimo_mpdus_failed_usr;
-	u32 mu_mimo_mpdus_requeued_usr;
-	u32 mu_mimo_err_no_ba_usr;
-	u32 mu_mimo_mpdu_underrun_usr;
-	u32 mu_mimo_ampdu_underrun_usr;
-};
-
-struct htt_tx_hwq_mu_mimo_cmn_stats_tlv {
-	u32 mac_id__hwq_id__word;
-};
-
-/* == TX HWQ STATS == */
-struct htt_tx_hwq_stats_cmn_tlv {
-	u32 mac_id__hwq_id__word;
-
-	/* PPDU level stats */
-	u32 xretry;
-	u32 underrun_cnt;
-	u32 flush_cnt;
-	u32 filt_cnt;
-	u32 null_mpdu_bmap;
-	u32 user_ack_failure;
-	u32 ack_tlv_proc;
-	u32 sched_id_proc;
-	u32 null_mpdu_tx_count;
-	u32 mpdu_bmap_not_recvd;
-
-	/* Selfgen stats per hwQ */
-	u32 num_bar;
-	u32 rts;
-	u32 cts2self;
-	u32 qos_null;
-
-	/* MPDU level stats */
-	u32 mpdu_tried_cnt;
-	u32 mpdu_queued_cnt;
-	u32 mpdu_ack_fail_cnt;
-	u32 mpdu_filt_cnt;
-	u32 false_mpdu_ack_count;
-
-	u32 txq_timeout;
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_hwq_difs_latency_stats_tlv_v {
-	u32 hist_intvl;
-	/* histogram of ppdu post to hwsch - > cmd status received */
-	u32 difs_latency_hist[]; /* HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_hwq_cmd_result_stats_tlv_v {
-	/* Histogram of sched cmd result */
-	u32 cmd_result[0]; /* HTT_TX_HWQ_MAX_CMD_RESULT_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_hwq_cmd_stall_stats_tlv_v {
-	/* Histogram of various pause conitions */
-	u32 cmd_stall_status[0]; /* HTT_TX_HWQ_MAX_CMD_STALL_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_hwq_fes_result_stats_tlv_v {
-	/* Histogram of number of user fes result */
-	u32 fes_result[0]; /* HTT_TX_HWQ_MAX_FES_RESULT_STATS */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size
- *
- *  The hwq_tried_mpdu_cnt_hist is a  histogram of MPDUs tries per HWQ.
- *  The tries here is the count of the  MPDUS within a PPDU that the HW
- *  had attempted to transmit on  air, for the HWSCH Schedule command
- *  submitted by FW in this HWQ .It is not the retry attempts. The
- *  histogram bins are  0-29, 30-59, 60-89 and so on. The are 10 bins
- *  in this histogram.
- *  they are defined in FW using the following macros
- *  #define WAL_MAX_TRIED_MPDU_CNT_HISTOGRAM 9
- *  #define WAL_TRIED_MPDU_CNT_HISTOGRAM_INTERVAL 30
- */
-struct htt_tx_hwq_tried_mpdu_cnt_hist_tlv_v {
-	u32 hist_bin_size;
-	/* Histogram of number of mpdus on tried mpdu */
-	u32 tried_mpdu_cnt_hist[]; /* HTT_TX_HWQ_TRIED_MPDU_CNT_HIST */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size
- *
- * The txop_used_cnt_hist is the histogram of txop per burst. After
- * completing the burst, we identify the txop used in the burst and
- * incr the corresponding bin.
- * Each bin represents 1ms & we have 10 bins in this histogram.
- * they are deined in FW using the following macros
- * #define WAL_MAX_TXOP_USED_CNT_HISTOGRAM 10
- * #define WAL_TXOP_USED_HISTOGRAM_INTERVAL 1000 ( 1 ms )
- */
-struct htt_tx_hwq_txop_used_cnt_hist_tlv_v {
-	/* Histogram of txop used cnt */
-	u32 txop_used_cnt_hist[0]; /* HTT_TX_HWQ_TXOP_USED_CNT_HIST */
-};
-
-/* == TX SELFGEN STATS == */
-struct htt_tx_selfgen_cmn_stats_tlv {
-	u32 mac_id__word;
-	u32 su_bar;
-	u32 rts;
-	u32 cts2self;
-	u32 qos_null;
-	u32 delayed_bar_1; /* MU user 1 */
-	u32 delayed_bar_2; /* MU user 2 */
-	u32 delayed_bar_3; /* MU user 3 */
-	u32 delayed_bar_4; /* MU user 4 */
-	u32 delayed_bar_5; /* MU user 5 */
-	u32 delayed_bar_6; /* MU user 6 */
-	u32 delayed_bar_7; /* MU user 7 */
-};
-
-struct htt_tx_selfgen_ac_stats_tlv {
-	/* 11AC */
-	u32 ac_su_ndpa;
-	u32 ac_su_ndp;
-	u32 ac_mu_mimo_ndpa;
-	u32 ac_mu_mimo_ndp;
-	u32 ac_mu_mimo_brpoll_1; /* MU user 1 */
-	u32 ac_mu_mimo_brpoll_2; /* MU user 2 */
-	u32 ac_mu_mimo_brpoll_3; /* MU user 3 */
-};
-
-struct htt_tx_selfgen_ax_stats_tlv {
-	/* 11AX */
-	u32 ax_su_ndpa;
-	u32 ax_su_ndp;
-	u32 ax_mu_mimo_ndpa;
-	u32 ax_mu_mimo_ndp;
-	u32 ax_mu_mimo_brpoll_1; /* MU user 1 */
-	u32 ax_mu_mimo_brpoll_2; /* MU user 2 */
-	u32 ax_mu_mimo_brpoll_3; /* MU user 3 */
-	u32 ax_mu_mimo_brpoll_4; /* MU user 4 */
-	u32 ax_mu_mimo_brpoll_5; /* MU user 5 */
-	u32 ax_mu_mimo_brpoll_6; /* MU user 6 */
-	u32 ax_mu_mimo_brpoll_7; /* MU user 7 */
-	u32 ax_basic_trigger;
-	u32 ax_bsr_trigger;
-	u32 ax_mu_bar_trigger;
-	u32 ax_mu_rts_trigger;
-};
-
-struct htt_tx_selfgen_ac_err_stats_tlv {
-	/* 11AC error stats */
-	u32 ac_su_ndp_err;
-	u32 ac_su_ndpa_err;
-	u32 ac_mu_mimo_ndpa_err;
-	u32 ac_mu_mimo_ndp_err;
-	u32 ac_mu_mimo_brp1_err;
-	u32 ac_mu_mimo_brp2_err;
-	u32 ac_mu_mimo_brp3_err;
-};
-
-struct htt_tx_selfgen_ax_err_stats_tlv {
-	/* 11AX error stats */
-	u32 ax_su_ndp_err;
-	u32 ax_su_ndpa_err;
-	u32 ax_mu_mimo_ndpa_err;
-	u32 ax_mu_mimo_ndp_err;
-	u32 ax_mu_mimo_brp1_err;
-	u32 ax_mu_mimo_brp2_err;
-	u32 ax_mu_mimo_brp3_err;
-	u32 ax_mu_mimo_brp4_err;
-	u32 ax_mu_mimo_brp5_err;
-	u32 ax_mu_mimo_brp6_err;
-	u32 ax_mu_mimo_brp7_err;
-	u32 ax_basic_trigger_err;
-	u32 ax_bsr_trigger_err;
-	u32 ax_mu_bar_trigger_err;
-	u32 ax_mu_rts_trigger_err;
-};
-
-/* == TX MU STATS == */
-#define HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS 4
-#define HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS 8
-#define HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS    74
-
-struct htt_tx_pdev_mu_mimo_sch_stats_tlv {
-	/* mu-mimo sw sched cmd stats */
-	u32 mu_mimo_sch_posted;
-	u32 mu_mimo_sch_failed;
-	/* MU PPDU stats per hwQ */
-	u32 mu_mimo_ppdu_posted;
-	/*
-	 * Counts the number of users in each transmission of
-	 * the given TX mode.
-	 *
-	 * Index is the number of users - 1.
-	 */
-	u32 ac_mu_mimo_sch_nusers[HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS];
-	u32 ax_mu_mimo_sch_nusers[HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS];
-	u32 ax_ofdma_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
-};
-
-struct htt_tx_pdev_mu_mimo_mpdu_stats_tlv {
-	u32 mu_mimo_mpdus_queued_usr;
-	u32 mu_mimo_mpdus_tried_usr;
-	u32 mu_mimo_mpdus_failed_usr;
-	u32 mu_mimo_mpdus_requeued_usr;
-	u32 mu_mimo_err_no_ba_usr;
-	u32 mu_mimo_mpdu_underrun_usr;
-	u32 mu_mimo_ampdu_underrun_usr;
-
-	u32 ax_mu_mimo_mpdus_queued_usr;
-	u32 ax_mu_mimo_mpdus_tried_usr;
-	u32 ax_mu_mimo_mpdus_failed_usr;
-	u32 ax_mu_mimo_mpdus_requeued_usr;
-	u32 ax_mu_mimo_err_no_ba_usr;
-	u32 ax_mu_mimo_mpdu_underrun_usr;
-	u32 ax_mu_mimo_ampdu_underrun_usr;
-
-	u32 ax_ofdma_mpdus_queued_usr;
-	u32 ax_ofdma_mpdus_tried_usr;
-	u32 ax_ofdma_mpdus_failed_usr;
-	u32 ax_ofdma_mpdus_requeued_usr;
-	u32 ax_ofdma_err_no_ba_usr;
-	u32 ax_ofdma_mpdu_underrun_usr;
-	u32 ax_ofdma_ampdu_underrun_usr;
-};
-
-#define HTT_STATS_TX_SCHED_MODE_MU_MIMO_AC  1
-#define HTT_STATS_TX_SCHED_MODE_MU_MIMO_AX  2
-#define HTT_STATS_TX_SCHED_MODE_MU_OFDMA_AX 3
-
-struct htt_tx_pdev_mpdu_stats_tlv {
-	/* mpdu level stats */
-	u32 mpdus_queued_usr;
-	u32 mpdus_tried_usr;
-	u32 mpdus_failed_usr;
-	u32 mpdus_requeued_usr;
-	u32 err_no_ba_usr;
-	u32 mpdu_underrun_usr;
-	u32 ampdu_underrun_usr;
-	u32 user_index;
-	u32 tx_sched_mode; /* HTT_STATS_TX_SCHED_MODE_xxx */
-};
-
-/* == TX SCHED STATS == */
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_sched_txq_cmd_posted_tlv_v {
-	u32 sched_cmd_posted[0]; /* HTT_TX_PDEV_SCHED_TX_MODE_MAX */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_sched_txq_cmd_reaped_tlv_v {
-	u32 sched_cmd_reaped[0]; /* HTT_TX_PDEV_SCHED_TX_MODE_MAX */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_sched_txq_sched_order_su_tlv_v {
-	u32 sched_order_su[0]; /* HTT_TX_PDEV_NUM_SCHED_ORDER_LOG */
-};
-
-enum htt_sched_txq_sched_ineligibility_tlv_enum {
-	HTT_SCHED_TID_SKIP_SCHED_MASK_DISABLED = 0,
-	HTT_SCHED_TID_SKIP_NOTIFY_MPDU,
-	HTT_SCHED_TID_SKIP_MPDU_STATE_INVALID,
-	HTT_SCHED_TID_SKIP_SCHED_DISABLED,
-	HTT_SCHED_TID_SKIP_TQM_BYPASS_CMD_PENDING,
-	HTT_SCHED_TID_SKIP_SECOND_SU_SCHEDULE,
-
-	HTT_SCHED_TID_SKIP_CMD_SLOT_NOT_AVAIL,
-	HTT_SCHED_TID_SKIP_NO_ENQ,
-	HTT_SCHED_TID_SKIP_LOW_ENQ,
-	HTT_SCHED_TID_SKIP_PAUSED,
-	HTT_SCHED_TID_SKIP_UL,
-	HTT_SCHED_TID_REMOVE_PAUSED,
-	HTT_SCHED_TID_REMOVE_NO_ENQ,
-	HTT_SCHED_TID_REMOVE_UL,
-	HTT_SCHED_TID_QUERY,
-	HTT_SCHED_TID_SU_ONLY,
-	HTT_SCHED_TID_ELIGIBLE,
-	HTT_SCHED_INELIGIBILITY_MAX,
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_sched_txq_sched_ineligibility_tlv_v {
-	/* indexed by htt_sched_txq_sched_ineligibility_tlv_enum */
-	u32 sched_ineligibility[0];
-};
-
-struct htt_tx_pdev_stats_sched_per_txq_tlv {
-	u32 mac_id__txq_id__word;
-	u32 sched_policy;
-	u32 last_sched_cmd_posted_timestamp;
-	u32 last_sched_cmd_compl_timestamp;
-	u32 sched_2_tac_lwm_count;
-	u32 sched_2_tac_ring_full;
-	u32 sched_cmd_post_failure;
-	u32 num_active_tids;
-	u32 num_ps_schedules;
-	u32 sched_cmds_pending;
-	u32 num_tid_register;
-	u32 num_tid_unregister;
-	u32 num_qstats_queried;
-	u32 qstats_update_pending;
-	u32 last_qstats_query_timestamp;
-	u32 num_tqm_cmdq_full;
-	u32 num_de_sched_algo_trigger;
-	u32 num_rt_sched_algo_trigger;
-	u32 num_tqm_sched_algo_trigger;
-	u32 notify_sched;
-	u32 dur_based_sendn_term;
-};
-
-struct htt_stats_tx_sched_cmn_tlv {
-	/* BIT [ 7 :  0]   :- mac_id
-	 * BIT [31 :  8]   :- reserved
-	 */
-	u32 mac_id__word;
-	/* Current timestamp */
-	u32 current_timestamp;
-};
-
-/* == TQM STATS == */
-#define HTT_TX_TQM_MAX_GEN_MPDU_END_REASON          16
-#define HTT_TX_TQM_MAX_LIST_MPDU_END_REASON         16
-#define HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS 16
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_tqm_gen_mpdu_stats_tlv_v {
-	u32 gen_mpdu_end_reason[0]; /* HTT_TX_TQM_MAX_GEN_MPDU_END_REASON */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_tqm_list_mpdu_stats_tlv_v {
-	u32 list_mpdu_end_reason[0]; /* HTT_TX_TQM_MAX_LIST_MPDU_END_REASON */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_tx_tqm_list_mpdu_cnt_tlv_v {
-	u32 list_mpdu_cnt_hist[0];
-			/* HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS */
-};
-
-struct htt_tx_tqm_pdev_stats_tlv_v {
-	u32 msdu_count;
-	u32 mpdu_count;
-	u32 remove_msdu;
-	u32 remove_mpdu;
-	u32 remove_msdu_ttl;
-	u32 send_bar;
-	u32 bar_sync;
-	u32 notify_mpdu;
-	u32 sync_cmd;
-	u32 write_cmd;
-	u32 hwsch_trigger;
-	u32 ack_tlv_proc;
-	u32 gen_mpdu_cmd;
-	u32 gen_list_cmd;
-	u32 remove_mpdu_cmd;
-	u32 remove_mpdu_tried_cmd;
-	u32 mpdu_queue_stats_cmd;
-	u32 mpdu_head_info_cmd;
-	u32 msdu_flow_stats_cmd;
-	u32 remove_msdu_cmd;
-	u32 remove_msdu_ttl_cmd;
-	u32 flush_cache_cmd;
-	u32 update_mpduq_cmd;
-	u32 enqueue;
-	u32 enqueue_notify;
-	u32 notify_mpdu_at_head;
-	u32 notify_mpdu_state_valid;
-	/*
-	 * On receiving TQM_FLOW_NOT_EMPTY_STATUS from TQM, (on MSDUs being enqueued
-	 * the flow is non empty), if the number of MSDUs is greater than the threshold,
-	 * notify is incremented. UDP_THRESH counters are for UDP MSDUs, and NONUDP are
-	 * for non-UDP MSDUs.
-	 * MSDUQ_SWNOTIFY_UDP_THRESH1 threshold    - sched_udp_notify1 is incremented
-	 * MSDUQ_SWNOTIFY_UDP_THRESH2 threshold    - sched_udp_notify2 is incremented
-	 * MSDUQ_SWNOTIFY_NONUDP_THRESH1 threshold - sched_nonudp_notify1 is incremented
-	 * MSDUQ_SWNOTIFY_NONUDP_THRESH2 threshold - sched_nonudp_notify2 is incremented
-	 *
-	 * Notify signifies that we trigger the scheduler.
-	 */
-	u32 sched_udp_notify1;
-	u32 sched_udp_notify2;
-	u32 sched_nonudp_notify1;
-	u32 sched_nonudp_notify2;
-};
-
-struct htt_tx_tqm_cmn_stats_tlv {
-	u32 mac_id__word;
-	u32 max_cmdq_id;
-	u32 list_mpdu_cnt_hist_intvl;
-
-	/* Global stats */
-	u32 add_msdu;
-	u32 q_empty;
-	u32 q_not_empty;
-	u32 drop_notification;
-	u32 desc_threshold;
-};
-
-struct htt_tx_tqm_error_stats_tlv {
-	/* Error stats */
-	u32 q_empty_failure;
-	u32 q_not_empty_failure;
-	u32 add_msdu_failure;
-};
-
-/* == TQM CMDQ stats == */
-struct htt_tx_tqm_cmdq_status_tlv {
-	u32 mac_id__cmdq_id__word;
-	u32 sync_cmd;
-	u32 write_cmd;
-	u32 gen_mpdu_cmd;
-	u32 mpdu_queue_stats_cmd;
-	u32 mpdu_head_info_cmd;
-	u32 msdu_flow_stats_cmd;
-	u32 remove_mpdu_cmd;
-	u32 remove_msdu_cmd;
-	u32 flush_cache_cmd;
-	u32 update_mpduq_cmd;
-	u32 update_msduq_cmd;
-};
-
-/* == TX-DE STATS == */
-/* Structures for tx de stats */
-struct htt_tx_de_eapol_packets_stats_tlv {
-	u32 m1_packets;
-	u32 m2_packets;
-	u32 m3_packets;
-	u32 m4_packets;
-	u32 g1_packets;
-	u32 g2_packets;
-};
-
-struct htt_tx_de_classify_failed_stats_tlv {
-	u32 ap_bss_peer_not_found;
-	u32 ap_bcast_mcast_no_peer;
-	u32 sta_delete_in_progress;
-	u32 ibss_no_bss_peer;
-	u32 invalid_vdev_type;
-	u32 invalid_ast_peer_entry;
-	u32 peer_entry_invalid;
-	u32 ethertype_not_ip;
-	u32 eapol_lookup_failed;
-	u32 qpeer_not_allow_data;
-	u32 fse_tid_override;
-	u32 ipv6_jumbogram_zero_length;
-	u32 qos_to_non_qos_in_prog;
-};
-
-struct htt_tx_de_classify_stats_tlv {
-	u32 arp_packets;
-	u32 igmp_packets;
-	u32 dhcp_packets;
-	u32 host_inspected;
-	u32 htt_included;
-	u32 htt_valid_mcs;
-	u32 htt_valid_nss;
-	u32 htt_valid_preamble_type;
-	u32 htt_valid_chainmask;
-	u32 htt_valid_guard_interval;
-	u32 htt_valid_retries;
-	u32 htt_valid_bw_info;
-	u32 htt_valid_power;
-	u32 htt_valid_key_flags;
-	u32 htt_valid_no_encryption;
-	u32 fse_entry_count;
-	u32 fse_priority_be;
-	u32 fse_priority_high;
-	u32 fse_priority_low;
-	u32 fse_traffic_ptrn_be;
-	u32 fse_traffic_ptrn_over_sub;
-	u32 fse_traffic_ptrn_bursty;
-	u32 fse_traffic_ptrn_interactive;
-	u32 fse_traffic_ptrn_periodic;
-	u32 fse_hwqueue_alloc;
-	u32 fse_hwqueue_created;
-	u32 fse_hwqueue_send_to_host;
-	u32 mcast_entry;
-	u32 bcast_entry;
-	u32 htt_update_peer_cache;
-	u32 htt_learning_frame;
-	u32 fse_invalid_peer;
-	/*
-	 * mec_notify is HTT TX WBM multicast echo check notification
-	 * from firmware to host.  FW sends SA addresses to host for all
-	 * multicast/broadcast packets received on STA side.
-	 */
-	u32    mec_notify;
-};
-
-struct htt_tx_de_classify_status_stats_tlv {
-	u32 eok;
-	u32 classify_done;
-	u32 lookup_failed;
-	u32 send_host_dhcp;
-	u32 send_host_mcast;
-	u32 send_host_unknown_dest;
-	u32 send_host;
-	u32 status_invalid;
-};
-
-struct htt_tx_de_enqueue_packets_stats_tlv {
-	u32 enqueued_pkts;
-	u32 to_tqm;
-	u32 to_tqm_bypass;
-};
-
-struct htt_tx_de_enqueue_discard_stats_tlv {
-	u32 discarded_pkts;
-	u32 local_frames;
-	u32 is_ext_msdu;
-};
-
-struct htt_tx_de_compl_stats_tlv {
-	u32 tcl_dummy_frame;
-	u32 tqm_dummy_frame;
-	u32 tqm_notify_frame;
-	u32 fw2wbm_enq;
-	u32 tqm_bypass_frame;
-};
-
-/*
- *  The htt_tx_de_fw2wbm_ring_full_hist_tlv is a histogram of time we waited
- *  for the fw2wbm ring buffer.  we are requesting a buffer in FW2WBM release
- *  ring,which may fail, due to non availability of buffer. Hence we sleep for
- *  200us & again request for it. This is a histogram of time we wait, with
- *  bin of 200ms & there are 10 bin (2 seconds max)
- *  They are defined by the following macros in FW
- *  #define ENTRIES_PER_BIN_COUNT 1000  // per bin 1000 * 200us = 200ms
- *  #define RING_FULL_BIN_ENTRIES (WAL_TX_DE_FW2WBM_ALLOC_TIMEOUT_COUNT /
- *                               ENTRIES_PER_BIN_COUNT)
- */
-struct htt_tx_de_fw2wbm_ring_full_hist_tlv {
-	u32 fw2wbm_ring_full_hist[0];
-};
-
-struct htt_tx_de_cmn_stats_tlv {
-	u32   mac_id__word;
-
-	/* Global Stats */
-	u32   tcl2fw_entry_count;
-	u32   not_to_fw;
-	u32   invalid_pdev_vdev_peer;
-	u32   tcl_res_invalid_addrx;
-	u32   wbm2fw_entry_count;
-	u32   invalid_pdev;
-};
-
-/* == RING-IF STATS == */
-#define HTT_STATS_LOW_WM_BINS      5
-#define HTT_STATS_HIGH_WM_BINS     5
-
-struct htt_ring_if_stats_tlv {
-	u32 base_addr; /* DWORD aligned base memory address of the ring */
-	u32 elem_size;
-	u32 num_elems__prefetch_tail_idx;
-	u32 head_idx__tail_idx;
-	u32 shadow_head_idx__shadow_tail_idx;
-	u32 num_tail_incr;
-	u32 lwm_thresh__hwm_thresh;
-	u32 overrun_hit_count;
-	u32 underrun_hit_count;
-	u32 prod_blockwait_count;
-	u32 cons_blockwait_count;
-	u32 low_wm_hit_count[HTT_STATS_LOW_WM_BINS];
-	u32 high_wm_hit_count[HTT_STATS_HIGH_WM_BINS];
-};
-
-struct htt_ring_if_cmn_tlv {
-	u32 mac_id__word;
-	u32 num_records;
-};
-
-/* == SFM STATS == */
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_sfm_client_user_tlv_v {
-	/* Number of DWORDS used per user and per client */
-	u32 dwords_used_by_user_n[0];
-};
-
-struct htt_sfm_client_tlv {
-	/* Client ID */
-	u32 client_id;
-	/* Minimum number of buffers */
-	u32 buf_min;
-	/* Maximum number of buffers */
-	u32 buf_max;
-	/* Number of Busy buffers */
-	u32 buf_busy;
-	/* Number of Allocated buffers */
-	u32 buf_alloc;
-	/* Number of Available/Usable buffers */
-	u32 buf_avail;
-	/* Number of users */
-	u32 num_users;
-};
-
-struct htt_sfm_cmn_tlv {
-	u32 mac_id__word;
-	/* Indicates the total number of 128 byte buffers
-	 * in the CMEM that are available for buffer sharing
-	 */
-	u32 buf_total;
-	/* Indicates for certain client or all the clients
-	 * there is no dowrd saved in SFM, refer to SFM_R1_MEM_EMPTY
-	 */
-	u32 mem_empty;
-	/* DEALLOCATE_BUFFERS, refer to register SFM_R0_DEALLOCATE_BUFFERS */
-	u32 deallocate_bufs;
-	/* Number of Records */
-	u32 num_records;
-};
-
-/* == SRNG STATS == */
-struct htt_sring_stats_tlv {
-	u32 mac_id__ring_id__arena__ep;
-	u32 base_addr_lsb; /* DWORD aligned base memory address of the ring */
-	u32 base_addr_msb;
-	u32 ring_size;
-	u32 elem_size;
-
-	u32 num_avail_words__num_valid_words;
-	u32 head_ptr__tail_ptr;
-	u32 consumer_empty__producer_full;
-	u32 prefetch_count__internal_tail_ptr;
-};
-
-struct htt_sring_cmn_tlv {
-	u32 num_records;
-};
-
-/* == PDEV TX RATE CTRL STATS == */
-#define HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS        12
-#define HTT_TX_PDEV_STATS_NUM_GI_COUNTERS          4
-#define HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS         5
-#define HTT_TX_PDEV_STATS_NUM_BW_COUNTERS          4
-#define HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS      8
-#define HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
-#define HTT_TX_PDEV_STATS_NUM_LEGACY_CCK_STATS     4
-#define HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS    8
-#define HTT_TX_PDEV_STATS_NUM_LTF                  4
-
-#define HTT_TX_NUM_OF_SOUNDING_STATS_WORDS \
-	(HTT_TX_PDEV_STATS_NUM_BW_COUNTERS * \
-	 HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS)
-
-struct htt_tx_pdev_rate_stats_tlv {
-	u32 mac_id__word;
-	u32 tx_ldpc;
-	u32 rts_cnt;
-	/* RSSI value of last ack packet (units = dB above noise floor) */
-	u32 ack_rssi;
-
-	u32 tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-
-	u32 tx_su_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 tx_mu_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-
-	/* element 0,1, ...7 -> NSS 1,2, ...8 */
-	u32 tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
-	u32 tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
-	u32 tx_stbc[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 tx_pream[HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES];
-
-	/* Counters to track number of tx packets
-	 * in each GI (400us, 800us, 1600us & 3200us) in each mcs (0-11)
-	 */
-	u32 tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS][HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-
-	/* Counters to track packets in dcm mcs (MCS 0, 1, 3, 4) */
-	u32 tx_dcm[HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS];
-	/* Number of CTS-acknowledged RTS packets */
-	u32 rts_success;
-
-	/*
-	 * Counters for legacy 11a and 11b transmissions.
-	 *
-	 * The index corresponds to:
-	 *
-	 * CCK: 0: 1 Mbps, 1: 2 Mbps, 2: 5.5 Mbps, 3: 11 Mbps
-	 *
-	 * OFDM: 0: 6 Mbps, 1: 9 Mbps, 2: 12 Mbps, 3: 18 Mbps,
-	 *       4: 24 Mbps, 5: 36 Mbps, 6: 48 Mbps, 7: 54 Mbps
-	 */
-	u32 tx_legacy_cck_rate[HTT_TX_PDEV_STATS_NUM_LEGACY_CCK_STATS];
-	u32 tx_legacy_ofdm_rate[HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
-
-	u32 ac_mu_mimo_tx_ldpc;
-	u32 ax_mu_mimo_tx_ldpc;
-	u32 ofdma_tx_ldpc;
-
-	/*
-	 * Counters for 11ax HE LTF selection during TX.
-	 *
-	 * The index corresponds to:
-	 *
-	 * 0: unused, 1: 1x LTF, 2: 2x LTF, 3: 4x LTF
-	 */
-	u32 tx_he_ltf[HTT_TX_PDEV_STATS_NUM_LTF];
-
-	u32 ac_mu_mimo_tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 ax_mu_mimo_tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 ofdma_tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-
-	u32 ac_mu_mimo_tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-	u32 ax_mu_mimo_tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-	u32 ofdma_tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-
-	u32 ac_mu_mimo_tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
-	u32 ax_mu_mimo_tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
-	u32 ofdma_tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
-
-	u32 ac_mu_mimo_tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
-			    [HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 ax_mu_mimo_tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
-			    [HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 ofdma_tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
-		       [HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
-};
-
-/* == PDEV RX RATE CTRL STATS == */
-#define HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS     4
-#define HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS    8
-#define HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS        12
-#define HTT_RX_PDEV_STATS_NUM_GI_COUNTERS          4
-#define HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS         5
-#define HTT_RX_PDEV_STATS_NUM_BW_COUNTERS          4
-#define HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS      8
-#define HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
-#define HTT_RX_PDEV_MAX_OFDMA_NUM_USER             8
-#define HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS 16
-
-struct htt_rx_pdev_rate_stats_tlv {
-	u32 mac_id__word;
-	u32 nsts;
-
-	u32 rx_ldpc;
-	u32 rts_cnt;
-
-	u32 rssi_mgmt; /* units = dB above noise floor */
-	u32 rssi_data; /* units = dB above noise floor */
-	u32 rssi_comb; /* units = dB above noise floor */
-	u32 rx_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
-	/* element 0,1, ...7 -> NSS 1,2, ...8 */
-	u32 rx_nss[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-	u32 rx_dcm[HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS];
-	u32 rx_stbc[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
-	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
-	u32 rx_bw[HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
-	u32 rx_pream[HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES];
-	u8 rssi_chain[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
-		     [HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
-					/* units = dB above noise floor */
-
-	/* Counters to track number of rx packets
-	 * in each GI in each mcs (0-11)
-	 */
-	u32 rx_gi[HTT_RX_PDEV_STATS_NUM_GI_COUNTERS][HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
-	s32 rssi_in_dbm; /* rx Signal Strength value in dBm unit */
-
-	u32 rx_11ax_su_ext;
-	u32 rx_11ac_mumimo;
-	u32 rx_11ax_mumimo;
-	u32 rx_11ax_ofdma;
-	u32 txbf;
-	u32 rx_legacy_cck_rate[HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS];
-	u32 rx_legacy_ofdm_rate[HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
-	u32 rx_active_dur_us_low;
-	u32 rx_active_dur_us_high;
-
-	u32 rx_11ax_ul_ofdma;
-
-	u32 ul_ofdma_rx_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 ul_ofdma_rx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
-			  [HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
-	u32 ul_ofdma_rx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-	u32 ul_ofdma_rx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
-	u32 ul_ofdma_rx_stbc;
-	u32 ul_ofdma_rx_ldpc;
-
-	/* record the stats for each user index */
-	u32 rx_ulofdma_non_data_ppdu[HTT_RX_PDEV_MAX_OFDMA_NUM_USER]; /* ppdu level */
-	u32 rx_ulofdma_data_ppdu[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];     /* ppdu level */
-	u32 rx_ulofdma_mpdu_ok[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];       /* mpdu level */
-	u32 rx_ulofdma_mpdu_fail[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];     /* mpdu level */
-
-	u32 nss_count;
-	u32 pilot_count;
-	/* RxEVM stats in dB */
-	s32 rx_pilot_evm_db[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
-			   [HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS];
-	/* rx_pilot_evm_db_mean:
-	 * EVM mean across pilots, computed as
-	 *     mean(10*log10(rx_pilot_evm_linear)) = mean(rx_pilot_evm_db)
-	 */
-	s32 rx_pilot_evm_db_mean[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS];
-	s8 rx_ul_fd_rssi[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
-			[HTT_RX_PDEV_MAX_OFDMA_NUM_USER]; /* dBm units */
-	/* per_chain_rssi_pkt_type:
-	 * This field shows what type of rx frame the per-chain RSSI was computed
-	 * on, by recording the frame type and sub-type as bit-fields within this
-	 * field:
-	 * BIT [3 : 0]    :- IEEE80211_FC0_TYPE
-	 * BIT [7 : 4]    :- IEEE80211_FC0_SUBTYPE
-	 * BIT [31 : 8]   :- Reserved
-	 */
-	u32 per_chain_rssi_pkt_type;
-	s8 rx_per_chain_rssi_in_dbm[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
-				   [HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
-};
-
-/* == RX PDEV/SOC STATS == */
-struct htt_rx_soc_fw_stats_tlv {
-	u32 fw_reo_ring_data_msdu;
-	u32 fw_to_host_data_msdu_bcmc;
-	u32 fw_to_host_data_msdu_uc;
-	u32 ofld_remote_data_buf_recycle_cnt;
-	u32 ofld_remote_free_buf_indication_cnt;
-
-	u32 ofld_buf_to_host_data_msdu_uc;
-	u32 reo_fw_ring_to_host_data_msdu_uc;
-
-	u32 wbm_sw_ring_reap;
-	u32 wbm_forward_to_host_cnt;
-	u32 wbm_target_recycle_cnt;
-
-	u32 target_refill_ring_recycle_cnt;
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_rx_soc_fw_refill_ring_empty_tlv_v {
-	u32 refill_ring_empty_cnt[0]; /* HTT_RX_STATS_REFILL_MAX_RING */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_rx_soc_fw_refill_ring_num_refill_tlv_v {
-	u32 refill_ring_num_refill[0]; /* HTT_RX_STATS_REFILL_MAX_RING */
-};
-
-/* RXDMA error code from WBM released packets */
-enum htt_rx_rxdma_error_code_enum {
-	HTT_RX_RXDMA_OVERFLOW_ERR                           = 0,
-	HTT_RX_RXDMA_MPDU_LENGTH_ERR                        = 1,
-	HTT_RX_RXDMA_FCS_ERR                                = 2,
-	HTT_RX_RXDMA_DECRYPT_ERR                            = 3,
-	HTT_RX_RXDMA_TKIP_MIC_ERR                           = 4,
-	HTT_RX_RXDMA_UNECRYPTED_ERR                         = 5,
-	HTT_RX_RXDMA_MSDU_LEN_ERR                           = 6,
-	HTT_RX_RXDMA_MSDU_LIMIT_ERR                         = 7,
-	HTT_RX_RXDMA_WIFI_PARSE_ERR                         = 8,
-	HTT_RX_RXDMA_AMSDU_PARSE_ERR                        = 9,
-	HTT_RX_RXDMA_SA_TIMEOUT_ERR                         = 10,
-	HTT_RX_RXDMA_DA_TIMEOUT_ERR                         = 11,
-	HTT_RX_RXDMA_FLOW_TIMEOUT_ERR                       = 12,
-	HTT_RX_RXDMA_FLUSH_REQUEST                          = 13,
-	HTT_RX_RXDMA_ERR_CODE_RVSD0                         = 14,
-	HTT_RX_RXDMA_ERR_CODE_RVSD1                         = 15,
-
-	/* This MAX_ERR_CODE should not be used in any host/target messages,
-	 * so that even though it is defined within a host/target interface
-	 * definition header file, it isn't actually part of the host/target
-	 * interface, and thus can be modified.
-	 */
-	HTT_RX_RXDMA_MAX_ERR_CODE
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v {
-	u32 rxdma_err[0]; /* HTT_RX_RXDMA_MAX_ERR_CODE */
-};
-
-/* REO error code from WBM released packets */
-enum htt_rx_reo_error_code_enum {
-	HTT_RX_REO_QUEUE_DESC_ADDR_ZERO                     = 0,
-	HTT_RX_REO_QUEUE_DESC_NOT_VALID                     = 1,
-	HTT_RX_AMPDU_IN_NON_BA                              = 2,
-	HTT_RX_NON_BA_DUPLICATE                             = 3,
-	HTT_RX_BA_DUPLICATE                                 = 4,
-	HTT_RX_REGULAR_FRAME_2K_JUMP                        = 5,
-	HTT_RX_BAR_FRAME_2K_JUMP                            = 6,
-	HTT_RX_REGULAR_FRAME_OOR                            = 7,
-	HTT_RX_BAR_FRAME_OOR                                = 8,
-	HTT_RX_BAR_FRAME_NO_BA_SESSION                      = 9,
-	HTT_RX_BAR_FRAME_SN_EQUALS_SSN                      = 10,
-	HTT_RX_PN_CHECK_FAILED                              = 11,
-	HTT_RX_2K_ERROR_HANDLING_FLAG_SET                   = 12,
-	HTT_RX_PN_ERROR_HANDLING_FLAG_SET                   = 13,
-	HTT_RX_QUEUE_DESCRIPTOR_BLOCKED_SET                 = 14,
-	HTT_RX_REO_ERR_CODE_RVSD                            = 15,
-
-	/* This MAX_ERR_CODE should not be used in any host/target messages,
-	 * so that even though it is defined within a host/target interface
-	 * definition header file, it isn't actually part of the host/target
-	 * interface, and thus can be modified.
-	 */
-	HTT_RX_REO_MAX_ERR_CODE
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_rx_soc_fw_refill_ring_num_reo_err_tlv_v {
-	u32 reo_err[0]; /* HTT_RX_REO_MAX_ERR_CODE */
-};
-
-/* == RX PDEV STATS == */
-#define HTT_STATS_SUBTYPE_MAX     16
-
-struct htt_rx_pdev_fw_stats_tlv {
-	u32 mac_id__word;
-	u32 ppdu_recvd;
-	u32 mpdu_cnt_fcs_ok;
-	u32 mpdu_cnt_fcs_err;
-	u32 tcp_msdu_cnt;
-	u32 tcp_ack_msdu_cnt;
-	u32 udp_msdu_cnt;
-	u32 other_msdu_cnt;
-	u32 fw_ring_mpdu_ind;
-	u32 fw_ring_mgmt_subtype[HTT_STATS_SUBTYPE_MAX];
-	u32 fw_ring_ctrl_subtype[HTT_STATS_SUBTYPE_MAX];
-	u32 fw_ring_mcast_data_msdu;
-	u32 fw_ring_bcast_data_msdu;
-	u32 fw_ring_ucast_data_msdu;
-	u32 fw_ring_null_data_msdu;
-	u32 fw_ring_mpdu_drop;
-	u32 ofld_local_data_ind_cnt;
-	u32 ofld_local_data_buf_recycle_cnt;
-	u32 drx_local_data_ind_cnt;
-	u32 drx_local_data_buf_recycle_cnt;
-	u32 local_nondata_ind_cnt;
-	u32 local_nondata_buf_recycle_cnt;
-
-	u32 fw_status_buf_ring_refill_cnt;
-	u32 fw_status_buf_ring_empty_cnt;
-	u32 fw_pkt_buf_ring_refill_cnt;
-	u32 fw_pkt_buf_ring_empty_cnt;
-	u32 fw_link_buf_ring_refill_cnt;
-	u32 fw_link_buf_ring_empty_cnt;
-
-	u32 host_pkt_buf_ring_refill_cnt;
-	u32 host_pkt_buf_ring_empty_cnt;
-	u32 mon_pkt_buf_ring_refill_cnt;
-	u32 mon_pkt_buf_ring_empty_cnt;
-	u32 mon_status_buf_ring_refill_cnt;
-	u32 mon_status_buf_ring_empty_cnt;
-	u32 mon_desc_buf_ring_refill_cnt;
-	u32 mon_desc_buf_ring_empty_cnt;
-	u32 mon_dest_ring_update_cnt;
-	u32 mon_dest_ring_full_cnt;
-
-	u32 rx_suspend_cnt;
-	u32 rx_suspend_fail_cnt;
-	u32 rx_resume_cnt;
-	u32 rx_resume_fail_cnt;
-	u32 rx_ring_switch_cnt;
-	u32 rx_ring_restore_cnt;
-	u32 rx_flush_cnt;
-	u32 rx_recovery_reset_cnt;
-};
-
-#define HTT_STATS_PHY_ERR_MAX 43
-
-struct htt_rx_pdev_fw_stats_phy_err_tlv {
-	u32 mac_id__word;
-	u32 total_phy_err_cnt;
-	/* Counts of different types of phy errs
-	 * The mapping of PHY error types to phy_err array elements is HW dependent.
-	 * The only currently-supported mapping is shown below:
-	 *
-	 * 0 phyrx_err_phy_off Reception aborted due to receiving a PHY_OFF TLV
-	 * 1 phyrx_err_synth_off
-	 * 2 phyrx_err_ofdma_timing
-	 * 3 phyrx_err_ofdma_signal_parity
-	 * 4 phyrx_err_ofdma_rate_illegal
-	 * 5 phyrx_err_ofdma_length_illegal
-	 * 6 phyrx_err_ofdma_restart
-	 * 7 phyrx_err_ofdma_service
-	 * 8 phyrx_err_ppdu_ofdma_power_drop
-	 * 9 phyrx_err_cck_blokker
-	 * 10 phyrx_err_cck_timing
-	 * 11 phyrx_err_cck_header_crc
-	 * 12 phyrx_err_cck_rate_illegal
-	 * 13 phyrx_err_cck_length_illegal
-	 * 14 phyrx_err_cck_restart
-	 * 15 phyrx_err_cck_service
-	 * 16 phyrx_err_cck_power_drop
-	 * 17 phyrx_err_ht_crc_err
-	 * 18 phyrx_err_ht_length_illegal
-	 * 19 phyrx_err_ht_rate_illegal
-	 * 20 phyrx_err_ht_zlf
-	 * 21 phyrx_err_false_radar_ext
-	 * 22 phyrx_err_green_field
-	 * 23 phyrx_err_bw_gt_dyn_bw
-	 * 24 phyrx_err_leg_ht_mismatch
-	 * 25 phyrx_err_vht_crc_error
-	 * 26 phyrx_err_vht_siga_unsupported
-	 * 27 phyrx_err_vht_lsig_len_invalid
-	 * 28 phyrx_err_vht_ndp_or_zlf
-	 * 29 phyrx_err_vht_nsym_lt_zero
-	 * 30 phyrx_err_vht_rx_extra_symbol_mismatch
-	 * 31 phyrx_err_vht_rx_skip_group_id0
-	 * 32 phyrx_err_vht_rx_skip_group_id1to62
-	 * 33 phyrx_err_vht_rx_skip_group_id63
-	 * 34 phyrx_err_ofdm_ldpc_decoder_disabled
-	 * 35 phyrx_err_defer_nap
-	 * 36 phyrx_err_fdomain_timeout
-	 * 37 phyrx_err_lsig_rel_check
-	 * 38 phyrx_err_bt_collision
-	 * 39 phyrx_err_unsupported_mu_feedback
-	 * 40 phyrx_err_ppdu_tx_interrupt_rx
-	 * 41 phyrx_err_unsupported_cbf
-	 * 42 phyrx_err_other
-	 */
-	u32 phy_err[HTT_STATS_PHY_ERR_MAX];
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_rx_pdev_fw_ring_mpdu_err_tlv_v {
-	/* Num error MPDU for each RxDMA error type  */
-	u32 fw_ring_mpdu_err[0]; /* HTT_RX_STATS_RXDMA_MAX_ERR */
-};
-
-/* NOTE: Variable length TLV, use length spec to infer array size */
-struct htt_rx_pdev_fw_mpdu_drop_tlv_v {
-	/* Num MPDU dropped  */
-	u32 fw_mpdu_drop[0]; /* HTT_RX_STATS_FW_DROP_REASON_MAX */
-};
-
-#define HTT_PDEV_CCA_STATS_TX_FRAME_INFO_PRESENT               (0x1)
-#define HTT_PDEV_CCA_STATS_RX_FRAME_INFO_PRESENT               (0x2)
-#define HTT_PDEV_CCA_STATS_RX_CLEAR_INFO_PRESENT               (0x4)
-#define HTT_PDEV_CCA_STATS_MY_RX_FRAME_INFO_PRESENT            (0x8)
-#define HTT_PDEV_CCA_STATS_USEC_CNT_INFO_PRESENT              (0x10)
-#define HTT_PDEV_CCA_STATS_MED_RX_IDLE_INFO_PRESENT           (0x20)
-#define HTT_PDEV_CCA_STATS_MED_TX_IDLE_GLOBAL_INFO_PRESENT    (0x40)
-#define HTT_PDEV_CCA_STATS_CCA_OBBS_USEC_INFO_PRESENT         (0x80)
-
-struct htt_pdev_stats_cca_counters_tlv {
-	/* Below values are obtained from the HW Cycles counter registers */
-	u32 tx_frame_usec;
-	u32 rx_frame_usec;
-	u32 rx_clear_usec;
-	u32 my_rx_frame_usec;
-	u32 usec_cnt;
-	u32 med_rx_idle_usec;
-	u32 med_tx_idle_global_usec;
-	u32 cca_obss_usec;
-};
-
-struct htt_pdev_cca_stats_hist_v1_tlv {
-	u32    chan_num;
-	/* num of CCA records (Num of htt_pdev_stats_cca_counters_tlv)*/
-	u32    num_records;
-	u32    valid_cca_counters_bitmap;
-	u32    collection_interval;
-
-	/* This will be followed by an array which contains the CCA stats
-	 * collected in the last N intervals,
-	 * if the indication is for last N intervals CCA stats.
-	 * Then the pdev_cca_stats[0] element contains the oldest CCA stats
-	 * and pdev_cca_stats[N-1] will have the most recent CCA stats.
-	 * htt_pdev_stats_cca_counters_tlv cca_hist_tlv[1];
-	 */
-};
-
-struct htt_pdev_stats_twt_session_tlv {
-	u32 vdev_id;
-	struct htt_mac_addr peer_mac;
-	u32 flow_id_flags;
-
-	/* TWT_DIALOG_ID_UNAVAILABLE is used
-	 * when TWT session is not initiated by host
-	 */
-	u32 dialog_id;
-	u32 wake_dura_us;
-	u32 wake_intvl_us;
-	u32 sp_offset_us;
-};
-
-struct htt_pdev_stats_twt_sessions_tlv {
-	u32 pdev_id;
-	u32 num_sessions;
-	struct htt_pdev_stats_twt_session_tlv twt_session[];
-};
-
-enum htt_rx_reo_resource_sample_id_enum {
-	/* Global link descriptor queued in REO */
-	HTT_RX_REO_RESOURCE_GLOBAL_LINK_DESC_COUNT_0           = 0,
-	HTT_RX_REO_RESOURCE_GLOBAL_LINK_DESC_COUNT_1           = 1,
-	HTT_RX_REO_RESOURCE_GLOBAL_LINK_DESC_COUNT_2           = 2,
-	/*Number of queue descriptors of this aging group */
-	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC0                   = 3,
-	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC1                   = 4,
-	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC2                   = 5,
-	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC3                   = 6,
-	/* Total number of MSDUs buffered in AC */
-	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC0               = 7,
-	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC1               = 8,
-	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC2               = 9,
-	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC3               = 10,
-
-	HTT_RX_REO_RESOURCE_STATS_MAX                          = 16
-};
-
-struct htt_rx_reo_resource_stats_tlv_v {
-	/* Variable based on the Number of records. HTT_RX_REO_RESOURCE_STATS_MAX */
-	u32 sample_id;
-	u32 total_max;
-	u32 total_avg;
-	u32 total_sample;
-	u32 non_zeros_avg;
-	u32 non_zeros_sample;
-	u32 last_non_zeros_max;
-	u32 last_non_zeros_min;
-	u32 last_non_zeros_avg;
-	u32 last_non_zeros_sample;
-};
-
-/* == TX SOUNDING STATS == */
-
-enum htt_txbf_sound_steer_modes {
-	HTT_IMPLICIT_TXBF_STEER_STATS                = 0,
-	HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS        = 1,
-	HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS         = 2,
-	HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS        = 3,
-	HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS         = 4,
-	HTT_TXBF_MAX_NUM_OF_MODES                    = 5
-};
-
-enum htt_stats_sounding_tx_mode {
-	HTT_TX_AC_SOUNDING_MODE                      = 0,
-	HTT_TX_AX_SOUNDING_MODE                      = 1,
-};
-
-struct htt_tx_sounding_stats_tlv {
-	u32 tx_sounding_mode; /* HTT_TX_XX_SOUNDING_MODE */
-	/* Counts number of soundings for all steering modes in each bw */
-	u32 cbf_20[HTT_TXBF_MAX_NUM_OF_MODES];
-	u32 cbf_40[HTT_TXBF_MAX_NUM_OF_MODES];
-	u32 cbf_80[HTT_TXBF_MAX_NUM_OF_MODES];
-	u32 cbf_160[HTT_TXBF_MAX_NUM_OF_MODES];
-	/*
-	 * The sounding array is a 2-D array stored as an 1-D array of
-	 * u32. The stats for a particular user/bw combination is
-	 * referenced with the following:
-	 *
-	 *          sounding[(user* max_bw) + bw]
-	 *
-	 * ... where max_bw == 4 for 160mhz
-	 */
-	u32 sounding[HTT_TX_NUM_OF_SOUNDING_STATS_WORDS];
-};
-
-struct htt_pdev_obss_pd_stats_tlv {
-	u32        num_obss_tx_ppdu_success;
-	u32        num_obss_tx_ppdu_failure;
-};
-
-void ath11k_debug_htt_stats_init(struct ath11k *ar);
-
-struct htt_ring_backpressure_stats_tlv {
-	u32 pdev_id;
-	u32 current_head_idx;
-	u32 current_tail_idx;
-	u32 num_htt_msgs_sent;
-	/* Time in milliseconds for which the ring has been in
-	 * its current backpressure condition
-	 */
-	u32 backpressure_time_ms;
-	/* backpressure_hist - histogram showing how many times
-	 * different degrees of backpressure duration occurred:
-	 * Index 0 indicates the number of times ring was
-	 * continuously in backpressure state for 100 - 200ms.
-	 * Index 1 indicates the number of times ring was
-	 * continuously in backpressure state for 200 - 300ms.
-	 * Index 2 indicates the number of times ring was
-	 * continuously in backpressure state for 300 - 400ms.
-	 * Index 3 indicates the number of times ring was
-	 * continuously in backpressure state for 400 - 500ms.
-	 * Index 4 indicates the number of times ring was
-	 * continuously in backpressure state beyond 500ms.
-	 */
-	u32 backpressure_hist[5];
-};
-
-#endif
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 7ac5f69cb6ad..5193b308a992 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -10,7 +10,7 @@
 #include "wmi.h"
 #include "hal_rx.h"
 #include "dp_tx.h"
-#include "debug_htt_stats.h"
+#include "debugfs_htt_stats.h"
 #include "peer.h"
 
 static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
@@ -1081,7 +1081,7 @@ int ath11k_debugfs_register(struct ath11k *ar)
 	snprintf(buf, 100, "../../ath11k/%pd2", ar->debug.debugfs_pdev);
 	debugfs_create_symlink("ath11k", ar->hw->wiphy->debugfsdir, buf);
 
-	ath11k_debug_htt_stats_init(ar);
+	ath11k_debugfs_htt_stats_init(ar);
 
 	ath11k_debugfs_fw_stats_init(ar);
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
new file mode 100644
index 000000000000..6f6e8ca014a1
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -0,0 +1,4598 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/vmalloc.h>
+#include "core.h"
+#include "dp_tx.h"
+#include "dp_rx.h"
+#include "debug.h"
+#include "debugfs_htt_stats.h"
+
+#define HTT_DBG_OUT(buf, len, fmt, ...) \
+			scnprintf(buf, len, fmt "\n", ##__VA_ARGS__)
+
+#define HTT_MAX_STRING_LEN 256
+#define HTT_MAX_PRINT_CHAR_PER_ELEM 15
+
+#define HTT_TLV_HDR_LEN 4
+
+#define ARRAY_TO_STRING(out, arr, len)							\
+	do {										\
+		int index = 0; u8 i;							\
+		for (i = 0; i < len; i++) {						\
+			index += scnprintf(out + index, HTT_MAX_STRING_LEN - index,	\
+					  " %u:%u,", i, arr[i]);			\
+			if (index < 0 || index >= HTT_MAX_STRING_LEN)			\
+				break;							\
+		}									\
+	} while (0)
+
+static inline void htt_print_stats_string_tlv(const void *tag_buf,
+					      u16 tag_len,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_stats_string_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u8  i;
+	u16 index = 0;
+	char data[HTT_MAX_STRING_LEN] = {0};
+
+	tag_len = tag_len >> 2;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:");
+
+	for (i = 0; i < tag_len; i++) {
+		index += scnprintf(&data[index],
+				HTT_MAX_STRING_LEN - index,
+				"%.*s", 4, (char *)&(htt_stats_buf->data[i]));
+		if (index >= HTT_MAX_STRING_LEN)
+			break;
+	}
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "data = %s\n", data);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf,
+						   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_queued = %u",
+			   htt_stats_buf->hw_queued);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_reaped = %u",
+			   htt_stats_buf->hw_reaped);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun = %u",
+			   htt_stats_buf->underrun);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_paused = %u",
+			   htt_stats_buf->hw_paused);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_flush = %u",
+			   htt_stats_buf->hw_flush);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_filt = %u",
+			   htt_stats_buf->hw_filt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort = %u",
+			   htt_stats_buf->tx_abort);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_requeued = %u",
+			   htt_stats_buf->mpdu_requed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_xretry = %u",
+			   htt_stats_buf->tx_xretry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "data_rc = %u",
+			   htt_stats_buf->data_rc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_dropped_xretry = %u",
+			   htt_stats_buf->mpdu_dropped_xretry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "illegal_rate_phy_err = %u",
+			   htt_stats_buf->illgl_rate_phy_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cont_xretry = %u",
+			   htt_stats_buf->cont_xretry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_timeout = %u",
+			   htt_stats_buf->tx_timeout);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_resets = %u",
+			   htt_stats_buf->pdev_resets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_underrun = %u",
+			   htt_stats_buf->phy_underrun);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_ovf = %u",
+			   htt_stats_buf->txop_ovf);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_posted = %u",
+			   htt_stats_buf->seq_posted);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_failed_queueing = %u",
+			   htt_stats_buf->seq_failed_queueing);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_completed = %u",
+			   htt_stats_buf->seq_completed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_restarted = %u",
+			   htt_stats_buf->seq_restarted);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_seq_posted = %u",
+			   htt_stats_buf->mu_seq_posted);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_switch_hw_paused = %u",
+			   htt_stats_buf->seq_switch_hw_paused);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "next_seq_posted_dsr = %u",
+			   htt_stats_buf->next_seq_posted_dsr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_posted_isr = %u",
+			   htt_stats_buf->seq_posted_isr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_ctrl_cached = %u",
+			   htt_stats_buf->seq_ctrl_cached);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_count_tqm = %u",
+			   htt_stats_buf->mpdu_count_tqm);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_count_tqm = %u",
+			   htt_stats_buf->msdu_count_tqm);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_removed_tqm = %u",
+			   htt_stats_buf->mpdu_removed_tqm);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_removed_tqm = %u",
+			   htt_stats_buf->msdu_removed_tqm);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_sw_flush = %u",
+			   htt_stats_buf->mpdus_sw_flush);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_hw_filter = %u",
+			   htt_stats_buf->mpdus_hw_filter);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_truncated = %u",
+			   htt_stats_buf->mpdus_truncated);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_ack_failed = %u",
+			   htt_stats_buf->mpdus_ack_failed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_expired = %u",
+			   htt_stats_buf->mpdus_expired);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_seq_hw_retry = %u",
+			   htt_stats_buf->mpdus_seq_hw_retry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
+			   htt_stats_buf->ack_tlv_proc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "coex_abort_mpdu_cnt_valid = %u",
+			   htt_stats_buf->coex_abort_mpdu_cnt_valid);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "coex_abort_mpdu_cnt = %u",
+			   htt_stats_buf->coex_abort_mpdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_total_ppdus_tried_ota = %u",
+			   htt_stats_buf->num_total_ppdus_tried_ota);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_tried_ota = %u",
+			   htt_stats_buf->num_data_ppdus_tried_ota);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_ctrl_mgmt_enqued = %u",
+			   htt_stats_buf->local_ctrl_mgmt_enqued);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_ctrl_mgmt_freed = %u",
+			   htt_stats_buf->local_ctrl_mgmt_freed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_data_enqued = %u",
+			   htt_stats_buf->local_data_enqued);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_data_freed = %u",
+			   htt_stats_buf->local_data_freed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_tried = %u",
+			   htt_stats_buf->mpdu_tried);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "isr_wait_seq_posted = %u",
+			   htt_stats_buf->isr_wait_seq_posted);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_active_dur_us_low = %u",
+			   htt_stats_buf->tx_active_dur_us_low);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_active_dur_us_high = %u\n",
+			   htt_stats_buf->tx_active_dur_us_high);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_urrn_tlv_v(const void *tag_buf,
+				   u16 tag_len,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_urrn_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char urrn_stats[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_URRN_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_URRN_TLV_V:");
+
+	ARRAY_TO_STRING(urrn_stats, htt_stats_buf->urrn_stats, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "urrn_stats = %s\n", urrn_stats);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_flush_tlv_v(const void *tag_buf,
+				    u16 tag_len,
+				    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_flush_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char flush_errs[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_FLUSH_REASON_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_FLUSH_TLV_V:");
+
+	ARRAY_TO_STRING(flush_errs, htt_stats_buf->flush_errs, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_errs = %s\n", flush_errs);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_sifs_tlv_v(const void *tag_buf,
+				   u16 tag_len,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_sifs_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char sifs_status[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_SIFS_TLV_V:");
+
+	ARRAY_TO_STRING(sifs_status, htt_stats_buf->sifs_status, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_status = %s\n",
+			   sifs_status);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_phy_err_tlv_v(const void *tag_buf,
+				      u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_phy_err_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char phy_errs[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_PHY_ERR_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_PHY_ERR_TLV_V:");
+
+	ARRAY_TO_STRING(phy_errs, htt_stats_buf->phy_errs, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_sifs_hist_tlv_v(const void *tag_buf,
+					u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_sifs_hist_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char sifs_hist_status[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_PDEV_STATS_SIFS_HIST_TLV_V:");
+
+	ARRAY_TO_STRING(sifs_hist_status, htt_stats_buf->sifs_hist_status, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_hist_status = %s\n",
+			   sifs_hist_status);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_tx_ppdu_stats_tlv_v(const void *tag_buf,
+					    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_tx_ppdu_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_PDEV_STATS_TX_PPDU_STATS_TLV_V:");
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_legacy_su = %u",
+			   htt_stats_buf->num_data_ppdus_legacy_su);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ac_su = %u",
+			   htt_stats_buf->num_data_ppdus_ac_su);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ax_su = %u",
+			   htt_stats_buf->num_data_ppdus_ax_su);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ac_su_txbf = %u",
+			   htt_stats_buf->num_data_ppdus_ac_su_txbf);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ax_su_txbf = %u\n",
+			   htt_stats_buf->num_data_ppdus_ax_su_txbf);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
+						  u16 tag_len,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char tried_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
+	u32  num_elements = ((tag_len - sizeof(htt_stats_buf->hist_bin_size)) >> 2);
+	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_PDEV_STATS_TRIED_MPDU_CNT_HIST_TLV_V:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u",
+			   htt_stats_buf->hist_bin_size);
+
+	if (required_buffer_size < HTT_MAX_STRING_LEN) {
+		ARRAY_TO_STRING(tried_mpdu_cnt_hist,
+				htt_stats_buf->tried_mpdu_cnt_hist,
+				num_elements);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "tried_mpdu_cnt_hist = %s\n",
+				   tried_mpdu_cnt_hist);
+	} else {
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "INSUFFICIENT PRINT BUFFER\n");
+	}
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_hw_stats_intr_misc_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_hw_stats_intr_misc_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN + 1] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_INTR_MISC_TLV:");
+	memcpy(hw_intr_name, &(htt_stats_buf->hw_intr_name[0]),
+	       HTT_STATS_MAX_HW_INTR_NAME_LEN);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_intr_name = %s ", hw_intr_name);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mask = %u",
+			   htt_stats_buf->mask);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
+			   htt_stats_buf->count);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_hw_stats_wd_timeout_tlv(const void *tag_buf,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_hw_stats_wd_timeout_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN + 1] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_WD_TIMEOUT_TLV:");
+	memcpy(hw_module_name, &(htt_stats_buf->hw_module_name[0]),
+	       HTT_STATS_MAX_HW_MODULE_NAME_LEN);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_module_name = %s ",
+			   hw_module_name);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u",
+			   htt_stats_buf->count);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_hw_stats_pdev_errs_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_hw_stats_pdev_errs_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_PDEV_ERRS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort = %u",
+			   htt_stats_buf->tx_abort);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort_fail_count = %u",
+			   htt_stats_buf->tx_abort_fail_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_abort = %u",
+			   htt_stats_buf->rx_abort);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_abort_fail_count = %u",
+			   htt_stats_buf->rx_abort_fail_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "warm_reset = %u",
+			   htt_stats_buf->warm_reset);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cold_reset = %u",
+			   htt_stats_buf->cold_reset);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_flush = %u",
+			   htt_stats_buf->tx_flush);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_glb_reset = %u",
+			   htt_stats_buf->tx_glb_reset);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_txq_reset = %u",
+			   htt_stats_buf->tx_txq_reset);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_timeout_reset = %u\n",
+			   htt_stats_buf->rx_timeout_reset);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_msdu_flow_stats_tlv(const void *tag_buf,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_msdu_flow_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_MSDU_FLOW_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_update_timestamp = %u",
+			   htt_stats_buf->last_update_timestamp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_add_timestamp = %u",
+			   htt_stats_buf->last_add_timestamp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_remove_timestamp = %u",
+			   htt_stats_buf->last_remove_timestamp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_processed_msdu_count = %u",
+			   htt_stats_buf->total_processed_msdu_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cur_msdu_count_in_flowq = %u",
+			   htt_stats_buf->cur_msdu_count_in_flowq);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
+			   htt_stats_buf->sw_peer_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_flow_no = %u",
+			   htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
+			   (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xF0000) >>
+			   16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "drop_rule = %u",
+			   (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0x100000) >>
+			   20);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_enqueue_count = %u",
+			   htt_stats_buf->last_cycle_enqueue_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_dequeue_count = %u",
+			   htt_stats_buf->last_cycle_dequeue_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_drop_count = %u",
+			   htt_stats_buf->last_cycle_drop_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_drop_th = %u\n",
+			   htt_stats_buf->current_drop_th);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_tid_stats_tlv(const void *tag_buf,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tid_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TID_STATS_TLV:");
+	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
+			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
+			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sched_pending = %u",
+			   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ppdu_in_hwq = %u",
+			   (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
+			   0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_flags = 0x%x",
+			   htt_stats_buf->tid_flags);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_queued = %u",
+			   htt_stats_buf->hw_queued);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_reaped = %u",
+			   htt_stats_buf->hw_reaped);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_hw_filter = %u",
+			   htt_stats_buf->mpdus_hw_filter);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_bytes = %u",
+			   htt_stats_buf->qdepth_bytes);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_msdu = %u",
+			   htt_stats_buf->qdepth_num_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_mpdu = %u",
+			   htt_stats_buf->qdepth_num_mpdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_scheduled_tsmp = %u",
+			   htt_stats_buf->last_scheduled_tsmp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_module_id = %u",
+			   htt_stats_buf->pause_module_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_module_id = %u\n",
+			   htt_stats_buf->block_module_id);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_tid_stats_v1_tlv(const void *tag_buf,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tid_stats_v1_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TID_STATS_V1_TLV:");
+	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
+			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
+			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sched_pending = %u",
+			   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ppdu_in_hwq = %u",
+			   (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
+			   0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_flags = 0x%x",
+			   htt_stats_buf->tid_flags);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_qdepth_bytes = %u",
+			   htt_stats_buf->max_qdepth_bytes);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_qdepth_n_msdus = %u",
+			   htt_stats_buf->max_qdepth_n_msdus);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rsvd = %u",
+			   htt_stats_buf->rsvd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_bytes = %u",
+			   htt_stats_buf->qdepth_bytes);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_msdu = %u",
+			   htt_stats_buf->qdepth_num_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_mpdu = %u",
+			   htt_stats_buf->qdepth_num_mpdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_scheduled_tsmp = %u",
+			   htt_stats_buf->last_scheduled_tsmp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_module_id = %u",
+			   htt_stats_buf->pause_module_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_module_id = %u",
+			   htt_stats_buf->block_module_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "allow_n_flags = 0x%x",
+			   htt_stats_buf->allow_n_flags);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sendn_frms_allowed = %u\n",
+			   htt_stats_buf->sendn_frms_allowed);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_rx_tid_stats_tlv(const void *tag_buf,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_tid_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_TID_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
+			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
+			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_in_reorder = %u",
+			   htt_stats_buf->dup_in_reorder);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_past_outside_window = %u",
+			   htt_stats_buf->dup_past_outside_window);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_past_within_window = %u",
+			   htt_stats_buf->dup_past_within_window);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdesc_err_decrypt = %u\n",
+			   htt_stats_buf->rxdesc_err_decrypt);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_counter_tlv(const void *tag_buf,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_counter_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char counter_name[HTT_MAX_STRING_LEN] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_COUNTER_TLV:");
+
+	ARRAY_TO_STRING(counter_name,
+			htt_stats_buf->counter_name,
+			HTT_MAX_COUNTER_NAME);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "counter_name = %s ", counter_name);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
+			   htt_stats_buf->count);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_peer_stats_cmn_tlv(const void *tag_buf,
+						struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_peer_stats_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PEER_STATS_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ppdu_cnt = %u",
+			   htt_stats_buf->ppdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt = %u",
+			   htt_stats_buf->mpdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_cnt = %u",
+			   htt_stats_buf->msdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_bitmap = %u",
+			   htt_stats_buf->pause_bitmap);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_bitmap = %u",
+			   htt_stats_buf->block_bitmap);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_rssi = %d",
+			   htt_stats_buf->rssi);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueued_count = %llu",
+			   htt_stats_buf->peer_enqueued_count_low |
+			   ((u64)htt_stats_buf->peer_enqueued_count_high << 32));
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dequeued_count = %llu",
+			   htt_stats_buf->peer_dequeued_count_low |
+			   ((u64)htt_stats_buf->peer_dequeued_count_high << 32));
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dropped_count = %llu",
+			   htt_stats_buf->peer_dropped_count_low |
+			   ((u64)htt_stats_buf->peer_dropped_count_high << 32));
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "transmitted_ppdu_bytes = %llu",
+			   htt_stats_buf->ppdu_transmitted_bytes_low |
+			   ((u64)htt_stats_buf->ppdu_transmitted_bytes_high << 32));
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ttl_removed_count = %u",
+			   htt_stats_buf->peer_ttl_removed_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "inactive_time = %u\n",
+			   htt_stats_buf->inactive_time);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_peer_details_tlv(const void *tag_buf,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_peer_details_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PEER_DETAILS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_type = %u",
+			   htt_stats_buf->peer_type);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
+			   htt_stats_buf->sw_peer_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "vdev_id = %u",
+			   htt_stats_buf->vdev_pdev_ast_idx & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
+			   (htt_stats_buf->vdev_pdev_ast_idx & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ast_idx = %u",
+			   (htt_stats_buf->vdev_pdev_ast_idx & 0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "mac_addr = %02x:%02x:%02x:%02x:%02x:%02x",
+			   htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF,
+			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF00) >> 8,
+			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF0000) >> 16,
+			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF000000) >> 24,
+			   (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF),
+			   (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_flags = 0x%x",
+			   htt_stats_buf->peer_flags);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qpeer_flags = 0x%x\n",
+			   htt_stats_buf->qpeer_flags);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_peer_rate_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char str_buf[HTT_MAX_STRING_LEN] = {0};
+	char *tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
+	u8 j;
+
+	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
+		tx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!tx_gi[j])
+			goto fail;
+	}
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PEER_RATE_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_ldpc = %u",
+			   htt_stats_buf->tx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
+			   htt_stats_buf->rts_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_rssi = %u",
+			   htt_stats_buf->ack_rssi);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_su_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_su_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mu_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mu_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf,
+			htt_stats_buf->tx_nss,
+			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf,
+			htt_stats_buf->tx_bw,
+			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_stbc,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_pream,
+			HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
+
+	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(tx_gi[j],
+				htt_stats_buf->tx_gi[j],
+				HTT_TX_PEER_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
+				j, tx_gi[j]);
+	}
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf,
+			htt_stats_buf->tx_dcm,
+			HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+
+fail:
+	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++)
+		kfree(tx_gi[j]);
+}
+
+static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_peer_rate_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u8 j;
+	char *rssi_chain[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS] = {NULL};
+	char *rx_gi[HTT_RX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
+	char str_buf[HTT_MAX_STRING_LEN] = {0};
+
+	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
+		rssi_chain[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!rssi_chain[j])
+			goto fail;
+	}
+
+	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
+		rx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!rx_gi[j])
+			goto fail;
+	}
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PEER_RATE_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "nsts = %u",
+			   htt_stats_buf->nsts);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ldpc = %u",
+			   htt_stats_buf->rx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
+			   htt_stats_buf->rts_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_mgmt = %u",
+			   htt_stats_buf->rssi_mgmt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_data = %u",
+			   htt_stats_buf->rssi_data);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_comb = %u",
+			   htt_stats_buf->rssi_comb);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_mcs,
+			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_nss,
+			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_dcm,
+			HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_stbc,
+			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_bw,
+			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
+
+	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
+		ARRAY_TO_STRING(rssi_chain[j], htt_stats_buf->rssi_chain[j],
+				HTT_RX_PEER_STATS_NUM_BW_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
+				   j, rssi_chain[j]);
+	}
+
+	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->rx_gi[j],
+				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
+				j, rx_gi[j]);
+	}
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_pream,
+			HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s\n", str_buf);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+
+fail:
+	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++)
+		kfree(rssi_chain[j]);
+
+	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++)
+		kfree(rx_gi[j]);
+}
+
+static inline void
+htt_print_tx_hwq_mu_mimo_sch_stats_tlv(const void *tag_buf,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_mu_mimo_sch_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_SCH_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_posted = %u",
+			   htt_stats_buf->mu_mimo_sch_posted);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_failed = %u",
+			   htt_stats_buf->mu_mimo_sch_failed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n",
+			   htt_stats_buf->mu_mimo_ppdu_posted);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_mu_mimo_mpdu_stats_tlv(const void *tag_buf,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_mu_mimo_mpdu_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_HWQ_MU_MIMO_MPDU_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_queued_usr = %u",
+			   htt_stats_buf->mu_mimo_mpdus_queued_usr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_tried_usr = %u",
+			   htt_stats_buf->mu_mimo_mpdus_tried_usr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_failed_usr = %u",
+			   htt_stats_buf->mu_mimo_mpdus_failed_usr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_requeued_usr = %u",
+			   htt_stats_buf->mu_mimo_mpdus_requeued_usr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_err_no_ba_usr = %u",
+			   htt_stats_buf->mu_mimo_err_no_ba_usr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdu_underrun_usr = %u",
+			   htt_stats_buf->mu_mimo_mpdu_underrun_usr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ampdu_underrun_usr = %u\n",
+			   htt_stats_buf->mu_mimo_ampdu_underrun_usr);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_mu_mimo_cmn_stats_tlv(const void *tag_buf,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_mu_mimo_cmn_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_CMN_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__hwq_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwq_id = %u\n",
+			   (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_stats_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	/* TODO: HKDBG */
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__hwq_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwq_id = %u",
+			   (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "xretry = %u",
+			   htt_stats_buf->xretry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun_cnt = %u",
+			   htt_stats_buf->underrun_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cnt = %u",
+			   htt_stats_buf->flush_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "filt_cnt = %u",
+			   htt_stats_buf->filt_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "null_mpdu_bmap = %u",
+			   htt_stats_buf->null_mpdu_bmap);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "user_ack_failure = %u",
+			   htt_stats_buf->user_ack_failure);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
+			   htt_stats_buf->ack_tlv_proc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_id_proc = %u",
+			   htt_stats_buf->sched_id_proc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "null_mpdu_tx_count = %u",
+			   htt_stats_buf->null_mpdu_tx_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_bmap_not_recvd = %u",
+			   htt_stats_buf->mpdu_bmap_not_recvd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_bar = %u",
+			   htt_stats_buf->num_bar);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts = %u",
+			   htt_stats_buf->rts);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cts2self = %u",
+			   htt_stats_buf->cts2self);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_null = %u",
+			   htt_stats_buf->qos_null);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_tried_cnt = %u",
+			   htt_stats_buf->mpdu_tried_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queued_cnt = %u",
+			   htt_stats_buf->mpdu_queued_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_ack_fail_cnt = %u",
+			   htt_stats_buf->mpdu_ack_fail_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_filt_cnt = %u",
+			   htt_stats_buf->mpdu_filt_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "false_mpdu_ack_count = %u",
+			   htt_stats_buf->false_mpdu_ack_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "txq_timeout = %u\n",
+			   htt_stats_buf->txq_timeout);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_difs_latency_stats_tlv_v(const void *tag_buf,
+					  u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_difs_latency_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u16 data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS);
+	char difs_latency_hist[HTT_MAX_STRING_LEN] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_HWQ_DIFS_LATENCY_STATS_TLV_V:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hist_intvl = %u",
+			htt_stats_buf->hist_intvl);
+
+	ARRAY_TO_STRING(difs_latency_hist, htt_stats_buf->difs_latency_hist,
+			data_len);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "difs_latency_hist = %s\n",
+			difs_latency_hist);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_cmd_result_stats_tlv_v(const void *tag_buf,
+					u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_cmd_result_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u16 data_len;
+	char cmd_result[HTT_MAX_STRING_LEN] = {0};
+
+	data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_RESULT_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_HWQ_CMD_RESULT_STATS_TLV_V:");
+
+	ARRAY_TO_STRING(cmd_result, htt_stats_buf->cmd_result, data_len);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_result = %s\n", cmd_result);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_cmd_stall_stats_tlv_v(const void *tag_buf,
+				       u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_cmd_stall_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u16 num_elems;
+	char cmd_stall_status[HTT_MAX_STRING_LEN] = {0};
+
+	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_STALL_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_CMD_STALL_STATS_TLV_V:");
+
+	ARRAY_TO_STRING(cmd_stall_status, htt_stats_buf->cmd_stall_status, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_stall_status = %s\n",
+			   cmd_stall_status);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_fes_result_stats_tlv_v(const void *tag_buf,
+					u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_fes_result_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u16 num_elems;
+	char fes_result[HTT_MAX_STRING_LEN] = {0};
+
+	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_FES_RESULT_STATS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_HWQ_FES_RESULT_STATS_TLV_V:");
+
+	ARRAY_TO_STRING(fes_result, htt_stats_buf->fes_result, num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fes_result = %s\n", fes_result);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
+					   u16 tag_len,
+					   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_tried_mpdu_cnt_hist_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char tried_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
+	u32  num_elements = ((tag_len -
+			    sizeof(htt_stats_buf->hist_bin_size)) >> 2);
+	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_HWQ_TRIED_MPDU_CNT_HIST_TLV_V:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u",
+			   htt_stats_buf->hist_bin_size);
+
+	if (required_buffer_size < HTT_MAX_STRING_LEN) {
+		ARRAY_TO_STRING(tried_mpdu_cnt_hist,
+				htt_stats_buf->tried_mpdu_cnt_hist,
+				num_elements);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "tried_mpdu_cnt_hist = %s\n",
+				   tried_mpdu_cnt_hist);
+	} else {
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "INSUFFICIENT PRINT BUFFER ");
+	}
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(const void *tag_buf,
+					  u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_hwq_txop_used_cnt_hist_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char txop_used_cnt_hist[HTT_MAX_STRING_LEN] = {0};
+	u32 num_elements = tag_len >> 2;
+	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_HWQ_TXOP_USED_CNT_HIST_TLV_V:");
+
+	if (required_buffer_size < HTT_MAX_STRING_LEN) {
+		ARRAY_TO_STRING(txop_used_cnt_hist,
+				htt_stats_buf->txop_used_cnt_hist,
+				num_elements);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_used_cnt_hist = %s\n",
+				   txop_used_cnt_hist);
+	} else {
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "INSUFFICIENT PRINT BUFFER ");
+	}
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_sounding_stats_tlv(const void *tag_buf,
+						   struct debug_htt_stats_req *stats_req)
+{
+	s32 i;
+	const struct htt_tx_sounding_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	const u32 *cbf_20 = htt_stats_buf->cbf_20;
+	const u32 *cbf_40 = htt_stats_buf->cbf_40;
+	const u32 *cbf_80 = htt_stats_buf->cbf_80;
+	const u32 *cbf_160 = htt_stats_buf->cbf_160;
+
+	if (htt_stats_buf->tx_sounding_mode == HTT_TX_AC_SOUNDING_MODE) {
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "\nHTT_TX_AC_SOUNDING_STATS_TLV:\n");
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ac_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u ",
+				   cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ac_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
+				   cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ac_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
+				   cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ac_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
+				   cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+
+		for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS; i++) {
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u ",
+					   i,
+					   htt_stats_buf->sounding[0],
+					   htt_stats_buf->sounding[1],
+					   htt_stats_buf->sounding[2],
+					   htt_stats_buf->sounding[3]);
+		}
+	} else if (htt_stats_buf->tx_sounding_mode == HTT_TX_AX_SOUNDING_MODE) {
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "\nHTT_TX_AX_SOUNDING_STATS_TLV:\n");
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u ",
+				   cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
+				   cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
+				   cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
+				   cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				   cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+
+		for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS; i++) {
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u ",
+					   i,
+					   htt_stats_buf->sounding[0],
+					   htt_stats_buf->sounding[1],
+					   htt_stats_buf->sounding[2],
+					   htt_stats_buf->sounding[3]);
+		}
+	}
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_selfgen_cmn_stats_tlv(const void *tag_buf,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_selfgen_cmn_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_CMN_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "su_bar = %u",
+			   htt_stats_buf->su_bar);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts = %u",
+			   htt_stats_buf->rts);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cts2self = %u",
+			   htt_stats_buf->cts2self);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_null = %u",
+			   htt_stats_buf->qos_null);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_1 = %u",
+			   htt_stats_buf->delayed_bar_1);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_2 = %u",
+			   htt_stats_buf->delayed_bar_2);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_3 = %u",
+			   htt_stats_buf->delayed_bar_3);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_4 = %u",
+			   htt_stats_buf->delayed_bar_4);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_5 = %u",
+			   htt_stats_buf->delayed_bar_5);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_6 = %u",
+			   htt_stats_buf->delayed_bar_6);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_7 = %u\n",
+			   htt_stats_buf->delayed_bar_7);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_selfgen_ac_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndpa = %u",
+			   htt_stats_buf->ac_su_ndpa);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndp = %u",
+			   htt_stats_buf->ac_su_ndp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndpa = %u",
+			   htt_stats_buf->ac_mu_mimo_ndpa);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndp = %u",
+			   htt_stats_buf->ac_mu_mimo_ndp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_1 = %u",
+			   htt_stats_buf->ac_mu_mimo_brpoll_1);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_2 = %u",
+			   htt_stats_buf->ac_mu_mimo_brpoll_2);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_3 = %u\n",
+			   htt_stats_buf->ac_mu_mimo_brpoll_3);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_selfgen_ax_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndpa = %u",
+			   htt_stats_buf->ax_su_ndpa);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndp = %u",
+			   htt_stats_buf->ax_su_ndp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndpa = %u",
+			   htt_stats_buf->ax_mu_mimo_ndpa);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndp = %u",
+			   htt_stats_buf->ax_mu_mimo_ndp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_1 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_1);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_2 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_2);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_3 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_3);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_4 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_4);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_5 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_5);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_6 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_6);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_7 = %u",
+			   htt_stats_buf->ax_mu_mimo_brpoll_7);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_basic_trigger = %u",
+			   htt_stats_buf->ax_basic_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_bsr_trigger = %u",
+			   htt_stats_buf->ax_bsr_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_bar_trigger = %u",
+			   htt_stats_buf->ax_mu_bar_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_rts_trigger = %u\n",
+			   htt_stats_buf->ax_mu_rts_trigger);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_selfgen_ac_err_stats_tlv(const void *tag_buf,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_selfgen_ac_err_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_ERR_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndp_err = %u",
+			   htt_stats_buf->ac_su_ndp_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndpa_err = %u",
+			   htt_stats_buf->ac_su_ndpa_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndpa_err = %u",
+			   htt_stats_buf->ac_mu_mimo_ndpa_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndp_err = %u",
+			   htt_stats_buf->ac_mu_mimo_ndp_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp1_err = %u",
+			   htt_stats_buf->ac_mu_mimo_brp1_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp2_err = %u",
+			   htt_stats_buf->ac_mu_mimo_brp2_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp3_err = %u\n",
+			   htt_stats_buf->ac_mu_mimo_brp3_err);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_selfgen_ax_err_stats_tlv(const void *tag_buf,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_selfgen_ax_err_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_ERR_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndp_err = %u",
+			   htt_stats_buf->ax_su_ndp_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndpa_err = %u",
+			   htt_stats_buf->ax_su_ndpa_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndpa_err = %u",
+			   htt_stats_buf->ax_mu_mimo_ndpa_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndp_err = %u",
+			   htt_stats_buf->ax_mu_mimo_ndp_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp1_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp1_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp2_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp2_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp3_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp3_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp4_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp4_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp5_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp5_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp6_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp6_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp7_err = %u",
+			   htt_stats_buf->ax_mu_mimo_brp7_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_basic_trigger_err = %u",
+			   htt_stats_buf->ax_basic_trigger_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_bsr_trigger_err = %u",
+			   htt_stats_buf->ax_bsr_trigger_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_bar_trigger_err = %u",
+			   htt_stats_buf->ax_mu_bar_trigger_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_rts_trigger_err = %u\n",
+			   htt_stats_buf->ax_mu_rts_trigger_err);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_mu_mimo_sch_stats_tlv(const void *tag_buf,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_mu_mimo_sch_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u8 i;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_PDEV_MU_MIMO_SCH_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_posted = %u",
+			   htt_stats_buf->mu_mimo_sch_posted);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_failed = %u",
+			   htt_stats_buf->mu_mimo_sch_failed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n",
+			   htt_stats_buf->mu_mimo_ppdu_posted);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "11ac MU_MIMO SCH STATS:");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS; i++)
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ac_mu_mimo_sch_nusers_%u = %u",
+				   i, htt_stats_buf->ac_mu_mimo_sch_nusers[i]);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n11ax MU_MIMO SCH STATS:");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS; i++)
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_mu_mimo_sch_nusers_%u = %u",
+				   i, htt_stats_buf->ax_mu_mimo_sch_nusers[i]);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n11ax OFDMA SCH STATS:");
+
+	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++)
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_ofdma_sch_nusers_%u = %u",
+				   i, htt_stats_buf->ax_ofdma_sch_nusers[i]);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(const void *tag_buf,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_mpdu_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_MIMO_AC) {
+		if (!htt_stats_buf->user_index)
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "HTT_TX_PDEV_MU_MIMO_AC_MPDU_STATS:\n");
+
+		if (htt_stats_buf->user_index <
+		    HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS) {
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_mpdus_queued_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_queued_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_mpdus_tried_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_tried_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_mpdus_failed_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_failed_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_mpdus_requeued_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_requeued_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_err_no_ba_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->err_no_ba_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_mpdu_underrun_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdu_underrun_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ac_mu_mimo_ampdu_underrun_usr_%u = %u\n",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->ampdu_underrun_usr);
+		}
+	}
+
+	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_MIMO_AX) {
+		if (!htt_stats_buf->user_index)
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "HTT_TX_PDEV_MU_MIMO_AX_MPDU_STATS:\n");
+
+		if (htt_stats_buf->user_index <
+		    HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS) {
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_mpdus_queued_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_queued_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_mpdus_tried_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_tried_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_mpdus_failed_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_failed_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_mpdus_requeued_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_requeued_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_err_no_ba_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->err_no_ba_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_mpdu_underrun_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdu_underrun_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_mimo_ampdu_underrun_usr_%u = %u\n",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->ampdu_underrun_usr);
+		}
+	}
+
+	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_OFDMA_AX) {
+		if (!htt_stats_buf->user_index)
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "HTT_TX_PDEV_AX_MU_OFDMA_MPDU_STATS:\n");
+
+		if (htt_stats_buf->user_index < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS) {
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_mpdus_queued_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_queued_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_mpdus_tried_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_tried_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_mpdus_failed_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_failed_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_mpdus_requeued_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdus_requeued_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_err_no_ba_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->err_no_ba_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_mpdu_underrun_usr_%u = %u",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->mpdu_underrun_usr);
+			len += HTT_DBG_OUT(buf + len, buf_len - len,
+					   "ax_mu_ofdma_ampdu_underrun_usr_%u = %u\n",
+					   htt_stats_buf->user_index,
+					   htt_stats_buf->ampdu_underrun_usr);
+		}
+	}
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_sched_txq_cmd_posted_tlv_v(const void *tag_buf,
+				     u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sched_txq_cmd_posted_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char sched_cmd_posted[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV_V:");
+
+	ARRAY_TO_STRING(sched_cmd_posted, htt_stats_buf->sched_cmd_posted,
+			num_elements);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_posted = %s\n",
+			   sched_cmd_posted);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_sched_txq_cmd_reaped_tlv_v(const void *tag_buf,
+				     u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sched_txq_cmd_reaped_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char sched_cmd_reaped[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV_V:");
+
+	ARRAY_TO_STRING(sched_cmd_reaped, htt_stats_buf->sched_cmd_reaped,
+			num_elements);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_reaped = %s\n",
+			   sched_cmd_reaped);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_sched_txq_sched_order_su_tlv_v(const void *tag_buf,
+					 u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sched_txq_sched_order_su_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char sched_order_su[HTT_MAX_STRING_LEN] = {0};
+	/* each entry is u32, i.e. 4 bytes */
+	u32 sched_order_su_num_entries =
+		min_t(u32, (tag_len >> 2), HTT_TX_PDEV_NUM_SCHED_ORDER_LOG);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV_V:");
+
+	ARRAY_TO_STRING(sched_order_su, htt_stats_buf->sched_order_su,
+			sched_order_su_num_entries);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_order_su = %s\n",
+			   sched_order_su);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_sched_txq_sched_ineligibility_tlv_v(const void *tag_buf,
+					      u16 tag_len,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sched_txq_sched_ineligibility_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char sched_ineligibility[HTT_MAX_STRING_LEN] = {0};
+	/* each entry is u32, i.e. 4 bytes */
+	u32 sched_ineligibility_num_entries = tag_len >> 2;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_SCHED_TXQ_SCHED_INELIGIBILITY_V:");
+
+	ARRAY_TO_STRING(sched_ineligibility, htt_stats_buf->sched_ineligibility,
+			sched_ineligibility_num_entries);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_ineligibility = %s\n",
+			   sched_ineligibility);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_pdev_stats_sched_per_txq_tlv(const void *tag_buf,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_stats_sched_per_txq_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__txq_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "txq_id = %u",
+			   (htt_stats_buf->mac_id__txq_id__word & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_policy = %u",
+			   htt_stats_buf->sched_policy);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "last_sched_cmd_posted_timestamp = %u",
+			   htt_stats_buf->last_sched_cmd_posted_timestamp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "last_sched_cmd_compl_timestamp = %u",
+			   htt_stats_buf->last_sched_cmd_compl_timestamp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_2_tac_lwm_count = %u",
+			   htt_stats_buf->sched_2_tac_lwm_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_2_tac_ring_full = %u",
+			   htt_stats_buf->sched_2_tac_ring_full);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_post_failure = %u",
+			   htt_stats_buf->sched_cmd_post_failure);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_active_tids = %u",
+			   htt_stats_buf->num_active_tids);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ps_schedules = %u",
+			   htt_stats_buf->num_ps_schedules);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmds_pending = %u",
+			   htt_stats_buf->sched_cmds_pending);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tid_register = %u",
+			   htt_stats_buf->num_tid_register);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tid_unregister = %u",
+			   htt_stats_buf->num_tid_unregister);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_qstats_queried = %u",
+			   htt_stats_buf->num_qstats_queried);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qstats_update_pending = %u",
+			   htt_stats_buf->qstats_update_pending);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_qstats_query_timestamp = %u",
+			   htt_stats_buf->last_qstats_query_timestamp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tqm_cmdq_full = %u",
+			   htt_stats_buf->num_tqm_cmdq_full);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_de_sched_algo_trigger = %u",
+			   htt_stats_buf->num_de_sched_algo_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_rt_sched_algo_trigger = %u",
+			   htt_stats_buf->num_rt_sched_algo_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tqm_sched_algo_trigger = %u",
+			   htt_stats_buf->num_tqm_sched_algo_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_sched = %u\n",
+			   htt_stats_buf->notify_sched);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dur_based_sendn_term = %u\n",
+			   htt_stats_buf->dur_based_sendn_term);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_stats_tx_sched_cmn_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_stats_tx_sched_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_TX_SCHED_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_timestamp = %u\n",
+			   htt_stats_buf->current_timestamp);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_tqm_gen_mpdu_stats_tlv_v(const void *tag_buf,
+				      u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_gen_mpdu_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char gen_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elements = min_t(u16, (tag_len >> 2),
+				 HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV_V:");
+
+	ARRAY_TO_STRING(gen_mpdu_end_reason, htt_stats_buf->gen_mpdu_end_reason,
+			num_elements);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_end_reason = %s\n",
+			   gen_mpdu_end_reason);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_tqm_list_mpdu_stats_tlv_v(const void *tag_buf,
+				       u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_list_mpdu_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char list_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_TQM_LIST_MPDU_STATS_TLV_V:");
+
+	ARRAY_TO_STRING(list_mpdu_end_reason, htt_stats_buf->list_mpdu_end_reason,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_end_reason = %s\n",
+			   list_mpdu_end_reason);
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_tqm_list_mpdu_cnt_tlv_v(const void *tag_buf,
+				     u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_list_mpdu_cnt_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char list_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:");
+
+	ARRAY_TO_STRING(list_mpdu_cnt_hist, htt_stats_buf->list_mpdu_cnt_hist,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist = %s\n",
+			   list_mpdu_cnt_hist);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_tqm_pdev_stats_tlv_v(const void *tag_buf,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_pdev_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_PDEV_STATS_TLV_V:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_count = %u",
+			   htt_stats_buf->msdu_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_count = %u",
+			   htt_stats_buf->mpdu_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu = %u",
+			   htt_stats_buf->remove_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu = %u",
+			   htt_stats_buf->remove_mpdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_ttl = %u",
+			   htt_stats_buf->remove_msdu_ttl);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_bar = %u",
+			   htt_stats_buf->send_bar);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "bar_sync = %u",
+			   htt_stats_buf->bar_sync);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu = %u",
+			   htt_stats_buf->notify_mpdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sync_cmd = %u",
+			   htt_stats_buf->sync_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "write_cmd = %u",
+			   htt_stats_buf->write_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_trigger = %u",
+			   htt_stats_buf->hwsch_trigger);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
+			   htt_stats_buf->ack_tlv_proc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_cmd = %u",
+			   htt_stats_buf->gen_mpdu_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_list_cmd = %u",
+			   htt_stats_buf->gen_list_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_cmd = %u",
+			   htt_stats_buf->remove_mpdu_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_tried_cmd = %u",
+			   htt_stats_buf->remove_mpdu_tried_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u",
+			   htt_stats_buf->mpdu_queue_stats_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_head_info_cmd = %u",
+			   htt_stats_buf->mpdu_head_info_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u",
+			   htt_stats_buf->msdu_flow_stats_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_cmd = %u",
+			   htt_stats_buf->remove_msdu_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_ttl_cmd = %u",
+			   htt_stats_buf->remove_msdu_ttl_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cache_cmd = %u",
+			   htt_stats_buf->flush_cache_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_mpduq_cmd = %u",
+			   htt_stats_buf->update_mpduq_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueue = %u",
+			   htt_stats_buf->enqueue);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueue_notify = %u",
+			   htt_stats_buf->enqueue_notify);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu_at_head = %u",
+			   htt_stats_buf->notify_mpdu_at_head);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu_state_valid = %u",
+			   htt_stats_buf->notify_mpdu_state_valid);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_udp_notify1 = %u",
+			   htt_stats_buf->sched_udp_notify1);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_udp_notify2 = %u",
+			   htt_stats_buf->sched_udp_notify2);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_nonudp_notify1 = %u",
+			   htt_stats_buf->sched_nonudp_notify1);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_nonudp_notify2 = %u\n",
+			   htt_stats_buf->sched_nonudp_notify2);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_tqm_cmn_stats_tlv(const void *tag_buf,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_cmn_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_CMN_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_cmdq_id = %u",
+			   htt_stats_buf->max_cmdq_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist_intvl = %u",
+			   htt_stats_buf->list_mpdu_cnt_hist_intvl);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "add_msdu = %u",
+			   htt_stats_buf->add_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_empty = %u",
+			   htt_stats_buf->q_empty);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_not_empty = %u",
+			   htt_stats_buf->q_not_empty);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "drop_notification = %u",
+			   htt_stats_buf->drop_notification);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "desc_threshold = %u\n",
+			   htt_stats_buf->desc_threshold);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_tqm_error_stats_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_error_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_ERROR_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_empty_failure = %u",
+			   htt_stats_buf->q_empty_failure);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_not_empty_failure = %u",
+			   htt_stats_buf->q_not_empty_failure);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "add_msdu_failure = %u\n",
+			   htt_stats_buf->add_msdu_failure);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_tqm_cmdq_status_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_tqm_cmdq_status_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_CMDQ_STATUS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__cmdq_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmdq_id = %u\n",
+			   (htt_stats_buf->mac_id__cmdq_id__word & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sync_cmd = %u",
+			   htt_stats_buf->sync_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "write_cmd = %u",
+			   htt_stats_buf->write_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_cmd = %u",
+			   htt_stats_buf->gen_mpdu_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u",
+			   htt_stats_buf->mpdu_queue_stats_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_head_info_cmd = %u",
+			   htt_stats_buf->mpdu_head_info_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u",
+			   htt_stats_buf->msdu_flow_stats_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_cmd = %u",
+			   htt_stats_buf->remove_mpdu_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_cmd = %u",
+			   htt_stats_buf->remove_msdu_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cache_cmd = %u",
+			   htt_stats_buf->flush_cache_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_mpduq_cmd = %u",
+			   htt_stats_buf->update_mpduq_cmd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_msduq_cmd = %u\n",
+			   htt_stats_buf->update_msduq_cmd);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_eapol_packets_stats_tlv(const void *tag_buf,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_eapol_packets_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "m1_packets = %u",
+			   htt_stats_buf->m1_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "m2_packets = %u",
+			   htt_stats_buf->m2_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "m3_packets = %u",
+			   htt_stats_buf->m3_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "m4_packets = %u",
+			   htt_stats_buf->m4_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "g1_packets = %u",
+			   htt_stats_buf->g1_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "g2_packets = %u\n",
+			   htt_stats_buf->g2_packets);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_classify_failed_stats_tlv(const void *tag_buf,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_classify_failed_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ap_bss_peer_not_found = %u",
+			   htt_stats_buf->ap_bss_peer_not_found);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ap_bcast_mcast_no_peer = %u",
+			   htt_stats_buf->ap_bcast_mcast_no_peer);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sta_delete_in_progress = %u",
+			   htt_stats_buf->sta_delete_in_progress);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ibss_no_bss_peer = %u",
+			   htt_stats_buf->ibss_no_bss_peer);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_vdev_type = %u",
+			   htt_stats_buf->invalid_vdev_type);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_ast_peer_entry = %u",
+			   htt_stats_buf->invalid_ast_peer_entry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_entry_invalid = %u",
+			   htt_stats_buf->peer_entry_invalid);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ethertype_not_ip = %u",
+			   htt_stats_buf->ethertype_not_ip);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "eapol_lookup_failed = %u",
+			   htt_stats_buf->eapol_lookup_failed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qpeer_not_allow_data = %u",
+			   htt_stats_buf->qpeer_not_allow_data);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_tid_override = %u",
+			   htt_stats_buf->fse_tid_override);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ipv6_jumbogram_zero_length = %u",
+			   htt_stats_buf->ipv6_jumbogram_zero_length);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_to_non_qos_in_prog = %u\n",
+			   htt_stats_buf->qos_to_non_qos_in_prog);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_classify_stats_tlv(const void *tag_buf,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_classify_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_CLASSIFY_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "arp_packets = %u",
+			   htt_stats_buf->arp_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "igmp_packets = %u",
+			   htt_stats_buf->igmp_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dhcp_packets = %u",
+			   htt_stats_buf->dhcp_packets);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_inspected = %u",
+			   htt_stats_buf->host_inspected);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_included = %u",
+			   htt_stats_buf->htt_included);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_mcs = %u",
+			   htt_stats_buf->htt_valid_mcs);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_nss = %u",
+			   htt_stats_buf->htt_valid_nss);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_preamble_type = %u",
+			   htt_stats_buf->htt_valid_preamble_type);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_chainmask = %u",
+			   htt_stats_buf->htt_valid_chainmask);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_guard_interval = %u",
+			   htt_stats_buf->htt_valid_guard_interval);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_retries = %u",
+			   htt_stats_buf->htt_valid_retries);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_bw_info = %u",
+			   htt_stats_buf->htt_valid_bw_info);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_power = %u",
+			   htt_stats_buf->htt_valid_power);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_key_flags = 0x%x",
+			   htt_stats_buf->htt_valid_key_flags);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_no_encryption = %u",
+			   htt_stats_buf->htt_valid_no_encryption);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_entry_count = %u",
+			   htt_stats_buf->fse_entry_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_be = %u",
+			   htt_stats_buf->fse_priority_be);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_high = %u",
+			   htt_stats_buf->fse_priority_high);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_low = %u",
+			   htt_stats_buf->fse_priority_low);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_be = %u",
+			   htt_stats_buf->fse_traffic_ptrn_be);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_over_sub = %u",
+			   htt_stats_buf->fse_traffic_ptrn_over_sub);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_bursty = %u",
+			   htt_stats_buf->fse_traffic_ptrn_bursty);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_interactive = %u",
+			   htt_stats_buf->fse_traffic_ptrn_interactive);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_periodic = %u",
+			   htt_stats_buf->fse_traffic_ptrn_periodic);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_alloc = %u",
+			   htt_stats_buf->fse_hwqueue_alloc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_created = %u",
+			   htt_stats_buf->fse_hwqueue_created);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_send_to_host = %u",
+			   htt_stats_buf->fse_hwqueue_send_to_host);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mcast_entry = %u",
+			   htt_stats_buf->mcast_entry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "bcast_entry = %u",
+			   htt_stats_buf->bcast_entry);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_update_peer_cache = %u",
+			   htt_stats_buf->htt_update_peer_cache);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_learning_frame = %u",
+			   htt_stats_buf->htt_learning_frame);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_invalid_peer = %u",
+			   htt_stats_buf->fse_invalid_peer);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mec_notify = %u\n",
+			   htt_stats_buf->mec_notify);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_classify_status_stats_tlv(const void *tag_buf,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_classify_status_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "eok = %u",
+			   htt_stats_buf->eok);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "classify_done = %u",
+			   htt_stats_buf->classify_done);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "lookup_failed = %u",
+			   htt_stats_buf->lookup_failed);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_dhcp = %u",
+			   htt_stats_buf->send_host_dhcp);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_mcast = %u",
+			   htt_stats_buf->send_host_mcast);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_unknown_dest = %u",
+			   htt_stats_buf->send_host_unknown_dest);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host = %u",
+			   htt_stats_buf->send_host);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "status_invalid = %u\n",
+			   htt_stats_buf->status_invalid);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_enqueue_packets_stats_tlv(const void *tag_buf,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_enqueue_packets_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueued_pkts = %u",
+			htt_stats_buf->enqueued_pkts);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "to_tqm = %u",
+			htt_stats_buf->to_tqm);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "to_tqm_bypass = %u\n",
+			htt_stats_buf->to_tqm_bypass);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_enqueue_discard_stats_tlv(const void *tag_buf,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_enqueue_discard_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "discarded_pkts = %u",
+			   htt_stats_buf->discarded_pkts);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_frames = %u",
+			   htt_stats_buf->local_frames);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "is_ext_msdu = %u\n",
+			   htt_stats_buf->is_ext_msdu);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_de_compl_stats_tlv(const void *tag_buf,
+						   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_compl_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_COMPL_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl_dummy_frame = %u",
+			   htt_stats_buf->tcl_dummy_frame);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_dummy_frame = %u",
+			   htt_stats_buf->tqm_dummy_frame);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_notify_frame = %u",
+			   htt_stats_buf->tqm_notify_frame);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw2wbm_enq = %u",
+			   htt_stats_buf->fw2wbm_enq);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_bypass_frame = %u\n",
+			   htt_stats_buf->tqm_bypass_frame);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_fw2wbm_ring_full_hist_tlv(const void *tag_buf,
+					  u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_fw2wbm_ring_full_hist_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char fw2wbm_ring_full_hist[HTT_MAX_STRING_LEN] = {0};
+	u16  num_elements = tag_len >> 2;
+	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_TX_DE_FW2WBM_RING_FULL_HIST_TLV");
+
+	if (required_buffer_size < HTT_MAX_STRING_LEN) {
+		ARRAY_TO_STRING(fw2wbm_ring_full_hist,
+				htt_stats_buf->fw2wbm_ring_full_hist,
+				num_elements);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "fw2wbm_ring_full_hist = %s\n",
+				   fw2wbm_ring_full_hist);
+	} else {
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "INSUFFICIENT PRINT BUFFER ");
+	}
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_tx_de_cmn_stats_tlv(const void *tag_buf, struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_de_cmn_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_CMN_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl2fw_entry_count = %u",
+			   htt_stats_buf->tcl2fw_entry_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "not_to_fw = %u",
+			   htt_stats_buf->not_to_fw);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_pdev_vdev_peer = %u",
+			   htt_stats_buf->invalid_pdev_vdev_peer);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl_res_invalid_addrx = %u",
+			   htt_stats_buf->tcl_res_invalid_addrx);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm2fw_entry_count = %u",
+			   htt_stats_buf->wbm2fw_entry_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_pdev = %u\n",
+			   htt_stats_buf->invalid_pdev);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
+					       struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_ring_if_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char low_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
+	char high_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RING_IF_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr = %u",
+			   htt_stats_buf->base_addr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "elem_size = %u",
+			   htt_stats_buf->elem_size);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_elems = %u",
+			   htt_stats_buf->num_elems__prefetch_tail_idx & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "prefetch_tail_idx = %u",
+			   (htt_stats_buf->num_elems__prefetch_tail_idx &
+			   0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "head_idx = %u",
+			   htt_stats_buf->head_idx__tail_idx & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tail_idx = %u",
+			   (htt_stats_buf->head_idx__tail_idx & 0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "shadow_head_idx = %u",
+			   htt_stats_buf->shadow_head_idx__shadow_tail_idx & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "shadow_tail_idx = %u",
+			   (htt_stats_buf->shadow_head_idx__shadow_tail_idx &
+			   0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tail_incr = %u",
+			   htt_stats_buf->num_tail_incr);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "lwm_thresh = %u",
+			   htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwm_thresh = %u",
+			   (htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "overrun_hit_count = %u",
+			   htt_stats_buf->overrun_hit_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun_hit_count = %u",
+			   htt_stats_buf->underrun_hit_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "prod_blockwait_count = %u",
+			   htt_stats_buf->prod_blockwait_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "cons_blockwait_count = %u",
+			   htt_stats_buf->cons_blockwait_count);
+
+	ARRAY_TO_STRING(low_wm_hit_count, htt_stats_buf->low_wm_hit_count,
+			HTT_STATS_LOW_WM_BINS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "low_wm_hit_count = %s ",
+			   low_wm_hit_count);
+
+	ARRAY_TO_STRING(high_wm_hit_count, htt_stats_buf->high_wm_hit_count,
+			HTT_STATS_HIGH_WM_BINS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "high_wm_hit_count = %s\n",
+			   high_wm_hit_count);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_ring_if_cmn_tlv(const void *tag_buf,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_ring_if_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RING_IF_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
+			   htt_stats_buf->num_records);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_sfm_client_user_tlv_v(const void *tag_buf,
+						   u16 tag_len,
+						   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sfm_client_user_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char dwords_used_by_user_n[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = tag_len >> 2;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV_V:");
+
+	ARRAY_TO_STRING(dwords_used_by_user_n,
+			htt_stats_buf->dwords_used_by_user_n,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dwords_used_by_user_n = %s\n",
+			   dwords_used_by_user_n);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_sfm_client_tlv(const void *tag_buf,
+					    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sfm_client_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "client_id = %u",
+			   htt_stats_buf->client_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_min = %u",
+			   htt_stats_buf->buf_min);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_max = %u",
+			   htt_stats_buf->buf_max);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_busy = %u",
+			   htt_stats_buf->buf_busy);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_alloc = %u",
+			   htt_stats_buf->buf_alloc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_avail = %u",
+			   htt_stats_buf->buf_avail);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_users = %u\n",
+			   htt_stats_buf->num_users);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_sfm_cmn_tlv(const void *tag_buf,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sfm_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_total = %u",
+			   htt_stats_buf->buf_total);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mem_empty = %u",
+			   htt_stats_buf->mem_empty);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "deallocate_bufs = %u",
+			   htt_stats_buf->deallocate_bufs);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
+			   htt_stats_buf->num_records);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_sring_stats_tlv(const void *tag_buf,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sring_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SRING_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ring_id = %u",
+			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "arena = %u",
+			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ep = %u",
+			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0x1000000) >> 24);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr_lsb = 0x%x",
+			   htt_stats_buf->base_addr_lsb);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr_msb = 0x%x",
+			   htt_stats_buf->base_addr_msb);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ring_size = %u",
+			   htt_stats_buf->ring_size);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "elem_size = %u",
+			   htt_stats_buf->elem_size);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_avail_words = %u",
+			   htt_stats_buf->num_avail_words__num_valid_words & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_valid_words = %u",
+			   (htt_stats_buf->num_avail_words__num_valid_words &
+			   0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "head_ptr = %u",
+			   htt_stats_buf->head_ptr__tail_ptr & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tail_ptr = %u",
+			   (htt_stats_buf->head_ptr__tail_ptr & 0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "consumer_empty = %u",
+			   htt_stats_buf->consumer_empty__producer_full & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "producer_full = %u",
+			   (htt_stats_buf->consumer_empty__producer_full &
+			   0xFFFF0000) >> 16);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "prefetch_count = %u",
+			   htt_stats_buf->prefetch_count__internal_tail_ptr & 0xFFFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "internal_tail_ptr = %u\n",
+			   (htt_stats_buf->prefetch_count__internal_tail_ptr &
+			   0xFFFF0000) >> 16);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_sring_cmn_tlv(const void *tag_buf,
+					   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_sring_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SRING_CMN_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
+			   htt_stats_buf->num_records);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_tx_pdev_rate_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u8 j;
+	char str_buf[HTT_MAX_STRING_LEN] = {0};
+	char *tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
+
+	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
+		tx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!tx_gi[j])
+			goto fail;
+	}
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_ldpc = %u",
+			   htt_stats_buf->tx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_ldpc = %u",
+			   htt_stats_buf->ac_mu_mimo_tx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_ldpc = %u",
+			   htt_stats_buf->ax_mu_mimo_tx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_ldpc = %u",
+			   htt_stats_buf->ofdma_tx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
+			   htt_stats_buf->rts_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_success = %u",
+			   htt_stats_buf->rts_success);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_rssi = %u",
+			   htt_stats_buf->ack_rssi);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "Legacy CCK Rates: 1 Mbps: %u, 2 Mbps: %u, 5.5 Mbps: %u, 11 Mbps: %u",
+			   htt_stats_buf->tx_legacy_cck_rate[0],
+			   htt_stats_buf->tx_legacy_cck_rate[1],
+			   htt_stats_buf->tx_legacy_cck_rate[2],
+			   htt_stats_buf->tx_legacy_cck_rate[3]);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "Legacy OFDM Rates: 6 Mbps: %u, 9 Mbps: %u, 12 Mbps: %u, 18 Mbps: %u\n"
+			   "                   24 Mbps: %u, 36 Mbps: %u, 48 Mbps: %u, 54 Mbps: %u",
+			   htt_stats_buf->tx_legacy_ofdm_rate[0],
+			   htt_stats_buf->tx_legacy_ofdm_rate[1],
+			   htt_stats_buf->tx_legacy_ofdm_rate[2],
+			   htt_stats_buf->tx_legacy_ofdm_rate[3],
+			   htt_stats_buf->tx_legacy_ofdm_rate[4],
+			   htt_stats_buf->tx_legacy_ofdm_rate[5],
+			   htt_stats_buf->tx_legacy_ofdm_rate[6],
+			   htt_stats_buf->tx_legacy_ofdm_rate[7]);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_mcs,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_nss,
+			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_nss,
+			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_nss,
+			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_nss,
+			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_bw,
+			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_bw,
+			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_bw = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_bw,
+			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_bw = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_bw,
+			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_bw = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_stbc,
+			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_pream,
+			HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u",
+			   htt_stats_buf->tx_he_ltf[1],
+			   htt_stats_buf->tx_he_ltf[2],
+			   htt_stats_buf->tx_he_ltf[3]);
+
+	/* SU GI Stats */
+	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->tx_gi[j],
+				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
+				   j, tx_gi[j]);
+	}
+
+	/* AC MU-MIMO GI Stats */
+	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ac_mu_mimo_tx_gi[j],
+				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ac_mu_mimo_tx_gi[%u] = %s ",
+				   j, tx_gi[j]);
+	}
+
+	/* AX MU-MIMO GI Stats */
+	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ax_mu_mimo_tx_gi[j],
+				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "ax_mu_mimo_tx_gi[%u] = %s ",
+				   j, tx_gi[j]);
+	}
+
+	/* DL OFDMA GI Stats */
+	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ofdma_tx_gi[j],
+				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_gi[%u] = %s ",
+				   j, tx_gi[j]);
+	}
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_dcm,
+			HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+fail:
+	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++)
+		kfree(tx_gi[j]);
+}
+
+static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_rate_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u8 i, j;
+	u16 index = 0;
+	char *rssi_chain[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS] = {NULL};
+	char *rx_gi[HTT_RX_PDEV_STATS_NUM_GI_COUNTERS] = {NULL};
+	char str_buf[HTT_MAX_STRING_LEN] = {0};
+	char *rx_pilot_evm_db[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS] = {NULL};
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		rssi_chain[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!rssi_chain[j])
+			goto fail;
+	}
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		rx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!rx_gi[j])
+			goto fail;
+	}
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		rx_pilot_evm_db[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
+		if (!rx_pilot_evm_db[j])
+			goto fail;
+	}
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "nsts = %u",
+			   htt_stats_buf->nsts);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ldpc = %u",
+			   htt_stats_buf->rx_ldpc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
+			   htt_stats_buf->rts_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_mgmt = %u",
+			   htt_stats_buf->rssi_mgmt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_data = %u",
+			   htt_stats_buf->rssi_data);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_comb = %u",
+			   htt_stats_buf->rssi_comb);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_in_dbm = %d",
+			   htt_stats_buf->rssi_in_dbm);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_mcs,
+			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_nss,
+			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_dcm,
+			HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_stbc,
+			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_bw,
+			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_nss_count = %u",
+			htt_stats_buf->nss_count);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_pilot_count = %u",
+			htt_stats_buf->pilot_count);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		index = 0;
+
+		for (i = 0; i < HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS; i++)
+			index += scnprintf(&rx_pilot_evm_db[j][index],
+					  HTT_MAX_STRING_LEN - index,
+					  " %u:%d,",
+					  i,
+					  htt_stats_buf->rx_pilot_evm_db[j][i]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB[%u] = %s ",
+				   j, rx_pilot_evm_db[j]);
+	}
+
+	index = 0;
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
+		index += scnprintf(&str_buf[index],
+				  HTT_MAX_STRING_LEN - index,
+				  " %u:%d,", i, htt_stats_buf->rx_pilot_evm_db_mean[i]);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB_mean = %s ", str_buf);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		ARRAY_TO_STRING(rssi_chain[j], htt_stats_buf->rssi_chain[j],
+				HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
+				   j, rssi_chain[j]);
+	}
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->rx_gi[j],
+				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
+				   j, rx_gi[j]);
+	}
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_pream,
+			HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s", str_buf);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_su_ext = %u",
+			   htt_stats_buf->rx_11ax_su_ext);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ac_mumimo = %u",
+			   htt_stats_buf->rx_11ac_mumimo);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_mumimo = %u",
+			   htt_stats_buf->rx_11ax_mumimo);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_ofdma = %u",
+			   htt_stats_buf->rx_11ax_ofdma);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "txbf = %u",
+			   htt_stats_buf->txbf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_legacy_cck_rate,
+			HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_cck_rate = %s ",
+			   str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_legacy_ofdm_rate,
+			HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_ofdm_rate = %s ",
+			   str_buf);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_active_dur_us_low = %u",
+			   htt_stats_buf->rx_active_dur_us_low);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_active_dur_us_high = %u",
+			htt_stats_buf->rx_active_dur_us_high);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u",
+			htt_stats_buf->rx_11ax_ul_ofdma);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_mcs,
+			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_mcs = %s ", str_buf);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->ul_ofdma_rx_gi[j],
+				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+		len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u] = %s ",
+				   j, rx_gi[j]);
+	}
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_nss,
+			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_nss = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_bw,
+			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_bw = %s ", str_buf);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u",
+			htt_stats_buf->ul_ofdma_rx_stbc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u",
+			htt_stats_buf->ul_ofdma_rx_ldpc);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_non_data_ppdu,
+			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu = %s ",
+			   str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_data_ppdu,
+			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_data_ppdu = %s ",
+			   str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_mpdu_ok,
+			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok = %s ", str_buf);
+
+	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_mpdu_fail,
+			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail = %s",
+			   str_buf);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		index = 0;
+		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+		for (i = 0; i < HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
+			index += scnprintf(&str_buf[index],
+					  HTT_MAX_STRING_LEN - index,
+					  " %u:%d,",
+					  i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "rx_ul_fd_rssi: nss[%u] = %s", j, str_buf);
+	}
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "per_chain_rssi_pkt_type = %#x",
+			   htt_stats_buf->per_chain_rssi_pkt_type);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		index = 0;
+		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
+			index += scnprintf(&str_buf[index],
+					  HTT_MAX_STRING_LEN - index,
+					  " %u:%d,",
+					  i,
+					  htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "rx_per_chain_rssi_in_dbm[%u] = %s ", j, str_buf);
+	}
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n");
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+
+fail:
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
+		kfree(rssi_chain[j]);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
+		kfree(rx_pilot_evm_db[j]);
+
+	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; i++)
+		kfree(rx_gi[i]);
+}
+
+static inline void htt_print_rx_soc_fw_stats_tlv(const void *tag_buf,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_soc_fw_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_SOC_FW_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_reo_ring_data_msdu = %u",
+			   htt_stats_buf->fw_reo_ring_data_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_to_host_data_msdu_bcmc = %u",
+			   htt_stats_buf->fw_to_host_data_msdu_bcmc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_to_host_data_msdu_uc = %u",
+			   htt_stats_buf->fw_to_host_data_msdu_uc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "ofld_remote_data_buf_recycle_cnt = %u",
+			   htt_stats_buf->ofld_remote_data_buf_recycle_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "ofld_remote_free_buf_indication_cnt = %u",
+			   htt_stats_buf->ofld_remote_free_buf_indication_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "ofld_buf_to_host_data_msdu_uc = %u",
+			   htt_stats_buf->ofld_buf_to_host_data_msdu_uc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "reo_fw_ring_to_host_data_msdu_uc = %u",
+			   htt_stats_buf->reo_fw_ring_to_host_data_msdu_uc);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_sw_ring_reap = %u",
+			   htt_stats_buf->wbm_sw_ring_reap);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_forward_to_host_cnt = %u",
+			   htt_stats_buf->wbm_forward_to_host_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_target_recycle_cnt = %u",
+			   htt_stats_buf->wbm_target_recycle_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "target_refill_ring_recycle_cnt = %u",
+			   htt_stats_buf->target_refill_ring_recycle_cnt);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_soc_fw_refill_ring_empty_tlv_v(const void *tag_buf,
+					    u16 tag_len,
+					    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_soc_fw_refill_ring_empty_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char refill_ring_empty_cnt[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV_V:");
+
+	ARRAY_TO_STRING(refill_ring_empty_cnt,
+			htt_stats_buf->refill_ring_empty_cnt,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_empty_cnt = %s\n",
+			   refill_ring_empty_cnt);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(const void *tag_buf,
+						    u16 tag_len,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v *htt_stats_buf =
+		tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char rxdma_err_cnt[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_RXDMA_MAX_ERR_CODE);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV_V:");
+
+	ARRAY_TO_STRING(rxdma_err_cnt,
+			htt_stats_buf->rxdma_err,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdma_err = %s\n",
+			   rxdma_err_cnt);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(const void *tag_buf,
+						  u16 tag_len,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_soc_fw_refill_ring_num_reo_err_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char reo_err_cnt[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_REO_MAX_ERR_CODE);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV_V:");
+
+	ARRAY_TO_STRING(reo_err_cnt,
+			htt_stats_buf->reo_err,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "reo_err = %s\n",
+			   reo_err_cnt);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_reo_debug_stats_tlv_v(const void *tag_buf,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_reo_resource_stats_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_REO_RESOURCE_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sample_id = %u",
+			   htt_stats_buf->sample_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_max = %u",
+			   htt_stats_buf->total_max);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_avg = %u",
+			   htt_stats_buf->total_avg);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_sample = %u",
+			   htt_stats_buf->total_sample);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "non_zeros_avg = %u",
+			   htt_stats_buf->non_zeros_avg);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "non_zeros_sample = %u",
+			   htt_stats_buf->non_zeros_sample);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_max = %u",
+			   htt_stats_buf->last_non_zeros_max);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_min %u",
+			   htt_stats_buf->last_non_zeros_min);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_avg %u",
+			   htt_stats_buf->last_non_zeros_avg);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_sample %u\n",
+			   htt_stats_buf->last_non_zeros_sample);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(const void *tag_buf,
+						 u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_soc_fw_refill_ring_num_refill_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char refill_ring_num_refill[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV_V:");
+
+	ARRAY_TO_STRING(refill_ring_num_refill,
+			htt_stats_buf->refill_ring_num_refill,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_num_refill = %s\n",
+			   refill_ring_num_refill);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_fw_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char fw_ring_mgmt_subtype[HTT_MAX_STRING_LEN] = {0};
+	char fw_ring_ctrl_subtype[HTT_MAX_STRING_LEN] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ppdu_recvd = %u",
+			   htt_stats_buf->ppdu_recvd);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u",
+			   htt_stats_buf->mpdu_cnt_fcs_ok);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt_fcs_err = %u",
+			   htt_stats_buf->mpdu_cnt_fcs_err);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcp_msdu_cnt = %u",
+			   htt_stats_buf->tcp_msdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcp_ack_msdu_cnt = %u",
+			   htt_stats_buf->tcp_ack_msdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "udp_msdu_cnt = %u",
+			   htt_stats_buf->udp_msdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "other_msdu_cnt = %u",
+			   htt_stats_buf->other_msdu_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u",
+			   htt_stats_buf->fw_ring_mpdu_ind);
+
+	ARRAY_TO_STRING(fw_ring_mgmt_subtype,
+			htt_stats_buf->fw_ring_mgmt_subtype,
+			HTT_STATS_SUBTYPE_MAX);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mgmt_subtype = %s ",
+			   fw_ring_mgmt_subtype);
+
+	ARRAY_TO_STRING(fw_ring_ctrl_subtype,
+			htt_stats_buf->fw_ring_ctrl_subtype,
+			HTT_STATS_SUBTYPE_MAX);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ctrl_subtype = %s ",
+			   fw_ring_ctrl_subtype);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u",
+			   htt_stats_buf->fw_ring_mcast_data_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u",
+			   htt_stats_buf->fw_ring_bcast_data_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ucast_data_msdu = %u",
+			   htt_stats_buf->fw_ring_ucast_data_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_null_data_msdu = %u",
+			   htt_stats_buf->fw_ring_null_data_msdu);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_drop = %u",
+			   htt_stats_buf->fw_ring_mpdu_drop);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofld_local_data_ind_cnt = %u",
+			   htt_stats_buf->ofld_local_data_ind_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "ofld_local_data_buf_recycle_cnt = %u",
+			   htt_stats_buf->ofld_local_data_buf_recycle_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "drx_local_data_ind_cnt = %u",
+			   htt_stats_buf->drx_local_data_ind_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "drx_local_data_buf_recycle_cnt = %u",
+			   htt_stats_buf->drx_local_data_buf_recycle_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_nondata_ind_cnt = %u",
+			   htt_stats_buf->local_nondata_ind_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_nondata_buf_recycle_cnt = %u",
+			   htt_stats_buf->local_nondata_buf_recycle_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_status_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->fw_status_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_status_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->fw_status_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_pkt_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->fw_pkt_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_pkt_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->fw_pkt_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_link_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->fw_link_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_link_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->fw_link_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_pkt_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->host_pkt_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_pkt_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->host_pkt_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_pkt_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->mon_pkt_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_pkt_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->mon_pkt_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "mon_status_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->mon_status_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_status_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->mon_status_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_desc_buf_ring_refill_cnt = %u",
+			   htt_stats_buf->mon_desc_buf_ring_refill_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_desc_buf_ring_empty_cnt = %u",
+			   htt_stats_buf->mon_desc_buf_ring_empty_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_dest_ring_update_cnt = %u",
+			   htt_stats_buf->mon_dest_ring_update_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_dest_ring_full_cnt = %u",
+			   htt_stats_buf->mon_dest_ring_full_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_suspend_cnt = %u",
+			   htt_stats_buf->rx_suspend_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_suspend_fail_cnt = %u",
+			   htt_stats_buf->rx_suspend_fail_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_resume_cnt = %u",
+			   htt_stats_buf->rx_resume_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_resume_fail_cnt = %u",
+			   htt_stats_buf->rx_resume_fail_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ring_switch_cnt = %u",
+			   htt_stats_buf->rx_ring_switch_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ring_restore_cnt = %u",
+			   htt_stats_buf->rx_ring_restore_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_flush_cnt = %u",
+			   htt_stats_buf->rx_flush_cnt);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_recovery_reset_cnt = %u\n",
+			   htt_stats_buf->rx_recovery_reset_cnt);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(const void *tag_buf,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_fw_ring_mpdu_err_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char fw_ring_mpdu_err[HTT_MAX_STRING_LEN] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV_V:");
+
+	ARRAY_TO_STRING(fw_ring_mpdu_err,
+			htt_stats_buf->fw_ring_mpdu_err,
+			HTT_RX_STATS_RXDMA_MAX_ERR);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_err = %s\n",
+			   fw_ring_mpdu_err);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_pdev_fw_mpdu_drop_tlv_v(const void *tag_buf,
+				     u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_fw_mpdu_drop_tlv_v *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char fw_mpdu_drop[HTT_MAX_STRING_LEN] = {0};
+	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_FW_DROP_REASON_MAX);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV_V:");
+
+	ARRAY_TO_STRING(fw_mpdu_drop,
+			htt_stats_buf->fw_mpdu_drop,
+			num_elems);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_mpdu_drop = %s\n", fw_mpdu_drop);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_fw_stats_phy_err_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	char phy_errs[HTT_MAX_STRING_LEN] = {0};
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id__word = %u",
+			   htt_stats_buf->mac_id__word);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_phy_err_nct = %u",
+			   htt_stats_buf->total_phy_err_cnt);
+
+	ARRAY_TO_STRING(phy_errs,
+			htt_stats_buf->phy_err,
+			HTT_STATS_PHY_ERR_MAX);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_pdev_cca_stats_hist_tlv(const void *tag_buf,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_pdev_cca_stats_hist_v1_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "\nHTT_PDEV_CCA_STATS_HIST_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "chan_num = %u",
+			   htt_stats_buf->chan_num);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u",
+			   htt_stats_buf->num_records);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "valid_cca_counters_bitmap = 0x%x",
+			   htt_stats_buf->valid_cca_counters_bitmap);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "collection_interval = %u\n",
+			   htt_stats_buf->collection_interval);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)");
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "|  tx_frame|   rx_frame|   rx_clear| my_rx_frame|        cnt| med_rx_idle| med_tx_idle_global|   cca_obss|");
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_pdev_stats_cca_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "|%10u| %10u| %10u| %11u| %10u| %11u| %18u| %10u|",
+			   htt_stats_buf->tx_frame_usec,
+			   htt_stats_buf->rx_frame_usec,
+			   htt_stats_buf->rx_clear_usec,
+			   htt_stats_buf->my_rx_frame_usec,
+			   htt_stats_buf->usec_cnt,
+			   htt_stats_buf->med_rx_idle_usec,
+			   htt_stats_buf->med_tx_idle_global_usec,
+			   htt_stats_buf->cca_obss_usec);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_hw_stats_whal_tx_tlv(const void *tag_buf,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_hw_stats_whal_tx_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_WHAL_TX_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
+			   htt_stats_buf->mac_id__word & 0xFF);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_unpause_ppdu_id = %u",
+			   htt_stats_buf->last_unpause_ppdu_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_unpause_wait_tqm_write = %u",
+			   htt_stats_buf->hwsch_unpause_wait_tqm_write);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_dummy_tlv_skipped = %u",
+			   htt_stats_buf->hwsch_dummy_tlv_skipped);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "hwsch_misaligned_offset_received = %u",
+			   htt_stats_buf->hwsch_misaligned_offset_received);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_reset_count = %u",
+			   htt_stats_buf->hwsch_reset_count);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_dev_reset_war = %u",
+			   htt_stats_buf->hwsch_dev_reset_war);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_delayed_pause = %u",
+			   htt_stats_buf->hwsch_delayed_pause);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_long_delayed_pause = %u",
+			   htt_stats_buf->hwsch_long_delayed_pause);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_rx_ppdu_no_response = %u",
+			   htt_stats_buf->sch_rx_ppdu_no_response);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_selfgen_response = %u",
+			   htt_stats_buf->sch_selfgen_response);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_rx_sifs_resp_trigger= %u\n",
+			   htt_stats_buf->sch_rx_sifs_resp_trigger);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_pdev_stats_twt_sessions_tlv(const void *tag_buf,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_pdev_stats_twt_sessions_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSIONS_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
+			   htt_stats_buf->pdev_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sessions = %u\n",
+			   htt_stats_buf->num_sessions);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_pdev_stats_twt_session_tlv(const void *tag_buf,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_pdev_stats_twt_session_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSION_TLV:");
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "vdev_id = %u",
+			   htt_stats_buf->vdev_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "peer_mac = %02x:%02x:%02x:%02x:%02x:%02x",
+			   htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF,
+			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF00) >> 8,
+			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF0000) >> 16,
+			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF000000) >> 24,
+			   (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF),
+			   (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF00) >> 8);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "flow_id_flags = %u",
+			   htt_stats_buf->flow_id_flags);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "dialog_id = %u",
+			   htt_stats_buf->dialog_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "wake_dura_us = %u",
+			   htt_stats_buf->wake_dura_us);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "wake_intvl_us = %u",
+			   htt_stats_buf->wake_intvl_us);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "sp_offset_us = %u\n",
+			   htt_stats_buf->sp_offset_us);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+htt_print_pdev_obss_pd_stats_tlv_v(const void *tag_buf,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_pdev_obss_pd_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "OBSS Tx success PPDU = %u",
+			   htt_stats_buf->num_obss_tx_ppdu_success);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "OBSS Tx failures PPDU = %u\n",
+			   htt_stats_buf->num_obss_tx_ppdu_failure);
+
+	if (len >= buf_len)
+		buf[buf_len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	stats_req->buf_len = len;
+}
+
+static inline void htt_print_backpressure_stats_tlv_v(const u32 *tag_buf,
+						      u8 *data)
+{
+	struct debug_htt_stats_req *stats_req =
+			(struct debug_htt_stats_req *)data;
+	struct htt_ring_backpressure_stats_tlv *htt_stats_buf =
+			(struct htt_ring_backpressure_stats_tlv *)tag_buf;
+	int i;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
+			   htt_stats_buf->pdev_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_head_idx = %u",
+			   htt_stats_buf->current_head_idx);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_tail_idx = %u",
+			   htt_stats_buf->current_tail_idx);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_htt_msgs_sent = %u",
+			   htt_stats_buf->num_htt_msgs_sent);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "backpressure_time_ms = %u",
+			   htt_stats_buf->backpressure_time_ms);
+
+	for (i = 0; i < 5; i++)
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "backpressure_hist_%u = %u",
+				   i + 1, htt_stats_buf->backpressure_hist[i]);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "============================");
+
+	if (len >= buf_len) {
+		buf[buf_len - 1] = 0;
+		stats_req->buf_len = buf_len - 1;
+	} else {
+		buf[len] = 0;
+		stats_req->buf_len = len;
+	}
+}
+
+static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
+					  u16 tag, u16 len, const void *tag_buf,
+					  void *user_data)
+{
+	struct debug_htt_stats_req *stats_req = user_data;
+
+	switch (tag) {
+	case HTT_STATS_TX_PDEV_CMN_TAG:
+		htt_print_tx_pdev_stats_cmn_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_UNDERRUN_TAG:
+		htt_print_tx_pdev_stats_urrn_tlv_v(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_SIFS_TAG:
+		htt_print_tx_pdev_stats_sifs_tlv_v(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_FLUSH_TAG:
+		htt_print_tx_pdev_stats_flush_tlv_v(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_PHY_ERR_TAG:
+		htt_print_tx_pdev_stats_phy_err_tlv_v(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_SIFS_HIST_TAG:
+		htt_print_tx_pdev_stats_sifs_hist_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_PDEV_TX_PPDU_STATS_TAG:
+		htt_print_tx_pdev_stats_tx_ppdu_stats_tlv_v(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_PDEV_TRIED_MPDU_CNT_HIST_TAG:
+		htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(tag_buf, len,
+								  stats_req);
+		break;
+
+	case HTT_STATS_STRING_TAG:
+		htt_print_stats_string_tlv(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_CMN_TAG:
+		htt_print_tx_hwq_stats_cmn_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_DIFS_LATENCY_TAG:
+		htt_print_tx_hwq_difs_latency_stats_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_CMD_RESULT_TAG:
+		htt_print_tx_hwq_cmd_result_stats_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_CMD_STALL_TAG:
+		htt_print_tx_hwq_cmd_stall_stats_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_FES_STATUS_TAG:
+		htt_print_tx_hwq_fes_result_stats_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_TRIED_MPDU_CNT_HIST_TAG:
+		htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_TXOP_USED_CNT_HIST_TAG:
+		htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_TQM_GEN_MPDU_TAG:
+		htt_print_tx_tqm_gen_mpdu_stats_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_TQM_LIST_MPDU_TAG:
+		htt_print_tx_tqm_list_mpdu_stats_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG:
+		htt_print_tx_tqm_list_mpdu_cnt_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_TQM_CMN_TAG:
+		htt_print_tx_tqm_cmn_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_TQM_PDEV_TAG:
+		htt_print_tx_tqm_pdev_stats_tlv_v(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_TQM_CMDQ_STATUS_TAG:
+		htt_print_tx_tqm_cmdq_status_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_EAPOL_PACKETS_TAG:
+		htt_print_tx_de_eapol_packets_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_CLASSIFY_FAILED_TAG:
+		htt_print_tx_de_classify_failed_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_CLASSIFY_STATS_TAG:
+		htt_print_tx_de_classify_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_CLASSIFY_STATUS_TAG:
+		htt_print_tx_de_classify_status_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG:
+		htt_print_tx_de_enqueue_packets_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG:
+		htt_print_tx_de_enqueue_discard_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_FW2WBM_RING_FULL_HIST_TAG:
+		htt_print_tx_de_fw2wbm_ring_full_hist_tlv(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_CMN_TAG:
+		htt_print_tx_de_cmn_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RING_IF_TAG:
+		htt_print_ring_if_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG:
+		htt_print_tx_pdev_mu_mimo_sch_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_SFM_CMN_TAG:
+		htt_print_sfm_cmn_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_SRING_STATS_TAG:
+		htt_print_sring_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RX_PDEV_FW_STATS_TAG:
+		htt_print_rx_pdev_fw_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RX_PDEV_FW_RING_MPDU_ERR_TAG:
+		htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RX_PDEV_FW_MPDU_DROP_TAG:
+		htt_print_rx_pdev_fw_mpdu_drop_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_RX_SOC_FW_STATS_TAG:
+		htt_print_rx_soc_fw_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RX_SOC_FW_REFILL_RING_EMPTY_TAG:
+		htt_print_rx_soc_fw_refill_ring_empty_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_RX_SOC_FW_REFILL_RING_NUM_REFILL_TAG:
+		htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(
+				tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_REFILL_RXDMA_ERR_TAG:
+		htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(
+				tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_RX_REFILL_REO_ERR_TAG:
+		htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(
+				tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_RX_REO_RESOURCE_STATS_TAG:
+		htt_print_rx_reo_debug_stats_tlv_v(
+				tag_buf, stats_req);
+		break;
+	case HTT_STATS_RX_PDEV_FW_STATS_PHY_ERR_TAG:
+		htt_print_rx_pdev_fw_stats_phy_err_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_PDEV_RATE_STATS_TAG:
+		htt_print_tx_pdev_rate_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RX_PDEV_RATE_STATS_TAG:
+		htt_print_rx_pdev_rate_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG:
+		htt_print_tx_pdev_stats_sched_per_txq_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TX_SCHED_CMN_TAG:
+		htt_print_stats_tx_sched_cmn_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_PDEV_MPDU_STATS_TAG:
+		htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG:
+		htt_print_sched_txq_cmd_posted_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_RING_IF_CMN_TAG:
+		htt_print_ring_if_cmn_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_SFM_CLIENT_USER_TAG:
+		htt_print_sfm_client_user_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_SFM_CLIENT_TAG:
+		htt_print_sfm_client_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_TQM_ERROR_STATS_TAG:
+		htt_print_tx_tqm_error_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG:
+		htt_print_sched_txq_cmd_reaped_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_SRING_CMN_TAG:
+		htt_print_sring_cmn_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_SOUNDING_STATS_TAG:
+		htt_print_tx_sounding_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG:
+		htt_print_tx_selfgen_ac_err_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_SELFGEN_CMN_STATS_TAG:
+		htt_print_tx_selfgen_cmn_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_SELFGEN_AC_STATS_TAG:
+		htt_print_tx_selfgen_ac_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_SELFGEN_AX_STATS_TAG:
+		htt_print_tx_selfgen_ax_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_SELFGEN_AX_ERR_STATS_TAG:
+		htt_print_tx_selfgen_ax_err_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_MUMIMO_SCH_STATS_TAG:
+		htt_print_tx_hwq_mu_mimo_sch_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_MUMIMO_MPDU_STATS_TAG:
+		htt_print_tx_hwq_mu_mimo_mpdu_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_HWQ_MUMIMO_CMN_STATS_TAG:
+		htt_print_tx_hwq_mu_mimo_cmn_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_HW_INTR_MISC_TAG:
+		htt_print_hw_stats_intr_misc_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_HW_WD_TIMEOUT_TAG:
+		htt_print_hw_stats_wd_timeout_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_HW_PDEV_ERRS_TAG:
+		htt_print_hw_stats_pdev_errs_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_COUNTER_NAME_TAG:
+		htt_print_counter_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_TID_DETAILS_TAG:
+		htt_print_tx_tid_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_TID_DETAILS_V1_TAG:
+		htt_print_tx_tid_stats_v1_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_RX_TID_DETAILS_TAG:
+		htt_print_rx_tid_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PEER_STATS_CMN_TAG:
+		htt_print_peer_stats_cmn_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PEER_DETAILS_TAG:
+		htt_print_peer_details_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PEER_MSDU_FLOWQ_TAG:
+		htt_print_msdu_flow_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PEER_TX_RATE_STATS_TAG:
+		htt_print_tx_peer_rate_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PEER_RX_RATE_STATS_TAG:
+		htt_print_rx_peer_rate_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_TX_DE_COMPL_STATS_TAG:
+		htt_print_tx_de_compl_stats_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PDEV_CCA_1SEC_HIST_TAG:
+	case HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG:
+	case HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG:
+		htt_print_pdev_cca_stats_hist_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
+		htt_print_pdev_stats_cca_counters_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_WHAL_TX_TAG:
+		htt_print_hw_stats_whal_tx_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PDEV_TWT_SESSIONS_TAG:
+		htt_print_pdev_stats_twt_sessions_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_PDEV_TWT_SESSION_TAG:
+		htt_print_pdev_stats_twt_session_tlv(tag_buf, stats_req);
+		break;
+
+	case HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG:
+		htt_print_sched_txq_sched_order_su_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG:
+		htt_print_sched_txq_sched_ineligibility_tlv_v(tag_buf, len, stats_req);
+		break;
+
+	case HTT_STATS_PDEV_OBSS_PD_TAG:
+		htt_print_pdev_obss_pd_stats_tlv_v(tag_buf, stats_req);
+		break;
+	case HTT_STATS_RING_BACKPRESSURE_STATS_TAG:
+		htt_print_backpressure_stats_tlv_v(tag_buf, user_data);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
+				      struct sk_buff *skb)
+{
+	struct ath11k_htt_extd_stats_msg *msg;
+	struct debug_htt_stats_req *stats_req;
+	struct ath11k *ar;
+	u32 len;
+	u64 cookie;
+	int ret;
+	bool send_completion = false;
+	u8 pdev_id;
+
+	msg = (struct ath11k_htt_extd_stats_msg *)skb->data;
+	cookie = msg->cookie;
+
+	if (FIELD_GET(HTT_STATS_COOKIE_MSB, cookie) != HTT_STATS_MAGIC_VALUE) {
+		ath11k_warn(ab, "received invalid htt ext stats event\n");
+		return;
+	}
+
+	pdev_id = FIELD_GET(HTT_STATS_COOKIE_LSB, cookie);
+	rcu_read_lock();
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
+	rcu_read_unlock();
+	if (!ar) {
+		ath11k_warn(ab, "failed to get ar for pdev_id %d\n", pdev_id);
+		return;
+	}
+
+	stats_req = ar->debug.htt_stats.stats_req;
+	if (!stats_req)
+		return;
+
+	spin_lock_bh(&ar->debug.htt_stats.lock);
+
+	stats_req->done = FIELD_GET(HTT_T2H_EXT_STATS_INFO1_DONE, msg->info1);
+	if (stats_req->done)
+		send_completion = true;
+
+	spin_unlock_bh(&ar->debug.htt_stats.lock);
+
+	len = FIELD_GET(HTT_T2H_EXT_STATS_INFO1_LENGTH, msg->info1);
+	ret = ath11k_dp_htt_tlv_iter(ab, msg->data, len,
+				     ath11k_dbg_htt_ext_stats_parse,
+				     stats_req);
+	if (ret)
+		ath11k_warn(ab, "Failed to parse tlv %d\n", ret);
+
+	if (send_completion)
+		complete(&stats_req->cmpln);
+}
+
+static ssize_t ath11k_read_htt_stats_type(struct file *file,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	size_t len;
+
+	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.type);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath11k_write_htt_stats_type(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	u8 type;
+	int ret;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	if (ret)
+		return ret;
+
+	if (type >= ATH11K_DBG_HTT_NUM_EXT_STATS)
+		return -E2BIG;
+
+	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET ||
+	    type == ATH11K_DBG_HTT_EXT_STATS_PEER_INFO)
+		return -EPERM;
+
+	ar->debug.htt_stats.type = type;
+
+	ret = count;
+
+	return ret;
+}
+
+static const struct file_operations fops_htt_stats_type = {
+	.read = ath11k_read_htt_stats_type,
+	.write = ath11k_write_htt_stats_type,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int ath11k_prep_htt_stats_cfg_params(struct ath11k *ar, u8 type,
+					    const u8 *mac_addr,
+					    struct htt_ext_stats_cfg_params *cfg_params)
+{
+	if (!cfg_params)
+		return -EINVAL;
+
+	switch (type) {
+	case ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ:
+	case ATH11K_DBG_HTT_EXT_STATS_TX_MU_HWQ:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_HWQS;
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_TXQS;
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_TQM_CMDQ:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_CMDQS;
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_PEER_INFO:
+		cfg_params->cfg0 = HTT_STAT_PEER_INFO_MAC_ADDR;
+		cfg_params->cfg0 |= FIELD_PREP(GENMASK(15, 1),
+					HTT_PEER_STATS_REQ_MODE_FLUSH_TQM);
+		cfg_params->cfg1 = HTT_STAT_DEFAULT_PEER_REQ_TYPE;
+		cfg_params->cfg2 |= FIELD_PREP(GENMASK(7, 0), mac_addr[0]);
+		cfg_params->cfg2 |= FIELD_PREP(GENMASK(15, 8), mac_addr[1]);
+		cfg_params->cfg2 |= FIELD_PREP(GENMASK(23, 16), mac_addr[2]);
+		cfg_params->cfg2 |= FIELD_PREP(GENMASK(31, 24), mac_addr[3]);
+		cfg_params->cfg3 |= FIELD_PREP(GENMASK(7, 0), mac_addr[4]);
+		cfg_params->cfg3 |= FIELD_PREP(GENMASK(15, 8), mac_addr[5]);
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_RING_IF_INFO:
+	case ATH11K_DBG_HTT_EXT_STATS_SRNG_INFO:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_RINGS;
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_ACTIVE_PEERS_LIST:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ACTIVE_PEERS;
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_CCA_CUMULATIVE;
+		break;
+	case ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ACTIVE_VDEVS;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int ath11k_dbg_htt_stats_req(struct ath11k *ar)
+{
+	struct debug_htt_stats_req *stats_req = ar->debug.htt_stats.stats_req;
+	u8 type = stats_req->type;
+	u64 cookie = 0;
+	int ret, pdev_id = ar->pdev->pdev_id;
+	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+
+	init_completion(&stats_req->cmpln);
+
+	stats_req->done = false;
+	stats_req->pdev_id = pdev_id;
+
+	cookie = FIELD_PREP(HTT_STATS_COOKIE_MSB, HTT_STATS_MAGIC_VALUE) |
+		 FIELD_PREP(HTT_STATS_COOKIE_LSB, pdev_id);
+
+	ret = ath11k_prep_htt_stats_cfg_params(ar, type, stats_req->peer_addr,
+					       &cfg_params);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set htt stats cfg params: %d\n", ret);
+		return ret;
+	}
+
+	ret = ath11k_dp_tx_htt_h2t_ext_stats_req(ar, type, &cfg_params, cookie);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
+		return ret;
+	}
+
+	while (!wait_for_completion_timeout(&stats_req->cmpln, 3 * HZ)) {
+		spin_lock_bh(&ar->debug.htt_stats.lock);
+		if (!stats_req->done) {
+			stats_req->done = true;
+			spin_unlock_bh(&ar->debug.htt_stats.lock);
+			ath11k_warn(ar->ab, "stats request timed out\n");
+			return -ETIMEDOUT;
+		}
+		spin_unlock_bh(&ar->debug.htt_stats.lock);
+	}
+
+	return 0;
+}
+
+static int ath11k_open_htt_stats(struct inode *inode, struct file *file)
+{
+	struct ath11k *ar = inode->i_private;
+	struct debug_htt_stats_req *stats_req;
+	u8 type = ar->debug.htt_stats.type;
+	int ret;
+
+	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET)
+		return -EPERM;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	if (ar->debug.htt_stats.stats_req) {
+		ret = -EAGAIN;
+		goto err_unlock;
+	}
+
+	stats_req = vzalloc(sizeof(*stats_req) + ATH11K_HTT_STATS_BUF_SIZE);
+	if (!stats_req) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	ar->debug.htt_stats.stats_req = stats_req;
+	stats_req->type = type;
+
+	ret = ath11k_dbg_htt_stats_req(ar);
+	if (ret < 0)
+		goto out;
+
+	file->private_data = stats_req;
+
+	mutex_unlock(&ar->conf_mutex);
+
+	return 0;
+out:
+	vfree(stats_req);
+	ar->debug.htt_stats.stats_req = NULL;
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
+static int ath11k_release_htt_stats(struct inode *inode, struct file *file)
+{
+	struct ath11k *ar = inode->i_private;
+
+	mutex_lock(&ar->conf_mutex);
+	vfree(file->private_data);
+	ar->debug.htt_stats.stats_req = NULL;
+	mutex_unlock(&ar->conf_mutex);
+
+	return 0;
+}
+
+static ssize_t ath11k_read_htt_stats(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct debug_htt_stats_req *stats_req = file->private_data;
+	char *buf;
+	u32 length = 0;
+
+	buf = stats_req->buf;
+	length = min_t(u32, stats_req->buf_len, ATH11K_HTT_STATS_BUF_SIZE);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, length);
+}
+
+static const struct file_operations fops_dump_htt_stats = {
+	.open = ath11k_open_htt_stats,
+	.release = ath11k_release_htt_stats,
+	.read = ath11k_read_htt_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_read_htt_stats_reset(struct file *file,
+					   char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	size_t len;
+
+	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.reset);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath11k_write_htt_stats_reset(struct file *file,
+					    const char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	u8 type;
+	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	int ret;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	if (ret)
+		return ret;
+
+	if (type >= ATH11K_DBG_HTT_NUM_EXT_STATS ||
+	    type == ATH11K_DBG_HTT_EXT_STATS_RESET)
+		return -E2BIG;
+
+	mutex_lock(&ar->conf_mutex);
+	cfg_params.cfg0 = HTT_STAT_DEFAULT_RESET_START_OFFSET;
+	cfg_params.cfg1 = 1 << (cfg_params.cfg0 + type);
+	ret = ath11k_dp_tx_htt_h2t_ext_stats_req(ar,
+						 ATH11K_DBG_HTT_EXT_STATS_RESET,
+						 &cfg_params,
+						 0ULL);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
+		mutex_unlock(&ar->conf_mutex);
+		return ret;
+	}
+
+	ar->debug.htt_stats.reset = type;
+	mutex_unlock(&ar->conf_mutex);
+
+	ret = count;
+
+	return ret;
+}
+
+static const struct file_operations fops_htt_stats_reset = {
+	.read = ath11k_read_htt_stats_reset,
+	.write = ath11k_write_htt_stats_reset,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath11k_debugfs_htt_stats_init(struct ath11k *ar)
+{
+	spin_lock_init(&ar->debug.htt_stats.lock);
+	debugfs_create_file("htt_stats_type", 0600, ar->debug.debugfs_pdev,
+			    ar, &fops_htt_stats_type);
+	debugfs_create_file("htt_stats", 0400, ar->debug.debugfs_pdev,
+			    ar, &fops_dump_htt_stats);
+	debugfs_create_file("htt_stats_reset", 0600, ar->debug.debugfs_pdev,
+			    ar, &fops_htt_stats_reset);
+}
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
new file mode 100644
index 000000000000..d2d01bfc5081
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -0,0 +1,1690 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef DEBUG_HTT_STATS_H
+#define DEBUG_HTT_STATS_H
+
+#define HTT_STATS_COOKIE_LSB    GENMASK_ULL(31, 0)
+#define HTT_STATS_COOKIE_MSB    GENMASK_ULL(63, 32)
+#define HTT_STATS_MAGIC_VALUE   0xF0F0F0F0
+
+enum htt_tlv_tag_t {
+	HTT_STATS_TX_PDEV_CMN_TAG                           = 0,
+	HTT_STATS_TX_PDEV_UNDERRUN_TAG                      = 1,
+	HTT_STATS_TX_PDEV_SIFS_TAG                          = 2,
+	HTT_STATS_TX_PDEV_FLUSH_TAG                         = 3,
+	HTT_STATS_TX_PDEV_PHY_ERR_TAG                       = 4,
+	HTT_STATS_STRING_TAG                                = 5,
+	HTT_STATS_TX_HWQ_CMN_TAG                            = 6,
+	HTT_STATS_TX_HWQ_DIFS_LATENCY_TAG                   = 7,
+	HTT_STATS_TX_HWQ_CMD_RESULT_TAG                     = 8,
+	HTT_STATS_TX_HWQ_CMD_STALL_TAG                      = 9,
+	HTT_STATS_TX_HWQ_FES_STATUS_TAG                     = 10,
+	HTT_STATS_TX_TQM_GEN_MPDU_TAG                       = 11,
+	HTT_STATS_TX_TQM_LIST_MPDU_TAG                      = 12,
+	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG                  = 13,
+	HTT_STATS_TX_TQM_CMN_TAG                            = 14,
+	HTT_STATS_TX_TQM_PDEV_TAG                           = 15,
+	HTT_STATS_TX_TQM_CMDQ_STATUS_TAG                    = 16,
+	HTT_STATS_TX_DE_EAPOL_PACKETS_TAG                   = 17,
+	HTT_STATS_TX_DE_CLASSIFY_FAILED_TAG                 = 18,
+	HTT_STATS_TX_DE_CLASSIFY_STATS_TAG                  = 19,
+	HTT_STATS_TX_DE_CLASSIFY_STATUS_TAG                 = 20,
+	HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG                 = 21,
+	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG                 = 22,
+	HTT_STATS_TX_DE_CMN_TAG                             = 23,
+	HTT_STATS_RING_IF_TAG                               = 24,
+	HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG                 = 25,
+	HTT_STATS_SFM_CMN_TAG                               = 26,
+	HTT_STATS_SRING_STATS_TAG                           = 27,
+	HTT_STATS_RX_PDEV_FW_STATS_TAG                      = 28,
+	HTT_STATS_RX_PDEV_FW_RING_MPDU_ERR_TAG              = 29,
+	HTT_STATS_RX_PDEV_FW_MPDU_DROP_TAG                  = 30,
+	HTT_STATS_RX_SOC_FW_STATS_TAG                       = 31,
+	HTT_STATS_RX_SOC_FW_REFILL_RING_EMPTY_TAG           = 32,
+	HTT_STATS_RX_SOC_FW_REFILL_RING_NUM_REFILL_TAG      = 33,
+	HTT_STATS_TX_PDEV_RATE_STATS_TAG                    = 34,
+	HTT_STATS_RX_PDEV_RATE_STATS_TAG                    = 35,
+	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG           = 36,
+	HTT_STATS_TX_SCHED_CMN_TAG                          = 37,
+	HTT_STATS_TX_PDEV_MUMIMO_MPDU_STATS_TAG             = 38,
+	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG                  = 39,
+	HTT_STATS_RING_IF_CMN_TAG                           = 40,
+	HTT_STATS_SFM_CLIENT_USER_TAG                       = 41,
+	HTT_STATS_SFM_CLIENT_TAG                            = 42,
+	HTT_STATS_TX_TQM_ERROR_STATS_TAG                    = 43,
+	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG                  = 44,
+	HTT_STATS_SRING_CMN_TAG                             = 45,
+	HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG               = 46,
+	HTT_STATS_TX_SELFGEN_CMN_STATS_TAG                  = 47,
+	HTT_STATS_TX_SELFGEN_AC_STATS_TAG                   = 48,
+	HTT_STATS_TX_SELFGEN_AX_STATS_TAG                   = 49,
+	HTT_STATS_TX_SELFGEN_AX_ERR_STATS_TAG               = 50,
+	HTT_STATS_TX_HWQ_MUMIMO_SCH_STATS_TAG               = 51,
+	HTT_STATS_TX_HWQ_MUMIMO_MPDU_STATS_TAG              = 52,
+	HTT_STATS_TX_HWQ_MUMIMO_CMN_STATS_TAG               = 53,
+	HTT_STATS_HW_INTR_MISC_TAG                          = 54,
+	HTT_STATS_HW_WD_TIMEOUT_TAG                         = 55,
+	HTT_STATS_HW_PDEV_ERRS_TAG                          = 56,
+	HTT_STATS_COUNTER_NAME_TAG                          = 57,
+	HTT_STATS_TX_TID_DETAILS_TAG                        = 58,
+	HTT_STATS_RX_TID_DETAILS_TAG                        = 59,
+	HTT_STATS_PEER_STATS_CMN_TAG                        = 60,
+	HTT_STATS_PEER_DETAILS_TAG                          = 61,
+	HTT_STATS_PEER_TX_RATE_STATS_TAG                    = 62,
+	HTT_STATS_PEER_RX_RATE_STATS_TAG                    = 63,
+	HTT_STATS_PEER_MSDU_FLOWQ_TAG                       = 64,
+	HTT_STATS_TX_DE_COMPL_STATS_TAG                     = 65,
+	HTT_STATS_WHAL_TX_TAG                               = 66,
+	HTT_STATS_TX_PDEV_SIFS_HIST_TAG                     = 67,
+	HTT_STATS_RX_PDEV_FW_STATS_PHY_ERR_TAG              = 68,
+	HTT_STATS_TX_TID_DETAILS_V1_TAG                     = 69,
+	HTT_STATS_PDEV_CCA_1SEC_HIST_TAG                    = 70,
+	HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG                 = 71,
+	HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG              = 72,
+	HTT_STATS_PDEV_CCA_COUNTERS_TAG                     = 73,
+	HTT_STATS_TX_PDEV_MPDU_STATS_TAG                    = 74,
+	HTT_STATS_PDEV_TWT_SESSIONS_TAG                     = 75,
+	HTT_STATS_PDEV_TWT_SESSION_TAG                      = 76,
+	HTT_STATS_RX_REFILL_RXDMA_ERR_TAG                   = 77,
+	HTT_STATS_RX_REFILL_REO_ERR_TAG                     = 78,
+	HTT_STATS_RX_REO_RESOURCE_STATS_TAG                 = 79,
+	HTT_STATS_TX_SOUNDING_STATS_TAG                     = 80,
+	HTT_STATS_TX_PDEV_TX_PPDU_STATS_TAG                 = 81,
+	HTT_STATS_TX_PDEV_TRIED_MPDU_CNT_HIST_TAG           = 82,
+	HTT_STATS_TX_HWQ_TRIED_MPDU_CNT_HIST_TAG            = 83,
+	HTT_STATS_TX_HWQ_TXOP_USED_CNT_HIST_TAG             = 84,
+	HTT_STATS_TX_DE_FW2WBM_RING_FULL_HIST_TAG           = 85,
+	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG              = 86,
+	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG         = 87,
+	HTT_STATS_PDEV_OBSS_PD_TAG                          = 88,
+	HTT_STATS_HW_WAR_TAG				    = 89,
+	HTT_STATS_RING_BACKPRESSURE_STATS_TAG		    = 90,
+
+	HTT_STATS_MAX_TAG,
+};
+
+#define HTT_STATS_MAX_STRING_SZ32            4
+#define HTT_STATS_MACID_INVALID              0xff
+#define HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS     10
+#define HTT_TX_HWQ_MAX_CMD_RESULT_STATS      13
+#define HTT_TX_HWQ_MAX_CMD_STALL_STATS       5
+#define HTT_TX_HWQ_MAX_FES_RESULT_STATS      10
+
+enum htt_tx_pdev_underrun_enum {
+	HTT_STATS_TX_PDEV_NO_DATA_UNDERRUN           = 0,
+	HTT_STATS_TX_PDEV_DATA_UNDERRUN_BETWEEN_MPDU = 1,
+	HTT_STATS_TX_PDEV_DATA_UNDERRUN_WITHIN_MPDU  = 2,
+	HTT_TX_PDEV_MAX_URRN_STATS                   = 3,
+};
+
+#define HTT_TX_PDEV_MAX_FLUSH_REASON_STATS     71
+#define HTT_TX_PDEV_MAX_SIFS_BURST_STATS       9
+#define HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS  10
+#define HTT_TX_PDEV_MAX_PHY_ERR_STATS          18
+#define HTT_TX_PDEV_SCHED_TX_MODE_MAX          4
+#define HTT_TX_PDEV_NUM_SCHED_ORDER_LOG        20
+
+#define HTT_RX_STATS_REFILL_MAX_RING         4
+#define HTT_RX_STATS_RXDMA_MAX_ERR           16
+#define HTT_RX_STATS_FW_DROP_REASON_MAX      16
+
+/* Bytes stored in little endian order */
+/* Length should be multiple of DWORD */
+struct htt_stats_string_tlv {
+	u32 data[0]; /* Can be variable length */
+} __packed;
+
+/* == TX PDEV STATS == */
+struct htt_tx_pdev_stats_cmn_tlv {
+	u32 mac_id__word;
+	u32 hw_queued;
+	u32 hw_reaped;
+	u32 underrun;
+	u32 hw_paused;
+	u32 hw_flush;
+	u32 hw_filt;
+	u32 tx_abort;
+	u32 mpdu_requed;
+	u32 tx_xretry;
+	u32 data_rc;
+	u32 mpdu_dropped_xretry;
+	u32 illgl_rate_phy_err;
+	u32 cont_xretry;
+	u32 tx_timeout;
+	u32 pdev_resets;
+	u32 phy_underrun;
+	u32 txop_ovf;
+	u32 seq_posted;
+	u32 seq_failed_queueing;
+	u32 seq_completed;
+	u32 seq_restarted;
+	u32 mu_seq_posted;
+	u32 seq_switch_hw_paused;
+	u32 next_seq_posted_dsr;
+	u32 seq_posted_isr;
+	u32 seq_ctrl_cached;
+	u32 mpdu_count_tqm;
+	u32 msdu_count_tqm;
+	u32 mpdu_removed_tqm;
+	u32 msdu_removed_tqm;
+	u32 mpdus_sw_flush;
+	u32 mpdus_hw_filter;
+	u32 mpdus_truncated;
+	u32 mpdus_ack_failed;
+	u32 mpdus_expired;
+	u32 mpdus_seq_hw_retry;
+	u32 ack_tlv_proc;
+	u32 coex_abort_mpdu_cnt_valid;
+	u32 coex_abort_mpdu_cnt;
+	u32 num_total_ppdus_tried_ota;
+	u32 num_data_ppdus_tried_ota;
+	u32 local_ctrl_mgmt_enqued;
+	u32 local_ctrl_mgmt_freed;
+	u32 local_data_enqued;
+	u32 local_data_freed;
+	u32 mpdu_tried;
+	u32 isr_wait_seq_posted;
+
+	u32 tx_active_dur_us_low;
+	u32 tx_active_dur_us_high;
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_pdev_stats_urrn_tlv_v {
+	u32 urrn_stats[0]; /* HTT_TX_PDEV_MAX_URRN_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_pdev_stats_flush_tlv_v {
+	u32 flush_errs[0]; /* HTT_TX_PDEV_MAX_FLUSH_REASON_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_pdev_stats_sifs_tlv_v {
+	u32 sifs_status[0]; /* HTT_TX_PDEV_MAX_SIFS_BURST_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_pdev_stats_phy_err_tlv_v {
+	u32  phy_errs[0]; /* HTT_TX_PDEV_MAX_PHY_ERR_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_pdev_stats_sifs_hist_tlv_v {
+	u32 sifs_hist_status[0]; /* HTT_TX_PDEV_SIFS_BURST_HIST_STATS */
+};
+
+struct htt_tx_pdev_stats_tx_ppdu_stats_tlv_v {
+	u32 num_data_ppdus_legacy_su;
+	u32 num_data_ppdus_ac_su;
+	u32 num_data_ppdus_ax_su;
+	u32 num_data_ppdus_ac_su_txbf;
+	u32 num_data_ppdus_ax_su_txbf;
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size .
+ *
+ *  Tried_mpdu_cnt_hist is the histogram of MPDUs tries per HWQ.
+ *  The tries here is the count of the  MPDUS within a PPDU that the
+ *  HW had attempted to transmit on  air, for the HWSCH Schedule
+ *  command submitted by FW.It is not the retry attempts.
+ *  The histogram bins are  0-29, 30-59, 60-89 and so on. The are
+ *   10 bins in this histogram. They are defined in FW using the
+ *  following macros
+ *  #define WAL_MAX_TRIED_MPDU_CNT_HISTOGRAM 9
+ *  #define WAL_TRIED_MPDU_CNT_HISTOGRAM_INTERVAL 30
+ */
+struct htt_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v {
+	u32 hist_bin_size;
+	u32 tried_mpdu_cnt_hist[]; /* HTT_TX_PDEV_TRIED_MPDU_CNT_HIST */
+};
+
+/* == SOC ERROR STATS == */
+
+/* =============== PDEV ERROR STATS ============== */
+#define HTT_STATS_MAX_HW_INTR_NAME_LEN 8
+struct htt_hw_stats_intr_misc_tlv {
+	/* Stored as little endian */
+	u8 hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN];
+	u32 mask;
+	u32 count;
+};
+
+#define HTT_STATS_MAX_HW_MODULE_NAME_LEN 8
+struct htt_hw_stats_wd_timeout_tlv {
+	/* Stored as little endian */
+	u8 hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN];
+	u32 count;
+};
+
+struct htt_hw_stats_pdev_errs_tlv {
+	u32    mac_id__word; /* BIT [ 7 :  0] : mac_id */
+	u32    tx_abort;
+	u32    tx_abort_fail_count;
+	u32    rx_abort;
+	u32    rx_abort_fail_count;
+	u32    warm_reset;
+	u32    cold_reset;
+	u32    tx_flush;
+	u32    tx_glb_reset;
+	u32    tx_txq_reset;
+	u32    rx_timeout_reset;
+};
+
+struct htt_hw_stats_whal_tx_tlv {
+	u32 mac_id__word;
+	u32 last_unpause_ppdu_id;
+	u32 hwsch_unpause_wait_tqm_write;
+	u32 hwsch_dummy_tlv_skipped;
+	u32 hwsch_misaligned_offset_received;
+	u32 hwsch_reset_count;
+	u32 hwsch_dev_reset_war;
+	u32 hwsch_delayed_pause;
+	u32 hwsch_long_delayed_pause;
+	u32 sch_rx_ppdu_no_response;
+	u32 sch_selfgen_response;
+	u32 sch_rx_sifs_resp_trigger;
+};
+
+/* ============ PEER STATS ============ */
+struct htt_msdu_flow_stats_tlv {
+	u32 last_update_timestamp;
+	u32 last_add_timestamp;
+	u32 last_remove_timestamp;
+	u32 total_processed_msdu_count;
+	u32 cur_msdu_count_in_flowq;
+	u32 sw_peer_id;
+	u32 tx_flow_no__tid_num__drop_rule;
+	u32 last_cycle_enqueue_count;
+	u32 last_cycle_dequeue_count;
+	u32 last_cycle_drop_count;
+	u32 current_drop_th;
+};
+
+#define MAX_HTT_TID_NAME 8
+
+/* Tidq stats */
+struct htt_tx_tid_stats_tlv {
+	/* Stored as little endian */
+	u8     tid_name[MAX_HTT_TID_NAME];
+	u32 sw_peer_id__tid_num;
+	u32 num_sched_pending__num_ppdu_in_hwq;
+	u32 tid_flags;
+	u32 hw_queued;
+	u32 hw_reaped;
+	u32 mpdus_hw_filter;
+
+	u32 qdepth_bytes;
+	u32 qdepth_num_msdu;
+	u32 qdepth_num_mpdu;
+	u32 last_scheduled_tsmp;
+	u32 pause_module_id;
+	u32 block_module_id;
+	u32 tid_tx_airtime;
+};
+
+/* Tidq stats */
+struct htt_tx_tid_stats_v1_tlv {
+	/* Stored as little endian */
+	u8 tid_name[MAX_HTT_TID_NAME];
+	u32 sw_peer_id__tid_num;
+	u32 num_sched_pending__num_ppdu_in_hwq;
+	u32 tid_flags;
+	u32 max_qdepth_bytes;
+	u32 max_qdepth_n_msdus;
+	u32 rsvd;
+
+	u32 qdepth_bytes;
+	u32 qdepth_num_msdu;
+	u32 qdepth_num_mpdu;
+	u32 last_scheduled_tsmp;
+	u32 pause_module_id;
+	u32 block_module_id;
+	u32 tid_tx_airtime;
+	u32 allow_n_flags;
+	u32 sendn_frms_allowed;
+};
+
+struct htt_rx_tid_stats_tlv {
+	u32 sw_peer_id__tid_num;
+	u8 tid_name[MAX_HTT_TID_NAME];
+	u32 dup_in_reorder;
+	u32 dup_past_outside_window;
+	u32 dup_past_within_window;
+	u32 rxdesc_err_decrypt;
+	u32 tid_rx_airtime;
+};
+
+#define HTT_MAX_COUNTER_NAME 8
+struct htt_counter_tlv {
+	u8 counter_name[HTT_MAX_COUNTER_NAME];
+	u32 count;
+};
+
+struct htt_peer_stats_cmn_tlv {
+	u32 ppdu_cnt;
+	u32 mpdu_cnt;
+	u32 msdu_cnt;
+	u32 pause_bitmap;
+	u32 block_bitmap;
+	u32 current_timestamp;
+	u32 peer_tx_airtime;
+	u32 peer_rx_airtime;
+	s32 rssi;
+	u32 peer_enqueued_count_low;
+	u32 peer_enqueued_count_high;
+	u32 peer_dequeued_count_low;
+	u32 peer_dequeued_count_high;
+	u32 peer_dropped_count_low;
+	u32 peer_dropped_count_high;
+	u32 ppdu_transmitted_bytes_low;
+	u32 ppdu_transmitted_bytes_high;
+	u32 peer_ttl_removed_count;
+	u32 inactive_time;
+};
+
+struct htt_peer_details_tlv {
+	u32 peer_type;
+	u32 sw_peer_id;
+	u32 vdev_pdev_ast_idx;
+	struct htt_mac_addr mac_addr;
+	u32 peer_flags;
+	u32 qpeer_flags;
+};
+
+enum htt_stats_param_type {
+	HTT_STATS_PREAM_OFDM,
+	HTT_STATS_PREAM_CCK,
+	HTT_STATS_PREAM_HT,
+	HTT_STATS_PREAM_VHT,
+	HTT_STATS_PREAM_HE,
+	HTT_STATS_PREAM_RSVD,
+	HTT_STATS_PREAM_RSVD1,
+
+	HTT_STATS_PREAM_COUNT,
+};
+
+#define HTT_TX_PEER_STATS_NUM_MCS_COUNTERS        12
+#define HTT_TX_PEER_STATS_NUM_GI_COUNTERS          4
+#define HTT_TX_PEER_STATS_NUM_DCM_COUNTERS         5
+#define HTT_TX_PEER_STATS_NUM_BW_COUNTERS          4
+#define HTT_TX_PEER_STATS_NUM_SPATIAL_STREAMS      8
+#define HTT_TX_PEER_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
+
+struct htt_tx_peer_rate_stats_tlv {
+	u32 tx_ldpc;
+	u32 rts_cnt;
+	u32 ack_rssi;
+
+	u32 tx_mcs[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
+	u32 tx_su_mcs[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
+	u32 tx_mu_mcs[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
+	/* element 0,1, ...7 -> NSS 1,2, ...8 */
+	u32 tx_nss[HTT_TX_PEER_STATS_NUM_SPATIAL_STREAMS];
+	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
+	u32 tx_bw[HTT_TX_PEER_STATS_NUM_BW_COUNTERS];
+	u32 tx_stbc[HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
+	u32 tx_pream[HTT_TX_PEER_STATS_NUM_PREAMBLE_TYPES];
+
+	/* Counters to track number of tx packets in each GI
+	 * (400us, 800us, 1600us & 3200us) in each mcs (0-11)
+	 */
+	u32 tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS][HTT_TX_PEER_STATS_NUM_MCS_COUNTERS];
+
+	/* Counters to track packets in dcm mcs (MCS 0, 1, 3, 4) */
+	u32 tx_dcm[HTT_TX_PEER_STATS_NUM_DCM_COUNTERS];
+
+};
+
+#define HTT_RX_PEER_STATS_NUM_MCS_COUNTERS        12
+#define HTT_RX_PEER_STATS_NUM_GI_COUNTERS          4
+#define HTT_RX_PEER_STATS_NUM_DCM_COUNTERS         5
+#define HTT_RX_PEER_STATS_NUM_BW_COUNTERS          4
+#define HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS      8
+#define HTT_RX_PEER_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
+
+struct htt_rx_peer_rate_stats_tlv {
+	u32 nsts;
+
+	/* Number of rx ldpc packets */
+	u32 rx_ldpc;
+	/* Number of rx rts packets */
+	u32 rts_cnt;
+
+	u32 rssi_mgmt; /* units = dB above noise floor */
+	u32 rssi_data; /* units = dB above noise floor */
+	u32 rssi_comb; /* units = dB above noise floor */
+	u32 rx_mcs[HTT_RX_PEER_STATS_NUM_MCS_COUNTERS];
+	/* element 0,1, ...7 -> NSS 1,2, ...8 */
+	u32 rx_nss[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS];
+	u32 rx_dcm[HTT_RX_PEER_STATS_NUM_DCM_COUNTERS];
+	u32 rx_stbc[HTT_RX_PEER_STATS_NUM_MCS_COUNTERS];
+	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
+	u32 rx_bw[HTT_RX_PEER_STATS_NUM_BW_COUNTERS];
+	u32 rx_pream[HTT_RX_PEER_STATS_NUM_PREAMBLE_TYPES];
+	/* units = dB above noise floor */
+	u8 rssi_chain[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS]
+		     [HTT_RX_PEER_STATS_NUM_BW_COUNTERS];
+
+	/* Counters to track number of rx packets in each GI in each mcs (0-11) */
+	u32 rx_gi[HTT_RX_PEER_STATS_NUM_GI_COUNTERS]
+		 [HTT_RX_PEER_STATS_NUM_MCS_COUNTERS];
+};
+
+enum htt_peer_stats_req_mode {
+	HTT_PEER_STATS_REQ_MODE_NO_QUERY,
+	HTT_PEER_STATS_REQ_MODE_QUERY_TQM,
+	HTT_PEER_STATS_REQ_MODE_FLUSH_TQM,
+};
+
+enum htt_peer_stats_tlv_enum {
+	HTT_PEER_STATS_CMN_TLV       = 0,
+	HTT_PEER_DETAILS_TLV         = 1,
+	HTT_TX_PEER_RATE_STATS_TLV   = 2,
+	HTT_RX_PEER_RATE_STATS_TLV   = 3,
+	HTT_TX_TID_STATS_TLV         = 4,
+	HTT_RX_TID_STATS_TLV         = 5,
+	HTT_MSDU_FLOW_STATS_TLV      = 6,
+
+	HTT_PEER_STATS_MAX_TLV       = 31,
+};
+
+/* =========== MUMIMO HWQ stats =========== */
+/* MU MIMO stats per hwQ */
+struct htt_tx_hwq_mu_mimo_sch_stats_tlv {
+	u32 mu_mimo_sch_posted;
+	u32 mu_mimo_sch_failed;
+	u32 mu_mimo_ppdu_posted;
+};
+
+struct htt_tx_hwq_mu_mimo_mpdu_stats_tlv {
+	u32 mu_mimo_mpdus_queued_usr;
+	u32 mu_mimo_mpdus_tried_usr;
+	u32 mu_mimo_mpdus_failed_usr;
+	u32 mu_mimo_mpdus_requeued_usr;
+	u32 mu_mimo_err_no_ba_usr;
+	u32 mu_mimo_mpdu_underrun_usr;
+	u32 mu_mimo_ampdu_underrun_usr;
+};
+
+struct htt_tx_hwq_mu_mimo_cmn_stats_tlv {
+	u32 mac_id__hwq_id__word;
+};
+
+/* == TX HWQ STATS == */
+struct htt_tx_hwq_stats_cmn_tlv {
+	u32 mac_id__hwq_id__word;
+
+	/* PPDU level stats */
+	u32 xretry;
+	u32 underrun_cnt;
+	u32 flush_cnt;
+	u32 filt_cnt;
+	u32 null_mpdu_bmap;
+	u32 user_ack_failure;
+	u32 ack_tlv_proc;
+	u32 sched_id_proc;
+	u32 null_mpdu_tx_count;
+	u32 mpdu_bmap_not_recvd;
+
+	/* Selfgen stats per hwQ */
+	u32 num_bar;
+	u32 rts;
+	u32 cts2self;
+	u32 qos_null;
+
+	/* MPDU level stats */
+	u32 mpdu_tried_cnt;
+	u32 mpdu_queued_cnt;
+	u32 mpdu_ack_fail_cnt;
+	u32 mpdu_filt_cnt;
+	u32 false_mpdu_ack_count;
+
+	u32 txq_timeout;
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_hwq_difs_latency_stats_tlv_v {
+	u32 hist_intvl;
+	/* histogram of ppdu post to hwsch - > cmd status received */
+	u32 difs_latency_hist[]; /* HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_hwq_cmd_result_stats_tlv_v {
+	/* Histogram of sched cmd result */
+	u32 cmd_result[0]; /* HTT_TX_HWQ_MAX_CMD_RESULT_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_hwq_cmd_stall_stats_tlv_v {
+	/* Histogram of various pause conitions */
+	u32 cmd_stall_status[0]; /* HTT_TX_HWQ_MAX_CMD_STALL_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_hwq_fes_result_stats_tlv_v {
+	/* Histogram of number of user fes result */
+	u32 fes_result[0]; /* HTT_TX_HWQ_MAX_FES_RESULT_STATS */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size
+ *
+ *  The hwq_tried_mpdu_cnt_hist is a  histogram of MPDUs tries per HWQ.
+ *  The tries here is the count of the  MPDUS within a PPDU that the HW
+ *  had attempted to transmit on  air, for the HWSCH Schedule command
+ *  submitted by FW in this HWQ .It is not the retry attempts. The
+ *  histogram bins are  0-29, 30-59, 60-89 and so on. The are 10 bins
+ *  in this histogram.
+ *  they are defined in FW using the following macros
+ *  #define WAL_MAX_TRIED_MPDU_CNT_HISTOGRAM 9
+ *  #define WAL_TRIED_MPDU_CNT_HISTOGRAM_INTERVAL 30
+ */
+struct htt_tx_hwq_tried_mpdu_cnt_hist_tlv_v {
+	u32 hist_bin_size;
+	/* Histogram of number of mpdus on tried mpdu */
+	u32 tried_mpdu_cnt_hist[]; /* HTT_TX_HWQ_TRIED_MPDU_CNT_HIST */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size
+ *
+ * The txop_used_cnt_hist is the histogram of txop per burst. After
+ * completing the burst, we identify the txop used in the burst and
+ * incr the corresponding bin.
+ * Each bin represents 1ms & we have 10 bins in this histogram.
+ * they are deined in FW using the following macros
+ * #define WAL_MAX_TXOP_USED_CNT_HISTOGRAM 10
+ * #define WAL_TXOP_USED_HISTOGRAM_INTERVAL 1000 ( 1 ms )
+ */
+struct htt_tx_hwq_txop_used_cnt_hist_tlv_v {
+	/* Histogram of txop used cnt */
+	u32 txop_used_cnt_hist[0]; /* HTT_TX_HWQ_TXOP_USED_CNT_HIST */
+};
+
+/* == TX SELFGEN STATS == */
+struct htt_tx_selfgen_cmn_stats_tlv {
+	u32 mac_id__word;
+	u32 su_bar;
+	u32 rts;
+	u32 cts2self;
+	u32 qos_null;
+	u32 delayed_bar_1; /* MU user 1 */
+	u32 delayed_bar_2; /* MU user 2 */
+	u32 delayed_bar_3; /* MU user 3 */
+	u32 delayed_bar_4; /* MU user 4 */
+	u32 delayed_bar_5; /* MU user 5 */
+	u32 delayed_bar_6; /* MU user 6 */
+	u32 delayed_bar_7; /* MU user 7 */
+};
+
+struct htt_tx_selfgen_ac_stats_tlv {
+	/* 11AC */
+	u32 ac_su_ndpa;
+	u32 ac_su_ndp;
+	u32 ac_mu_mimo_ndpa;
+	u32 ac_mu_mimo_ndp;
+	u32 ac_mu_mimo_brpoll_1; /* MU user 1 */
+	u32 ac_mu_mimo_brpoll_2; /* MU user 2 */
+	u32 ac_mu_mimo_brpoll_3; /* MU user 3 */
+};
+
+struct htt_tx_selfgen_ax_stats_tlv {
+	/* 11AX */
+	u32 ax_su_ndpa;
+	u32 ax_su_ndp;
+	u32 ax_mu_mimo_ndpa;
+	u32 ax_mu_mimo_ndp;
+	u32 ax_mu_mimo_brpoll_1; /* MU user 1 */
+	u32 ax_mu_mimo_brpoll_2; /* MU user 2 */
+	u32 ax_mu_mimo_brpoll_3; /* MU user 3 */
+	u32 ax_mu_mimo_brpoll_4; /* MU user 4 */
+	u32 ax_mu_mimo_brpoll_5; /* MU user 5 */
+	u32 ax_mu_mimo_brpoll_6; /* MU user 6 */
+	u32 ax_mu_mimo_brpoll_7; /* MU user 7 */
+	u32 ax_basic_trigger;
+	u32 ax_bsr_trigger;
+	u32 ax_mu_bar_trigger;
+	u32 ax_mu_rts_trigger;
+};
+
+struct htt_tx_selfgen_ac_err_stats_tlv {
+	/* 11AC error stats */
+	u32 ac_su_ndp_err;
+	u32 ac_su_ndpa_err;
+	u32 ac_mu_mimo_ndpa_err;
+	u32 ac_mu_mimo_ndp_err;
+	u32 ac_mu_mimo_brp1_err;
+	u32 ac_mu_mimo_brp2_err;
+	u32 ac_mu_mimo_brp3_err;
+};
+
+struct htt_tx_selfgen_ax_err_stats_tlv {
+	/* 11AX error stats */
+	u32 ax_su_ndp_err;
+	u32 ax_su_ndpa_err;
+	u32 ax_mu_mimo_ndpa_err;
+	u32 ax_mu_mimo_ndp_err;
+	u32 ax_mu_mimo_brp1_err;
+	u32 ax_mu_mimo_brp2_err;
+	u32 ax_mu_mimo_brp3_err;
+	u32 ax_mu_mimo_brp4_err;
+	u32 ax_mu_mimo_brp5_err;
+	u32 ax_mu_mimo_brp6_err;
+	u32 ax_mu_mimo_brp7_err;
+	u32 ax_basic_trigger_err;
+	u32 ax_bsr_trigger_err;
+	u32 ax_mu_bar_trigger_err;
+	u32 ax_mu_rts_trigger_err;
+};
+
+/* == TX MU STATS == */
+#define HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS 4
+#define HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS 8
+#define HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS    74
+
+struct htt_tx_pdev_mu_mimo_sch_stats_tlv {
+	/* mu-mimo sw sched cmd stats */
+	u32 mu_mimo_sch_posted;
+	u32 mu_mimo_sch_failed;
+	/* MU PPDU stats per hwQ */
+	u32 mu_mimo_ppdu_posted;
+	/*
+	 * Counts the number of users in each transmission of
+	 * the given TX mode.
+	 *
+	 * Index is the number of users - 1.
+	 */
+	u32 ac_mu_mimo_sch_nusers[HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS];
+	u32 ax_mu_mimo_sch_nusers[HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS];
+	u32 ax_ofdma_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
+};
+
+struct htt_tx_pdev_mu_mimo_mpdu_stats_tlv {
+	u32 mu_mimo_mpdus_queued_usr;
+	u32 mu_mimo_mpdus_tried_usr;
+	u32 mu_mimo_mpdus_failed_usr;
+	u32 mu_mimo_mpdus_requeued_usr;
+	u32 mu_mimo_err_no_ba_usr;
+	u32 mu_mimo_mpdu_underrun_usr;
+	u32 mu_mimo_ampdu_underrun_usr;
+
+	u32 ax_mu_mimo_mpdus_queued_usr;
+	u32 ax_mu_mimo_mpdus_tried_usr;
+	u32 ax_mu_mimo_mpdus_failed_usr;
+	u32 ax_mu_mimo_mpdus_requeued_usr;
+	u32 ax_mu_mimo_err_no_ba_usr;
+	u32 ax_mu_mimo_mpdu_underrun_usr;
+	u32 ax_mu_mimo_ampdu_underrun_usr;
+
+	u32 ax_ofdma_mpdus_queued_usr;
+	u32 ax_ofdma_mpdus_tried_usr;
+	u32 ax_ofdma_mpdus_failed_usr;
+	u32 ax_ofdma_mpdus_requeued_usr;
+	u32 ax_ofdma_err_no_ba_usr;
+	u32 ax_ofdma_mpdu_underrun_usr;
+	u32 ax_ofdma_ampdu_underrun_usr;
+};
+
+#define HTT_STATS_TX_SCHED_MODE_MU_MIMO_AC  1
+#define HTT_STATS_TX_SCHED_MODE_MU_MIMO_AX  2
+#define HTT_STATS_TX_SCHED_MODE_MU_OFDMA_AX 3
+
+struct htt_tx_pdev_mpdu_stats_tlv {
+	/* mpdu level stats */
+	u32 mpdus_queued_usr;
+	u32 mpdus_tried_usr;
+	u32 mpdus_failed_usr;
+	u32 mpdus_requeued_usr;
+	u32 err_no_ba_usr;
+	u32 mpdu_underrun_usr;
+	u32 ampdu_underrun_usr;
+	u32 user_index;
+	u32 tx_sched_mode; /* HTT_STATS_TX_SCHED_MODE_xxx */
+};
+
+/* == TX SCHED STATS == */
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_sched_txq_cmd_posted_tlv_v {
+	u32 sched_cmd_posted[0]; /* HTT_TX_PDEV_SCHED_TX_MODE_MAX */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_sched_txq_cmd_reaped_tlv_v {
+	u32 sched_cmd_reaped[0]; /* HTT_TX_PDEV_SCHED_TX_MODE_MAX */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_sched_txq_sched_order_su_tlv_v {
+	u32 sched_order_su[0]; /* HTT_TX_PDEV_NUM_SCHED_ORDER_LOG */
+};
+
+enum htt_sched_txq_sched_ineligibility_tlv_enum {
+	HTT_SCHED_TID_SKIP_SCHED_MASK_DISABLED = 0,
+	HTT_SCHED_TID_SKIP_NOTIFY_MPDU,
+	HTT_SCHED_TID_SKIP_MPDU_STATE_INVALID,
+	HTT_SCHED_TID_SKIP_SCHED_DISABLED,
+	HTT_SCHED_TID_SKIP_TQM_BYPASS_CMD_PENDING,
+	HTT_SCHED_TID_SKIP_SECOND_SU_SCHEDULE,
+
+	HTT_SCHED_TID_SKIP_CMD_SLOT_NOT_AVAIL,
+	HTT_SCHED_TID_SKIP_NO_ENQ,
+	HTT_SCHED_TID_SKIP_LOW_ENQ,
+	HTT_SCHED_TID_SKIP_PAUSED,
+	HTT_SCHED_TID_SKIP_UL,
+	HTT_SCHED_TID_REMOVE_PAUSED,
+	HTT_SCHED_TID_REMOVE_NO_ENQ,
+	HTT_SCHED_TID_REMOVE_UL,
+	HTT_SCHED_TID_QUERY,
+	HTT_SCHED_TID_SU_ONLY,
+	HTT_SCHED_TID_ELIGIBLE,
+	HTT_SCHED_INELIGIBILITY_MAX,
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_sched_txq_sched_ineligibility_tlv_v {
+	/* indexed by htt_sched_txq_sched_ineligibility_tlv_enum */
+	u32 sched_ineligibility[0];
+};
+
+struct htt_tx_pdev_stats_sched_per_txq_tlv {
+	u32 mac_id__txq_id__word;
+	u32 sched_policy;
+	u32 last_sched_cmd_posted_timestamp;
+	u32 last_sched_cmd_compl_timestamp;
+	u32 sched_2_tac_lwm_count;
+	u32 sched_2_tac_ring_full;
+	u32 sched_cmd_post_failure;
+	u32 num_active_tids;
+	u32 num_ps_schedules;
+	u32 sched_cmds_pending;
+	u32 num_tid_register;
+	u32 num_tid_unregister;
+	u32 num_qstats_queried;
+	u32 qstats_update_pending;
+	u32 last_qstats_query_timestamp;
+	u32 num_tqm_cmdq_full;
+	u32 num_de_sched_algo_trigger;
+	u32 num_rt_sched_algo_trigger;
+	u32 num_tqm_sched_algo_trigger;
+	u32 notify_sched;
+	u32 dur_based_sendn_term;
+};
+
+struct htt_stats_tx_sched_cmn_tlv {
+	/* BIT [ 7 :  0]   :- mac_id
+	 * BIT [31 :  8]   :- reserved
+	 */
+	u32 mac_id__word;
+	/* Current timestamp */
+	u32 current_timestamp;
+};
+
+/* == TQM STATS == */
+#define HTT_TX_TQM_MAX_GEN_MPDU_END_REASON          16
+#define HTT_TX_TQM_MAX_LIST_MPDU_END_REASON         16
+#define HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS 16
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_tqm_gen_mpdu_stats_tlv_v {
+	u32 gen_mpdu_end_reason[0]; /* HTT_TX_TQM_MAX_GEN_MPDU_END_REASON */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_tqm_list_mpdu_stats_tlv_v {
+	u32 list_mpdu_end_reason[0]; /* HTT_TX_TQM_MAX_LIST_MPDU_END_REASON */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_tx_tqm_list_mpdu_cnt_tlv_v {
+	u32 list_mpdu_cnt_hist[0];
+			/* HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS */
+};
+
+struct htt_tx_tqm_pdev_stats_tlv_v {
+	u32 msdu_count;
+	u32 mpdu_count;
+	u32 remove_msdu;
+	u32 remove_mpdu;
+	u32 remove_msdu_ttl;
+	u32 send_bar;
+	u32 bar_sync;
+	u32 notify_mpdu;
+	u32 sync_cmd;
+	u32 write_cmd;
+	u32 hwsch_trigger;
+	u32 ack_tlv_proc;
+	u32 gen_mpdu_cmd;
+	u32 gen_list_cmd;
+	u32 remove_mpdu_cmd;
+	u32 remove_mpdu_tried_cmd;
+	u32 mpdu_queue_stats_cmd;
+	u32 mpdu_head_info_cmd;
+	u32 msdu_flow_stats_cmd;
+	u32 remove_msdu_cmd;
+	u32 remove_msdu_ttl_cmd;
+	u32 flush_cache_cmd;
+	u32 update_mpduq_cmd;
+	u32 enqueue;
+	u32 enqueue_notify;
+	u32 notify_mpdu_at_head;
+	u32 notify_mpdu_state_valid;
+	/*
+	 * On receiving TQM_FLOW_NOT_EMPTY_STATUS from TQM, (on MSDUs being enqueued
+	 * the flow is non empty), if the number of MSDUs is greater than the threshold,
+	 * notify is incremented. UDP_THRESH counters are for UDP MSDUs, and NONUDP are
+	 * for non-UDP MSDUs.
+	 * MSDUQ_SWNOTIFY_UDP_THRESH1 threshold    - sched_udp_notify1 is incremented
+	 * MSDUQ_SWNOTIFY_UDP_THRESH2 threshold    - sched_udp_notify2 is incremented
+	 * MSDUQ_SWNOTIFY_NONUDP_THRESH1 threshold - sched_nonudp_notify1 is incremented
+	 * MSDUQ_SWNOTIFY_NONUDP_THRESH2 threshold - sched_nonudp_notify2 is incremented
+	 *
+	 * Notify signifies that we trigger the scheduler.
+	 */
+	u32 sched_udp_notify1;
+	u32 sched_udp_notify2;
+	u32 sched_nonudp_notify1;
+	u32 sched_nonudp_notify2;
+};
+
+struct htt_tx_tqm_cmn_stats_tlv {
+	u32 mac_id__word;
+	u32 max_cmdq_id;
+	u32 list_mpdu_cnt_hist_intvl;
+
+	/* Global stats */
+	u32 add_msdu;
+	u32 q_empty;
+	u32 q_not_empty;
+	u32 drop_notification;
+	u32 desc_threshold;
+};
+
+struct htt_tx_tqm_error_stats_tlv {
+	/* Error stats */
+	u32 q_empty_failure;
+	u32 q_not_empty_failure;
+	u32 add_msdu_failure;
+};
+
+/* == TQM CMDQ stats == */
+struct htt_tx_tqm_cmdq_status_tlv {
+	u32 mac_id__cmdq_id__word;
+	u32 sync_cmd;
+	u32 write_cmd;
+	u32 gen_mpdu_cmd;
+	u32 mpdu_queue_stats_cmd;
+	u32 mpdu_head_info_cmd;
+	u32 msdu_flow_stats_cmd;
+	u32 remove_mpdu_cmd;
+	u32 remove_msdu_cmd;
+	u32 flush_cache_cmd;
+	u32 update_mpduq_cmd;
+	u32 update_msduq_cmd;
+};
+
+/* == TX-DE STATS == */
+/* Structures for tx de stats */
+struct htt_tx_de_eapol_packets_stats_tlv {
+	u32 m1_packets;
+	u32 m2_packets;
+	u32 m3_packets;
+	u32 m4_packets;
+	u32 g1_packets;
+	u32 g2_packets;
+};
+
+struct htt_tx_de_classify_failed_stats_tlv {
+	u32 ap_bss_peer_not_found;
+	u32 ap_bcast_mcast_no_peer;
+	u32 sta_delete_in_progress;
+	u32 ibss_no_bss_peer;
+	u32 invalid_vdev_type;
+	u32 invalid_ast_peer_entry;
+	u32 peer_entry_invalid;
+	u32 ethertype_not_ip;
+	u32 eapol_lookup_failed;
+	u32 qpeer_not_allow_data;
+	u32 fse_tid_override;
+	u32 ipv6_jumbogram_zero_length;
+	u32 qos_to_non_qos_in_prog;
+};
+
+struct htt_tx_de_classify_stats_tlv {
+	u32 arp_packets;
+	u32 igmp_packets;
+	u32 dhcp_packets;
+	u32 host_inspected;
+	u32 htt_included;
+	u32 htt_valid_mcs;
+	u32 htt_valid_nss;
+	u32 htt_valid_preamble_type;
+	u32 htt_valid_chainmask;
+	u32 htt_valid_guard_interval;
+	u32 htt_valid_retries;
+	u32 htt_valid_bw_info;
+	u32 htt_valid_power;
+	u32 htt_valid_key_flags;
+	u32 htt_valid_no_encryption;
+	u32 fse_entry_count;
+	u32 fse_priority_be;
+	u32 fse_priority_high;
+	u32 fse_priority_low;
+	u32 fse_traffic_ptrn_be;
+	u32 fse_traffic_ptrn_over_sub;
+	u32 fse_traffic_ptrn_bursty;
+	u32 fse_traffic_ptrn_interactive;
+	u32 fse_traffic_ptrn_periodic;
+	u32 fse_hwqueue_alloc;
+	u32 fse_hwqueue_created;
+	u32 fse_hwqueue_send_to_host;
+	u32 mcast_entry;
+	u32 bcast_entry;
+	u32 htt_update_peer_cache;
+	u32 htt_learning_frame;
+	u32 fse_invalid_peer;
+	/*
+	 * mec_notify is HTT TX WBM multicast echo check notification
+	 * from firmware to host.  FW sends SA addresses to host for all
+	 * multicast/broadcast packets received on STA side.
+	 */
+	u32    mec_notify;
+};
+
+struct htt_tx_de_classify_status_stats_tlv {
+	u32 eok;
+	u32 classify_done;
+	u32 lookup_failed;
+	u32 send_host_dhcp;
+	u32 send_host_mcast;
+	u32 send_host_unknown_dest;
+	u32 send_host;
+	u32 status_invalid;
+};
+
+struct htt_tx_de_enqueue_packets_stats_tlv {
+	u32 enqueued_pkts;
+	u32 to_tqm;
+	u32 to_tqm_bypass;
+};
+
+struct htt_tx_de_enqueue_discard_stats_tlv {
+	u32 discarded_pkts;
+	u32 local_frames;
+	u32 is_ext_msdu;
+};
+
+struct htt_tx_de_compl_stats_tlv {
+	u32 tcl_dummy_frame;
+	u32 tqm_dummy_frame;
+	u32 tqm_notify_frame;
+	u32 fw2wbm_enq;
+	u32 tqm_bypass_frame;
+};
+
+/*
+ *  The htt_tx_de_fw2wbm_ring_full_hist_tlv is a histogram of time we waited
+ *  for the fw2wbm ring buffer.  we are requesting a buffer in FW2WBM release
+ *  ring,which may fail, due to non availability of buffer. Hence we sleep for
+ *  200us & again request for it. This is a histogram of time we wait, with
+ *  bin of 200ms & there are 10 bin (2 seconds max)
+ *  They are defined by the following macros in FW
+ *  #define ENTRIES_PER_BIN_COUNT 1000  // per bin 1000 * 200us = 200ms
+ *  #define RING_FULL_BIN_ENTRIES (WAL_TX_DE_FW2WBM_ALLOC_TIMEOUT_COUNT /
+ *                               ENTRIES_PER_BIN_COUNT)
+ */
+struct htt_tx_de_fw2wbm_ring_full_hist_tlv {
+	u32 fw2wbm_ring_full_hist[0];
+};
+
+struct htt_tx_de_cmn_stats_tlv {
+	u32   mac_id__word;
+
+	/* Global Stats */
+	u32   tcl2fw_entry_count;
+	u32   not_to_fw;
+	u32   invalid_pdev_vdev_peer;
+	u32   tcl_res_invalid_addrx;
+	u32   wbm2fw_entry_count;
+	u32   invalid_pdev;
+};
+
+/* == RING-IF STATS == */
+#define HTT_STATS_LOW_WM_BINS      5
+#define HTT_STATS_HIGH_WM_BINS     5
+
+struct htt_ring_if_stats_tlv {
+	u32 base_addr; /* DWORD aligned base memory address of the ring */
+	u32 elem_size;
+	u32 num_elems__prefetch_tail_idx;
+	u32 head_idx__tail_idx;
+	u32 shadow_head_idx__shadow_tail_idx;
+	u32 num_tail_incr;
+	u32 lwm_thresh__hwm_thresh;
+	u32 overrun_hit_count;
+	u32 underrun_hit_count;
+	u32 prod_blockwait_count;
+	u32 cons_blockwait_count;
+	u32 low_wm_hit_count[HTT_STATS_LOW_WM_BINS];
+	u32 high_wm_hit_count[HTT_STATS_HIGH_WM_BINS];
+};
+
+struct htt_ring_if_cmn_tlv {
+	u32 mac_id__word;
+	u32 num_records;
+};
+
+/* == SFM STATS == */
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_sfm_client_user_tlv_v {
+	/* Number of DWORDS used per user and per client */
+	u32 dwords_used_by_user_n[0];
+};
+
+struct htt_sfm_client_tlv {
+	/* Client ID */
+	u32 client_id;
+	/* Minimum number of buffers */
+	u32 buf_min;
+	/* Maximum number of buffers */
+	u32 buf_max;
+	/* Number of Busy buffers */
+	u32 buf_busy;
+	/* Number of Allocated buffers */
+	u32 buf_alloc;
+	/* Number of Available/Usable buffers */
+	u32 buf_avail;
+	/* Number of users */
+	u32 num_users;
+};
+
+struct htt_sfm_cmn_tlv {
+	u32 mac_id__word;
+	/* Indicates the total number of 128 byte buffers
+	 * in the CMEM that are available for buffer sharing
+	 */
+	u32 buf_total;
+	/* Indicates for certain client or all the clients
+	 * there is no dowrd saved in SFM, refer to SFM_R1_MEM_EMPTY
+	 */
+	u32 mem_empty;
+	/* DEALLOCATE_BUFFERS, refer to register SFM_R0_DEALLOCATE_BUFFERS */
+	u32 deallocate_bufs;
+	/* Number of Records */
+	u32 num_records;
+};
+
+/* == SRNG STATS == */
+struct htt_sring_stats_tlv {
+	u32 mac_id__ring_id__arena__ep;
+	u32 base_addr_lsb; /* DWORD aligned base memory address of the ring */
+	u32 base_addr_msb;
+	u32 ring_size;
+	u32 elem_size;
+
+	u32 num_avail_words__num_valid_words;
+	u32 head_ptr__tail_ptr;
+	u32 consumer_empty__producer_full;
+	u32 prefetch_count__internal_tail_ptr;
+};
+
+struct htt_sring_cmn_tlv {
+	u32 num_records;
+};
+
+/* == PDEV TX RATE CTRL STATS == */
+#define HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS        12
+#define HTT_TX_PDEV_STATS_NUM_GI_COUNTERS          4
+#define HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS         5
+#define HTT_TX_PDEV_STATS_NUM_BW_COUNTERS          4
+#define HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS      8
+#define HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
+#define HTT_TX_PDEV_STATS_NUM_LEGACY_CCK_STATS     4
+#define HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS    8
+#define HTT_TX_PDEV_STATS_NUM_LTF                  4
+
+#define HTT_TX_NUM_OF_SOUNDING_STATS_WORDS \
+	(HTT_TX_PDEV_STATS_NUM_BW_COUNTERS * \
+	 HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS)
+
+struct htt_tx_pdev_rate_stats_tlv {
+	u32 mac_id__word;
+	u32 tx_ldpc;
+	u32 rts_cnt;
+	/* RSSI value of last ack packet (units = dB above noise floor) */
+	u32 ack_rssi;
+
+	u32 tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+
+	u32 tx_su_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 tx_mu_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+
+	/* element 0,1, ...7 -> NSS 1,2, ...8 */
+	u32 tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
+	u32 tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	u32 tx_stbc[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 tx_pream[HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES];
+
+	/* Counters to track number of tx packets
+	 * in each GI (400us, 800us, 1600us & 3200us) in each mcs (0-11)
+	 */
+	u32 tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS][HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+
+	/* Counters to track packets in dcm mcs (MCS 0, 1, 3, 4) */
+	u32 tx_dcm[HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS];
+	/* Number of CTS-acknowledged RTS packets */
+	u32 rts_success;
+
+	/*
+	 * Counters for legacy 11a and 11b transmissions.
+	 *
+	 * The index corresponds to:
+	 *
+	 * CCK: 0: 1 Mbps, 1: 2 Mbps, 2: 5.5 Mbps, 3: 11 Mbps
+	 *
+	 * OFDM: 0: 6 Mbps, 1: 9 Mbps, 2: 12 Mbps, 3: 18 Mbps,
+	 *       4: 24 Mbps, 5: 36 Mbps, 6: 48 Mbps, 7: 54 Mbps
+	 */
+	u32 tx_legacy_cck_rate[HTT_TX_PDEV_STATS_NUM_LEGACY_CCK_STATS];
+	u32 tx_legacy_ofdm_rate[HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
+
+	u32 ac_mu_mimo_tx_ldpc;
+	u32 ax_mu_mimo_tx_ldpc;
+	u32 ofdma_tx_ldpc;
+
+	/*
+	 * Counters for 11ax HE LTF selection during TX.
+	 *
+	 * The index corresponds to:
+	 *
+	 * 0: unused, 1: 1x LTF, 2: 2x LTF, 3: 4x LTF
+	 */
+	u32 tx_he_ltf[HTT_TX_PDEV_STATS_NUM_LTF];
+
+	u32 ac_mu_mimo_tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 ax_mu_mimo_tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 ofdma_tx_mcs[HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+
+	u32 ac_mu_mimo_tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	u32 ax_mu_mimo_tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	u32 ofdma_tx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+
+	u32 ac_mu_mimo_tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	u32 ax_mu_mimo_tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	u32 ofdma_tx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+
+	u32 ac_mu_mimo_tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			    [HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 ax_mu_mimo_tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			    [HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 ofdma_tx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+		       [HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+};
+
+/* == PDEV RX RATE CTRL STATS == */
+#define HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS     4
+#define HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS    8
+#define HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS        12
+#define HTT_RX_PDEV_STATS_NUM_GI_COUNTERS          4
+#define HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS         5
+#define HTT_RX_PDEV_STATS_NUM_BW_COUNTERS          4
+#define HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS      8
+#define HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
+#define HTT_RX_PDEV_MAX_OFDMA_NUM_USER             8
+#define HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS 16
+
+struct htt_rx_pdev_rate_stats_tlv {
+	u32 mac_id__word;
+	u32 nsts;
+
+	u32 rx_ldpc;
+	u32 rts_cnt;
+
+	u32 rssi_mgmt; /* units = dB above noise floor */
+	u32 rssi_data; /* units = dB above noise floor */
+	u32 rssi_comb; /* units = dB above noise floor */
+	u32 rx_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	/* element 0,1, ...7 -> NSS 1,2, ...8 */
+	u32 rx_nss[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	u32 rx_dcm[HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS];
+	u32 rx_stbc[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	/* element 0: 20 MHz, 1: 40 MHz, 2: 80 MHz, 3: 160 and 80+80 MHz */
+	u32 rx_bw[HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
+	u32 rx_pream[HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES];
+	u8 rssi_chain[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+		     [HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
+					/* units = dB above noise floor */
+
+	/* Counters to track number of rx packets
+	 * in each GI in each mcs (0-11)
+	 */
+	u32 rx_gi[HTT_RX_PDEV_STATS_NUM_GI_COUNTERS][HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	s32 rssi_in_dbm; /* rx Signal Strength value in dBm unit */
+
+	u32 rx_11ax_su_ext;
+	u32 rx_11ac_mumimo;
+	u32 rx_11ax_mumimo;
+	u32 rx_11ax_ofdma;
+	u32 txbf;
+	u32 rx_legacy_cck_rate[HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS];
+	u32 rx_legacy_ofdm_rate[HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
+	u32 rx_active_dur_us_low;
+	u32 rx_active_dur_us_high;
+
+	u32 rx_11ax_ul_ofdma;
+
+	u32 ul_ofdma_rx_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 ul_ofdma_rx_gi[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			  [HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	u32 ul_ofdma_rx_nss[HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	u32 ul_ofdma_rx_bw[HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	u32 ul_ofdma_rx_stbc;
+	u32 ul_ofdma_rx_ldpc;
+
+	/* record the stats for each user index */
+	u32 rx_ulofdma_non_data_ppdu[HTT_RX_PDEV_MAX_OFDMA_NUM_USER]; /* ppdu level */
+	u32 rx_ulofdma_data_ppdu[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];     /* ppdu level */
+	u32 rx_ulofdma_mpdu_ok[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];       /* mpdu level */
+	u32 rx_ulofdma_mpdu_fail[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];     /* mpdu level */
+
+	u32 nss_count;
+	u32 pilot_count;
+	/* RxEVM stats in dB */
+	s32 rx_pilot_evm_db[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+			   [HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS];
+	/* rx_pilot_evm_db_mean:
+	 * EVM mean across pilots, computed as
+	 *     mean(10*log10(rx_pilot_evm_linear)) = mean(rx_pilot_evm_db)
+	 */
+	s32 rx_pilot_evm_db_mean[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	s8 rx_ul_fd_rssi[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+			[HTT_RX_PDEV_MAX_OFDMA_NUM_USER]; /* dBm units */
+	/* per_chain_rssi_pkt_type:
+	 * This field shows what type of rx frame the per-chain RSSI was computed
+	 * on, by recording the frame type and sub-type as bit-fields within this
+	 * field:
+	 * BIT [3 : 0]    :- IEEE80211_FC0_TYPE
+	 * BIT [7 : 4]    :- IEEE80211_FC0_SUBTYPE
+	 * BIT [31 : 8]   :- Reserved
+	 */
+	u32 per_chain_rssi_pkt_type;
+	s8 rx_per_chain_rssi_in_dbm[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+				   [HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
+};
+
+/* == RX PDEV/SOC STATS == */
+struct htt_rx_soc_fw_stats_tlv {
+	u32 fw_reo_ring_data_msdu;
+	u32 fw_to_host_data_msdu_bcmc;
+	u32 fw_to_host_data_msdu_uc;
+	u32 ofld_remote_data_buf_recycle_cnt;
+	u32 ofld_remote_free_buf_indication_cnt;
+
+	u32 ofld_buf_to_host_data_msdu_uc;
+	u32 reo_fw_ring_to_host_data_msdu_uc;
+
+	u32 wbm_sw_ring_reap;
+	u32 wbm_forward_to_host_cnt;
+	u32 wbm_target_recycle_cnt;
+
+	u32 target_refill_ring_recycle_cnt;
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_rx_soc_fw_refill_ring_empty_tlv_v {
+	u32 refill_ring_empty_cnt[0]; /* HTT_RX_STATS_REFILL_MAX_RING */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_rx_soc_fw_refill_ring_num_refill_tlv_v {
+	u32 refill_ring_num_refill[0]; /* HTT_RX_STATS_REFILL_MAX_RING */
+};
+
+/* RXDMA error code from WBM released packets */
+enum htt_rx_rxdma_error_code_enum {
+	HTT_RX_RXDMA_OVERFLOW_ERR                           = 0,
+	HTT_RX_RXDMA_MPDU_LENGTH_ERR                        = 1,
+	HTT_RX_RXDMA_FCS_ERR                                = 2,
+	HTT_RX_RXDMA_DECRYPT_ERR                            = 3,
+	HTT_RX_RXDMA_TKIP_MIC_ERR                           = 4,
+	HTT_RX_RXDMA_UNECRYPTED_ERR                         = 5,
+	HTT_RX_RXDMA_MSDU_LEN_ERR                           = 6,
+	HTT_RX_RXDMA_MSDU_LIMIT_ERR                         = 7,
+	HTT_RX_RXDMA_WIFI_PARSE_ERR                         = 8,
+	HTT_RX_RXDMA_AMSDU_PARSE_ERR                        = 9,
+	HTT_RX_RXDMA_SA_TIMEOUT_ERR                         = 10,
+	HTT_RX_RXDMA_DA_TIMEOUT_ERR                         = 11,
+	HTT_RX_RXDMA_FLOW_TIMEOUT_ERR                       = 12,
+	HTT_RX_RXDMA_FLUSH_REQUEST                          = 13,
+	HTT_RX_RXDMA_ERR_CODE_RVSD0                         = 14,
+	HTT_RX_RXDMA_ERR_CODE_RVSD1                         = 15,
+
+	/* This MAX_ERR_CODE should not be used in any host/target messages,
+	 * so that even though it is defined within a host/target interface
+	 * definition header file, it isn't actually part of the host/target
+	 * interface, and thus can be modified.
+	 */
+	HTT_RX_RXDMA_MAX_ERR_CODE
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v {
+	u32 rxdma_err[0]; /* HTT_RX_RXDMA_MAX_ERR_CODE */
+};
+
+/* REO error code from WBM released packets */
+enum htt_rx_reo_error_code_enum {
+	HTT_RX_REO_QUEUE_DESC_ADDR_ZERO                     = 0,
+	HTT_RX_REO_QUEUE_DESC_NOT_VALID                     = 1,
+	HTT_RX_AMPDU_IN_NON_BA                              = 2,
+	HTT_RX_NON_BA_DUPLICATE                             = 3,
+	HTT_RX_BA_DUPLICATE                                 = 4,
+	HTT_RX_REGULAR_FRAME_2K_JUMP                        = 5,
+	HTT_RX_BAR_FRAME_2K_JUMP                            = 6,
+	HTT_RX_REGULAR_FRAME_OOR                            = 7,
+	HTT_RX_BAR_FRAME_OOR                                = 8,
+	HTT_RX_BAR_FRAME_NO_BA_SESSION                      = 9,
+	HTT_RX_BAR_FRAME_SN_EQUALS_SSN                      = 10,
+	HTT_RX_PN_CHECK_FAILED                              = 11,
+	HTT_RX_2K_ERROR_HANDLING_FLAG_SET                   = 12,
+	HTT_RX_PN_ERROR_HANDLING_FLAG_SET                   = 13,
+	HTT_RX_QUEUE_DESCRIPTOR_BLOCKED_SET                 = 14,
+	HTT_RX_REO_ERR_CODE_RVSD                            = 15,
+
+	/* This MAX_ERR_CODE should not be used in any host/target messages,
+	 * so that even though it is defined within a host/target interface
+	 * definition header file, it isn't actually part of the host/target
+	 * interface, and thus can be modified.
+	 */
+	HTT_RX_REO_MAX_ERR_CODE
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_rx_soc_fw_refill_ring_num_reo_err_tlv_v {
+	u32 reo_err[0]; /* HTT_RX_REO_MAX_ERR_CODE */
+};
+
+/* == RX PDEV STATS == */
+#define HTT_STATS_SUBTYPE_MAX     16
+
+struct htt_rx_pdev_fw_stats_tlv {
+	u32 mac_id__word;
+	u32 ppdu_recvd;
+	u32 mpdu_cnt_fcs_ok;
+	u32 mpdu_cnt_fcs_err;
+	u32 tcp_msdu_cnt;
+	u32 tcp_ack_msdu_cnt;
+	u32 udp_msdu_cnt;
+	u32 other_msdu_cnt;
+	u32 fw_ring_mpdu_ind;
+	u32 fw_ring_mgmt_subtype[HTT_STATS_SUBTYPE_MAX];
+	u32 fw_ring_ctrl_subtype[HTT_STATS_SUBTYPE_MAX];
+	u32 fw_ring_mcast_data_msdu;
+	u32 fw_ring_bcast_data_msdu;
+	u32 fw_ring_ucast_data_msdu;
+	u32 fw_ring_null_data_msdu;
+	u32 fw_ring_mpdu_drop;
+	u32 ofld_local_data_ind_cnt;
+	u32 ofld_local_data_buf_recycle_cnt;
+	u32 drx_local_data_ind_cnt;
+	u32 drx_local_data_buf_recycle_cnt;
+	u32 local_nondata_ind_cnt;
+	u32 local_nondata_buf_recycle_cnt;
+
+	u32 fw_status_buf_ring_refill_cnt;
+	u32 fw_status_buf_ring_empty_cnt;
+	u32 fw_pkt_buf_ring_refill_cnt;
+	u32 fw_pkt_buf_ring_empty_cnt;
+	u32 fw_link_buf_ring_refill_cnt;
+	u32 fw_link_buf_ring_empty_cnt;
+
+	u32 host_pkt_buf_ring_refill_cnt;
+	u32 host_pkt_buf_ring_empty_cnt;
+	u32 mon_pkt_buf_ring_refill_cnt;
+	u32 mon_pkt_buf_ring_empty_cnt;
+	u32 mon_status_buf_ring_refill_cnt;
+	u32 mon_status_buf_ring_empty_cnt;
+	u32 mon_desc_buf_ring_refill_cnt;
+	u32 mon_desc_buf_ring_empty_cnt;
+	u32 mon_dest_ring_update_cnt;
+	u32 mon_dest_ring_full_cnt;
+
+	u32 rx_suspend_cnt;
+	u32 rx_suspend_fail_cnt;
+	u32 rx_resume_cnt;
+	u32 rx_resume_fail_cnt;
+	u32 rx_ring_switch_cnt;
+	u32 rx_ring_restore_cnt;
+	u32 rx_flush_cnt;
+	u32 rx_recovery_reset_cnt;
+};
+
+#define HTT_STATS_PHY_ERR_MAX 43
+
+struct htt_rx_pdev_fw_stats_phy_err_tlv {
+	u32 mac_id__word;
+	u32 total_phy_err_cnt;
+	/* Counts of different types of phy errs
+	 * The mapping of PHY error types to phy_err array elements is HW dependent.
+	 * The only currently-supported mapping is shown below:
+	 *
+	 * 0 phyrx_err_phy_off Reception aborted due to receiving a PHY_OFF TLV
+	 * 1 phyrx_err_synth_off
+	 * 2 phyrx_err_ofdma_timing
+	 * 3 phyrx_err_ofdma_signal_parity
+	 * 4 phyrx_err_ofdma_rate_illegal
+	 * 5 phyrx_err_ofdma_length_illegal
+	 * 6 phyrx_err_ofdma_restart
+	 * 7 phyrx_err_ofdma_service
+	 * 8 phyrx_err_ppdu_ofdma_power_drop
+	 * 9 phyrx_err_cck_blokker
+	 * 10 phyrx_err_cck_timing
+	 * 11 phyrx_err_cck_header_crc
+	 * 12 phyrx_err_cck_rate_illegal
+	 * 13 phyrx_err_cck_length_illegal
+	 * 14 phyrx_err_cck_restart
+	 * 15 phyrx_err_cck_service
+	 * 16 phyrx_err_cck_power_drop
+	 * 17 phyrx_err_ht_crc_err
+	 * 18 phyrx_err_ht_length_illegal
+	 * 19 phyrx_err_ht_rate_illegal
+	 * 20 phyrx_err_ht_zlf
+	 * 21 phyrx_err_false_radar_ext
+	 * 22 phyrx_err_green_field
+	 * 23 phyrx_err_bw_gt_dyn_bw
+	 * 24 phyrx_err_leg_ht_mismatch
+	 * 25 phyrx_err_vht_crc_error
+	 * 26 phyrx_err_vht_siga_unsupported
+	 * 27 phyrx_err_vht_lsig_len_invalid
+	 * 28 phyrx_err_vht_ndp_or_zlf
+	 * 29 phyrx_err_vht_nsym_lt_zero
+	 * 30 phyrx_err_vht_rx_extra_symbol_mismatch
+	 * 31 phyrx_err_vht_rx_skip_group_id0
+	 * 32 phyrx_err_vht_rx_skip_group_id1to62
+	 * 33 phyrx_err_vht_rx_skip_group_id63
+	 * 34 phyrx_err_ofdm_ldpc_decoder_disabled
+	 * 35 phyrx_err_defer_nap
+	 * 36 phyrx_err_fdomain_timeout
+	 * 37 phyrx_err_lsig_rel_check
+	 * 38 phyrx_err_bt_collision
+	 * 39 phyrx_err_unsupported_mu_feedback
+	 * 40 phyrx_err_ppdu_tx_interrupt_rx
+	 * 41 phyrx_err_unsupported_cbf
+	 * 42 phyrx_err_other
+	 */
+	u32 phy_err[HTT_STATS_PHY_ERR_MAX];
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_rx_pdev_fw_ring_mpdu_err_tlv_v {
+	/* Num error MPDU for each RxDMA error type  */
+	u32 fw_ring_mpdu_err[0]; /* HTT_RX_STATS_RXDMA_MAX_ERR */
+};
+
+/* NOTE: Variable length TLV, use length spec to infer array size */
+struct htt_rx_pdev_fw_mpdu_drop_tlv_v {
+	/* Num MPDU dropped  */
+	u32 fw_mpdu_drop[0]; /* HTT_RX_STATS_FW_DROP_REASON_MAX */
+};
+
+#define HTT_PDEV_CCA_STATS_TX_FRAME_INFO_PRESENT               (0x1)
+#define HTT_PDEV_CCA_STATS_RX_FRAME_INFO_PRESENT               (0x2)
+#define HTT_PDEV_CCA_STATS_RX_CLEAR_INFO_PRESENT               (0x4)
+#define HTT_PDEV_CCA_STATS_MY_RX_FRAME_INFO_PRESENT            (0x8)
+#define HTT_PDEV_CCA_STATS_USEC_CNT_INFO_PRESENT              (0x10)
+#define HTT_PDEV_CCA_STATS_MED_RX_IDLE_INFO_PRESENT           (0x20)
+#define HTT_PDEV_CCA_STATS_MED_TX_IDLE_GLOBAL_INFO_PRESENT    (0x40)
+#define HTT_PDEV_CCA_STATS_CCA_OBBS_USEC_INFO_PRESENT         (0x80)
+
+struct htt_pdev_stats_cca_counters_tlv {
+	/* Below values are obtained from the HW Cycles counter registers */
+	u32 tx_frame_usec;
+	u32 rx_frame_usec;
+	u32 rx_clear_usec;
+	u32 my_rx_frame_usec;
+	u32 usec_cnt;
+	u32 med_rx_idle_usec;
+	u32 med_tx_idle_global_usec;
+	u32 cca_obss_usec;
+};
+
+struct htt_pdev_cca_stats_hist_v1_tlv {
+	u32    chan_num;
+	/* num of CCA records (Num of htt_pdev_stats_cca_counters_tlv)*/
+	u32    num_records;
+	u32    valid_cca_counters_bitmap;
+	u32    collection_interval;
+
+	/* This will be followed by an array which contains the CCA stats
+	 * collected in the last N intervals,
+	 * if the indication is for last N intervals CCA stats.
+	 * Then the pdev_cca_stats[0] element contains the oldest CCA stats
+	 * and pdev_cca_stats[N-1] will have the most recent CCA stats.
+	 * htt_pdev_stats_cca_counters_tlv cca_hist_tlv[1];
+	 */
+};
+
+struct htt_pdev_stats_twt_session_tlv {
+	u32 vdev_id;
+	struct htt_mac_addr peer_mac;
+	u32 flow_id_flags;
+
+	/* TWT_DIALOG_ID_UNAVAILABLE is used
+	 * when TWT session is not initiated by host
+	 */
+	u32 dialog_id;
+	u32 wake_dura_us;
+	u32 wake_intvl_us;
+	u32 sp_offset_us;
+};
+
+struct htt_pdev_stats_twt_sessions_tlv {
+	u32 pdev_id;
+	u32 num_sessions;
+	struct htt_pdev_stats_twt_session_tlv twt_session[];
+};
+
+enum htt_rx_reo_resource_sample_id_enum {
+	/* Global link descriptor queued in REO */
+	HTT_RX_REO_RESOURCE_GLOBAL_LINK_DESC_COUNT_0           = 0,
+	HTT_RX_REO_RESOURCE_GLOBAL_LINK_DESC_COUNT_1           = 1,
+	HTT_RX_REO_RESOURCE_GLOBAL_LINK_DESC_COUNT_2           = 2,
+	/*Number of queue descriptors of this aging group */
+	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC0                   = 3,
+	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC1                   = 4,
+	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC2                   = 5,
+	HTT_RX_REO_RESOURCE_BUFFERS_USED_AC3                   = 6,
+	/* Total number of MSDUs buffered in AC */
+	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC0               = 7,
+	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC1               = 8,
+	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC2               = 9,
+	HTT_RX_REO_RESOURCE_AGING_NUM_QUEUES_AC3               = 10,
+
+	HTT_RX_REO_RESOURCE_STATS_MAX                          = 16
+};
+
+struct htt_rx_reo_resource_stats_tlv_v {
+	/* Variable based on the Number of records. HTT_RX_REO_RESOURCE_STATS_MAX */
+	u32 sample_id;
+	u32 total_max;
+	u32 total_avg;
+	u32 total_sample;
+	u32 non_zeros_avg;
+	u32 non_zeros_sample;
+	u32 last_non_zeros_max;
+	u32 last_non_zeros_min;
+	u32 last_non_zeros_avg;
+	u32 last_non_zeros_sample;
+};
+
+/* == TX SOUNDING STATS == */
+
+enum htt_txbf_sound_steer_modes {
+	HTT_IMPLICIT_TXBF_STEER_STATS                = 0,
+	HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS        = 1,
+	HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS         = 2,
+	HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS        = 3,
+	HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS         = 4,
+	HTT_TXBF_MAX_NUM_OF_MODES                    = 5
+};
+
+enum htt_stats_sounding_tx_mode {
+	HTT_TX_AC_SOUNDING_MODE                      = 0,
+	HTT_TX_AX_SOUNDING_MODE                      = 1,
+};
+
+struct htt_tx_sounding_stats_tlv {
+	u32 tx_sounding_mode; /* HTT_TX_XX_SOUNDING_MODE */
+	/* Counts number of soundings for all steering modes in each bw */
+	u32 cbf_20[HTT_TXBF_MAX_NUM_OF_MODES];
+	u32 cbf_40[HTT_TXBF_MAX_NUM_OF_MODES];
+	u32 cbf_80[HTT_TXBF_MAX_NUM_OF_MODES];
+	u32 cbf_160[HTT_TXBF_MAX_NUM_OF_MODES];
+	/*
+	 * The sounding array is a 2-D array stored as an 1-D array of
+	 * u32. The stats for a particular user/bw combination is
+	 * referenced with the following:
+	 *
+	 *          sounding[(user* max_bw) + bw]
+	 *
+	 * ... where max_bw == 4 for 160mhz
+	 */
+	u32 sounding[HTT_TX_NUM_OF_SOUNDING_STATS_WORDS];
+};
+
+struct htt_pdev_obss_pd_stats_tlv {
+	u32        num_obss_tx_ppdu_success;
+	u32        num_obss_tx_ppdu_failure;
+};
+
+void ath11k_debugfs_htt_stats_init(struct ath11k *ar);
+
+struct htt_ring_backpressure_stats_tlv {
+	u32 pdev_id;
+	u32 current_head_idx;
+	u32 current_tail_idx;
+	u32 num_htt_msgs_sent;
+	/* Time in milliseconds for which the ring has been in
+	 * its current backpressure condition
+	 */
+	u32 backpressure_time_ms;
+	/* backpressure_hist - histogram showing how many times
+	 * different degrees of backpressure duration occurred:
+	 * Index 0 indicates the number of times ring was
+	 * continuously in backpressure state for 100 - 200ms.
+	 * Index 1 indicates the number of times ring was
+	 * continuously in backpressure state for 200 - 300ms.
+	 * Index 2 indicates the number of times ring was
+	 * continuously in backpressure state for 300 - 400ms.
+	 * Index 3 indicates the number of times ring was
+	 * continuously in backpressure state for 400 - 500ms.
+	 * Index 4 indicates the number of times ring was
+	 * continuously in backpressure state beyond 500ms.
+	 */
+	u32 backpressure_hist[5];
+};
+
+#endif
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index d189cc80805a..14f2e904a89d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -9,7 +9,7 @@
 #include "peer.h"
 #include "debug.h"
 #include "dp_tx.h"
-#include "debug_htt_stats.h"
+#include "debugfs_htt_stats.h"
 
 void
 ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
-- 
2.7.4

