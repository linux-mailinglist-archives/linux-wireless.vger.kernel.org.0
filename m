Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D129E2A2928
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgKBLZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKBLZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F3C061A4F
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 205so1377659wma.4
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LpWKESLTGBe7YeMGrN5FmJYCFJcGpFNookfaDX/IDGg=;
        b=r5dRwCOBEnNkEhSvcu8ebuTtLZMpAlfj59ZOipi6qoNBtJVyZFxR/ENjeGQ7/AcNso
         cqOfRNxCPcTLrEYICbEKEu1tydiDfltsD/8KVFTImadOsSiZqCbZmEKrKyE6koP3ttbO
         0SHnXVSM/w+uWw11b9MM5F4CtPo/MirlBPwz7VCzzrtBkxS5js9Z2k5TFRcwhD5Dwza2
         FeVKfh8hLHloz3hOKbA5m7Sp/Pj8qsWYVD9NFrWSC8ousDTAwYhIV0OXx9QqYTchAsxZ
         qnsEq8fgZrn8ElXazGnLAaVRbnI+UOgpNPqS6xWE/ermyTsylsJ0TlRi2kSvC/lrfLEh
         9EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpWKESLTGBe7YeMGrN5FmJYCFJcGpFNookfaDX/IDGg=;
        b=qc8PeOM9ea5mL/2VqOEEZgUhu6+M7e2QjVGZ9HK55Svi+xZNXgKNi3qE2dAMFlRAT1
         8M67fa/SnRqr8mkKGDT9RLtLC0qKdHSPbk8M/RjqSPBwYbNLeWMFi3ZZWn29gICZPcYf
         5d6ycqhETCO9572d7B60zL4l51KYHP1WffzU7PMbabRqGcDyypwoKXxl4bVwB+36MNWg
         m63afTq0yS5oeSzG91Bez9zfmBZpdRWvo4yLx8J60UDczC5xaMZ4u+83ae13lCafHBdb
         hgcc9ltocGpVUhWMup0hFq6g/v2JuxJNhRBB2zAdZg3JAnqU22Eo3/2WUjp50hCyF7bu
         scEw==
X-Gm-Message-State: AOAM532mNmP08riGUZBePztU/kgwSVxevZz2Xuly3bbihgrpNUYjcyI6
        vH4FQz3octymhzroLL2SVvCJ3g==
X-Google-Smtp-Source: ABdhPJyyfs4HJbOnKkn7LRYpmCrrd1Eh+uguAsVZJ8Pk+IFH4jzNRMFjuc3acSYojh6656kuXXXSLA==
X-Received: by 2002:a1c:2901:: with SMTP id p1mr17665790wmp.170.1604316305760;
        Mon, 02 Nov 2020 03:25:05 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 36/41] rtw8822b: Return type is not const
Date:   Mon,  2 Nov 2020 11:24:05 +0000
Message-Id: <20201102112410.1049272-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtw88/rtw8822b.c:90:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 22d0dd640ac94..b420eb9148796 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -87,7 +87,7 @@ static const u32 rtw8822b_txscale_tbl[RTW_TXSCALE_SIZE] = {
 	0x2d3, 0x2fe, 0x32b, 0x35c, 0x38e, 0x3c4, 0x3fe
 };
 
-static const u8 rtw8822b_get_swing_index(struct rtw_dev *rtwdev)
+static u8 rtw8822b_get_swing_index(struct rtw_dev *rtwdev)
 {
 	u8 i = 0;
 	u32 swing, table_value;
-- 
2.25.1

