Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D465A261A5E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgIHSeu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731780AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA9BC0617B9
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so197891wrn.10
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=vfytRyIWj9sZ1Y6Pgz4Y1o9VVwDmzeiVbWWGa0+XVFHMhQ662ftEfe/xnNCbSdlgBF
         YNtKCqHg5p9RrjJkZXPMXXoPS/QhQ6qzEIwOlnTmndpCo+a/sNt8K+bRYKGdLvh2sw2m
         oaLAzdMD55kPkR6Hqxn8HxdQqyoe3O1XkLNVOiId35WEkHUaxM9H3gGUni/EsTj8sxVI
         X7UIvLBXaigqQax5r5PM0Ihrg4/oKSnFdgyvAA0SL6Ru3pHefBOSCp8tcRB/MupVkYN8
         JNKRGGMhyPdbTRPC9VRbSHnMnXS4Axy8qOG8TxsXZjw878u9dhyWfnRGyZtB1ucgP+p7
         pmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBk3qb6esZU21s8yt3ET2KrYd742m2TmS8YznjO4lK8=;
        b=s7f876VMgelzH+jpcRVi8W/9Kasjp6oY9F8qX3p5PGNFXTMFOSB/3tNme0979OWq6i
         NtgT6+k1NNCldHudzq7QuTddHQK2j4Ib9IDN3ugSeEuyfI6GP1p2KBhxoFJkFvUV6yhW
         UV2dWFlPnxlHA0apeNsAkI08+0e6TyUvDxbZjYU0ybEYVhzpW93KZOBS83rGwTaY6Go2
         tNOSsSVQ3UF+UTgY/QMORLUuhH8MBjrUm8Wo/GlO80KkZ1RQsWVd20ewfns0jIWjmZRt
         tauk0R8qorC1TA154wElNMEvhdN7+EjyQexnZjpTVkV2CA3N/85NaD0K66dvbHjjodDq
         RBVg==
X-Gm-Message-State: AOAM530ZFLgjAxmp1c5dJsvp8lQPrkQJzJcHikPKuJv0gBbKEnzYcDv5
        Ju6bMMtafxY7sofiPUuLV1+5FA==
X-Google-Smtp-Source: ABdhPJwWzTxq3WGFO6jHOZiBcCJxIIsjOWopIFtwn01+v5KJw6lajQm1vc5VXPpeMJoH+u6YoLu7nw==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr860212wrs.367.1599589468376;
        Tue, 08 Sep 2020 11:24:28 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm352447wrv.72.2020.09.08.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/5] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
Date:   Tue,  8 Sep 2020 19:25:10 +0100
Message-Id: <20200908182514.2870410-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
References: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds HW_VALUE_CHANNEL(hw_value) an access macro that will be used to
extract the channel number from struct ieee80211_channel->hw_value in
preparation for also storing PHY settings for 802.11ac in the upper bits of
hw_value.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 2da81d9926c4..ebce1ed7adf7 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -83,7 +83,9 @@ enum wcn36xx_ampdu_state {
 	WCN36XX_AMPDU_OPERATIONAL,
 };
 
-#define WCN36XX_HW_CHANNEL(__wcn) (__wcn->hw->conf.chandef.chan->hw_value)
+#define HW_VALUE_CHANNEL(hw_value) ((hw_value) & 0xFF)
+#define WCN36XX_HW_CHANNEL(__wcn)\
+	HW_VALUE_CHANNEL(__wcn->hw->conf.chandef.chan->hw_value)
 #define WCN36XX_BAND(__wcn) (__wcn->hw->conf.chandef.chan->band)
 #define WCN36XX_CENTER_FREQ(__wcn) (__wcn->hw->conf.chandef.chan->center_freq)
 #define WCN36XX_LISTEN_INTERVAL(__wcn) (__wcn->hw->conf.listen_interval)
-- 
2.27.0

