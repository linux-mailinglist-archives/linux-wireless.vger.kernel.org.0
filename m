Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949B40CCD9
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhIOS5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOS5v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 14:57:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1B5C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 11:56:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t190so4602516qke.7
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sXTQmBodNg5WTV0AyZ/PqLAipBdMijQBBzKn4s9bJ50=;
        b=jdH1EYERwJPdpLP4+yEjG2KwqvtS3y+L7z7R5m03cRjcXouy03PP5d8mjOuD2ePOGL
         2T1NbFLQbXr56VYvS8+KuShHlrcMmnkDtg8tG3/sFzVZ13dl4gwnEaMhBOj4e4ikV4So
         MDFX93tNhI0ImDlgLobrArKXA9WkN2KiB3g8fY0SSUzr/iTbFR+njKDObkwKQSESreHM
         w5PNUz9gQMDERiEGoOFsJbKFQL5KCZe9CFUNwsdsn178DGe4fqAposc7P3pxm1PAvmD8
         eiTlEgwdyZpcWwdupva3wow1HhiUTFXwtTFw+QM/XHamsNXxS3oF6vFGjLa6NeiC4UOu
         Diuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sXTQmBodNg5WTV0AyZ/PqLAipBdMijQBBzKn4s9bJ50=;
        b=GuqfqS9ZBWjjpfNt/Hkju3/jjVUj7VbJEquzngyrqoBDL8gxX2B9Ryk6uMA+3tzlgf
         oisqKEQqTaBBHjGMT1myPLm5L8DUpD5/l8q9Htw9F8U1MoSVjK/+wbxgz0kKAEgIjfvP
         CUZ4MXGzCchgfM2ver598fN3UfMzkdP9hCNoWGtM18O+9OdClGE2qtpuZihwqYWwna37
         iiNQvvjIPS++8nJI4/Z8XGbre8N79FOr4OdivywKWddz7rsGoLm1G4INdBWSEUMZ078G
         rOyd8UGOt+ej/3kScFletyjv7YCIrWzDd3Zub5K8+R+Yvx564J6NGOLeIwTJ+kEYHNCD
         LxTQ==
X-Gm-Message-State: AOAM531ycbweiVT5mzUL8c+NsYa3ntuZlKtYjx1rBvxldZ9t+b4OVQWL
        sZMZXvjHQEkF6IVc5LMAH7dI47KDK0Q=
X-Google-Smtp-Source: ABdhPJzq3oPBis7GB2dp6r4F+wutCEQ4x+GyEgOJ6oNnTqczdoaFmt9yVvc0SdInJHu3/cFX+YuvrA==
X-Received: by 2002:a05:620a:1455:: with SMTP id i21mr1467688qkl.116.1631732191660;
        Wed, 15 Sep 2021 11:56:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:38c5:675f:1e0:5e11:1b48:4db0])
        by smtp.gmail.com with ESMTPSA id q22sm555783qtn.25.2021.09.15.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:56:31 -0700 (PDT)
From:   Peter Oh <ebmajor.dev@gmail.com>
To:     ath10k@lists.infradead.org, kvalo@qca.qualcomm.com
Cc:     Peter Oh <ebmajor.dev@gmail.com>, linux-wireless@vger.kernel.org,
        andreas.tepe@debitel.net
Subject: [PATCH] ath: regdom: extend South Korea regulatory domain support
Date:   Wed, 15 Sep 2021 11:56:11 -0700
Message-Id: <20210915185611.6195-1-ebmajor.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

South Korea manufacturer, Samsung, has extended South Korea
regulatory domain pair with 0x5F and has used it for their
devices such as Samsung Galaxy book. Hence add support
0x5F as a regulatory domain pair along with extended country
code, 413.

Signed-off-by: Peter Oh <ebmajor.dev@gmail.com>
Signed-off-by: Andreas Tepe <andreas.tepe@debitel.net>
---
 drivers/net/wireless/ath/regd.h        | 1 +
 drivers/net/wireless/ath/regd_common.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/regd.h b/drivers/net/wireless/ath/regd.h
index 8d5a16b558e6..774419c7f442 100644
--- a/drivers/net/wireless/ath/regd.h
+++ b/drivers/net/wireless/ath/regd.h
@@ -126,6 +126,7 @@ enum CountryCode {
 	CTRY_KOREA_ROC = 410,
 	CTRY_KOREA_ROC2 = 411,
 	CTRY_KOREA_ROC3 = 412,
+	CTRY_KOREA_ROC4 = 413,
 	CTRY_KUWAIT = 414,
 	CTRY_LATVIA = 428,
 	CTRY_LEBANON = 422,
diff --git a/drivers/net/wireless/ath/regd_common.h b/drivers/net/wireless/ath/regd_common.h
index c4bd26e65949..cdb1e9a23734 100644
--- a/drivers/net/wireless/ath/regd_common.h
+++ b/drivers/net/wireless/ath/regd_common.h
@@ -76,6 +76,7 @@ enum EnumRd {
 	APL7_FCCA = 0x5C,
 	APL8_WORLD = 0x5D,
 	APL9_WORLD = 0x5E,
+	APL10_WORLD = 0x5F,
 
 	WOR0_WORLD = 0x60,
 	WOR1_WORLD = 0x61,
@@ -204,6 +205,7 @@ static struct reg_dmn_pair_mapping regDomainPairs[] = {
 	{APL6_WORLD, CTL_ETSI, CTL_ETSI},
 	{APL8_WORLD, CTL_ETSI, CTL_ETSI},
 	{APL9_WORLD, CTL_ETSI, CTL_ETSI},
+	{APL10_WORLD, CTL_ETSI, CTL_ETSI},
 
 	{APL3_FCCA, CTL_FCC, CTL_FCC},
 	{APL7_FCCA, CTL_FCC, CTL_FCC},
@@ -426,6 +428,7 @@ static struct country_code_to_enum_rd allCountries[] = {
 	{CTRY_KOREA_ROC, APL9_WORLD, "KR"},
 	{CTRY_KOREA_ROC2, APL2_WORLD, "K2"},
 	{CTRY_KOREA_ROC3, APL9_WORLD, "K3"},
+	{CTRY_KOREA_ROC4, APL10_WORLD, "K4"},
 	{CTRY_KUWAIT, ETSI3_WORLD, "KW"},
 	{CTRY_LATVIA, ETSI1_WORLD, "LV"},
 	{CTRY_LEBANON, NULL1_WORLD, "LB"},
-- 
2.22.0

