Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D003D2A12D3
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 03:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJaCWX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 22:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 22:22:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF0C0613D7
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h22so4514468wmb.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iv7B7K7D9VvHbxmcBfln7lw+K346+6hhS3Q0IcSwxLA=;
        b=zTwXUj+G2qv/fQqxFYuW5c2qUvkoBjMpU7dOnOaHhN3StBOfUHARx7l6Yc7E3GjkZR
         4uvhV6okFZ5S/Dbrbs+UwS/kHHCELD23R6YtRuPSEDh+ovm2bN9ePC67/Wmy52mCaBNV
         BoarhzQhWYGhYBb9/bWrclkvka2KuMf/To0s5BlI6sb3l/SinLEhobYC0SE/Huz6dZXw
         xRzuRjLMnEz/5Rh6RIiq0f369VMBF0bXCyccGDMCcRpsAgHgnFrX3jXCyxdbli3Uhwwt
         lWvKldyrCD3tkRokMco65YV0s89Xeq0kiDbzZVuta0lRdoVS8ERoWJMdJGd4EUtq08JC
         CJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iv7B7K7D9VvHbxmcBfln7lw+K346+6hhS3Q0IcSwxLA=;
        b=n78WScVARPqOWfkFR8mwGX+NKkGtMZwkLct83bo8KS7BUZ+JtdqlmZKY00/6HLlh/J
         fWf9MaXWZ1t/CEGQNT+Rtq07Xwj6b1GN8G2yKjQr79opWskIUY0TC4M0f4N3SjHzHkCH
         8aOTo9VsD/M8mGXrfau6rk4IXUPo+vV/2yDGBW4ytb6/X2LnDeB1H4unE3OzxYXy2g0z
         SLvdAtPSEZIw6nq/ZyDJoVOacNns8z9vXtmjeprYWNWws7EQL7DrC8qVH/vj0tuH1d65
         xLnIW1oP1Ub7y9vp+IElhLZGS50ak2+YcGngYOlDjyJBBc3KfMqy5kYSmAxf5yg6BqMZ
         HlPg==
X-Gm-Message-State: AOAM530y1AJqhklPoP7rEKrCllcxtL2emrouq30BkCTQhzSNKcQty7jN
        RIP/5QtPVXsoUKw00AC5HRSi/SMpOy+lAQ==
X-Google-Smtp-Source: ABdhPJxhfCa7OyIrcUOM43R8RxfteP6uk+3GBqtKm1I3MEid5WvSin7nL/lMo4HnzRvJiw0iWBSYIg==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr5898465wmj.77.1604110940521;
        Fri, 30 Oct 2020 19:22:20 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g4sm6663817wmh.13.2020.10.30.19.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 19:22:19 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH 1/3] wcn36xx: Set LINK_FAIL_TX_CNT non zero on wcn3620/wcn3660
Date:   Sat, 31 Oct 2020 02:23:09 +0000
Message-Id: <20201031022311.1677337-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware parameter LINK_FAIL_TX_CNT maps to the prima configuration
file parameter gLinkFailTxCnt and is described as:

quote: " If within gLinkFailTimeout period(values is mentioned in msec) if
         FW doesn't receive acks for gLinkFailTxCnt number of packets, then
         link will be disconnected."

The downstream description sets a minimum value of 1000 a maximum value of
60000 and a default value of 6000, however it appears that unless we
actually set this value deliberately firmware defaults it to 0.

Setting this value to non-zero results in the firmware doing link
monitoring.

In conjunction with ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR); this
change effects offload of link monitoring to the firmware.

Tested with:
'CNSS-PR-2-0-1-2-c1-74-130449-3' wcn3620
'CNSS-PR-2-0-1-2-c1-00083'       wcn3680

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 766400f7b61c..262978371c1f 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -78,6 +78,7 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
 	WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
 	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
+	WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 200),
 };
 
 static struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
-- 
2.28.0

