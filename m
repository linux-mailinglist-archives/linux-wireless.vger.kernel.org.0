Return-Path: <linux-wireless+bounces-9737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABB91D54D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3173B1F24DB7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC54C6B;
	Mon,  1 Jul 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9QAY0MQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B74A07;
	Mon,  1 Jul 2024 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792882; cv=none; b=EhFyMV5bd1uh93kS6yl1s3/3WnTGMydbxJUBfxVyrtiwaoCHm+uanDgyUJMS0wE8HA5/OkU9wniEZljL6d8hXhpf41U4uLetj17n2t0MP30e5KvBybxf+HlYBUj/PfeWzze87A2wb+8FZ/jVI43o9pJgSuJ0ANVLO11Ow/Xl9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792882; c=relaxed/simple;
	bh=Q4EBs0UeNiowPayuH2ixLZ0K3jSQYRgZGN00yMuPIYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dP/QxZCkSXesm1f9DTPBlYefdl+u2d4m5G738UDXWZldzo7lbLnTYlGECGhWM0t5GhBkCQubfA3C2fy5+16Q9yFJql9F8IhPmjD8RbwgsRJtuUd+esE1akx9JspYGWUNDR0XHPYO23knB3Dv0xoTJSTSiYIxqoXeuXFw460ItHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9QAY0MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B08C2BD10;
	Mon,  1 Jul 2024 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792881;
	bh=Q4EBs0UeNiowPayuH2ixLZ0K3jSQYRgZGN00yMuPIYw=;
	h=From:To:Cc:Subject:Date:From;
	b=m9QAY0MQ1VlQdDWJELoGHqURGa3Wegqhpc8cDFLRBqUjr7y6O0hIjTWhCZ66xKtfp
	 ZO9thhAii5jzRfeQ3pFeqQuWItd61QBbmrUTvIUWbENkQHoexljbq4/Z01qXlyA50P
	 PdU9Cg0LRi5++/5bqEZDEdvbv/Si49Z5zk4UIjsf9Y0aXruHD4XyAlU7efVQXpDmzc
	 4OdSZUrMuA5fFH36BRPcIlFPxyeWPzP6E7ToySe8zW5hFj6dbih6gZLiivhEw8pRDm
	 h5HEkOFxaluQhi1KHBq0rl44ZebrghmS7pQZiRxIEBDunyDKl5fr8YZPRdxoFCml4x
	 OnZ5Uep7q5V9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/5] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:14:29 -0400
Message-ID: <20240701001438.2921324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 6ef09cdc5ba0f93826c09d810c141a8d103a80fc ]

In 'cfg80211_wext_siwscan()', add extra check whether number of
channels passed via 'ioctl(sock, SIOCSIWSCAN, ...)' doesn't exceed
IW_MAX_FREQUENCIES and reject invalid request with -EINVAL otherwise.

Reported-by: syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=253cd2d2491df77c93ac
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://msgid.link/20240531032010.451295-1-dmantipov@yandex.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2898df10a72ae..a444eb84d621e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2782,10 +2782,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	wiphy = &rdev->wiphy;
 
 	/* Determine number of channels, needed to allocate creq */
-	if (wreq && wreq->num_channels)
+	if (wreq && wreq->num_channels) {
+		/* Passed from userspace so should be checked */
+		if (unlikely(wreq->num_channels > IW_MAX_FREQUENCIES))
+			return -EINVAL;
 		n_channels = wreq->num_channels;
-	else
+	} else {
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
+	}
 
 	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
 		       n_channels * sizeof(void *),
-- 
2.43.0


