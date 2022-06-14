Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F154A454
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jun 2022 04:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352126AbiFNCHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 22:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351539AbiFNCGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 22:06:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139534652;
        Mon, 13 Jun 2022 19:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C71B2B816AC;
        Tue, 14 Jun 2022 02:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A77FC34114;
        Tue, 14 Jun 2022 02:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655172336;
        bh=WVB2cZoIsM8ti2+D/PLRAPxWV297NPg1wTNvLUzUnTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1BoGgK2VKVd79okHn2mkEZJYe7ASt9WqjKI/AEV72Vzn5BeKeidYwxKYwH56ZVrK
         xDZucanulIlahGj9ZHrwmuy3WMR5CeguAbiP4FvjTfPEgSQr53AXuqxREPi87atPTR
         uPmPx2T4KKe7mKigklsVhGbaACHw49p0tzwEP5QIgob0B+7TXhtxO9AXVs6h9tadIF
         uNDkobcB3HFbFzHNM7cXxgmR2kKgdxbrQJYysDQTWcBeQCrkbYWZSOA8xByPDlTADd
         Nv1O117XCp1uTxToKJQJ02RPlptbkTAfJGd/cu3SY6odYCUpOMgmWf8SGG1xoP+Wq2
         v2+L4IccoDxTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lauro.venancio@openbossa.org,
        aloisio.almeida@openbossa.org, sameo@linux.intel.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 32/47] nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred
Date:   Mon, 13 Jun 2022 22:04:25 -0400
Message-Id: <20220614020441.1098348-32-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614020441.1098348-1-sashal@kernel.org>
References: <20220614020441.1098348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>

[ Upstream commit 8a4d480702b71184fabcf379b80bf7539716752e ]

Similar to the handling of play_deferred in commit 19cfe912c37b
("Bluetooth: btusb: Fix memory leak in play_deferred"), we thought
a patch might be needed here as well.

Currently usb_submit_urb is called directly to submit deferred tx
urbs after unanchor them.

So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
and cause memory leak.

Put those urbs in tx_anchor to avoid the leak, and also fix the error
handling.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220607083230.6182-1-xiaohuizhang@ruc.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/nfcmrvl/usb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/usb.c b/drivers/nfc/nfcmrvl/usb.c
index a99aedff795d..ea7309453096 100644
--- a/drivers/nfc/nfcmrvl/usb.c
+++ b/drivers/nfc/nfcmrvl/usb.c
@@ -388,13 +388,25 @@ static void nfcmrvl_play_deferred(struct nfcmrvl_usb_drv_data *drv_data)
 	int err;
 
 	while ((urb = usb_get_from_anchor(&drv_data->deferred))) {
+		usb_anchor_urb(urb, &drv_data->tx_anchor);
+
 		err = usb_submit_urb(urb, GFP_ATOMIC);
-		if (err)
+		if (err) {
+			kfree(urb->setup_packet);
+			usb_unanchor_urb(urb);
+			usb_free_urb(urb);
 			break;
+		}
 
 		drv_data->tx_in_flight++;
+		usb_free_urb(urb);
+	}
+
+	/* Cleanup the rest deferred urbs. */
+	while ((urb = usb_get_from_anchor(&drv_data->deferred))) {
+		kfree(urb->setup_packet);
+		usb_free_urb(urb);
 	}
-	usb_scuttle_anchored_urbs(&drv_data->deferred);
 }
 
 static int nfcmrvl_resume(struct usb_interface *intf)
-- 
2.35.1

