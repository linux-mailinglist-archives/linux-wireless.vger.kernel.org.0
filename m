Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C025239DB9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHCDLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgHCDLO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D953EC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so13026999wmg.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BTNqwjDKrrqUfjjYFYREgjuysuBsm6saZBOF6hQXB8=;
        b=pf0p2LqHvdoSu1NBezIFgTBQbH78N6H71VzMeBjbkBfD4cmjdcRRFaxVCaCZWkJLZo
         wzBYOriDhpZBpOJ7Uo+muXHglpta9YeXRUpIn87M+hFHV5sehqLv/ndl/3YESsyUMb0c
         RId4b3JXDVsJju67omiC1M/J/2H9E41BIMyLle3t5kt6d0MErFOUccCg4WQup5uCDNgW
         o/ji6LTq/HQq4YUqyzTLga8vtqaVaOLXFff5JE/Vll/pXgrXP/9y0h4pzdnwMJnu5cVb
         5R2qmDmPX00YeKwJQM4eS6eem7snVnwf6g6tqxBXiGGWWoUofBPcARAe1+7Ju/L9oiGP
         tzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BTNqwjDKrrqUfjjYFYREgjuysuBsm6saZBOF6hQXB8=;
        b=d6JZ6hByAecyzJFoZ4y6eUbQtqaMztEgyg7979W1NPuNC5XEmcIdqw90HONivBQeNe
         KNdEDfukwGrXU8iXrGS61I9u0pIUvSOtBPFmByIVPSfy7zSZ1z53vAlfuWMKMQgMsxTs
         h9hgAfAJFMz+B66rzaezuKQVRiGLKHtknnhjTiqs4snExyX2S/ZwX6HDb0VVgzcZDYMC
         H3DliYlUW8Q5uv0qTSl3MK/nu4aA3McvM4BKxBthyEHwb9g3V5+h2ueKDPFibfUXe5ak
         q3F906BNhCSCd69/l35qXILpalugc1LxPR0Pqi6MlURsHVJozQmxvArB8YV8OOFn1u0A
         es4w==
X-Gm-Message-State: AOAM532pSvgRB41amLdbZSg8KhEgnG2UmVIBNLdV2smgXYu9QrVE7hQD
        2wKNCPbkJUo3MwxaGxBCySVFRQ==
X-Google-Smtp-Source: ABdhPJxBtVvbvulxHygOMmFH068tyq2AlfPvkr/uFN6OjsQ7+h2sKgrIySRcuWI5QNWqv/8TTYHj+g==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr13645349wme.50.1596424272685;
        Sun, 02 Aug 2020 20:11:12 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:12 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 24/36] wcn36xx: Add wcn36xx_smd_config_bss_v0
Date:   Mon,  3 Aug 2020 04:11:20 +0100
Message-Id: <20200803031132.1427063-25-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_config_bss_v0() as a step along the road of
functionally decomposing wcn36xx_smd_config_bss().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 5fda63f79ca7..43021b13b5b0 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1584,6 +1584,47 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta, const u8 *bssid,
+			      bool update)
+{
+	struct wcn36xx_hal_config_bss_req_msg *msg;
+	struct wcn36xx_hal_config_bss_params *bss;
+	struct wcn36xx_hal_config_sta_params *sta_params;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
+
+	bss = &msg->bss_params;
+	sta_params = &bss->sta;
+
+	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
+		    bss->bssid, bss->self_mac_addr, bss->bss_type,
+		    bss->oper_mode, bss->nw_type);
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
+		    sta_params->bssid, sta_params->action,
+		    sta_params->sta_index, sta_params->bssid_index,
+		    sta_params->aid, sta_params->type,
+		    sta_params->mac);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+	kfree(msg);
+
+	return ret;
+}
+
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
-- 
2.27.0

