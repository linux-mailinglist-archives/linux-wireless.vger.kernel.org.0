Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0EF432A28
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhJRXRj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJRXRi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88566C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m22so44363743wrb.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cqgq7CmylZ5uOrbViyRL+gfi0biEauoJtPG6puA4TVg=;
        b=Y0ODsvaf5ZQxj5xz7bmOLKad1kYhn+RH4Ua0wsqAeZod6Uq9jKGhPwNCJG4hxeEkSL
         FM9WV4HKZtzBGJySM7/sP6V/Vf5l/mMGXb49vJqqFj1zMJ/ujbXntX6cpUINNPI0ZDZ3
         6Hcu/LgwjoWIezkxF6NcQFlfYgjUgn60z/bCsjS3k/PEHreq6fB/psqCqxXKG5CnskBp
         nWpwcwHY7CVNEljum3cTy+hLSZewKVzBSBhLsYiiaWJeU7w507uBc3Ju3hiBJNjVwW+y
         iBYTVYFgHzTCjBnxmZDOR4tK4gcwSeZNsIZb+jmhO4WyDgwPRk/30KMNJ+TOfnSOrpSJ
         Lqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cqgq7CmylZ5uOrbViyRL+gfi0biEauoJtPG6puA4TVg=;
        b=v9YeZT238csSWb5A6TEMlP1hkl22gx1O7rCIiQlrgDAJtlicaqJw+p/DTJQDZIU+o3
         r2b3gK00k73pKCTTEPAQV80Gm4eGQGJoGLSyYueKpchfqsKDUPbc0OT2B5CNoIRdcJde
         mo3zFp01Q17ihlkhBtUh3a4jZXJxOzS+1+vWURDANfVR8l6wLAYfNpPU672epvTsVijr
         Z6pN5PjO6Ara1uNw8Rmxz5elB9EQ4K1n0GReRevTVlzGh7iDtKh1ekcxAIsyWG4rMiap
         DhwnOAH12MUstpxNwFsxSux/Gt6IaEsPRCVfElYol4gsamsmCt2hYPpVmP+Nb/VwG4bO
         yO2g==
X-Gm-Message-State: AOAM533jePlBo8PPrTvtbAWmHMaony4Xv0JZ3/8RwY+0lrlnafUpHY+x
        JOdMfL3Oq2bfxja5GBPTStfCDg==
X-Google-Smtp-Source: ABdhPJzeu/mi5sQ0AECApkbIJScjQstkgsvsk2FwVf4f2ED+PSHmEvm0zl0ETS637sJW2Kf4AWsyWw==
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr39642914wrd.264.1634598925129;
        Mon, 18 Oct 2021 16:15:25 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm3685379wrr.15.2021.10.18.16.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:15:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/5] wcn36xx: Fix dxe lock layering violation
Date:   Tue, 19 Oct 2021 00:17:18 +0100
Message-Id: <20211018231722.873525-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
References: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are looking at some interesting crashes with wcn36xx in the wild, with
some of the data appearing to indicate multiple instances of "WARNING
Spurious TX complete indication".

Looking at the code here we see that txrx.c is taking the dxe.c lock to set
and unset the current TX skbuff pointer.

There is no obvious logical bug however, it is a layering violation to
share locks like this.

Lets tidy up the code a bit by making access functions to set and unset the
TX sbuff. This makes it easier to reason about this code without having to
switch between multiple files.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c  | 26 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/dxe.h  |  2 ++
 drivers/net/wireless/ath/wcn36xx/txrx.c | 15 ++------------
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index c4e9e939d7d6d..6c43df4bc92c3 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -878,6 +878,32 @@ int wcn36xx_dxe_tx_flush(struct wcn36xx *wcn)
 	return -EBUSY;
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
index 26a31edf52e99..9a7655d6af982 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.h
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.h
@@ -468,4 +468,6 @@ int wcn36xx_dxe_tx_frame(struct wcn36xx *wcn,
 			 bool is_low);
 int wcn36xx_dxe_tx_flush(struct wcn36xx *wcn);
 void wcn36xx_dxe_tx_ack_ind(struct wcn36xx *wcn, u32 status);
+int wcn36xx_dxe_set_tx_ack_skb(struct wcn36xx *wcn, struct sk_buff *skb);
+void wcn36xx_dxe_unset_tx_ack_skb(struct wcn36xx *wcn);
 #endif	/* _DXE_H_ */
diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index d727b0dd98de5..1218bd85de3ba 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -584,7 +584,6 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct wcn36xx_vif *vif_priv = NULL;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	unsigned long flags;
 	bool is_low = ieee80211_is_data(hdr->frame_control);
 	bool bcast = is_broadcast_ether_addr(hdr->addr1) ||
 		is_multicast_ether_addr(hdr->addr1);
@@ -606,15 +605,8 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
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
@@ -644,10 +636,7 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
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

