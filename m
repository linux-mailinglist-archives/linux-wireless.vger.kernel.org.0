Return-Path: <linux-wireless+bounces-9740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E487F91D574
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 02:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3541F21649
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 00:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9715E5C2;
	Mon,  1 Jul 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRCj+a/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0815E5B5;
	Mon,  1 Jul 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792929; cv=none; b=JpSdipjGi3NsaVucyWgqX/E7lzwq09bY792V+5usYL4wpx345ipP+Goy2JL7ABIJa3lGuN2ydfJxKbRl92rdyKWGv6y601sjvCeDbPPbNDjJWajZVweSyld7jT2PWPmMJQzXF8CysWxMuxJYADAqxvYrfOZSZ7E8k/h3vfdz0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792929; c=relaxed/simple;
	bh=bOqZL3nocXZv75amT86xjTri92MhjmQSpmYnYvlqLlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=on7bwgLKIjAiGEq9/Jw5Xu/hfYnEgRWlCsxhlG6dTGx/gMPmkNON/b8AkZUCTiFnymQE3JhuKNf3JoIuS23rd87O8R5c5iEFmI9oR+jPutgLw8RyylwSvQ7PQ/X10VMMIh8zuG03o1Sd12DzG05NtXWIRaPQjaVfvuNKkPUbv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRCj+a/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CC7C2BD10;
	Mon,  1 Jul 2024 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792929;
	bh=bOqZL3nocXZv75amT86xjTri92MhjmQSpmYnYvlqLlk=;
	h=From:To:Cc:Subject:Date:From;
	b=cRCj+a/oiksTQSL04gxtQ84xzqzD75dfXC0nzNApNy+mkIiJZE1BhQrmfpKUd3omr
	 kb4YKnEuNgrNqTxBDfG+kR3k5M1BPbokHTGuIs6jA/JF1FCUfYhSs15l4Shr5B5t2g
	 qHEvrNG08y7hq0/bPQJVcY4BGIOiPvq6ufHQjTnI5C9vxHJlWQ+UCBOTiZYkC4wItb
	 B15whA3h4t2HkQBAOZ9Ke3rFw5fyiXShG2fgNlRw4JvicwFfic4xSNNcpXTSjuKXNC
	 sBgrkHC975UVj/9vM64csFpdauZBVYyOuZ/jHpwxTse2CwYFpH5jtzIiJUeDtdSzKT
	 v4YTkP0SYEWkg==
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
Subject: [PATCH AUTOSEL 4.19] wifi: cfg80211: wext: add extra SIOCSIWSCAN data check
Date: Sun, 30 Jun 2024 20:15:26 -0400
Message-ID: <20240701001526.2921645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
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
index dacb9ceee3efd..0dc27703443c8 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1405,10 +1405,14 @@ int cfg80211_wext_siwscan(struct net_device *dev,
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


