Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C147938BCA0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 04:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhEUCuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhEUCuL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 22:50:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15DCC061574
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 19:48:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so6554201pjt.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49tVRFAbN3FICwoTXkFUg1rjsSNZ36l5NduVB6gFlPQ=;
        b=OhIFtl4kJ07zdA1OkOvSkvlEyo184jIok03pX5DhONBBspcYZc/crmRSf3/gOzTzqx
         oR9Bzm9sLuM4lVzkpCcVTe88YhFmjVNEj/tzRhLotuotO1wOisw72QPwcESQAtkpnNkt
         FfeUHgy4FTnOE3Af5xcxXaMwuORPI89W42PYKW6qMey+ZN6evv9Zm7AMSwVxmiMurG8K
         6IF/sZZw+OvgsPBuSOGeTWjVMqAEXvDSrx9efuKkqshekVyX0iSMz3In/g2QKDPDeIbi
         nnFTm8eImOD4IuZsjMcmJNUM2af7xNwQBUL35LuS3y6BAj6l7O9itnRIvTpE9Hiu72aa
         DfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49tVRFAbN3FICwoTXkFUg1rjsSNZ36l5NduVB6gFlPQ=;
        b=OUuozN9Q6E80Fpd2RVieqNxzbA4g/+8EUydQCl+wm4Gsw8Skwkwuz+2qDjm1HE5H/n
         DyF+y5QReD9K/ggDZHIBEbBpUPMUMsFNp7tveFQphzz0YSFK4I0N/4tRFUQiRYTDSYCU
         /dC3ujkQXxhQpvB9+9M+2174cCRcQBEQxL4DJsfYM+wiX+fzPrA6QavtBZXkD5dQadqa
         sVp6HSjSc9wibojP/7MnIgCUkWRNZt5qS4XYUaInh6tYyfXfqe0ZI7wg7Fyj9yH/hN6h
         yxxKHpOnWiuVsszl64DaMWkFxJ7XUxFGi5QXajvFs1+iyIUciT1WAy352koPqgorXmd1
         3K6A==
X-Gm-Message-State: AOAM530tGFxaPmrE+/nmgylM9yQvENfgFVUq/K5ty6jFD7pBQ0GU6b4j
        FNHQmjqMKOV1HNANWgejqgo=
X-Google-Smtp-Source: ABdhPJxUAthdVBIMiHZ1AFtCwQtS4Lr7cN1Enn66Mwd51XcGmauZY2oIzU5ptrrvqxJapASPWf5+pQ==
X-Received: by 2002:a17:90a:9517:: with SMTP id t23mr8316479pjo.130.1621565327309;
        Thu, 20 May 2021 19:48:47 -0700 (PDT)
Received: from yguoaz-VirtualBox.hz.ali.com ([106.11.30.42])
        by smtp.googlemail.com with ESMTPSA id i7sm3049974pgv.93.2021.05.20.19.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 19:48:46 -0700 (PDT)
From:   Yiyuan GUO <yguoaz@gmail.com>
X-Google-Original-From: Yiyuan GUO <yguoaz@cse.ust.hk>
To:     briannorris@chromium.org
Cc:     linux-wireless@vger.kernel.org, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, yguoaz@gmail.com,
        Yiyuan GUO <yguoaz@cse.ust.hk>
Subject: [PATCH] mwifiex: protect against divide by zero in mwifiex_set_ibss_params
Date:   Fri, 21 May 2021 10:48:34 +0800
Message-Id: <20210521024834.8354-1-yguoaz@cse.ust.hk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In function mwifiex_set_ibss_params, the variable index may remain
zero if it is never altered inside the loop, leading to a potential
divide by zero problem.

Signed-off-by: Yiyuan GUO <yguoaz@cse.ust.hk>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 0961f4a5e..afcdebdcf 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2450,7 +2450,7 @@ static int mwifiex_set_ibss_params(struct mwifiex_private *priv,
 				config_bands = BAND_B;
 			} else {
 				config_bands = BAND_G;
-				if (params->basic_rates % index)
+				if (index && (params->basic_rates % index))
 					config_bands |= BAND_B;
 			}
 		}
-- 
2.25.1

