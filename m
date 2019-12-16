Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00E1216D8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfLPScW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 13:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfLPScV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 13:32:21 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB686207FF;
        Mon, 16 Dec 2019 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576521140;
        bh=2Rr7S+BHnMwk5f9jNJ8U1LMGgMiGoUWHfMb/bgKUMJw=;
        h=From:To:Cc:Subject:Date:From;
        b=wzdDg/65Q/KqFwvZkyNlxz7UMMhFh1zahPSO5HaQBppiuKdFWm0lN0zQD0ql5xkAH
         4oVVmMpO67trT6jsUUBCCWvc/g0dNdlmTTs7ctEp8CZHyGtk3hkFux5YrT8bUrEZsw
         phNFDeupJLz380bwZMNu4xi8ECqoLdMA/ptCHZyA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com
Subject: [PATCH] mt76: fix compilation warning in mt76_eeprom_override()
Date:   Mon, 16 Dec 2019 19:32:10 +0100
Message-Id: <a64aaf778d3d144a46678f2833db2ec0afa3c58a.1576521036.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following compilation warning in mt76_eeprom_override routine
when CONFIG_OF is not set and label 'out' is not actually used

drivers/net/wireless/mediatek/mt76/eeprom.c: In function ‘mt76_eeprom_override’:
drivers/net/wireless/mediatek/mt76/eeprom.c:100:1: warning: label ‘out’ defined but not used [-Wunused-label]

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 8f2693748faf..c236e303ccfd 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -87,17 +87,14 @@ mt76_eeprom_override(struct mt76_dev *dev)
 {
 #ifdef CONFIG_OF
 	struct device_node *np = dev->dev->of_node;
-	const u8 *mac;
+	const u8 *mac = NULL;
 
-	if (!np)
-		goto out;
-
-	mac = of_get_mac_address(np);
-	if (!IS_ERR(mac))
+	if (np)
+		mac = of_get_mac_address(np);
+	if (!IS_ERR_OR_NULL(mac))
 		ether_addr_copy(dev->macaddr, mac);
 #endif
 
-out:
 	if (!is_valid_ether_addr(dev->macaddr)) {
 		eth_random_addr(dev->macaddr);
 		dev_info(dev->dev,
-- 
2.21.0

