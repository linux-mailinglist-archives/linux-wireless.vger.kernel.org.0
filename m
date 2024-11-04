Return-Path: <linux-wireless+bounces-14872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01AB9BB262
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1131C21C57
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48461C3314;
	Mon,  4 Nov 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8ZWur/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC311E8857;
	Mon,  4 Nov 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717699; cv=none; b=qSXA6CcH4hZGPlNSf+ce5QLYaHM0R27ZYdDTnW4vlQjWy3juqR0/gY3txxGwAtF5OL4DyLd9d1exWNBpI6CN3NyFZqFmwET7l1lpDVLX6F4pmaXckRu46A4IvJL+DB04izuh9hbAM/G3qeTyX9t+cE1lN0iKgSfwyBzu+CVvg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717699; c=relaxed/simple;
	bh=DbFzu9xjoqS0oa9BDsSK/QAvs75vxy3wEaoQXKzgi7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv23qqCE1zyjUNP4mzE61nGsqpTQzgBKFDqKbcfbR+Mf6h48fIHIVa6jOeATG6YZP+44Lin7qIFrFod1wgOwdf8IW7u/SyXzFEi19oZBdLBQdLbpfhsm9o8UhSUdX0e+I6jamVWNBqpJ3XXzt3lGHQ2rRCkZcw9WZolDTqmePNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8ZWur/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C86AC4CED1;
	Mon,  4 Nov 2024 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717699;
	bh=DbFzu9xjoqS0oa9BDsSK/QAvs75vxy3wEaoQXKzgi7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8ZWur/2vMAIAjk9hlAqBKWL7n0C5HcxBGc34fwnbjpQKcySEVODsZSifUcI98X6h
	 a8I2XPyvReQeAv/WAzmZ9jaJ0d3/NFKR5WCcU62+y+JD7rZmZA+wCwG5Lcz9Wda6w4
	 ZvewafBQgL5r6LEwC2qXgzmGW695Zldy/11nsLsJbTrMLecxbgdZ2xtMy9xQMKvJiD
	 XfhvmWum2Z3s/5zH/pFsq/K7N+WWRmaBCq1kA/0oco/NS8pJi4l5xgk9TqLb42cRh3
	 9j68COyS+EaksBHQDNeGAH9aYgI2CTelkEX8c5xgYvbCucCH0Ahs/IOShLXOcCDJiG
	 poh77EZqUmFDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/6] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:54:43 -0500
Message-ID: <20241104105454.97918-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105454.97918-1-sashal@kernel.org>
References: <20241104105454.97918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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
index ae90ac3be59aa..8b3eead8989dd 100644
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


