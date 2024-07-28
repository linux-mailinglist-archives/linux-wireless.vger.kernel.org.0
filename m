Return-Path: <linux-wireless+bounces-10573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E793E2C1
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EA81C204D6
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F712FB37;
	Sun, 28 Jul 2024 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBmhmVeK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7684D0F;
	Sun, 28 Jul 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128085; cv=none; b=XMH7yxpPwuIxbiFD47yd2P0aoryhKu2s4BikfDagWUktZy6BnP1ZPCBr1jJl29B31KnCIThsi4GG9rUFgebbfN+/4DPNwKYbLZjrlLI10W8pd+GlxsuNShTIJT/fRoiK9ydt4IiofIfuvPViuqv5ussziNpErv11kEkdpncjbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128085; c=relaxed/simple;
	bh=nn3Yfax6uInX6pXIz+7wPnAw0wc2sIdXqFpMY30YWcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1YGOjEoJq+BRJ4wJbJVAfmbvsEGQ6BedqYACBr3sNORr7eGm3whRClUgnf7Bdw3MmbOJ7sJOrWfqVZhKA/V2F63yYA8kQBXgWPR3v/kYLH2CcN7AyaKvJWs9yBbghTflhBdqOhuxspl3LGL5Oe7M6XWdGq7qVHQJMhbfOJvQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBmhmVeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47925C32781;
	Sun, 28 Jul 2024 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128085;
	bh=nn3Yfax6uInX6pXIz+7wPnAw0wc2sIdXqFpMY30YWcU=;
	h=From:To:Cc:Subject:Date:From;
	b=aBmhmVeKBKSsWewYwjSST1pfJAoKIT3IBFgSrnEIQzBrzqAPgMkuoAc1G6iyAPjx9
	 cCbZwv3m5ipKNJM15S2YC5B0Zyyz5muvJ0oiqkxXjYgpThaEo7IvtkUJqlJrn04lxM
	 uZUt71Qt6H/J88w5ceCVs5iO4qY0YfNXis98R9OsAjJyYiOUlVTfPTQM0xwEdeUQ3/
	 LogXEhjUzEnV4EqE4n/PvSFxYzW2Jm311as4fwJjrGMQU6xDtwZ4r/mpU90c9Es1NR
	 Qs3PT+sBEJYJFxa1oWvKGK5oZNF2EGd4EDL+E4cTqgey+pzvUaSsosKJjsRIKm/Obp
	 WXklKW3ZlRKNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+bc0f5b92cc7091f45fb6@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/15] wifi: nl80211: disallow setting special AP channel widths
Date: Sat, 27 Jul 2024 20:54:22 -0400
Message-ID: <20240728005442.1729384-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 23daf1b4c91db9b26f8425cc7039cf96d22ccbfe ]

Setting the AP channel width is meant for use with the normal
20/40/... MHz channel width progression, and switching around
in S1G or narrow channels isn't supported. Disallow that.

Reported-by: syzbot+bc0f5b92cc7091f45fb6@syzkaller.appspotmail.com
Link: https://msgid.link/20240515141600.d4a9590bfe32.I19a32d60097e81b527eafe6b0924f6c5fbb2dc45@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8f8f077e6cd40..053258b4e28d2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3398,6 +3398,33 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 			if (chandef.chan != cur_chan)
 				return -EBUSY;
 
+			/* only allow this for regular channel widths */
+			switch (wdev->links[link_id].ap.chandef.width) {
+			case NL80211_CHAN_WIDTH_20_NOHT:
+			case NL80211_CHAN_WIDTH_20:
+			case NL80211_CHAN_WIDTH_40:
+			case NL80211_CHAN_WIDTH_80:
+			case NL80211_CHAN_WIDTH_80P80:
+			case NL80211_CHAN_WIDTH_160:
+			case NL80211_CHAN_WIDTH_320:
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			switch (chandef.width) {
+			case NL80211_CHAN_WIDTH_20_NOHT:
+			case NL80211_CHAN_WIDTH_20:
+			case NL80211_CHAN_WIDTH_40:
+			case NL80211_CHAN_WIDTH_80:
+			case NL80211_CHAN_WIDTH_80P80:
+			case NL80211_CHAN_WIDTH_160:
+			case NL80211_CHAN_WIDTH_320:
+				break;
+			default:
+				return -EINVAL;
+			}
+
 			result = rdev_set_ap_chanwidth(rdev, dev, link_id,
 						       &chandef);
 			if (result)
-- 
2.43.0


