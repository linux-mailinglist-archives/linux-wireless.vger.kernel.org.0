Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDA465FFD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbhLBI4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 03:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356569AbhLBIzG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 03:55:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E57C0613F9
        for <linux-wireless@vger.kernel.org>; Thu,  2 Dec 2021 00:50:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so58064602wrr.8
        for <linux-wireless@vger.kernel.org>; Thu, 02 Dec 2021 00:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k7FGcIcMATtGAyJayOA6uq5PyB683XzDF+2NpZuNmHk=;
        b=GfGwLr6iegfmxDOZhQbHS53E4W6ystqqLDihIXytNFl4b7z885Vkgg+vAZHmOvgUB4
         9IeTP/i84FuSZgzsk0IWpa8UdSmD16rKWBrzLHhW+R9QsroT3/j9B9mpWQCnCRI0qT/i
         5CLQKw6li9Cv3JnK3JBlIWqkc6He/v6T19zJkMV/6EmSVGLHE7r0SNFzraSKx3A7yxer
         NCDThkaODTfV5IfkTKoV8i8gbmy+Al4yo7CkVZU0RfKnxdxMv1Ba+hl7VH8SAt0bT8VE
         f9hvkIndLNjZEmIN6jWxY8SgWOxISi8XJ8NsRU7G7DAENTwvFefDasT97CTRPXlj7NRp
         ex5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k7FGcIcMATtGAyJayOA6uq5PyB683XzDF+2NpZuNmHk=;
        b=rc7qxnTSQvW4U+Gj75AzzFwnlVld07oZDqyn5WIoavXgHARyf8gNAFY8jquirf5sV5
         ubRKslBOjB9dX476hidXK/dJ4QVXbs33x9h7YsNrD6FU57Kl/LX5nHbaFJM23M+nHWwS
         34a73dEUh4gJbJg8AXFvfbsO031Uni/tdMNVP1Cy9onAd8oBpBobEAlqtN/b3J/3cH4F
         umdgslbIVSBywjdUXmuN0mNruPfoOLMVWK+DNspG3xSEJmdSgti5YIUc5ktKDJTydHO3
         xq05paABYIVCkiVGifBAJySge5dJt/fu8rSjIWcgxC+2UuEQF62F9GqXO9Yf+hteaPCH
         cCXw==
X-Gm-Message-State: AOAM5339lUN4klDfMXg3g6WnkXZ3TkTseKsK14KYqyJuBjtIr+TBe/DI
        HYh/iVt5ois8xhPqQWsoXYK4GthW+4mHVHnq
X-Google-Smtp-Source: ABdhPJzHM1dX4f+KTH5ZThYS3A/TnqLriH73kCliNw1NSKjBvcboJqi2rCBLAs+O93bVg1b+5QmA9Q==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr12722200wrv.400.1638435001222;
        Thu, 02 Dec 2021 00:50:01 -0800 (PST)
Received: from localhost.localdomain ([88.160.176.23])
        by smtp.gmail.com with ESMTPSA id i15sm1723519wmq.18.2021.12.02.00.50.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:50:00 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Fix max channels retrieval
Date:   Thu,  2 Dec 2021 10:02:12 +0100
Message-Id: <1638435732-14657-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kernel test robot reported:drivers/net/wireless/ath/wcn36xx/smd.c:943:33:
   sparse: sparse: cast truncates bits from constant value (780 becomes 80)

The 'channels' field is not a simple u8 array but an array of
channel_params. Using sizeof for retrieving the max number of
channels is then wrong.

In practice, it was not an issue, because the sizeof returned
value is 780, which is truncated in min_t (u8) to 80, which is
the value we expect...

Fix that properly using ARRAY_SIZE instead of sizeof.

Fixes: d707f812bb05 ("wcn36xx: Channel list update before hardware scan")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index ed45e2cf..900e5a5 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -940,7 +940,7 @@ int wcn36xx_smd_update_channel_list(struct wcn36xx *wcn, struct cfg80211_scan_re
 
 	INIT_HAL_MSG((*msg_body), WCN36XX_HAL_UPDATE_CHANNEL_LIST_REQ);
 
-	msg_body->num_channel = min_t(u8, req->n_channels, sizeof(msg_body->channels));
+	msg_body->num_channel = min_t(u8, req->n_channels, ARRAY_SIZE(msg_body->channels));
 	for (i = 0; i < msg_body->num_channel; i++) {
 		struct wcn36xx_hal_channel_param *param = &msg_body->channels[i];
 		u32 min_power = WCN36XX_HAL_DEFAULT_MIN_POWER;
-- 
2.7.4

