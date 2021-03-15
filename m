Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD433B239
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCOMIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhCOMIV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F9C061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b9so5570767wrt.8
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONHI2fbjYbzj5/3JjsXCEhoFBnrzZ23MWIBVbw21Y74=;
        b=NZ/Q8ih8IXuf5m3Kre++BHd/PI1vVkgmFcOxFjfAtkIj7LMYQP0mw7PeywlPdbUdrM
         rmX7xLZ7/h6SCrgKiNangiElTGr10No1S5a0VuuwAa4HbNkLb39OIOfyZRd9MHQXPuLK
         t7YP5hQFztyGpwDSljtgjCUB5o09tq5953LujmVt6710jO3n6ioG36UyEXMZrcoqM45Y
         twxEBqS0HvQDRX8FfHMQZaw7MgGMx0iax9wXLAA4wYcgVC42JWWbccC1AgqCWRZhus3u
         MuRHiROvXwKtJfmJJTi1BnnHbjrAlLCT4Q4WO//weaGVZ/Ym2TPQnZ4SmbWPSBBKnMvO
         G1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONHI2fbjYbzj5/3JjsXCEhoFBnrzZ23MWIBVbw21Y74=;
        b=j0M6yLSnl8cYR5iUJNM3Vkrg9TVgCC80klsjqbQjEYRlDkrR9cSPOvL/CVS28PoQ0Y
         LxUuLTItrxdWbg3v3Esuzrq4gQb8DigGQ5gjKCoskIQW3R/Xgah2F5uZr530EMhVkIhy
         ihqq8zW1lvmbGMYalNuGoNtiDefLO8td7NJcYivmiJFh30uze/ZJA6GmQeEGzk500k+h
         Hejh/d1r9uMwFn5BPHn20J8gz9EIj7D58y4BwrL6d6rXKR+IxW2FWmsoNIYmNYTMRV4F
         YN9m+2dfYZBPeH0st+EOZCN7FffdmsAhiLbCmHqirmUK9CuwCex9lgGKA/qq32yI0le7
         eBzw==
X-Gm-Message-State: AOAM530I402JhWYeaqL8TrM1ylXCfGdLkxOSBScB29hWf9LHcP8fYy/d
        fp9F40WDap9/J/72m2qqcY1uPw==
X-Google-Smtp-Source: ABdhPJz9Kn4QV0WB5CgIpS5oIi6xuU8BwEHv8AI2iFw7O5U4PKCDDAJBILX1IWEE5PrnSjBRXSCepg==
X-Received: by 2002:a5d:4cc7:: with SMTP id c7mr2243031wrt.164.1615810099476;
        Mon, 15 Mar 2021 05:08:19 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:19 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 10/12] wcn36xx: Add Host suspend indication support
Date:   Mon, 15 Mar 2021 12:09:35 +0000
Message-Id: <20210315120937.2512341-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
index a84128e04cc4..535e0d4245c3 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1127,6 +1127,9 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
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
index 6064fdef69ac..dbc5c9902794 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2956,6 +2956,25 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
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

