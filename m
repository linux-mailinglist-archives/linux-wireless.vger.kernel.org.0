Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167101B6A7A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgDXAtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgDXAtj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CDC09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r17so6291862lff.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/b3npb6pWEyc/rTWSDgsuwKjZh16aTlDyhMtdfaza4g=;
        b=DfVDRkxB5o1unqMkdwVEHWkdoydfqEGK3DqscgzZshy3J7HBQzXdmdS1N3GsdRJprK
         BeByShk0tDM9eRz6+GNclRIjsEx83p4Lo9FrRBQSeFbZO7Oxo5ZXwXgKS1/cl8+2eA4p
         NfzIZ/jzCaZR/z/x/3cQfN4o7VkQ8OIccI1JQ+KnhZMAkv9wxMtNULCmnz9Gp5DLcn5J
         umeWpQfRTnGbPrZAx8H3qq2a7V2NJNhoN7BxYaiBHutDzXogc+Z1bsiKT6lNzL+a+g/6
         RyYoOAGpszd/5c3ZEgrYtOnmM2gSTYYyxk+9/nwlRs4PoOXCkL+U1oStY4XzYrAI1CEU
         ohxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/b3npb6pWEyc/rTWSDgsuwKjZh16aTlDyhMtdfaza4g=;
        b=V8Epfr2jHAU0aODWnaTPPlNEWZBkzA/xYiP7eUnVBxXEssc8zi2mZwvCdHP47rOxIX
         FbK8uLlHnBeW9MKb4MKVEwFMQVKn3UBcz4eWjoS0Z0yfQBO1yK5PZzmCmSINcZI5lFNr
         s+KxrOxozCPdv0Sa0g41yoZG+4macLvlcjfLlMO4yFO/0A5DrPCO8L6kja5660BqrSAO
         20OpUpfUeaF7/hhXnjTKAHl7kcVQyO3o5DxhiZ5Gu3LFtt372JISRmb98SBDN7SO30Xt
         YBNetQ7q/8ZU70PnFW2910pU+H3tnrDABxEov94kBHJY3IGQ+JEDtOxZ+DPVuBcS//Sl
         pZKA==
X-Gm-Message-State: AGi0PuZJZqO1ODDQ3dvHPUSqeWGdesopAA2RhRgwSSGvB/Yow/nnUAMm
        ZxlnhPw2aB5aVyb1fovhPBw=
X-Google-Smtp-Source: APiQypJ1oR8r2M0seiVpQ9Qw7z98IuiVt34JVAyGFGzWYISlwpY7u+OFvhXkrjcb8qmqK4lwRiznwQ==
X-Received: by 2002:a05:6512:3189:: with SMTP id i9mr4220250lfe.178.1587689377419;
        Thu, 23 Apr 2020 17:49:37 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:36 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] ath9k: remove needless NFCAL_PENDING flag setting
Date:   Fri, 24 Apr 2020 03:49:19 +0300
Message-Id: <20200424004923.17129-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
References: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The NFCAL_PENDING flag is set by the ath9k_hw_start_nfcal() routine,
so there is no reason to set it manually after calling it during the
AR9002 calibrations initialization.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ar9002_calib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_calib.c b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
index 14eee06744ed..0f7c5812e5c2 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
@@ -857,9 +857,6 @@ static bool ar9002_hw_init_cal(struct ath_hw *ah, struct ath9k_channel *chan)
 	ath9k_hw_loadnf(ah, chan);
 	ath9k_hw_start_nfcal(ah, true);
 
-	if (ah->caldata)
-		set_bit(NFCAL_PENDING, &ah->caldata->cal_flags);
-
 	ah->cal_list = ah->cal_list_last = ah->cal_list_curr = NULL;
 
 	/* Enable IQ, ADC Gain and ADC DC offset CALs */
-- 
2.24.1

