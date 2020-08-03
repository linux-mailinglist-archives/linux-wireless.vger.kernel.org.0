Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA7239DBB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHCDLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgHCDLQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76CC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g8so13015009wmk.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBh3ROPhrGIW2kesBf+bRTaWxVaasDDdtUrc0+Ft64o=;
        b=s9l2/eO/Zqk3vRbIoBFtoeYfeVNL2XnNhUFm46L50xRWa/qtInzNprqVb5kcvbMwK7
         EgmgXuht6ZM5Fp1toNm69MyIa1mSUw6w3lAhVGdukvLosY0S8MlD/g/1IjyraKO5XWfr
         AlWuvJzCJCGThyKTCPm8FPTCyWRzhp1naQh/7eOuBA9jMmpvKRjcwGtX5MlrFQKvLhSn
         hewFIsJcHd/7Zu6uQPZ1pAzkKrGMHfycNfEWamQd74H8ReDz28G0MBhQ08sZKlVQzNGg
         wMoAzu4X/7PVb+nEy9rgBxdQBxMfeChmALMgNTz97at3P3g0g3QWj1mrdzG9KB67u6+o
         4Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBh3ROPhrGIW2kesBf+bRTaWxVaasDDdtUrc0+Ft64o=;
        b=oh/Cf2CDo6K8Kt4xp9PfFzrosOtaiWGRUZIL8ybeeAtP9thztIg8MzRQ3rPmtyvOk9
         mWweKd1DRj3WggOCWeGVL2L9y/QroslOagkJzBtMJ1N6sAWNu7cg5yra5AzECq+kFHG/
         waU3kq3IRxygY/3Y9/Za3btFjf7bwwVTGXpvKwZvUIwtQmGBuhwcv6GhGnB39Fub8I4g
         8dfOVqXK9OQ5qCIbDpDbejaJzVZ06Sw7fdGA3M58ZD6mfu6cO4WpN55l1iHU0ap5xcr4
         5l3740pmO6PMQkBLvKI8uA5qXJQzCTx5pPUXj/PVvxA+VZY8ABo+2X9L7gwymelUMydB
         J+Pw==
X-Gm-Message-State: AOAM531a0ioVZ7S0NwsPasPCH2Ep0Xnp2uzN3zRbuys+e8VkpO0r4//k
        i7niWDko4F4rO9/MohXM/zusMg==
X-Google-Smtp-Source: ABdhPJwqTncYt4YwFMv8r39LMkRwhd3tWRbE0gotPujqphLWJr2dfAJgDaN2Es3TcxVveiAPw22Law==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr13642585wme.158.1596424274637;
        Sun, 02 Aug 2020 20:11:14 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 26/36] wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
Date:   Mon,  3 Aug 2020 04:11:22 +0100
Message-Id: <20200803031132.1427063-27-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A previous patch added wcn36xx_smd_config_bss_v0() this patch converts the
version 0 data-path in wcn36xx_smd_config_bss() to use
wcn36xx_smd_config_bss_v0().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 50559871d109..033afe52dd9c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1710,9 +1710,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
 	} else {
-		PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
-
-		ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
 	}
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
-- 
2.27.0

