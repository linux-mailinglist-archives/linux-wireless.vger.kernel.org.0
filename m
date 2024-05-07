Return-Path: <linux-wireless+bounces-7307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C78BF0BE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA88B25194
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BD137743;
	Tue,  7 May 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsU0hEr9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47D136E3A;
	Tue,  7 May 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122835; cv=none; b=WjoD5m3HxFRkETMLA+5jJzPvuyoSI8jJQ8Tc9UmufpV6l51JTQJCEYqm4N3A4CK5REIKFFRSlojlSZ/o7HbpbU2PrZdjbZz2OOd5VA94aGcS5TLBp3j8xpHffZicplMAxNMF3eWM8O7YNzvTv7IQ+GRQOXZznu1XqOKP9XbrljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122835; c=relaxed/simple;
	bh=P2pPIS+RD1X1DNu+n4HDuyJDMESoKQ7izjR9tS2Mj+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHfIw0D7bYBSighcuh9hE5L6fG3Q56oV0Fo31AStjCG/xxAdcF/0Nr1Aaov+oLbuCyQZBlwFSRZC18sdwiW0uoydIkv51ED8Ikfan0dSlb8rPZNkyHc4bDkPfl59VM3udb5jL1SZDEVnNeneYJg1EKNWzlIwvPoAgLY3ptdd32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsU0hEr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E68DC3277B;
	Tue,  7 May 2024 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122835;
	bh=P2pPIS+RD1X1DNu+n4HDuyJDMESoKQ7izjR9tS2Mj+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsU0hEr9d1Ffps5flLUMVxnR59zTbv/DPAIHpC6jDmeU+wwA1g++ZC7EzslzGX7nD
	 TujExz+Vn7E32jaLkeDIrr/M1JzhSr0+7wmC2yK1kmLw82VZX51hCgKPw4slCApH+N
	 OMQC+RSmxsiG4rxV4Zg0dP5NPFJizG3IPa9CBd3C3nP32MtlBy46yV8M3gqujEmX3T
	 4BZp+W3FiqySj79YjN/29cL28R/Gy/5eOLrullJDVjYzNDS+SdaD679/OyW4kyGixj
	 k439Y5eLDp7CCKJc1spXFWZtdR+RGJn/Rhvc/a5FlV9g2cVRa0nL8Ip3CM5+Sedi6I
	 5zc5Lfxnv2diA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Kinder <richard.kinder@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/12] wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field
Date: Tue,  7 May 2024 19:00:04 -0400
Message-ID: <20240507230031.391436-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Richard Kinder <richard.kinder@gmail.com>

[ Upstream commit d12b9779cc9ba29d65fbfc728eb8a037871dd331 ]

Logic inside ieee80211_rx_mgmt_beacon accesses the
mgmt->u.beacon.timestamp field without first checking whether the beacon
received is non-S1G format.

Fix the problem by checking the beacon is non-S1G format to avoid access
of the mgmt->u.beacon.timestamp field.

Signed-off-by: Richard Kinder <richard.kinder@gmail.com>
Link: https://msgid.link/20240328005725.85355-1-richard.kinder@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f25dc6931a5b1..9a5530ca2f6b2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5528,7 +5528,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 			link->u.mgd.dtim_period = elems->dtim_period;
 		link->u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
-		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
+		    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
 			link->conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
 			link->conf->sync_device_ts =
-- 
2.43.0


