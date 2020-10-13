Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABA228D03B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgJMOae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbgJMOad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 10:30:33 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Oct 2020 07:30:32 PDT
Received: from mail.blocktrron.ovh (mars.blocktrron.ovh [IPv6:2001:41d0:401:3000::cbd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEEBC0613D0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Oct 2020 07:30:32 -0700 (PDT)
Received: from localhost.localdomain (p200300e53f108a00dce3cb5728203c5a.dip0.t-ipconnect.de [IPv6:2003:e5:3f10:8a00:dce3:cb57:2820:3c5a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id ADFB226EC4;
        Tue, 13 Oct 2020 16:23:38 +0200 (CEST)
From:   David Bauer <mail@david-bauer.net>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Cc:     dev@andreas-ziegler.de, Ron Asimi <ron.asimi@gmail.com>
Subject: [PATCH] mt76: mt7603: add additional EEPROM chip ID
Date:   Tue, 13 Oct 2020 16:23:26 +0200
Message-Id: <20201013142326.8361-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some newer MT7628 based routers (notably the TP-Link Archer C50 v4) are
shipped with a chip-id of 0x7600 in the on-flash EEPROM. Add this as a
possible valid ID.

Ref: https://bugs.openwrt.org/index.php?do=details&task_id=2781

Suggested-by: Ron Asimi <ron.asimi@gmail.com>
Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 3ee06e2577b8..422b9d9e8962 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -141,6 +141,7 @@ static int mt7603_check_eeprom(struct mt76_dev *dev)
 	switch (val) {
 	case 0x7628:
 	case 0x7603:
+	case 0x7600:
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.28.0

