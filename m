Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF862202BD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 05:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGODJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 23:09:45 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:23541 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbgGODJp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 23:09:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594782584; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LDraCycdrYUFDO+cpsBwm91tCEoFpX6yzK9Lz2c3eKE=; b=xdX0uJcLC2wqlSYf1LpUiTfpjU3Bm4vKm8MdnaNlyOeBq8/l4SYZct/G3yPueH2P9XcLSHIU
 dE3gWO9EN+0DxtscvXq1W/ip8q5qXwwecFMj4dS8bX/PbFmFGp2CaOrlTFIUEZUdDNe1QlIZ
 zZfJ77RciZpCphz7YiaUbbtV7Ck=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f0e73781e603dbb44be5b42 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 03:09:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64751C43387; Wed, 15 Jul 2020 03:09:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67B20C433CB;
        Wed, 15 Jul 2020 03:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67B20C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] mac80211: save he oper info in bss config for AP and mesh
Date:   Tue, 14 Jul 2020 20:09:37 -0700
Message-Id: <20200715030937.25290-1-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently he_support is set only for AP mode. Storing this
information for mesh bss as well helps driver to determine
he support. Also save he operation element params in bss
conf so that drivers can access this for any configurations
instead of having to parse the beacon to fetch that info.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 include/net/mac80211.h     | 3 ++-
 net/mac80211/cfg.c         | 4 ++++
 net/mac80211/ieee80211_i.h | 3 ++-
 net/mac80211/mesh.c        | 2 ++
 net/mac80211/util.c        | 4 +++-
 5 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 11d5610d2ad5..ef8ec345a201 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -604,7 +604,8 @@ struct ieee80211_ftm_responder_params {
  *	nontransmitted BSSIDs
  * @profile_periodicity: the least number of beacon frames need to be received
  *	in order to discover all the nontransmitted BSSIDs in the set.
- * @he_oper: HE operation information of the AP we are connected to
+ * @he_oper: HE operation information of the BSS (AP/Mesh) or of the AP we are
+ *	connected to (STA)
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
  */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9b360544ad6f..c80eb5bac86b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1019,6 +1019,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata->vif.bss_conf.frame_time_rts_th =
 			le32_get_bits(params->he_oper->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
+		sdata->vif.bss_conf.he_oper.params =
+			__le32_to_cpu(params->he_oper->he_oper_params);
+		sdata->vif.bss_conf.he_oper.nss_set =
+			__le16_to_cpu(params->he_oper->he_mcs_nss_set);
 	}
 
 	mutex_lock(&local->mtx);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec1a71ac65f2..47d1fcf365cf 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2184,7 +2184,8 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      u8 *end);
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 				    struct sk_buff *skb);
-u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
+u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef,
+			       struct ieee80211_sub_if_data *sdata);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5f1ca25b6c97..b84ddf6351db 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -601,6 +601,8 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
+	sdata->vif.bss_conf.he_support = true;
+
 	len = 2 + 1 + sizeof(struct ieee80211_he_operation);
 	if (sdata->vif.bss_conf.chandef.chan->band == NL80211_BAND_6GHZ)
 		len += sizeof(struct ieee80211_he_6ghz_oper);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 21c94094a699..eb3be6b89b0b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3028,7 +3028,8 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos + sizeof(struct ieee80211_vht_operation);
 }
 
-u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
+u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef,
+			       struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_he_operation *he_oper;
 	struct ieee80211_he_6ghz_oper *he_6ghz_op;
@@ -3056,6 +3057,7 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
 	he_oper = (struct ieee80211_he_operation *)pos;
 	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
 
+	sdata->vif.bss_conf.he_oper.params = he_oper_params;
 	/* don't require special HE peer rates */
 	he_oper->he_mcs_nss_set = cpu_to_le16(0xffff);
 	pos += sizeof(struct ieee80211_he_operation);
-- 
2.17.1

