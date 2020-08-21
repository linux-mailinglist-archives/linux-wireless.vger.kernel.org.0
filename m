Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C424D14E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHUJUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 05:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHUJUG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 05:20:06 -0400
Received: from lore-desk.redhat.com (unknown [151.48.139.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6936207DA;
        Fri, 21 Aug 2020 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598001606;
        bh=x8lsLAUKN4w5AQhotb6Di6BMjhDcDyVm5uPhBjD5yDE=;
        h=From:To:Cc:Subject:Date:From;
        b=aHPdvPoKfD+MJXtjGuBw2qlCM9+IeXj33qc52ch7wvgqpGskIHXd88E4UD1w5/Ka6
         +fw3Ukaw3uVhOimLJ4wA0jg0Mt5wLm5QhKdk5ZZGWfHXmJKbJ34rBdiNihR9XA/eN8
         xPlZDsBmf2dL08F4esnQHcOd9ckMM1QfeTWQ0Xk8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix possible memory leak in mt7615_tm_set_tx_power
Date:   Fri, 21 Aug 2020 11:19:51 +0200
Message-Id: <df64ab1001dd2374190cd6e35631bd2945e53528.1598001436.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a memory leak in mt7615_tm_set_tx_power routine if
mt7615_eeprom_get_target_power_index fails.
Moreover do not account req_header twice in mcu skb allocation.

Fixes: 4f0bce1c88882 ("mt76: mt7615: implement testmode support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index 1730751133aa..2cfa58d49832 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -70,7 +70,7 @@ mt7615_tm_set_tx_power(struct mt7615_phy *phy)
 	if (dev->mt76.test.state != MT76_TM_STATE_OFF)
 		tx_power = dev->mt76.test.tx_power;
 
-	len = sizeof(req_hdr) + MT7615_EE_MAX - MT_EE_NIC_CONF_0;
+	len = MT7615_EE_MAX - MT_EE_NIC_CONF_0;
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req_hdr) + len);
 	if (!skb)
 		return -ENOMEM;
@@ -83,8 +83,10 @@ mt7615_tm_set_tx_power(struct mt7615_phy *phy)
 		int index;
 
 		ret = mt7615_eeprom_get_target_power_index(dev, chandef->chan, i);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_kfree_skb(skb);
 			return -EINVAL;
+		}
 
 		index = ret - MT_EE_NIC_CONF_0;
 		if (tx_power && tx_power[i])
-- 
2.26.2

