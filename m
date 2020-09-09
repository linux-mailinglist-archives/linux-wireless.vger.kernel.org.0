Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86762633B5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgIIRJF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A28C061756
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so3479089wrv.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/nry3NgBBjA9BLR7RzttfZX9dZbP5DRqQfPiOO3p9I=;
        b=EMnSQzZTSE9s5aFAM5MDV0hTDv9ggZAxrmlePWW4YdP43Zi68a3/vEMVOfy9Ee51Zf
         4FEYdWOdWQr9tV4D0xB3n32EpVf2tMX/pqmN7JGJ4+EA21kAw+XTSBCkC0zfego+mtcR
         EJTOd9qDhor9BCfXRY9oGTek80zjaAKXhtqZDWakXL+UrIViFmeMmgU0NN3aPfuOC3Jx
         8zQU5g5QcFCY+ysgpVrQ4pjKQZ9h/Lis2kU02piYNbHEe2bz5ueDtyzBso99j/HUTxeZ
         WNc6rgWfyRzj0FyZP0FEgippjD+0CoJpCJj1w9XATKjtEr45upPkwWKrjQGQ45hqd0NG
         Rl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/nry3NgBBjA9BLR7RzttfZX9dZbP5DRqQfPiOO3p9I=;
        b=DvogpbdOpBEXYLcnbN46bOg7kfH08mmx4FaouDFkhGHVOE0ysI98I8CPMo7WZsP/G3
         ZW7BRgyH15UpEMHZ47VXKcwGQHUo035supXxvMn/h8dNlTfb7Mk+Qaq7+89sxI740yfS
         XC7h20NNB2l5pAxOP534uN/gsv84WOh+Ua1aLsp9WxemOcSexRR/g8S49yst5YJ6JUxb
         Ftf+fazTnJQGuqqh6wS6b9XBetWUIDCyXwn2ICZuK41JPujBQG3e4ii8t8Qavfxu/8FK
         7lxXUaNAx2PJJGS9mw7bGzdvmwXq0Iq3q1L3WiE0mH2U+dUFJisTpwpGlWH3Sxlvkrer
         8GdA==
X-Gm-Message-State: AOAM532+sd3BGa2TrfKUp3fsNAde5XpLL+s85qjA5j8T8OIdDM6d+yS/
        5mBPoBpX5+rUrRw+zkaUxkLscw==
X-Google-Smtp-Source: ABdhPJysZYDKrwLOFlDsjr2JknJHfgYs93ua2Bzj2UCNzwZ1fsEaWqu2QdWDsvUxWiWM/1qyQxdqNw==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr4402142wrw.253.1599665745792;
        Wed, 09 Sep 2020 08:35:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 6/7] wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
Date:   Wed,  9 Sep 2020 16:36:27 +0100
Message-Id: <20200909153628.2904888-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
References: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
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
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e603e2d3be16..fc922dd9ccde 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1707,9 +1707,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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

