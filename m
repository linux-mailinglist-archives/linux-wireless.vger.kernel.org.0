Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1C2E67AC
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633525AbgL1Q2P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633520AbgL1Q2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1ABC061796
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r7so11757593wrc.5
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b09nwm7NaeS1J9x71TcNl2allAdNLCiHKyq9pTgIlF8=;
        b=gMjL3dHhsy2tfSfXubl1Td3kE3jdr+nWcP/IaMuZUtClF/usQU9BEY4wiqWeG/Ip36
         sYe+UCnI6Lgbgn4KT2APFWFdAlXD1kRSDlzn8yDEK2Zup5+Ntuvy8jXG1M5K9X8H8MIz
         ZXhFT1Tk+FfJLbNS/FHsT3Yz45uWXLsPGybv++12wxhooX5lZdY+DcHoEyYqb/4N9YRz
         Al/Z56dPnS+8jgu9VpZiY6JxiwRTsiujTplUO9jBR6uTdwUJtNAueGpRwkv/IUOGToYh
         QvogNviebwyhN6q38sWAJFAKw7kzb4teoOCUoj1X06k8WSvnUQbcPoCPjPNxDdH+/3ir
         Iipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b09nwm7NaeS1J9x71TcNl2allAdNLCiHKyq9pTgIlF8=;
        b=qkB4nURcSHmYtvE7J7uI6nZO7utc1dGS+OfzVQo+m+AvQYW5ro5aO7IjBGYcLldoqU
         DTfBqjgiTWM5xFOC6Cy81eF42bu67PuQ5OTe/9c1152OmrMtslNvTBe9h5OUoKkHsdCT
         P0z6/mtPMZXsIChCcOkaUWj43m7Cle3UD7/shiwbrbvgvtNshdQZNTLTR6Ygm4ngDIuc
         Q6QvnRDyyrciixctpZZ59rY7scj4sRwPhl9Yea0Ybsh8DV6Si5+jmaAxlRNJyQro3E6x
         z/9B+YyiJ18IymeYmHHtuBdB9mT/Nn57a+MwS3GhfRGO67NHIkUysjAUdPEMQy7RCNX0
         ILkA==
X-Gm-Message-State: AOAM530uoGjnCMQ+CIqhoIplWA0TdBwClUvOodf2z7SiXyRM74sX5iS6
        LHBSJHVpsPUJbpLpo2wCnETq/Q==
X-Google-Smtp-Source: ABdhPJy8QDFmrdXsSXt4w04PKRJ51IwyamnU+2JXAgBp2L1Q5Vyw5o6JZP9HH5/EinuHWDWZLfdNeQ==
X-Received: by 2002:a5d:4641:: with SMTP id j1mr52201878wrs.94.1609172852271;
        Mon, 28 Dec 2020 08:27:32 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:31 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 02/13] wcn36xx: Run suspend for the first ieee80211_vif
Date:   Mon, 28 Dec 2020 16:28:28 +0000
Message-Id: <20201228162839.369156-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A subsequent set of patches will extend out suspend/resume support in this
driver, we cannot set the firmware up for multiple ipv4/ipv6 addresses and
as such we can't iterate through a list of ieee80211_vif.

This patch constrains the interaction with the firmware to the first
ieee80211_vif on the suspend/resume/wowlan path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 43 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index a863a90232c9..b90664bdf6ee 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1088,15 +1088,39 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
 
 #ifdef CONFIG_PM
 
+struct ieee80211_vif *wcn36xx_get_first_vif(struct wcn36xx *wcn)
+{
+	struct wcn36xx_vif *tmp;
+	struct ieee80211_vif *vif = NULL;
+
+	list_for_each_entry(tmp, &wcn->vif_list, list) {
+		vif = wcn36xx_priv_to_vif(tmp);
+		if (vif)
+			break;
+	}
+	return vif;
+}
+
 static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 {
 	struct wcn36xx *wcn = hw->priv;
-	int ret;
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *vif_priv = NULL;
+	int ret = 0;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	ret = wcn36xx_smd_set_power_params(wcn, true);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_vif(wcn);
+	if (vif) {
+		vif_priv = wcn36xx_vif_to_priv(vif);
+		if (!vif_priv->sta_assoc)
+			goto out;
+		ret = wcn36xx_smd_set_power_params(wcn, true);
+	}
+out:
+	mutex_unlock(&wcn->conf_mutex);
 
 	return ret;
 }
@@ -1104,11 +1128,24 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 static int wcn36xx_resume(struct ieee80211_hw *hw)
 {
 	struct wcn36xx *wcn = hw->priv;
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *vif_priv = NULL;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	wcn36xx_smd_set_power_params(wcn, false);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_vif(wcn);
+	if (vif) {
+		vif_priv = wcn36xx_vif_to_priv(vif);
+		if (!vif_priv->sta_assoc)
+			goto out;
+
+		wcn36xx_smd_set_power_params(wcn, false);
+	}
+out:
+	mutex_unlock(&wcn->conf_mutex);
+
 	return 0;
 }
 
-- 
2.29.2

