Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE02299F2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jul 2020 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgGVOU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jul 2020 10:20:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:21898 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731084AbgGVOU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jul 2020 10:20:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595427656; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8rvyiAILmpkXTt2FiIDAvNes+wck1u8Fy2xyz3Iah9E=; b=XDW+/da3Tu4v0u+2kZEhAxHtbp/t/IPbQy1eAkzat7nVs6cnNHbXI1L+36fg/VlowRYJSFW2
 WI9XrsHI/Atr2pzsuqMw1tzKmDulsrciLKeU1FCQ+1hKFB4Z80Zyhwd8H1L333QzBxnlC/RW
 PMzOKaTzSBmgf1ucMX/ThHmbcWA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f184b2be32d449b31b775e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 14:20:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FFD6C433C6; Wed, 22 Jul 2020 14:20:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTEX0180100-LIN.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vthiagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82F38C433CA;
        Wed, 22 Jul 2020 14:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82F38C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vthiagar@codeaurora.org
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Subject: [PATCH] mac80211: Fix bug in Tx ack status reporting in 802.3 xmit path
Date:   Wed, 22 Jul 2020 19:50:17 +0530
Message-Id: <1595427617-1713-1-git-send-email-vthiagar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allocated ack_frame id from local->ack_status_frames is not really
stored in the tx_info for 802.3 Tx path. Due to this, tx ack status
is not reported and ack_frame id is not freed for the buffers requiring
tx ack status. Also move the memset to 0 of tx_info before
IEEE80211_TX_CTL_REQ_TX_STATUS flag assignment.

Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
---
 net/mac80211/tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e9ce658141f5..98dfabb7b7f7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4227,11 +4227,12 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
 		goto out_free;
 
+	memset(info, 0, sizeof(*info));
+
 	if (unlikely(!multicast && skb->sk &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		ieee80211_store_ack_skb(local, skb, &info->flags, NULL);
-
-	memset(info, 0, sizeof(*info));
+		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
+							     &info->flags, NULL);
 
 	if (unlikely(sdata->control_port_protocol == ehdr->h_proto)) {
 		if (sdata->control_port_no_encrypt)
-- 
2.7.4

