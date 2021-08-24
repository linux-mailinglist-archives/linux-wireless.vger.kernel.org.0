Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980D03F6865
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhHXRuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbhHXRuC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 13:50:02 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18220C0F26CC
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 10:11:11 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso42900371otp.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvhpETrEpcbNS5tm6bQ3pCjBYg+a71Wh95ngB5PZYBE=;
        b=AOzGiPFS13S44pAap29oALDR+4evL+IZW+yZrvzYI0T1p/5RbsaugSmkNhL2jrtoJU
         +Hj1lt5hKsOlTgEkuncuJXnTeBTHtcB7yoF3J755EAtQjIEJf3Sj92lU1wat5orlB2J+
         sDUdqli6kx+wu2MU3pk63OMZdoeNIkkbGK1nqSEGXsMMz/NgH1EaWAldDktdLJqRLqZw
         nZWoW5pejn175qs4teV8oZlfzEgZRfdAFtGBpI0yUqvKoMoi771sHIKahEzrMf12uFGc
         kmFoPO7cJy3QA1zK+BtDzRd9yb4rZ1UNUd3pKiU0cUkzOak9k/kbOz+qekbAqIrxKSjs
         NAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvhpETrEpcbNS5tm6bQ3pCjBYg+a71Wh95ngB5PZYBE=;
        b=ryDRKJZ59/+FUHWPM/lfm8+2SXxxxF5jlP+ZM2X6KIZEUcQCM3qW/0hhyPrjw1w8ZE
         hwOpo3YJ22A50TkJ36XGCL9nWIVDo72Bg+9i8w/25AGXZLgnoKG3GrlIHzjLNeYmedGK
         Xfz9fclOlX6tf7osKMK7zX8NDrRj7LxgfCmMkwMMycntfzBHtMnygSmEZWTNY2ay5JRR
         s+RjWqpw1piY6kYc3/GtU3n5y7+aafIV+910PBfsZlKxaB6XxtTMidFyinU+xpDf5e0E
         R2A/P6LQq6UwDwoA94rO0aVJ+6HnCUqllACHApraRd7hrz2fhkKroqUp2wtgmQQdfR/y
         WtNw==
X-Gm-Message-State: AOAM531e8qyEYuLJKYCpdPY4yOtwWERvM3WAwCM9tZF5PxUralmz+d5q
        86xjzJp04Ud/Nl9j8/j+r5SNfw==
X-Google-Smtp-Source: ABdhPJw7ciWfxqB71e4RSCRJJxzK+nKwfBFMu3mHYumW2+F97O/lOwbyNKxlfTwFzOw0wH4GtZH8rg==
X-Received: by 2002:a9d:1d25:: with SMTP id m34mr32755207otm.313.1629825070322;
        Tue, 24 Aug 2021 10:11:10 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v29sm4213475ooe.31.2021.08.24.10.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:11:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linaro.org>
Subject: [RESEND PATCH] wcn36xx: Allow firmware name to be overridden by DT
Date:   Tue, 24 Aug 2021 10:12:25 -0700
Message-Id: <20210824171225.686683-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WLAN NV firmware blob differs between platforms, and possibly
devices, so add support in the wcn36xx driver for reading the path of
this file from DT in order to allow these files to live in a generic
file system (or linux-firmware).

For some reason the parent (wcnss_ctrl) also needs to upload this blob,
so rather than specifying the same information in both nodes wcn36xx
reads the string from the parent's of_node.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Aníbal Limón <anibal.limon@linaro.org>
---

This was previously part of a series spanning multiple subsystems, picked up
tested-bys and resending alone in hope that it can be merged.

https://lore.kernel.org/linux-arm-msm/20210312003318.3273536-3-bjorn.andersson@linaro.org/

 drivers/net/wireless/ath/wcn36xx/main.c    | 7 +++++++
 drivers/net/wireless/ath/wcn36xx/smd.c     | 4 ++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index d202f2128df2..2ccf7a8924a0 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1500,6 +1500,13 @@ static int wcn36xx_probe(struct platform_device *pdev)
 		goto out_wq;
 	}
 
+	wcn->nv_file = WLAN_NV_FILE;
+	ret = of_property_read_string(wcn->dev->parent->of_node, "firmware-name", &wcn->nv_file);
+	if (ret < 0 && ret != -EINVAL) {
+		wcn36xx_err("failed to read \"firmware-name\" property\n");
+		goto out_wq;
+	}
+
 	wcn->smd_channel = qcom_wcnss_open_channel(wcnss, "WLAN_CTRL", wcn36xx_smd_rsp_process, hw);
 	if (IS_ERR(wcn->smd_channel)) {
 		wcn36xx_err("failed to open WLAN_CTRL channel\n");
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 0e3be17d8cea..57fa857b290b 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -504,10 +504,10 @@ int wcn36xx_smd_load_nv(struct wcn36xx *wcn)
 	u16 fm_offset = 0;
 
 	if (!wcn->nv) {
-		ret = request_firmware(&wcn->nv, WLAN_NV_FILE, wcn->dev);
+		ret = request_firmware(&wcn->nv, wcn->nv_file, wcn->dev);
 		if (ret) {
 			wcn36xx_err("Failed to load nv file %s: %d\n",
-				      WLAN_NV_FILE, ret);
+				    wcn->nv_file, ret);
 			goto out;
 		}
 	}
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 6121d8a5641a..a69cce883563 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -199,6 +199,7 @@ struct wcn36xx {
 	struct device		*dev;
 	struct list_head	vif_list;
 
+	const char		*nv_file;
 	const struct firmware	*nv;
 
 	u8			fw_revision;
-- 
2.29.2

