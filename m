Return-Path: <linux-wireless+bounces-9735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9962691D51D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511AB1F230CE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267A184A35;
	Mon,  1 Jul 2024 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlz9n7Mw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B83CA3;
	Mon,  1 Jul 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792828; cv=none; b=Y6Kf0ZRHbPshIeZ7fgpzrDqQiBNmPBml/vHpZoXGSzT8+/xvZcB+eJWqnxz0THreeCeSaD+UNwIG2BC6RQJUcpHXSffxyRe7zots8kuWAV15G9EhNbhjQxm5zbGF7phlkL2LWMq5pwNUV2i4aInpuJK2/LRUxie/Q/jIJPHYnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792828; c=relaxed/simple;
	bh=is8MCgPnmQklhkaN9/tSD2XXvi9ZMLQp3DHwWaEavts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYzYWhn1IHH2xl7+SGcyMm6YhROqMxHb/39aPhJaN2t3h6LiQDgXqSEnq5huYulkxrb6+76+QlHNOwAvJYDhjsWZ9UkLDqzHwMsprSNtiTsXHYGQgxf3UQwQtOi6OizL/PCwJbE4eHaQQfZVK1yetJ6B8/pPHXbxg2082MaM8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlz9n7Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A40C4AF0A;
	Mon,  1 Jul 2024 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792827;
	bh=is8MCgPnmQklhkaN9/tSD2XXvi9ZMLQp3DHwWaEavts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlz9n7Mw0ZhHkQp9FyXr1CYdI0mtgIo0zY1gWhf6BuQlmf3sgUSM797uXLqIfN7Ay
	 cnSKMZdyenzpXQw2cBbgmFQhtihUQyRraoser0NoYS/QngNNunxCZS31587yD7O7Uw
	 roqhStRw8/H0TbplATxWZYOVqL/UpDkWHrOD6e5mTCXQ+b4HONQ19cSFHk/AvcPhFN
	 6X3SYYteAYTTStrhX2yk0izAHCo4MfbuW3/o58m+0VxIPhkOjbEWd+EcGxof3vhT4s
	 nsszWY6GpiOLw1LIJjMCSy89CbJzSDl63AWtu9AxHA407JF0A0cvzj/212P10mNaBv
	 Q2DVeOQ1BKAbQ==
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
Subject: [PATCH AUTOSEL 6.6 02/12] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:13:21 -0400
Message-ID: <20240701001342.2920907-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
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
index c646094a5fc47..af81cf81f68ff 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3163,10 +3163,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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


