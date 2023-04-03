Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995BC6D5300
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 23:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjDCVEu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjDCVEs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 17:04:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91101990
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 14:04:40 -0700 (PDT)
X-UUID: 23e887bad26311edb6b9f13eb10bd0fe-20230404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Tr5PKTZkytsHces4K8xckZrMRgweSHoafCTFPOREkbc=;
        b=n9sIBALoq+Wva5x2CWAmkIlgvhsvw/uvHm0gWOZOuT/PYwPk8NDyviMSOE1c5mFUliJ8sPE4E9UyX7gwP9us3YbWYS7JhSaSzoeH3a9YgZVxT0rBXl0EuwdtDwcNFVdQGInZqXST1sZ3PK17ITeo7tt0SRfNh7YLzxjpEYVBAww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:1aa6a687-1465-480f-a6a4-8b199ec393d6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:a1fd4a2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 23e887bad26311edb6b9f13eb10bd0fe-20230404
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1847009266; Tue, 04 Apr 2023 05:04:36 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 05:04:35 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 4 Apr 2023 05:04:33 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Subject: [PATCH 1/2] wifi: mac80211: track obss color bitmap
Date:   Mon, 3 Apr 2023 14:04:29 -0700
Message-ID: <774ab129159408a3f3e04b7e662cb559cf087c48.1680553706.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Track OBSS BSS colors on checking OBSS Beacons and report used color bitmap to
hostapd when collide.

Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
 include/net/mac80211.h | 1 +
 net/mac80211/rx.c      | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 219fd15893b0..f003e0dbc7c4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -749,6 +749,7 @@ struct ieee80211_bss_conf {
 
 	bool color_change_active;
 	u8 color_change_color;
+	u64 used_color_bitmap;
 
 	bool vht_su_beamformer;
 	bool vht_su_beamformee;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f7fdfe710951..e4a60992e4eb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3264,9 +3264,11 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 
 		color = le32_get_bits(he_oper->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
+		bss_conf->used_color_bitmap |= BIT_ULL(color);
+
 		if (color == bss_conf->he_bss_color.color)
 			ieee80211_obss_color_collision_notify(&rx->sdata->vif,
-							      BIT_ULL(color),
+							      bss_conf->used_color_bitmap,
 							      GFP_ATOMIC);
 	}
 }
-- 
2.39.0

