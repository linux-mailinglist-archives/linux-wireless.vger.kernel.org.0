Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604AD46E557
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhLIJT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 04:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhLIJT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 04:19:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB2C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 01:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 706A2B81FA7
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 09:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E374C004DD;
        Thu,  9 Dec 2021 09:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639041352;
        bh=FEimqqnZesa480TVcNbq0cAFDsG+3iH7UdvocRivT3E=;
        h=From:To:Cc:Subject:Date:From;
        b=lKL+oGxvd0DhROw0gW94CZtJs4oKkPNyZeEKn25EjiJW1CoLWGHOePQxiQGIZyPI+
         KpRJbxk3nwH6ijv8ypGxAU8axf/Z+w6lBRVYIgGgn0Af/I89aJyZiD4ckRM6gZvhGi
         eVc4WOVVW2E/3d6HDgtoftJ3RatgkOYnpOOb5Riux0Rb2mSU+BQVKAGeAidvRlAm2m
         H67Lkh+abOF/3ReBzrY5nrXHf4msOYvWHtc1Ul4J4CQpPRijgGV7Tq6GcUnd3EPgbR
         gGIbOz9ZOoL849xFplr7jgeknd6m/DLi76AuZhaGpqhNZJyc2tWB3VGgHvGEsxrj4a
         G8oSdGUk+Jhvg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] ath10k: htt: remove array of flexible structures
Date:   Thu,  9 Dec 2021 11:15:44 +0200
Message-Id: <20211209091545.6098-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

I updated to sparse v0.6.4 and it warns:

drivers/net/wireless/ath/ath10k/hw.c: note: in included file (through drivers/net/wireless/ath/ath10k/core.h):
drivers/net/wireless/ath/ath10k/htt.h:1503:41: warning: array of flexible structures
drivers/net/wireless/ath/ath10k/htt_rx.c: note: in included file (through drivers/net/wireless/ath/ath10k/core.h):
drivers/net/wireless/ath/ath10k/htt.h:1503:41: warning: array of flexible structures

The structure is unused in ath10k so let's just remove it.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/htt.h | 110 --------------------------
 1 file changed, 110 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index a6de08d3bf4a..9a3a8907389b 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -1400,115 +1400,6 @@ enum htt_dbg_stats_status {
 	HTT_DBG_STATS_STATUS_SERIES_DONE = 7
 };
 
-/*
- * target -> host statistics upload
- *
- * The following field definitions describe the format of the HTT target
- * to host stats upload confirmation message.
- * The message contains a cookie echoed from the HTT host->target stats
- * upload request, which identifies which request the confirmation is
- * for, and a series of tag-length-value stats information elements.
- * The tag-length header for each stats info element also includes a
- * status field, to indicate whether the request for the stat type in
- * question was fully met, partially met, unable to be met, or invalid
- * (if the stat type in question is disabled in the target).
- * A special value of all 1's in this status field is used to indicate
- * the end of the series of stats info elements.
- *
- *
- * |31                         16|15           8|7   5|4       0|
- * |------------------------------------------------------------|
- * |                  reserved                  |    msg type   |
- * |------------------------------------------------------------|
- * |                        cookie LSBs                         |
- * |------------------------------------------------------------|
- * |                        cookie MSBs                         |
- * |------------------------------------------------------------|
- * |      stats entry length     |   reserved   |  S  |stat type|
- * |------------------------------------------------------------|
- * |                                                            |
- * |                  type-specific stats info                  |
- * |                                                            |
- * |------------------------------------------------------------|
- * |      stats entry length     |   reserved   |  S  |stat type|
- * |------------------------------------------------------------|
- * |                                                            |
- * |                  type-specific stats info                  |
- * |                                                            |
- * |------------------------------------------------------------|
- * |              n/a            |   reserved   | 111 |   n/a   |
- * |------------------------------------------------------------|
- * Header fields:
- *  - MSG_TYPE
- *    Bits 7:0
- *    Purpose: identifies this is a statistics upload confirmation message
- *    Value: 0x9
- *  - COOKIE_LSBS
- *    Bits 31:0
- *    Purpose: Provide a mechanism to match a target->host stats confirmation
- *        message with its preceding host->target stats request message.
- *    Value: LSBs of the opaque cookie specified by the host-side requestor
- *  - COOKIE_MSBS
- *    Bits 31:0
- *    Purpose: Provide a mechanism to match a target->host stats confirmation
- *        message with its preceding host->target stats request message.
- *    Value: MSBs of the opaque cookie specified by the host-side requestor
- *
- * Stats Information Element tag-length header fields:
- *  - STAT_TYPE
- *    Bits 4:0
- *    Purpose: identifies the type of statistics info held in the
- *        following information element
- *    Value: htt_dbg_stats_type
- *  - STATUS
- *    Bits 7:5
- *    Purpose: indicate whether the requested stats are present
- *    Value: htt_dbg_stats_status, including a special value (0x7) to mark
- *        the completion of the stats entry series
- *  - LENGTH
- *    Bits 31:16
- *    Purpose: indicate the stats information size
- *    Value: This field specifies the number of bytes of stats information
- *       that follows the element tag-length header.
- *       It is expected but not required that this length is a multiple of
- *       4 bytes.  Even if the length is not an integer multiple of 4, the
- *       subsequent stats entry header will begin on a 4-byte aligned
- *       boundary.
- */
-
-#define HTT_STATS_CONF_ITEM_INFO_STAT_TYPE_MASK 0x1F
-#define HTT_STATS_CONF_ITEM_INFO_STAT_TYPE_LSB  0
-#define HTT_STATS_CONF_ITEM_INFO_STATUS_MASK    0xE0
-#define HTT_STATS_CONF_ITEM_INFO_STATUS_LSB     5
-
-struct htt_stats_conf_item {
-	union {
-		u8 info;
-		struct {
-			u8 stat_type:5; /* %HTT_DBG_STATS_ */
-			u8 status:3; /* %HTT_DBG_STATS_STATUS_ */
-		} __packed;
-	} __packed;
-	u8 pad;
-	__le16 length;
-	u8 payload[]; /* roundup(length, 4) long */
-} __packed;
-
-struct htt_stats_conf {
-	u8 pad[3];
-	__le32 cookie_lsb;
-	__le32 cookie_msb;
-
-	/* each item has variable length! */
-	struct htt_stats_conf_item items[];
-} __packed;
-
-static inline struct htt_stats_conf_item *htt_stats_conf_next_item(
-					const struct htt_stats_conf_item *item)
-{
-	return (void *)item + sizeof(*item) + roundup(item->length, 4);
-}
-
 /*
  * host -> target FRAG DESCRIPTOR/MSDU_EXT DESC bank
  *
@@ -1828,7 +1719,6 @@ struct htt_resp {
 		struct htt_rc_update rc_update;
 		struct htt_rx_test rx_test;
 		struct htt_pktlog_msg pktlog_msg;
-		struct htt_stats_conf stats_conf;
 		struct htt_rx_pn_ind rx_pn_ind;
 		struct htt_rx_offload_ind rx_offload_ind;
 		struct htt_rx_in_ord_ind rx_in_ord_ind;
-- 
2.20.1

