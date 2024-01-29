Return-Path: <linux-wireless+bounces-2695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C68412C8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F371F274B9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344614AAA;
	Mon, 29 Jan 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KuZijSO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069EB4CB28
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554452; cv=none; b=S6Isas8Y0k5EN/z+cAjlbRD0w716q2a5TX49l9+8FFfxXk59+LAWnoQ6NFuus7zX9vXNkIrmFfvNIHZ8V+stiD+FGh7GEBCuXQwJHbwwvQxzynIZwQ8asBTXKAkoB7IJ6mo7EzRNbigSoc2Q7rr+zeOl8SDk6KIsoFyb2f2YlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554452; c=relaxed/simple;
	bh=PVFdaj5VUQh/lAUtTz4P4kLyn/mjINRKxu+X6+evylw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3fN02Ru8vQZec0H5re2xrY5YeZ8prcfY1qXO83CDQYhKpG4jycu+8E28NRBdQ0VFtbzCxbIskPOgyAqDGQ5xPM4THzb2lES4lCTJQdbphcnhSw9qbQnFJPv4Y8D4JDbEGTYreRSPVfiY5MMx8282CwXCFZTsHMlkMK2szcuTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KuZijSO9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=PIPAqo4rCv2Njc94WT+NN6BB0BdBKrBVdyRRZgq83Vw=; t=1706554451; x=1707764051; 
	b=KuZijSO962o+3P55JOTQ9aqc0LiglSQgD4QJnvT6exkYDEMJs0RxAFb66kePyckvQ/sds1sDmmh
	ap4HNimKVpMOG7VmtKDvVW5lsh7B9jgMxX+o8IJ+3YjwungX63fry//o2PwwGSoAU/R1dVrKtBFwt
	ALaX+ZTZ8v4HlZuYv4fvVOubKtt5jVLHukNqgYbpEBWyyLMuA31bwp0aT4yRvqtyMWLjAgvOkHcTO
	MwRz6MvMMBCqLKLV/ARaWzz3OlNQ1b8w8CoSwBuyPPXhK92K1Q+MproMBohiCL7C3tZf/Eygc55Xk
	psM8xAK1/S/Sn8CAEqV5hiHpPACyJlkAfoJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWlj-00000004zhu-1Xu9;
	Mon, 29 Jan 2024 19:54:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: initialize SMPS mode correctly
Date: Mon, 29 Jan 2024 19:54:05 +0100
Message-ID: <20240129195405.d6d74508be18.I0a7303b1ce4d8e5436011951ab624372a445c069@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The SMPS mode is currently re-initialized too late, since
ieee80211_prep_channel() can be called again after we've
already done ieee80211_setup_assoc_link(), in case there's
some override of the channel configuration. Fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c62c7c6ce91f..f1cdd2df323e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -2918,6 +2918,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	/* other links will be destroyed */
 	sdata->deflink.u.mgd.bss = NULL;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 
 	netif_carrier_off(sdata->dev);
 
@@ -5045,9 +5046,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!link)
 		return 0;
 
-	/* will change later if needed */
-	link->smps_mode = IEEE80211_SMPS_OFF;
-
 	/*
 	 * If this fails (possibly due to channel context sharing
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
@@ -7096,6 +7094,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	link->u.mgd.p2p_noa_index = -1;
 	link->u.mgd.conn_flags = 0;
 	link->conf->bssid = link->u.mgd.bssid;
+	link->smps_mode = IEEE80211_SMPS_OFF;
 
 	wiphy_work_init(&link->u.mgd.request_smps_work,
 			ieee80211_request_smps_mgd_work);
-- 
2.43.0


