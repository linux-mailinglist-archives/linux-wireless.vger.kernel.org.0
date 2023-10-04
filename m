Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE07B8E51
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbjJDUsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbjJDUsI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 16:48:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF3D9
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 13:47:57 -0700 (PDT)
X-UUID: 4a37c97e62f711eea33bb35ae8d461a2-20231005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LFy87yjf9KXOANWeEraJGBPvxzxdIAOP07SjS/SRr4w=;
        b=swCM/Uo+fZYsnkGa7uchHsV5uvbSrxV6J1DGIv6RonOI+IaQlYqUFNRipBVVoS/pSEYDea9XfsnlqBy41F0vg58AbpniZnqMGgXj0I/4aNW+9R3NGEnJ3qIBL92J5/OV4ZwE0HA8vCP7uHkS8B2abwORWnkyB6wibkC2nTu24Lk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:815bb2a1-9f6d-4d28-bb0f-234f02047f68,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:11ca96bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4a37c97e62f711eea33bb35ae8d461a2-20231005
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 146054958; Thu, 05 Oct 2023 04:47:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Oct 2023 04:47:51 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Oct 2023 04:47:49 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v4] wifi: mac80211: add exported tpt_led_trig function for softmac driver
Date:   Wed, 4 Oct 2023 13:47:47 -0700
Message-ID: <ce30818cd336b64ded17f410b594e9c9c1f5f4ee.1696376062.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.407600-8.000000
X-TMASE-MatchedRID: YXgS1C6OPWwLazoQyrpm0lVN8laWo90MXzuf6CMHFBtUFL8kNivfsBlN
        xiPQSlnnxILoPou7rql2etPL9FEV3h9NAFnVs2NuGfRQPgZTkipP2RIvtLAHWLXvDHySC+eUsi1
        pjbhwmMbBoRXt6OjjTOKOmN63egZIX7XIHqmHuTMshGpBsK6H7grefVId6fzVCqIJhrrDy2+uDV
        or40eHhjY4a60cBjqtbCcQdI7TJsmtiF+p+9BY6Z7tR0mnRAg1D+LwVja9M4GbKItl61J/yZ+in
        TK0bC9eKrauXd3MZDWuikCL8VXXTA/Vry4qaSVoKF1Idy3saK6v2bc3gVmpDXLMfv1cTKPs39Pj
        2R0rKz4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.407600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D85A7AFBF9A87D709BD0139A5455188470022CB016CCE5776EB1A8ACABC13BFC2000:8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new function __ieee80211_tpt_led_trig_trx. It is exported and
takes ieee80211_hw as argument so that softmac driver can use. This
can be helpful when traffic runs in HW path and mac80211 is not
aware of the traffic.

Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2: split series
---
v3: retitle, keep the original API and combine double-underscore functions
---
v4: export ieee80211_tpt_led_trig_trx and make double-underscore function inline

---
 include/net/mac80211.h | 10 ++++++++++
 net/mac80211/led.c     |  7 +++++++
 net/mac80211/led.h     | 29 +++++++++++------------------
 net/mac80211/rx.c      |  2 +-
 net/mac80211/tx.c      |  4 ++--
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72375eceb786..de37020ee845 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4853,6 +4853,16 @@ ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw, unsigned int flags,
 #endif
 }
 
+/**
+ * ieee80211_tpt_led_trig_trx - report traffic to throughput LED
+ *
+ * @hw: the hardware to count bytes for tpt_led
+ * @tx_bytes: bytes to add to tx
+ * @rx_bytes: bytes to add to rx
+ */
+void ieee80211_tpt_led_trig_trx(struct ieee80211_hw *hw,
+				int tx_bytes, int rx_bytes);
+
 /**
  * ieee80211_unregister_hw - Unregister a hardware device
  *
diff --git a/net/mac80211/led.c b/net/mac80211/led.c
index 2dc732147e85..89fd5da21423 100644
--- a/net/mac80211/led.c
+++ b/net/mac80211/led.c
@@ -319,6 +319,13 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(__ieee80211_create_tpt_led_trigger);
 
+void ieee80211_tpt_led_trig_trx(struct ieee80211_hw *hw,
+				int tx_bytes, int rx_bytes)
+{
+	__ieee80211_tpt_led_trig_trx(hw_to_local(hw), tx_bytes, rx_bytes);
+}
+EXPORT_SYMBOL(ieee80211_tpt_led_trig_trx);
+
 static void ieee80211_start_tpt_led_trig(struct ieee80211_local *local)
 {
 	struct tpt_led_trigger *tpt_trig = local->tpt_led_trigger;
diff --git a/net/mac80211/led.h b/net/mac80211/led.h
index d25f13346b82..8368564d205f 100644
--- a/net/mac80211/led.h
+++ b/net/mac80211/led.h
@@ -28,6 +28,17 @@ static inline void ieee80211_led_tx(struct ieee80211_local *local)
 #endif
 }
 
+static inline void __ieee80211_tpt_led_trig_trx(struct ieee80211_local *local,
+						int tx_bytes, int rx_bytes)
+{
+#ifdef CONFIG_MAC80211_LEDS
+	if (atomic_read(&local->tpt_led_active)) {
+		local->tpt_led_trigger->tx_bytes += tx_bytes;
+		local->tpt_led_trigger->rx_bytes += rx_bytes;
+	}
+#endif
+}
+
 #ifdef CONFIG_MAC80211_LEDS
 void ieee80211_led_assoc(struct ieee80211_local *local,
 			 bool associated);
@@ -66,21 +77,3 @@ static inline void ieee80211_mod_tpt_led_trig(struct ieee80211_local *local,
 {
 }
 #endif
-
-static inline void
-ieee80211_tpt_led_trig_tx(struct ieee80211_local *local, int bytes)
-{
-#ifdef CONFIG_MAC80211_LEDS
-	if (atomic_read(&local->tpt_led_active))
-		local->tpt_led_trigger->tx_bytes += bytes;
-#endif
-}
-
-static inline void
-ieee80211_tpt_led_trig_rx(struct ieee80211_local *local, int bytes)
-{
-#ifdef CONFIG_MAC80211_LEDS
-	if (atomic_read(&local->tpt_led_active))
-		local->tpt_led_trigger->rx_bytes += bytes;
-#endif
-}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 051db97a92b4..c6d67e62d866 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5383,7 +5383,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	if (skb) {
 		if ((status->flag & RX_FLAG_8023) ||
 			ieee80211_is_data_present(hdr->frame_control))
-			ieee80211_tpt_led_trig_rx(local, skb->len);
+			ieee80211_tpt_led_trig_trx(&local->hw, 0, skb->len);
 
 		if (status->flag & RX_FLAG_8023)
 			__ieee80211_rx_handle_8023(hw, pubsta, skb, list);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a984fc54644e..0cffd3a94830 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4334,7 +4334,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 	len = 0;
  out:
 	if (len)
-		ieee80211_tpt_led_trig_tx(local, len);
+		ieee80211_tpt_led_trig_trx(&local->hw, len, 0);
 	rcu_read_unlock();
 }
 
@@ -4665,7 +4665,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	sta->deflink.tx_stats.packets[queue] += skbs;
 	sta->deflink.tx_stats.bytes[queue] += len;
 
-	ieee80211_tpt_led_trig_tx(local, len);
+	ieee80211_tpt_led_trig_trx(&local->hw, len, 0);
 
 	ieee80211_tx_8023(sdata, skb, sta, false);
 
-- 
2.39.0

