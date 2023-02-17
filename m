Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E469B20A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBQRtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 12:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjBQRtk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 12:49:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D8554D0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:49:34 -0800 (PST)
X-UUID: 6cfa7aeeaeeb11eda06fc9ecc4dadd91-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mVnTocHQiiTL5C+NkFkIOH4zRxnyLpTv9jQKgqKpk3o=;
        b=kAw9q07yDGPVv4COhEy2IVKegpVkZy2VJv8iMCetENANGG1UZYyUhBp3gx6lrS7yz/3RSXxrkL9AjF4Jf68QAipb3U4UWa6JLEzuO28y7VVboe7GJ+j0pAhELGxA6R53Ac2iGJRPSH/SknXhqJNPNIUAmSSsgerQ5tcMLcoO7wE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:c5eb8ea0-8ed5-4c4f-850e-932390641f26,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:5591ea25-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 6cfa7aeeaeeb11eda06fc9ecc4dadd91-20230218
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 572548056; Sat, 18 Feb 2023 01:49:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 18 Feb 2023 01:49:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 18 Feb 2023 01:49:27 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] wifi: mac80211: add LDPC related flags in ieee80211_bss_conf
Date:   Sat, 18 Feb 2023 01:49:25 +0800
Message-ID: <1de696aaa34efd77a926eb657b8c0fda05aaa177.1676628065.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <8d9966c4c1e77cb1ade77d42bdc49905609192e9.1676628065.git.ryder.lee@mediatek.com>
References: <8d9966c4c1e77cb1ade77d42bdc49905609192e9.1676628065.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is utilized to pass LDPC configurations from user space
(i.e. hostapd) to driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2
- fix typo of commit logs.
- revise statement of newly added members in ieee80211_bss_conf.
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/cfg.c     | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 879fc14ebd2a..5f0902b4f8ea 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -653,6 +653,9 @@ struct ieee80211_fils_discovery {
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
  * @color_change_color: the bss color that will be used after the change.
+ * @ht_ldpc: in AP mode, indicates interface has HT LDPC capability.
+ * @vht_ldpc: in AP mode, indicates interface has VHT LDPC capability.
+ * @he_ldpc: in AP mode, indicates interface has HE LDPC capability.
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
index 6bf1cdf254f6..b02cd0acc4e3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1252,7 +1252,15 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = link_conf->beacon_int;
 	link_conf->beacon_int = params->beacon_interval;
 
+	if (params->ht_cap)
+		link_conf->ht_ldpc =
+			params->ht_cap->cap_info &
+				cpu_to_le16(IEEE80211_HT_CAP_LDPC_CODING);
+
 	if (params->vht_cap) {
+		link_conf->vht_ldpc =
+			params->vht_cap->vht_cap_info &
+				cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC);
 		link_conf->vht_su_beamformer =
 			params->vht_cap->vht_cap_info &
 				cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
@@ -1282,6 +1290,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
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

