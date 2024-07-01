Return-Path: <linux-wireless+bounces-9738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD7F91D55C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A07FB20E60
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C851C42;
	Mon,  1 Jul 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnr+JcxP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04A5382;
	Mon,  1 Jul 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792900; cv=none; b=tgqHiqKJOmjWPs03AH/qk4tjTn/rO4exVULgwtTtEyxcFhkRrAwJAFHFiC+qlCdL2AX68vB/ZfbR8NvJFrNeZLqH3+JqCglO8jYnX0IaJ7do4W9YRymn+nnMoMI+WPh7sOmaeuDZXVt/0Zgxvryxfi2JYdXZtqNeXh7tWp0+ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792900; c=relaxed/simple;
	bh=jWkqHQxtzhYZIeTqCuAdjrMMX4M1bB/KaFpYCUtCLE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fa3DoRJ3+FzpFezuoZWQu1aNp4W4+jmz9tD08qI6IrBZ7qo8JBe637lhs3lTkP8myzlwRDyKSL/ffUfgQiRpAwx6BVWnQfvuygM6JQvZ1IASZHAeCzggor1Zkn8tjxdyfSwyg21+F2P1EEOx+/DC67Qkc/Iy53BSbkvIWuKSNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnr+JcxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB6C2BD10;
	Mon,  1 Jul 2024 00:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792900;
	bh=jWkqHQxtzhYZIeTqCuAdjrMMX4M1bB/KaFpYCUtCLE8=;
	h=From:To:Cc:Subject:Date:From;
	b=Cnr+JcxPGcQfEwX4zgB1ZTiDbFRJfWCLlpaFv51511GY/OBxUCr3o6wNe0UsczgyB
	 LguhOEXzSvqDnLBPX2XjSlj2jeoa+Q5+eLJwcrxCkhm2ZNUUUKvlTGWbQXKsjfWAC4
	 oAbthoKxfH5YBB1loR+RzgIUPZCpsCbK0JqI/Qxkzx4DKPhmr5hoVh5gEOSH0tVPo8
	 55BVHUFDfCtnPuJs0RFbItA8BUpAjzMyNO3cbMm+DzkPkbP3/gxho/w2F3iLwEZQuP
	 HwWFqJoBCBOn8/g+BcBp5zcmULPbLzthIS3e5my7SrJInNCuAK+xtmQJMagKec1uXz
	 58A6kN0GSgH0Q==
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
Subject: [PATCH AUTOSEL 5.10 1/4] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:14:49 -0400
Message-ID: <20240701001457.2921445-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.220
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
index a6c289a61d30c..76a27b6d45d28 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2772,10 +2772,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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


