Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73EC1B8224
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 00:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDXWmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 18:42:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:41446 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgDXWmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 18:42:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587768154; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=VxY8suiVyo1RraUmOlNWnapxuSMeUPKipYrG08rD4n8=; b=ADWch/ZgshUpNYBVt5hzeLXFLXeuKQMM4M/GqgftEYiQxX9E1IMAj+x8ZVrqNryF2dMc+rSn
 tFRqi2DeTsN7B6O96S6/lQIU5uIX2M9gNuTIMlOvZBBV5LVDaBk1UlJerLrJbqJe5wRznVjI
 KHodLRcNKGiNAZ2thwLITe5pM0I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea36b54.7f317777cab0-smtp-out-n05;
 Fri, 24 Apr 2020 22:42:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10E3BC432C2; Fri, 24 Apr 2020 22:42:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D9C5C433D2;
        Fri, 24 Apr 2020 22:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D9C5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 09/10] mac80211: determine chantype from HE operation in 6 GHz
Date:   Fri, 24 Apr 2020 15:41:47 -0700
Message-Id: <1587768108-25248-10-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 6 GHz band, determine chandef from 6 GHz operation information
of HE operation element.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/mesh.c        |  1 +
 net/mac80211/mlme.c        | 12 ++++++
 net/mac80211/util.c        | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d5f4fb3a7a73..70393084a1cb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2193,6 +2193,9 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
+bool ieee80211_chandef_he_oper(struct ieee80211_sub_if_data *sdata,
+			       const struct ieee80211_he_operation *heop,
+			       struct cfg80211_chan_def *chandef);
 u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
 
 int __must_check
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f6e46b18c304..daa2d6abef3f 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -99,6 +99,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	ieee80211_chandef_vht_oper(&sdata->local->hw,
 				   ie->vht_operation, ie->ht_operation,
 				   &sta_chan_def);
+	ieee80211_chandef_he_oper(sdata, ie->he_operation, &sta_chan_def);
 
 	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chandef,
 					 &sta_chan_def))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6ff1087e3bba..02d7d28594e5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -163,6 +163,9 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 	chandef->center_freq1 = channel->center_freq;
 
+	if (channel->band == NL80211_BAND_6GHZ)
+		goto skip_ht_vht_oper;
+
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
@@ -263,6 +266,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	*chandef = vht_chandef;
 
+skip_ht_vht_oper:
+	if (!ieee80211_chandef_he_oper(sdata, he_oper, chandef)) {
+		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+			sdata_info(sdata,
+				   "AP HE information is invalid, disable HE\n");
+		ret = IEEE80211_STA_DISABLE_HE;
+		goto out;
+	}
+
 	ret = 0;
 
 out:
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 90b8c42b1aa8..660cf52913f1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3170,6 +3170,98 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw,
 	return true;
 }
 
+bool ieee80211_chandef_he_oper(struct ieee80211_sub_if_data *sdata,
+			       const struct ieee80211_he_operation *heop,
+			       struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_he_oper_6ghz_op_info info;
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	struct cfg80211_chan_def new = *chandef;
+	int cf0, cf1;
+	int ccf0, ccf1;
+	bool support_80_80;
+	bool support_160;
+	u8 he_phy_cap;
+	u8 pos = 0;
+
+	if (!heop)
+		return false;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return false;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, sdata->vif.type);
+	if (!he_cap)
+		return false;
+
+	if (!(le32_to_cpu(heop->he_oper_params) &
+				IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
+		return false;
+
+	he_phy_cap = he_cap->he_cap_elem.phy_cap_info[0];
+	support_160 =
+		!!(he_phy_cap &
+		   IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
+	support_80_80 =
+		!!(he_phy_cap &
+		   IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
+
+	if (le32_to_cpu(heop->he_oper_params) &
+	    IEEE80211_HE_OPERATION_VHT_OPER_INFO)
+		pos += 3;
+	if (le32_to_cpu(heop->he_oper_params) &
+	    IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
+		pos += 1;
+
+	memcpy(&info, &heop->optional[pos], sizeof(info));
+	ccf0 = info.center_freq_seg0_idx;
+	ccf1 = info.center_freq_seg1_idx;
+
+	cf0 = ieee80211_channel_to_frequency(ccf0, chandef->chan->band);
+	cf1 = ieee80211_channel_to_frequency(ccf1, chandef->chan->band);
+
+	switch (info.control & 0x3) {
+	case IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ:
+		new.center_freq1 = cf0;
+		new.width = NL80211_CHAN_WIDTH_20;
+		break;
+	case IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ:
+		new.center_freq1 = cf0;
+		new.width = NL80211_CHAN_WIDTH_40;
+		break;
+	case IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ:
+		new.center_freq1 = cf0;
+		new.width = NL80211_CHAN_WIDTH_80;
+		break;
+	case IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ:
+		new.center_freq1 = cf0;
+		new.width = NL80211_CHAN_WIDTH_80;
+		if (ccf1) {
+			unsigned int diff;
+
+			diff = abs(ccf1 - ccf0);
+			if (diff == 8 && support_160) {
+				new.width = NL80211_CHAN_WIDTH_160;
+				new.center_freq1 = cf1;
+			} else if ((diff > 8) && support_80_80) {
+				new.width = NL80211_CHAN_WIDTH_80P80;
+				new.center_freq2 = cf1;
+			}
+		}
+		break;
+	default:
+		return false;
+	}
+
+	if (!cfg80211_chandef_valid(&new))
+		return false;
+
+	*chandef = new;
+	return true;
+}
+
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates)
-- 
2.7.4
