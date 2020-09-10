Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB92648AB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgIJPYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgIJPF0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:05:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2601C06179A
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so7042867wrl.12
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7OETVLDh9JWcogSM8CDzEM26oQ0pGJijOBeVJ880zs=;
        b=VgXQxDJJradt6PJ+rpPriG71cFDgg04zrawTaOr0wQGs28wSCdRy6a9jMPgJFTufeq
         gQmZ9yqbKxUKQ5ZtrwTuZsItIbSjuAC3b3Er4JPLZfKB205+Sdudrf9tLveLx5baghF8
         xUzeRMBq9gukRX+390jzn4t6aNPINlMTG5JZwJ06uM/Xl/G5xqLbsluD03kVRqMZ1clt
         vpwizbxuT19pzxKnGI+Rs/rEQ1vqcCE/YzCQ96IaYJapbL7j8xFJLx3WI5RQrHHR0bYW
         hj8JYBFrzYyQPwQxqDbIqRMIy9GdRQad9ubUW1/4zowORaqAnyqetIyY1dDz4XmWWHSW
         FGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7OETVLDh9JWcogSM8CDzEM26oQ0pGJijOBeVJ880zs=;
        b=L4jTg/wOLi/n500WNbnXTBaTe83bY5YhwbMsNwMUYUT2o1SHFN+QkDXzc62EwBrhBR
         pHyegsBaqUDE5rCX9mEzvGRFX75rW7gA2Ro0/U6gXzsgTyvwQVZDdK6Jg5b+AYqF2YkD
         owa2Z/f+g+4xVGK40c/84yWNDn1mZGF+kArTmPXe0ZitAaagpGZDpvUV1/UlI1/TUJVg
         EeBkR+KDN7kFUOicp+T9tejo3FF3ZTCrona1zyqkFnhXEVOMeFGB1cpgERAB8mk2gcRf
         +yAvTQFxZuYSeIuRuxM0A+qNTn9xwPVUtC3LOYRvUzOY4BytF4cr32OBAFCJuLt1Yre6
         uuYg==
X-Gm-Message-State: AOAM5328uS0JXkKEx08soUoaWYmS0KVXO2vMifD4deRq2dwk2K2KOV0d
        MGrnVPT70UmBxWeRFh9Vm5V5Yg==
X-Google-Smtp-Source: ABdhPJxdTzHFg2dNDzSnltVUbVyOFhFAS4b/miIRWMD1tkzilNTT/H5qJMNHwFYK3IYFnEvy9fNBiQ==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr9492606wrx.24.1599750309722;
        Thu, 10 Sep 2020 08:05:09 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:09 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 5/7] wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
Date:   Thu, 10 Sep 2020 16:05:50 +0100
Message-Id: <20200910150552.2178882-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds a routine to allow setting the LDPC bit for HT parameter passing
inside the version 1 STA parameters data structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 1432f310f758..ab9b6116cc75 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -199,6 +199,17 @@ void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 	}
 }
 
+void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
+void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (sta->ht_cap.ht_supported) {
+		sta_params->ht_ldpc_enabled =
+			is_cap_supported(sta->ht_cap.cap, IEEE80211_HT_CAP_LDPC_CODING);
+	}
+}
+
 static void wcn36xx_smd_set_sta_default_ht_params(
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

