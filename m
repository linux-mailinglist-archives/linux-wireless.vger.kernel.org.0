Return-Path: <linux-wireless+bounces-9152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F190CBED
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CE01C238C7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87362154C02;
	Tue, 18 Jun 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQW9Sl0R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56853154445;
	Tue, 18 Jun 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714198; cv=none; b=V06WOL5gUrsJSPZevrLXy/Yd0aY5IhbPr/aGdS7s3pmbQnEtVZyy21HozBlkHmdaduWtEYj0aYVQEBFYYxVq7uLKcT15dBcZX9QrkZAt5xkuFD37DQpdaUA4bUTOucbq00z4Vx4YEgxd88yjbwuHK+52aeDphkDnmS23EcWXN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714198; c=relaxed/simple;
	bh=7sMmr0W+ZNWG77z3Z80KDAuawwS/RyzpRiRosMOSNDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LchEanFfhRGB7UNCz8DBIBHPJjSBhgNA9P1shdStTRmauXwmGS9vdvaw7TOfHqp585mmnilpGApHY9OSz3XzxGMuQZzRNvumL/wDuwPQ/VqAFBzpuoCle5edlRTk9dd2eVmhd6mTjjGKV2Z/1Y8vgjSL2dhhxECPQgcHnpEOF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQW9Sl0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F8DC4AF1D;
	Tue, 18 Jun 2024 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714197;
	bh=7sMmr0W+ZNWG77z3Z80KDAuawwS/RyzpRiRosMOSNDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQW9Sl0RvqRDhBh9QGeywsc+rPzqVpdVZZI59V/iRMFDA0beqiWdp/Yv1VDAA3lTW
	 xzTUyk5iFOpcfPnb28WifU1LEmoFl/7rbkGyb8JMHWBNHq1XGOc8+qU6vLt08HHkR5
	 2L8/HMgw0ASmQ39ZMahvECijvoHCW6XRJNcUdnFPnTllqTEzPXGQdOTsFSLI2IOVvr
	 HZntQhzwX8tOE8/MizkCzQZ+kCiDfhWICR2247Vdz3IqYntu5ez93d1b6uXTfVkCta
	 YqCTJodVxaG+YYkAtNYFjXH1isvn7uFfS7jasU4KtGdFtjYgrPNT4SUQxD258lUFJf
	 VmiS/ke4NH3Hw==
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
Subject: [PATCH AUTOSEL 6.9 14/44] wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sdata
Date: Tue, 18 Jun 2024 08:34:55 -0400
Message-ID: <20240618123611.3301370-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index cbc9b5e40cb35..6d4510221c98e 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1776,6 +1776,7 @@ void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmsh->last_preq = jiffies;
 	ifmsh->next_perr = jiffies;
 	ifmsh->csa_role = IEEE80211_MESH_CSA_ROLE_NONE;
+	ifmsh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	/* Allocate all mesh structures when creating the first mesh interface. */
 	if (!mesh_allocated)
 		ieee80211s_init();
-- 
2.43.0


