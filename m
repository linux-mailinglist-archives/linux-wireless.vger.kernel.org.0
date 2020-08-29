Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0225647B
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgH2DjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgH2Diy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232FC061232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o4so906398wrn.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxv61ncwVKFnMMfQ3MXOOnXWNB/b+jhNeIcIEXIr8Og=;
        b=X7A5f5kIZQxiUDKLPU+AyV/QmxXLuswYHbKSh6F1VmRxPjWCzx3SyQ4oHX5H1S6t2u
         mGXjZQfvo1/SQNzftI86fsJS9aq1sIKYUqQy3kShimW8ZADkw3q02mrzeydHmTnNFeIp
         7q1hL3lNe0NxQYXBXvJEmHERxi+yEixSHy4Ry2RQeY7kWK3JlOAKbflMcpNDAg7Rhwyp
         ZMM7aLgFlSS6KO+xOiZww2BGgQJtNR7j3g4zpg3Ht6oQQ5xIa1SlJ3z2YuxeiLzqCRKj
         Shd4Dh9A8aLG9iOTf3pkjxGKUa6WU8+lltBmEXwUxP3RiRA0sME22LunfGHJH95+E/UQ
         CdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxv61ncwVKFnMMfQ3MXOOnXWNB/b+jhNeIcIEXIr8Og=;
        b=Ym91XkT4Rv6AOuS6lC5sXOEPp6rl7NPKE8MzNpCg5eAhrZg9WGIvecs/8+SDeTWbUW
         hmyGCKKCrvS4cJ7OgX1S2nbcFOQtVeUda76XXPMTN2356Pi8DUUejWKNCDUdbEMA13Cn
         9sZz/amB3EAdVO8yS0GfeD2OAPBwvDIzun7LTAFm/yxHiExJ7z5XPNr714Xa/DneP3UI
         kpX6JJYbH+OcF8ufZ6btc9XF/qi3T+jurzC6kQjygE+ic/lVkkZ6q1cU3u/QIOLRZDIP
         fLmpamQBHB2r3VRlGn/grRg7q8FWHJKonCHQAtI/6/xPa9P30cIuS3LvbxJ62QEi30Lb
         az0w==
X-Gm-Message-State: AOAM533zd2XOlzxlKnNyUVMcTBJsGxcIj2HvtuKHuNABx2ieWxA2eV7M
        g5RCpVzxhDgokyLoCrYJFYuBBg==
X-Google-Smtp-Source: ABdhPJwzhrKlkVFHTpphp9UXmECJmvvV9nQFnNgEil6PtJvM1c/nJl74SDv3c2LC83vJEprwqwR11g==
X-Received: by 2002:adf:f106:: with SMTP id r6mr1752085wro.106.1598672332736;
        Fri, 28 Aug 2020 20:38:52 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:52 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 7/7] wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
Date:   Sat, 29 Aug 2020 04:39:29 +0100
Message-Id: <20200829033929.2167761-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wcn36xx_smd_config_bss_v0() and wcn36xx_smd_config_bss_v1() have been
designed to operate in standalone fashion. As a result we can drop the
dead code now present in wcn36xx_smd_config_bss() and happily remove one
kzalloc from the BSS config path as we do so.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 39 ++++----------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 9acf1af14c54..2c58f7050836 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1683,42 +1683,15 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, const u8 *bssid,
 			   bool update)
 {
-	struct wcn36xx_hal_config_bss_req_msg *msg;
-	struct wcn36xx_hal_config_bss_params *bss;
-	struct wcn36xx_hal_config_sta_params *sta_params;
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
-	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
-
-	bss = &msg->bss_params;
-	sta_params = &bss->sta;
-
-	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
-
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
-		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-		    bss->oper_mode, bss->nw_type);
 
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
-		    sta_params->bssid, sta_params->action,
-		    sta_params->sta_index, sta_params->bssid_index,
-		    sta_params->aid, sta_params->type,
-		    sta_params->mac);
-
-	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
+	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24))
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
-	} else {
+	else
 		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
-	}
+
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
 		goto out;
@@ -1728,12 +1701,10 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 					 sta,
 					 wcn->hal_buf,
 					 wcn->hal_rsp_len);
-	if (ret) {
+	if (ret)
 		wcn36xx_err("hal_config_bss response failed err=%d\n", ret);
-		goto out;
-	}
+
 out:
-	kfree(msg);
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
-- 
2.27.0

