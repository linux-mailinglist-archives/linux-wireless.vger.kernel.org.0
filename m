Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB534264BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIJRnV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgIJRmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 13:42:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DF7C0617B9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so368243wmh.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwCebeUlM9NmAaYhyXx/fGUpE3fedfQDauBCeR9/OgI=;
        b=L3MkbVXGJPurnYM3WDW1dF3eJa47VxzV+MKyRjLNW/5JJwOMxEOp7Lvsms+/L06oNq
         6wO7i2QiP4x/HjG7VXaakOErwTgFkGWDZTbgHq1BBgPdhIzsQmhWzTZngTn8ZGwDi0cB
         t80Aw2mTdbqdjAmmy3Y578uJNHClTA/X534ct4YEKEdsoSz6HiE1ZHIaPBSrSblWj9+u
         fBMD/4e0XThL5j4zjSJBt1P0+BzuS+kumYJg1BupFawctkCQ8rGb8im5cWyE2nmS/4De
         itXIvvLLNcLuI1YpBm4xWmKwAqNAOvKzv3tD7dtYY73g4M9obxji5vWbaE4LuzjgiII+
         thng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwCebeUlM9NmAaYhyXx/fGUpE3fedfQDauBCeR9/OgI=;
        b=l+4rsBwdo1FPH6Iy6/ZaFUit61ZkdKp3Fm/ORJl+5SpBQHUO8fLXhAKFf1+LYLa6qy
         U9Qj7WMiXM2Dp7sXgpZl8JjyU/+vYtQi9TBUNzcE08/XhT445J4WnVCudOrzsA2fjlaI
         mY4j1I0XRUnYcA8ooIy6d2jcBAelo40f6+FY3aNuordN57N5aMx6luo//QXvgOPcqKue
         wLVYiBjuLBBPpQ92fpwkw8dA8EcTcoSukJ9m5b39/NPrPj3sL8/L5paxWiWw9Vd5Zz4q
         g1J5e2pYpsV0mjUCL2cd6G6rk8EBIVzO4MTog6DRxtmKjS5rjrHEXWn9gKzqC1XFWnq9
         11Sg==
X-Gm-Message-State: AOAM532882r/Eh2VZliFF6EjWd4J2hx86NorgQ64BajM74i3VYiFmknV
        /zuYCY/5j3C5XBkt+mu64wLHc0ruuEEl0g==
X-Google-Smtp-Source: ABdhPJxJI9aXfxjZE/mJPioohYp205Ok3rdrKBXqXlbuiXvuW2RQ14c13F7Z3GDoTS0xARWw++1Qpg==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr422223wmk.189.1599750382696;
        Thu, 10 Sep 2020 08:06:22 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i11sm8778906wre.32.2020.09.10.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 2/5] wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
Date:   Thu, 10 Sep 2020 16:07:05 +0100
Message-Id: <20200910150708.2179043-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
References: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
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
index 05e5e079dab3..feeb27851f7a 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -773,8 +773,10 @@ int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
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

