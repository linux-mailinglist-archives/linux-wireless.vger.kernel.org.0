Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0526D252A6A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHZJip (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgHZJeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B034EC06138F
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t2so1086367wma.0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qElmRnHsar7tn4JV1a4MOU4ECliWfWuqmHMN13MnixU=;
        b=PBwJBdkQlk8+/glvNbz0NN9mU9pLT9iRphNJRoCwUkB7TBfg41MLFYDe9JWU4G4eSz
         iCZgPMD8KHcs2xTrORTWg9H0xYW4xLdiY/VdZDgZ58k8y9+IngWN8V66vafUV9a4j8mv
         ZMgrcGPYBYdj3/3d1SQ7JqQCHwSZE6fkwTf4ry/wbHo3DGWpzQWmmveF9yLR8HIBxX6E
         4txc7BApPS000GyfapvamEZqKo9PpsZ7m1dTFY4Uj144iF4cUUa3nKtjQH39JzVPDoIQ
         XuwF7EN1CCGOSGA3e6rv9sCVtYV0zOw0RAbFRfsqExehODp8gWDYcuaCSbbz5U1NRWV+
         aX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qElmRnHsar7tn4JV1a4MOU4ECliWfWuqmHMN13MnixU=;
        b=G9xLyH435PjLBJVE91ehYg9Jmvg8A4OW3HlfX6vP3UZUjG1Y7A6n07pDd7ZxWzroEO
         xMbUy+G/kewKELL3o2anm6IwJk7kz527aopWOH3LoUbPBns1KuF0BAwZ60HXYWQTSYOd
         k0LVV6SaxpXLyICRpvTDxIfCyhMFlu8ehx+rD4d4m8AqPvv39jpq5cBQ+djfYsUj8sMJ
         7Oed+MzInh8gN1qZL9ZoayQkXxgSBfnNwKTa11rcgavXbhX2+4+1/MRQcJ0p0UKsR9vw
         9j8ygbHQLHjvrap6fNXuWD01DG5dIZ/XWXaMP2BcsWhz4FSBXtS0ywQ3P8VGMs+tABmm
         wdZQ==
X-Gm-Message-State: AOAM530rjbN8xNK0P81b3QkUMtJ3IikfaRVJl5HTRyespjOE8A4jadtq
        N5qeKgygnNWj0rBHEz0HgVjzOQ==
X-Google-Smtp-Source: ABdhPJx3h8A3mjpNHgeZ/6rKPE6GI6Xtear6POyYyOrLQKipA1gOfGiBA+GtMpx2b9EQwV0Whzi1Mg==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr6392874wmd.72.1598434462418;
        Wed, 26 Aug 2020 02:34:22 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 14/30] wireless: ath: ath6kl: wmi: Remove unused variable 'rate'
Date:   Wed, 26 Aug 2020 10:33:45 +0100
Message-Id: <20200826093401.1458456-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath6kl/wmi.c: In function ‘ath6kl_wmi_bitrate_reply_rx’:
 drivers/net/wireless/ath/ath6kl/wmi.c:1204:6: warning: variable ‘rate’ set but not used [-Wunused-but-set-variable]

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath6kl/wmi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 6885d2ded53a8..a4339cca661f0 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -1201,8 +1201,7 @@ static int ath6kl_wmi_pstream_timeout_event_rx(struct wmi *wmi, u8 *datap,
 static int ath6kl_wmi_bitrate_reply_rx(struct wmi *wmi, u8 *datap, int len)
 {
 	struct wmi_bit_rate_reply *reply;
-	s32 rate;
-	u32 sgi, index;
+	u32 index;
 
 	if (len < sizeof(struct wmi_bit_rate_reply))
 		return -EINVAL;
@@ -1211,15 +1210,10 @@ static int ath6kl_wmi_bitrate_reply_rx(struct wmi *wmi, u8 *datap, int len)
 
 	ath6kl_dbg(ATH6KL_DBG_WMI, "rateindex %d\n", reply->rate_index);
 
-	if (reply->rate_index == (s8) RATE_AUTO) {
-		rate = RATE_AUTO;
-	} else {
+	if (reply->rate_index != (s8) RATE_AUTO) {
 		index = reply->rate_index & 0x7f;
 		if (WARN_ON_ONCE(index > (RATE_MCS_7_40 + 1)))
 			return -EINVAL;
-
-		sgi = (reply->rate_index & 0x80) ? 1 : 0;
-		rate = wmi_rate_tbl[index][sgi];
 	}
 
 	ath6kl_wakeup_event(wmi->parent_dev);
-- 
2.25.1

