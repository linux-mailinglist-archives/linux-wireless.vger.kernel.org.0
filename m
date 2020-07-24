Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38822C2E8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGXKPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgGXKPf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 06:15:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D2C0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so7106877wmg.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6sIBs2chvdtlEKeOF6rmdpIMaaTVwiwiQeevfHl2XXk=;
        b=m4QVLZ8yfq0jCWgZZhasLvAzDwhOnovGfmIrWzAePSJr8qA/rxrsHf80FwCrRlceUC
         vWfNM4lSAkKHjyDOIC51I8EDM8kQU2/0FrUuKE8LHt4xJQquk8LFXsoHwaqEWki5ODy/
         ytTEtWfzjku5DnY+a9O/FG46+yhc8F3w76yla1VbiLFC1Czec09kcvAb3MLPo1oVqxb8
         MvBGuBkRbtug+ohZPeOy/opp5voOjvBfCiBVB1nxuFVO2k9bg53L1INmNW4Ab7BjwOD6
         f5fFQHKFWh0b65kOUzTxbCbD0aJUh7F9+pugj5+VYY1L/oPj7MQXIrgUFuTnYNibtiw0
         E2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6sIBs2chvdtlEKeOF6rmdpIMaaTVwiwiQeevfHl2XXk=;
        b=Z+Fr3o8zHHWB/4Gxq15lFE8WQ3AOcVXs5ImtRbXA67TYMBFFDyj5jKja88k6QK/amc
         VIEzTaAawYHKHfRbtzhYjyXK6X1SMGKF/b8vDk9eX9RvuoYX3oZ6E8gAKtkaaHIqRnFy
         dlAnw4t5F14WfE2+kseRr6q5F/j21e/wnpkUUysKqqxrfSo8xNjHHHGpxTkme+2KSKYH
         dXYokMjCt2naB8ytSZUDavwachZsAxmLYeLrBPeq5A4WWQkz0Iy0GoKivXjuqiBDbthn
         t60QqLgoz4s7Nmzjjd57kjVzJEsoNDB0WNolJu03K5U3V4CcbyPS3B4mHAXXwPAZ3v9e
         pW3w==
X-Gm-Message-State: AOAM531EPMom9xudK9r7Crik9QXtIscxRIKzWE3E6DV9nUeuNG9j1Qnj
        rBOftm/yaUhmCuOy/1h+ZfeD1g==
X-Google-Smtp-Source: ABdhPJwg3hSv/7exm0i0KMK9ArjANj4yxY46PKbm2dJFhvL45UEU/nQ7ZT04SsFGomlR6drLCVvBVQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr7705694wmj.57.1595585733593;
        Fri, 24 Jul 2020 03:15:33 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id d18sm774714wrj.8.2020.07.24.03.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 03:15:33 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 4/6] wcn36xx: Fix TX data path
Date:   Fri, 24 Jul 2020 12:20:50 +0200
Message-Id: <1595586052-16081-5-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
References: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
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

