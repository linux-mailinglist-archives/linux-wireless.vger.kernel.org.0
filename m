Return-Path: <linux-wireless+bounces-10566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D943C93E266
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168871C20CA2
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3946FD5;
	Sun, 28 Jul 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncN6SMDb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C5B647;
	Sun, 28 Jul 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128013; cv=none; b=q7FXPUE0dhD37KjocrZWn8ZChGo51SssNqxBJtY22p+eLUQ5/0HQ9yPyUCQaAwjqytTGfwsw7k4CXugObPk2Eg/w+COvBaDisC9vTPJF9i0D1ACRe2/4WlriuTk54Sfe7RRrmpm3cAhvRiL8d/PJKZ7fmPQoEHlmdEzmNpng3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128013; c=relaxed/simple;
	bh=c/ylGyDBTGC8cJxP38BzVvzNxAC5zQpdDkTVkqP6Uks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMFgXN63q/acTtf311lyD4WTNg96FMCpA+3LS2YBNjCUEV8K5bEz7LMFiEhzWO/iFFAJJRCxUjnAFOpGfRKyO0Og+haPwqWMyWS3+eZGO1dnJ5jXvFbVSLiiX10ggByYI7ymNqbzATurL9J959ENEa1NR8zT5hqahwb5lHKj/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncN6SMDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEE9C32781;
	Sun, 28 Jul 2024 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128012;
	bh=c/ylGyDBTGC8cJxP38BzVvzNxAC5zQpdDkTVkqP6Uks=;
	h=From:To:Cc:Subject:Date:From;
	b=ncN6SMDbizgOgj+WTIeqZntLf61iZp8ltGO43SAS0GtR6YqZtdSTZnK8x5lBVv/au
	 X0c3CyzFe1U+fS0Fk2yA2mmtcAiVrXo86seEkYOarruWGw/JccUsHXdveZ8PTIDdjA
	 vYN4CSHq+S+15fZ4gS0cxN7uC8/wlV4Q3G8nkOxJuLez8GvAEd2WmSGw9Fy/tSoP0j
	 1iD/ETyADrcqpLIRuPcI01QRXj3I2eWBZ4hUNnTDa4w8di6SwZAKWeC0PKX1bUYrlM
	 GHMaMI9wwpzr2ewciyDQ0DWTMYVCjI23E4+pwXvAFIW5BGUCFJj96LSeHJrsdkG27f
	 A1DP9PuEdx8xQ==
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
Subject: [PATCH AUTOSEL 6.10 01/27] wifi: nl80211: disallow setting special AP channel widths
Date: Sat, 27 Jul 2024 20:52:44 -0400
Message-ID: <20240728005329.1723272-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 72c7bf5585816..81d5bf186180f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3419,6 +3419,33 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
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


