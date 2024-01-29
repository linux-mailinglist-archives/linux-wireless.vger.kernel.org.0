Return-Path: <linux-wireless+bounces-2665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D08404BD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95731C21E29
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C560265;
	Mon, 29 Jan 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bF5vvmaB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FC60242
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530471; cv=none; b=C7d5sEGjdk1yxcstOAG9mi3C/tq0mkDIh7PjosArXoRJJvmmdURLq0HoIhBUu8OeRfZMyGEBJ6O8nwB4UkRHPNUbFvFRqWtY0ALfQUx0XQ7eyK1vTPNEUl/Gn9raiHe8KYZTeJ57d67ai9pXGdsrk6bsn8U1qEflLEk6S4BNM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530471; c=relaxed/simple;
	bh=Gs89PZed4BgdDQEDFKrvKcQJydk759cHZNZLQpXl5nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa9aojGnVWyWCyD+LoGnuZ4Xu+TiUY6kAXwoAKhI7vaDNdgnnD7+bSrVAORvnr7ahp5Moh/cHSF+4NHSZSKKHwxTZceiRAPnlQyu3LI9m/Iz+euPS7Vds17RHgPiGrLlgmA9RH5rJjWsCTlmC7I78yEleUUrkvSvRJ1gB8PJANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bF5vvmaB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iT9Y/uDSI26VhSJPF0hg9eTl2O2jJRFsT4qMaN/I1hQ=;
	t=1706530466; x=1707740066; b=bF5vvmaBZqn4JDM7H9eGszpQYbjPzglBpARlleP/NaB8Xes
	yLib3YgK5J9kKHQTVzG9kNFKAWa+farlwipuRl1ZYzQ392bj78mfc8z2VcEyFBP27dhgQTRgALKo2
	Qt3vgzd4f8O+lm79pBdPocme7G2Uf2PegdtHPLAUbUjGc6iX8p6qiviMByYTvlEc75vTf7U1YtDye
	+pJ89QEqvuz6huso4upMkBASwpO69AHhr3xsced02cRu6WXFzIHBQkRSd6L2ixMkS35Hbj9cYdlKr
	u3ZTnrqsAvDlj7Ywlj/o51+vUm+7lmDHcv0rbAcyGK4V8SRGgt3OjJrvSwd0577A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUQWm-00000004p5l-2cHn;
	Mon, 29 Jan 2024 13:14:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	coldolt <andypalmadi@gmail.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: improve CSA/ECSA connection refusal
Date: Mon, 29 Jan 2024 13:14:14 +0100
Message-ID: <20240129131413.cc2d0a26226e.I682c016af76e35b6c47007db50e8554c5a426910@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129131413.246972c8775e.Ibf834d7f52f9951a353b6872383da710a7358338@changeid>
References: <20240129131413.246972c8775e.Ibf834d7f52f9951a353b6872383da710a7358338@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

As mentioned in the previous commit, we pretty quickly found
that some APs have ECSA elements stuck in their probe response,
so using that to not attempt to connect while CSA is happening
we never connect to such an AP.

Improve this situation by checking more carefully and ignoring
the ECSA if cfg80211 has previously detected the ECSA element
being stuck in the probe response.

Additionally, allow connecting to an AP that's switching to a
channel it's already using, unless it's using quiet mode. In
this case, we may just have to adjust bandwidth later. If it's
actually switching channels, it's better not to try to connect
in the middle of that.

Reported-by: coldolt <andypalmadi@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com/
Fixes: c09c4f31998b ("wifi: mac80211: don't connect to an AP while it's in a CSA process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 105 ++++++++++++++++++++++++++++++++------------
 1 file changed, 77 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 073105deb424..c62c7c6ce91f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7309,6 +7309,75 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	return err;
 }
 
