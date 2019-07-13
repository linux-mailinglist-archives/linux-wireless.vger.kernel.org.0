Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495CB67AC3
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfGMPEA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 11:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPEA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 11:04:00 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B3F20850;
        Sat, 13 Jul 2019 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030240;
        bh=Jak/d+IRqVxcglo3a01YV2Bw6lP+PMzRagdjYo8qPDE=;
        h=From:To:Cc:Subject:Date:From;
        b=ENiZiYKMY/k78Wjd5PMVj5d7PzHqsDhUVFv8LHdgHilWCwoovNSFLD/e/9TtKi0Fz
         xZdtYGmIiVFvbYNpY0vnXCZIiQKfhI3hOaiW0WaUzRjQpK26TzHbJ08rG1ElmtuC9p
         HoZGKhk7OOOBYppEHeCEOOXpARxKvfhv8f5Jt1ek=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: [PATCH] mac80211: add IEEE80211_KEY_FLAG_PUT_MMIE_SPACE to ieee80211_key_flags
Date:   Sat, 13 Jul 2019 17:03:51 +0200
Message-Id: <1dd6dd782121d0b9cc32dec6a01db474e568ffb2.1563030033.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add IEEE80211_KEY_FLAG_PUT_MMIE_SPACE flag to ieee80211_key_flags in order
to allow the driver to notify mac80211 to allocate mmie space for AES_CMAC
hw cipher. Moreover mac80211 will set MMIE pn while MIC will be computed
in hw.
This is a preliminary patch to add BIP_CMAC_128 hw support to mt7615
driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/mac80211.h | 4 ++++
 net/mac80211/wpa.c     | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da013f7c0..204e5537def6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1702,6 +1702,9 @@ struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
  *	a TKIP key if it only requires MIC space. Do not set together with
  *	@IEEE80211_KEY_FLAG_GENERATE_MMIC on the same key.
  * @IEEE80211_KEY_FLAG_NO_AUTO_TX: Key needs explicit Tx activation.
+ * @IEEE80211_KEY_FLAG_PUT_MMIE_SPACE: This flag should be set by the driver
+ *	for a AES_CMAC key if it only requires MMIE space. Moreover mac80211
+ *	will compute PN MMIE
  */
 enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_GENERATE_IV_MGMT	= BIT(0),
@@ -1714,6 +1717,7 @@ enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_RESERVE_TAILROOM	= BIT(7),
 	IEEE80211_KEY_FLAG_PUT_MIC_SPACE	= BIT(8),
 	IEEE80211_KEY_FLAG_NO_AUTO_TX		= BIT(9),
+	IEEE80211_KEY_FLAG_PUT_MMIE_SPACE	= BIT(10),
 };
 
 /**
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index a51c7909366e..969597ddbb76 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -946,7 +946,8 @@ ieee80211_crypto_aes_cmac_encrypt(struct ieee80211_tx_data *tx)
 
 	info = IEEE80211_SKB_CB(skb);
 
-	if (info->control.hw_key)
+	if (info->control.hw_key &&
+	    !(key->conf.flags & IEEE80211_KEY_FLAG_PUT_MMIE_SPACE))
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

