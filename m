Return-Path: <linux-wireless+bounces-14864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4B9BB1B7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BB9284149
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA01C232B;
	Mon,  4 Nov 2024 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzcqAeuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA91C2324;
	Mon,  4 Nov 2024 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717482; cv=none; b=eiWdxi/uFAYSMGQHo6f2knCVVC+JaVkhUh+WxcarGGaW9rz5MIUvaGlLhhqnoVKCNmvgsSaCcgw/HI6dHf8w+aeOFty+gvT8hJ2oJtFuurTL1hljXMBG/QHU6X+cModPCnxxwimY051MN9R7g2v1U9m9nO3umkFhUMpXDO0zwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717482; c=relaxed/simple;
	bh=M96IfNJzskDiISQX57v8BteausYlS5ErBEYAuU+LiMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H401EmD8qx2M41uZL+iQhr/1SQQv2ccpEvKeZEyyUzTP7jCfHaODkJIcZT1Z1ROuBeWieiMD7UolsNbf/c1i81scwRk7GJy5VbIpnVUPNUz5WDAXBALUs1iNrhWbWBw0ra4dnSsfJyoyoWW1OnAmbd3f3C3UqHcgk5fdNa2Uv18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzcqAeuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42ACC4CED4;
	Mon,  4 Nov 2024 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717481;
	bh=M96IfNJzskDiISQX57v8BteausYlS5ErBEYAuU+LiMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzcqAeuRHhI8L60QUZaiNkM7Xr+wo++LNzNt7SJGugfv0iBWTJNs0Jamye4H0OHtD
	 r8NXviA/AmU0JVoSmahSvvEvdIzd2EzD2smZscANx+Q4ZBYbXSO+Ar3XMqSgq1xZPo
	 yfX0suIZYKMF0/x52GqZeIWZmOidrgf9nykcAu2Kh576eJ0YfjLahTEOtbK2xcYEFH
	 Btt8XGefJACPKiP2CJ4RobuyVIilhKBJvSjAt1AEN2hf6mYrSxoguyof7ifSAehlaE
	 5wxg2sTuD7OqWxk5l+gyaa/+0AiFvPwwbWdF8js+bUmmv878MTDbwydIWpeK5Sr23V
	 ++KUxc+QxQXWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 12/21] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:49:48 -0500
Message-ID: <20241104105048.96444-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
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
index a3104b6ea6f0b..9ce942f3a4a4e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -167,6 +167,8 @@ static u32 ieee80211_calc_hw_conf_chan(struct ieee80211_local *local,
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.43.0


