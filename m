Return-Path: <linux-wireless+bounces-9113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC07190B15B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7419E285038
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3A1A00E4;
	Mon, 17 Jun 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s692JUt6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4491A00DD;
	Mon, 17 Jun 2024 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630866; cv=none; b=ivpTPSVPExc46pl0hR8xCHzMzCay0glLgivYtjTvLlN5eH494kiq6AIGZdkQUr7ctrZbvlaLO8CQ92w0EyJX87QDlFR0HPDM5UvpAdLKL5hPVWmlsqPbPtBW5EE1q4RHcnCIKjSt11rFzAoDAaCGohc7+e+qG2jYWf0stAHa/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630866; c=relaxed/simple;
	bh=udfluiMSrKjfX3TcpaFiU7kSgo+DhoGkY4CHIyY9NPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJDcwC6XoMXLEN1Qo2i+Tn7GIduvCqV5fEr3JMK8SRPoVoeniSRNBPcO0PVN/C4j0YSqPKelatsHqgfIq2NKetvG57dqaszS4zpLTJuwr49IvGCHEKzRdabRpZkQ8U1ob0fR+IP08RPM3H7Va3UXm2THnm4HDnpC8PUBUeS+vFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s692JUt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4E0C4AF1C;
	Mon, 17 Jun 2024 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630865;
	bh=udfluiMSrKjfX3TcpaFiU7kSgo+DhoGkY4CHIyY9NPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s692JUt6h/ZAri1//VewWx6Qr/9rpextUNNIgef2qmunah9VyvTPeIksCXOxsFQvL
	 jp7IA6j/QRnGiulsGCfzHrFJ7RVQ2b1rxoFHORSPy2QNPUCFXnf/dYcKnXrixjKOz2
	 UMPCx9kQcrjcipxQzP8enhwwZRekqlNgt15vpf88ZoNYy4bZGxteR+zQKGP5wfRbKD
	 fOmxGytFwbGuuq56fzOBWV7kL45SwMJou98r05iJ8Af3ZDOOM+/KI0fMrt1GWx8lrx
	 NiArfneUSa1T9GBnn86xYj3Iwm/P2SyMJ4RZEOZzOmDEOn9l+0aKPbAB/tcbCJT/6E
	 4R9AloCczaDbQ==
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
Subject: [PATCH AUTOSEL 5.4 4/9] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Mon, 17 Jun 2024 09:27:31 -0400
Message-ID: <20240617132739.2590390-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132739.2590390-1-sashal@kernel.org>
References: <20240617132739.2590390-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
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
index 36978a0e50001..c2d1addaa7ccc 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1525,6 +1525,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


