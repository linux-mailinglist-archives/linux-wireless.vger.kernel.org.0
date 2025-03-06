Return-Path: <linux-wireless+bounces-19878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C531A5482F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C348C188DAE5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CD2040BE;
	Thu,  6 Mar 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Csr7oSS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73E204C28
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257824; cv=none; b=sknTWxaPMksvYvGzZSSs83/lUOL00vGUJJ2SALHNUH6IJioXs5grNwqLg+saAit+x96uBCy1rua7a/BJPK2StDxFS5Igjho5Zj4EvYQi7TRx5U2qaBuYOqNRrFX5bfXB/CN5xEBnrCs1JSt3GMe8fNgFn0TTAaTPDFOvpXmJQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257824; c=relaxed/simple;
	bh=kdBYZdaB8/26drJFity98xmPQnxsQqiq068PnVbHqac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9L7gWfI+H8RHnRRcYvnGjc4bCxpVWKOk+NCbeZfsDEEArkMhN7C/Gua19hJEgilsz1jyFC2ZEfmqT/KXUMXTfS9a6usdjQ9oyxmaxETqMas4Hz7LflRrXZqgQQafqnyGU/MyhXDfalXAglIxNp9T35qLL1vaEYfP4uA2UDEJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Csr7oSS6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257823; x=1772793823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdBYZdaB8/26drJFity98xmPQnxsQqiq068PnVbHqac=;
  b=Csr7oSS6oOxC/MiHXrUTCJnCaULW5+pAM2P8rGJW7SWKlvB8hoxX8B/d
   okgYexRz+6nMYV5AzgMSfV5WkdQrWWwifQ1DEXZWgrNKaDc2sF8WnqvXz
   KQ14yq0ajGIQYPqOEUoQnpx5pp3bmIJWh6DTILB9lnsEZeMveQ/RvOVCM
   AnOENZNC8qkwgg47hRIj2pTGcMI/VS3PAmPmZyvCL8ptrDjkKG4O3TVSW
   sQi2arVUYany16zTGsUgS5EPdXgjGcwJIp+qmLs9dUcujT5KxMt6nGyhQ
   6quowOeqQ4Jwo5yR0vnAUeOa/d8JOndm6fnmGPXL6eRF4s9E7yhpAgnIk
   g==;
X-CSE-ConnectionGUID: WVAu1qyzTYClOd9ANoYrMA==
X-CSE-MsgGUID: YyoOjTVrRia0CnCSQc7FCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844474"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844474"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:43 -0800
X-CSE-ConnectionGUID: O5XfNfd+QfeA2NjLaOZ4LA==
X-CSE-MsgGUID: mFKBJ1pURBGUOu4xCrSN8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797716"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 03/15] wifi: mac80211: mlme: support extended MLD capa/ops in assoc
Date: Thu,  6 Mar 2025 12:43:14 +0200
Message-Id: <20250306124057.83a8f80bf509.I623f59023b47ec202fc0c7520f2b5f575b439927@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Support passing the value from userspace on to the AP in the
association and ML link reconfiguration requests. We may need
to also add a driver value to or in with the field, but for
now have no feature that is controlled by the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5f92619f8584..a36563a07b3b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -462,6 +462,8 @@ struct ieee80211_mgd_assoc_data {
 
 	unsigned int assoc_link_id;
 
+	__le16 ext_mld_capa_ops;
+
 	u8 fils_nonces[2 * FILS_NONCE_LEN];
 	u8 fils_kek[FILS_MAX_KEK_LEN];
 	size_t fils_kek_len;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 613959f19713..87ebeec2877d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1943,6 +1943,21 @@ ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 	}
 	skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
 
+	/* Many APs have broken parsing of the extended MLD capa/ops field,
+	 * dropping (re-)association request frames or replying with association
+	 * response with a failure status if it's present. Without a clear
+	 * indication as to whether the AP supports parsing this field or not do
+	 * not include it in the common information unless strict mode is set.
+	 */
+	if (ieee80211_hw_check(&local->hw, STRICT) &&
+	    assoc_data->ext_mld_capa_ops) {
+		ml_elem->control |=
+			cpu_to_le16(IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP);
+		common->len += 2;
+		skb_put_data(skb, &assoc_data->ext_mld_capa_ops,
+			     sizeof(assoc_data->ext_mld_capa_ops));
+	}
+
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		u16 link_present_elems[PRESENT_ELEMS_MAX] = {};
 		const u8 *extra_elems;
@@ -2112,6 +2127,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		/* max common info field in basic multi-link element */
 		size += sizeof(struct ieee80211_mle_basic_common_info) +
 			2 + /* capa & op */
+			2 + /* ext capa & op */
 			2; /* EML capa */
 
 		/*
@@ -9366,6 +9382,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(assoc_data->ap_addr, cbss->bssid, ETH_ALEN);
 
+	assoc_data->ext_mld_capa_ops = cpu_to_le16(req->ext_mld_capa_ops);
+
 	if (ifmgd->associated) {
 		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
@@ -10136,7 +10154,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 static struct sk_buff *
 ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_mgd_assoc_data *add_links_data,
-			      u16 removed_links)
+			      u16 removed_links, __le16 ext_mld_capa_ops)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
@@ -10185,6 +10203,9 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 			var_common_size += 2;
 	}
 
+	if (ext_mld_capa_ops)
+		var_common_size += 2;
+
 	/* Add the common information length */
 	size += common_size + var_common_size;
 
@@ -10269,6 +10290,12 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 		skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
 	}
 
+	if (ext_mld_capa_ops) {
+		ml_elem->control |=
+			cpu_to_le16(IEEE80211_MLC_RECONF_PRES_EXT_MLD_CAPA_OP);
+		skb_put_data(skb, &ext_mld_capa_ops, sizeof(ext_mld_capa_ops));
+	}
+
 	if (sdata->u.mgd.flags & IEEE80211_STA_ENABLE_RRM)
 		capab |= WLAN_CAPABILITY_RADIO_MEASURE;
 
@@ -10535,7 +10562,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 * is expected to send the ML reconfiguration response frame on the link
 	 * on which the request was received.
 	 */
-	skb = ieee80211_build_ml_reconf_req(sdata, data, req->rem_links);
+	skb = ieee80211_build_ml_reconf_req(sdata, data, req->rem_links,
+					    cpu_to_le16(req->ext_mld_capa_ops));
 	if (!skb) {
 		err = -ENOMEM;
 		goto err_free;
-- 
2.34.1


