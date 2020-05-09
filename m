Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC621CBBAE
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 02:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgEIANw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 20:13:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53460 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728498AbgEIANw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 20:13:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588983231; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4tl1qGfvbpOMqFrvZIHrhJs0A7tqTukkONqdYB0f/FM=; b=DNVhQS5iVJvUsfTZ5E0LfcZRHTeWn2zPNPk4xrzgPp93VwiUKcus3mcc5pSb9sj4gfLTnrOt
 8w/2gCi+czTVCvjNba3cRkyagHatF0yupoR0TdasCfG22eq2L44VQsPN2JocdkFxRzOepYdK
 HhROmqgvjyZQQkxOmwAOyX5sLmE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5f5a7.7f090a701ae8-smtp-out-n05;
 Sat, 09 May 2020 00:13:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01C13C43637; Sat,  9 May 2020 00:13:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 063EDC44791;
        Sat,  9 May 2020 00:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 063EDC44791
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v3 07/11] mac80211: add HE 6 GHz Band Capability IE in Assoc. Request
Date:   Fri,  8 May 2020 17:13:01 -0700
Message-Id: <1588983185-5741-7-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
References: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Construct HE 6 GHz band capability element element (IEEE 802.11ax/D6.0,
9.4.2.261) for association request and mesh beacon. The 6 GHz capability
information is passed by driver through iftypes caps.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mesh.c        | 34 ++++++++++++++++++++++++++++++++++
 net/mac80211/mesh.h        |  2 ++
 net/mac80211/mesh_plink.c  |  3 ++-
 net/mac80211/mlme.c        | 12 ++++++++++--
 net/mac80211/util.c        | 15 +++++++++++++++
 6 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 78a95a11458c..6517a56970b7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2174,6 +2174,7 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
 u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *end);
+u8 *ieee80211_ie_build_he_6ghz_band_cap(u8 *pos, u16 he_6ghz_cap);
 u8 *ieee80211_ie_build_he_oper(u8 *pos);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 36978a0e5000..2ca34869538d 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -587,6 +587,39 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct ieee80211_supported_band *sband;
+	u8 ie_len;
+	u8 *pos;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
+
+	if (!he_cap ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+		return 0;
+
+	if (!he_cap->has_he_6ghz)
+		return 0;
+
+	ie_len = 2 + 1 + sizeof(struct ieee80211_he_6ghz_band_cap);
+	if (skb_tailroom(skb) < ie_len)
+		return -ENOMEM;
+
+	pos = skb_put(skb, ie_len);
+	ieee80211_ie_build_he_6ghz_band_cap(pos, he_cap->he_6ghz.cap);
+
+	return 0;
+}
+
 static void ieee80211_mesh_path_timer(struct timer_list *t)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -885,6 +918,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 	    mesh_add_vht_oper_ie(sdata, skb) ||
 	    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
 	    mesh_add_he_oper_ie(sdata, skb) ||
+	    mesh_add_he_6ghz_cap_ie(sdata, skb) ||
 	    mesh_add_vendor_ies(sdata, skb))
 		goto out_free;
 
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 953f720754e8..40492d1bd8fd 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -222,6 +222,8 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 		       struct sk_buff *skb, u8 ie_len);
 int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 			struct sk_buff *skb);
+int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb);
 void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index e3e29b8d641d..dedb2341ebdd 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -328,7 +328,8 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 		    mesh_add_vht_cap_ie(sdata, skb) ||
 		    mesh_add_vht_oper_ie(sdata, skb) ||
 		    mesh_add_he_cap_ie(sdata, skb, ie_len_he_cap) ||
-		    mesh_add_he_oper_ie(sdata, skb))
+		    mesh_add_he_oper_ie(sdata, skb) ||
+		    mesh_add_he_6ghz_cap_ie(sdata, skb))
 			goto free;
 	}
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 58a082efc3b3..b4dfefd482a6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -654,6 +654,12 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 				      he_cap->he_cap_elem.phy_cap_info);
 	pos = skb_put(skb, he_cap_size);
 	ieee80211_ie_build_he_cap(pos, he_cap, pos + he_cap_size);
+
+	if (!he_cap->has_he_6ghz)
+		return;
+
+	pos = skb_put(skb, 5); /* 2 + 1 + sizeof(he_cap->he_6ghz.cap) */
+	ieee80211_ie_build_he_6ghz_band_cap(pos, he_cap->he_6ghz.cap);
 }
 
 static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
@@ -4803,7 +4809,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!sband->ht_cap.ht_supported) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		if (sband->band != NL80211_BAND_6GHZ)
+			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
 	if (!sband->vht_cap.vht_supported)
@@ -5493,7 +5500,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (req->flags & ASSOC_REQ_DISABLE_HT) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		if (sband->band != NL80211_BAND_6GHZ)
+			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_VHT)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 5a33755c22f4..2bcebe672c0d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2839,6 +2839,21 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 	return pos;
 }
 
+u8 *ieee80211_ie_build_he_6ghz_band_cap(u8 *pos, u16 he_6ghz_cap)
+{
+	__le16 cap = cpu_to_le16(he_6ghz_cap);
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 3;
+	*pos++ = WLAN_EID_EXT_HE_6GHZ_BAND_CAP;
+
+	/* Fixed data */
+	memcpy(pos, &cap, sizeof(cap));
+	pos += sizeof(cap);
+
+	return pos;
+}
+
 u8 *ieee80211_ie_build_ht_oper(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
 			       const struct cfg80211_chan_def *chandef,
 			       u16 prot_mode, bool rifs_mode)
-- 
2.7.4
