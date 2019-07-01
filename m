Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA595BC54
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfGANEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 09:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANEv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 09:04:51 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.13.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BC42173C;
        Mon,  1 Jul 2019 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561986290;
        bh=fcJ+mqXnXmzWFxB/r6FAvbq99QrEX+8pRHLTzQ2RBUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIkUxQNnhz7xxMfP8/bnkSM8LLtidCaoDXiHjyCPTEhKCmDQB/QrjTiJ6yefCHMvh
         AOIBYIES3xUSIl8Mf4rQGPrITD3qm9oLLOSD3RrTXOTRa5y5zep1cHC8YTtqghRIyx
         YHmnIkih7Pd+He2D5ZePB/unGHsS6GUf2frmrKdA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, s.gottschall@newmedia-net.de,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: [PATCH 1/2] mt76: mt7615: fall back to sw encryption for unsupported ciphers
Date:   Mon,  1 Jul 2019 15:04:39 +0200
Message-Id: <ad2dc0f14b8defe0e81ab269b698a669f6a8eac1.1561985981.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561985981.git.lorenzo@kernel.org>
References: <cover.1561985981.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix following warning falling back to sw encryption for unsupported
ciphers

WARNING: CPU: 2 PID: 1495 at backports-4.19.32-1/net/mac80211/key.c:1023
mt76_wcid_key_setup+0x68/0xbc [mt76]
CPU: 2 PID: 1495 Comm: hostapd Not tainted 4.14.131 #0
Stack : 00000000 8f0f8bc0 00000000 8007ccec 805f0000 8058ec18 00000000 00000000
	80559788 8dca79bc 8fefb10c 805c89c7 805545c8 00000001 8dca7960 53261662
	00000000 00000000 80640000 00004668 00000000 000000e9 00000007 00000000
	00000000 805d0000 00072537 00000000 80000000 00000000 805f0000 8f1e70d0
	8e8fa098 000003ff 805c0000 8f0f8bc0 00000001 802d4340 00000008 80630008
[<800108d0>] show_stack+0x58/0x100
[<8049214c>] dump_stack+0x9c/0xe0
[<80033998>] __warn+0xe0/0x138
[<80033a80>] warn_slowpath_null+0x1c/0x2c
[<8e8fa098>] mt76_wcid_key_setup+0x68/0xbc [mt76]
[<8e889930>] mt7615_eeprom_init+0x7c0/0xe14 [mt7615e]

Suggested-by: Sebastian Gottschall <s.gottschall@newmedia-net.de>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 1ee6dda579a8..8fefcfba83b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -178,6 +178,21 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
+	/* fall back to sw encryption for unsupported ciphers */
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_SMS4:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	if (cmd == SET_KEY) {
 		key->hw_key_idx = wcid->idx;
 		wcid->hw_key_idx = idx;
-- 
2.21.0

