Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0519AB8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfEJJfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 05:35:55 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:33330 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfEJJfz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 05:35:55 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id D30F2434E;
        Fri, 10 May 2019 11:35:51 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 608a6a61;
        Fri, 10 May 2019 11:35:50 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 5/5] net: wireless: mt76: fix similar warning reported by kbuild test robot
Date:   Fri, 10 May 2019 11:35:18 +0200
Message-Id: <1557480918-9627-6-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557480918-9627-1-git-send-email-ynezz@true.cz>
References: <1557480918-9627-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes following (similar) warning reported by kbuild test robot:

 In function ‘memcpy’,
  inlined from ‘smsc75xx_init_mac_address’ at drivers/net/usb/smsc75xx.c:778:3,
  inlined from ‘smsc75xx_bind’ at drivers/net/usb/smsc75xx.c:1501:2:
  ./include/linux/string.h:355:9: warning: argument 2 null where non-null expected [-Wnonnull]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/usb/smsc75xx.c: In function ‘smsc75xx_bind’:
  ./include/linux/string.h:355:9: note: in a call to built-in function ‘__builtin_memcpy’

I've replaced the offending memcpy with ether_addr_copy, because I'm
100% sure, that of_get_mac_address can't return NULL as it returns valid
pointer or ERR_PTR encoded value, nothing else.

I'm hesitant to just change IS_ERR into IS_ERR_OR_NULL check, as this
would make the warning disappear also, but it would be confusing to
check for impossible return value just to make a compiler happy.

I'm now changing all occurencies of memcpy to ether_addr_copy after the
of_get_mac_address call, as it's very likely, that we're going to get
similar reports from kbuild test robot in the future.

Fixes: d31a36b5f407 ("net: wireless: support of_get_mac_address new ERR_PTR error")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 04964937a3af..b7a49ae6b327 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -95,7 +95,7 @@
 
 	mac = of_get_mac_address(np);
 	if (!IS_ERR(mac))
-		memcpy(dev->macaddr, mac, ETH_ALEN);
+		ether_addr_copy(dev->macaddr, mac);
 #endif
 
 	if (!is_valid_ether_addr(dev->macaddr)) {
-- 
1.9.1

