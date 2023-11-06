Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C897E1B44
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Nov 2023 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjKFHdj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Nov 2023 02:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKFHdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Nov 2023 02:33:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0EAF
        for <linux-wireless@vger.kernel.org>; Sun,  5 Nov 2023 23:33:29 -0800 (PST)
X-UUID: c3c7f8847c7611eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J37wmEwEMmX9LbSDRr+Nj79WDT7N0f7jeuPPtyfYH5g=;
        b=h6rdLHVRDLub79PgxUqfpKU30aAZRya9HMmpUAKTKkdxPjuWVgu4/Xxc8lxiBe91zGlYQ3mrJ4zvXSLGM+hi3i9JWhJsniWtK/iRjYZRJMlfaikx0X7Wd9Ll+nZe5Ot0KOPlqvJJ4D7EgET3PoCScO2wXfpRtoX9R1U7RbhbStE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:5ad95e9e-beb2-405f-9c2a-8bb6f2b4b3e5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:98170f95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c3c7f8847c7611eea33bb35ae8d461a2-20231106
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <michael-cy.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 31344608; Mon, 06 Nov 2023 15:33:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 15:33:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 15:33:22 +0800
From:   Michael-CY Lee <michael-cy.lee@mediatek.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Michael-CY Lee <michael-cy.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mac80211: Refactor STA CSA parsing flow
Date:   Mon, 6 Nov 2023 15:33:01 +0800
Message-ID: <20231106073301.7351-2-michael-cy.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231106073301.7351-1-michael-cy.lee@mediatek.com>
References: <20231106073301.7351-1-michael-cy.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Wi-Fi Standard (IEEE 802.11-2020 9.4.2.160) initially specified that
the Wide Bandwidth Channel Switch (WBCS) IE subfields have same definitions
as the S1G or VHT Operation Information according to the operating band.

However, it did not change the definitions in the amendment for 6 GHz
(IEEE 802.11ax-2021), so the logic remain the same for handling the WBCS
IE even if there is no VHT mode in 6 GHz.

Now the Wi-Fi Standard draft (IEEE P80211be D3.2 9.4.2.159) modifies the
defitions, making the WBCS IE subfields follow the definitions of S1G,
VHT and HE Operation Information in S1G, 5 GHz and 6 GHz band, respectively.

APs in 6 GHz band might use the VHT or HE Operation Information to build
a WBCS IE according to the Wi-Fi Standard they follow. Originally, the STA
just parsed the WBCS IE as VHT Operation Inforamtion, which was wrong if
the AP was actually build the IE by the HE Operation Information.

To avoid the ambiguity, STA should prefer the op_class in the Extended
Channel Switch Announcement (ECSA) IE rathen than the WBCS IE. If the ECSA
IE is not presented in a channel switch to 6 GHz, the STA should be aware
of the possible ambiguity when parsing the WBCS IE.

To derive the correct bandwidtin in use, the STA should check the
combination of new channel width, ccfs0 and ccfs1, see the following
table:

| width|          ccfs1|            ccfs2| new BW in MHz|
---------------------------------------------------------
|     0|    center freq|                0|            40|
|     1|    center freq|                0|            80|
|     1| primary 80 MHz| secondary 80 MHz|         80P80|
|     1| primary 80 MHz|      center freq|           160|
|     1|    center freq|                0|            40|
|     2|    center freq|                0|           160|
|     2|    center freq|                0|            80|
|     3| primary 80 MHz| secondary 80 MHz|         80P80|
|     3| primary 80 MHz|      center freq|           160|

This patch refactors the STA parsing CSA flow:

1. If the BWI IE is not presented while the ECSA IE is presented, this
   patch uses the subfield op_class to build the HT, VHT and HE operation
   in 2.4 GHz, 5 GHz and 6 GHz band, respectively.
2. If the BWI and ECSA IE are NOT presented while the WBCS IE is presented,
   the new channel width is at least 40 MHz.
   Therefore this patch first prepares a 40 MHz chandef, then builds the
   HT, VHT and HE operation in 2 GHz, 5 GHz and 6 GHz band, respectively.
   In the 6 GHz band, this patch checks the combination of new channel
   width, ccfs0 and ccfs1 to build the correct HE operation.
