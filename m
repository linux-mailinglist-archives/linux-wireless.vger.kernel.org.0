Return-Path: <linux-wireless+bounces-9736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E695491D540
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51CA2812DE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2A36126;
	Mon,  1 Jul 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KselPOfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7302B9BF;
	Mon,  1 Jul 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792863; cv=none; b=mY5QS0rN+q8hXqPUGJ623kJ0vmEcStz54jIvIx/A9wNvERqmgbp6Uj2J9DaJl8aBaNqtTBF9VYIC1dV/Yyv1vBlEkjVyVspUKEoroNYr6pF7sHY5VmahlX35u4EeaKZ8S95uS4pSUA2vk//QppvkIzYOwovaGT1HmHAyWwSDn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792863; c=relaxed/simple;
	bh=bpn8xa9Qt4rj7xl0HBtt/5P8WNcngqRYA9KlFcjM1Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hV21pYzNpIrtzd9ZZWFWMw3b+lRt/9mjf81dyAXIq5gxwwpfg6XOiaoK4b05IzpAkW9mJp0hNAAIwjA5eV4Nt8kcSqApx4g+AnAqkq31RBE9bv7DkVc0yO21WMu0tiypOZzDQZUuTXHAUP342Syg4n94/94dvSFdHhZYiKuyfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KselPOfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B575C2BD10;
	Mon,  1 Jul 2024 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792863;
	bh=bpn8xa9Qt4rj7xl0HBtt/5P8WNcngqRYA9KlFcjM1Ys=;
	h=From:To:Cc:Subject:Date:From;
	b=KselPOfWFptrsS71QfPtBdxkq5iduAq4mn/l6/DbGVYiMEBfbycBFRIlRQZx/ySo3
	 AjHEiKVNuxNsRKBiOR0hbc1ciw1LlSDrdtuC4NnpV+etk+iQ2sqBqiWb7je2XPC43m
	 oF/3B0aa5/4GXv6PCc2AsNUe9ddegySILSQbznM0Yc7bfifcndqJyxtTZP2wjTTp1l
	 PvHM6evsiDxB8aOsfbBKX3+/ptU+lfqyA4Jk2uxHrc0Nc6TyxgjS1KbIiPSAbdGFMv
	 qqXt8+tcPYbpLL4FSs8s9t1XK+W483YcQDROs2OoRVwZlLtG08RjzOJ/Ztsj31mXRH
	 mGd48y3GVzFTQ==
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
Subject: [PATCH AUTOSEL 6.1 1/5] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:14:11 -0400
Message-ID: <20240701001420.2921203-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.96
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
index 3ad4c1032c038..68c9f658ce385 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2704,10 +2704,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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


