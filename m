Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC97E9462
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 03:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjKMCLj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 21:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCLi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 21:11:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C511C
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 18:11:26 -0800 (PST)
X-UUID: f1145ffa81c911eea33bb35ae8d461a2-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pAsthbzADJx3MMEZcWhf4thSAMygZ12WqhsFc8e+XAo=;
        b=l8aje2I3OvwEky2BElPeZjIQb2eBhkdP8YnR1H+aOQXBZ4GlPdJMh2PMxymtwj+JbUmuBWwi762AeAMscmp5Dr8vBMzuDkUC53vplmYStIT4ML/3q/rjcVn0UCct3AUm71iRD24L+dprfBbXb6vWkxKWwefJqRkAAG+SLGbkRUM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:2a6292e1-6a54-496b-a26e-760c0293e768,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:b09e4f95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f1145ffa81c911eea33bb35ae8d461a2-20231113
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1509245877; Mon, 13 Nov 2023 10:11:22 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 10:11:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 10:11:19 +0800
From:   Michael-CY Lee <michael-cy.lee@mediatek.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Michael-CY Lee <michael-cy.lee@mediatek.com>
Subject: [PATCH v2,1/2] wifi: mac80211: Add utilities for converting op_class
Date:   Mon, 13 Nov 2023 10:11:06 +0800
Message-ID: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.322700-8.000000
X-TMASE-MatchedRID: 70Ug8sDH78/LmQtq4MlK+Y3NgkEqAN0Rdp9Xbh4iYgemg3jaUxa3XvVK
        H6lJND8AJtzOk8Hd4JNxTzGHHhO45IW/d/vd8jP9H5YQyOg71ZZMkOX0UoduuS8zQZ2rR/OpHz5
        ccRN5kLNhRGbVgSP6g3tNt2X25HGOvqB+AnZW+xMdxBAG5/hkW9OGA1GsPb1XjdXw3QqAuhr9kt
        CFFjP4beLzNWBegCW2wgn7iDBesS3CttcwYNipX6Znf3oa3keFS+6YaIfbskLa/B+Sp7xcTkrvD
        bJlC3s5OjzFEmBOt6iFPFZju4qY8EoQgUotyPsfh4x9yz/PxE60Kyqa3iMJX7IOwIgzK02XdmtR
        sRmKkASJZPT2ZDPuzPD2QfzMDLjho65UufHcDvg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.322700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B9F18406CEAA7A9FB95E6B112F9CC941C78028B1C8ABBCA8FC12C880C22E421A2000:8
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These utilities include converting op_class to nl80211 channel width and
center frequency.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Money Wang <money.wang@mediatek.com>
---
v2: fix the build warning
---
 include/net/cfg80211.h |  25 ++++++++
 net/wireless/util.c    | 127 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..a226d1cae7f7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8669,6 +8669,31 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 bool ieee80211_operating_class_to_band(u8 operating_class,
 				       enum nl80211_band *band);
 
