Return-Path: <linux-wireless+bounces-9733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A9B91D4D8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61361F21124
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF210F9;
	Mon,  1 Jul 2024 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLq1pMLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7329AB;
	Mon,  1 Jul 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792734; cv=none; b=Xs8eNeJ/UP1uF5GLjTYsm+YxWp6q+IXpeonLXsqOnEt+iPdYCYMKmdTIW7U2PqpCkWZQ7OUBoCwWpNtsrQTqCWXliTZyvm4cWiiyTn/+DXAL1xt8uBlM+pdpCxsi3JFEyKMYI56rsqW8zEJvSMK9SLXQctMWo+MtsTt8XHXGbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792734; c=relaxed/simple;
	bh=R2bT5Xe2ba+Nx+hbAaUxNkqWy6reDs+YMC/nS+m3WLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/lj/fCagb7A5RYmVtCttIBVANjbq4r7L8LfATv5EwU6l8I5NNewXcOdeus4oB39xM3VqBUo6rT/6BxW54m8/QH9UvAnzrfUasR/yzxC35Z0aFuf04Oxsw4pW7TT35kK8DbWHUHCxUylwZ+EOdEshlaGKN94vDEyIlPJEoRRl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLq1pMLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D69C32786;
	Mon,  1 Jul 2024 00:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792734;
	bh=R2bT5Xe2ba+Nx+hbAaUxNkqWy6reDs+YMC/nS+m3WLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLq1pMLDIXi37zmaBysGlzL5oOYif/pP0y7fj4qLjuvut4GOKxCGO+PB99pClOcuM
	 qo2XBkbO7GgCsDutOPseCuiXp7NDMSoDcGSsFha5nvJQ41xkw2FhsOXkUlvMIOn7UL
	 Scy4M16rOf2pVE9iDj6YRKbx9k0wun6+Yfm9fl7ykcpllECpki8VcmBgj7ZLFcEyRB
	 9pXwvS2P0ZmnOigS59miBlUMF4TW0wyFWNzBwuNO393dCiYR2eY71Ag4In/XLGyOuD
	 sZ54Z15C0tKgfh3R4vIZ2Er/wvXnUcN2c2y8h32O7FuIBHzM2ROiat6xBCSEWC3BUg
	 z1izZWHnKh+Wg==
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
Subject: [PATCH AUTOSEL 6.9 02/20] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:11:07 -0400
Message-ID: <20240701001209.2920293-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
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
index ecea8c08e2701..43eb77b4d2a67 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3396,10 +3396,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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


