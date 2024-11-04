Return-Path: <linux-wireless+bounces-14873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2359BB280
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA8284BE7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323C1F5829;
	Mon,  4 Nov 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V99X0UE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B51F5824;
	Mon,  4 Nov 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717722; cv=none; b=B3k6CWkLYveXln2mtytWcGVlLkGhvESX+zzDG4BsOPCotd2c2soggr+0gf1jGeEQkYrIr2uZKz4/yQ73hCXnx4yufBoVZZTIhejVP765ejBxgi7tIGh4+HVlP6EXeKxJ/YP3+9sZAmQXLUe+9iiA59UoUHYpFbiyeCjAKchqUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717722; c=relaxed/simple;
	bh=A2JvirvhQNBFQ5hH1ZIZA0LOkFVHzfzG4cUsmVyHxG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T48tbv+z1TQ3u9n0GeyQn+WiypxhLt7aeHRTy6zIodHkVjRvcurbWXP2XfACBddd5NPpjm5+/uI7Z1rYR9pXWloeAxxnrVtcVh5bqDwkme2TIJu26LH4MeDNePYsDBfPCgrtuEPOK1ItExoJWgqkQ+MCEMMF+SKs+O6he7sspZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V99X0UE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91535C4CED7;
	Mon,  4 Nov 2024 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717722;
	bh=A2JvirvhQNBFQ5hH1ZIZA0LOkFVHzfzG4cUsmVyHxG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V99X0UE+wuPhPoNFQo7dV9p///QuVH9lYSusz/+F3cWJcl9QGH+QknCMCxczrmX4R
	 jExs7frs8ublTiIo0lYK+WhA/Ep+FusrDN3NTj+bntEnxYKv2JsN16wUbEs3CyohF1
	 bgM+zi8hxD19cG/lhqZCv29krUhQJmBUV7fn+Rrsf4mS+22XuiJxbeLzkeuDgt/y/X
	 TWsP16bTkz32mmPr+tkp3JVZxcCBVZFh7VTOX5fz/4mKzOuSp3ksISJgF8+uj6BU1B
	 o0EHNxZVpmBV92KX84qn4G6RyvtQTIa9+cnC0bku8McKU0PnGLWIKV91w1vxvOOLc4
	 RsBfE7Hx297Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/6] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:55:06 -0500
Message-ID: <20241104105517.98071-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105517.98071-1-sashal@kernel.org>
References: <20241104105517.98071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index fa2ac02063cf4..266250e9f0330 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -139,6 +139,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.43.0


