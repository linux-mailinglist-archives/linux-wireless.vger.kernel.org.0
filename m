Return-Path: <linux-wireless+bounces-9163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBC90CC99
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD390B28297
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36BF14F9D0;
	Tue, 18 Jun 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKpf6oiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358016DC33;
	Tue, 18 Jun 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714332; cv=none; b=mqmPICoAoka4+xLYylc0ga0l7M+F86znqjvBQhIvEFY4FncpvAQqU0uD5xkUkLhSzeSm9rOZiUieJtLqzIiu/7gXYfArFlSGxuf3mRFwPJhTAbR4V4rR3MsvAlEcH19lWobnEltRm029NgXK2ZyVySN1dW77YopjhBCIHItXoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714332; c=relaxed/simple;
	bh=AN+qpo3ItwQXO5qFPg3qM/nxaDZ/P/Ny7NzmFypCeQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzu+QugSbeVEp3kUcO+0N+XdTej+dYqA2h+uoTrzsFqWg68PI8mRldCXmByQ88G0vDeoi3ZrW+NKFJdeB3+6W01S7r1gJap+xK4lAxQRguV2P6K/5XdBSyuIc7TbOoKXGgQ/vA+Op5yiBT2ykkCDNe3pW2pDFGcKO5RLdtmlzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKpf6oiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428B7C4AF4D;
	Tue, 18 Jun 2024 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714332;
	bh=AN+qpo3ItwQXO5qFPg3qM/nxaDZ/P/Ny7NzmFypCeQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKpf6oiM8ZBRzySLcSsfb81gumC9i4v+8fJtBnKW4KXPVRMd9cqB0MLu5XN9nL4jD
	 IEpM+EtDSXYJ3iFMT8D1lva1KdsOK2R7g2m9q6uk2jjKL2tvVjJ322XarsZDrw0Ofe
	 eyG+0vBIeHWKEEHZJMjh2cDwFhpWiXifsRxY5PxRYpBiC3MQQrvNIpi/XOynXOzdWK
	 bgjVtozyPYbQGHoZLj430LvDzWl0xzLOTMmcKfD5DDB6gSVnCYXF+r7hEPJNj0KPMU
	 TsFtnMy7kxvKXpNyikDqTmP8Ij9+upPiHJ4aLu0BuX1arH0QrTvxhXl2JsYq7FGfAV
	 0NCwfZ3rg4mTg==
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
Subject: [PATCH AUTOSEL 6.6 11/35] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Tue, 18 Jun 2024 08:37:31 -0400
Message-ID: <20240618123831.3302346-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index 7b3ecc288f09d..25223184d6e5b 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1792,6 +1792,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


