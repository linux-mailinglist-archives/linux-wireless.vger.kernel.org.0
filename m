Return-Path: <linux-wireless+bounces-22500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB4AAA277
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01019165450
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217C52DBB1F;
	Mon,  5 May 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxOi47tE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0952DBB1D;
	Mon,  5 May 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483703; cv=none; b=Uaq9++mVFkCIemVtIKYaW4EEx7C2DNHRBqfS7EdUcd2LNl7PkqW+i7bxceOv4FAStYVbIZ2XMZB+eVKsqKEvAiPPuWH88JzwU+rCztLDBU4aaNz1k26rnc8ZOoK3Xy5VEpFiwWwQnbzEvVUKORza9+xwCXiilEJOsT0x/ip9Lc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483703; c=relaxed/simple;
	bh=DszLJD2tK6D797WA0V4+NQ0Ml7GX1K1pXq+Wt9fHwzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txQPl1NVbPnja8uY+YbjjBg8+l4RBB4UpFQJ8t5GImsUzgua8lhnRIpK70Bin0xI8/uDIhVoaGTPXaBSrKS9oY8aTfcFTHIgsi8Lxsy9nt7QEWszoVZu1fJg4vwjAahoM1+8au9giVZQprHoVzg6NqHNOhC2e5R6mpko1gtDw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxOi47tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA186C4CEE4;
	Mon,  5 May 2025 22:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483702;
	bh=DszLJD2tK6D797WA0V4+NQ0Ml7GX1K1pXq+Wt9fHwzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxOi47tE3rOYcq/YiOTuZKj7k0JPiGIvInUOM5lZrT91kdZ0pEo6cRRCe2GhpZ/UG
	 bPvw30cogECTjnEVih4b3yNOxhMgULwjhJsiYobeufNYMow7rs4SoJGKsAfU6q5QMA
	 qzofzS+EFHMMoajeKNaxwGQeueZ/3sGK1ip2diHbMvxLqy5RXQhNOSBI5ZgtyX/Bv8
	 YMBJJoCPRrkG+NXnZCppYBFGi3/Fqt5z5dasDWsnUZDOkm8S/3TWFuX6h9IVVjegzR
	 Y2sP2E1wYbUpysnVzFogCpzIuP+GFTl1VpuvnthLF6SgtehW4DhSimrARX5zh6M9FZ
	 VVXlKmRXoQO4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 186/642] wifi: mac80211: don't include MLE in ML reconf per-STA profile
Date: Mon,  5 May 2025 18:06:42 -0400
Message-Id: <20250505221419.2672473-186-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c3171bed65ec323803b6b73f74017f7d0fd7aa6c ]

In the multi-link reconfiguration frame, the per-STA profile for
added links shouldn't include the multi-link element. Set the
association ID to an invalid value, so it doesn't erroneously
match the link ID if that happens to be zero.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308225541.8e5be244c70f.I3472cd5c347814ee3600869a88488997bcd43224@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7dc3f0cfc9a9..8f5f7797f0b6b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -462,7 +462,7 @@ struct ieee80211_mgd_assoc_data {
 	bool s1g;
 	bool spp_amsdu;
 
-	unsigned int assoc_link_id;
+	s8 assoc_link_id;
 
 	u8 fils_nonces[2 * FILS_NONCE_LEN];
 	u8 fils_kek[FILS_MAX_KEK_LEN];
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 99e9b03d7fe19..ca8f682a8db73 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10156,6 +10156,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 		if (!data)
 			return -ENOMEM;
 
+		data->assoc_link_id = -1;
+
 		uapsd_supported = true;
 		ieee80211_ml_reconf_selectors(userspace_selectors);
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
-- 
2.39.5


