Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1B5903E9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiHKQ15 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiHKQ0j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 12:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF369A954;
        Thu, 11 Aug 2022 09:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8E561426;
        Thu, 11 Aug 2022 16:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFD9C433C1;
        Thu, 11 Aug 2022 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660234086;
        bh=T28FyA/NNNhylR3hPMcHZhmqLIObadBJHyivF7eBngM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSV17MVhOYrRWLcuhPIKi66EzprEvxICX2cHUS2xglmLmfCJg+Bbtn7Ei47KUWsDw
         sFsISM0PQttw6r3dWV1Nwar2jj1qI9SreexzXGzX3fap/C4HbFt0YVjLhE4bbZcRKd
         3KQ1FaE+auqUugSdn38BwR3r6sAEfoR7+4XpHSG8vqDPLffMySI7ARsuj8hzJ6KTou
         ceZ5Jih+TVQ0ag5IVJJgYFQWbvJdUeTjF9KS19s+gOm/lJ0ZBctltEP5OXYf+Tnvf6
         sfFi1q9XIW3V0yqo/4K8TGoH+5OVE3hRwXU0fF1XRM0xYSliVRf134RhuwpnQYDXhq
         3yU6foKjLy4Hg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zheyu Ma <zheyuma97@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, Jes.Sorensen@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 42/46] wifi: rtl8xxxu: Fix the error handling of the probe function
Date:   Thu, 11 Aug 2022 12:04:06 -0400
Message-Id: <20220811160421.1539956-42-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811160421.1539956-1-sashal@kernel.org>
References: <20220811160421.1539956-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zheyu Ma <zheyuma97@gmail.com>

[ Upstream commit 13876f2a087ad352bf640a7a0a4a4229ea6e9e4f ]

When the driver fails at ieee80211_alloc_hw() at the probe time, the
driver will free the 'hw' which is not allocated, causing a bug.

The following log can reveal it:

[   15.981294] BUG: KASAN: user-memory-access in mutex_is_locked+0xe/0x40
[   15.981558] Read of size 8 at addr 0000000000001ab0 by task modprobe/373
[   15.982583] Call Trace:
[   15.984282]  ieee80211_free_hw+0x22/0x390
[   15.984446]  rtl8xxxu_probe+0x3a1/0xab30 [rtl8xxxu]

Fix the bug by changing the order of the error handling.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220716130444.2950690-1-zheyuma97@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 0d374a294840..1d4ff9f6cbf4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6606,7 +6606,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	if (!hw) {
 		ret = -ENOMEM;
 		priv = NULL;
-		goto exit;
+		goto err_put_dev;
 	}
 
 	priv = hw->priv;
@@ -6629,24 +6629,24 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 
 	ret = rtl8xxxu_parse_usb(priv, interface);
 	if (ret)
-		goto exit;
+		goto err_set_intfdata;
 
 	ret = rtl8xxxu_identify_chip(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to identify chip\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	ret = rtl8xxxu_read_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to read EFuse\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	ret = priv->fops->parse_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to parse EFuse\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	rtl8xxxu_print_chipinfo(priv);
@@ -6654,12 +6654,12 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	ret = priv->fops->load_firmware(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to load firmware\n");
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	ret = rtl8xxxu_init_device(hw);
 	if (ret)
-		goto exit;
+		goto err_set_intfdata;
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
@@ -6709,12 +6709,12 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	if (ret) {
 		dev_err(&udev->dev, "%s: Failed to register: %i\n",
 			__func__, ret);
-		goto exit;
+		goto err_set_intfdata;
 	}
 
 	return 0;
 
-exit:
+err_set_intfdata:
 	usb_set_intfdata(interface, NULL);
 
 	if (priv) {
@@ -6722,9 +6722,10 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		mutex_destroy(&priv->usb_buf_mutex);
 		mutex_destroy(&priv->h2c_mutex);
 	}
-	usb_put_dev(udev);
 
 	ieee80211_free_hw(hw);
+err_put_dev:
+	usb_put_dev(udev);
 
 	return ret;
 }
-- 
2.35.1

