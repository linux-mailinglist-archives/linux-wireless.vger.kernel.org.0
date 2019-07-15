Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6438769EB6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 00:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfGOWJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jul 2019 18:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGOWJe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jul 2019 18:09:34 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145832145D;
        Mon, 15 Jul 2019 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563228573;
        bh=DcE4+64A4nHxapEGOKJKDEj369HjauWVXPc0Zli6qqE=;
        h=From:To:Cc:Subject:Date:From;
        b=Xxd73u3sdSKtl1i5aufg+I9jK7cwQZl369kLdHCSJ9iBTlNtB7phQKSjBHpPj9bOK
         F11Yy5+4qK/M94KgT3R1MZr9VaLYQL3QvUdgu2XziQq5NngZ4SZpOs8Wbott5LqQbS
         VKQ6RyjwHoimhPEeTDx7J/AKLWTZbYcL5HmwC06M=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: [PATCH v2] mac80211: add IEEE80211_KEY_FLAG_GENERATE_MMIE to ieee80211_key_flags
Date:   Tue, 16 Jul 2019 00:09:19 +0200
Message-Id: <dfe275f9aa0f1cc6b33085f9efd5d8447f68ad13.1563228405.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add IEEE80211_KEY_FLAG_GENERATE_MMIE flag to ieee80211_key_flags in order
to allow the driver to notify mac80211 to generate MMIE and that it
requires sequence number generation only.
This is a preliminary patch to add BIP_CMAC_128 hw support to mt7615
driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- rename IEEE80211_KEY_FLAG_PUT_MMIE_SPACE in IEEE80211_KEY_FLAG_GENERATE_MMIE
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/wpa.c     | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da013f7c0..a655de2c65dd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1702,6 +1702,9 @@ struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
  *	a TKIP key if it only requires MIC space. Do not set together with
  *	@IEEE80211_KEY_FLAG_GENERATE_MMIC on the same key.
  * @IEEE80211_KEY_FLAG_NO_AUTO_TX: Key needs explicit Tx activation.
+ * @IEEE80211_KEY_FLAG_GENERATE_MMIE: This flag should be set by the driver
+ *	for a AES_CMAC key to indicate that it requires sequence number
+ *	generation only
  */
 enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_GENERATE_IV_MGMT	= BIT(0),
@@ -1714,6 +1717,7 @@ enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_RESERVE_TAILROOM	= BIT(7),
 	IEEE80211_KEY_FLAG_PUT_MIC_SPACE	= BIT(8),
 	IEEE80211_KEY_FLAG_NO_AUTO_TX		= BIT(9),
+	IEEE80211_KEY_FLAG_GENERATE_MMIE	= BIT(10),
 };
 
 /**
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index a51c7909366e..f5845af9a449 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -946,7 +946,8 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 
 	info = IEEE80211_SKB_CB(skb);
 
-	if (info->control.hw_key)
+	if (info->control.hw_key &&
+	    !(key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_MMIE))
 		return TX_CONTINUE;
 
 	if (WARN_ON(skb_tailroom(skb) < sizeof(*mmie)))
@@ -962,6 +963,9 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 
 	bip_ipn_set64(mmie->sequence_number, pn64);
 
+	if (info->control.hw_key)
+		return TX_CONTINUE;
+
 	bip_aad(skb, aad);
 
 	/*
-- 
2.21.0

