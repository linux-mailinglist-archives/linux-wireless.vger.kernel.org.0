Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5DC2E67D1
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441838AbgL1Q27 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441824AbgL1Q2z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B8C0617A1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d13so11723790wrc.13
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaRR0s0yK5BJ7snyCgYM3YYfv91qTFP1bIba/mfbIt0=;
        b=W68ezXvAn1yxyVAM4VLHizolz0Zwdnfq4KSit0A1itMtMF/iQt5vHWpmasiwR8uOY6
         iANb9sWGbtrbzeK/2coyGmKHcgTznst/IFmzz58rglUrK3yrf/o0Unk1N9xqCNiv5K9G
         dVoRFsdMxtSBEIj5/lIAqGdf68XwohXZr4GkE03yD0sx3+Hpjl9Mf1+88LmEFof3f9A5
         Gz0UF/f8vOQTFFO9Hi6Ul2dl5n/YNNa9bB7u66lD2wQ/VEWkiAAqdQpxOE5jPQMiNSDM
         UfTwZj/9RK4nNR1G8vwEERUulwQ/iXCaVMez0lxLzfkiizSQFW0gdJrSrYnJ/mhZ1RyT
         3vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaRR0s0yK5BJ7snyCgYM3YYfv91qTFP1bIba/mfbIt0=;
        b=KoVtcP9bPRsXfBwQodEXG3y+rIgj5tgIiOeELAIMznTFvORJCeI9FHyiN+zN2Am+lJ
         NKPxax0cP9ywLhty+Aq1IxopY8UVxnNjfDush5yY1unxXtfxmgFZBQ+wp3wxLtvMEzyK
         8mo9JGXDAe8QlwE9JV0fZAO6WjleKxgr3jwVHE3trxh/tLb4NibU6/7ygm+eAp/t3FCU
         A++Ds2SvPoiGCMScGpDKTAN8TJihwxD17itT75n4M6vi4rGeiSI/PkTxH/kfy5e9prWK
         tSNTaNaa2QmJhaknmnQzsHjIxX1R1jr9n5WDbEcKLpYBDq9g+5jgB7qShb4289D2i4Vf
         sWTA==
X-Gm-Message-State: AOAM531DlMA8726U1UmBvlDtvTyvBGc8LYmRrqZEai75TQ02hn3YrWoW
        jrFBYkD3Y/c+DiAvGbiaCkqmwg==
X-Google-Smtp-Source: ABdhPJw6O0hyzcV4HP4nSNFNiEFZUrWQz1TIHKXJ+IzbVgMJWa8ne1uINiaBhvEwsqTQBNmz2KqW4g==
X-Received: by 2002:adf:ab56:: with SMTP id r22mr40739831wrc.351.1609172862552;
        Mon, 28 Dec 2020 08:27:42 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:41 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 11/13] wcn36xx: Do not suspend if scan in progress
Date:   Mon, 28 Dec 2020 16:28:37 +0000
Message-Id: <20201228162839.369156-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If a scan is in progress do not attempt to enter into suspend. Allow the
scan process to quiesce before proceeding.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    |  5 +++++
 drivers/net/wireless/ath/wcn36xx/smd.c     | 13 +++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h     |  2 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b48a3f0dcc0b..feb909192c8e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1113,6 +1113,11 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
+	if (wcn36xx_smd_is_scanning(wcn)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_vif(wcn);
 	if (vif) {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index dd12575f33c3..378282a93aa0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -731,6 +731,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
 		wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
 		goto out;
 	}
+	wcn->scanning = true;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
@@ -807,6 +808,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FINISH_SCAN_REQ);
 
+	wcn->scanning = false;
 	msg_body.mode = mode;
 	msg_body.oper_channel = WCN36XX_HW_CHANNEL(wcn);
 	if (vif_priv->bss_index != WCN36XX_HAL_BSS_INVALID_IDX) {
@@ -938,6 +940,17 @@ int wcn36xx_smd_stop_hw_scan(struct wcn36xx *wcn)
 	return ret;
 }
 
+bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn)
+{
+	bool scanning;
+
+	mutex_lock(&wcn->hal_mutex);
+	scanning = wcn->scanning;
+	mutex_unlock(&wcn->hal_mutex);
+
+	return scanning;
+}
+
 static int wcn36xx_smd_switch_channel_rsp(void *buf, size_t len)
 {
 	struct wcn36xx_hal_switch_channel_rsp_msg *rsp;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index b225c805107c..3488abb201d0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -159,4 +159,6 @@ int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
 				     struct ieee80211_vif *vif);
 
+bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 6121d8a5641a..36ea768a5203 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -249,6 +249,7 @@ struct wcn36xx {
 	struct ieee80211_vif	*sw_scan_vif;
 	struct mutex		scan_lock;
 	bool			scan_aborted;
+	bool			scanning;
 
 	/* DXE channels */
 	struct wcn36xx_dxe_ch	dxe_tx_l_ch;	/* TX low */
-- 
2.29.2

