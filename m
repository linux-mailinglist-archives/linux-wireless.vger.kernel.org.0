Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68F397622
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhFAPKV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhFAPKQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1663C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q5so14717144wrs.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7tgQqGtDFs1RDJ68kf8vBszyeLOJelji2axp1aENbQ=;
        b=MpsmmDjyujoAEL7TQVSjXsylzBeOrzk0pG8I0ioGr/FwgfXmYzFGl+j/tHWyp7s7eW
         eBgw8D3+rbXlBLEh1NfZUOc+k4RxiWgKcvQx1Xcdoyw8ezo1cwR1TvCIntomq1LEVLeL
         AnZjMc4xuC1qUxiZD2wRZEtD75AsSqrZijWnqJif3fbj1aXOeSRnhHoABGxq3p4N9Asz
         8rgN6l+dHw1beIwqBl14gD/KMUGMrpe+MsJAaA75j/UwXjAmEB7ZGvdsQlGlrGMlWt9G
         SFFRpMqkAnzM6zdZg9FkEMP+OQZDalcgqqq+8FjKOeJ050kwPjaZ7ro/JlOl2Mo/0ol0
         8bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7tgQqGtDFs1RDJ68kf8vBszyeLOJelji2axp1aENbQ=;
        b=fqJ7DfSxXiwxGZC9Fjv0f6GD/NkoSwaZaRohbdoLLw7+ajhLeVyb4p83kFBqQ9yU2E
         tLWO19GVkD8gYNGsGRilrt67ioEdeidLl/wSABjlEporCOpNjTR79vnw0hDxw0Mi10Fr
         4/O4mGIfJ8PyDEo2Zxfqr662bVfEZnnyb3TlJySLptVZwHKDVpl+iWday8C9I0LCneLt
         sLP3udsKyyW319C6EPRcYjqtTV9Lwi2IuGjuWDyKaRfeDmYNCCwm5i+MpaK9czQNPaOE
         lU5XZJpyTAjjyG5B8C2vkMpE1K/GxWJQ7VdGMZyGpS0MoVX+1lay83zPexqa++Whh3Mh
         JMSw==
X-Gm-Message-State: AOAM533iFHwY7uayezNCb9ZxR55WOChhpHdMe+7nfgnLzwwZqiLruFsC
        LyKZlaSYnLztjdr8IRT29gTrSxyrcxzCeq/d
X-Google-Smtp-Source: ABdhPJzc741143oOEtI/dX8JEndNk6fwrlIJBkEA9U8mASZxUa6EgBLad0cAxp1GVaazhjPpbQAqWw==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr1761317wro.187.1622560112316;
        Tue, 01 Jun 2021 08:08:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 10/12] wcn36xx: Add Host suspend indication support
Date:   Tue,  1 Jun 2021 16:09:59 +0100
Message-Id: <20210601151001.1450540-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c |  3 +++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 19 +++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 8e5d8326d551..e4d5e4d597f9 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1125,6 +1125,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
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
index e249971c4ef7..302877d23ecf 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2964,6 +2964,25 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
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
index 90c7faea0ef6..2909facdb100 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -159,4 +159,6 @@ int wcn36xx_smd_gtk_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
 				     struct ieee80211_vif *vif);
 
+int wcn36xx_smd_wlan_host_suspend_ind(struct wcn36xx *wcn);
+
 #endif	/* _SMD_H_ */
-- 
2.30.1

