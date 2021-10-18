Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711FA432A2D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhJRXRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJRXRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C96C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r18so44173926wrg.6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ums5lH5A6tPRuZbLiAY6nRVNCSm8UQRGQFhKC352/Xs=;
        b=HPfHLoDquM7RwcND+vgWYueLkNiO7PWgpgDB78EfJZCLRozaCjUGgUBe+L0EkWBs8D
         oe6kjBNWVhYB9ZQfRQ63pxsrtBbEB94++LbfWizDhOHCG0Dbp1oCzZfIAOtiwSNR2jJX
         o99ktNMwHwoiVNlLuFNxqqoZPzqN43TfVTv6ckG3PiPXFcALOxxMVkTmoyx8g3ay2at1
         Ogqqd8wsWOJg5RKDO1SdNR27TcQFlKJHdlvjGfFFuCSzYQ1go/ImvAT8OE53nt5thYL2
         h3GHSNxkMmuQ2LBA9X09Fji001m00w2y9n0tJUv/irXZeEvGYOPT7RhsiDW5I7dQpeWr
         rgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ums5lH5A6tPRuZbLiAY6nRVNCSm8UQRGQFhKC352/Xs=;
        b=U43p9okupF4O43nw3dG6rNJM3wu3EP/BVzgh/BhXCGTVDSvfThR1Uw5t5bRCd4xqGu
         F9kEMuZTRKlI6Fy19KMcQ/t0Kj1lJiS8G6PaFfNRfCfY6xHtrBDcF1/3Kg6tuwXyxVgh
         NRngL3abxv7UmGv9dK1h+9Nt72j+5hPJ8HNSHDY2LcqpW1ZKTQd9CNMo0nAfMR8uIsUS
         YJM7H15vaWLzon1khek0/EPfZZKDcqkQD4PjkhMNbFV0MiLh75UB1XcEWzXQteeTNDal
         Txi0hmhMYgu4CGRrh02FNpXZVlO3tYzwgJaSTs31war06eUsIaWCBpzBXtvViXqUD+rp
         cF/g==
X-Gm-Message-State: AOAM530NLytpcgQuyA3+ovQfJCpcT95rjth1yntuoZycAHCK5lNijI3w
        j44UP5+CWWYDASCFDWjDEXplyg==
X-Google-Smtp-Source: ABdhPJzQ825m3VfzLCVqqVY4uThT3296xK7cmuholih9I0tL6ZMXMehP/ZzeyfDfu8hErR79FMgHfg==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr39029542wrz.20.1634598928262;
        Mon, 18 Oct 2021 16:15:28 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm3685379wrr.15.2021.10.18.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:15:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 4/5] wcn36xx: Functionally decompose DXE reset
Date:   Tue, 19 Oct 2021 00:17:21 +0100
Message-Id: <20211018231722.873525-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
References: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A follow-on patch will reset the DXE block in dxe_deinit. Prepare the way
by first functionally decomposing the reset.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 30f4484b336c3..d4f5746d9b10a 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -919,12 +919,19 @@ void wcn36xx_dxe_unset_tx_ack_skb(struct wcn36xx *wcn)
 	spin_unlock_irqrestore(&wcn->dxe_lock, flags);
 }
 
-int wcn36xx_dxe_init(struct wcn36xx *wcn)
+static void wcn36xx_dxe_reset(struct wcn36xx *wcn)
 {
-	int reg_data = 0, ret;
+	int reg_data = 0;
 
 	reg_data = WCN36XX_DXE_REG_RESET;
 	wcn36xx_dxe_write_register(wcn, WCN36XX_DXE_REG_CSR_RESET, reg_data);
+}
+
+int wcn36xx_dxe_init(struct wcn36xx *wcn)
+{
+	int reg_data = 0, ret;
+
+	wcn36xx_dxe_reset(wcn);
 
 	/* Select channels for rx avail and xfer done interrupts... */
 	reg_data = (WCN36XX_DXE_INT_CH3_MASK | WCN36XX_DXE_INT_CH1_MASK) << 16 |
-- 
2.33.0

