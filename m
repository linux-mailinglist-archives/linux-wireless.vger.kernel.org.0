Return-Path: <linux-wireless+bounces-9111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9D90B129
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4868288CFC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8284319F49A;
	Mon, 17 Jun 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksbXGOHZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265319F494;
	Mon, 17 Jun 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630837; cv=none; b=YT9l1P4CQq1NrDorcL7e01JnlBVCm/Z2aASA0DxNavVwPSevz3pE9WibIajpWl0ha094TlCAUmBdL597tP4TTFOusCiRtQprxdQfCDynpG4GE90T1O88jL92BDReM/DF7jc0AU0eCpGMKDR3oT/fIewURkS0C7u9e3eVD1dFQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630837; c=relaxed/simple;
	bh=ojaUoTqc9rW0ZKJS7yZY+c8GzWgSEwuKxehfDpPp2pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvatE6ZPebxH4+wrMGSRnJNRZU+DJY/kCy9dEoDn/n83vTwTWNNtx7xwH7Lh8vbTcmX9StvUfbWWZd+KvG4DOFWapbOrhPDng4QMn30Qf3ewc2G2Q+0ua4Jd9MFpEGjZCTc81tuOj8hkXRnzO5HnrlBSRTSQjXeNbAQp0Lsz7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksbXGOHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62D3C4AF1D;
	Mon, 17 Jun 2024 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630837;
	bh=ojaUoTqc9rW0ZKJS7yZY+c8GzWgSEwuKxehfDpPp2pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksbXGOHZ6WyDKFyDLL9I5Z/G/HYqSu6f58gv47+pKiYHsQ+G7Tnhb6yOFswJKIlO7
	 z87ZZ0fhVQCa8Pz/v9cH+vcIZ79AxGRLRQbooCOLuVgGuUdVXvYAvqleRPqF3DK9FC
	 CrdJORTk4CAc8T6xotS8rvNjfveM7j35JNgicIhbRUIHOpgLCE697HjLC1Z/CIsza8
	 E81vbtC6jjTVKjJEYxxl43CZdAf4rcorR3xlX/UriZwK5MsRTfP9ywSZT54qn7OBrr
	 IPR0Y+QtQXHVeETw26IGpH8oT5gFmC1y9S1cXtQ7m3z0QUc+pduymEueUu5xGfpAzr
	 u8QA7gRioBpCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Escande <nico.escande@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/13] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Mon, 17 Jun 2024 09:26:53 -0400
Message-ID: <20240617132710.2590101-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
Content-Transfer-Encoding: 8bit

From: Nicolas Escande <nico.escande@gmail.com>

[ Upstream commit 6f6291f09a322c1c1578badac8072d049363f4e6 ]

With a ath9k device I can see that:
	iw phy phy0 interface add mesh0 type mp
	ip link set mesh0 up
	iw dev mesh0 scan

Will start a scan with the Power Management bit set in the Frame Control Field.
This is because we set this bit depending on the nonpeer_pm variable of the mesh
iface sdata and when there are no active links on the interface it remains to
NL80211_MESH_POWER_UNKNOWN.

As soon as links starts to be established, it wil switch to
NL80211_MESH_POWER_ACTIVE as it is the value set by befault on the per sta
nonpeer_pm field.
As we want no power save by default, (as expressed with the per sta ini values),
lets init it to the expected default value of NL80211_MESH_POWER_ACTIVE.

Also please note that we cannot change the default value from userspace prior to
establishing a link as using NL80211_CMD_SET_MESH_CONFIG will not work before
NL80211_CMD_JOIN_MESH has been issued. So too late for our initial scan.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Link: https://msgid.link/20240527141759.299411-1-nico.escande@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index ce5825d6f1d1c..d3a9ce1f8e53f 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1584,6 +1584,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


