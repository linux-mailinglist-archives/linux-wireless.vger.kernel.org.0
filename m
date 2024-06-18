Return-Path: <linux-wireless+bounces-9175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637DB90CCF2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774351C23CAF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC01A0B05;
	Tue, 18 Jun 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppA4Je1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA80156C7F;
	Tue, 18 Jun 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714440; cv=none; b=Ztbt3xmCz92CudM3nQp4i4jN3K40XP5bjt2nxfvEtTlBpgbbE0v1aLxJFWlEwfSmN1z0bszvhWfGGRdROD3Tior0IwovN/ITM0a5xa6WyK/utKawRfR2rpbolDoJrZ4zRZs79zbrAZnaguA1ay+m8wF8s33inQxIXz/qTYDaxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714440; c=relaxed/simple;
	bh=VNR/aRNyviV1hVqoK3ZPFxvV0nyMXjxLv7AXsbINkwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIXpgjwAoMXUNxQ1KKNjtiMwiVOtWCrDRZ36eYD0hnzPNe7hNUG6CvB5GqlR06zRLkQh6omoF86gJYkrak/OwJR9fDHQzvIglVzKFG45QmHqAgMNf7HqPaQwvaHT/gU/TsISLEHNrSLHzdDij+osMfvuM8bvuBF9iTknP43BhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppA4Je1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491B5C4AF50;
	Tue, 18 Jun 2024 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714440;
	bh=VNR/aRNyviV1hVqoK3ZPFxvV0nyMXjxLv7AXsbINkwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppA4Je1FGNaRlaJa+DOAm5TnSYigNEGtTQY3ZpM4zuBSSKKLpk0jjDf1vEL2zrB6v
	 n0QgJ/S+CjdfwT7uMnE/+CCM4Dn4GpQhPhzuJ43wwOQTr2LDi8wJpE1x2Bm649JYZL
	 2QshOn5JFAlSfptzpF/42qO9ju4woXwcpkxvzjG7FYZu3YLAcD8mECtz9dEFeZuNm5
	 ReDXic7PJ3uZFG0+V3SXitWUP4UpsUs7e7pSXGxPTa3fZXMKk27WsBRJea7azg3e88
	 MZJExvORacyes+gc6MoASZEDG4RtAXYZXbIUO3iF+xs0p6c3XtZIFXg3KxAe6Zsvpv
	 q4UwMd6vTyjFA==
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
Date: Tue, 18 Jun 2024 08:39:38 -0400
Message-ID: <20240618124018.3303162-12-sashal@kernel.org>
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


