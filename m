Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFE294220
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbgJTSbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 14:31:32 -0400
Received: from z5.mailgun.us ([104.130.96.5]:27689 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390258AbgJTSbb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 14:31:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603218691; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=I/IA4K8w52uB26vzWid6os7fFtEWyv0Vp9iaOgxRsYs=; b=mGW3CzQY5KqmkPP9mTmkE4Dnuv3zvtkNz1JP1oDDJRKMNAVjoS9XFGvhlGgZ3QTT89SrSXUQ
 hyP9gTqZr46gmIWgmL5eSvMBGVUBnYKWLfBt5zZRhR7BwRs/8vcopn6tQ2JRdB7lyckd7W45
 d01hfGZlrNoQtxMoDhlf9ZabS+k=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f8f2cf957b88ccb5644a18b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 18:31:21
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44B73C433FF; Tue, 20 Oct 2020 18:31:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8593CC433C9;
        Tue, 20 Oct 2020 18:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8593CC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 1/4] mac80211: save HE oper info in BSS config for mesh
Date:   Tue, 20 Oct 2020 11:31:08 -0700
Message-Id: <20201020183111.25458-2-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020183111.25458-1-pradeepc@codeaurora.org>
References: <20201020183111.25458-1-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently he_support is set only for AP mode. Storing this
information for mesh BSS as well helps driver to determine
HE support. Also save HE operation element params in BSS
conf so that drivers can access this for any configurations
instead of having to parse the beacon to fetch that info.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 include/net/mac80211.h |  3 ++-
 net/mac80211/mesh.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e8e295dae744..ee72ea5ec861 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -621,7 +621,8 @@ struct ieee80211_fils_discovery {
  *	nontransmitted BSSIDs
  * @profile_periodicity: the least number of beacon frames need to be received
  *	in order to discover all the nontransmitted BSSIDs in the set.
- * @he_oper: HE operation information of the AP we are connected to
+ * @he_oper: HE operation information of the BSS (AP/Mesh) or of the AP we are
+ *	connected to (STA)
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
  * @fils_discovery: FILS discovery configuration
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index ce5825d6f1d1..97095b7c9c64 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -667,6 +667,35 @@ void ieee80211_mesh_root_setup(struct ieee80211_if_mesh *ifmsh)
 	}
 }
 
+static void
+ieee80211_mesh_update_bss_params(struct ieee80211_sub_if_data *sdata,
+				 u8 *ie, u8 ie_len)
+{
+	struct ieee80211_supported_band *sband;
+	const u8 *cap;
+	const struct ieee80211_he_operation *he_oper = NULL;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return;
+
+	if (!ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT) ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
+		return;
+
+	sdata->vif.bss_conf.he_support = true;
+
+	cap = cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION, ie, ie_len);
+	if (cap && cap[1] >= ieee80211_he_oper_size(&cap[3]))
+		he_oper = (void *)(cap + 3);
+
+	if (he_oper)
+		sdata->vif.bss_conf.he_oper.params =
+			__le32_to_cpu(he_oper->he_oper_params);
+}
+
 /**
  * ieee80211_fill_mesh_addresses - fill addresses of a locally originated mesh frame
  * @hdr:	802.11 frame header
@@ -943,6 +972,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 
 	bcn->tail_len = skb->len;
 	memcpy(bcn->tail, skb->data, bcn->tail_len);
+	ieee80211_mesh_update_bss_params(sdata, bcn->tail, bcn->tail_len);
 	bcn->meshconf = (struct ieee80211_meshconf_ie *)
 					(bcn->tail + ifmsh->meshconf_offset);
 
-- 
2.17.1

