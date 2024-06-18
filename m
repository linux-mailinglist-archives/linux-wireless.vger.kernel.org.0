Return-Path: <linux-wireless+bounces-9164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F590CC7A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB20E285AC3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5716EB6F;
	Tue, 18 Jun 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njXHy/sP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07C14F9E2;
	Tue, 18 Jun 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714334; cv=none; b=rNXuZmdYp2+GEYxHnn6ZW3ww1aLyRYreJkx7J9iiKxkZ6f7V/CzTN/DdSRwYxvAR+wYinf4GriRcx1qAfDEN0E8JyZTl1lBOdvVEi2TZnnzGSYrqKeRJjjdFRg3g7Pw9Qh8dP+OS5M0sLJBz7sMeUtGSwD+mVnHAgw93sRfMRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714334; c=relaxed/simple;
	bh=yAc7Cg+LvcJNP6MHenJI3HRC/4+g2Ha2WT6arXir4J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/wZn5K7E5748ELJDjnBcsZ/lf2jj1KI7KnmJbzZCBtXDBIrB7uiUp+BWKav6XjMGCB+ku72QS+qKC2zd8FvONIJ6b3O2dtVi2hCGFRyR9422SaelG+ni0siHvnu7i7WPCWAf/fM7IvjmT0usXUgZjTn7YENuFWXhUSCYFqWBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njXHy/sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41A9C3277B;
	Tue, 18 Jun 2024 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714334;
	bh=yAc7Cg+LvcJNP6MHenJI3HRC/4+g2Ha2WT6arXir4J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njXHy/sPdsPcgmb3dTbVh3nt2gRYyV5gIDDErBiCe1sV5G6qOlHxDWk37qlUnw7lu
	 FJ3fEffiYuF6ayJzcHaD8O8926641AGh4NPjPPrzEVu1H+VV6ohZ/AebLwdgCwXsEh
	 vf3sjc9XiKQj6qo8L9fBWJuEtvH1hydqYxQKJHl1ocdcTslLt2fNqIghn2mVIf3w4V
	 d6wwLB32viEWEp2UD7u9I11kxqoXmlxmM8yE3k9fFNVmUlqwTtWWzbyj11xGwIKG12
	 FI20EBNP1Mg3zaxhhujVB+Vxr/iPwtaoGL/s2XIBoZnUCy9/KdX0ZXltTWlkPbCAb/
	 uG7YiwNnqO7EA==
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
Date: Tue, 18 Jun 2024 08:37:32 -0400
Message-ID: <20240618123831.3302346-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
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


