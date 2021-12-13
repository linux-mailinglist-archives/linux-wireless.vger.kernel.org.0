Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37759472DC7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 14:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbhLMNtZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 08:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhLMNtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 08:49:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41912C06173F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 05:49:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v11so27121795wrw.10
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTYixfrhf6bWN82g0Fi5qU9LAYUUaPAtaNL6sw+Jd4U=;
        b=UzkP3u7mSRzndezO5s6DIfYjheCQSdCtQU02g3Q5ETtGqScOMlm5VyzNoy9cUiNM6i
         vaV5b0J+kpEicIiBgpHVFTqJdXYVavg8/2ClSQpUBmZIB8i+3KlSl44I7u/kQLYL1bln
         wAu0+ith3OH2xkKQ6LINlR35Zv2FdwXYZwJONimN0yVstrcDg8bICGoU9rAb7Nvksh9U
         R/jBBC2oRQq0LRZ2AMaIXkA0hwT/Or4zWE3msLK/kDhKK+xoScvB22JH16TcbOZmMbpa
         5Egll1Rbzgh4TjkHx8186xLo+dmPSFqQapSaty8SQmevV/y4/4rncvu+oif0qof18jy7
         2abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTYixfrhf6bWN82g0Fi5qU9LAYUUaPAtaNL6sw+Jd4U=;
        b=odu4xQbw8uFOMOlK+jgTPWMp/CIPI6sDa7fLtz03EyjgGaXNbGyxGdsqxMFoyC2vnU
         GqU2guTiDahYsDDozqbrMg/HWrqJ+XbP0uuwC0s6Ng8XX3Dwex+fdE6K65pQMuQ8izpt
         P6Xg9M8rtIeRuyzaDYyCpqg2y2dwUkIvpTRcPGHmIwjgv/gpgapEaDPoakmEVSyRLT9c
         bUdk6nC4mpOKe0TDVgARgp4P9cyr/7zSzAFUcsoAGpKxxE8G1n9yY0XmIRQxLyEwRWQn
         YYGPt1QmJWMOTPQFi86tjMpF4qqtNGc+eJZ2GcLokY0Xez5u8TKJztYrJ0Fb/NsP/UrN
         Sxtg==
X-Gm-Message-State: AOAM531UazB7eFG8SjICYfpBUg7JkebTOtaVqGgeTpf8GRa2D4ofeXEv
        prWzgcsaA1G6I//B7vT6Icq8zQ==
X-Google-Smtp-Source: ABdhPJwK6y8wWUO3a3CYfX2jh280i5UfxSv4TZuelqWNn5LWM0hWXZ+LUPFZxc2v+BpnSFWIvbUWOQ==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr16979001wrm.684.1639403362897;
        Mon, 13 Dec 2021 05:49:22 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m9sm7366621wmq.1.2021.12.13.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:49:22 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 1/3] wcn36xx: Fix beacon filter structure definitions
Date:   Mon, 13 Dec 2021 13:51:25 +0000
Message-Id: <20211213135127.1656258-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213135127.1656258-1-bryan.odonoghue@linaro.org>
References: <20211213135127.1656258-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The beacon filter structures need to be packed. Right now its fine because
we don't yet use these structures so just pack them without marking it for
backporting.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 9bea2b01f9aab..9bce71592f743 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -3469,7 +3469,7 @@ struct beacon_filter_ie {
 	u8 value;
 	u8 bitmask;
 	u8 ref;
-};
+} __packed;
 
 struct wcn36xx_hal_add_bcn_filter_req_msg {
 	struct wcn36xx_hal_msg_header header;
@@ -3480,14 +3480,14 @@ struct wcn36xx_hal_add_bcn_filter_req_msg {
 	u16 ie_num;
 	u8 bss_index;
 	u8 reserved;
-};
+} __packed;
 
 struct wcn36xx_hal_rem_bcn_filter_req {
 	struct wcn36xx_hal_msg_header header;
 
 	u8 ie_Count;
 	u8 rem_ie_id[1];
-};
+} __packed;
 
 #define WCN36XX_HAL_IPV4_ARP_REPLY_OFFLOAD                  0
 #define WCN36XX_HAL_IPV6_NEIGHBOR_DISCOVERY_OFFLOAD         1
-- 
2.33.0

