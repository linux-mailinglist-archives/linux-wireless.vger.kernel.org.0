Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25E2E67D0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441835AbgL1Q25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441825AbgL1Q24 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522EC0617A2
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so10199072wmg.4
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/sf0TvCOSTx5tivsY1tuBdXidg386Du0OJP+4zFzuI=;
        b=Pj7YzXBBXro5Okt10fjB6pr1awWUU5epPF2T+flMBEuKCBKkDyiw2D46UhDr0UCC14
         JKSkJVjCfcpJkkgr9Z+q1o4Oimy+OAk+OA7i1gyRkFgJPVj5vczFKrz6GgdCR8zAEPj1
         DToBAE8FSA5yhdibErba20LK17cloNGREz+iDge38L9w6JIbt0AAuBqAVybD9fW2oqTO
         HHsKQOhn6Uo1zhaEnGZXrrBMfl6cZfHPql61r/aLY8Wsi60Z4/cePcR4ju/H7/J8DeoC
         azR4Z0hdiRta45ydB8TcOxmWlxtlfOEQHaJHJbplBgzgOsuIgVdWyvgZvdFEEvIFVU0L
         yShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/sf0TvCOSTx5tivsY1tuBdXidg386Du0OJP+4zFzuI=;
        b=fb6AefKXomce29w9YskUB9VyvgeQDZtz80Jy3Ixt6FcQEqozliD3+/nLIgqNW5pWjK
         K01dDvjRTEhEKSU4cBC1mMFG7dYVY0F8FIZTcBwNNtrr3LTZ+9QuS0rnXFdUF5rjmWzy
         47Ns0b7/7MzzWPU9LSPSpqiEBeL4qqlgulo24pduqSIG27AXOu7SytPHHvX2aA5/JqsQ
         5lUnPto9BCXcnuDhlbHKH+TerCH3E2C85y63+DTiFrI/1YX5mTu1XeYeLlgXHZBcO22Z
         ARbzAjuESRQubk5BRyOmvalCWfKIePtwan24JzlNrvKEYBdLsl4nqxjZ7s6gbQm1Sy4+
         54yg==
X-Gm-Message-State: AOAM533E/AQcnV07PjhhNwQp3Pp+zVrXZe/xvEOrldCwMUB/WcA/7qZt
        bJf/RuWDQAGFsc9U+/y8NcCmgw==
X-Google-Smtp-Source: ABdhPJyAG2ybqZDxZWdKoAVBjVyCgWxzkbRjHLwhR0fzZFMwkRN+y2nfOOXqNDAVhCde2oH1EtIj0Q==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr21524744wmj.115.1609172863690;
        Mon, 28 Dec 2020 08:27:43 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:43 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 12/13] wcn36xx: Add Host suspend indication support
Date:   Mon, 28 Dec 2020 16:28:38 +0000
Message-Id: <20201228162839.369156-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to activate ipv4 ARP offload, ipv6 NS offload and firmware GTK
offload we need to send a unidirectional indication from host to wcn
indicating a transition to suspend.

Once done, firmware will respond to ARP broadcasts, ipv6 NS lookups and
perform GTK rekeys without waking the host.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c |  3 +++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 19 +++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index feb909192c8e..ec24b0cc5b8c 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1134,6 +1134,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 		if (ret)
 			goto out;
 		ret = wcn36xx_smd_set_power_params(wcn, true);
+		if (ret)
+			goto out;
+		ret = wcn36xx_smd_wlan_host_suspend_ind(wcn);
 	}
 out:
 	mutex_unlock(&wcn->conf_mutex);
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 378282a93aa0..5450d56d8e1c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2970,6 +2970,25 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn)
+{
+	struct wcn36xx_hal_wlan_host_suspend_ind_msg msg_body;
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	INIT_HAL_MSG(msg_body, WCN36XX_HAL_HOST_SUSPEND_IND);
+	msg_body.configured_mcst_bcst_filter_setting = 0;
+	msg_body.active_session_count = 1;
+	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
+
+	ret = rpmsg_send(wcn->smd_channel, wcn->hal_buf, msg_body.header.len);
+
+	mutex_unlock(&wcn->hal_mutex);
+
+	return ret;
+}
+
 int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 			    void *buf, int len, void *priv, u32 addr)
 {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index 3488abb201d0..77efcfa145ec 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -161,4 +161,6 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
 
 bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn);
 
+int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
-- 
2.29.2

