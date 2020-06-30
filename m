Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2A20F5F7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbgF3NmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbgF3NmB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 09:42:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B625AC061755
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 06:42:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so18868235wmi.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6sIBs2chvdtlEKeOF6rmdpIMaaTVwiwiQeevfHl2XXk=;
        b=h55QpveRBmEuytChPe1JQ8tfB9L9FDUpKC16zVZ/s+eCYemPIR8SlAKZZXd/xsvkbE
         1NyWPGTIeZsaCTACcmlPipIz1raxsF0ipBwiUqifzgQx8lGx6bxiDm2d/fLZmVXzreUH
         1Z+d93mf9/S+Azk50GhPMGE9ZvYlLtCFwdMptHBhgA7+CsweQchG4kxpDQkO7lhYDvCI
         OJZokJRzs6ZVIy5EHzGmfZNIiTKe1z2IjMq3ehEPjjaaAZKqNR2A9DuOxD+pgAzz4Phz
         N/dzhxai5vhipdshUawrKpFNfSvzUuuPlXGLXTmCrZ5OgiA7H1phULRklXM91VA+LN8f
         q+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6sIBs2chvdtlEKeOF6rmdpIMaaTVwiwiQeevfHl2XXk=;
        b=MPaWTwLVqSuOobVVAVB+asawLEmEH9piWUZ7ni6zybNnLTypfotDv2rh8X+KRNidcq
         sVbo8MrvPE7Mn2GScj+AbpEdM3QR2i2g7oFy+iwUZq7k+Uuf5VkDOFbIwVQXA26XuOKQ
         62OpiTWgQbBPY9nXUCuRhT+bRmCztHnxvkh10bOlCjkD/Ep9M1z8AVQ/iU8OkzIeSOEL
         mHPsb/ZqKlbP0bIaGob+t6N5ena8qFXpC69lXF+ZJy9nTzids20/mB913Eg4KYs4yvB6
         6TmSwxvAX64CyQfU2oX8fsu09ODcAWn8ZEZoGj8NhySFP2fpp41c23Bl6h73+ACGIbU1
         lhIw==
X-Gm-Message-State: AOAM532NlZ4i4V51txehPenNS/a8ZgyCEOEW+1/QQqHdPjrSf9dRXsOb
        LhQist9n0tO9VAk/hLhMqedO0w==
X-Google-Smtp-Source: ABdhPJyZrb+eaHj4wXU2bLj5vsoaAQ48TQKxHvjykxKLoaY1N9m2rrWtqjrEYsJQuT6EtxlwNl6NpA==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr20023729wmg.34.1593524519466;
        Tue, 30 Jun 2020 06:41:59 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id l18sm3803411wrm.52.2020.06.30.06.41.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:41:59 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH 3/4] wcn36xx: Fix TX data path
Date:   Tue, 30 Jun 2020 15:47:00 +0200
Message-Id: <1593524821-32115-3-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch contains the following fixes:

- Use correct queue for submitting QoS packet. The queue id to use
is a one-to-one mapping with the TID.

- Don't encrypt a frame with IEEE80211_TX_INTFL_DONT_ENCRYPT flag.

- Use the 'special queue' for null packets, preventing the firmware
to submit it as AMPDU.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 274cf58..dcc2ec0 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -160,9 +160,11 @@ static void wcn36xx_set_tx_data(struct wcn36xx_tx_bd *bd,
 				bool bcast)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = NULL;
 	struct wcn36xx_vif *__vif_priv = NULL;
-	bool is_data_qos;
+	bool is_data_qos = ieee80211_is_data_qos(hdr->frame_control);
+	u16 tid = 0;
 
 	bd->bd_rate = WCN36XX_BD_RATE_DATA;
 
@@ -191,24 +193,33 @@ static void wcn36xx_set_tx_data(struct wcn36xx_tx_bd *bd,
 		bd->dpu_sign = __vif_priv->self_ucast_dpu_sign;
 	}
 
-	if (ieee80211_is_any_nullfunc(hdr->frame_control) ||
-	   (sta_priv && !sta_priv->is_data_encrypted)) {
+	if (is_data_qos) {
+		tid = ieee80211_get_tid(hdr);
+		/* TID->QID is one-to-one mapping */
+		bd->queue_id = tid;
+	}
+
+	if (info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT ||
+	    (sta_priv && !sta_priv->is_data_encrypted)) {
 		bd->dpu_ne = 1;
 	}
 
+	if (ieee80211_is_any_nullfunc(hdr->frame_control)) {
+		/* Don't use a regular queue for null packet (no ampdu) */
+		bd->queue_id = WCN36XX_TX_U_WQ_ID;
+	}
+
 	if (bcast) {
 		bd->ub = 1;
 		bd->ack_policy = 1;
 	}
 	*vif_priv = __vif_priv;
 
-	is_data_qos = ieee80211_is_data_qos(hdr->frame_control);
-
 	wcn36xx_set_tx_pdu(bd,
 			   is_data_qos ?
 			   sizeof(struct ieee80211_qos_hdr) :
 			   sizeof(struct ieee80211_hdr_3addr),
-			   skb->len, sta_priv ? sta_priv->tid : 0);
+			   skb->len, tid);
 
 	if (sta_priv && is_data_qos)
 		wcn36xx_tx_start_ampdu(wcn, sta_priv, skb);
-- 
2.7.4

