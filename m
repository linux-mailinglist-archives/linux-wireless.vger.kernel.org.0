Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A63353408
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Apr 2021 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhDCMf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Apr 2021 08:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhDCMf1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Apr 2021 08:35:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5A386121F;
        Sat,  3 Apr 2021 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617453324;
        bh=uDQ6q4qUKnpZVF4UWarGNBvgB2f/VXPNnVcQWsK2AiE=;
        h=From:To:Cc:Subject:Date:From;
        b=KBCOM7Lciaq6QQu4J8SdzuLGPvOI0pqsKhZAUpxPF31/a2WW6rX9cMyC8XY/WI6a6
         zBANR27dlQpWQZ3G8CWnwb/tIJbpztLU5cH1e8SlzqB/JTgwKy2J06nxf6+kY5ric5
         RZNAqPPpy4dX+ikVh55y5k6ny8bWEQ4GNquppd5vep8BPMRTPdoOO2uBsDaWaqyMwV
         WXB7Cp+3QKJlU1QWsgcXAOzuUBTIHcfmuMuFYkEUZQ+PKNc6YCIC9+ByArbTwK6Qu4
         PkBIQs8mYk73Xu0V13RuLl0YPYrFHA+xBNZGWc0+98u6wI6nkLJlmw775HH4mbvzVT
         yYJxFcMedXLAw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, leon.yen@mediatek.com
Subject: [PATCH] mt76: mt7921: rework mt7921_mcu_debug_msg_event routine
Date:   Sat,  3 Apr 2021 14:35:12 +0200
Message-Id: <c7882c1daae536299dba56cacbd894b026277e39.1617453256.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rework mt7921_mcu_debug_msg_event routing removing unnecessary
assignments and relying on wiphy_info

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index b0ece9eae858..e44ce9bdfa9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -485,29 +485,27 @@ mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 static void
 mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
-	struct mt7921_mcu_rxd *rxd = (struct mt7921_mcu_rxd *)skb->data;
-	struct debug_msg {
+	struct mt7921_debug_msg {
 		__le16 id;
 		u8 type;
 		u8 flag;
 		__le32 value;
 		__le16 len;
 		u8 content[512];
-	} __packed * debug_msg;
-	u16 cur_len;
-	int i;
-
-	skb_pull(skb, sizeof(*rxd));
-	debug_msg = (struct debug_msg *)skb->data;
+	} __packed * msg;
 
-	cur_len = min_t(u16, le16_to_cpu(debug_msg->len), 512);
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	msg = (struct mt7921_debug_msg *)skb->data;
 
-	if (debug_msg->type == 0x3) {
-		for (i = 0 ; i < cur_len; i++)
-			if (!debug_msg->content[i])
-				debug_msg->content[i] = ' ';
+	if (msg->type == 3) { /* fw log */
+		u16 len = min_t(u16, le16_to_cpu(msg->len), 512);
+		int i;
 
-		dev_dbg(dev->mt76.dev, "%s", debug_msg->content);
+		for (i = 0 ; i < len; i++) {
+			if (!msg->content[i])
+				msg->content[i] = ' ';
+		}
+		wiphy_info(mt76_hw(dev)->wiphy, "%*s", len, msg->content);
 	}
 }
 
-- 
2.30.2