3. From the HT/VHT/HE operation created in step 1 or 2, this patch then
   creates the chandef and assigns it to csa_ie.

Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Money Wang <money.wang@mediatek.com>
---
 net/mac80211/spectmgmt.c | 512 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 456 insertions(+), 56 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 55959b0b24c5..39441a4955eb 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -19,6 +19,332 @@
 #include "sta_info.h"
 #include "wme.h"
 
+static inline void
+op_class_to_6ghz_he_eht_oper(u8 op_class, struct ieee80211_channel *chan,
+			     struct ieee80211_he_operation *he_oper,
+			     struct ieee80211_eht_operation *eht_oper)
+{
+	u8 new_chan_width;
+	u32 he_oper_params, center_freq1 = 0, center_freq2 = 0;
+	struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	struct ieee80211_eht_operation_info *eht_oper_info;
+
+	new_chan_width = ieee80211_operating_class_to_chan_width(op_class);
+	if (!ieee80211_operating_class_to_center_freq(op_class, chan,
+						      &center_freq1,
+						      &center_freq2)) {
+		new_chan_width = NL80211_CHAN_WIDTH_20;
+		center_freq1 = chan->center_freq;
+	}
+
+	he_oper_params =
+		u32_encode_bits(1, IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
+	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
+
+	he_6ghz_oper = (struct ieee80211_he_6ghz_oper *)he_oper->optional;
+	he_6ghz_oper->primary =
+		ieee80211_frequency_to_channel(chan->center_freq);
+	he_6ghz_oper->ccfs0 = ieee80211_frequency_to_channel(center_freq1);
+	he_6ghz_oper->ccfs1 = center_freq2 ?
+		ieee80211_frequency_to_channel(center_freq2) : 0;
+
+	switch (new_chan_width) {
+	case NL80211_CHAN_WIDTH_320:
+		/* Cannot derive center frequency of 320 MHZ from op_class
+		 * since it might be 320 Mhz-1 or 320 Mhz-2.
+		 */
+		WARN_ON(1);
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		he_6ghz_oper->ccfs1 = he_6ghz_oper->ccfs0;
+		he_6ghz_oper->ccfs0 += chan->center_freq < center_freq1 ? -8 : 8;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_80P80:
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ;
+		break;
+	default:
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ;
+		break;
+	}
+
+	eht_oper->params = IEEE80211_EHT_OPER_INFO_PRESENT;
+
+	eht_oper_info =
+		(struct ieee80211_eht_operation_info *)eht_oper->optional;
+	eht_oper_info->control = he_6ghz_oper->control;
+	eht_oper_info->ccfs0 = he_6ghz_oper->ccfs0;
+	eht_oper_info->ccfs1 = he_6ghz_oper->ccfs1;
+}
+
+static inline void
+wbcs_ie_to_6ghz_he_eht_oper(const struct ieee80211_wide_bw_chansw_ie *wbcs_ie,
+			    u8 new_chan_no,
+			    struct ieee80211_he_operation *he_oper,
+			    struct ieee80211_eht_operation *eht_oper)
+{
+	u32 he_oper_params;
+	struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	struct ieee80211_eht_operation_info *eht_oper_info;
+	bool fallback_20mhz;
+	u8 ccfs_diff;
+
+	he_oper_params =
+		u32_encode_bits(1, IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
+	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
+
+	he_6ghz_oper = (struct ieee80211_he_6ghz_oper *)he_oper->optional;
+	he_6ghz_oper->primary = new_chan_no;
+
+	/* The Wide Bandwidth Channel Switch IE in a 6 GHz BSS migth be
+	 * deprecated VHT operation, VHT operation (IEEE 802.11-2020 9.4.2.160)
+	 * or HE operation (IEEE P80211be D3.2 9.4.2.159).
+	 * Check the combination of width, ccfs0 and ccfs1 to build the correct
+	 * HE/EHT operation.
+	 */
+	he_6ghz_oper->ccfs0 = wbcs_ie->new_center_freq_seg0;
+	he_6ghz_oper->ccfs1 = wbcs_ie->new_center_freq_seg1;
+	switch (wbcs_ie->new_channel_width) {
+	case 0:
+		/* Must be [deprecated] VHT operation with 40 MHz bandwidth */
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ;
+		break;
+	case 1:
+		if (he_6ghz_oper->ccfs1) {
+			/* VHT operation with 160/80P80 MHz bandwidth */
+			he_6ghz_oper->control =
+				IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
+		} else if ((he_6ghz_oper->ccfs0 - 7) % 16 == 0) {
+			/* [deprecated] VHT operation with 80 MHz bandwidth */
+			he_6ghz_oper->control =
+				IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ;
+		} else {
+			/* HE operation with 40 MHz bandwidth */
+			he_6ghz_oper->control =
+				IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ;
+		}
+		break;
+	case 2:
+		if ((he_6ghz_oper->ccfs0 - 15) % 32 == 0) {
+			/* deprecated VHT operation with 160 MHz bandwidth */
+			he_6ghz_oper->control =
+				IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
+			he_6ghz_oper->ccfs1 = he_6ghz_oper->ccfs0;
+			he_6ghz_oper->ccfs0 +=
+				new_chan_no < he_6ghz_oper->ccfs0 ? -8 : 8;
+		} else {
+			/* HE operation with 80 MHz bandwidth */
+			he_6ghz_oper->control =
+				IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ;
+		}
+		break;
+	case 3:
+		/* Can be
+		 * 1. deprecated VHT operation with 80P80 MHz bandwidth
+		 * 2. HE operation with 160/80P80 MHz bandwidth
+		 */
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ;
+		break;
+	case 4:
+		/* 320 MHz bandwidth
+		 * TODO channel switch to 320 MHz bandwidth should be indiated
+		 * by Bandwidth Indication IE (IEEE P80211be D3.2 9.4.2.159)
+		 */
+		he_6ghz_oper->control = IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
+		break;
+	default:
+		/* Ignore invalid width */
+		break;
+	}
+
+	/* Validate the relationship between new channel width and center frequency
+	 * segments, and fallback to 20 MHz if the relationship is wrong.
+	 */
+	fallback_20mhz = false;
+	switch (he_6ghz_oper->control) {
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ:
+		if ((he_6ghz_oper->ccfs0 - 3) % 8 != 0)
+			fallback_20mhz = true;
+		break;
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ:
+		if ((he_6ghz_oper->ccfs0 - 7) % 16 != 0)
+			fallback_20mhz = true;
+		break;
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
+		ccfs_diff = abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0);
+		if ((ccfs_diff == 8 && (he_6ghz_oper->ccfs1 - 15) % 32 != 0) ||
+		    (ccfs_diff > 16 && ((he_6ghz_oper->ccfs0 - 7) % 16 != 0 ||
+		    (he_6ghz_oper->ccfs1 - 7) % 16 != 0)))
+			fallback_20mhz = true;
+		break;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
+		if ((he_6ghz_oper->ccfs1 - 31) % 32 != 0)
+			fallback_20mhz = true;
+		break;
+	}
+
+	if (fallback_20mhz) {
+		he_6ghz_oper->control =
+			IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ;
+		he_6ghz_oper->ccfs0 = he_6ghz_oper->primary;
+		he_6ghz_oper->ccfs1 = 0;
+	}
+
+	eht_oper->params = IEEE80211_EHT_OPER_INFO_PRESENT;
+	eht_oper_info =
+		(struct ieee80211_eht_operation_info *)eht_oper->optional;
+	eht_oper_info->control = he_6ghz_oper->control;
+	eht_oper_info->ccfs0 = he_6ghz_oper->ccfs0;
+	eht_oper_info->ccfs1 = he_6ghz_oper->ccfs1;
+}
+
+static inline void
+op_class_to_ht_vht_oper(u8 op_class, struct ieee80211_channel *chan,
+			struct ieee80211_ht_operation *ht_oper,
+			struct ieee80211_vht_operation *vht_oper)
+{
+	u8 new_chan_width;
+	u32 center_freq1 = 0, center_freq2 = 0;
+
+	new_chan_width = ieee80211_operating_class_to_chan_width(op_class);
+	if (!ieee80211_operating_class_to_center_freq(op_class, chan,
+						      &center_freq1,
+						      &center_freq2)) {
+		new_chan_width = NL80211_CHAN_WIDTH_20;
+		center_freq1 = chan->center_freq;
+	}
+
+	vht_oper->center_freq_seg0_idx =
+		ieee80211_frequency_to_channel(center_freq1);
+	vht_oper->center_freq_seg1_idx = center_freq2 ?
+		ieee80211_frequency_to_channel(center_freq2) : 0;
+
+	ht_oper->ht_param = (chan->center_freq / 20) & 1 ?
+				IEEE80211_HT_PARAM_CHA_SEC_ABOVE :
+				IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+
+	switch (new_chan_width) {
+	case NL80211_CHAN_WIDTH_320:
+		WARN_ON(1);
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_80MHZ;
+		vht_oper->center_freq_seg1_idx = vht_oper->center_freq_seg0_idx;
+		vht_oper->center_freq_seg0_idx +=
+			chan->center_freq < center_freq1 ? -8 : 8;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_80MHZ;
+		break;
+	default:
+		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_USE_HT;
+		if (chan->center_freq != center_freq1)
+			ht_oper->ht_param = chan->center_freq > center_freq1 ?
+				IEEE80211_HT_PARAM_CHA_SEC_BELOW :
+				IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
+		else
+			ht_oper->ht_param = IEEE80211_HT_PARAM_CHA_SEC_NONE;
+	}
+
+	ht_oper->operation_mode =
+		cpu_to_le16(vht_oper->center_freq_seg1_idx <<
+				IEEE80211_HT_OP_MODE_CCFS2_SHIFT);
+}
+
+static inline void
+wbcs_ie_to_ht_vht_oper(struct ieee80211_channel *chan,
+		       const struct ieee80211_wide_bw_chansw_ie *wbcs_ie,
+		       struct ieee80211_ht_operation *ht_oper,
+		       struct ieee80211_vht_operation *vht_oper)
+{
+	u8 new_chan_width, new_ccfs0, new_ccfs1;
+	bool fallback_20mhz;
+
+	new_chan_width = wbcs_ie->new_channel_width;
+	new_ccfs0 = wbcs_ie->new_center_freq_seg0;
+	new_ccfs1 = wbcs_ie->new_center_freq_seg1;
+
+	/* Validate the relationship between new channel width and center frequency
+	 * segments, and fallback to 20 MHz if the relationship is wrong.
+	 */
+	fallback_20mhz = false;
+	switch (new_chan_width) {
+	case IEEE80211_VHT_CHANWIDTH_USE_HT:
+		/* If the wide bandwidth channel switch IE is presented,
+		 * the new channel width is at least 40 MHz.
+		 */
+		if (!new_ccfs1) {
+			new_ccfs0 -= (new_ccfs0 >= 149) ? 151 : 38;
+			if (new_ccfs0 % 8 != 0)
+				fallback_20mhz = true;
+		} else {
+			fallback_20mhz = true;
+		}
+		break;
+	case IEEE80211_VHT_CHANWIDTH_80MHZ:
+		if (!new_ccfs1) {
+			new_ccfs0 -= (new_ccfs0 >= 149) ? 155 : 42;
+			if (new_ccfs0 % 16 != 0)
+				fallback_20mhz = true;
+			break;
+		} else if (abs(new_ccfs1 - new_ccfs0) == 8) {
+			new_ccfs0 = new_ccfs1;
+			new_ccfs1 = 0;
+		}
+		fallthrough;
+	case IEEE80211_VHT_CHANWIDTH_160MHZ:
+		if (!new_ccfs1) {
+			if (new_ccfs0 != 50 && new_ccfs0 != 114 && new_ccfs0 != 163)
+				fallback_20mhz = true;
+			break;
+		}
+		fallthrough;
+	case IEEE80211_VHT_CHANWIDTH_80P80MHZ:
+		new_ccfs0 -= (new_ccfs0 >= 149) ? 155 : 42;
+		new_ccfs1 -= (new_ccfs1 >= 149) ? 155 : 42;
+		if (new_ccfs0 % 16 != 0 || new_ccfs1 % 16 != 0)
+			fallback_20mhz = true;
+		break;
+	default:
+		fallback_20mhz = true;
+	}
+
+	if (fallback_20mhz) {
+		ht_oper->ht_param = IEEE80211_HT_PARAM_CHA_SEC_NONE;
+
+		vht_oper->chan_width = IEEE80211_VHT_CHANWIDTH_USE_HT;
+		vht_oper->center_freq_seg0_idx =
+			ieee80211_frequency_to_channel(chan->center_freq);
+		vht_oper->center_freq_seg1_idx = 0;
+
+	} else {
+		ht_oper->ht_param = (chan->center_freq / 20) & 1 ?
+					IEEE80211_HT_PARAM_CHA_SEC_ABOVE :
+					IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+
+		vht_oper->chan_width = new_chan_width;
+		vht_oper->center_freq_seg0_idx = wbcs_ie->new_center_freq_seg0;
+		vht_oper->center_freq_seg1_idx = wbcs_ie->new_center_freq_seg1;
+	}
+
+	ht_oper->operation_mode = cpu_to_le16(vht_oper->center_freq_seg1_idx <<
+					      IEEE80211_HT_OP_MODE_CCFS2_SHIFT);
+}
+
 int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
@@ -26,14 +352,21 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 ieee80211_conn_flags_t conn_flags, u8 *bssid,
 				 struct ieee80211_csa_ie *csa_ie)
 {
+	struct ieee80211_supported_band *sband;
 	enum nl80211_band new_band = current_band;
-	int new_freq;
-	u8 new_chan_no;
+	int new_freq, size;
+	u8 new_chan_no = 0, new_op_class = 0;
 	struct ieee80211_channel *new_chan;
-	struct cfg80211_chan_def new_vht_chandef = {};
+	struct cfg80211_chan_def new_chandef = {};
 	const struct ieee80211_sec_chan_offs_ie *sec_chan_offs;
 	const struct ieee80211_wide_bw_chansw_ie *wide_bw_chansw_ie;
 	const struct ieee80211_bandwidth_indication *bwi;
+	const struct ieee80211_ext_chansw_ie *ext_chansw_ie;
+	struct ieee80211_ht_operation *ht_oper;
+	struct ieee80211_vht_operation *vht_oper;
+	struct ieee80211_he_operation *he_oper;
+	struct ieee80211_eht_operation *eht_oper;
+	struct ieee80211_sta_ht_cap sta_ht_cap;
 	int secondary_channel_offset = -1;
 
 	memset(csa_ie, 0, sizeof(*csa_ie));
@@ -41,6 +374,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	sec_chan_offs = elems->sec_chan_offs;
 	wide_bw_chansw_ie = elems->wide_bw_chansw_ie;
 	bwi = elems->bandwidth_indication;
+	ext_chansw_ie = elems->ext_chansw_ie;
 
 	if (conn_flags & (IEEE80211_CONN_DISABLE_HT |
 			  IEEE80211_CONN_DISABLE_40MHZ)) {
@@ -48,29 +382,30 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		wide_bw_chansw_ie = NULL;
 	}
 
-	if (conn_flags & IEEE80211_CONN_DISABLE_VHT)
-		wide_bw_chansw_ie = NULL;
-
-	if (elems->ext_chansw_ie) {
-		if (!ieee80211_operating_class_to_band(
-				elems->ext_chansw_ie->new_operating_class,
-				&new_band)) {
-			sdata_info(sdata,
-				   "cannot understand ECSA IE operating class, %d, ignoring\n",
-				   elems->ext_chansw_ie->new_operating_class);
+	if (ext_chansw_ie) {
+		new_op_class = ext_chansw_ie->new_operating_class;
+		if (!ieee80211_operating_class_to_band(new_op_class, &new_band)) {
+			new_op_class = 0;
+			sdata_info(sdata, "cannot understand ECSA IE "
+					  "operating class, %d, ignoring\n",
+				   ext_chansw_ie->new_operating_class);
+		} else {
+			new_chan_no = ext_chansw_ie->new_ch_num;
+			csa_ie->count = ext_chansw_ie->count;
+			csa_ie->mode = ext_chansw_ie->mode;
 		}
-		new_chan_no = elems->ext_chansw_ie->new_ch_num;
-		csa_ie->count = elems->ext_chansw_ie->count;
-		csa_ie->mode = elems->ext_chansw_ie->mode;
-	} else if (elems->ch_switch_ie) {
+	}
+
+	if (!new_op_class && elems->ch_switch_ie) {
 		new_chan_no = elems->ch_switch_ie->new_ch_num;
 		csa_ie->count = elems->ch_switch_ie->count;
 		csa_ie->mode = elems->ch_switch_ie->mode;
-	} else {
-		/* nothing here we understand */
-		return 1;
 	}
 
+	/* nothing here we understand */
+	if (!new_chan_no)
+		return 1;
+
 	/* Mesh Channel Switch Parameters Element */
 	if (elems->mesh_chansw_params_ie) {
 		csa_ie->ttl = elems->mesh_chansw_params_ie->mesh_ttl;
@@ -136,59 +471,124 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 
 	if (bwi) {
 		/* start with the CSA one */
-		new_vht_chandef = csa_ie->chandef;
+		new_chandef = csa_ie->chandef;
 		/* and update the width accordingly */
 		/* FIXME: support 160/320 */
 		ieee80211_chandef_eht_oper(&bwi->info, true, true,
-					   &new_vht_chandef);
-	} else if (wide_bw_chansw_ie) {
-		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
-		struct ieee80211_vht_operation vht_oper = {
-			.chan_width =
-				wide_bw_chansw_ie->new_channel_width,
-			.center_freq_seg0_idx =
-				wide_bw_chansw_ie->new_center_freq_seg0,
-			.center_freq_seg1_idx = new_seg1,
-			/* .basic_mcs_set doesn't matter */
-		};
-		struct ieee80211_ht_operation ht_oper = {
-			.operation_mode =
-				cpu_to_le16(new_seg1 <<
-					    IEEE80211_HT_OP_MODE_CCFS2_SHIFT),
-		};
-
-		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
-		 * to the previously parsed chandef
-		 */
-		new_vht_chandef = csa_ie->chandef;
+					   &new_chandef);
+	} else if (new_band == NL80211_BAND_6GHZ) {
+		size = sizeof(struct ieee80211_he_operation) +
+		       sizeof(struct ieee80211_he_6ghz_oper);
+		he_oper = kzalloc(size, GFP_KERNEL);
+		if (!he_oper)
+			return -ENOMEM;
+
+		size = sizeof(struct ieee80211_eht_operation) +
+		       sizeof(struct ieee80211_eht_operation_info);
+		eht_oper = kzalloc(size, GFP_KERNEL);
+		if (!eht_oper) {
+			kfree(he_oper);
+			return -ENOMEM;
+		}
+
+		if (new_op_class && new_op_class != 135 && new_op_class != 137) {
+			/* There is no way to tell the ccfs1 for op_class 135
+			 * (80P80 MHz) and 137 (320 MHz).
+			 */
+			op_class_to_6ghz_he_eht_oper(new_op_class, new_chan,
+						     he_oper, eht_oper);
+		} else if (wide_bw_chansw_ie) {
+			wbcs_ie_to_6ghz_he_eht_oper(wide_bw_chansw_ie,
+						    new_chan_no, he_oper,
+						    eht_oper);
+		}
+
+		new_chandef = csa_ie->chandef;
 
 		/* ignore if parsing fails */
-		if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
-						vht_cap_info,
-						&vht_oper, &ht_oper,
-						&new_vht_chandef))
-			new_vht_chandef.chan = NULL;
+		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, eht_oper,
+						    &new_chandef))
+			new_chandef.chan = NULL;
+
+		kfree(he_oper);
+		kfree(eht_oper);
+	} else {
+		sband = sdata->local->hw.wiphy->bands[new_band];
+		memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+
+		if (!sta_ht_cap.ht_supported ||
+		    !(sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			goto out;
+
+		ht_oper = kzalloc(sizeof(*ht_oper), GFP_KERNEL);
+		if (!ht_oper)
+			return -ENOMEM;
+
+		vht_oper = kzalloc(sizeof(*vht_oper), GFP_KERNEL);
+		if (!vht_oper) {
+			kfree(ht_oper);
+			return -ENOMEM;
+		}
+
+		if (new_op_class && new_op_class != 130) {
+			/* There is no way to tell the ccfs1 for op_class 130
+			 * (80P80 MHz).
+			 */
+			op_class_to_ht_vht_oper(new_op_class, new_chan, ht_oper,
+						vht_oper);
+		} else if (wide_bw_chansw_ie && new_band == NL80211_BAND_5GHZ &&
+			   sband->vht_cap.vht_supported) {
+			/* It is assumed that there is no WBCS IE in the beacon
+			 * from a 2 GHz BSS during a channel switch.
+			 */
+			wbcs_ie_to_ht_vht_oper(new_chan, wide_bw_chansw_ie,
+					       ht_oper, vht_oper);
+		} else {
+			kfree(ht_oper);
+			kfree(vht_oper);
+			goto out;
+		}
+
+		new_chandef = csa_ie->chandef;
+
+		ieee80211_chandef_ht_oper(ht_oper, &new_chandef);
+
+		/* ignore if parsing fails */
+		if (sband->vht_cap.vht_supported &&
+		    !ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
+						vht_oper, ht_oper, &new_chandef))
+			new_chandef.chan = NULL;
+
+		kfree(ht_oper);
+		kfree(vht_oper);
+	}
+
+	if (new_chandef.chan) {
+		if (conn_flags & IEEE80211_CONN_DISABLE_320MHZ &&
+		    new_chandef.width == NL80211_CHAN_WIDTH_320)
+			ieee80211_chandef_downgrade(&new_chandef);
 
 		if (conn_flags & IEEE80211_CONN_DISABLE_80P80MHZ &&
-		    new_vht_chandef.width == NL80211_CHAN_WIDTH_80P80)
-			ieee80211_chandef_downgrade(&new_vht_chandef);
+		    new_chandef.width == NL80211_CHAN_WIDTH_80P80)
+			ieee80211_chandef_downgrade(&new_chandef);
+
 		if (conn_flags & IEEE80211_CONN_DISABLE_160MHZ &&
-		    new_vht_chandef.width == NL80211_CHAN_WIDTH_160)
-			ieee80211_chandef_downgrade(&new_vht_chandef);
-	}
+		    new_chandef.width == NL80211_CHAN_WIDTH_160)
+			ieee80211_chandef_downgrade(&new_chandef);
 
-	/* if VHT data is there validate & use it */
-	if (new_vht_chandef.chan) {
-		if (!cfg80211_chandef_compatible(&new_vht_chandef,
+		if (!cfg80211_chandef_compatible(&new_chandef,
 						 &csa_ie->chandef)) {
 			sdata_info(sdata,
 				   "BSS %pM: CSA has inconsistent channel data, disconnecting\n",
 				   bssid);
 			return -EINVAL;
 		}
-		csa_ie->chandef = new_vht_chandef;
+
+		csa_ie->chandef = new_chandef;
 	}
 
+out:
 	if (elems->max_channel_switch_time)
 		csa_ie->max_switch_time =
 			(elems->max_channel_switch_time[0] << 0) |
-- 
2.25.1

