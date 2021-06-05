Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73B39C4C3
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFEBM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:12:56 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35480 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEBM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:12:56 -0400
Received: by mail-wr1-f41.google.com with SMTP id m18so10946281wrv.2
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDB2CUDPDaolV/e1QpwHthEeMSH5hthfQ21cne8mw4A=;
        b=NF/cwqZ6Ubzo4pV7cu65rgWcEdGWB5wymDbcsQuIkGi1LgTpPDlHB6xbU2iNhV5xlV
         kvM/jq/ftKX/i/VyuGuabC1wuhZUgS5Lpa38uAeYJidXWACYL2od97F+9rwlE/MA/kLf
         F9TJGKTKDLaeTSm7bAGeNnTdMKcJL92sDZ6Ch1d+IchWYXj6DAnTISWsWOYOF3YhK74z
         EBXf3JD5MidAa65Ox9hz81o3F/mWNueCDzKbz/znvGghjOwNrVURbm7d1mu9AxVKBLdB
         kAlC/elIkXNVcIr9kAlvm3np71E+O1FDnY7ZmR6ESSeBjIvAuQXGkZg7iZeLKbOIYQj4
         zR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDB2CUDPDaolV/e1QpwHthEeMSH5hthfQ21cne8mw4A=;
        b=pyXiB9kn+7b6X9NARdLPMIeNkUmE63yOtokGkuQ1vgYHZzxKEUYzFczWGoEYV7eDkX
         715JGorRXgw8YfiG3WBdMag6+UwpoDZEagZDspUgqmmeBW/ymBKIKKDLbaSjqJMPxZJo
         D0tHu5BrnWvKZ9dD5qPhKQzSCEfv5KviOsRc7BHb9yyOgOB1uN0rpRxCxqu91wkaFAHx
         kecxyB7cMb2pgksyJA8wjWQRjLXmEmY5X+j7FYen398ELiMeRbW9mk5rkttzeDavpxeR
         2+MBDdnvJksrTMOU4fcoWX5r6v60E5zNXnPJyoR1Bq98aW2+7dokTdjmAGntywKRDs3A
         HdCQ==
X-Gm-Message-State: AOAM531ps9nLFCyEetcFWbwYVbMbmu+AhtAkaZhCw6au/i3OE21CImps
        rYhLp31QHJ2mvBAVhLw1B2Ctbg==
X-Google-Smtp-Source: ABdhPJzatelMtxYytOstRQgjT9Ov2yoYI0dnrQVpstU13+IpjmBkphI4KtbY6DcUcYazwxMC0c6CMA==
X-Received: by 2002:adf:f346:: with SMTP id e6mr6183011wrp.179.1622855398651;
        Fri, 04 Jun 2021 18:09:58 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:09:58 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 02/12] wcn36xx: Run suspend for the first ieee80211_vif
Date:   Sat,  5 Jun 2021 02:11:30 +0100
Message-Id: <20210605011140.2004643-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A subsequent set of patches will extend out suspend/resume support in this
driver, we cannot set the firmware up for multiple ipv4/ipv6 addresses and
as such we can't iterate through a list of ieee80211_vif.

Constrain the interaction with the firmware to the first ieee80211_vif on
the suspend/resume/wowlan path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 31 ++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b361e40697a6..9a97a288a96f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1088,15 +1088,34 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
 
 #ifdef CONFIG_PM
 
+static struct ieee80211_vif *wcn36xx_get_first_assoc_vif(struct wcn36xx *wcn)
+{
+	struct wcn36xx_vif *vif_priv = NULL;
+	struct ieee80211_vif *vif = NULL;
+
+	list_for_each_entry(vif_priv, &wcn->vif_list, list) {
+		if (vif_priv->sta_assoc) {
+			vif = wcn36xx_priv_to_vif(vif_priv);
+			break;
+		}
+	}
+	return vif;
+}
+
 static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 {
 	struct wcn36xx *wcn = hw->priv;
-	int ret;
+	struct ieee80211_vif *vif = NULL;
+	int ret = 0;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	ret = wcn36xx_smd_set_power_params(wcn, true);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_assoc_vif(wcn);
+	if (vif)
+		ret = wcn36xx_smd_set_power_params(wcn, true);
+	mutex_unlock(&wcn->conf_mutex);
 
 	return ret;
 }
@@ -1104,11 +1123,17 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 static int wcn36xx_resume(struct ieee80211_hw *hw)
 {
 	struct wcn36xx *wcn = hw->priv;
+	struct ieee80211_vif *vif = NULL;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	wcn36xx_smd_set_power_params(wcn, false);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_assoc_vif(wcn);
+	if (vif)
+		wcn36xx_smd_set_power_params(wcn, false);
+	mutex_unlock(&wcn->conf_mutex);
+
 	return 0;
 }
 
-- 
2.30.1

