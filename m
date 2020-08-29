Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11566256466
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgH2Di3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgH2DiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0021C061235
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so876240wmc.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ombPAKmNa4Z6zut9RJcKKY/F0yxtyCaqxLuyUzdePk=;
        b=IMCX8icDForxzG9FE+bBTFQyGhkCMFVE0MKRM+c5KrhIacr5VdhHjw8tWi6LwK6qdB
         rzaRms0G/00jSp4Sbx0ZrGMa2lEfxUQJVQ+SJ/G0t2wwGePXX4QfhQcU+3Nrcp8seegt
         r+YEsTwJXHGWCtEy244gzhoBGDPvcQOPtnMSC3dIDLnb3mUdwwiNAysSiT0XyyGiHcYx
         MSsp9loY2yFCfZO71WSazI7pvwLHQEFzgv21ZFROQyyEwFY4OHjFVg+7OMMFeHEIvg8p
         boo0p2o7Srsh71HEE6V7O83aPfvyuhgfRf6HgUMBHs5AJO/8eZ5fvF/ZoUqcUYYZCjJW
         Gxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ombPAKmNa4Z6zut9RJcKKY/F0yxtyCaqxLuyUzdePk=;
        b=ryW6k6vt/3Of9iiEsyCPG5E8Wwk36zJwGVnl/AvbKclg5avbdGDMrYIME5NUinc3Fc
         6EVuDqeOe2QhohaGDB8/M9drd0woDA4LQhJpnVBO9tVhXKouHa+rh0HxIbO3TlmyCj/W
         H9pdNX4HsGlBOmyT/SEjMi+/UyqN/OHySA/Y3fi7riBHs9mg+oFwSVc1QF/6AsE7r42D
         J7Gy82ztuAUd9+tw+P7IDJy/oFy6+kFiMDondeerBh5psxXe+wX1qPS0OomCImf15r9w
         6ImAhsc0/msULPFZTPI/JhStfIQAq0qbBqvxDmt14Nxs7pA4rLbtrGaH96J+6gYl0a33
         98Wg==
X-Gm-Message-State: AOAM531u2lIm4vrpStX2rMHAGfue5M7zVo90uiXDf2l5HXkY75VpjOCF
        VhKF8pg3QIAF2zerZa7TnTBCzw==
X-Google-Smtp-Source: ABdhPJyE/P5cRdxFv5yjxbP0L7wsHmfzX2dn5YDu7kOar3UTTQaBlx7pQYBHFYJ2OMZonrahUbETjg==
X-Received: by 2002:a7b:c116:: with SMTP id w22mr1509152wmi.149.1598672289482;
        Fri, 28 Aug 2020 20:38:09 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:09 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 06/10] wcn36xx: Specify ieee80211_rx_status.nss
Date:   Sat, 29 Aug 2020 04:38:42 +0100
Message-Id: <20200829033846.2167619-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Specify the number of spatial streams in ieee80211_rx_status. For non VHT
data-rates the wireless core doesn't care about this field, however for VHT
data-rates it does.

Every version of wcn36xx has one spatial stream, so specify nss for
wcn3620, wcn3660 and wcn3680 now.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 05a84f82584c..903b47b55728 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -272,6 +272,7 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 		status.bw = rate->bw;
 		status.rate_idx = rate->mcs_or_legacy_index;
 		sband = wcn->hw->wiphy->bands[status.band];
+		status.nss = 1;
 
 		if (status.band == NL80211_BAND_5GHZ &&
 		    status.encoding == RX_ENC_LEGACY &&
-- 
2.27.0

