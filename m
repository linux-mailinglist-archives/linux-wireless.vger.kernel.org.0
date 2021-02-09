Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB35E314DAC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 11:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhBIK5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 05:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhBIKzO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 05:55:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D604164E30;
        Tue,  9 Feb 2021 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612868073;
        bh=ZPxHDBkx5wOh5HwxUhHGTm0f3SWVwQyBWDKIQdYsB+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkKQAcfYcb1VwCGKvZFcs0CtbEZKHb2+Dp5P+WnlFCSpz14W/EDhfebWhTobd6phI
         C/ItXv5qix07JgzaCt7EcJhFBFtMmuRfghT/uwwaAEggqCthSy91GEhcTdY7rXnzMi
         R3o35Q/5S+3NNyCeODwdNVGyJVBeJaDn7a+no/ohUzkwTu7YToMVgldi2cdPix0TO7
         ypG7k4/iIR7dJp5uEzbhMCnpaghbjtjTywySzPZPQqaZOGge2rB6UHSVY1cUaYCPB0
         D3IB4dWtJXBI0TlL6FZnzuckeNBEYUxORnA3O9uWfpi86QWuGanz92HVN08Nihj+B5
         jqZLTBhd+Wqdg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 4/6] mt76: mt7921: add flush operation
Date:   Tue,  9 Feb 2021 11:54:05 +0100
Message-Id: <e88c62ef501ac065897a678a04e133afbaebb31c.1612867656.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612867656.git.lorenzo@kernel.org>
References: <cover.1612867656.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add flush operation to make sure cfg80211_mlme_deauth is able to flush
the deauthtication frame into air immediately.

Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 617e48f243f3..e6843c9ff145 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1120,6 +1120,15 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 }
 #endif /* CONFIG_PM */
 
+static void mt7921_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 u32 queues, bool drop)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	wait_event_timeout(dev->mt76.tx_wait, !mt76_has_tx_pending(&dev->mphy),
+			   HZ / 2);
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt7921_tx,
 	.start = mt7921_start,
@@ -1158,4 +1167,5 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_wakeup = mt7921_set_wakeup,
 	.set_rekey_data = mt7921_set_rekey_data,
 #endif /* CONFIG_PM */
+	.flush = mt7921_flush,
 };
-- 
2.29.2

