Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B26239DB7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHCDLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgHCDLM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51DC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so27705569wrs.8
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EodbAD856JPjKx6stA7m96iT9XaLUX9CNtoPFY/hAs=;
        b=L1rhFRsEfHLjnSsHVVaEBIxtc9NzrVr56RXmtApGJVLIyBuc/hoXN0d53Z0S/kfb0S
         I7vAIDHZZKsC1gTAc89oWpxfTMF9gDVZ8kX4cuJXHhhV3s6H3j7Jag5v/CMX1rG2DM1b
         HGByol3odBt5m5ujJbJjIGspKtYQkvqYa3KYytc/09zyv9+08/XA7Mv51D+kkBwYjBLx
         TwA1uPYRl6jH6V0rW+LQTSFwDztNdLYm547GlzVwR2cfydfw0qbpmd9UisMefBkp5gz9
         dwe/X6Ra+Gf1r5WwyuQfmyPppydl4yKqBNVQfZ8Wpvw4quyPWHmav8xhb1aYrwE4Tzs5
         BeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EodbAD856JPjKx6stA7m96iT9XaLUX9CNtoPFY/hAs=;
        b=aD7Fi4INGLBrA5UtFCpMA67MmhQ8H3IVtcDxf5BLrOIqPWuxsyxaQnuj/KLtmEIvlU
         RTmSmj8YkF+HerHZ1NW30qE2qPVXFQoSvvRqtQa1uq3oI1/s5uR6AeVnR+N1ANuId0mf
         8smT2TUFnPoFoitgN/zsXwIxTlq78JasapXyW+qwK8UCDrsUajMrL1rtmc7Uwv/t+R9d
         yueYGGQ0CuXatg4XftWQf37Hq+auPqWSJdCQAwSXwREyf6cAjFRf0KP9qpgFb52daesu
         TvvG0SgvfwPpGcBZqG7qmPkGWsiFgrC9RQVxu3FpFrO9mGTAepH1LreklRYyvdjBk+cd
         Wczg==
X-Gm-Message-State: AOAM531vYOiEuo97ooGTGOri0M0nTjonCuSEIHlnwgYfzUjT4Di89n0D
        xQ/vOrQnYYrFLiy1D4ry8l2H5Q==
X-Google-Smtp-Source: ABdhPJzqKLUpAJrb7gnUWvNuAS6X4/LgBOiUHF35xEdaa0sqqwb9O422L+o3kfkIs5WepSDVBcnSZg==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr12993677wru.222.1596424270640;
        Sun, 02 Aug 2020 20:11:10 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 22/36] wcn36xx: Move wcn36xx_smd_set_sta_params() inside wcn36xx_smd_config_bss()
Date:   Mon,  3 Aug 2020 04:11:18 +0100
Message-Id: <20200803031132.1427063-23-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to facilitate functional decomposition of
wcn36xx_smd_config_bss() we need to move wcn36xx_smd_set_sta_params() later
in function.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 7ad75faf8c4b..6232e64fb298 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1612,7 +1612,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
 
 	bss->reserved = 0;
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
 	/* wcn->ssid is only valid in AP and IBSS mode */
 	bss->ssid.length = vif_priv->ssid.length;
@@ -1638,6 +1637,8 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	vif_priv->bss_type = bss->bss_type;
 
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
 		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-- 
2.27.0

