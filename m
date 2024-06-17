Return-Path: <linux-wireless+bounces-9074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4815B90AF49
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16B51F20EE4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA11B1A2552;
	Mon, 17 Jun 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNIX1yfS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8311A254C;
	Mon, 17 Jun 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630473; cv=none; b=SjfxZqwPz3NDFsP6DzP0XK+gKhZunZqIsUn0b52Kj7bo8UlO+ZZ7C6vEoPaACoYyjBSKSJiBHZvICueD+62jtDtgfbwVWuYZdudGNKwsNIha7oGVBf/cOA2BIxEZlaShFVNxY2FK6UIlInNZKrAFpWZMpoaal//r5LENl6Y6AwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630473; c=relaxed/simple;
	bh=8kabB6EPxtK6Zz3PjFOMHndCUHRvwX1PEvmDCfVfmw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KORGevIs3WdUtmqVsdK0zdGGXry+UMThsHFAZiQWnZuxE57lMKBjLd48hsF5qJzADtA1P1+8gvPcpXpn9FHXexyFuTgXn6zEDwub+phAF/jFwe5tIbUmrG0zlNtujvgJmKeR1xJNBY6/pfXZuUqL/v6PEG338hfUSAABtcW+DG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNIX1yfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D2C4AF52;
	Mon, 17 Jun 2024 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630473;
	bh=8kabB6EPxtK6Zz3PjFOMHndCUHRvwX1PEvmDCfVfmw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNIX1yfSyywvKNM3HGGFOau386fV8u8c6LfhUz7EN6yrxjdit/e8xMjhpfLrYWOvr
	 83JSLdkVwJauX6wdXGBdHoYEvybkaymmghMNPJfAKPUg/IoK3vqGjjQfz9FQD4zGUu
	 vwJ/2r4k3BcM09bzEBZ4T7YlX0XGUy2yRLlQkE3qtLTy4L8lq1goEjrPZiScU+3/ST
	 EOu4Idmb1JYQDFlwPC8sY2GbIlTA/rIfBNrccV6iVSBFL/SZHG5P1NIPKZm1iFIgaY
	 lyv3jDgk1z4GMX1dso6lCUTknxlAttA2oN7xhfLMIERaQDYIhBlzJ401swULYXs624
	 MsjNkrnP3hFaQ==
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
Subject: [PATCH AUTOSEL 6.9 15/44] wifi: mac80211: apply mcast rate only if interface is up
Date: Mon, 17 Jun 2024 09:19:28 -0400
Message-ID: <20240617132046.2587008-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 07abaf7820c56..b70edd8e40ae9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2954,8 +2954,9 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
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


