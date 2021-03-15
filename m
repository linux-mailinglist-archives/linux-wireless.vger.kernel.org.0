Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD533B232
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCOMIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCOMIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52598C061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so5570511wrt.8
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZ3WKCazIuoUxdRWj4Ban4JPE+r27UOCDH/EMw86Dwc=;
        b=a9K4toRB7jQlVdt6mKJ4d0L0yJ+9ZNwc4VgeWjc8VuYvomYeF+bjJTpSfd1lhb3gLc
         8veu4Wf339Luv5hxRw7kWFoIVM9L5z7lVLDskBhowx0D1+fmsyFpFkPKm/domr0nwmoq
         q9HOUoMy06yz+3/EwsKAK7G4lD3in+aqMSHp99TZVtEkkTC+OVybFjDHzTR7CApc28Tb
         0S5H3lxb89PMQSRLX6vGbsw50cQi8WNztFdDlekKABh8jebfU6uDf1U3lnS/CtDM1Qqd
         REvxIcUxmaW6jg5CxXROEcpQHtzyir4ny9/UQbZkmOq6dAxawpl3+nMGU7vLjYnaFjq9
         lrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZ3WKCazIuoUxdRWj4Ban4JPE+r27UOCDH/EMw86Dwc=;
        b=W0qMLeMkD8D4ne3G+4tUgg+EK2THyh0jeNYm3YvaLAslYnpW1ZKxqwL0bxGyzbwP7R
         J+HjrODRoB4ydBzCB8zEaIphFO+YbhgXjS+9W6ieI8kIA/f58q+o6xGyEiBh9IVs58TR
         Q/x4ItgjJ3acVduy4prTR3/kGKvMFzPXjUXp5MScuhwvJyDYvIndBtM3/OaCks+DSXAf
         YW4WG7UTf2ai811XtIr9gySdsew2iGTCQlTEx4w8cOly3rTc+uQlu4WPnQr1/rV6UvXd
         MjB1OsY9l8VJisMio1gCwne8x64219aeqC3zJ7aaaJuVaUmMqa29u/giqkW9O4LVcDpV
         0FYg==
X-Gm-Message-State: AOAM5325+U/mEgILYurrEBAOsuGhdNkYhjWGCGzgoxCMoQpYDS5LQtqX
        VCHO7D3CLy3hd9bWS7F/Gx+k3Q==
X-Google-Smtp-Source: ABdhPJzwoLtBr4Q4Y23/6vr6QYFijfbt2ww9Bg7l/qkEVbE5dZtNjIaxtA/UCdjWq7MbI6fCn5geNw==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr27501854wrt.294.1615810090038;
        Mon, 15 Mar 2021 05:08:10 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:09 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 02/12] wcn36xx: Run suspend for the first ieee80211_vif
Date:   Mon, 15 Mar 2021 12:09:27 +0000
Message-Id: <20210315120937.2512341-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
---
 drivers/net/wireless/ath/wcn36xx/main.c | 43 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b361e40697a6..c0c1ea18864f 100644
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
2.30.1

