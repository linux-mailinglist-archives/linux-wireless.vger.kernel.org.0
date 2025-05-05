Return-Path: <linux-wireless+bounces-22607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9BAAB0A3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357E27AE5BE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F622319A7A;
	Tue,  6 May 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h68Y1rEc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6A298CC7;
	Mon,  5 May 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485075; cv=none; b=MFXVbQOquZF2tVlomjjlMnn3TwIRxusGHKnac4C8L5E/rKM04ao+uhDSf2NT8pzYSIRXhN09UQp8oxtVKOBTEWIAEPGRMqlNFToFL1XPMo9wK97xezsLXFkDp05A//YtXU/hA+ra0OeOt3j+4VQt94W8Yd3p2R0UeNnrdoMNG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485075; c=relaxed/simple;
	bh=uuYJmiuVaYZWxBlp40dGfyJgqpHBTHOU2pQdrpbsmy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1CuKIjiZPHtjsnRKJgxlUufB/vXeEn9Y32zMBzaQpbSmY6XPnrwhIA48qO4S50ET4ZBQFFJloOM9kb9VI9GRYtJu+U/AphYND6O0vbGAGn6tOOQG8qI5XHUw1oczZvtYJROkvylCacfSTL1ik2EOX3jl2CvRjyVsDiDpRqaGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h68Y1rEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95086C4CEEE;
	Mon,  5 May 2025 22:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485074;
	bh=uuYJmiuVaYZWxBlp40dGfyJgqpHBTHOU2pQdrpbsmy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h68Y1rEcb1sqcl59VaD3Z/b0o+R57A7QnGuam7N9f57gUpIExX8UBQJrFCsK5WMWU
	 waorB78YxT9AYZp64d4sVdF1JUoF0dWDLNEtisBaoPiuUek13lFkXvUcSh1qkKDBfj
	 5JGKnv62D7hALvyarZSDhGB5jSRuZlSTFHimsBLve6zZnxVTL7nqL2ZOXeaswAUWxF
	 2/8JUd24dpFn5YRw+oN08tbyTyUnHdVz10cxqwwhpObQ3swV8N5ACDT4ojzPpsdAfS
	 WngQRMy3x0htQB6nflCLOYNBiI6rvXNW+kCdsJr5Dt6dO7fYsutJmxHsqXhH8OxVtp
	 3Cq4GpxqwG35Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 153/486] wifi: mac80211_hwsim: Fix MLD address translation
Date: Mon,  5 May 2025 18:33:49 -0400
Message-Id: <20250505223922.2682012-153-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 3f424f14de4ec..4a2b7c9921bc6 100644
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


