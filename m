Return-Path: <linux-wireless+bounces-9086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4890AFE5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2651CB3643E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CE1BE22F;
	Mon, 17 Jun 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQTcJAYo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E821BD4E0;
	Mon, 17 Jun 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630612; cv=none; b=Jy7RXbS8888oStfQWVjGqrZHORfoPURSC5q7FSdwvgJ27qKEZrOnCup3m+5qHqSo1HH9b5Zr/zKiEjc4RXZWSXqtoQ7552lS0kWSDMfczLpqb/O451E5X3NPesfy1Jl5MbL7ip5eSLO0hUUIl1TnPdQKcGZhVW+ro+GB0C9I50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630612; c=relaxed/simple;
	bh=yAc7Cg+LvcJNP6MHenJI3HRC/4+g2Ha2WT6arXir4J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqUTA7l+CIYsOzbx5oxl327UaWoSFRyByCx7qm8XHoeDA4Tyykinvsa0M0dWwaL08ew5cV4cAVQSex5R2ARA2me6icXKzi5pdJJZyJ3gXxQhBj5nZeBZdtkYBjFfRXL9X7CzY45iyY3+fSV7vmJfySQ5facfWkScf6JDH/zEAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQTcJAYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F1FC4AF1C;
	Mon, 17 Jun 2024 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630611;
	bh=yAc7Cg+LvcJNP6MHenJI3HRC/4+g2Ha2WT6arXir4J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQTcJAYo6APCfTbQwHDSQSDCvNQGLV9h14LuX2XwTaEHXpWK1l/ab89Bh4sDKtKlj
	 8oI/vW6AUhjRUs9g1Ru05VlnhssBlC7E1c/Z2xa0RnnQHhvIVsR/O9a7GX1MwEfwYU
	 b6X3T28LUxPqsvf+MFIXIBOs0on66ZGRfut8cdim/K10tDOML2gJZPuzcEoDe1t/yP
	 kzUnuk3n/h3CazEtmFmkfDkTZSda6QMk4ba+RjOgENMTc8cy6S5mU0dWaybh1NsoC/
	 lZS7TLXivuGKtC8v3byEt7QS1nEAgEMwFI5yMN3oQ+Jx9ORFPs0GCj3tHqWQYAg3SD
	 EP1XsBE6vHXjw==
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
Subject: [PATCH AUTOSEL 6.6 12/35] wifi: mac80211: apply mcast rate only if interface is up
Date: Mon, 17 Jun 2024 09:22:10 -0400
Message-ID: <20240617132309.2588101-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index 505f1d6ccd16c..f3fc0be9d8eac 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2953,8 +2953,9 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
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


