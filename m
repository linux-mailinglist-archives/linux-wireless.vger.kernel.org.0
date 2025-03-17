Return-Path: <linux-wireless+bounces-20451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC97A6586E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384FD3B6CA9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500911B4242;
	Mon, 17 Mar 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPxJpFNI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246581B4232;
	Mon, 17 Mar 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229462; cv=none; b=HZ0EZH1/V5YWVsXyfAVf2EPsgqVTP25gdTi/cGQgp68wl8Mty4Yl0AkHun+1zoW8ZBpq62oMXP4B0q9b/QIwIUp+VqCXYgQGJExgDP4k1vuJupIZDaWR1zoPopCzp1oNVzVwUZ3tNTk+lxcJYuV2a7QIGjEPImG+c3Wavgm+PpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229462; c=relaxed/simple;
	bh=BO/df52qQyIkVvB40Zd0Td+wo/KKLPGVrY2SdRmVtDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcAn7HxmBr7FEJqxcODfnV6xF/7sRTrpzCjzM9oGfOlkMvu0fCUwKt+/VgcK5Luxq0P9yYeAfIjYCmcUR5cQYHaaHIpsNMvyKqA71Iz3L6C3AGouwc85Efw6+6axjRcrQn47avphsHWQecja3okqiQfrEsg5ii3njzbi6xISkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPxJpFNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AABCC4CEEF;
	Mon, 17 Mar 2025 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229459;
	bh=BO/df52qQyIkVvB40Zd0Td+wo/KKLPGVrY2SdRmVtDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPxJpFNIfOXKP08WAG9KI20khsSe79CnN+c5BnL4skqflhd71m2/zU5rgTc/dikUW
	 9Te81eaJrV7u2hsmU7XO+CWu6XmXgEuFAefrrTQiaiuNRvDl281Oin/h044weY/6K8
	 Qu1cZIawiPIMQfrw6bCvGW6nz1MH2+RNSG/HKkFsEoKMGW7/rg/9YRFJPkhj4NB05J
	 H2Um+vk2ErVlYjXyWnQD0o1jdsgAia/yccd45jw/na3Qqa3ZbXavDezvEUWBFe9C/r
	 4iQ8Ot+ihuLxHvZuGZSMiYnmYmsmaGkVQf85NkDy9Dg1m66bPoB+klDhp/Fc+U9Dh+
	 Lc9Pi4Hwie1Ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 06/16] wifi: mac80211: fix SA Query processing in MLO
Date: Mon, 17 Mar 2025 12:37:15 -0400
Message-Id: <20250317163725.1892824-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 9a267ce4a3fca93a34a8881046f97bcf472228c8 ]

When MLO is used and SA Query processing isn't done by
userspace (e.g. wpa_supplicant w/o CONFIG_OCV), then
the mac80211 code kicks in but uses the wrong addresses.
Fix them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250306123626.bab48bb49061.I9391b22f1360d20ac8c4e92604de23f27696ba8f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c4a28ccbd0647..a42959b39bd01 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -3330,8 +3330,8 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	if (!ether_addr_equal(mgmt->sa, sdata->deflink.u.mgd.bssid) ||
-	    !ether_addr_equal(mgmt->bssid, sdata->deflink.u.mgd.bssid)) {
+	if (!ether_addr_equal(mgmt->sa, sdata->vif.cfg.ap_addr) ||
+	    !ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)) {
 		/* Not from the current AP or not associated yet. */
 		return;
 	}
@@ -3347,9 +3347,9 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 	resp = skb_put_zero(skb, 24);
-	memcpy(resp->da, mgmt->sa, ETH_ALEN);
+	memcpy(resp->da, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	memcpy(resp->sa, sdata->vif.addr, ETH_ALEN);
-	memcpy(resp->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+	memcpy(resp->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	resp->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
 	skb_put(skb, 1 + sizeof(resp->u.action.u.sa_query));
-- 
2.39.5


