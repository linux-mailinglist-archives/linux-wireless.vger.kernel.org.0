Return-Path: <linux-wireless+bounces-16655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD319F9814
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213C97A27A9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C932343C7;
	Fri, 20 Dec 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWrPVZiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFE1A01BD;
	Fri, 20 Dec 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714830; cv=none; b=ccpVolMbq9bo4tuXD4iu8jzfLKViaNy7FYE3ZwveweBFjQWNZSaAwxkSH4kC4DivFml+zZyEp1plYpSYR31g9IIrGfrDYGcIwD7DMoLwCNC5+5zFvhOsaiU4PDtKOtNo/lqqIUuWvHBkwQusoqYMdhOWQGeNU0ZJJcuNK+87B/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714830; c=relaxed/simple;
	bh=7/ky7wjBDGDXL74FY0a86N3C6OqFGMhTWisUfsrZ5YU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGopepukUzwZBkS3zPNemnfqprol1eZJQgkaAfI6ooMOI5hX+YYVhRWc8UCtuHZdfr41jrIq4JQs/kbh05m2Z9EmCGGek4084XDgc5D1QIVRW1HdEHzF2TyFJdJJV2gJLlGGh/eZlK1iGecfXaaE2Iz2gn95agwtSm3YW/LRlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWrPVZiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1183C4CECD;
	Fri, 20 Dec 2024 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714829;
	bh=7/ky7wjBDGDXL74FY0a86N3C6OqFGMhTWisUfsrZ5YU=;
	h=From:To:Cc:Subject:Date:From;
	b=TWrPVZiT1U/ZwRCnsFXLYZq9OX1GaxpwzCWjFQFkmEonPPRcBPHBDik1vuNuz5RPk
	 JXyXtwn62JtfdV1gIVvxxI/vfUPam6Tbx0LwRnWZzfXGPVUmVoJ4WMxMfoL31wLO5A
	 XT6qhyeQ4jAFt53pcueg3B8ipVcV02NgoI65FCI5BMATc2wvSw8OoW2C8yyo4ZEUA7
	 4QcfHph5P6bXDwARJXF3NgCJl5Udqt/xPpJYob1w0C5FhEHgSjQP985C4G5Dkda8Gc
	 NUOCxPc6eHzoHaPyLx+XP0d+K3gLsRE7T2k4N7l8dy531uFp1bxFXymSdKjAAnmASC
	 JwVbFZg9W4ljQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/9] wifi: mac80211: wake the queues in case of failure in resume
Date: Fri, 20 Dec 2024 12:13:39 -0500
Message-Id: <20241220171347.512287-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
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
index 85d3d2034d43..cc78d3cba45e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2374,6 +2374,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
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


