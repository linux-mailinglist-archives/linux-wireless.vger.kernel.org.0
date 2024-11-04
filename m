Return-Path: <linux-wireless+bounces-14867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DB9BB1EE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964AF28184D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC811D0F79;
	Mon,  4 Nov 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4Sk4dyl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BB1BAED6;
	Mon,  4 Nov 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717570; cv=none; b=bt+i2YjvcPeSioOR32q9BCYPNAfbF/dAcvctpzc/rC1/ark5YRyiVDxBkvXqleIQ49TiWLx7GBGEUoBiLL8mUjhRyF3uB9lE7Wa+AUYyoEEcGrBX0Ot+Y+IBAH3ZmmJSe0Wk5TZ77xGyG31TvCJbqtPGDHLbA03pL+WY4MQB8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717570; c=relaxed/simple;
	bh=M1tBnd5QgtHfSuPQ3doUDwwQxd4uNfNizza5Uw7n8Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMCMalzYyaClrOqyEFI7B4N8cBL3Z7XOfvgW+kkysSA34UHXFd3JCe8eicx/cCtEFSi4TZ/+xc9TqxbK830p+taDHCjP9EYAE2ahIVJAAa6kq6kyxREphNaRVBFqf1MI3N25ZuaXPh/kLI0ZeRgUY5/mOQzLVlqk9Ae0v7AAb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4Sk4dyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE1C4CED4;
	Mon,  4 Nov 2024 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717570;
	bh=M1tBnd5QgtHfSuPQ3doUDwwQxd4uNfNizza5Uw7n8Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4Sk4dyldeGhwnbkUowCmuXLCcFKn4tNCb8Dz7m3PlVTj7ZKR630lGueSe7s0LpE2
	 ZUeupALbyDW2+YElhPjFjxheMDe0O8LVrlLWQAjQ5PIb+HGRFcajsc2wTp661PCgMI
	 JbF9PeHpJQcIUh2vW7OnXb6qIfd8SU2YE7TNBTWT71hVOa650+5VNOGK3IZHsl0LBJ
	 Pwulh0QFZunPl/kW0kmkTZKpPVRj+L6C8ncOFiv+0KiEUAq4BGqEFLaMId7PXF4jN8
	 htK6hpRsrVIB2UGR6XbCB3MIfuKGBk19ZoVCyAZxVcr+wIgO9eZUAslEQJ7Nwo3i62
	 b9R7Aj8MhmCXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/14] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:51:59 -0500
Message-ID: <20241104105228.97053-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
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
index 71d60f57a886c..d1046f495e63f 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -145,6 +145,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.43.0


