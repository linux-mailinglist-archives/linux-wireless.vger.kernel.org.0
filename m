Return-Path: <linux-wireless+bounces-9183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B809E90CD47
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473C1282002
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E91ACE7A;
	Tue, 18 Jun 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHUx3fIJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD831ACE76;
	Tue, 18 Jun 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714513; cv=none; b=IKhZ8T26ZpO6xpvWcVRVYtG45e/VQ9PMRofYAj2gZ/iJ/5SkTyMl2CHoal0J3Jlk80lFVpMnk36C3b4V6auxFN/Axq8Wqt7I8jXgeV755c+6jBPOH69sIuIIkbW9bPBjvDx/wh16Ghg9YioPBzyQ3OKBR6Qh/SYRRJftydxGTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714513; c=relaxed/simple;
	bh=gXP+HGtKZBJTAK+ZamdQmVHy9NzhVXSFas4iEwLoRqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li1Nflk4vDSBqkgtFV9jLvdVNrAv/TVU79hgo/UXxfLOELdNX62xWS0FQMJHfvTUvnoXnxpmkwFXFd6y2ucNao7vtg592HasNRTkpHkJ7bRgd3VIf9VtSWlSj1tbZdM0SqLWrhukrXk9+Gn/W3LszA+QkYctt0Sc4LS8L7eUw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHUx3fIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44589C4AF1D;
	Tue, 18 Jun 2024 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714513;
	bh=gXP+HGtKZBJTAK+ZamdQmVHy9NzhVXSFas4iEwLoRqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHUx3fIJuaIlQWiCuv+xpA5aeqKhANJf1SS0pgCCBKSfrR1aV/CtV/mg4II9L1wjp
	 cq7z+NmGa1GKceviHgZO/5tVqfyFWBNP5ldTjllkrOeU3SF6Fgq0Ht8/2tO4F/bQ67
	 tPKefJ4t0CeXFbUI7OZuR29w5nGEOxF47zjBOp+jZJeUTiU0JomYAf5j/qkpxRF1FU
	 5j2jIdG7OWnLQA2bhqZvNVdiT0KflCn5oOME0ZZlyidPHCOgNzhVbt4ND/zb/fll7J
	 3agbAESaok/K2HZE1QxNsRaXNvmfBGP8X8r91JNJYOpUdi9os8bat9gUe34hza5Z7U
	 5wxSfqBK8STgw==
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
Date: Tue, 18 Jun 2024 08:41:07 -0400
Message-ID: <20240618124139.3303801-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
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


