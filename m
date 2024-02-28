Return-Path: <linux-wireless+bounces-4139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B486AA4C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56651F2900F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC082E635;
	Wed, 28 Feb 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XFNnHfya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCD2D05C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109737; cv=none; b=UCntBLcZxPjy2ctCdStn/mbQ3EWe1HJia/pz2TygMsOFbHX8CbooSy56ogsWXElfEIDYEU6C1PfmUlBHXFIDuEmtu3fKatzp71ncBiIwH09QmYJDcHj7KOhKk+Cc1jcUFGF4HZqv4ExkUGJrAnab08viGw6CUBsXkV9zAAacbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109737; c=relaxed/simple;
	bh=2G7v+oZXnVJFV2uy5ZCe55Ed6V8KZVT5zGP5ebwBHWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWRLZg8oUiXcxZ/Oc2yz1aAw+6d/axeDftJk16NlX/sP7uaPAjtgg8ocuiQy072zZXP7a0UgQJ/AGTleHmZqlkcH7MKf9jxJydb7+TRZXp3ErldOzXGJ85YeBl044JmoHwuziyQGFvbpVFMiwXvl9pgmiCanwN0kI3E+b08XsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XFNnHfya; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=16Wy14CQl1zGS4nR/ZVid8dfGZJq3z75j/st9ORbILc=;
	t=1709109735; x=1710319335; b=XFNnHfyatRX5s1QnZPx+AJhmFuQ9thODd9OmWhfn1pX279f
	a2uNkT4+IULAc6jhztMhKe+jQmhm0hf+/THzUOB+ppxn9iNVcZN4Ri1rpOXcIqphpgHlxFZ3qwv8X
	gS2xP4Gv7XHU0UGYp6+WGChKr5DNudaOrcd71f3A1amhRlkLLUVwBmY99nVWQEeqOBRZ9lqvCWpP2
	NmYMrJLztSCpHzfgmEF6zQCTfO3lfs3QFZBj6XaWXWPeib9TSNiCceNsH71079Iy0/jF8Y2oT/M+y
	QmgcW76Ua4wP8YcbQtGwh/OW4xh9USs3RygvYNK2IaLFwJcuW8H1GJdLYntxECSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFVz-0000000BzmR-3jqq;
	Wed, 28 Feb 2024 09:42:12 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: obtain AP HT/VHT data for assoc request
Date: Wed, 28 Feb 2024 09:40:52 +0100
Message-ID: <20240228094207.7dc812c2060a.Ibd591f9c214b4e166cf7171db3cf63bda8e3c9fd@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084207.18142-4-johannes@sipsolutions.net>
References: <20240228084207.18142-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the association request, we make some parameters depend on the
AP's HT/VHT information. This was broken by my code because it no
longer filled that information, making it all zero.

For HT that meant we wouldn't reduce our capabilities to 20 MHz if
needed, and for VHT we lost beamforming capabilities.

Fix this. It seems like it may even have been broken for all but
the assoc link before.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 73 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fa0d679b78f4..d5678a817771 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8049,6 +8049,67 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
+static int
+ieee80211_mgd_get_ap_ht_vht_capa(struct ieee80211_sub_if_data *sdata,
+				 struct ieee80211_mgd_assoc_data *assoc_data,
+				 int link_id)
+{
+	struct cfg80211_bss *cbss = assoc_data->link[link_id].bss;
+	enum nl80211_band band = cbss->channel->band;
+	struct ieee80211_supported_band *sband;
+	const struct element *elem;
+	int err;
+
+	/* neither HT nor VHT elements used on 6 GHz */
+	if (band == NL80211_BAND_6GHZ)
+		return 0;
+
+	if (assoc_data->link[link_id].conn.mode < IEEE80211_CONN_MODE_HT)
+		return 0;
+
+	rcu_read_lock();
+	elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_OPERATION);
+	if (!elem || elem->datalen < sizeof(struct ieee80211_ht_operation)) {
+		mlme_link_id_dbg(sdata, link_id, "no HT operation on BSS %pM\n",
+				 cbss->bssid);
+		err = -EINVAL;
+		goto out_rcu;
+	}
+	assoc_data->link[link_id].ap_ht_param =
+		((struct ieee80211_ht_operation *)(elem->data))->ht_param;
+	rcu_read_unlock();
+
+	if (assoc_data->link[link_id].conn.mode < IEEE80211_CONN_MODE_VHT)
+		return 0;
+
+	/* some drivers want to support VHT on 2.4 GHz even */
+	sband = sdata->local->hw.wiphy->bands[band];
+	if (!sband->vht_cap.vht_supported)
+		return 0;
+
+	rcu_read_lock();
+	elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
+	/* but even then accept it not being present on the AP */
+	if (!elem && band == NL80211_BAND_2GHZ) {
+		err = 0;
+		goto out_rcu;
+	}
+	if (!elem || elem->datalen < sizeof(struct ieee80211_vht_cap)) {
+		mlme_link_id_dbg(sdata, link_id, "no VHT capa on BSS %pM\n",
+				 cbss->bssid);
+		err = -EINVAL;
+		goto out_rcu;
+	}
+	memcpy(&assoc_data->link[link_id].ap_vht_cap, elem->data,
+	       sizeof(struct ieee80211_vht_cap));
+	rcu_read_unlock();
+
+	return 0;
+out_rcu:
+	rcu_read_unlock();
+	return err;
+}
+
 int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_assoc_request *req)
 {
@@ -8193,6 +8254,14 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 				req->links[i].error = err;
 				goto err_free;
 			}
+
+			err = ieee80211_mgd_get_ap_ht_vht_capa(sdata,
+							       assoc_data, i);
+			if (err) {
+				err = -EINVAL;
+				req->links[i].error = err;
+				goto err_free;
+			}
 		}
 
 		assoc_data->wmm = true;
@@ -8228,6 +8297,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 						       &assoc_data->link[0].conn);
 
 		uapsd_supported = bss->uapsd_supported;
+
+		err = ieee80211_mgd_get_ap_ht_vht_capa(sdata, assoc_data, 0);
+		if (err)
+			goto err_free;
 	}
 
 	assoc_data->spp_amsdu = req->flags & ASSOC_REQ_SPP_AMSDU;
-- 
2.43.2


