Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D096C1DE0C4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEVHYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:24:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42271 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbgEVHYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:24:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590132286; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=jyz3x2JwKOlJ71uD4rr/6M+zl/2g0sj9LnuIltlzqhA=; b=Lt0zB50iz0MQL4twJxlKjp3TEDh4LHnAi8JuCn+FJwF8PjBOnbws2TvcKVDQfbIPfgR3r45w
 lyKH2K0KtDpH8WK78V2Z+SXvXbafvA5i1rlx3m8SX4a7Zso6y9MwVlHygjobBHKQ0WicC+73
 xoeVjgvxsERA+knikt/zazEC8eA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec77e3d.7ff0d1a71228-smtp-out-n02;
 Fri, 22 May 2020 07:24:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5CC2C43387; Fri, 22 May 2020 07:24:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB664C433C8;
        Fri, 22 May 2020 07:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB664C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 6/9] ath11k: set psc channel flag when sending channel list to firmware.
Date:   Fri, 22 May 2020 00:24:28 -0700
Message-Id: <20200522072431.27601-7-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522072431.27601-1-pradeepc@codeaurora.org>
References: <20200522072431.27601-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If 6 ghz channel is a Preferred Scanning Channel(PSC), mark
the channel flag accordingly when updating channel list to firmware.
This will be used when making scanning decision in 6GHz channels.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/reg.c | 4 ++++
 drivers/net/wireless/ath/ath11k/wmi.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 453aa9c06969..50d13a5d7cf8 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -161,6 +161,10 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 			else
 				ch->phy_mode = MODE_11A;
 
+			if (channel->band == NL80211_BAND_6GHZ &&
+			    channel->flags & IEEE80211_CHAN_PSC)
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
