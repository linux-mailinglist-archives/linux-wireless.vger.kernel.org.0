Return-Path: <linux-wireless+bounces-1188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BE981C294
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 02:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472892878BE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F421A53;
	Fri, 22 Dec 2023 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VE2zAe+P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFF819
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c3fd6258a06611eea5db2bebc7c28f94-20231222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bE2EG5ost8SzA/gX5PT8nHP18dhMS5yCBIwP0l0ls7I=;
	b=VE2zAe+POzHp7ECI9BszUAUloIxtP4Pi5d3wGaKPgq6QGcC2ddsRAvV36bMZG8R0j6QYzhwSXfuZYnal5+c48zIl8stGOV+gqxy32lZwB8aw+HhVHJ4zC8Q354rFrUvaiDtI1sJ9nhGYaEqVMGfWxDjLBIlpT//mXkMVfVqoD08=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:89855147-2258-4302-b4ad-52161fc72254,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:055d0a82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c3fd6258a06611eea5db2bebc7c28f94-20231222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 395967718; Fri, 22 Dec 2023 09:09:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Dec 2023 09:09:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Dec 2023 09:09:31 +0800
From: Michael-CY Lee <michael-cy.lee@mediatek.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Michael-CY Lee
	<michael-cy.lee@mediatek.com>
Subject: [v4,1/2] wifi: mac80211: Add utility for converting op_class into chandef
Date: Fri, 22 Dec 2023 09:09:13 +0800
Message-ID: <20231222010914.6521-2-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
References: <20231222010914.6521-1-michael-cy.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.202000-8.000000
X-TMASE-MatchedRID: +2zAcmHD8Q7LmQtq4MlK+Y+emiGnyeDRUK80YYUAl4sXdhT0BAdFzvMT
	uIrC6WWhsRIB98XGTDmkeU7arquyzm94Ipa1otxo0Xw0ILvo/uUK3n1SHen81Wd6vNuG6Cqy56y
	iAZYPrXdKlBq8feLAYQ1Ica/LQEH+98hoZRVgb5WNzYJBKgDdEbyfV74eQpk+myiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1l3+bAt/YFVROQSbiTNQmeZerkDDruMdsGrj/8opIaOcGqSULbIPBSGA7b
	UFBqh2V
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.202000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6B95A0EE5A464375FFD95EB39FE80FB83A0475E68EA8F450FC127FBA2D7232A82000:8

This utility is used in STA CSA handling. The op_class in the ECSA
Element can be converted into chandef.

Co-developed-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
---
v4: no change
---
 include/net/cfg80211.h | 13 ++++++++
 net/wireless/util.c    | 76 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d59669d86718..3093c88ab9ec 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8672,6 +8672,19 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 bool ieee80211_operating_class_to_band(u8 operating_class,
 				       enum nl80211_band *band);
 
+/**
+ * ieee80211_operating_class_to_chandef - convert operating class to chandef
+ *
+ * @operating_class: the operating class to convert
+ * @chan: the ieee80211_channel to convert
+ * @chandef: a pointer to the resulting chandef
+ *
+ * Returns %true if the conversion was successful, %false otherwise.
+ */
+bool ieee80211_operating_class_to_chandef(u8 operating_class,
+					  struct ieee80211_channel *chan,
+					  struct cfg80211_chan_def *chandef);
+
 /**
  * ieee80211_chandef_to_operating_class - convert chandef to operation class
  *
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 626b858b4b35..edcc6f202c19 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2017,6 +2017,82 @@ bool ieee80211_operating_class_to_band(u8 operating_class,
 }
 EXPORT_SYMBOL(ieee80211_operating_class_to_band);
 
+bool ieee80211_operating_class_to_chandef(u8 operating_class,
+					  struct ieee80211_channel *chan,
+					  struct cfg80211_chan_def *chandef)
+{
+	u32 control_freq, offset = 0;
+	enum nl80211_band band;
+
+	if (!ieee80211_operating_class_to_band(operating_class, &band) ||
+	    !chan || band != chan->band)
+		return false;
+
+	control_freq = chan->center_freq;
+	chandef->chan = chan;
+
+	if (control_freq >= 5955)
+		offset = control_freq - 5955;
+	else if (control_freq >= 5745)
+		offset = control_freq - 5745;
+	else if (control_freq >= 5180)
+		offset = control_freq - 5180;
+	offset /= 20;
+
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
+		chandef->center_freq1 = control_freq;
+		chandef->width = NL80211_CHAN_WIDTH_20;
+		return true;
+	case 83:  /* 2 GHz band; 40 MHz; channels 1..9 */
+	case 116: /* 5 GHz band; 40 MHz; channels 36,44 */
+	case 119: /* 5 GHz band; 40 MHz; channels 52,60 */
+	case 122: /* 5 GHz band; 40 MHz; channels 100,108,116,124,132,140 */
+	case 126: /* 5 GHz band; 40 MHz; channels 149,157,165,173 */
+		chandef->center_freq1 = control_freq + 10;
+		chandef->width = NL80211_CHAN_WIDTH_40;
+		return true;
+	case 84:  /* 2 GHz band; 40 MHz; channels 5..13 */
+	case 117: /* 5 GHz band; 40 MHz; channels 40,48 */
+	case 120: /* 5 GHz band; 40 MHz; channels 56,64 */
+	case 123: /* 5 GHz band; 40 MHz; channels 104,112,120,128,136,144 */
+	case 127: /* 5 GHz band; 40 MHz; channels 153,161,169,177 */
+		chandef->center_freq1 = control_freq - 10;
+		chandef->width = NL80211_CHAN_WIDTH_40;
+		return true;
+	case 132: /* 6 GHz band; 40 MHz; channels 1,5,..,229*/
+		chandef->center_freq1 = control_freq + 10 - (offset & 1) * 20;
+		chandef->width = NL80211_CHAN_WIDTH_40;
+		return true;
+	case 128: /* 5 GHz band; 80 MHz; channels 36..64,100..144,149..177 */
+	case 133: /* 6 GHz band; 80 MHz; channels 1,5,..,229 */
+		chandef->center_freq1 = control_freq + 30 - (offset & 3) * 20;
+		chandef->width = NL80211_CHAN_WIDTH_80;
+		return true;
+	case 129: /* 5 GHz band; 160 MHz; channels 36..64,100..144,149..177 */
+	case 134: /* 6 GHz band; 160 MHz; channels 1,5,..,229 */
+		chandef->center_freq1 = control_freq + 70 - (offset & 7) * 20;
+		chandef->width = NL80211_CHAN_WIDTH_160;
+		return true;
+	case 130: /* 5 GHz band; 80+80 MHz; channels 36..64,100..144,149..177 */
+	case 135: /* 6 GHz band; 80+80 MHz; channels 1,5,..,229 */
+		  /* The center_freq2 of 80+80 MHz is unknown */
+	case 137: /* 6 GHz band; 320 MHz; channels 1,5,..,229 */
+		  /* 320-1 or 320-2 channelization is unknown */
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(ieee80211_operating_class_to_chandef);
+
 bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 					  u8 *op_class)
 {
-- 
2.25.1


