Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238E8239DBC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHCDLS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgHCDLR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D185BC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so13027050wmg.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZJJwTRfJFPBU3Vu91Q4/DbR77Wu6U4kNTpxlGREayg=;
        b=elbd9VM5vFPn0RwWyS8xk6xx97ocJlVW15ll+koqPbmbVJiUKCqe8IdD4YHZA/ipAe
         jkzzr8yLrxb+RPTswk59mDPdu8y9tuXQOwCe2K5kAhgbB+9eG7x2TkfeSu59e/yqHLPu
         ulsS4nIuvFW0Vd0KLeDbdZoEKAIR1MbyGBwq67tsqPa4onEMNkPihff+SJT75/WHNe2U
         JWn9dQt5UXqEiD/FJLkwp3p21Rbq05WUsz4hufjFj5HILQcXThdxUz/Oq/41/DV+NBHT
         QloEDSy1gtMquhxje0dHP7iPtzsstke6cWJSMMPSQ42Mw4xv7ZVwNChUVInO4R8aLjYM
         lI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZJJwTRfJFPBU3Vu91Q4/DbR77Wu6U4kNTpxlGREayg=;
        b=ASVWMBSgr7HhegzFZqyB08VCH/t73NE26TTpjEJQBOcyeKY2+DNV3xRg8HdiQbjAbQ
         HoGYhl9clG/88+BXgayfYiPgS2NAwIlZkMmaOCSnFZP5AF7KlLEol83ByrlFWH5WFjZ3
         xw7LYmch/q/0FhVL0w44aKT5bpcmxm42U125MqD9vy9KVeOlFxeYUNFtaFD7UUEeZ8pL
         qq5xCg5JmpwW9W70LXO/OOo0sd1NnCdq8DMU3sTjsvxCCecM/kfGA3m16UPZRCrWhrRe
         Syr8xK63HW1UkEYg7ad298AIaA0LlIMmPLv+nBio8W5llND2vC7mMGPJVm2P83Femhar
         pzmQ==
X-Gm-Message-State: AOAM530lZT43BPkD/T7QGJ7hX+31ZHdJtcep2E9W1t4DmzOM3aA4fRfZ
        Sw39heUbHItGGWR0dwqAsAJHhw==
X-Google-Smtp-Source: ABdhPJzQO4ufKDR38zBgmY8KVO5EBlTEW4pAYrf2vNEpEd8018EyY0stLgy/t0LxT73hmNZKqB7Cog==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr13309557wmh.96.1596424275655;
        Sun, 02 Aug 2020 20:11:15 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 27/36] wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
Date:   Mon,  3 Aug 2020 04:11:23 +0100
Message-Id: <20200803031132.1427063-28-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 033afe52dd9c..1eb13765e1f2 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1676,42 +1676,15 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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
@@ -1721,12 +1694,10 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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

