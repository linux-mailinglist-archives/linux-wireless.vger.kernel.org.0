Return-Path: <linux-wireless+bounces-22503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FDAAA28C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735437B0F77
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E172DCB44;
	Mon,  5 May 2025 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAFj5CXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442BC2DC13E;
	Mon,  5 May 2025 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483707; cv=none; b=s9cFUWJRswqbk8J+/et8lyvq7sjRL8O1hlckjYlNJuIIrnPs7QQ7BzV4YkkdA5lLt1Xruq0PEiw1uFEswSR3BfplIBgik7Dy1iYXFbBLwrM1rkY0EuynyYUfn8IHLs5y7AAhvHCQDy6UsA9vIMrZKcK0CGiVG0tjm7UKr6b0g1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483707; c=relaxed/simple;
	bh=TjQJNUhlxHAiNcxQ+2c7MKvA7EJc9b4i9GaT+2WGCNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DjK3fYFO4Xj26gDDfHLDPi5gaiW/ZUcYMbP16tTNm3eoOCANE/1tlfpopNPPlDk3Lcw2w+TAZOQpTqxUqdzou2ovApbhDLBwJLAwjvswAG25KE+BS0etwCIBicTeV6HwS6yw0ORANUnGkr2go2KSoGiTxfIndqfFk90Bi3PeJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAFj5CXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD2EC4CEED;
	Mon,  5 May 2025 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483706;
	bh=TjQJNUhlxHAiNcxQ+2c7MKvA7EJc9b4i9GaT+2WGCNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAFj5CXHpXqhDaOA+Uk3BDKW7dMLaLT7VckRwVBKo8OOJCwDxCiilr4qdUa3AMd0P
	 73eIjvQkeMAgmbEacx4MEWXY9ieTYMEq08JKfIfAzsmIO+5wqw9ULDC0PoBmyBRttl
	 LBFQUPbwO3s/BLclsjQpKFO4e/iKOgeCxw7jfH9kRnjGMWzDbcL5KtoKuVW70rbaqq
	 0hR8n3blatFmHKgpqM5qxIBG6h4HMPnpKBnnVFtX/sWqYfMWg4SNgtkpVCfyQuAm0v
	 VtQ3x+7ysfC5d+thQYGszBbSBVb+LHm3cslPAs3/lxu/et2SPwj+o968/HfL0gMCfi
	 siKy9kgG4wuaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 189/642] wifi: mac80211_hwsim: Fix MLD address translation
Date: Mon,  5 May 2025 18:06:45 -0400
Message-Id: <20250505221419.2672473-189-sashal@kernel.org>
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

[ Upstream commit 65bff0be9b154621b617fc2e4bd89f1e18e97cdb ]

Do address translations only between shared links. It is
possible that while an non-AP MLD station and an AP MLD
station have shared links, the frame is intended to be sent
on a link which is not shared (for example when sending a
probe response).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.1aa461270bb6.Ic21592e1b1634653f02b80628cb2152f6e9de367@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331d40427..a68530344d205 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 /*
@@ -1983,11 +1983,13 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			return;
 		}
 
-		if (sta && sta->mlo) {
-			if (WARN_ON(!link_sta)) {
-				ieee80211_free_txskb(hw, skb);
-				return;
-			}
+		/* Do address translations only between shared links. It is
+		 * possible that while an non-AP MLD station and an AP MLD
+		 * station have shared links, the frame is intended to be sent
+		 * on a link which is not shared (for example when sending a
+		 * probe response).
+		 */
+		if (sta && sta->mlo && link_sta) {
 			/* address translation to link addresses on TX */
 			ether_addr_copy(hdr->addr1, link_sta->addr);
 			ether_addr_copy(hdr->addr2, bss_conf->addr);
-- 
2.39.5


