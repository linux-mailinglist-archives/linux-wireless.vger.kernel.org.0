Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5630034218D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCSQO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhCSQOD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D68C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 12so5757163wmf.5
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gigI+obh4OgQAHcvn4ct7jEpV5/6/PU9YOe1h8WyUL4=;
        b=yVCuNnhGbRNZgUToUq8Y6pXPRQDfLgcKxQ87BQjtNvri+d363NoDhV0CLGWYBkDFWV
         qgjZGJJ36ilzUw+VyWjEhLD5biIUzjf74QBHp173bn6Hj/6rgucsgiNwUo9PAsEKB1Fc
         D5QfRR1G46EbW3PMbf4q4jBFSgE6uD3NeJej16mET3WOgkCtgqvH6+JgSidJ8cGwJve3
         39iScW0RpBnFkjxcESbixqmctO1UGDk1Ub8xIM5Ti6VLZlHjccSsLbq5z9Kv79FhPWnP
         ZbSHAjUXJtLNR+tKwqSz/hLLG05GI+G9dQcKIOexTvnhhxHFj3ap13MmbzHRZEpJxXwz
         Q3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gigI+obh4OgQAHcvn4ct7jEpV5/6/PU9YOe1h8WyUL4=;
        b=mJNe/92N17Jp+RAX+Lo/RdLMKReDg05UmjBJrs3+IMUC4HSXdctsStzpCbaW5JEx5U
         nQPOQ4HVMOBBEnvmoTEAogwe9zNLBTXC+1YOca8RCF0PTSYlQZPHM43TLA2odoGxWsHB
         xWu4xP3MjS+tEbqcqBpiDvW0bsgsHuuxl10H6M2SomlpWMeFIfiBK+HW668kdTCqnWkd
         Or1s0QG91+XH/XePia5+8GjJuwOuvdMI7G5xPyNgec1pH0shMGHQ4ymggsMyzqY/ac/b
         JB79O4qTZF+G233UCxPKpQJl7ve+TmvUnZgFHeCYMl7VKGMaduHmVLNbEuGR57uTuqgm
         niDQ==
X-Gm-Message-State: AOAM531H4OFfLTnzyP69NkYba3wqmupX46oyoP7w5UGZM+p15DMDa9gX
        v1Q8MrIOH7WAraxKn6QnEDzPUA==
X-Google-Smtp-Source: ABdhPJwwTWMOyp9sCdSPi7XtacVkBHgtZI68V9E/LgsnYwQYUAH7WPKSJonCUntxfTIrTk9w3aRjZQ==
X-Received: by 2002:a1c:43c5:: with SMTP id q188mr4337744wma.94.1616170441863;
        Fri, 19 Mar 2021 09:14:01 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:14:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 10/12] wcn36xx: Add Host suspend indication support
Date:   Fri, 19 Mar 2021 16:15:18 +0000
Message-Id: <20210319161520.3590510-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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

