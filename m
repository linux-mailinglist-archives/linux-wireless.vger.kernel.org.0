Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49093261A42
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIHSeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbgIHScz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC89AC061799
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so303534wme.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvzZFSwrpgxQ+WGjQnmFyunvxfM/MsB1Cn6EiHCvmSY=;
        b=LTHB9KCJE1QUX6RZrRuw1GYy4xlUDUeqoywhh/tA8Jc9cINXN7UARuLYNdBTwe449u
         OpBTNnsUvGxfYfA2KvjxqWj4J+k+LcvMDJ5jvtbMHjvu1v8Oirjp0UVZTibtH8gtfHLE
         BjGJDO8O0bydjsQQa9d87Mmmrx+ODTZEHXPH9mVWpLrCJomhltz57Pmz45H1+NzgFaKY
         quPSNGfklDg3e3YXHv7mq5BUE2WmXYmuoxtP50ZmbyHuCa8BhFhCogQ4mCXnZTSAG/R+
         /e4UBhBr29vruFJsRcBSWaYXAuec2wPOen3rIzmUBbeyPvFw9KuEsoJ6rD8WMPACr1Yt
         EOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvzZFSwrpgxQ+WGjQnmFyunvxfM/MsB1Cn6EiHCvmSY=;
        b=fAUJcUXHTUQJx34fHxdR80paHawJcH1RT99CZxU0U002Q/79WLE60+o5oRbo4iujWs
         dRCiG84dzOHXKWnR6SV/4H4+VXHXPV6KlS551hqAlIot07qLljt6pUUdVRSbdV8e0KVI
         YoE+968KY/5zHM7EQ/cqkBTZQVkJzzDs3c9C8qAdbmP3P20EgCrIXFni9o2ZWkmt3bxD
         vUWdpabQKKTSCRRFWLLYaxba2R94x6vpDi3Wm4eK0qLVPoy/EILEccdDpx9xvnHw7aPf
         UU5wxXfnGcj2pivHeyOTC3iVrfWdDk7ogqHgqDOJGar/RY4t/Pu6g4lQj6zDie7PvbTC
         7VxQ==
X-Gm-Message-State: AOAM532dzf9oRltT2I0rHORnzfIO+TeqoU3XBklZR6hib4D9Z9uSNfkl
        b2FsqoIHRf79vlIopvyqzYb5KQ==
X-Google-Smtp-Source: ABdhPJwvTrPDuc0XXgWWwBR9bVnejwWI/m88kFgrrbZlpAeI+18A7QOo4Yztl+ApedZr9n9ACCJm7w==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr416670wmg.0.1599589433441;
        Tue, 08 Sep 2020 11:23:53 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 3/7] wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
Date:   Tue,  8 Sep 2020 19:24:33 +0100
Message-Id: <20200908182437.2870281-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toggling the LDPC enabled bit is possible only via the extended V1
data-structure. This function provides a means of setting the default
depending on chip-type.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index bb31c4d4d9a8..3f57acfe11bb 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -206,6 +206,15 @@ void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
+void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
+{
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		sta_params->ht_ldpc_enabled = 1;
+	else
+		sta_params->ht_ldpc_enabled = 0;
+}
+
 static void wcn36xx_smd_set_sta_params(struct wcn36xx *wcn,
 		struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
-- 
2.27.0

