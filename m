Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED831FDE3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhBSRa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhBSRaZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:30:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94DE464EAF;
        Fri, 19 Feb 2021 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755765;
        bh=ik7TcAG6L+8HBvNfWMTac/K2JxK0lP1+MRKyTG9j8vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qev0CEiDiChF3FlY6I4xmHegqmaWoJPWaHFPeq5EnL840GWISYRfCzRfTirm4w0/o
         KrcpCgVO3UKITkQRBRDslCCEyQTwaCOQvOl4INaOIi9iZGAjA/F9WJWtRAutKRAUFQ
         0F8rOxn7sz19IuBQTfxVpC3c7CRm4weA/4ZiPTyx/n1CKvPXbyKawJnNmxJbPkmNPY
         JZ76Igc6RLBhA/Y2tIGUe6ufwBk/beMLg6EOKYOYIakM4bZieiswBLg8UKBs295a0g
         Gb9RdVpqTDkA2bxfybhpDUGl699slKuU81lBzV2l4a+M5PvfNgKudhLkSemyL5461y
         mYuInYxlIIVBQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2 6/8] mt76: mt7921: add flush operation
Date:   Fri, 19 Feb 2021 18:28:49 +0100
Message-Id: <6bb7f2f4862cebfe84c42fbfb332585bc56df910.1613755428.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613755428.git.lorenzo@kernel.org>
References: <cover.1613755428.git.lorenzo@kernel.org>
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
index 11d85cf9cfb8..f7552f5201b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1137,6 +1137,15 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
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
@@ -1175,4 +1184,5 @@ const struct ieee80211_ops mt7921_ops = {
 	.set_wakeup = mt7921_set_wakeup,
 	.set_rekey_data = mt7921_set_rekey_data,
 #endif /* CONFIG_PM */
+	.flush = mt7921_flush,
 };
-- 
2.29.2

