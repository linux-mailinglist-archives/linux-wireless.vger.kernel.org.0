Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F80227A82
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGUIT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 04:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgGUIT3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 04:19:29 -0400
Received: from lore-desk.redhat.com (unknown [151.48.143.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F8620720;
        Tue, 21 Jul 2020 08:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319568;
        bh=ahYmlHcuyF/trozgYMlx24U5x2wu1v4aDv9Qkb4PwOw=;
        h=From:To:Cc:Subject:Date:From;
        b=vl8rvNUKm6Yro75nqOa7q43K2JOnbHzoToL6+wFeguPgavgK5bZu0dYgx4DclAsnY
         0vO0wkrfW2mGA5SzBxU3yovUVGLzKpAxkaHOhvokF6sO+hXNo2MG5bHTnWDmz6Ub30
         FHkAaJKapz9xynZ/PCcEd7Ro8ZwKLmC0rVNVf+/I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix possible memory leak in mt7615_mcu_wtbl_sta_add
Date:   Tue, 21 Jul 2020 10:19:22 +0200
Message-Id: <7c17fa2c123ae13c3c77a45a3659d19f986a85b8.1595319246.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free the second mcu skb if __mt76_mcu_skb_send_msg() fails to transmit
the first one in mt7615_mcu_wtbl_sta_add().

Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 179412355ae5..d46287e2b19f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1366,8 +1366,12 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	skb = enable ? wskb : sskb;
 
 	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
-	if (err < 0)
+	if (err < 0) {
+		skb = enable ? sskb : wskb;
+		dev_kfree_skb(skb);
+
 		return err;
+	}
 
 	cmd = enable ? MCU_EXT_CMD_STA_REC_UPDATE : MCU_EXT_CMD_WTBL_UPDATE;
 	skb = enable ? sskb : wskb;
-- 
2.26.2

