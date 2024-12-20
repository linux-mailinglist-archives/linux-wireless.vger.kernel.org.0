Return-Path: <linux-wireless+bounces-16657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5790A9F9849
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB39162D78
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8B23A18D;
	Fri, 20 Dec 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ1P5c8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93523A1B7;
	Fri, 20 Dec 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714863; cv=none; b=BXC1kOUHuWJtaPXsJsLNhKhBpwBZxQEPkO20N0outy9BeuMNci9Ww2JRcQHbO/lK99BWnNetjpR57JDW4Ar83/XIh3q6Khhr8+/FuMND4qvO6n++NtFe6jI6CZMbyrgsjA3f6saMG+kdZZfoofj15sNqSPfsyul9gWRvQKFomxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714863; c=relaxed/simple;
	bh=7bJtG8AhoTYudM19HcUmlXvNCViYljPNQhacxOceofs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=opLtdX/5CfoEidVlAObsVRhj7C0EsoWDpAGr8iv84u+w3dY3Rigc/y5Fp9swPuwirky1bhkF+rbYRhfCL0DOprSfSrqHzp705Vf8gPsXHij2EaVkivMJqpbwSGUszfXNWgu8PCt/lKlG4ExpJzX7cv+UD7gAJKygiBZJavyMTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ1P5c8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC790C4CECD;
	Fri, 20 Dec 2024 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714862;
	bh=7bJtG8AhoTYudM19HcUmlXvNCViYljPNQhacxOceofs=;
	h=From:To:Cc:Subject:Date:From;
	b=iZ1P5c8pFiq7S4nr65xnEeFg7ZOAp3KsY4b9KAjcn19a+7YQ17s8tB3tmZBNg/Zgy
	 nN86uGo7xz6YuUAiVoS/sToqWhs2nfDxZkcxLk5S2xC1MUVM6B+rR3I/w3yErF94ti
	 OhDAmHJ28XrdKZfd+eo0I6XZiOH9xCz5iMruM8Sv3KgZGQIuXS6foxU/FYYru7H0K8
	 lA/dwHkuXNHOfYm55QrLTDHH085i4Q8x7yoHy8dnda9W1EzGIRQxxYZtwyXy+1wIec
	 m/VONlC9I6XPBZftEnjGOF5/aawl++S5nEY4nn7ZxZVQ0RXoicMZgv/dN5TAG7T+5o
	 6iQz6siZ1OOVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/6] wifi: mac80211: wake the queues in case of failure in resume
Date: Fri, 20 Dec 2024 12:14:15 -0500
Message-Id: <20241220171420.512513-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.288
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
index 63b66fd0a1ce..515fe1d539b4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2209,6 +2209,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
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


