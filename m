Return-Path: <linux-wireless+bounces-7235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FD8BD533
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC8B1F22652
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE613DDD8;
	Mon,  6 May 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CVjecVzD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB03158DC4
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022642; cv=none; b=RQacjtynD6zY5QDi0cJdDCOsMvQjWmEXr6CYfqVux8Rpt1PUsUag0l8DoX6aGoVMjBbH/uAS2GCfNvB1B5nCJXQ5t6L7TZwbHvB/vjUdD4QLmkC3Sml87WFvc/BvW2nz4Htf8hcg1jx0GpFyQMA3bVpJt5UKjKz/gM2Q0IaAiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022642; c=relaxed/simple;
	bh=/rXrdo3guuU7PaSMKhSAyCkNqtmcZL6SPoVLSwhntkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui4gsiHKxb21SvnA+ucIrBsaFWFHesRXy7LSvupPlHPl9SUVjjVHLgJC38/IL1imUjclIDcBM4reuYXtP4I1iTORNsmBYGiczcY/EW71U0yRitT3eHZLQD4TzqSebP2LzeuE+QKxj5j1qjUtZDcR9ZsCCQaikxf+dZw+vy4DZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CVjecVzD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aNY+0nK6q0pEgSp3NsTAxoeeRRjfxMRo9+I59wMAixI=;
	t=1715022640; x=1716232240; b=CVjecVzDnUuhmIbRqfS1YSjuLHMfpejDm0yZfqSSXcYtJ9c
	ur3o5cSeKonGmrlQyKbSlKCcI24+qx0k3KjhaqsR4PEv553Ly8Wh5qR6MEZbFarOLx+ujLWeswRI/
	xSbgB24JJnLegwiNRPwB0xckqC9JtAshVRH4NgfFk0BUysfzU9uchrITQgXGQ8ICRXxnaDeTg3B8I
	QbJIUDRpzzS1UmLQd6q92U5CcBj7e0snhl3nC+Zh8kTXBZI49MYqk7A53VnmR7uB3doV9TM3sV4EI
	mrZH14ksQ8p5o2XPJMCOoafcnOLMdXDYiJDyAx9147R+i4aBGvtLNO1OpirLjV6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43jR-000000089kh-44Pe;
	Mon, 06 May 2024 21:10:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/3] wifi: mac80211: cancel TTLM teardown work earlier
Date: Mon,  6 May 2024 21:10:34 +0200
Message-ID: <20240506211034.096a10ccebec.I5584a21c27eb9b3e87b9e26380b627114b32ccba@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506211034.ac754794279f.Ib9fbb1dab50c6b67f6de9be09a6c452ce89bbd50@changeid>
References: <20240506211034.ac754794279f.Ib9fbb1dab50c6b67f6de9be09a6c452ce89bbd50@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It shouldn't be possible to run this after disconnecting, so
cancel the work earlier.

Fixes: a17a58ad2ff2 ("wifi: mac80211: add support for tearing down negotiated TTLM")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 49bcd800bdca..9b0598b42d48 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3294,6 +3294,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &sdata->u.mgd.ml_reconf_work);
 
+	wiphy_work_cancel(sdata->local->hw.wiphy,
+			  &ifmgd->teardown_ttlm_work);
+
 	ieee80211_vif_set_links(sdata, 0, 0);
 
 	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
@@ -8709,8 +8712,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->beacon_connection_loss_work);
 	wiphy_work_cancel(sdata->local->hw.wiphy,
 			  &ifmgd->csa_connection_drop_work);
-	wiphy_work_cancel(sdata->local->hw.wiphy,
-			  &ifmgd->teardown_ttlm_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->tdls_peer_del_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
-- 
2.44.0


