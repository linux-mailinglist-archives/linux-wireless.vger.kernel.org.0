Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0551E99F3
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2020 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgEaS41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 May 2020 14:56:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48738 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbgEaS40 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 May 2020 14:56:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590951385; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GY0UL1d42jxKtmM+sKRO++ZAk83fZY5nWlncvV98PLQ=; b=OIMQ/x0QUcb0I978xGizxe7ow82uWuAMXyzU8Kg3O8c5ivsemDiNH97Veb5G0+e82keoCwY0
 +cDjGKsJxVvXC2D+M7wSc6HJjZQSollLV72l4GU5oxX5T07gMwLTleraZfh7t5fdLBWCn8gV
 y+mMKw8XbjB4/glbufJsiIohkQg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed3fdc944a25e00523c325b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 31 May 2020 18:56:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C27CC433A1; Sun, 31 May 2020 18:56:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB982C43391;
        Sun, 31 May 2020 18:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB982C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v4 5/8] ath11k: set psc channel flag when sending channel list to firmware.
Date:   Sun, 31 May 2020 11:55:57 -0700
Message-Id: <20200531185600.20789-6-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531185600.20789-1-pradeepc@codeaurora.org>
References: <20200531185600.20789-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If 6 ghz channel is a Preferred Scanning Channel(PSC), mark
the channel flag accordingly when updating channel list to firmware.
This will be used when making scanning decision in 6GHz channels.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v4:
 - use cfg80211_channel_is_psc.
v3:
 - use helper function ieee80211_is_channel_psc() instead of
   channel flag for identifying 6GHz PSC channels.

 drivers/net/wireless/ath/ath11k/reg.c | 4 ++++
 drivers/net/wireless/ath/ath11k/wmi.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 453aa9c06969..7c9dc91cc48a 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -161,6 +161,10 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 			else
 				ch->phy_mode = MODE_11A;
 
+			if (channel->band == NL80211_BAND_6GHZ &&
+			    cfg80211_channel_is_psc(channel))
+				ch->psc_channel = true;
+
 			ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
 				   "mac channel [%d/%d] freq %d maxpower %d regpower %d antenna %d mode %d\n",
 				   i, params->nallchans,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index fd82cff7537b..76c2da2c5db7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2520,7 +2520,8 @@ struct channel_param {
 	    allow_ht:1,
 	    allow_vht:1,
 	    allow_he:1,
-	    set_agile:1;
+	    set_agile:1,
+	    psc_channel:1;
 	u32 phy_mode;
 	u32 cfreq1;
 	u32 cfreq2;
-- 
2.17.1

