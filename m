Return-Path: <linux-wireless+bounces-9153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B190CBF1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692261C232ED
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FCC1553A0;
	Tue, 18 Jun 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK5dw6Cq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6813BAD9;
	Tue, 18 Jun 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714199; cv=none; b=LwOaAx0zc80/1oTG0TJQshnXqwyhanB58/GFkkMZ5+JbO2RfGcgCIked1bEvZzSBaND/gQccr4sESROS9TGxs9oBrpqd8TcU/1ST9QwMQY2LVcvIUx11nJdyDJ2UTJYO7PYphYBlw5tFlTpesdrF5EcvJP5i/QTE9X15Zg9x8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714199; c=relaxed/simple;
	bh=8kabB6EPxtK6Zz3PjFOMHndCUHRvwX1PEvmDCfVfmw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2lfrY+BD0zAI2jb2edgjMgeV7qDk2TtwkiActe/6wzafOJl4i2n1u5ZhdqI1uNU6+1AqSy5+XjMz/MPaLLrdoUUjjlwhH+oswT64rJANbZQZoLJt9OVUY5Wf+I5zs+6AKvhR8YnvpjnNMXvyrHZhoiKkvW0L48vHSCPhIpHyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK5dw6Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85509C4AF49;
	Tue, 18 Jun 2024 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714198;
	bh=8kabB6EPxtK6Zz3PjFOMHndCUHRvwX1PEvmDCfVfmw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tK5dw6Cq1nndVcCHDSymNWfMrpP7H7pug4PmhTwq/79cVzSov0FJ+L9IM9f1yhKDo
	 xRXSbBvNC/kz9NmwHTEaq0vFtrXhh1jp6hwIpSgMWgpUtQsE0/oShVH/ClZS+d+8gd
	 cqSKy3Zdykk4NPzdovzlxEUNhObiG0c6WD0OLcQnjIuXqM/qahEzRDjS1WzpfVxOew
	 n6FRmAa60xPMC/gD3I5JK5EiOsDGMZVo5llKzZbB9qcAmSgD7XYotP7CvhxbE+GZbO
	 iAnR6x3AfzI0iWWSvlLkSmmXwrnaD3BBbNSgiae7CLlmFAw5zrwoHw6GS5Q5WydC1u
	 RII7I/TV4kvxg==
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
Date: Tue, 18 Jun 2024 08:34:56 -0400
Message-ID: <20240618123611.3301370-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
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


