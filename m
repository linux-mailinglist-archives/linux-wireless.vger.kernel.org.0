Return-Path: <linux-wireless+bounces-14869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A22F9BB21D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043D31F22198
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F331D5AAD;
	Mon,  4 Nov 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki1+SE7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12D1D5AAC;
	Mon,  4 Nov 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717622; cv=none; b=FC0t+e3LlfOM3fcUR31p0zbREQ5/uwpa/3DG7j9K5z19NCSCD95nBWhunQaesyDiFKeh1nAaF6u5Gtr2+qBy+SLgxJy5a4meORUyjaExSBGTgfYrI2BceKh/sfbefopx4OPnEp018rR6WpDikXQN/LI1ioRIpMby6244yuASj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717622; c=relaxed/simple;
	bh=VipNjBoo3aRkN62EYxOlTYNmTADw8PLaEF5NDcY04Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ravjX13kLFm+JCiraWtQHKPn/GC2jHoFiSPyLZvQzJnpVpngskJPwqVn3w8P/Z0ElI2WNkBkxpTXGWZLu0oi1tYNjUVGDn+EVzmdXDbQek35ErMocSXKX+7b2zKNLRSmAAjZqPDtCe/JitnthwjCqHNO2pJ3rGFMVWyIc2Nn/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki1+SE7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D47C4CED1;
	Mon,  4 Nov 2024 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717622;
	bh=VipNjBoo3aRkN62EYxOlTYNmTADw8PLaEF5NDcY04Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ki1+SE7q7wJYyHRdu79JXkY7baRMwFKQSYgEsbCSdphWW2YwrKB0XzEy9/NxeKEfn
	 CZnuQvz4oobt90KLcTcNRmp9Tfn4BEvxWbkonYEsTHubAfco2gBbCDFhu4hZRT2OCs
	 CwWRuRsA58pmzpZZXvwN3uuKKALYhIWSiZ1bV8yOerwC0Zx0lJCuWxsgapaDnQmLBW
	 Arp5r1zWv4fenhuSKFkr3ZAYnUHQfqNae0Hhjlj9kGIVK95t8M5z4++3IdtQ7a5oUa
	 Ff1oAhSL7jKWxzhSvcS4H66+6oJDAbKrE8Q4st2RPCIdVRTE3e7FYxWjTHP0M+Fzg2
	 AFevMk2Ua1mjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/11] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:53:03 -0500
Message-ID: <20241104105324.97393-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105324.97393-1-sashal@kernel.org>
References: <20241104105324.97393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.115
Content-Transfer-Encoding: 8bit

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 9b15c6cf8d2e82c8427cd06f535d8de93b5b995c ]

ieee80211_calc_hw_conf_chan was ignoring the configured
user_txpower.  If it is set, use it to potentially decrease
txpower as requested.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Link: https://patch.msgid.link/20241010203954.1219686-1-greearb@candelatech.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 1eec4e2eb74cc..683301d9f5084 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -144,6 +144,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.43.0


