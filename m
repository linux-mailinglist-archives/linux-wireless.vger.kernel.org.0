Return-Path: <linux-wireless+bounces-9739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE691D567
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB761C20A6D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B107CF34;
	Mon,  1 Jul 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4jVek6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08863D5;
	Mon,  1 Jul 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792917; cv=none; b=RygLPHY6P0Ial9fEd3en4dog+oGaeNYj0K6SGHJH8mt4rnnJXLSVtRDMHlM2fUMaEHrl1eGyBniE9DFUJXvbE4tQADUhbo4rY1D0yaoM+gLUliO57426JP4Ci5QfJyynO34KXtoiZEoH99DKouXFCij8C9qXx/sDomGjqJEMekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792917; c=relaxed/simple;
	bh=vJpI8tTF5x8556rUfU1x4T6wxPqleIZgs4thDPai1EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQVCtvKsdO9YoC3CzcoKHF+Sqf0xlTDgWYlCitY6rcaWvUxBz6UTwnpxv7J16jZaOBUrgNHrh4ajMGAMm/95TO+R4KgN7OXad1bBQifm+dE1j5mb8AZFuR7YQ7m3/0ybP4BnbmZ16LZvP8q6XwqbcQgEj+LDYicjpyFin/UruAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4jVek6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F301C2BD10;
	Mon,  1 Jul 2024 00:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792917;
	bh=vJpI8tTF5x8556rUfU1x4T6wxPqleIZgs4thDPai1EI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z4jVek6LgLLodIhjnyYyt6CyO9qU8ZOjevIP6O36D4xT9L+PrAF7S/t/8TL4E5hMq
	 exe2RHpcnJIbtLL8W5Q2KA4xnRSpJJvVeQSVgl31h/4tNEt6HtfaHxwLewk50RvStV
	 4H13FAq0UYfs3Vs9VbjR9jyJFZFtq4wEkfdQSyzaNsCogcGaiQLXHSfNuWhNyv8iZc
	 6sxYaNVPspdX9psQ5rwfzVOpwXnAe+MPqx2rC/dndepANjSOpZS8xAiRfYtHyKJ2dH
	 4yiFrxcH5uSyQxnGen2iDoecv4v5HTG34Y1DVo+meuvvkfO3lVBcgkFQzKp1FXXi+I
	 NpD7po37IJkzQ==
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
Subject: [PATCH AUTOSEL 5.4 1/4] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:15:06 -0400
Message-ID: <20240701001514.2921545-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
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
index a1c53d4b6711b..c74882e3c3096 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2212,10 +2212,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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


