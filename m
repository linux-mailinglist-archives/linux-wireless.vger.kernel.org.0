Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F40459459
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhKVR4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 12:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbhKVR4K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 12:56:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB8DC061714
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 09:53:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so34284878wrb.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YhYQ8RUeTdwDl+lHrOExHFWJ0nZobvIqPzubZOppEjA=;
        b=BLKKH9jEEiq81IjAPAFTpW/7efYH2zzqgDTzjpUAFwEVLQcmzqSxspHxNSO0aE+y3d
         vigYizmwj0ZbcglXnqlFWnKN14a/L6ah5HG3PGOYhA719+Y6u9lKMOWqWuZthX6wmTtJ
         nQlgsztpYM+BZ5OttZZNNa/mbmmAex5uCamx7lQwxs0Gj9wKd845mol/cejawYAKvv+Q
         VgRICe7i/2cSTtmiJvCP1+Yilupn+ehbLYz2WplHj/+li26O9NheP0gPG3BGI4Wt2pv9
         lW8u8x1s89DL4yhlURz9ip7Q/9xDPz8Zx1b5VLIgdFOw/FadV7Ildwantpc3BNFA1b29
         7sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YhYQ8RUeTdwDl+lHrOExHFWJ0nZobvIqPzubZOppEjA=;
        b=v1UwMYkxe5JyjaZBkqTfnFEnI8PaDOeQpzKeXiM8+Kg1ItON8Hh4a+lvrBM6aJKCJg
         WSa9erdmBxmNq5GnjMHCuA2+RzwVo8rIJ63+NAH0o/OSp44w3IFcVIMi4cbGfJyGuAGM
         nJpEl9WE9P9MXfc+0apdeV5vCvukZquvukz5Xnh/bF+tIuaxiR4iy+Sw9k6ddKRqOtZC
         hLECdeSXRHTm0ft7rMrdXBOaNEpkpL4jVFCtmeU6lkf4T1colSfU8RC81fPhRs3BOYe0
         Imx8LQfA0nvMaUfsS63oXMLw1osxPLNr64+Vd3dysKoINfD7hpLRMVtyB82FSWddRcZ8
         2bUg==
X-Gm-Message-State: AOAM5313sKs0Hd3geyXWfiGhA5qMXyTHPDWE4CpbFK2oOQQpogaj/7Tx
        MirgzE9Q80Uace19f51culRM4oyg3e2wscBkNyo=
X-Google-Smtp-Source: ABdhPJyvwMZEux+GWr1g88XZ5P5WqC4aifgYC+yz0MHyX+gxioPaPjVJ1Dz9bSfBl5NwFjhJelYRxg==
X-Received: by 2002:a05:6000:2c7:: with SMTP id o7mr40688087wry.62.1637603582284;
        Mon, 22 Nov 2021 09:53:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:82c:5f0:d48:f7c8:670e:7ff4])
        by smtp.gmail.com with ESMTPSA id g124sm21722612wme.28.2021.11.22.09.53.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 09:53:01 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Use correct SSN for ADD BA request
Date:   Mon, 22 Nov 2021 19:04:11 +0100
Message-Id: <1637604251-11763-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since firmware uses its own sequence number counters, we need to
use firmware number as well when mac80211 generates the ADD_BA
request packet. Indeed the firmware sequence counters tend to
slightly drift from the mac80211 ones because of firmware offload
features like ARP responses. This causes the starting sequence
number field of the ADD_BA request to be unaligned, and can possibly
cause issues with strict/picky APs.

To fix this, we retrieve the current firmware sequence number for
a given TID through the smd_trigger_ba API, and use that number as
replacement of the mac80211 starting sequence number.

This change also ensures that any issue in the smd *ba procedures
will cause the ba action to properly fail, and remove useless call
to smd_trigger_ba() from IEEE80211_AMPDU_RX_START.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 23 ++++++++++++++++++-----
 drivers/net/wireless/ath/wcn36xx/smd.c  | 29 +++++++++++++++++++++++++----
 drivers/net/wireless/ath/wcn36xx/smd.h  |  2 +-
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b04533b..7731ad0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1196,7 +1196,7 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 	u16 tid = params->tid;
 	u16 *ssn = &params->ssn;
 	int ret = 0;
-	u8 session;
+	int session;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac ampdu action action %d tid %d\n",
 		    action, tid);
@@ -1208,9 +1208,11 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 		sta_priv->tid = tid;
 		session = wcn36xx_smd_add_ba_session(wcn, sta, tid, ssn, 0,
 						     get_sta_index(vif, sta_priv));
+		if (session < 0) {
+			ret = session;
+			goto out;
+		}
 		wcn36xx_smd_add_ba(wcn, session);
