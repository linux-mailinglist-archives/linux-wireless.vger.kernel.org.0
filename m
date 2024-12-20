Return-Path: <linux-wireless+bounces-16651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA19F9789
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3757A2F2E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36921C9F2;
	Fri, 20 Dec 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4NUTpkF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DB21C9E3;
	Fri, 20 Dec 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714697; cv=none; b=gk9jSOfd5SG5w1kM4wFIojJ6z3F8txOd0fjFFd0HBbKIV8eLPY/dbx5lejbDpc34A3wrENLJb9sP8w6ckapPeTkK7fNRBHDfgKSd+/SMoUV4dzSu6kfFtuJfdRa8CZqCRFLVctXCvDeWVGXLvHceDm9BGAPAV9RhfUn3/sTYlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714697; c=relaxed/simple;
	bh=uisoTbrZB5Ys2OPjmjLgIFWxK/uTzX+73PPJu79PXI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHFU54srFyT0khrtSea26DzBsPfXZex2Sz9ch7p7dNR//tViL9GRgt9Xb6IRA/KYtdJ1Zx4Zj+OXcLHDwoCoTzN9zGIPRPWab0+MINzt6ODz1jm49J10hGQ/1kiJRSjHBV0GPJ3ZN+Zndyoifsmr/WuYOg1PzmOy8ZAkXiTl60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4NUTpkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E54C4CED7;
	Fri, 20 Dec 2024 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714697;
	bh=uisoTbrZB5Ys2OPjmjLgIFWxK/uTzX+73PPJu79PXI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4NUTpkFQJY4GBbBjov0iID073mre27aYqzOrs647+yz0mwFxIDDtQ/u/lUpissI1
	 KJmeI84TRAp5td4DCrvBcHsIu030QlAotP3UsljqjYsb/csOLdG+lufEkxu5ZvLCdj
	 FZuDPfL7zP+plxwZUIonDrEz6EPfKR7BFz5hwZxnyBrQrs+RXxeqEvOaz/2WizaobV
	 XX3q0oFPycIdaQouTtpH5TqNwW3j2QxH0SMSfMq3uSakvkcustUB6KAQfy1y5utQDD
	 rx8X7z4HnR2iYyTBzMKrVLdZl+yLMUW0TB57AZvy6gA/O7nzSHumabPUZMjZjUmGu7
	 ME5klZmwqh3zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/29] wifi: mac80211: wake the queues in case of failure in resume
Date: Fri, 20 Dec 2024 12:11:05 -0500
Message-Id: <20241220171130.511389-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
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
index f94faa86ba8a..9f96c4dc037a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1842,6 +1842,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
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


