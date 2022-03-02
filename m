Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9F4CAF13
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiCBTw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiCBTw0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 14:52:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7CFD95D8
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 11:51:42 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so5966952ejb.13
        for <linux-wireless@vger.kernel.org>; Wed, 02 Mar 2022 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRoBG7B0zH0T2Cz4z4vAwwSe16WQ3ILZgUAbzOIFsNc=;
        b=K0OBZ7grkGPMVqdFKYZXXKZdC4KgpmdEWNFFzR5UjHlv+iaWCuyN5V3DnjZwJkvOu/
         3f9OIw201YuRfByTzmunSRU2q8ViIJnfrBN5sr3B8JW8NSAyoTVZLWZaGzPVQakWh9LZ
         eE6GhNB/Ry10VwImGU6nQWHw+5Yec/VqkwWAgWywrFnuNz+bO8JEWqsfalNpAK5Elbqz
         oetgOUxVEK30iHSOTKp43xmUpXGN2T7Ip4SBH/fiNUQrGq7TVB1hRoUu1fyIN+0crSgk
         apR2GQqB0gUXahOG83jlnckuM3w5JoiPfBABuN20ur5YrHzGiTQreSMoMuw5JNWmEMSY
         hezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRoBG7B0zH0T2Cz4z4vAwwSe16WQ3ILZgUAbzOIFsNc=;
        b=ma6rbbl+eJ6Kthd6N5SwPhT8iCltSNVmP0duyv4ovLTEJXyzfyUsptMLrdZtZXnI5a
         6GN2n966nTa/rO6WklAGT2rxgmtfaPun9gOy3/eeTqEwrtMrYCWhWkd7T5iRt5EJxNk/
         MNCCMDJXxioM1SKPBLeuo90LMNuE03//jGjGN1Y6OLdL0qSgAFXbZE4/94c4qKWm9h50
         xZkhC1BL9cO//YG+/qxw1MpZfRaZ74yokY3g5KiB5TXF+KckV1mhZgMYYVovuV4MZogU
         aqIuW7XzIg7o0XS1yW5CiSnp7WPaZbunyC2yC/FG6vgWQ+n8W/MvMlI46QsxsDTMWNg/
         XUZw==
X-Gm-Message-State: AOAM532fv/N/CkETn3kDX8mTpnLd8zOniMisHw/jydsgKhr8oauIYmru
        HgyZI8UUcmfoI2WtFDJOLviI7nyCMco=
X-Google-Smtp-Source: ABdhPJzQvNOonSOApOmECH3r7vaz9ot8uaA4BHEjmTSTtMR2XLnMegT5BAEjesJS783xyg/wylTHbA==
X-Received: by 2002:a17:907:6e24:b0:6d9:43f1:d3ce with SMTP id sd36-20020a1709076e2400b006d943f1d3cemr4003419ejc.166.1646250701068;
        Wed, 02 Mar 2022 11:51:41 -0800 (PST)
Received: from debian64.daheim (p5b0d776b.dip0.t-ipconnect.de. [91.13.119.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906724600b006d4e2f6857dsm6620806ejk.139.2022.03.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:51:38 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nPV0c-000IPA-IM;
        Wed, 02 Mar 2022 20:51:38 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v1 5/5] carl9170: devres ar->survey_info
Date:   Wed,  2 Mar 2022 20:51:38 +0100
Message-Id: <9b9a059b384f49587f4384ba47f01d3fb2115b22.1646250537.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <0a79221aa5477501c3def032e95ef8018973a514.1646250537.git.chunkeey@gmail.com>
References: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com> <d1c16490462a9371ab3cc16a018ef5e08382a35e.1646250537.git.chunkeey@gmail.com> <f81a6ff3b02116c6a448c42eecb546ea5d46c108.1646250537.git.chunkeey@gmail.com> <0a79221aa5477501c3def032e95ef8018973a514.1646250537.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

driver keeps the same survey_info struct for its lifetime around.
This is used because while firmware does help by providing accounting
information of the current channel, it doesn't keep track on the
remaining channels.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/carl9170/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index fae927ca4863..76e84adf57c1 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1916,7 +1916,8 @@ static int carl9170_parse_eeprom(struct ar9170 *ar)
 	if (!bands)
 		return -EINVAL;
 
-	ar->survey = kcalloc(chans, sizeof(struct survey_info), GFP_KERNEL);
+	ar->survey = devm_kcalloc(&ar->udev->dev, chans,
+				  sizeof(struct survey_info), GFP_KERNEL);
 	if (!ar->survey)
 		return -ENOMEM;
 	ar->num_channels = chans;
@@ -2046,9 +2047,6 @@ void carl9170_free(struct ar9170 *ar)
 	kfree_skb(ar->rx_failover);
 	ar->rx_failover = NULL;
 
-	kfree(ar->survey);
-	ar->survey = NULL;
-
 	mutex_destroy(&ar->mutex);
 
 	ieee80211_free_hw(ar->hw);
-- 
2.35.1

