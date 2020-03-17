Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30B818786D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 05:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCQESc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 00:18:32 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57896 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgCQESc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 00:18:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584418711; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zv1ZF5aE/Ow1rxwLiS4O8HQowOiDcGaTxy0iW8ms5NQ=; b=wTkloh+n5+Dc9b0F+TJ9aHuz6x1p59t82Pp0G907jaTKHNyxyIPogwKn8YO2KSEri4CSuksf
 CQbmigTE8rpwijM+5FXinJosSXIu4sOpW1HZ0ZUOdGyhXdTlrWNZmODIRwvvp7TXrRuEcB76
 CnlVZVGgTO8Jgf3pk6yafsDXXis=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e704f96.7fafa992fb58-smtp-out-n02;
 Tue, 17 Mar 2020 04:18:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64B24C43637; Tue, 17 Mar 2020 04:18:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA698C433D2;
        Tue, 17 Mar 2020 04:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA698C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH] ath11k: fill channel info from rx channel
Date:   Tue, 17 Mar 2020 09:48:18 +0530
Message-Id: <1584418698-19505-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fill the channel information from rx channel for the packet
which has invalid channel info from meta data.

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index dc7881b..034e6f21 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1998,9 +1998,13 @@ static void ath11k_dp_rx_h_ppdu(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	} else if (channel_num >= 36 && channel_num <= 173) {
 		rx_status->band = NL80211_BAND_5GHZ;
 	} else {
-		ath11k_warn(ar->ab, "Unsupported Channel info received %d\n",
-			    channel_num);
-		return;
+		spin_lock_bh(&ar->data_lock);
+		rx_status->band = ar->rx_channel->band;
+		channel_num =
+			ieee80211_frequency_to_channel(ar->rx_channel->center_freq);
+		spin_unlock_bh(&ar->data_lock);
+		ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "rx_desc: ",
+				rx_desc, sizeof(struct hal_rx_desc));
 	}
 
 	rx_status->freq = ieee80211_channel_to_frequency(channel_num,
-- 
2.7.4
