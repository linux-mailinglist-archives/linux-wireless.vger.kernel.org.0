Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25B239DA4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHCDKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHCDKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF44C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q76so12875415wme.4
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rkrUdfDvYsiZC6pLeKL7GcoMXiECZnaO2mZKUo9/A9Q=;
        b=KOxLmaStr2tx9QXivlWnBrnTFBehDtBsfnwhgzaCtWNb8qyMDXMzt7E2qB2iE1uzwW
         d4uqo6ISy/id003byB+MOG+mrn5zUk253p5b9CacQOqpsimOM4JPHaNLD/K2BYn4u7ot
         VGXc/pJR/SXBnh/qZDZm68kp+DskrEFkBvLoBd0r5Kjvl/RMW2eAsPbEyV4F/KfkM4xA
         6+eqHsCUmgfTwX4kI4v332/Cr1xOQN5BiBiYJ9s2XjDXN1cLs2sEPzVPdqdwxW+N0Mi1
         ebxfs9WFtO0mbXEV9EVg4e70dWg6WM7Eocq/QYYg0IC6fGsd4rtw/+PvNG8MDpmq384d
         sY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkrUdfDvYsiZC6pLeKL7GcoMXiECZnaO2mZKUo9/A9Q=;
        b=HSpiC6KpznLglnJxiF6XIDWRPTGU+L0QMbKBbAbeJ38Urhc/DAmiTp35d6ye1ps7wp
         oi+QkzRr2t8gGBWtAy4sF8jmIc6BrYwFCl5W1hzfw5w9RXru7u6+J8rIjq/SKsXgxCzy
         jUDAmnfLNbAJHl73oxxonlvdAaxEYG6vt/Fbbb37g6u4FXMx1JBKeFP4ro9Eje+6QZLa
         8U1Z5tGGM4KO/D//EeLbwhDoDc5k/FVZHluPGsYXNkYv+F0Vp4pssMJohjDHqLjYhvL6
         G8HGJ/bWpP1KQ3WMF/LsnLX5hLQPLJHFuPHi8U9lp4X5roex8Ql8lVZ4IqaEmKQqnAWk
         772w==
X-Gm-Message-State: AOAM531tcnnxcb1Uq3Prgs9UBU52IicaRYRnj5WMQS5/c3QJLpyoml7q
        i5zAYSlaKxBAMUp82vNJ2rA71w==
X-Google-Smtp-Source: ABdhPJwBdmM2lg+SlQvxfNlnDwzzSHZCLZgAZ+yPT6et5pMATaAdYZEokAsEZsItsJz5O/9y8x/Cbg==
X-Received: by 2002:a7b:ca4b:: with SMTP id m11mr13445313wml.120.1596424250015;
        Sun, 02 Aug 2020 20:10:50 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 03/36] wcn36xx: Add 802.11ac MCS rates
Date:   Mon,  3 Aug 2020 04:10:59 +0100
Message-Id: <20200803031132.1427063-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit incorporates the 802.11ac table defined in downstream into
upstream wcn36xx.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 109 +++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index e20dbe0271f8..05a84f82584c 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -114,7 +114,114 @@ static const struct wcn36xx_rate wcn36xx_rate_table[] = {
 	{ 1215, 6, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
 	{ 1350, 7, RX_ENC_HT, RX_ENC_FLAG_HT_GF, RATE_INFO_BW_40 },
 
-	/* TODO: AC rates */
+	/* 11ac reserved indices */
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 20 MHz 800ns GI MCS 0-8 */
+	{   65, 0, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  130, 1, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  195, 2, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  260, 3, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  390, 4, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  520, 5, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  585, 6, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  650, 7, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+	{  780, 8, RX_ENC_HT, 0, RATE_INFO_BW_20 },
+
+	/* 11ac reserved indices */
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 20 MHz 400ns SGI MCS 6-8 */
+	{  655, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{  722, 7, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+	{  866, 8, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_20 },
+
+	/* 11ac reserved indices */
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 40 MHz 800ns GI MCS 0-9 */
+	{  135, 0, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{  270, 1, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{  405, 2, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{  540, 3, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{  810, 4, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1080, 5, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1215, 6, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1350, 7, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1350, 7, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1620, 8, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+	{ 1800, 9, RX_ENC_HT, 0, RATE_INFO_BW_40 },
+
+	/* 11ac reserved indices */
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 40 MHz 400ns SGI MCS 5-7 */
+	{ 1200, 5, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1500, 7, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac reserved index */
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 40 MHz 400ns SGI MCS 5-7 */
+	{ 1800, 8, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 2000, 9, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac reserved index */
+	{ 1350, 6, RX_ENC_HT,  RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 80 MHz 800ns GI MCS 0-7 */
+	{  292, 0, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{  585, 1, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{  877, 2, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{ 1170, 3, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{ 1755, 4, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{ 2340, 5, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{ 2632, 6, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{ 2925, 7, RX_ENC_HT, 0, RATE_INFO_BW_80},
+
+	/* 11 ac reserved index */
+	{ 1350, 6, RX_ENC_HT,  RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 80 MHz 800 ns GI MCS 8-9 */
+	{ 3510, 8, RX_ENC_HT, 0, RATE_INFO_BW_80},
+	{ 3900, 9, RX_ENC_HT, 0, RATE_INFO_BW_80},
+
+	/* 11 ac reserved indices */
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+	{ 1350, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 80 MHz 400 ns SGI MCS 6-7 */
+	{ 2925, 6, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_80 },
+	{ 3250, 7, RX_ENC_HT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_80 },
+
+	/* 11ac reserved index */
+	{ 1350, 6, RX_ENC_HT,  RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_40 },
+
+	/* 11ac 80 MHz 400ns SGI MCS 8-9 */
+	{ 3900, 8, RX_ENC_VHT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_80 },
+	{ 4333, 9, RX_ENC_VHT, RX_ENC_FLAG_SHORT_GI, RATE_INFO_BW_80 },
 };
 
 int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
-- 
2.27.0

