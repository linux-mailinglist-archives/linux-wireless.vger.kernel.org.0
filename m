Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8181C2630B8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgIIPjM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgIIPgP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C0C061348
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so2823140wmb.4
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bt8Tpyo9+uK9+uEwdNPTeV0vFTeTDzA61bzY9RGScBk=;
        b=TMXzdi0wCRf4hKgmK5t/ZwcD6+/6c7iCEsFgriLi00G89djhGOJw5Dk663lc9aQhq+
         8/SKK+39/9bDDqEZnSgyzhsr4L8mTjOtcEQJhXYDHkuHTPhPQugNVWYGl38KkM7QLcsQ
         6IH0mWXRYqo9Hc5zQFAEV+i9Q7IhJAhaAUSJPgBvowDkSncOyLBpCCkVutZ5lSzPSLkz
         aY5pVKRMgwW7t3S5oAIcK0Tbj5W8QxftN/WQvs5rQvfcgwul1lCHRYEDxdcSj/g9Lp56
         NGI4XVl8ZPwAs6PvyxWo5V3JmVEP6+JL0EgEXY7D+vhKParrqVr5L4YDVeh17vPaEM+5
         s5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bt8Tpyo9+uK9+uEwdNPTeV0vFTeTDzA61bzY9RGScBk=;
        b=Boc/H10zJQB+2Kl5cQkz2nrCCFIkfy/2iUMfNfa1q8WC0AOhoyjm6Plnlt7EnsfIqM
         YlFFqERywdGB9y/yFryudbmyUA6g3b1gimB1wwCZ4/q0/47t3gwTZ8Ks2Ez737zssE43
         CJN8xh2oQy7HpTJmJ1ZmI6kbIyTG5O0dZRG+arymEeXv00ae39PbTooSd8t8bAzE/cpH
         gFTdSnVPNNRu+XNAuyq4KJqmYARIUE5Rw5KyY9/GdOr2Q6O1D8rdiXbSQqSvVO9MmlHW
         ZMCrr1wI9f/0jIzQcVkIJjxnU5P20zNrBxOQc1eYtcIdIBr+B7eTJ0BaODREl3l0MMQR
         xUTQ==
X-Gm-Message-State: AOAM533GXvpnczVqR4D6oxyuJ1jG6BEZmEqtJna55UR8PSwf3mRjxLdS
        uSwPsaCbiWDllRVqNhhhLJWUFA==
X-Google-Smtp-Source: ABdhPJwBFoLdgT35KDHIJzm7xrewNIq9qTf1OKaDycVsrRNk8RotPEDHcLl80CYeyknzOZZUNZVCCw==
X-Received: by 2002:a1c:f704:: with SMTP id v4mr4145142wmh.4.1599665773319;
        Wed, 09 Sep 2020 08:36:13 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v204sm4619807wmg.20.2020.09.09.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:12 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 2/5] wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
Date:   Wed,  9 Sep 2020 16:36:57 +0100
Message-Id: <20200909153700.2904977-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
References: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uses HW_VALUE_CHANNEL() to extract the channel number from a
struct ieee80211_channel->hw_value. Once done we can use the upper bits of
the hw_value to encode PHY related data.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index ce6536a3185c..a28bf52a60c5 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -760,8 +760,10 @@ int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	msg_body->num_channel = min_t(u8, req->n_channels,
 				     sizeof(msg_body->channels));
-	for (i = 0; i < msg_body->num_channel; i++)
-		msg_body->channels[i] = req->channels[i]->hw_value;
+	for (i = 0; i < msg_body->num_channel; i++) {
+		msg_body->channels[i] =
+			HW_VALUE_CHANNEL(req->channels[i]->hw_value);
+	}
 
 	msg_body->header.len -= WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