+static bool ieee80211_mgd_csa_present(struct ieee80211_sub_if_data *sdata,
+				      const struct cfg80211_bss_ies *ies,
+				      u8 cur_channel, bool ignore_ecsa)
+{
+	const struct element *csa_elem, *ecsa_elem;
+	struct ieee80211_channel_sw_ie *csa = NULL;
+	struct ieee80211_ext_chansw_ie *ecsa = NULL;
+
+	if (!ies)
+		return false;
+
+	csa_elem = cfg80211_find_elem(WLAN_EID_CHANNEL_SWITCH,
+				      ies->data, ies->len);
+	if (csa_elem && csa_elem->datalen == sizeof(*csa))
+		csa = (void *)csa_elem->data;
+
+	ecsa_elem = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				       ies->data, ies->len);
+	if (ecsa_elem && ecsa_elem->datalen == sizeof(*ecsa))
+		ecsa = (void *)ecsa_elem->data;
+
+	if (csa && csa->count == 0)
+		csa = NULL;
+	if (csa && !csa->mode && csa->new_ch_num == cur_channel)
+		csa = NULL;
+
+	if (ecsa && ecsa->count == 0)
+		ecsa = NULL;
+	if (ecsa && !ecsa->mode && ecsa->new_ch_num == cur_channel)
+		ecsa = NULL;
+
+	if (ignore_ecsa && ecsa) {
+		sdata_info(sdata,
+			   "Ignoring ECSA in probe response - was considered stuck!\n");
+		return csa;
+	}
+
+	return csa || ecsa;
+}
+
+static bool ieee80211_mgd_csa_in_process(struct ieee80211_sub_if_data *sdata,
+					 struct cfg80211_bss *bss)
+{
+	u8 cur_channel;
+	bool ret;
+
+	cur_channel = ieee80211_frequency_to_channel(bss->channel->center_freq);
+
+	rcu_read_lock();
+	if (ieee80211_mgd_csa_present(sdata,
+				      rcu_dereference(bss->beacon_ies),
+				      cur_channel, false)) {
+		ret = true;
+		goto out;
+	}
+
+	if (ieee80211_mgd_csa_present(sdata,
+				      rcu_dereference(bss->proberesp_ies),
+				      cur_channel, bss->proberesp_ecsa_stuck)) {
+		ret = true;
+		goto out;
+	}
+
+	ret = false;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 /* config hooks */
 int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		       struct cfg80211_auth_request *req)
@@ -7317,7 +7386,6 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_link_data *link;
-	const struct element *csa_elem, *ecsa_elem;
 	u16 auth_alg;
 	int err;
 	bool cont_auth;
@@ -7360,21 +7428,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->assoc_data)
 		return -EBUSY;
 
-	rcu_read_lock();
-	csa_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_CHANNEL_SWITCH);
-	ecsa_elem = ieee80211_bss_get_elem(req->bss,
-					   WLAN_EID_EXT_CHANSWITCH_ANN);
-	if ((csa_elem &&
-	     csa_elem->datalen == sizeof(struct ieee80211_channel_sw_ie) &&
-	     ((struct ieee80211_channel_sw_ie *)csa_elem->data)->count != 0) ||
-	    (ecsa_elem &&
-	     ecsa_elem->datalen == sizeof(struct ieee80211_ext_chansw_ie) &&
-	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
-		rcu_read_unlock();
+	if (ieee80211_mgd_csa_in_process(sdata, req->bss)) {
 		sdata_info(sdata, "AP is in CSA process, reject auth\n");
 		return -EINVAL;
 	}
-	rcu_read_unlock();
 
 	auth_data = kzalloc(sizeof(*auth_data) + req->auth_data_len +
 			    req->ie_len, GFP_KERNEL);
@@ -7684,7 +7741,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data;
-	const struct element *ssid_elem, *csa_elem, *ecsa_elem;
+	const struct element *ssid_elem;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	ieee80211_conn_flags_t conn_flags = 0;
 	struct ieee80211_link_data *link;
@@ -7707,6 +7764,12 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	cbss = req->link_id < 0 ? req->bss : req->links[req->link_id].bss;
 
+	if (ieee80211_mgd_csa_in_process(sdata, cbss)) {
+		sdata_info(sdata, "AP is in CSA process, reject assoc\n");
+		kfree(assoc_data);
+		return -EINVAL;
+	}
+
 	rcu_read_lock();
 	ssid_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_SSID);
 	if (!ssid_elem || ssid_elem->datalen > sizeof(assoc_data->ssid)) {
@@ -7715,20 +7778,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	csa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_CHANNEL_SWITCH);
-	ecsa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_EXT_CHANSWITCH_ANN);
-	if ((csa_elem &&
-	     csa_elem->datalen == sizeof(struct ieee80211_channel_sw_ie) &&
-	     ((struct ieee80211_channel_sw_ie *)csa_elem->data)->count != 0) ||
-	    (ecsa_elem &&
-	     ecsa_elem->datalen == sizeof(struct ieee80211_ext_chansw_ie) &&
-	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
-		sdata_info(sdata, "AP is in CSA process, reject assoc\n");
-		rcu_read_unlock();
-		kfree(assoc_data);
-		return -EINVAL;
-	}
-
 	memcpy(assoc_data->ssid, ssid_elem->data, ssid_elem->datalen);
 	assoc_data->ssid_len = ssid_elem->datalen;
 	memcpy(vif_cfg->ssid, assoc_data->ssid, assoc_data->ssid_len);
-- 
2.43.0


