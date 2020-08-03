Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED0239DBF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHCDLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgHCDLU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC966C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so32795330wrs.0
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0MUmRNnfJhqzV4htTrjwxN3KiW8rf6W51Q4u6sP/f4=;
        b=yJSC1Hm+ZkvCnyrpM0d1nYzEQ1c381CKbRUyCPL07S5o4w06eRWjHCCfBkZwFivB0A
         WGrlIU99UHW+viSdK2N5xqXWQqZf2tVsCK/uwQUaHc970LvJZ9fE4M6OY4dUMgf05SzL
         kj+EwyZtpIOaV+1TvLce46xV4HproflPrfT3GrnblyYgkDhMLJUMD71GGmgAsOONu1aV
         rwLEpRcXnBC6kMRmTa/CT6KRvENNZDUwQHJwdmJS8PvBEPVJqVq7RZrPcpT5LaEkfdYc
         tQ7Kllwrlrh8thpoPr+9bGV7kKKyx41vAS3tH5xkEjZweDsr0svgXmJBxmZDx5MkVULr
         w3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0MUmRNnfJhqzV4htTrjwxN3KiW8rf6W51Q4u6sP/f4=;
        b=WuF52VY2/kvqDDvRHVTtyDT7MST++GEz7a8HAErlxWHmTbQ5QDwIyYIC7FbuUNvx81
         ZCL9w+8tIZW23eo+fT757FQPCoStGDEmrYwdUYOWM3O4mDPwsIRxmkVLHOZU8XM40RkN
         BSviJcuAPNkRnBKDGi0NZg0aAgKlNrVTnPWtuBgCvKfT3GOj8VVs1jdnPuF6FwynZ8KE
         eOShWGsf6zwzVtGbBa1i1uZ7//hBIYYFyYbttm/kcCsUdpLGHVkHMIw1bk4pnI52wDyf
         eJXwVlbvbtRAZvR+osxn+Xh7S/3GBDm2Y8bx1wAB82fy1CsBcdjhQo0djkbTYHIGv9wM
         aVZQ==
X-Gm-Message-State: AOAM530ywgpT54hhIyhR0tuH3DgZaUa5OEr9h9Pmni86ASt0WFfyd/KH
        XqQ8LVHHck9Npmr6DANzLYGGTw==
X-Google-Smtp-Source: ABdhPJz1FGg3rvHQKcIz6n0WqMd/bhjf7ve86KRnI7hDwM3F9ikgisZoe6Ly784hrExVQAUHYt/hrQ==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr12845030wrq.319.1596424278690;
        Sun, 02 Aug 2020 20:11:18 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 30/36] wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
Date:   Mon,  3 Aug 2020 04:11:26 +0100
Message-Id: <20200803031132.1427063-31-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index cedf4391a69a..9a7e6f96f0b6 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -758,8 +758,10 @@ int wcn36xx_smd_start_hw_scan(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
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

