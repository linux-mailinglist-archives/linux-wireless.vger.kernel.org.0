Return-Path: <linux-wireless+bounces-10576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6E93E2F5
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B86280D0C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79ED14038F;
	Sun, 28 Jul 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCBkipYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5413F441;
	Sun, 28 Jul 2024 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128126; cv=none; b=hKQRyoHHfJSiYiO4hSJnMUIORUPbd+twoz9BeTjVJvhC2Y/nopK7J1gHZNbVOD+zzuAqOUfuZ9dU7Q/CodB2wrXXopurUyeL3hxMjUQ526PpbJ+ijLCRJR8hNSptanJCsQEQMZn/mi4eeb1GVACCyzvCofcKCqDm6hBhuXQOFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128126; c=relaxed/simple;
	bh=kqV6iCppqkmKongtimN3/Grb4cO3fi2gMcCh4ULijZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijR4nJZ1Obvy/WiFCeQGrvot7o23kZY8kIXKmRf/1DuRVR6BvaFJganJgup6mP1pK1/7op7LWifPWI3tk+eUY8rOhuO0bLAnEDGJqKd5U/BndzQT6ezgR12+ytIEheTPGmNq7NAf1MMRFxMomtT+WeA+WrqvqcT7Zkvhhf6JOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCBkipYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052D5C32781;
	Sun, 28 Jul 2024 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128125;
	bh=kqV6iCppqkmKongtimN3/Grb4cO3fi2gMcCh4ULijZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=JCBkipYwLHjmJDM5O0ZDmnQnoD2nvu9a9t5IPy/l/hddoajhSRk40pEwWU7WOEV2W
	 knRLhBFCM47C1DHOFfOiNEPfO6GWDk1K3ZM2KwEuqLXmhqzQ5p0l8dRjQNTLvN9IUc
	 mbMa9Y/V9pysmFhoyOg5fcKa+WbaeWbIvn1iUsC9xseekHdVoIcqRrNeR26yEhRTAV
	 P208kHnY9ESc8ltx5Ewqt6vuH9Qz1L2AmlsUKsw2/ydiEmi9uxaOHP92+pnGwULRNd
	 LuO0X84bSbB3dJchGjU+3ZX9xtMvmGfBS0yYwOzweWVoAmW9l5bLYswhbOX0lJDDnW
	 ML6ZHWBp6YlaQ==
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
Subject: [PATCH AUTOSEL 6.1 01/11] wifi: nl80211: disallow setting special AP channel widths
Date: Sat, 27 Jul 2024 20:55:06 -0400
Message-ID: <20240728005522.1731999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index a00df7b89ca86..603fcd921bd22 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3346,6 +3346,33 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
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


