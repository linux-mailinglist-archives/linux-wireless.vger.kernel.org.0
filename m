Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55669B204
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBQRta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 12:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBQRt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 12:49:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2C67445
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:49:10 -0800 (PST)
X-UUID: 5e07203caeeb11ed945fc101203acc17-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WzCqWjdpu+FKpFM+RxVf4hcJaHMxYVVsPz2EEvBFdCU=;
        b=YdRuy/0T9J+VM7/zfhTfxY5lEc6Uzvdh6Jasi7zct0ZwJ3ccOSASN3NuvmBFZkzsrnR4FAQT2kVRpxDOkPsjVHgPDtGoaZIsES/vUx7vN//9OhEjTXAyXq+N9ijsfW9B+5bDSLZqeV//sUnZquzmqhmLFvGkknY/2FfvcJKdlsA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:eb233616-3271-498a-b537-69235a13a4c0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.19,REQID:eb233616-3271-498a-b537-69235a13a4c0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:885ddb2,CLOUDID:7736cbb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:23021801490518DFM278,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 5e07203caeeb11ed945fc101203acc17-20230218
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1211963295; Sat, 18 Feb 2023 01:49:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 18 Feb 2023 01:49:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 18 Feb 2023 01:49:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] wifi: mac80211: add EHT MU-MIMO related flags in ieee80211_bss_conf
Date:   Sat, 18 Feb 2023 01:48:59 +0800
Message-ID: <8d9966c4c1e77cb1ade77d42bdc49905609192e9.1676628065.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Similar to VHT/HE. This is utilized to pass MU-MIMO configurations
from user space (i.e. hostapd) to driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2 
- fix typo of commit logs.
- revise statement of newly added members in ieee80211_bss_conf
- remove unneeded braces.
---
 include/net/mac80211.h |  9 +++++++++
 net/mac80211/cfg.c     | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0cc76eea2014..879fc14ebd2a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -670,6 +670,12 @@ struct ieee80211_fils_discovery {
  * @he_full_ul_mumimo: does this BSS support the reception (AP) or transmission
  *	(non-AP STA) of an HE TB PPDU on an RU that spans the entire PPDU
  *	bandwidth
+ * @eht_su_beamformer: in AP-mode, does this BSS enable operation as an EHT SU
+ *	beamformer
+ * @eht_su_beamformee: in AP-mode, does this BSS enable operation as an EHT SU
+ *	beamformee
+ * @eht_mu_beamformer: in AP-mode, does this BSS enable operation as an EHT MU
+ *	beamformer
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -752,6 +758,9 @@ struct ieee80211_bss_conf {
 	bool he_su_beamformee;
 	bool he_mu_beamformer;
 	bool he_full_ul_mumimo;
+	bool eht_su_beamformer;
+	bool eht_su_beamformee;
+	bool eht_mu_beamformer;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f5d43f42f6d8..6bf1cdf254f6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1296,6 +1296,20 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 	}
 
+	if (params->eht_cap) {
+		link_conf->eht_su_beamformer =
+			params->eht_cap->fixed.phy_cap_info[0] &
+				IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER;
+		link_conf->eht_su_beamformee =
+			params->eht_cap->fixed.phy_cap_info[0] &
+				IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
+		link_conf->eht_mu_beamformer =
+			params->eht_cap->fixed.phy_cap_info[7] &
+				(IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
+				 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ |
+				 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-- 
2.18.0

