Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786B447E2EC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348126AbhLWMIS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348121AbhLWMIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855BEC061756
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2437C61E67
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79604C36AEB;
        Thu, 23 Dec 2021 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261296;
        bh=vP6j/02hwgDmWbznLUgvhEgvFr9gxVo4Wjnv2puONt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p22EzPOvVgJyyaB4aG1rZ2OiqQJ3d0UJDFkSTrL1uM2efIe4ps3sCyRor+DyTt0tL
         ioY9J41GYtl+zEXrq6dV37gev6WhB29K53NBCjqDxrMXMf8LkZaoJzZrnQ9K4jIqAW
         OzRenfg5fgJ4g+y6aD4Y2nKKRuQduvPe131p0++y33SQ/LcF5uERhd/bfw2MCE1aiD
         UViGjhCz2wexY9dy+mYR8/eiQsxkv7hA2aD3C+ALDgz2MgT7HZmMoeT8sZfLFQUKa/
         QYl6qfgZ25xYKCbXE51EPqkAx63juWeMK2bpRz9JXu/M3J/hRgGAizfYh2jQ9a+Z+8
         TjozFRj4iiqPw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 09/15] mt76: mt7915: rely on mt76_connac_mcu_sta_basic_tlv
Date:   Thu, 23 Dec 2021 13:07:37 +0100
Message-Id: <d00a2398f293a07ca02d4097fdaca23286ae0c3b.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_sta_basic_tlv routine in mt7915 and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 52 +------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 03deec48a758..fc1602105dfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -769,56 +769,6 @@ int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 				      enable, false);
 }
 
-static void
-mt7915_mcu_sta_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, bool enable)
-{
-#define EXTRA_INFO_VER          BIT(0)
-#define EXTRA_INFO_NEW          BIT(1)
-	struct sta_rec_basic *basic;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
-
-	basic = (struct sta_rec_basic *)tlv;
-	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
-
-	if (enable) {
-		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
-		basic->conn_state = CONN_STATE_PORT_SECURE;
-	} else {
-		basic->conn_state = CONN_STATE_DISCONNECT;
-	}
-
-	if (!sta) {
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
-		eth_broadcast_addr(basic->peer_addr);
-		return;
-	}
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
-		basic->aid = cpu_to_le16(sta->aid);
-		break;
-	case NL80211_IFTYPE_STATION:
-		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
-		basic->aid = cpu_to_le16(vif->bss_conf.aid);
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		basic->aid = cpu_to_le16(sta->aid);
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
-	basic->qos = sta->wme;
-}
-
 static void
 mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		      struct ieee80211_vif *vif)
@@ -1866,7 +1816,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt7915_mcu_sta_basic_tlv(skb, vif, sta, enable);
+	mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable, true);
 	if (!enable)
 		goto out;
 
-- 
2.33.1

