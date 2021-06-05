Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5BF39C4C0
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhFEBME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFEBMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:12:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A45C061768
        for <linux-wireless@vger.kernel.org>; Fri,  4 Jun 2021 18:10:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8864887wmh.4
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlPZ3vyEaLsC8b0Zd0Yph8pyULLvASpROqZxo2IdTyk=;
        b=muM5NSaZ19qh1PmVORUYJpKyCbYZpNB/w3c7lnc1sydYEOv4ogg6QCeqsTk6oxcCge
         U9bZcL9+ZzuajP/c7IqfvSQmdeHJ3hYbbyOwkb9yhiXRN+M2o1yzawUB6U1cGffiQ0Oh
         QqVL4h3of39sx+sZ0liEbjd3sdnouN1ZugxSOgCoGvXfCCtpIny7gP1UE+e6mCZZOLBZ
         Txy9OVdIcMHRkdKF57vzvJplwkiq6igDWnf++oM7VVWgJmDh5un7NIK2gkV/nVVTV7KI
         BrWVfxdo53/c3vfowaXlE3m0E2nhGAVwqhoIlX6/zQNY3hJoWmJTH/N7EOI4z+0GgLct
         ioDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlPZ3vyEaLsC8b0Zd0Yph8pyULLvASpROqZxo2IdTyk=;
        b=nBiOKmvvTiKPCnZsxtrXvE2Rw/ekhf8cfsF7Oo1AOZoz/Chj4H4DiIRTj6wCrA9zq1
         PdEy2jBSiwC+hnRVFBLKq60blPzfcaoP/zq84sWiMYjMEwIkfjo/V92x75ccAVQboG5Z
         0CFjHfXAnqvqvPn2zUih2siWcR6L3zdGv753r3Log0PHWb+o3IIKk2e3mUzGiBywOKrv
         TuTtgA9dCDn3JyjrDZvE1E+UIMQ+HcPY3KzFJHg3iTt8m33Bzkpq5Y030li6AoJyV3jV
         PHnRIAWRAz0bIjeqjpG9N3c6tkOdFu+dLyYXEg0yxxb8GlaXmdf257MR2YuaP1kOebub
         /UsA==
X-Gm-Message-State: AOAM531v78+cbTvPus+Z/+ANWyKA1Es7a5ob9YlCivnCeOlcXKulkdCR
        OtjAKq3gDPyjNjBKksyWcH3m+Q==
X-Google-Smtp-Source: ABdhPJxc43LdjHE+bmJz+LH4YvZZOQ6N8WQGk6+uaMCbHRhYZu+++OIgYFA1kzc46MkWHzNcbyRzVw==
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr6146344wms.166.1622855406501;
        Fri, 04 Jun 2021 18:10:06 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:06 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 10/12] wcn36xx: Add Host suspend indication support
Date:   Sat,  5 Jun 2021 02:11:38 +0100
Message-Id: <20210605011140.2004643-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
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
index 13200a079bd0..3b4ba6edd17a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2966,6 +2966,25 @@ int wcn36xx_smd_gtk_offload_get_info(struct wcn36xx *wcn,
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

