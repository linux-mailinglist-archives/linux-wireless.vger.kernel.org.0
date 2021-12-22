Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959DE47D4D1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhLVQGq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 11:06:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52444 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhLVQGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 11:06:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F9EAB81D12
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 16:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F729C36AE8;
        Wed, 22 Dec 2021 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640189203;
        bh=toUOCcrkepxhAUF49IzHM4KlhpDzhayQ4JMaSW23XSE=;
        h=From:To:Cc:Subject:Date:From;
        b=ekBKymaadwByP/HNmsp49fZu6iXkXPHqWxwoPtmji94hKo0pQeuBByEbs65NwHcIE
         gFPZef8Mt9KHokoay2wlTOk+1t8LEcnOec6WVNvntBbEpLH42QiASwwVXjN+xUMLxJ
         PJJOeNdk5SubXDYavDMz+yPswNvOCA58Svh0qQHARtSTdYVdjGRPfKljjb6yYZ1HF3
         q9z2iHi6CDfFEcp0ZT5f++1SUqEgFTHUTlIJjaJzyFJDvW4gk5MnrHitiTZowmNM0S
         h5Ys3lL88hiqH4EmeZoN0XBBvUFLEJ16Mvc5TkhzZbY8a/Fj4AIUNFsxZPs5DmoilD
         IrN9fgP00cdKw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7915: use proper aid value in mt7915_mcu_sta_basic_tlv
Date:   Wed, 22 Dec 2021 17:06:36 +0100
Message-Id: <e48936c4d2756b0254cec712488025f5224c42ca.1640188763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915_mcu_wtbl_generic_tlv, rely on vif->bss_conf.aid for
aid in sta mode and not on sta->aid.

Fixes: e57b7901469fc ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a1d50bbdece2..ec7ca7e90c48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1045,12 +1045,15 @@ mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		basic->aid = cpu_to_le16(sta->aid);
 		break;
 	case NL80211_IFTYPE_STATION:
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		basic->aid = cpu_to_le16(vif->bss_conf.aid);
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		basic->aid = cpu_to_le16(sta->aid);
 		break;
 	default:
 		WARN_ON(1);
@@ -1058,7 +1061,6 @@ mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	}
 
 	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
-	basic->aid = cpu_to_le16(sta->aid);
 	basic->qos = sta->wme;
 }
 
-- 
2.33.1

