Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F8F2A2912
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgKBLZK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgKBLZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64395C061A04
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:09 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so9020321wmg.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UT5EgnUvoHP+GjgilFxQnCqaL6JOwHOcMs3W1ZOmRXU=;
        b=xukb2MhFxJbVUdsWilattJVsGg0OAs77+oLW3aMTLk/EF/Ai4AANnWiI3wmBS5XwRf
         zi7tVBPSLiEoKSaopsSuC8MTjW7bGWgXFnsXe5GenkjXYAZ3XF+6Yc/v6MIMR2jYGiEA
         JccZN775WqcJLqdINDeWs5q/CcQ80igoAj4GphmiroGQwXn4EVHTg2tP0s0nBUTxWM2L
         Iiy3ylxRXTxxErZbkKpC3QUymQbzduX1rJycnCa03pcZ20vbdAiKvEkmk7c7wQ5Lkf5y
         vMwRN5JIToSpejVIkfvae9Gc+n2c/GQjELhxciFLObO1W62xiJ9tmDWdsqrJ74MpM93K
         k/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UT5EgnUvoHP+GjgilFxQnCqaL6JOwHOcMs3W1ZOmRXU=;
        b=IMhQVdqnEzsPUBZ///94Lh25272NvQ9DQ31wFzq2CFoOp5hCnuWRw9rR1509Sfz4kG
         5jjPQ1vvXxL/bRaXqP8fgn9pzANu2FY6LTIG1h31Zy3QVhfMlGSXroWKfkbijjzH15Bf
         8ugJZxbr78SBHBf185FQFTiahlisAdciUKXzXUrM1LVXl7BjqDdguL/NPCmqVRzL93Gc
         ZChQLuXD5hvP3z0yrv8hAUhv1ilmpOX3iItQ5KqbBZnnr93tuM/x+gp79klnPGmdBge7
         cnmL64g3am2AvwM7d9oIJBvuDfIO0TdNo4ndZjhH2o8cBz2K7Yz8ngLRZVejcuyU2fei
         3wxw==
X-Gm-Message-State: AOAM530JKI+vGQeU1NBwKLIGJcfRDUggUlGV+dxcxuVLKgIknWD/18UT
        IfK3nOjqHYHYOLszH5oI4MrQQl2YuB8r9g==
X-Google-Smtp-Source: ABdhPJzxaJagDnvgeH2HbXfAEJ2LYyd+wNu8tVtlIN4gwozyl0vvjVt8g0xrZK5de9DGHD5UPb/VJA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr17030497wme.0.1604316308191;
        Mon, 02 Nov 2020 03:25:08 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 38/41] realtek: rtw8822c: Remove unused variable 'corr_val'
Date:   Mon,  2 Nov 2020 11:24:07 +0000
Message-Id: <20201102112410.1049272-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function ‘rtw8822c_dpk_dc_corr_check’:
 drivers/net/wireless/realtek/rtw88/rtw8822c.c:2445:5: warning: variable ‘corr_val’ set but not used [-Wunused-but-set-variable]

Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index e37300e98517b..b129a10707573 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2442,7 +2442,7 @@ static void rtw8822c_dpk_rxbb_dc_cal(struct rtw_dev *rtwdev, u8 path)
 static u8 rtw8822c_dpk_dc_corr_check(struct rtw_dev *rtwdev, u8 path)
 {
 	u16 dc_i, dc_q;
-	u8 corr_val, corr_idx;
+	u8 corr_idx;
 
 	rtw_write32(rtwdev, REG_RXSRAM_CTL, 0x000900f0);
 	dc_i = (u16)rtw_read32_mask(rtwdev, REG_STAT_RPT, GENMASK(27, 16));
@@ -2455,7 +2455,7 @@ static u8 rtw8822c_dpk_dc_corr_check(struct rtw_dev *rtwdev, u8 path)
 
 	rtw_write32(rtwdev, REG_RXSRAM_CTL, 0x000000f0);
 	corr_idx = (u8)rtw_read32_mask(rtwdev, REG_STAT_RPT, GENMASK(7, 0));
-	corr_val = (u8)rtw_read32_mask(rtwdev, REG_STAT_RPT, GENMASK(15, 8));
+	rtw_read32_mask(rtwdev, REG_STAT_RPT, GENMASK(15, 8));
 
 	if (dc_i > 200 || dc_q > 200 || corr_idx < 40 || corr_idx > 65)
 		return 1;
-- 
2.25.1

