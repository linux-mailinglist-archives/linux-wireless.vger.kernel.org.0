Return-Path: <linux-wireless+bounces-9189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BD90CD7D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6EF1C2042F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A521B1434;
	Tue, 18 Jun 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPgd2bkM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9113D242;
	Tue, 18 Jun 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714558; cv=none; b=Sl/v8QpZrb2jZN+rRovEjd1BHAorLNL/DLaPx9k7KvgCs5dS0SWh/q20EZ2fyA0nOhecgySwFZFeNOXhoJyovYwIAx3vCCH03trSF6dDU6fGeWHpAt+uHku/rJaWD0VjrCxpuXdMVYCGYtrNede715v6cMyMb+LShZZZ/1LnoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714558; c=relaxed/simple;
	bh=ojaUoTqc9rW0ZKJS7yZY+c8GzWgSEwuKxehfDpPp2pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBSg+4CAWAKlGPypZcUrgR64zsE24R7Jd6n9AP/q1n0JHPZy7u3X9vwW7Uja8RACk8AY0/Lx/pQDlSxf3XEvNcah/y9db3kHdyEybyccwnB9FYJmlbpoUPJEvZlnomBxvYg9jpluZdcx0caAC7Zr+tdh2pJIbXlI0NBgbWk8eEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPgd2bkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25A8C3277B;
	Tue, 18 Jun 2024 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714558;
	bh=ojaUoTqc9rW0ZKJS7yZY+c8GzWgSEwuKxehfDpPp2pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPgd2bkMIg8Bv6C/LVymGm5z/WbRYb0zNFrFt//Hf7EKxCb5RCFauf/EmIuhYXsht
	 Qh/ZImSpMQLfFm16BTcy+fn3qmlH25XZFbB5U8+sSlxqJDDDgObNGVXDxm4qF3d5NH
	 k67ed3Qy2psEjeNmpcay/Q9upoRvJarn42GFHVB5b/MitG7exqx4FGkxrQp94dp3I1
	 RV3myvafFIiTGsM5s4QA4T9Fz8hxFl5UAeZLwMhtsn2ewymZXn18uMSnEwfLQ6fFXS
	 HKC5kewGqkd6DgUmDxfUvU5jJ9dsSI69LhC9exj+fi3I2Pp6xKAI1v9rKS7k/Bh/8A
	 yW9x5l5pn2MXA==
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
Date: Tue, 18 Jun 2024 08:42:15 -0400
Message-ID: <20240618124231.3304308-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124231.3304308-1-sashal@kernel.org>
References: <20240618124231.3304308-1-sashal@kernel.org>
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


