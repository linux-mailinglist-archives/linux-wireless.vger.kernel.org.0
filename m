Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A37256485
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgH2DjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgH2DjH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E85C061234
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so852366wrs.11
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gz5nCyObldL5Gm9cjjoAI5bGBbxcrE8UnaMm3PvfTM=;
        b=yhAvw0w35tHzVG2StztQGtBFWWj+pdnd7KCWqy13B35Z2J1rwMFZKsHOWIXhQAmMzW
         78Jh5t9kEE3gC8MBkhYHATVsIei4XWleRHuyPWUCcd5jsRTEVXUKmsTvhlVuXkoZLqBd
         0lglK5kdX9ScMoht1EOKG2tXnPlYnPesL7Wjlafp8Pj6lq+rkWnr7dMqsOQelY/1cwh5
         4fomDTtOC4MCAHNGYBkfEAMFUv/hxD5wzOs3VEu/n5Guphj1ITV5RmewzmE4jIFxcKiz
         wfNb+7BQJTHHC45eWZzJeVKtzWHnJ6Z8C3kqBEBhX9qj5Z0DbtOZn2IhsKX9E7dlFU3F
         31aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gz5nCyObldL5Gm9cjjoAI5bGBbxcrE8UnaMm3PvfTM=;
        b=uguLacfQMBtNiBiB9gjOZw5retSZDCsnMiwFUmV4DQIDK1XCDKoBkI551uDvz/+8Ak
         vPocAnFz8+XqrgZJHfS2T4NFejicLKDzycUcHeEZ7RqW2bMow+Ko7cd10TSD+EOWjuzW
         PqHyjj8NHSzEKfRm7ZqOoC4leKbFiv3U2kDPZRhQeibWJdnMujnFhFFM6qiRYLE/0uqO
         8y9k64jpPsi1vlCtiy2tYLDFk4HafqSyH5dudId5Fhg5H9gmE90a4bnUZTKizNwKB7O9
         CH3fubj+Kd5CPOg2GOPYJBvAOSV3HA+47+pn6Bv20UDN+APp0guDHfGkbQQTBPpO0rA4
         2LHQ==
X-Gm-Message-State: AOAM532b0cZFsu4/Qgg+woWiZBRpfsWzLWrpfJD2Gx/8+rjLGYbmJjZH
        iOTeiybGjx80FsJnAX/eaWipVg==
X-Google-Smtp-Source: ABdhPJzAGieFfHLCjmPvS4/ik9ECFgcLwdWkYeI+da9WLk2sRZKNHjWdPsaHohAtxfjby2Jfyge/2A==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr1777893wrc.386.1598672345939;
        Fri, 28 Aug 2020 20:39:05 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l9sm1732151wmh.1.2020.08.28.20.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 5/5] wcn36xx: Set PHY into correct mode for 80MHz channel width
Date:   Sat, 29 Aug 2020 04:39:47 +0100
Message-Id: <20200829033947.2167817-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the 80MHz channel we need to set the PHY mode to one of four PHY modes
that span the 80MHz range.

This patch latches the hw_value PHY field previously defined for 5GHz
channels directly to the parameter passed to the firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 729708d96586..4b967f8ba949 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1493,6 +1493,7 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
 	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
+	struct cfg80211_chan_def *chandef;
 	int ret;
 
 	msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
@@ -1536,7 +1537,13 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	bss->dtim_period = bss_v0.dtim_period;
 	bss->tx_channel_width_set = bss_v0.tx_channel_width_set;
 	bss->oper_channel = bss_v0.oper_channel;
-	bss->ext_channel = bss_v0.ext_channel;
+
+	if (wcn->hw->conf.chandef.width == NL80211_CHAN_WIDTH_80) {
+		chandef = &wcn->hw->conf.chandef;
+		bss->ext_channel = HW_VALUE_PHY(chandef->chan->hw_value);
+	} else {
+		bss->ext_channel = bss_v0.ext_channel;
+	}
 
 	bss->reserved = bss_v0.reserved;
 
-- 
2.27.0

