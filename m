Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731C22C55B5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 14:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbgKZNcd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 08:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390316AbgKZNcQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CADCC061A04
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so2158991wrs.4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 05:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=056QqikcWr/GU3mDhY6gijUgY/LGF79OsK2zfz8G1FY=;
        b=fqv0JhXGTBJ6+Rj9ibArRehnnEYTflFsehO23vS9knsxbK7litwIKnbiw7ObbXfS/e
         f4Ir3thv79U4cTh0HGulqmvMIBVxvuEt9Dop7Zv5ht638Jx8m12KvMVS7h6Z2l+G1GkX
         cVFxqKHqP1xMiYcLllMxAHpUIX1LY1gs9vLRELHv6ZmUlddNzRO0eVsCq/94H2h995bM
         5pPjAU9MStt8Om1c3WCFX1ENSOWaXEddv9/QhD39zVhQW2xuwwr737j16SIy/3Drbfhj
         oJ3+TDuW/eLNsRST+cRAuHC19XSYN6pvdJKzsOCF8y8sShpZ24tO1rVh9ubYqkjQ9S34
         Eq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=056QqikcWr/GU3mDhY6gijUgY/LGF79OsK2zfz8G1FY=;
        b=gguF8mSvnkLbAiEIs6bD19E91XAtrL9WVjDbLoiAVn8dyWqJsd5yy25glvbf2irLnJ
         cBVBFKXhpoiufXhd3Uo9EmyEEKs+CwMt4GupM21pwF0NUDY9a5KLGZse3TDcFzGgVbFD
         b296yaGorE0CijZXCaJ41ONf4d3DOWXiQ58mf1C2/Z9AAif0JnqZHqsMUZ3D1PvLNNt5
         /MBxXqn26/ENSjBM6ffNDDKeSPFEuvl4ruZP9XMy2sKWKQYy96NBH/t5Hmm01LJI4u3J
         Xl5tYslMg93aRsAAAH5GeFJIGLBbPnSG4wOVRPg6fP6z04nl65sLaZ3J7cbtxO4m9yL6
         0Zgw==
X-Gm-Message-State: AOAM532GmzfE9f/csGETr6DS9rXVt0T6YMW8mKkmiYIDVAyyz4EhaVDD
        Z4DoRu9kCcrlIUJn/U3rBipVDQ==
X-Google-Smtp-Source: ABdhPJzYvUJmMpBs6Uu4aktg9Hmy5bVFWzXjnfem1+AQgkKMzk6zfjUlVS+cAc7faTABkYV01/5rWQ==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr3769552wrj.223.1606397535117;
        Thu, 26 Nov 2020 05:32:15 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 15/17] ath9k: dynack: Demote non-compliant function header
Date:   Thu, 26 Nov 2020 13:31:50 +0000
Message-Id: <20201126133152.3211309-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/dynack.c:52: warning: Function parameter or member 'old' not described in 'ath_dynack_ewma'
 drivers/net/wireless/ath/ath9k/dynack.c:52: warning: Function parameter or member 'new' not described in 'ath_dynack_ewma'

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/dynack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
index fbeb4a739d321..3219715174a2f 100644
--- a/drivers/net/wireless/ath/ath9k/dynack.c
+++ b/drivers/net/wireless/ath/ath9k/dynack.c
@@ -44,9 +44,8 @@ static u32 ath_dynack_get_max_to(struct ath_hw *ah)
 	return 600;
 }
 
-/**
+/*
  * ath_dynack_ewma - EWMA (Exponentially Weighted Moving Average) calculation
- *
  */
 static inline int ath_dynack_ewma(int old, int new)
 {
-- 
2.25.1

