Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E932649C2
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgIJQas (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgIJQ1g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523CC0617BC
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so7057896wrn.10
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbuSpUHUK9Xf5kW5O/ETlw8jaTEXI5Gq5SIeCS+jaOg=;
        b=U/XYFWpntw9A4GcKyqUzPvxG99HZUxnQeS7+9JsXO8alW/1bYOJ4OnvAEUISI1Zzn/
         m8D1VDmaL08oBdQojRiAPCQBb05ZaVsxLV6JajOLFYdb+yQeXnoz3slcz7cexpvjfLJr
         6Rd/AJvjGRcbAJMfTQfHrwvyQfXnN4+maGPuEvtuvs+JDQGYYy5JqTRbs8VrKSgUq2bG
         Ye88eCMy1KntLfI2LblzmDLKWI6hME70yC4BTmkCv7BcW30IbtaRHWenrhi8wJH2ft68
         co9/CsjrUCIlQJJ0do+yebvunCaJWInlHp1ParrKO9JdEBxpNmN0/J3ZzD78iyYyzEiN
         Ao9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbuSpUHUK9Xf5kW5O/ETlw8jaTEXI5Gq5SIeCS+jaOg=;
        b=keCWmvMneFAeyF0jdhLWG9sC9KmzAo31l9rYlddmNH4DTetBA2rxRdoEuPwBdKo6sq
         NF7fB6YXnKj09AO7i8DPjNoA1N6hFEeE2odCtNzlgFnblpbzNOEn8q5LILNH/jPlqKyQ
         FcTLstGepCkUCeTrpD2QKuTT1R1VIIxEDc9EJkzo0v4spNsigarNcTMX+nBNrAmLUqv7
         6vH6pxhCTV9iJ2ZiPykWLbj2iE2JeVesuEmlmBanEZC4Nqk9pqtp0PXRwPZuOZcNIJDL
         DQd8X0Y9lz7MGw5tqPoWcxnklGBvPB+guyP1w+J11wHRECN+sxxv0H9BZwGULqvNFlSR
         ugRw==
X-Gm-Message-State: AOAM5323my6aKa0odopZF8fefYXyZXUpx3aHsU2IaQ6GOb5XQTo5yaga
        kAkwr9m9k1U+MlFQlGrv8HBfgg==
X-Google-Smtp-Source: ABdhPJxpm0q+z0KtTU4wpy1PgkcIuvIbM16uMuqr1ZlCqljI7M04mfPWFYB5I9oDdc1tPGRcDc+r6A==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr9613696wrp.370.1599750385515;
        Thu, 10 Sep 2020 08:06:25 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i11sm8778906wre.32.2020.09.10.08.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 5/5] wcn36xx: Set PHY into correct mode for 80MHz channel width
Date:   Thu, 10 Sep 2020 16:07:08 +0100
Message-Id: <20200910150708.2179043-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
References: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the 80MHz channel we need to set the PHY mode to one of four PHY modes
that span the 80MHz range.

This patch latches the hw_value PHY field previously defined for 5GHz
channels directly to the parameter passed to the firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index feeb27851f7a..7dada66b9f87 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1508,6 +1508,7 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
 	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
+	struct cfg80211_chan_def *chandef;
 	int ret;
 
 	msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
@@ -1547,7 +1548,13 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss->dtim_period = bss_v0.dtim_period;
 	bss->tx_channel_width_set = bss_v0.tx_channel_width_set;
 	bss->oper_channel = bss_v0.oper_channel;
-	bss->ext_channel = bss_v0.ext_channel;
+
+	if (wcn->hw->conf.chandef.width == NL80211_CHAN_WIDTH_80) {
+		chandef = &wcn->hw->conf.chandef;
+		bss->ext_channel = HW_VALUE_PHY(chandef->chan->hw_value);
+	} else {
+		bss->ext_channel = bss_v0.ext_channel;
+	}
 
 	bss->reserved = bss_v0.reserved;
 
-- 
2.27.0

