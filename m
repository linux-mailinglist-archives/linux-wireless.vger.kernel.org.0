Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1D119DA2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 23:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfLJWjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 17:39:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbfLJWdY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 17:33:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F0FF207FF;
        Tue, 10 Dec 2019 22:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017204;
        bh=7sTMV4vwJ45KNn4+KXTelyUht4p4Xd+WKHQCFHdyEV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGlOjmtAp4bFuJUdCwX1aQm4+/Rxm+F20ZjCaM9NsiUjs3N6kMirgFbBr3apY7Apg
         kX8sMaEx2Dwq1EsohC23eNXzDAYW6sxhWt+ARwIdpcr/RmqoZ2Erp6weYCnSTs6eEs
         ATW6JW8Zx7P5u2JwROJbt2Zp+e9dhbmYJtXMgUuw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/71] rtlwifi: prevent memory leak in rtl_usb_probe
Date:   Tue, 10 Dec 2019 17:32:11 -0500
Message-Id: <20191210223316.14988-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 3f93616951138a598d930dcaec40f2bfd9ce43bb ]

In rtl_usb_probe if allocation for usb_data fails the allocated hw
should be released. In addition the allocated rtlpriv->usb_data should
be released on error handling path.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index ad8390d2997b2..9408c1f8e3977 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1094,8 +1094,10 @@ int rtl_usb_probe(struct usb_interface *intf,
 	rtlpriv->hw = hw;
 	rtlpriv->usb_data = kzalloc(RTL_USB_MAX_RX_COUNT * sizeof(u32),
 				    GFP_KERNEL);
-	if (!rtlpriv->usb_data)
+	if (!rtlpriv->usb_data) {
+		ieee80211_free_hw(hw);
 		return -ENOMEM;
+	}
 
 	/* this spin lock must be initialized early */
 	spin_lock_init(&rtlpriv->locks.usb_lock);
@@ -1158,6 +1160,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 	_rtl_usb_io_handler_release(hw);
 	usb_put_dev(udev);
 	complete(&rtlpriv->firmware_loading_complete);
+	kfree(rtlpriv->usb_data);
 	return -ENODEV;
 }
 EXPORT_SYMBOL(rtl_usb_probe);
-- 
2.20.1

