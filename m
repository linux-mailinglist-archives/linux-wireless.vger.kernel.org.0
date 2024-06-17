Return-Path: <linux-wireless+bounces-9115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 482F590B184
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30C31F26313
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9E1BF31F;
	Mon, 17 Jun 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG7RotVJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A21BF318;
	Mon, 17 Jun 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630884; cv=none; b=r3dQjzpJN8NXUxPXNYyddegfYuxRta2sTxGqkjZq1y1TA9DWlbfdcKaTsyUuJ9A/eugu6EU/QY2B2m6Ah04Gtc+VPwM4Hs6EGYSYSEM+BdbkRn3AvBmQ399S1/A2djj7IuOhCOD4+85T+pMuorVlLuSUUuP3WBim4euC85857JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630884; c=relaxed/simple;
	bh=OTSUrzPahfesJZjU7ENFWagfb5ufLIfZZtTBExb1V3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIKXEL7RcE1e9ln2eBQhgshdE72yELcNlYUHsfd0BNNzGOz2qpRAZD1VawIpjUugI9WLnbVoX+sNY3ps4umEZCjRmsiarediEqUjrF2+hVqCNnfpY4yqd/ExMUJQ9yMDEnDLxOo/w0zs3fMWSV2ZcNq4e0QHsKMACYf1JiRhScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG7RotVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C189C4AF48;
	Mon, 17 Jun 2024 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630884;
	bh=OTSUrzPahfesJZjU7ENFWagfb5ufLIfZZtTBExb1V3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DG7RotVJr/ZZjSmtHAEMvHvTA29sUvnkbLNewVpPdseknRxWIjCByrB7cMIiJNWFH
	 IaCpfTM1Wjy/y3vEa3T/6MQwSwW0D/L7OyWOOVJ6WXll2zs+oJLIsldn215aEIw+YR
	 spf0mmSCKxACSSz8MSxe0NTYc3lmycLQsLvR/7O5a2PwBj0wSPICLDjmTMQozRlvcE
	 oUgELg9URsQsfPeLAPyNh6ZtfqGgTUSq+asUI6vCyobgJSwK6fPMwqsFL/ucOwBwH+
	 ARH8FvA8yAD+8T70oDZz5hugwfwc7SlTPUXjDfVkgyqvHHRMafNNHJTCrJ3wl//oEJ
	 oxhvLpa/l6t2Q==
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
Subject: [PATCH AUTOSEL 4.19 4/9] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Mon, 17 Jun 2024 09:27:49 -0400
Message-ID: <20240617132757.2590643-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132757.2590643-1-sashal@kernel.org>
References: <20240617132757.2590643-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
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
index 3162f955f3ae2..c9a5271d9b59d 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1454,6 +1454,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


