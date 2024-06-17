Return-Path: <linux-wireless+bounces-9096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5580090B081
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC60028487F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777416CD1F;
	Mon, 17 Jun 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYwlBlW6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9316CD18;
	Mon, 17 Jun 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630717; cv=none; b=SPbd76jSLF3HFlfm7P2TAjbSuP6ePHQIEqmcaZRDJ6NV7Iy8PrSk06tMrhuN7JwIAqQL79wsMriQxxowrp/uSaSwK8/B13fMPbNl8R3o7pBKz53B8N5xFPo8pZtXhZkk/rsaCWWjPYaRcR9+wj+s5f74+J0Lo2ii052l7/NOpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630717; c=relaxed/simple;
	bh=R9gQ5TWisbAU0V37/lrPQFfzIfNu5uluZ0CmaDwYwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kie4ab8nSBPnOU6EO9dckdALdc0ZECpZtUloUCGFz0I/0JAjBAC1UobMglGu+5CVuVNl1Obhyxh2uptVPwKtFo3oXGAy0bp+tVG4p+w1wk7AJ8VmLicCTYSzcQiwls9fahDoAvZUXkULrGZ9zUZra7Kcs8k5r0fa7hmAyoi8HUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYwlBlW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF4DC4AF49;
	Mon, 17 Jun 2024 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630716;
	bh=R9gQ5TWisbAU0V37/lrPQFfzIfNu5uluZ0CmaDwYwDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYwlBlW6RSSZ+XKawrHf3TQYD4/BjQaEtSYbRd0VTZW+IXcMoZ+ddnNHdUlFFaX1l
	 iThBtxF4CmcGtKYNQukoYDdM0s1cobfiD4we4gIb61x31Kbl9Sca1pF2liguWKNuBY
	 3M6TE2dL6VTXsspvIGZ9LyxcMaKYf/Mr423nXUw6p48Erw2I9MTM6iHrxysJyhCQa9
	 1myPk5c4BcZ0AGwKls49oeK3c72ffEJief19xd7j2GuhbAVv+zegPGV4JG9mCoLsf6
	 F/16Ry10D3miQ1Hgb8X9lW5TdblZ/5KTImDGMggwBHswLT16UBGheOLFxd+lpb305W
	 /U4FwY64UMMbQ==
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
Subject: [PATCH AUTOSEL 6.1 11/29] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Mon, 17 Jun 2024 09:24:15 -0400
Message-ID: <20240617132456.2588952-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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
index 5a99b8f6e465f..9c9b47d153c28 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1625,6 +1625,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


