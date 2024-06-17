Return-Path: <linux-wireless+bounces-9105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D93390B0E2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3256B1C219AA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2618EFF7;
	Mon, 17 Jun 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl62hy/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9B18EFF1;
	Mon, 17 Jun 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630792; cv=none; b=HIvW6stWRab0mzhQr4gNiw5pNlyiaHQwQclVovFKHMVtNHqa6YK2v1KBEtMOIUY/WrC+1XtA0/WR0C593b52SjeRWh4gTLgxkVFBPwD01Q87mWPoP2ASens/OTpfj2ECbQl8eFyCaAwU9Ho3QAKwbqU9AEcz/lWU5qLOSlkCP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630792; c=relaxed/simple;
	bh=gXP+HGtKZBJTAK+ZamdQmVHy9NzhVXSFas4iEwLoRqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD2N4VxcftAuvLXbRgEDfWEJveyiSoYYvrY5vlBub/+Et61QsvLH806YcFEVYXTvqc7dcuvfvv82MyI8wlbsrZtobg2z3nizbEiPY7bE6Cg8ICJxWb+8uJZpmujQbecNViGD435G7yK8QEIAQEmzh3QaM5nKU4DbDfgV0Ltqe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl62hy/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40583C4AF1C;
	Mon, 17 Jun 2024 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630791;
	bh=gXP+HGtKZBJTAK+ZamdQmVHy9NzhVXSFas4iEwLoRqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nl62hy/epbvobo2qWCmn25LL5gyMdxSizr7zIJ3xauIHLKa5fv1le9xKiQxJ1YxpL
	 vByaTeXyF7TUlsDpJzhMIOVhoHnMFGzEDM4OSvAA0Dp4KrK9nx5RhbEFjPMZtGwYfx
	 HR2U65FHPKH5fR+qkZFYotJNnoL8svG2Zj0feMtmsck8FQMlVaCHDKSTsSJFDUQgJS
	 7j117WEpPh+4okAEExCzIBg/TUIdZRhjduwlkD0+YyFC8trWv1pCPq/hsVGEebzPu8
	 t/ac6fIKM8ZEYVLTQxXYmjYgResfJ2bsmPuKTId8ANTxtfe3xZLVu5oM20CQtT6ogL
	 R0qT5FMpD5fOw==
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
Subject: [PATCH AUTOSEL 5.15 08/21] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Mon, 17 Jun 2024 09:25:45 -0400
Message-ID: <20240617132617.2589631-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 6847fdf934392..6202157f467b1 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1628,6 +1628,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


