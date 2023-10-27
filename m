Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF92B7D9080
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjJ0IA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJ0IA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 04:00:27 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B239F1A5
        for <linux-wireless@vger.kernel.org>; Fri, 27 Oct 2023 01:00:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:2087:0:640:7bf5:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 560D160AD5;
        Fri, 27 Oct 2023 10:59:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kxLb4GHW1Ko0-RumREi07;
        Fri, 27 Oct 2023 10:59:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698393586; bh=lKGfT/ZUcHsAp7BYh2JTjzrWjXSX98Wi8cGwDyNsMuk=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=sTdarNQ5A38hLqc71seujpKMx1325BiBm99wlYi6BA9ztE/uq3TOUuidL0HKUc1bK
         A8Ytwm+fi4LBb7eBr4lyuIffau6VFAlJBqkxklSrYgKzIlJ8XJeq5GB0TMdvRsFMUg
         VzTuL5FtHQvnxIlYHhwWYjJhoztKKehpad9dnsUw=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: fix USB device initialization sequence
Date:   Fri, 27 Oct 2023 10:59:17 +0300
Message-ID: <20231027075920.116006-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not ignore possible errors in '_rtl_usb_init()' and tweak error
handling in 'rtl_usb_probe()' to ensure that 'rtl_usb_cleanup()' is
called when needed. Minor style adjustments, compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 25 ++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 30bf2775a335..12b8a5fae947 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -332,10 +332,11 @@ static int _rtl_usb_init(struct ieee80211_hw *hw)
 	}
 	/* usb endpoint mapping */
 	err = rtlpriv->cfg->usb_interface_cfg->usb_endpoint_mapping(hw);
-	rtlusb->usb_mq_to_hwq =  rtlpriv->cfg->usb_interface_cfg->usb_mq_to_hwq;
-	_rtl_usb_init_tx(hw);
-	_rtl_usb_init_rx(hw);
-	return err;
+	if (err)
+		return err;
+	rtlusb->usb_mq_to_hwq = rtlpriv->cfg->usb_interface_cfg->usb_mq_to_hwq;
+	err = _rtl_usb_init_tx(hw);
+	return err ? err : _rtl_usb_init_rx(hw);
 }
 
 static void rtl_usb_init_sw(struct ieee80211_hw *hw)
@@ -1033,37 +1034,39 @@ int rtl_usb_probe(struct usb_interface *intf,
 	/* Init IO handler */
 	_rtl_usb_io_handler_init(&udev->dev, hw);
 	rtlpriv->cfg->ops->read_chip_version(hw);
-	/*like read eeprom and so on */
+	/* like read eeprom and so on */
 	rtlpriv->cfg->ops->read_eeprom_info(hw);
 	err = _rtl_usb_init(hw);
 	if (err)
-		goto error_out2;
+		goto out_usb_init;
 	rtl_usb_init_sw(hw);
 	/* Init mac80211 sw */
 	err = rtl_init_core(hw);
 	if (err) {
 		pr_err("Can't allocate sw for mac80211\n");
-		goto error_out2;
+		goto out_core_init;
 	}
 	if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
 		pr_err("Can't init_sw_vars\n");
-		goto error_out;
+		goto out;
 	}
 	rtl_init_sw_leds(hw);
 
 	err = ieee80211_register_hw(hw);
 	if (err) {
 		pr_err("Can't register mac80211 hw.\n");
-		goto error_out;
+		goto out;
 	}
 	rtlpriv->mac80211.mac80211_registered = 1;
 
 	set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
 	return 0;
 
-error_out:
+out:
 	rtl_deinit_core(hw);
-error_out2:
+out_core_init:
+	rtl_usb_cleanup(hw);
+out_usb_init:
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
 	complete(&rtlpriv->firmware_loading_complete);
-- 
2.41.0

