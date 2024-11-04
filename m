Return-Path: <linux-wireless+bounces-14874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9089BB291
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5031F218B3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6C1F7561;
	Mon,  4 Nov 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8xHn0Rt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DD1F755B;
	Mon,  4 Nov 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717744; cv=none; b=TKTqijK4D3WZY4ajedbmPjkbkgO20XQRtlymMcmkONtbDjvfeovQrfOoMRsVDlqoHXT4e/TYPY+towYZPDZS++oKxkwioyFYHz7YraPiXB5MuKnVp18Kj0eMnoGUcEvrbPfttN6JDA669AvjG9c8ATBHCpD+2j4ZW4fcvNLIH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717744; c=relaxed/simple;
	bh=+OLKUtZuVadq41JrBY27nCN6auZO8OYRPVSmExa2HmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+6G4qRjel1M6zPFjLku6lKvrBgGZ1xaTar94ll4DxTgAolGFyfaCnlFjLiQsBOrdnkpCSis8Z6JvpmCdVXEXYemeYc8NgoPHOsmtzbUiEXA9f2rQcwklolZGJGARqClJL5a2mY29Ijv2JXQUUsSpkn4uX6oucwskMpb6b0zzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8xHn0Rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7921C4CECE;
	Mon,  4 Nov 2024 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717743;
	bh=+OLKUtZuVadq41JrBY27nCN6auZO8OYRPVSmExa2HmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8xHn0RtCcssJw0lYJlIv2xDTJJvDw1NYE0Sq6/KhofiKc4FURav4Bs9TqDcc6My4
	 blEa+qjuLVD/pKkDhlgnf22xANzw83vJequr1CgQ0R5+16G4BA8tO8NQoTwBcH0pAI
	 VhqaS0ODsrCN5lCAp/URqL1A+DvZI+BNb7cCt4VnIrJ5h+w4OJ3APqldZdBrHugFgI
	 +nETqJiGW07gm3AptBr7q+Mj2Fu9VeZKn2KCbJU7pr1JBX0CZlJhwAQaik2RYL5A6R
	 O8KvqlkruNT4YxmViK8V+WA5SUMIU5jXO1MwpX77FQ4FzDIuseOvQLCDZ9ilEAHagZ
	 8bVdx3NUwFdPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:55:31 -0500
Message-ID: <20241104105539.98219-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105539.98219-1-sashal@kernel.org>
References: <20241104105539.98219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index e8c4e9c0c5a09..71d10bdee4309 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -140,6 +140,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.43.0


