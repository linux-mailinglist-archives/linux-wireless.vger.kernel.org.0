Return-Path: <linux-wireless+bounces-2166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE4831857
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77061C20F9A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34E241F5;
	Thu, 18 Jan 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QF0/NEG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380A241E6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576794; cv=none; b=YTIBidflmtV9hnMYGHMo5NA32YQiT9YotBulKkYqvF/NhdfLeLcarD0svOnyMn18d63JQIlxMQlkRxLpZPWnfK+H5Qb1jwIMywkReMpcpv6uCJrhd6DDKIM6RCR3/MQMDM9lnA99yGq6GgEqB6lERJFZJQggy2Idga4DldyHOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576794; c=relaxed/simple;
	bh=TTy+LTHrHFo22BkfzEpVwamB6yWrmwBcVTvizkCWicE=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=GMl0XQI11cVgZQTl7Z56Ku4LbfKcEiT8B1/y1ENyx9zh3VSQDsAbRUh2gRqJBvESVZGI9OpWNatUMuoqkCPqGbEO434YTjt4dvXeExD0OOSpav68smWR4Ut+wK9w+3OfIGjjfUfPD8L1QPT8OpM7oAsArRg3HC8LGU+hBmEhdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QF0/NEG5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cBMx0s6uA/mIw+qbsW0JnVH3RSARa4pBPQpgWKz1OCY=;
	t=1705576792; x=1706786392; b=QF0/NEG5fr2ZcjHVt5Dfavno4rmTKrylTZ4NiYvZ+CBjCtG
	nHLRm9sOrtB2aYyumKv2iyv7Mcrggz8ugZpqUi9gw0VK8gL19gkkFrI/S9lkRVhnjsXTkltVr9cDx
	CYUSz7yDXs0Ol4ZKUUlm4erYYYSb/BWuA2ffiaJx+y22oqe27cxXfDSxT7PBEcxWsCjhoDFul6vuH
	Zw8AMuCHBa1sD0tYEY+KvcSoxi+wPI4icy/5wK2MghtqUSJxTEDrb/v58fTn2qVN0g2tButvWaRCI
	Yat3HCr5siKZG3Mbp6r72o/RAjt98FPtHdOhGBvCWtkUdfW3xSQQ0I7v+qsjdKVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQQR3-00000007wVW-2Bhm;
	Thu, 18 Jan 2024 12:19:49 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: coldolt <andypalmadi@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/2] wifi: mac80211: improve CSA/ECSA connection refusal
Date: Thu, 18 Jan 2024 12:16:28 +0100
Message-ID: <20240118121941.05852b6b9362.I682c016af76e35b6c47007db50e8554c5a426910@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118111941.549593-4-johannes@sipsolutions.net>
References: <20240118111941.549593-4-johannes@sipsolutions.net>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 98 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c8998cf01b7a..3ac48423c441 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7257,6 +7257,68 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	return err;
 }
 
+static bool ieee80211_mgd_csa_present(struct ieee80211_sub_if_data *sdata,
+				      const struct cfg80211_bss_ies *ies,
+				      bool ignore_ecsa)
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
+
+	if (ecsa && ecsa->count == 0)
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
+	bool ret;
+
+	rcu_read_lock();
+	if (ieee80211_mgd_csa_present(sdata,
+				      rcu_dereference(bss->beacon_ies),
+				      false)) {
+		ret = true;
+		goto out;
+	}
+
+	if (ieee80211_mgd_csa_present(sdata,
+				      rcu_dereference(bss->proberesp_ies),
+				      bss->proberesp_ecsa_stuck)) {
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
@@ -7265,7 +7327,6 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_link_data *link;
-	const struct element *csa_elem, *ecsa_elem;
 	u16 auth_alg;
 	int err;
 	bool cont_auth;
@@ -7308,21 +7369,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
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
@@ -7631,7 +7681,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data;
-	const struct element *ssid_elem, *csa_elem, *ecsa_elem;
+	const struct element *ssid_elem;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	ieee80211_conn_flags_t conn_flags = 0;
 	struct ieee80211_link_data *link;
@@ -7654,6 +7704,12 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
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
@@ -7662,20 +7718,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
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


