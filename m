Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB69256464
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH2DiW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgH2DiJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E7CC061233
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so894246wrm.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZEQmynoQoGqql5uWz9R80ak6n6NCB+2pwYHU1F/YXI=;
        b=Ug6KpVaQEsn9IqxnjJSB/dU0b2hStJjSEx1mpkJAm3huL5fWGENXCX5gu7UKvHmzvE
         uRWE0ETy7awWup2LWk2FkwD1pOseIR+dpv8ocy2rlvasUqJmcAaDZCvZT8z49iKlfk6Q
         DIvuHrPfbpNOIrGdUXcifOCWCuIcARpr9+m0nCMgBZH8DXLoo5csz80QPulHQRGMqVYF
         frD//UDx9QOYf1Nwy3CanXLRslsx8TNIoKL/GUZgMrnCfRDEYYI9TpGQtdwYA8Ftj1Ny
         BIM6CmwpAXHSqvwNafhHh7BjB0B2ZD/6r79kF3DFA3Q9AIKZN+BJNn11C19imKPqsISq
         bouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZEQmynoQoGqql5uWz9R80ak6n6NCB+2pwYHU1F/YXI=;
        b=Kl6eCPmMMxtRzb79G4uLGLeiLx1aFZENcB52kRd4iRaJad0JisGOlvpJZZZHU3mDE0
         u5TSpWZ3R69oCUPMYJjLf1j3iBaD+rs74Lczmisno/8F3B6jN7W7Izqwr74h2m958MUL
         ifgtY4p4/hk7XRhWxEG6J9yHuAjgdSGu4fBj4UZNJy+tAq7FLa1/9H2xfums8FaSxRbk
         CInlhWYVYySEewDh0i+8QaZh/zlrsR9f7oN0CCPPCpUe5n7nQGKiD5xcKBZcU2Ugm0sq
         hOZrn6fkOT5v2vw6hbbjEiGG20uuGqYsB2ZOLuQ8U4yVTG2ftlph3bcuqWly86EyP7QG
         CFWA==
X-Gm-Message-State: AOAM531OghPC/A5Dv8o2pFwG/Dp5Rhdd90mriXD0T5AoEVmPHAs0G0ww
        tTgIiKEpJJzQzmPIaFm5bouTbQ==
X-Google-Smtp-Source: ABdhPJy0o6Cjmm+lIDQ74XQz8UkFhiDUK8CADj3r3mh7aIxmaefBwM1I+fXGNCOKEy9PrEOslkdBJQ==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr1600087wrv.231.1598672287438;
        Fri, 28 Aug 2020 20:38:07 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 04/10] wcn36xx: Add 802.11ac MCS rates
Date:   Sat, 29 Aug 2020 04:38:40 +0100
Message-Id: <20200829033846.2167619-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
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
index 564130d6b8cb..80e96c2296af 100644
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

