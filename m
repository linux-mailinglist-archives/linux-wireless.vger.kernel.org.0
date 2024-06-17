Return-Path: <linux-wireless+bounces-9097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E383190B086
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31C41C2039F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923A16DC09;
	Mon, 17 Jun 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6hwTdN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A516DC03;
	Mon, 17 Jun 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630718; cv=none; b=MrzwTbVV13v6kESpG0ZcBO9z9MolNgDuMJEmJ7VEB9j36sdb7v0hEItgTkYXxnpQFz+NoRRDK6kFR4yE98gHC4FVCOSxiwAdDKcUA568MMd5IRQz/hTY4qqKwAd73I4q4Un1j5/zQj8OsSn6jPPViNFjj/B1XEJ6Gq37QOI2xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630718; c=relaxed/simple;
	bh=VNR/aRNyviV1hVqoK3ZPFxvV0nyMXjxLv7AXsbINkwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqwe1fFcL3wQq9iPC/SIqRAakRfC4L71zd38cAUHTWhyv4r5DUU0/mYg4rqVeA5HeFago9aHT4Vi2bwsgE2jAgcEhhllevL8oNltQ3lL31EhcIi/+0xVWHHI0eaXxRIV86ttY7bzD84XSGUHo1rqn9YS5Fal37IGQcie/KKXQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6hwTdN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5986FC4AF1C;
	Mon, 17 Jun 2024 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630718;
	bh=VNR/aRNyviV1hVqoK3ZPFxvV0nyMXjxLv7AXsbINkwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6hwTdN6ZE00t5/IODjlk7UbOY5l5i2RsenMp21DoP4DZzgxfVtT6INb0kHnPitjY
	 dBgt/xMA6mc9KZqRKiuh79k19WuppbpPrtDakS0EjCh3Zqef7GZoa0QIbArFnJqlAH
	 abPCnug7Nmu/KqL30GYVXkWmgFBg5NUqN9yWcQmzEcQ2A8yQa7ORIR9fMwztIh4ZkZ
	 zmaSNYJSpP4C8BENns0PKQTQFfq4aYgLgcLJhL0luDKqTE1RArZb2eM7ZzVWYo91Rw
	 h7wD/6aXECX2RDc7FAI1/+XMgpBXZaAFSOOEHKh5HcXttok6fNIbHiVG41rJ/YN/ey
	 fcpTn4twsTt4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/29] wifi: mac80211: apply mcast rate only if interface is up
Date: Mon, 17 Jun 2024 09:24:16 -0400
Message-ID: <20240617132456.2588952-12-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 02c665f048a439c0d58cc45334c94634bd7c18e6 ]

If the interface isn't enabled, don't apply multicast
rate changes immediately.

Reported-by: syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Link: https://msgid.link/20240515133410.d6cffe5756cc.I47b624a317e62bdb4609ff7fa79403c0c444d32d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1e57027da2913..2c60fc165801c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2838,8 +2838,9 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-					  BSS_CHANGED_MCAST_RATE);
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
-- 
2.43.0


