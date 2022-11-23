Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1C636C66
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiKWVan (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 16:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiKWVam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 16:30:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A9942DE
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:30:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n20so222683ejh.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM8MTmsKK4jhGM5CZp4XeMVfIEpojaLXrg9jUBCEeCc=;
        b=Tq0y1tIHjlGLk1S1Hf/oWvXsns8FZ0OoTJrC9uoaEejXlD6R2ESNpNsNOsIYV8lbbw
         dV4zAmL1WJUQQjyQC6fGIlUULEEUueTjIGYvW4K++OarIC0WutWHvHyVcclrM4xq69/i
         J5XxVuu39hmSaCwLAhO3BrgfeuHtBn2NnWUGPNxeIp7kh0wqx6UpXTq1qBt37bx9ZsqG
         qJL4IPl5l/QF2HCFK988ciUk9rZ3Cf7+iwyX7zjvkCtGgn5dZAfE1CQ1bDnTuMo0MYSY
         XtbVp6xMRLbU47lo2AhmSws95HDka9kaMS8DX3cFMjqYCAOC0CQxpXeVCWhmCL11a/da
         I1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AM8MTmsKK4jhGM5CZp4XeMVfIEpojaLXrg9jUBCEeCc=;
        b=N3OsuUWoyfsIZsX7TksnCxEKu1U1dAe1HZ71cF+SPw7KIQNgse9MToPuKo0ddreEgH
         qEl5S54J4IWT6GDWPmftUNv8z4jqIODADs8i3DIxMhcQz7m2GFSJ6eP/rva003RtgLGt
         vbVzLONaSzzxFtbJ6w036Ws5gLYlZT4u2NwYLXbW7G6ZjVJ2LfuTxdrEGFVxVIXYb5Dl
         4PiLUMasS3+t1GSOOCPu8cGkrU5BsOUzB9RWEPYNM+Wy427vdBImd1/v+pyV275q2i6F
         wwDH5LfB1vPMZgEhi725XeJhoIt5Yyi2HuRVfaNFQyG/BZnAkO2s3WstTah0sUgSKUfK
         gYww==
X-Gm-Message-State: ANoB5plGu7BkoYZyJx4Fol655h5wsljIA4N+MEQ+EuzJpxcedk3TWgcW
        +RxTFxf2J5mAA7cv9PiDHiZv7o/k9m0=
X-Google-Smtp-Source: AA0mqf5JP/PDwlil+gddiam/EeOK9Uj678SjoodOJyhn9YDnvvCN/KYuJaqnsiIa1gEXCT8HjqmvjQ==
X-Received: by 2002:a17:906:1b48:b0:78d:a136:732b with SMTP id p8-20020a1709061b4800b0078da136732bmr10171741ejg.135.1669239038784;
        Wed, 23 Nov 2022 13:30:38 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b007ae32daf4b9sm7584162ejk.106.2022.11.23.13.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 13:30:38 -0800 (PST)
Message-ID: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
Date:   Wed, 23 Nov 2022 23:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 1/2] wifi: rtl8xxxu: Fix the channel width reporting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The gen 2 chips RTL8192EU and RTL8188FU periodically send the driver
reports about the TX rate, and the driver passes these reports to
sta_statistics. The reports from RTL8192EU may or may not include the
channel width. The reports from RTL8188FU do not include it.

Only access the c2h->ra_report.bw field if the report (skb) is big
enough.

The other problem fixed here is that the code was actually never
changing the channel width initially reported by
rtl8xxxu_bss_info_changed because the value of RATE_INFO_BW_20 is 0.

Fixes: 0985d3a410ac ("rtl8xxxu: Feed current txrate information for mac80211")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 28f136064297..1c29d0bf09e2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5569,7 +5569,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 			rarpt->txrate.flags = 0;
 			rate = c2h->ra_report.rate;
 			sgi = c2h->ra_report.sgi;
-			bw = c2h->ra_report.bw;
 
 			if (rate < DESC_RATE_MCS0) {
 				rarpt->txrate.legacy =
@@ -5586,8 +5585,13 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 						RATE_INFO_FLAGS_SHORT_GI;
 				}
 
-				if (bw == RATE_INFO_BW_20)
-					rarpt->txrate.bw |= RATE_INFO_BW_20;
+				if (skb->len >= 2 + 7) {
+					if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
+						bw = RATE_INFO_BW_40;
+					else
+						bw = RATE_INFO_BW_20;
+					rarpt->txrate.bw = bw;
+				}
 			}
 			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
 			rarpt->bit_rate = bit_rate;
-- 
2.38.0
