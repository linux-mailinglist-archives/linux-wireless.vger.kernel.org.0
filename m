Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44E27AA2B3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjIUVcA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjIUVaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:30:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1B803E6
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 14:05:04 -0700 (PDT)
X-UUID: 865e1e1a58c211ee8051498923ad61e6-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vKWek7dONjnAspukrkloUbp5Uh/V78O7fefRiKFW1I8=;
        b=ed3SnLAdoN/lm/WPmmDeuZ4HtZN9zdkqhsBbowdtLPSZCMN62ZvNHxGhofXI1Ncmg4txMdRCdHUwwX1hfKYM17MJjqYxa7lx4as1nruf0DfS0KTsoLDD+HX+HAMWkjBBb4HejBpzJFQYzlZ+OQEDe95vfB7lsc+qItkaVK/PoFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:29f1960b-d0d7-4c98-bd21-61be63ebb9e3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:19bffaef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 865e1e1a58c211ee8051498923ad61e6-20230922
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1619742303; Fri, 22 Sep 2023 05:04:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 05:04:57 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 05:04:55 +0800
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
Subject: [PATCH v3] wifi: mac80211: add exported tpt_led_trig function for softmac driver
Date:   Thu, 21 Sep 2023 14:04:53 -0700
Message-ID: <038706d9bbf434642013e880300d4f597f13b514.1695329290.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.250600-8.000000
X-TMASE-MatchedRID: +k55+NgUc6YLazoQyrpm0lVN8laWo90MXzuf6CMHFBtUFL8kNivfsBlN
        xiPQSlnnxILoPou7rql2etPL9FEV3h9NAFnVs2NuGfRQPgZTkipP2RIvtLAHWACGaccd4ae9cHj
        giTON9jLaFM5TPGLdCPSOC/eQVqddNLV8+yUR4KdH+PTjR9EWkpdhffisWXfH6dkNekyzYll91D
        unZtIaFuLzNWBegCW2wgn7iDBesS3CttcwYNipX8KVf7avePdYeJUA+tazrYR9t5CQ0a4zA3EE3
        X8vPDWHZjfkNwILovatJ9hPQP9PFP0ST08qTwdEiL4lZclYiDqEIoC1m6hGEBvGwqtTOzCBdmtR
        sRmKkASJZPT2ZDPuzPD2QfzMDLjhIh26TkmSN3fAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.250600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FCFCCEBC287D7F1181AEEE65EDE7A9361EB493E7D8A782D1DB33E5D5C963C6D22000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
 include/net/mac80211.h |  2 ++
 net/mac80211/led.c     | 12 ++++++++++++
 net/mac80211/led.h     |  6 ++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 8d993f6ab919..c32f614acb3d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4733,6 +4733,8 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw,
 				   unsigned int flags,
 				   const struct ieee80211_tpt_blink *blink_table,
 				   unsigned int blink_table_len);
+void __ieee80211_tpt_led_trig_trx(struct ieee80211_hw *hw,
+				  int tx_bytes, int rx_bytes);
 #endif
 /**
  * ieee80211_get_tx_led_name - get name of TX LED
diff --git a/net/mac80211/led.c b/net/mac80211/led.c
index 2dc732147e85..1c18ebcaac20 100644
--- a/net/mac80211/led.c
+++ b/net/mac80211/led.c
@@ -319,6 +319,18 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(__ieee80211_create_tpt_led_trigger);
 
+void __ieee80211_tpt_led_trig_trx(struct ieee80211_hw *hw,
+				  int tx_bytes, int rx_bytes)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	if (atomic_read(&local->tpt_led_active)) {
+		local->tpt_led_trigger->tx_bytes += tx_bytes;
+		local->tpt_led_trigger->rx_bytes += rx_bytes;
+	}
+}
+EXPORT_SYMBOL(__ieee80211_tpt_led_trig_trx);
+
 static void ieee80211_start_tpt_led_trig(struct ieee80211_local *local)
 {
 	struct tpt_led_trigger *tpt_trig = local->tpt_led_trigger;
diff --git a/net/mac80211/led.h b/net/mac80211/led.h
index d25f13346b82..6d3212443d35 100644
--- a/net/mac80211/led.h
+++ b/net/mac80211/led.h
@@ -71,8 +71,7 @@ static inline void
 ieee80211_tpt_led_trig_tx(struct ieee80211_local *local, int bytes)
 {
 #ifdef CONFIG_MAC80211_LEDS
-	if (atomic_read(&local->tpt_led_active))
-		local->tpt_led_trigger->tx_bytes += bytes;
+	__ieee80211_tpt_led_trig_trx(&local->hw, bytes, 0);
 #endif
 }
 
@@ -80,7 +79,6 @@ static inline void
 ieee80211_tpt_led_trig_rx(struct ieee80211_local *local, int bytes)
 {
 #ifdef CONFIG_MAC80211_LEDS
-	if (atomic_read(&local->tpt_led_active))
-		local->tpt_led_trigger->rx_bytes += bytes;
+	__ieee80211_tpt_led_trig_trx(&local->hw, 0, bytes);
 #endif
 }
-- 
2.39.0

