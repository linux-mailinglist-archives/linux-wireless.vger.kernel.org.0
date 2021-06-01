Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B82396B96
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhFACta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhFACt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D903C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so553156wmq.2
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7tgQqGtDFs1RDJ68kf8vBszyeLOJelji2axp1aENbQ=;
        b=AVGYpXFbDaAJdRho/4pg7qfMPZvEQIPAHvwvnEi9TenBRbEeqp6VWR5NndblkL4gKa
         nfnh8/BW0w849hdul8AvTOrp+M/PUszANqWRfdCumGrDcvzkwb1EbpkEOmB5GE5iyTC0
         +Z+Q0+Le2/9x/35xQWKWH492L95mUhKWJcQ33BJr4842zbpoXK/2RmMtH3tKdZpQVmx5
         sM7bbdTH3vvw3F96nJ16YEkN/WQ3yBLPq77OtmK6Mj6xX2WszBmvZLYohqTtHGDl9hig
         ZpRQM8hWCE7u77SNgWl4Ettg4IOAYyCXFjzZzT8TmPjZFhQuS6HUEZX/byEOCM/wVeDQ
         dljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7tgQqGtDFs1RDJ68kf8vBszyeLOJelji2axp1aENbQ=;
        b=TlJapx/F4DwQOjXU8qiLEyCUYer0FcSc2rdUKrLIi7X65Wmy76WuttiKJPBe1A+O9v
         gDBML6IBoLLsr4K0tHUls3nrATswaWEuL1RS0LDSYlW1CsrAT3L1DETqzYzs+TMwW2aq
         LvcK/opwxVCxBVIrxal7NePT1yUJzgrVg8+odVlYJsAJpRUpz1hCRBisggd2YO/R7MQR
         lzIr5E7aeQ3TOG+jOA2QTF+iMS6B11xv9tGdquqbmbhSjghkZjXyU7ujoqyLaRRpBmnw
         jHAbytqU/JNUMRWw4/Yubu6ZBQ77KrbpsVwCUawhHd1OGUHrO68q4XCmGnKEMKU7/GFw
         eYFw==
X-Gm-Message-State: AOAM530Au4VHJGF6hCOxn6OL0QQzS0FQymrBRhJveXY/pSW5PuJYeglu
        11a9wPSyITqrKWRDRJh74hnjKA==
X-Google-Smtp-Source: ABdhPJxbHh0K32fdM5e3MobSHmSVDv+JdHYCiE9oWAjQDbtrhgFH7VcfRypZ/iBunaJHX42C9cCX/A==
X-Received: by 2002:a05:600c:4f15:: with SMTP id l21mr23688001wmq.37.1622515667331;
        Mon, 31 May 2021 19:47:47 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 10/12] wcn36xx: Add Host suspend indication support
Date:   Tue,  1 Jun 2021 03:49:18 +0100
Message-Id: <20210601024920.1424144-11-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
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

