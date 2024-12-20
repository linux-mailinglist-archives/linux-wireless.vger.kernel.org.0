Return-Path: <linux-wireless+bounces-16656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315A9F982A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8474F7A2F9A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E9236FB3;
	Fri, 20 Dec 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaBLcmtG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDB236FAF;
	Fri, 20 Dec 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714849; cv=none; b=QwvlXDlGwi4LguxMMt9FgYGzqGsh5+2RB14XFFwOP3YPMyucDFlcxH3chPZYcGjWcClG562y5zjUfiE8JdW0EGPLHPgHPXcgrnJ12tmky0RytfYg03pdwnh0sWHOrR+Tj4oVlT49meDR26neg/9RRZE/h+D4EeeCHPx/gnRia8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714849; c=relaxed/simple;
	bh=9VHLcpfvfznCFcTQ3pZtm1AnGra7mSMg9J9I1z0KgQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dm3/bIu8dOd4t69Aybtd9iuzW5+hAHenHHkw9zTWUGkNnzQAutsSnCZbRqOGjNaKhVSCRrbDjYLAmXPl95BfwERlWc0+ED3Mk6K7JM/wpQ9/iDsg4wCVo7Rh9c9WctPzhDUuvtKiziADDxpzw1H+yziDagZpQ8ws/CneSKTuv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaBLcmtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22179C4CED7;
	Fri, 20 Dec 2024 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714849;
	bh=9VHLcpfvfznCFcTQ3pZtm1AnGra7mSMg9J9I1z0KgQs=;
	h=From:To:Cc:Subject:Date:From;
	b=SaBLcmtGs870reUtS+0O2wp+zwL8ejPS7qDm+04mrQ5UefnSVwSGfD0ZXOXITBHmW
	 tU6jehMZyGBjkNyrW+ZJN9wLCOlIQoB/JEp/imajBtYNQ07u1xPvld5oTLXREhr5H/
	 A6f5VeRjB7VYED+ERGtSEI9qUH3wYzGhrp86oVKRyeL4rWzUAD/jjkkfcF821cGTQ+
	 A2oo+ke0yaUcJhuhNqwwGK8D3FpJhgIp3Srqarr8KsmxrdVbCACSJ3kdS+XDnDG4Zd
	 r+/BbB9REWGBVdB41Jg0kYEQILWKyjS+ydUAjXrT5h6MmI5LicCzgSeVAVH9/EtNnh
	 MCU3rW9rNQaVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/7] wifi: mac80211: wake the queues in case of failure in resume
Date: Fri, 20 Dec 2024 12:14:00 -0500
Message-Id: <20241220171406.512413-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.232
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 220bf000530f9b1114fa2a1022a871c7ce8a0b38 ]

In case we fail to resume, we'll WARN with
"Hardware became unavailable during restart." and we'll wait until user
space does something. It'll typically bring the interface down and up to
recover. This won't work though because the queues are still stopped on
IEEE80211_QUEUE_STOP_REASON_SUSPEND reason.
Make sure we clear that reason so that we give a chance to the recovery
to succeed.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219447
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20241119173108.cd628f560f97.I76a15fdb92de450e5329940125f3c58916be3942@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e49355cbb1ce..0da845d9d486 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2351,6 +2351,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN(1, "Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.\n");
 		else
 			WARN(1, "Hardware became unavailable during restart.\n");
+		ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
+						IEEE80211_QUEUE_STOP_REASON_SUSPEND,
+						false);
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
-- 
2.39.5


