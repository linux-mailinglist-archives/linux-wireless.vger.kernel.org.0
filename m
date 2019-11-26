Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D5109BB7
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKZKGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 05:06:04 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:42836
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727482AbfKZKGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 05:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574762763;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=yTiK9glvulsqITImJlWDAB4xSvy0kI5KM/v2o3aPCmA=;
        b=ikr0bK8eBqrkla1NkWZelD10f3DkKUyCwEXsq34mN/81b5NDB8du3/c43BkjofEB
        P1tz+eI4Hz7n5nDg9ySA/6WNVo7lKEKIZnfVOgUOoIKkWQzOmxj5pbIGucw4v1EvB2F
        CsuRtjqoC0lF8elt9F0fExryXeOvoLo58616c3oI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574762763;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=yTiK9glvulsqITImJlWDAB4xSvy0kI5KM/v2o3aPCmA=;
        b=NH3T3lB+KBXKk8FJmhwNkV2QQjhQWhSjvr/aXXMFOurKKyJqEcnuyAh23qnHnNuc
        x/BzJZ+AMNq06dZnA/aQWv5tg06QPAgTQB8oLiu93tcjDRr5ZLC57w5KS9gadLeO/Fa
        K3rBYlZOU/TDP+eZUT6r8TDtpqWvH+PaBknNroVI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9C67C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: change bundle count for max rx bundle for sdio
Date:   Tue, 26 Nov 2019 10:06:03 +0000
Message-ID: <0101016ea72cd3fc-d998517d-4033-4659-b1f8-2b6dd2717682-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.26-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For max bundle size 32, the bundle mask is not same with 8/16.
Change it to match the max bundle size of htc. Otherwise it
will not match with firmware, for example, when bundle count
is 17, then flags of ath10k_htc_hdr is 0x4, if without this
patch, it will be considered as non-bundled packet because it
does not have mask 0xF0, then trigger error message later:
payload length 56747 exceeds max htc length: 4088.

htc->max_msgs_per_htc_bundle is the min value of
HTC_HOST_MAX_MSG_PER_RX_BUNDLE and
msg->ready_ext.max_msgs_per_htc_bundle of ath10k_htc_wait_target,
it will be sent to firmware later in ath10k_htc_start, then
firmware will use it as the final max rx bundle count, in
WLAN.RMH.4.4.1-00029, msg->ready_ext.max_msgs_per_htc_bundle
is 32, it is same with HTC_HOST_MAX_MSG_PER_RX_BUNDLE, so the
final max rx bundle count will be set to 32 in firmware.

This patch only effect sdio chips.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Fixes: 224776520ead69e ("ath10k: change max RX bundle size from 8 to 32 for sdio")
---
 drivers/net/wireless/ath/ath10k/htc.c  |  2 +-
 drivers/net/wireless/ath/ath10k/htc.h  | 10 ++++++----
 drivers/net/wireless/ath/ath10k/sdio.c | 10 ++++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 03c358cd16d4..4696d4ab5f6c 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -311,7 +311,7 @@ ath10k_htc_process_lookahead_bundle(struct ath10k_htc *htc,
 	struct ath10k *ar = htc->ar;
 	int bundle_cnt = len / sizeof(*report);
 
-	if (!bundle_cnt || (bundle_cnt > HTC_HOST_MAX_MSG_PER_RX_BUNDLE)) {
+	if (!bundle_cnt || (bundle_cnt > htc->max_msgs_per_htc_bundle)) {
 		ath10k_warn(ar, "Invalid lookahead bundle count: %d\n",
 			    bundle_cnt);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index b3f48fe7436e..0d25d2150ea5 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -58,13 +58,15 @@ enum ath10k_htc_rx_flags {
 #define ATH10K_HTC_BUNDLE_EXTRA_MASK GENMASK(3, 2)
 #define ATH10K_HTC_BUNDLE_EXTRA_SHIFT 4
 
-static inline unsigned int ath10k_htc_get_bundle_count(u8 flags)
+static inline unsigned int ath10k_htc_get_bundle_count(u8 max_msgs, u8 flags)
 {
-	unsigned int count, extra_count;
+	unsigned int count, extra_count = 0;
 
 	count = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, flags);
-	extra_count = FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, flags) <<
-		ATH10K_HTC_BUNDLE_EXTRA_SHIFT;
+
+	if (max_msgs > 16)
+		extra_count = FIELD_GET(ATH10K_HTC_BUNDLE_EXTRA_MASK, flags) <<
+			ATH10K_HTC_BUNDLE_EXTRA_SHIFT;
 
 	return count + extra_count;
 }
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 60849ab8088f..987d7c3eb32a 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -500,14 +500,15 @@ static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
 					 size_t *bndl_cnt)
 {
 	int ret, i;
+	u8 max_msgs = ar->htc.max_msgs_per_htc_bundle;
 
-	*bndl_cnt = ath10k_htc_get_bundle_count(htc_hdr->flags);
+	*bndl_cnt = ath10k_htc_get_bundle_count(max_msgs, htc_hdr->flags);
 
-	if (*bndl_cnt > HTC_HOST_MAX_MSG_PER_RX_BUNDLE) {
+	if (*bndl_cnt > max_msgs) {
 		ath10k_warn(ar,
 			    "HTC bundle length %u exceeds maximum %u\n",
 			    le16_to_cpu(htc_hdr->len),
-			    HTC_HOST_MAX_MSG_PER_RX_BUNDLE);
+			    max_msgs);
 		return -ENOMEM;
 	}
 
@@ -570,7 +571,8 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 			goto err;
 		}
 
-		if (htc_hdr->flags & ATH10K_HTC_FLAG_BUNDLE_MASK) {
+		if (ath10k_htc_get_bundle_count(
+			ar->htc.max_msgs_per_htc_bundle, htc_hdr->flags)) {
 			/* HTC header indicates that every packet to follow
 			 * has the same padded length so that it can be
 			 * optimally fetched as a full bundle.
-- 
2.23.0

