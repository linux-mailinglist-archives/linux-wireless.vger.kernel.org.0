Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94E29110E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Oct 2020 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437817AbgJQJnp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Oct 2020 05:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437799AbgJQJnp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Oct 2020 05:43:45 -0400
Received: from localhost.localdomain (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C2E206CB;
        Sat, 17 Oct 2020 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602927824;
        bh=RUS0VSx5eKFTNj2G/DbDiPonE/UIbO0VdkS84xU2LCY=;
        h=From:To:Cc:Subject:Date:From;
        b=Jz4py4nLi30CJ7Gci6egMusFX+lu/G1Ca959Cw3uhZnwl8WavyzsqOjj+v0MElepJ
         bMKMI64Lr3afy6mgZN2Q5V4TIvnJosWxKQqTC2oDJjkuUzD5CS0oDivzGjGHT5F7LQ
         GfeW8uzM1riJdHgcv7h7EvWGo3hgUPVyOavQAvAo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, yn.chen@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: switch to wep sw crypto for mt7615/mt7915
Date:   Sat, 17 Oct 2020 11:43:35 +0200
Message-Id: <fd73b08e54b40ae07e1b8dbc63cbe5eb32cf37fe.1602927614.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Switch to wep sw crypto for mt7615/mt7915 since wtbl require a sta
reference and wep key is not pairwise

Tested-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8b4746691954..e395470fbf80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -379,8 +379,6 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 		break;
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -388,6 +386,8 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
 		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b53f04fc0534..989747cb5044 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -313,8 +313,6 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 		break;
-	case WLAN_CIPHER_SUITE_WEP40:
-	case WLAN_CIPHER_SUITE_WEP104:
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -322,6 +320,8 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
 		break;
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.26.2