+/**
+ * ieee80211_operating_class_to_center_freq - convert operating class to
+ * center frequency
+ *
+ * @operating_class: the operating class to convert
+ * @chan: the ieee80211_channel to convert
+ * @center_freq1: cneter frequency 1 pointer to fill
+ * @center_freq2: cneter frequency 2 pointer to fill
+ *
+ * Returns %true if the conversion was successful, %false otherwise.
+ */
+bool ieee80211_operating_class_to_center_freq(u8 operating_class,
+					      struct ieee80211_channel *chan,
+					      u32 *center_freq1,
+					      u32 *center_freq2);
+
+/**
+ * ieee80211_operating_class_to_chan_width - convert operating class to
+ * nl80211 channel width
+ *
+ * @operating_class: the operating class to convert
+ */
+enum nl80211_chan_width
+ieee80211_operating_class_to_chan_width(u8 operating_class);
+
 /**
  * ieee80211_chandef_to_operating_class - convert chandef to operation class
  *
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 626b858b4b35..383c9f0897ce 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2017,6 +2017,133 @@ bool ieee80211_operating_class_to_band(u8 operating_class,
 }
 EXPORT_SYMBOL(ieee80211_operating_class_to_band);
 
+bool ieee80211_operating_class_to_center_freq(u8 operating_class,
+					      struct ieee80211_channel *chan,
+					      u32 *center_freq1,
+					      u32 *center_freq2)
+{
+	u32 control_freq, offset = 0;
+	enum nl80211_band band;
+
+	control_freq = chan->center_freq;
+	if (!ieee80211_operating_class_to_band(operating_class, &band))
+		return false;
+
+	if (band != chan->band)
+		return false;
+
+	if (control_freq >= 5955)
+		offset = control_freq - 5955;
+	else if (control_freq >= 5745)
+		offset = control_freq - 5745;
+	else if (control_freq >= 5180)
+		offset = control_freq - 5180;
+	offset /= 20;
+
+	*center_freq2 = 0;
+	switch (operating_class) {
+	case 81:  /* 2 GHz band; 20 MHz; channels 1..13 */
+	case 82:  /* 2 GHz band; 20 MHz; channel 14 */
+	case 115: /* 5 GHz band; 20 MHz; channels 36,40,44,48 */
+	case 118: /* 5 GHz band; 20 MHz; channels 52,56,60,64 */
+	case 121: /* 5 GHz band; 20 MHz; channels 100..144 */
+	case 124: /* 5 GHz band; 20 MHz; channels 149,153,157,161 */
+	case 125: /* 5 GHz band; 20 MHz; channels 149..177 */
+	case 131: /* 6 GHz band; 20 MHz; channels 1..233*/
+	case 136: /* 6 GHz band; 20 MHz; channel 2 */
+		*center_freq1 = control_freq;
+		return true;
+	case 83:  /* 2 GHz band; 40 MHz; channels 1..9 */
+	case 116: /* 5 GHz band; 40 MHz; channels 36,44 */
+	case 119: /* 5 GHz band; 40 MHz; channels 52,60 */
+	case 122: /* 5 GHz band; 40 MHz; channels 100,108,116,124,132,140 */
+	case 126: /* 5 GHz band; 40 MHz; channels 149,157,165,173 */
+		*center_freq1 = control_freq + 10;
+		return true;
+	case 84:  /* 2 GHz band; 40 MHz; channels 5..13 */
+	case 117: /* 5 GHz band; 40 MHz; channels 40,48 */
+	case 120: /* 5 GHz band; 40 MHz; channels 56,64 */
+	case 123: /* 5 GHz band; 40 MHz; channels 104,112,120,128,136,144 */
+	case 127: /* 5 GHz band; 40 MHz; channels 153,161,169,177 */
+		*center_freq1 = control_freq - 10;
+		return true;
+	case 132: /* 6 GHz band; 40 MHz; channels 1,5,..,229*/
+		*center_freq1 = control_freq + 10 - (offset & 1) * 20;
+		return true;
+	case 128: /* 5 GHz band; 80 MHz; channels 36..64,100..144,149..177 */
+		*center_freq1 = control_freq + 30 - (offset & 3) * 20;
+		return true;
+	case 130: /* 5 GHz band; 80+80 MHz; channels 36..64,100..144,149..177 */
+		/* TODO How to know the center_freq2 of 80+80 MHz?*/
+		*center_freq1 = 0;
+		return false;
+	case 133: /* 6 GHz band; 80 MHz; channels 1,5,..,229 */
+		*center_freq1 = control_freq + 30 - (offset & 3) * 20;
+		return true;
+	case 129: /* 5 GHz band; 160 MHz; channels 36..64,100..144,149..177 */
+		*center_freq1 = control_freq + 70 - (offset & 7) * 20;
+		return true;
+	case 134: /* 6 GHz band; 160 MHz; channels 1,5,..,229 */
+		*center_freq1 = control_freq + 70 - (offset & 7) * 20;
+		return true;
+	case 135: /* 6 GHz band; 80+80 MHz; channels 1,5,..,229 */
+		/* TODO How to know the center_freq2 of 80+80 MHz?*/
+		*center_freq1 = 0;
+		return false;
+	case 137: /* 6 GHz band; 320 MHz; channels 1,5,..,229 */
+		/* TODO it's 320 MHz-1 or 320 MHz-2 channelization? */
+		*center_freq1 = 0;
+		return false;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(ieee80211_operating_class_to_center_freq);
+
+enum nl80211_chan_width
+ieee80211_operating_class_to_chan_width(u8 operating_class)
+{
+	switch (operating_class) {
+	case 81:  /* 2 GHz band; 20 MHz; channels 1..13 */
+	case 82:  /* 2 GHz band; 20 MHz; channel 14 */
+	case 115: /* 5 GHz band; 20 MHz; channels 36,40,44,48 */
+	case 118: /* 5 GHz band; 20 MHz; channels 52,56,60,64 */
+	case 121: /* 5 GHz band; 20 MHz; channels 100..144 */
+	case 124: /* 5 GHz band; 20 MHz; channels 149,153,157,161 */
+	case 125: /* 5 GHz band; 20 MHz; channels 149..177 */
+	case 131: /* 6 GHz band; 20 MHz; channels 1..233*/
+	case 136: /* 6 GHz band; 20 MHz; channel 2 */
+		return NL80211_CHAN_WIDTH_20;
+	case 83:  /* 2 GHz band; 40 MHz; channels 1..9 */
+	case 84:  /* 2 GHz band; 40 MHz; channels 5..13 */
+	case 116: /* 5 GHz band; 40 MHz; channels 36,44 */
+	case 117: /* 5 GHz band; 40 MHz; channels 40,48 */
+	case 119: /* 5 GHz band; 40 MHz; channels 52,60 */
+	case 120: /* 5 GHz band; 40 MHz; channels 56,64 */
+	case 122: /* 5 GHz band; 40 MHz; channels 100,108,116,124,132,140 */
+	case 123: /* 5 GHz band; 40 MHz; channels 104,112,120,128,136,144 */
+	case 126: /* 5 GHz band; 40 MHz; channels 149,157,165,173 */
+	case 127: /* 5 GHz band; 40 MHz; channels 153,161,169,177 */
+	case 132: /* 6 GHz band; 40 MHz; channels 1,5,..,229*/
+		return NL80211_CHAN_WIDTH_40;
+	case 128: /* 5 GHz band; 80 MHz; channels 36..64,100..144,149..177 */
+	case 133: /* 6 GHz band; 80 MHz; channels 1,5,..,229 */
+		return NL80211_CHAN_WIDTH_80;
+	case 130: /* 5 GHz band; 80+80 MHz; channels 36..64,100..144,149..177 */
+	case 135: /* 6 GHz band; 80+80 MHz; channels 1,5,..,229 */
+		return NL80211_CHAN_WIDTH_80P80;
+	case 129: /* 5 GHz band; 160 MHz; channels 36..64,100..144,149..177 */
+	case 134: /* 6 GHz band; 160 MHz; channels 1,5,..,229 */
+		return NL80211_CHAN_WIDTH_160;
+	case 137: /* 6 GHz band; 320 MHz; channels 1,5,..,229 */
+		return NL80211_CHAN_WIDTH_320;
+	default:
+		WARN_ON(1);
+		return NL80211_CHAN_WIDTH_20_NOHT;
+	}
+}
+EXPORT_SYMBOL(ieee80211_operating_class_to_chan_width);
+
 bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 					  u8 *op_class)
 {
-- 
2.25.1

