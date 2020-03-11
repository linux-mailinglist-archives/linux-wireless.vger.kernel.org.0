Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C521813A1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgCKIrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:47:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgCKIrU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 751C7ADDA;
        Wed, 11 Mar 2020 08:47:18 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org
Subject: [PATCH 1/7] ath11k: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:47:07 +0100
Message-Id: <20200311084713.18220-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311084713.18220-1-tiwai@suse.de>
References: <20200311084713.18220-1-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: ath11k@lists.infradead.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/ath/ath11k/debug_htt_stats.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
index 9939e909628f..f44dec839e70 100644
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
@@ -22,7 +22,7 @@
 	do {										\
 		int index = 0; u8 i;							\
 		for (i = 0; i < len; i++) {						\
-			index += snprintf(out + index, HTT_MAX_STRING_LEN - index,	\
+			index += scnprintf(out + index, HTT_MAX_STRING_LEN - index,	\
 					  " %u:%u,", i, arr[i]);			\
 			if (index < 0 || index >= HTT_MAX_STRING_LEN)			\
 				break;							\
@@ -46,7 +46,7 @@ static inline void htt_print_stats_string_tlv(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:");
 
 	for (i = 0; i < tag_len; i++) {
-		index += snprintf(&data[index],
+		index += scnprintf(&data[index],
 				HTT_MAX_STRING_LEN - index,
 				"%.*s", 4, (char *)&(htt_stats_buf->data[i]));
 		if (index >= HTT_MAX_STRING_LEN)
@@ -3097,7 +3097,7 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 		index = 0;
 
 		for (i = 0; i < HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS; i++)
-			index += snprintf(&rx_pilot_evm_db[j][index],
+			index += scnprintf(&rx_pilot_evm_db[j][index],
 					  HTT_MAX_STRING_LEN - index,
 					  " %u:%d,",
 					  i,
@@ -3109,7 +3109,7 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	index = 0;
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
-		index += snprintf(&str_buf[index],
+		index += scnprintf(&str_buf[index],
 				  HTT_MAX_STRING_LEN - index,
 				  " %u:%d,", i, htt_stats_buf->rx_pilot_evm_db_mean[i]);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB_mean = %s ", str_buf);
@@ -3217,7 +3217,7 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 		index = 0;
 		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 		for (i = 0; i < HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
-			index += snprintf(&str_buf[index],
+			index += scnprintf(&str_buf[index],
 					  HTT_MAX_STRING_LEN - index,
 					  " %u:%d,",
 					  i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
@@ -3232,7 +3232,7 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 		index = 0;
 		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
-			index += snprintf(&str_buf[index],
+			index += scnprintf(&str_buf[index],
 					  HTT_MAX_STRING_LEN - index,
 					  " %u:%d,",
 					  i,
-- 
2.16.4

