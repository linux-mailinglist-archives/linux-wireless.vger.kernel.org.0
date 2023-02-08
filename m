Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E868FA12
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 23:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjBHWJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 17:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjBHWJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 17:09:19 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0442C65F
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 14:09:10 -0800 (PST)
X-UUID: 3434cdbca7fd11eda06fc9ecc4dadd91-20230209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b4W6l6GF1VWjTkxn870nPiyBNx/kDR/5X/MNtznSwgw=;
        b=FhoDrobwRIynPAwQjUBdpQ+k3cYMXKvYp07hnxfCUHpv0nsiWeXfS7DrqOD0URnLxmBaXDGpEFzyvBKmeC2yJnm4I7YmnaxTAkhh5DG5Sg0mbiDeyHVzhACy3+EBFHdX2VxnqiCL7ENYQvg8gErf26UqGYDaCRxZ+mBisUyO0Mg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:f5e7ede5-b870-45db-a26e-8db7eccd6401,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.19,REQID:f5e7ede5-b870-45db-a26e-8db7eccd6401,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:885ddb2,CLOUDID:82bbdff7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230209060906LK16WOGV,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 3434cdbca7fd11eda06fc9ecc4dadd91-20230209
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 512183387; Thu, 09 Feb 2023 06:09:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 9 Feb 2023 06:09:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 9 Feb 2023 06:09:05 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        <linux-wireless@vger.kernel.org>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mac80211: add LDPC related flags in ieee80211_bss_conf
Date:   Thu, 9 Feb 2023 06:09:02 +0800
Message-ID: <4e5cff1c538cbd9ecca171e0e4d6fddd87c3dfa0.1675893838.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
References: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is utilized to pass LDPC configurations from user space (i.e. hostap) to driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/cfg.c     | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 943f2aec6042..76a12bec71d5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -653,6 +653,9 @@ struct ieee80211_fils_discovery {
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
  * @color_change_color: the bss color that will be used after the change.
+ * @ht_ldpc: in AP mode, indicates interface owns HT LDPC capability.
+ * @vht_ldpc: in AP mode, indicates interface owns VHT LDPC capability.
+ * @he_ldpc: in AP mode, indicates interface owns HE LDPC capability.
  * @vht_su_beamformer: in AP mode, does this BSS support operation as an VHT SU
  *	beamformer
  * @vht_su_beamformee: in AP mode, does this BSS support operation as an VHT SU
@@ -750,6 +753,9 @@ struct ieee80211_bss_conf {
 	bool color_change_active;
 	u8 color_change_color;
 
+	bool ht_ldpc;
+	bool vht_ldpc;
+	bool he_ldpc;
 	bool vht_su_beamformer;
 	bool vht_su_beamformee;
 	bool vht_mu_beamformer;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6bf1cdf254f6..a080010da8fb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1252,7 +1252,16 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = link_conf->beacon_int;
 	link_conf->beacon_int = params->beacon_interval;
 
+	if (params->ht_cap) {
+		link_conf->ht_ldpc =
+			params->ht_cap->cap_info &
+				cpu_to_le16(IEEE80211_HT_CAP_LDPC_CODING);
+	}
+
 	if (params->vht_cap) {
+		link_conf->vht_ldpc =
+			params->vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC);
 		link_conf->vht_su_beamformer =
 			params->vht_cap->vht_cap_info &
 				cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
@@ -1282,6 +1291,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (params->he_cap) {
+		link_conf->he_ldpc =
+			params->he_cap->phy_cap_info[1] &
+				IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
 		link_conf->he_su_beamformer =
 			params->he_cap->phy_cap_info[3] &
 				IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
-- 
2.18.0

