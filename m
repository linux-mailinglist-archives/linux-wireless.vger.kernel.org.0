Return-Path: <linux-wireless+bounces-22501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B841AAA27C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159A816A5AE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4E2DC104;
	Mon,  5 May 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD02J3mQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D392DBB3F;
	Mon,  5 May 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483704; cv=none; b=MIqHNit1Yi+sCcPb7q7lLEMlwpaFMMSTWzeC2NcV4GaN8uJSFSV3TTwNfUEhBkhPIQEnCqVSFJ7VuILyva9Z5sZRQRoZESX6Aunk5NtcOKDBPStvnOQem0FF8g4e7E7cl+77KdvYHiBnwMHdDfL4kWTsH3az0W0K6mPxDDMwM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483704; c=relaxed/simple;
	bh=/6RXcikTGlExsZKixuMesNRG4VyS8GaM3pLFSNIGd3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2ZCdiAfZVs2VM8N4Jop2uwZIWfHIZlbN4KDdICg7wJmA5WVsZ+C6Si5fskImI2Ef7GobW5x6FrMW/5ykXmBtovLs+PqR2pMn8qI+sfCfESTfdEi0mqsrGBh9AtN9oDex+w4z0/YoZOZyUjc9KxHQofdhxRa6cD6E06JGzNMiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD02J3mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E8C4CEED;
	Mon,  5 May 2025 22:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483704;
	bh=/6RXcikTGlExsZKixuMesNRG4VyS8GaM3pLFSNIGd3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kD02J3mQFhOnoyS/L//suaMEFubCRAuAMuO/KK6SSxyvNwUq58378Fxk8Vi5AeWSy
	 t5/Z78Puee9VlenOBW7xkG+nHpCpfoKYkkf4wjeXQ3Far666jCtuSWheFCbTu6lZzj
	 xNilpKGv2xgpxo5PQzC+TlSxSUGNd5VWVjQWjg4scShA5172wboDl+mHg2TBxP3Az6
	 eHgr8uVZDBhDg5yOH2I5h1+mFQ19uq4k/w6mh7u9WXw9M0eQ3XAbSEyr4O3Nj4EQVR
	 OS4U6ERfzJMRvs6Nwr45nW87y7fHvqS9cPLnpyGlKTheKUDObO1fnVYsN2kKX1qCON
	 aaQZPyagugYnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 187/642] wifi: cfg80211: Update the link address when a link is added
Date: Mon,  5 May 2025 18:06:43 -0400
Message-Id: <20250505221419.2672473-187-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit e16caea70610ed4226034dfcdaa5c43b36ff9e0a ]

When links are added, update the wireless device link addresses based
on the information provided by the driver.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.d694a9125aba.I79b010ea9aab47893e4f22c266362fde30b7f9ac@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 1 +
 net/wireless/mlme.c    | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 363d7dd2255aa..c168b0e89b79d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9750,6 +9750,7 @@ struct cfg80211_mlo_reconf_done_data {
 	u16 added_links;
 	struct {
 		struct cfg80211_bss *bss;
+		u8 *addr;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e10f2b3b4b7f6..c1b71179601db 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1361,6 +1361,10 @@ void cfg80211_mlo_reconf_add_done(struct net_device *dev,
 		if (data->added_links & BIT(link_id)) {
 			wdev->links[link_id].client.current_bss =
 				bss_from_pub(bss);
+
+			memcpy(wdev->links[link_id].addr,
+			       data->links[link_id].addr,
+			       ETH_ALEN);
 		} else {
 			cfg80211_unhold_bss(bss_from_pub(bss));
 			cfg80211_put_bss(wiphy, bss);
-- 
2.39.5


