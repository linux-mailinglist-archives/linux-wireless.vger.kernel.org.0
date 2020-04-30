Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82EE1C0A4E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 00:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgD3WVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 18:21:31 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18610 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbgD3WVb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 18:21:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588285290; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=DcGrV8HlAtF6+uZZ+2b5rHHKNTAIUmF3GlDI2uuQP2M=; b=MRTHzQAIKE/RXqgcP0Aj7j6sTZng87gV9DbVs7ouzxH2g3Mnjf+1JZG1vsCFkCqIMoQ6Z5yl
 hRWnRVmcwp17gOLWfeWOoAtlFPbmtB8t+vG/xeHNw0XnkT+TnCsdksrsWj0i0mafSQIJgBi2
 6Eocay/swSS7N7nhcWuCf10o5Nw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eab4f5d.7f3fd531cd88-smtp-out-n03;
 Thu, 30 Apr 2020 22:21:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23A36C432C2; Thu, 30 Apr 2020 22:21:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71FB8C433BA;
        Thu, 30 Apr 2020 22:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71FB8C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v2 08/11] mac80211: build HE operation with 6 GHz oper information
Date:   Thu, 30 Apr 2020 15:20:49 -0700
Message-Id: <1588285252-30034-8-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
References: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 6 GHz operation information (IEEE 802.11ax/D6.0, Figure 9-787k)
while building HE operation element for non-HE AP. This field is used to
determine channel information in the absence of HT/VHT IEs.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mesh.c        | 11 +++++---
 net/mac80211/util.c        | 63 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6517a56970b7..0bb442feb1db 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2175,7 +2175,7 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
 u8 *ieee80211_ie_build_he_6ghz_band_cap(u8 *pos, u16 he_6ghz_cap);
-u8 *ieee80211_ie_build_he_oper(u8 *pos);
+u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 2ca34869538d..0cbe3260c5c1 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -565,6 +565,7 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 {
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_supported_band *sband;
+	u32 len;
 	u8 *pos;
 
 	sband = ieee80211_get_sband(sdata);
@@ -578,11 +579,15 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
-	if (skb_tailroom(skb) < 2 + 1 + sizeof(struct ieee80211_he_operation))
+	len = 2 + 1 + sizeof(struct ieee80211_he_operation);
+	if (sdata->vif.bss_conf.chandef.chan->band == NL80211_BAND_6GHZ)
+		len += sizeof(struct ieee80211_he_oper_6ghz_op_info);
+
+	if (skb_tailroom(skb) < len)
 		return -ENOMEM;
 
-	pos = skb_put(skb, 2 + 1 + sizeof(struct ieee80211_he_operation));
-	ieee80211_ie_build_he_oper(pos);
+	pos = skb_put(skb, len);
+	ieee80211_ie_build_he_oper(pos, &sdata->vif.bss_conf.chandef);
 
 	return 0;
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2bcebe672c0d..90b8c42b1aa8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2977,13 +2977,18 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos + sizeof(struct ieee80211_vht_operation);
 }
 
-u8 *ieee80211_ie_build_he_oper(u8 *pos)
+u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_he_operation *he_oper;
+	struct ieee80211_he_oper_6ghz_op_info *he_6ghz_op;
 	u32 he_oper_params;
+	u8 ie_len = 1 + sizeof(struct ieee80211_he_operation);
+
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		ie_len += sizeof(struct ieee80211_he_oper_6ghz_op_info);
 
 	*pos++ = WLAN_EID_EXTENSION;
-	*pos++ = 1 + sizeof(struct ieee80211_he_operation);
+	*pos++ = ie_len;
 	*pos++ = WLAN_EID_EXT_HE_OPERATION;
 
 	he_oper_params = 0;
@@ -2993,16 +2998,66 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos)
 				IEEE80211_HE_OPERATION_ER_SU_DISABLE);
 	he_oper_params |= u32_encode_bits(1,
 				IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		he_oper_params |= u32_encode_bits(1,
+				IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
 
 	he_oper = (struct ieee80211_he_operation *)pos;
 	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
 
 	/* don't require special HE peer rates */
 	he_oper->he_mcs_nss_set = cpu_to_le16(0xffff);
+	pos += sizeof(struct ieee80211_he_operation);
 
-	/* TODO add VHT operational and 6GHz operational subelement? */
+	if (chandef->chan->band != NL80211_BAND_6GHZ)
+		goto out;
 
-	return pos + sizeof(struct ieee80211_vht_operation);
+	/* TODO add VHT operational */
+	he_6ghz_op = (struct ieee80211_he_oper_6ghz_op_info *)pos;
+	he_6ghz_op->min_rate = 6; /* 6 Mbps */
+	he_6ghz_op->primary_chan =
+		ieee80211_frequency_to_channel(chandef->chan->center_freq);
+	he_6ghz_op->center_freq_seg0_idx =
+		ieee80211_frequency_to_channel(chandef->center_freq1);
+	if (chandef->center_freq2)
+		he_6ghz_op->center_freq_seg1_idx =
+			ieee80211_frequency_to_channel(chandef->center_freq2);
+	else
+		he_6ghz_op->center_freq_seg1_idx = 0;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_160:
+		/* Convert 160 MHz channel width to new style as interop
+		 * workaround.
+		 */
+		he_6ghz_op->control =
+			IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ;
+		he_6ghz_op->center_freq_seg1_idx =
+			he_6ghz_op->center_freq_seg0_idx;
+		if (chandef->chan->center_freq < chandef->center_freq1)
+			he_6ghz_op->center_freq_seg0_idx -= 8;
+		else
+			he_6ghz_op->center_freq_seg0_idx += 8;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_80P80:
+		he_6ghz_op->control =
+			IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		he_6ghz_op->control = IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		he_6ghz_op->control = IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ;
+		break;
+	default:
+		he_6ghz_op->control = IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ;
+		break;
+	}
+
+	pos += sizeof(struct ieee80211_he_oper_6ghz_op_info);
+
+out:
+	return pos;
 }
 
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
-- 
2.7.4
