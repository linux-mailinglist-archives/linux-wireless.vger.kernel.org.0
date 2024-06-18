Return-Path: <linux-wireless+bounces-9174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07BD90CCF0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55FD281742
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F341A08AF;
	Tue, 18 Jun 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0vE+/kw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC731A08A7;
	Tue, 18 Jun 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714439; cv=none; b=XAYqs59eC4ySgx3JEmSgv2+YnV9l86zSyZso/D8jmr6NYbSZ/Od0jC0SFAsbVz3zURr9iQFGWwN4ktN1vQHrI1raHBEPwTqCgjN/iXKS9VqzfWEnH0PCMnYTkm5s7ku/6FthZ3txgzAOcoNRD18Fas5GvCeJxcTOV+9Z3c/6CGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714439; c=relaxed/simple;
	bh=R9gQ5TWisbAU0V37/lrPQFfzIfNu5uluZ0CmaDwYwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0Oo/zliVygdMrbQEUs62K/4yp4v/g4zqzgMvA8LJGfQ36GagSdb8gOkwySJqMrdRZpMz0XOf+E6QGocYpTcaoXSW/ncHafmvylY4f46MX/eKdJ8EuJrRAIWGr+Q0Nk3grnA7oLywicm+ZDowC5BbJvKSKnBeE3115UQIymF4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0vE+/kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE48C4AF51;
	Tue, 18 Jun 2024 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714438;
	bh=R9gQ5TWisbAU0V37/lrPQFfzIfNu5uluZ0CmaDwYwDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0vE+/kw9Zqn7Rk+07S9qG7koP+Q5SAXqBaSpqQzAorTszN2hUHvBRwOE4HB/w6hz
	 QFjyvzcNtMWa6zb1EpWWtc3SCbNrte4yUpoEcuDneLG4wqdwHNIhj1MaZ2qjt2+fp+
	 V6kx+NmASAsUdfs96Xef6oCiOBexYp+0ZA26yLarzzqBeMnMeij8Whd0Fr/Qc1odCf
	 Gs3wBKkvr6ZXF8SX+D8P3KY2k4KXy73SozCYbg9RbZ4M4agh1fQ256jyUjUhMAWcwl
	 yIhEGS7wdTFfSYe/lGj6132KaA/rcOzE2jRNQEH/3Ickb5qZPSJ0YyMQnzlzIIChd8
	 hk6dkgGGF02mw==
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
Date: Tue, 18 Jun 2024 08:39:37 -0400
Message-ID: <20240618124018.3303162-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
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