-		wcn36xx_smd_trigger_ba(wcn, get_sta_index(vif, sta_priv), tid,
-				       session);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		wcn36xx_smd_del_ba(wcn, tid, 0, get_sta_index(vif, sta_priv));
@@ -1220,6 +1222,18 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 		sta_priv->ampdu_state[tid] = WCN36XX_AMPDU_START;
 		spin_unlock_bh(&sta_priv->ampdu_lock);
 
+		/* Replace the mac80211 ssn with the firmware one */
+		wcn36xx_dbg(WCN36XX_DBG_MAC, "mac ampdu ssn = %u\n", *ssn);
+		wcn36xx_smd_trigger_ba(wcn, get_sta_index(vif, sta_priv), tid, ssn);
+		wcn36xx_dbg(WCN36XX_DBG_MAC, "mac ampdu fw-ssn = %u\n", *ssn);
+
+		/* Start BA session */
+		session = wcn36xx_smd_add_ba_session(wcn, sta, tid, ssn, 1,
+						     get_sta_index(vif, sta_priv));
+		if (session < 0) {
+			ret = session;
+			goto out;
+		}
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
@@ -1227,8 +1241,6 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 		sta_priv->ampdu_state[tid] = WCN36XX_AMPDU_OPERATIONAL;
 		spin_unlock_bh(&sta_priv->ampdu_lock);
 
-		wcn36xx_smd_add_ba_session(wcn, sta, tid, ssn, 1,
-			get_sta_index(vif, sta_priv));
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
@@ -1244,6 +1256,7 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 		wcn36xx_err("Unknown AMPDU action\n");
 	}
 
+out:
 	mutex_unlock(&wcn->conf_mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index ed45e2cf..7fcb40f 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2557,6 +2557,7 @@ int wcn36xx_smd_add_ba_session(struct wcn36xx *wcn,
 					     &session_id);
 	if (ret) {
 		wcn36xx_err("hal_add_ba_session response failed err=%d\n", ret);
+		ret = -EINVAL;
 		goto out;
 	}
 
@@ -2622,27 +2623,43 @@ int wcn36xx_smd_del_ba(struct wcn36xx *wcn, u16 tid, u8 direction, u8 sta_index)
 	return ret;
 }
 
-static int wcn36xx_smd_trigger_ba_rsp(void *buf, int len)
+static int wcn36xx_smd_trigger_ba_rsp(void *buf, int len, struct add_ba_info *ba_info)
 {
+	struct wcn36xx_hal_trigger_ba_rsp_candidate *candidate;
 	struct wcn36xx_hal_trigger_ba_rsp_msg *rsp;
+	int i;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
 	rsp = (struct wcn36xx_hal_trigger_ba_rsp_msg *) buf;
+
+	if (rsp->candidate_cnt < 1)
+		return rsp->status ? rsp->status : -EINVAL;
+
+	candidate = (struct wcn36xx_hal_trigger_ba_rsp_candidate *)(buf + sizeof(*rsp));
+
+	for (i = 0; i < STACFG_MAX_TC; i++) {
+		ba_info[i] = candidate->ba_info[i];
+	}
+
 	return rsp->status;
 }
 
-int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u8 session_id)
+int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u16 *ssn)
 {
 	struct wcn36xx_hal_trigger_ba_req_msg msg_body;
 	struct wcn36xx_hal_trigger_ba_req_candidate *candidate;
+	struct add_ba_info ba_info[STACFG_MAX_TC];
 	int ret;
 
+	if (tid >= STACFG_MAX_TC)
+		return -EINVAL;
+
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_TRIGGER_BA_REQ);
 
-	msg_body.session_id = session_id;
+	msg_body.session_id = 0; /* not really used */
 	msg_body.candidate_cnt = 1;
 	msg_body.header.len += sizeof(*candidate);
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
@@ -2657,13 +2674,17 @@ int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u8 sessio
 		wcn36xx_err("Sending hal_trigger_ba failed\n");
 		goto out;
 	}
-	ret = wcn36xx_smd_trigger_ba_rsp(wcn->hal_buf, wcn->hal_rsp_len);
+	ret = wcn36xx_smd_trigger_ba_rsp(wcn->hal_buf, wcn->hal_rsp_len, ba_info);
 	if (ret) {
 		wcn36xx_err("hal_trigger_ba response failed err=%d\n", ret);
 		goto out;
 	}
 out:
 	mutex_unlock(&wcn->hal_mutex);
+
+	if (ssn)
+		*ssn = ba_info[tid].starting_seq_num;
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 88e045d..cfde153 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -137,7 +137,7 @@ int wcn36xx_smd_add_ba_session(struct wcn36xx *wcn,
 		u8 sta_index);
 int wcn36xx_smd_add_ba(struct wcn36xx *wcn, u8 session_id);
 int wcn36xx_smd_del_ba(struct wcn36xx *wcn, u16 tid, u8 direction, u8 sta_index);
-int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u8 session_id);
+int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u16 *ssn);
 
 int wcn36xx_smd_update_cfg(struct wcn36xx *wcn, u32 cfg_id, u32 value);
 
-- 
2.7.4

