Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13614239DB2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgHCDLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgHCDLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F479C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so13013683wmi.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dc68vpe0LVXUulWOmw+HiZxgDJO28qrPNtD0WWyi8Tc=;
        b=ft/Q1CIUiqx6ryiWMvkYWb2I/kUTLpSuMimOKZM2WxAdtJUdmOTc0RTQXr2EkgsS4J
         MP9Jk50dnN6r8AOvlzinkC2vPPGN7Rgx2aUCXxIIqP2AiYR2/UWHdQZu30for3XlpmA+
         VD1d5jTP4/Pbz/lgx6HgvgeSaZm23VH3Rk7QDQp4e+4/S1OgAouMsmIQhcozXqKTPrNQ
         QIq7hcqQNMBjvQVhBTP1KIHG5Ko3NQzxT/qflnM1wgM/nyjgO+uBA2QuoJUeN81xgVeL
         m+Ke7ZGHk3w1aKfkBvoECjAxg1V6vwt+EYxmj5ZfCshPHk8aoH9zqNPeAqDaxMFuQ7SC
         mDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dc68vpe0LVXUulWOmw+HiZxgDJO28qrPNtD0WWyi8Tc=;
        b=QwWuvg6EJaiyAhRTUoFkN64+vKRJBQ0ZXJtJLZe/Zu2KeDkvDoBEUIdfZ0p9PYXF4/
         P2AuNH9QS55IjT+9s9xhb0KkOUKA25h1mus2XwJcIVC5M8xomNTzxxDQk8ItWjU9zewx
         ATaYYy01XkMeskETv/YliEWKjPLlVALcK64pEJtse+sal7ERzvvauMQ/rNhR84HLz98q
         hu70o2zDSc7CVM16Tsn14yzC3hLSUxVRbdu43PbqPUiECwdBZfdfZesrMIHRCeOUYzh3
         Wlw89n28BXbNhawt6B/Qj/4lDCjFUuPNoam9auwUsZRTVqHD2FpOHHYoyF+CdnDRabmX
         7VVA==
X-Gm-Message-State: AOAM532rA09g4em5/IG/oQPzIsFOrslJVa1ycJAmUBgXkfLaQp8buxzQ
        /1drfWX+UI4g57qwNzF2gEOPWA==
X-Google-Smtp-Source: ABdhPJxHDo/9yz1YSMlxv98Q1bFr7pWkf+ycR1vK5rO9n9c+4m2AH6b2oCcJiuw610zPctuwUxDY7A==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr13437098wmc.179.1596424266273;
        Sun, 02 Aug 2020 20:11:06 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 18/36] wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
Date:   Mon,  3 Aug 2020 04:11:14 +0100
Message-Id: <20200803031132.1427063-19-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds a wrapper function wcn36xx_smd_set_sta_params_v1() which
calls into wcn36xx_smd_set_sta_params() and then subsequently sets
version-1 specific parameters.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index ab9f0361aec4..f61516988953 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1241,6 +1241,31 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
+static void
+wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct wcn36xx_hal_config_sta_params_v1 *sta_par)
+{
+	struct wcn36xx_sta *sta_priv = NULL;
+	struct wcn36xx_hal_config_sta_params sta_par_v0;
+
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, &sta_par_v0);
+	wcn36xx_smd_convert_sta_to_v1(wcn, &sta_par_v0, sta_par);
+
+	if (sta) {
+		sta_priv = wcn36xx_sta_to_priv(sta);
+		wcn36xx_smd_set_sta_vht_params(sta, sta_par);
+		wcn36xx_smd_set_sta_ht_ldpc_params(sta, sta_par);
+		memcpy(&sta_par->supported_rates, &sta_priv->supported_rates,
+		       sizeof(sta_par->supported_rates));
+	} else {
+		wcn36xx_set_default_rates_v1(&sta_par->supported_rates);
+		wcn36xx_smd_set_sta_default_vht_params(wcn, sta_par);
+		wcn36xx_smd_set_sta_default_ht_ldpc_params(wcn, sta_par);
+	}
+}
+
 static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_sta *sta,
 				      void *buf,
-- 
2.27.0

