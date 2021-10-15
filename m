Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DBA42F1F9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhJONRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhJONRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1520C061762
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so26366303wra.12
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHuhRsyo5I9tg994O+s+A8x/tyH5ZdCl1bmMze2pAnU=;
        b=laUkFjTz3t6pC1ovKbp5JgO8lCUtujhpQa+xjjbbWLawmNYdE1g/9ekgqTm4W8jzOa
         foPSTOdVpo8tlBF7eTxEyW//MPy+f18a8ch0UBY6zJ3SXP6cLApQ00a6jjS6fv81nuj7
         thG30CCCKWlj/tm2exCsxBJ2vZCJhQwPZl4yGsKVHyHuyk12WdZ0DbkgfYrYTjiuftin
         d5AqhE81uNWP5u+awyqQvPzvJytVD1MUN+OfQN1FV/u66PHYvBiqCUrl5lJYxhvLeais
         55KaNvlvNtayZQehr9KYU/0VnKP1b8BA6gH+xpZcR7C677wslyH2gXVsTHVqyQkSDAvM
         d2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHuhRsyo5I9tg994O+s+A8x/tyH5ZdCl1bmMze2pAnU=;
        b=f6ed9WFE3+EkPKI3GnDSdQ0SOX5J2r5D6kAksyUgvVKF3VVOydlQDWdOry6AeTEPno
         1laEpE254opMB84EMQ/8Yp1Svj9HJBFPjIcaoWGYzRlW2/XcW/mzdVU5ynodLo6TBLAn
         h731TChMcIvsIk5I1aboPuZv3xY4vqZ+XOGrKCWL7/NMBWzkltGP05wSl0Jl7dc2gmN5
         o3j6QBdTbqO6cefLW6xFTRA6UnX681Zh4UETuwgljEX1xpGuDcrF/sYu/8kMHM7WlijL
         duJMCjp/JvP7EqqTQmVrEGTLaVIntZzhx976wG9dWGM4FB/6mJUaJDa8GNWVjKCPs93/
         B/TQ==
X-Gm-Message-State: AOAM532DCEP2bnMpPUo0a88fIIIF0d9pn2u0Xk9dgQyoDSPK8R5mL69f
        I4lCKI7rzYUYGEiGsTSVnSSL0w==
X-Google-Smtp-Source: ABdhPJwoZ1vrQUl1TEORYABjSpTZ8cwVBJu5hdQt5I/fll3uHO+PwL4j/74t7WcqosBHnaq8ZPVmNw==
X-Received: by 2002:a5d:6245:: with SMTP id m5mr14385783wrv.148.1634303744292;
        Fri, 15 Oct 2021 06:15:44 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e8sm7091716wrg.48.2021.10.15.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:15:43 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 1/4] wcn36xx: Fix DXE lock layering violation
Date:   Fri, 15 Oct 2021 14:17:38 +0100
Message-Id: <20211015131741.2455824-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
References: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Looking at the code here we see that txrx.c is taking the dxe.c lock to set
and unset the current TX skbuff pointer.

There is no obvious logical bug however, it is a layering violation to
share locks like this.

Lets tidy up the code a bit by making access functions to set and unset the
TX sbuff. This makes it easier to read and reason about this code without
having to switch between multiple files.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c  | 26 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/dxe.h  |  2 ++
 drivers/net/wireless/ath/wcn36xx/txrx.c | 15 ++------------
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 8e1dbfda65386..4e898bde1bb8c 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -831,6 +831,32 @@ int wcn36xx_dxe_tx_frame(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_dxe_set_tx_ack_skb(struct wcn36xx *wcn, struct sk_buff *skb)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wcn->dxe_lock, flags);
+	if (wcn->tx_ack_skb) {
+		spin_unlock_irqrestore(&wcn->dxe_lock, flags);
+		wcn36xx_warn("tx_ack_skb already set\n");
+		return -EINVAL;
+	}
+
+	wcn->tx_ack_skb = skb;
+	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
+
+	return 0;
+}
+
+void wcn36xx_dxe_unset_tx_ack_skb(struct wcn36xx *wcn)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wcn->dxe_lock, flags);
+	wcn->tx_ack_skb = NULL;
+	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
+}
+
 int wcn36xx_dxe_init(struct wcn36xx *wcn)
 {
 	int reg_data = 0, ret;
diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.h b/drivers/net/wireless/ath/wcn36xx/dxe.h
index 31b81b7547a32..083a95e7de576 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.h
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.h
@@ -467,4 +467,6 @@ int wcn36xx_dxe_tx_frame(struct wcn36xx *wcn,
 			 struct sk_buff *skb,
 			 bool is_low);
 void wcn36xx_dxe_tx_ack_ind(struct wcn36xx *wcn, u32 status);
+int wcn36xx_dxe_set_tx_ack_skb(struct wcn36xx *wcn, struct sk_buff *skb);
+void wcn36xx_dxe_unset_tx_ack_skb(struct wcn36xx *wcn);
 #endif	/* _DXE_H_ */
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index cab196bb38cd4..969210812cfbb 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -502,7 +502,6 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct wcn36xx_vif *vif_priv = NULL;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	unsigned long flags;
 	bool is_low = ieee80211_is_data(hdr->frame_control);
 	bool bcast = is_broadcast_ether_addr(hdr->addr1) ||
 		is_multicast_ether_addr(hdr->addr1);
@@ -524,15 +523,8 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
 		wcn36xx_dbg(WCN36XX_DBG_DXE, "TX_ACK status requested\n");
 
-		spin_lock_irqsave(&wcn->dxe_lock, flags);
-		if (wcn->tx_ack_skb) {
-			spin_unlock_irqrestore(&wcn->dxe_lock, flags);
-			wcn36xx_warn("tx_ack_skb already set\n");
+		if (wcn36xx_dxe_set_tx_ack_skb(wcn, skb))
 			return -EINVAL;
-		}
-
-		wcn->tx_ack_skb = skb;
-		spin_unlock_irqrestore(&wcn->dxe_lock, flags);
 
 		/* Only one at a time is supported by fw. Stop the TX queues
 		 * until the ack status gets back.
@@ -562,10 +554,7 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 		/* If the skb has not been transmitted,
 		 * don't keep a reference to it.
 		 */
-		spin_lock_irqsave(&wcn->dxe_lock, flags);
-		wcn->tx_ack_skb = NULL;
-		spin_unlock_irqrestore(&wcn->dxe_lock, flags);
-
+		wcn36xx_dxe_unset_tx_ack_skb(wcn);
 		ieee80211_wake_queues(wcn->hw);
 	}
 
-- 
2.33.0

