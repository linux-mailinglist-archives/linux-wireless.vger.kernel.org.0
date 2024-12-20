Return-Path: <linux-wireless+bounces-16654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA39F97EE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6E57A27DC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A8230988;
	Fri, 20 Dec 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCZb/gl3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA68230984;
	Fri, 20 Dec 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714800; cv=none; b=EkrB1kA1McrfL9X8cO9XTYC0qOwxW09RnYywUoDL2uqWINCSPrhujL+hWyIrYaCd9+6kfVgIKJU0cY6Z8rQQTE+7U24BzWxRDkagOnRRkvG6acFRxayD+8sf1JK0gw4r0X7zIW2SDtht108omHMfik56/RVUbs1fHGHRpWD4+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714800; c=relaxed/simple;
	bh=kBtmxMQmmk01nRGleFCsIKpQsxjI3b4W+GcH87wpo9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EbDIcWXM8cxuUW/ujs5sowFS2cvmApVZez21dJ5tN42VR6ZIvNa55IFKdBPm7CYHrjLmglmVtJH1BCy13Lf+OkvJkaBNRhHdk/MnWHwTTJEb+SvsbuVTu2xGXiVslIaFFUZ1idqD21LmJtAuPNxAa1O4TKgsRXbF+N1hWdivXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCZb/gl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A4C4CECD;
	Fri, 20 Dec 2024 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714800;
	bh=kBtmxMQmmk01nRGleFCsIKpQsxjI3b4W+GcH87wpo9E=;
	h=From:To:Cc:Subject:Date:From;
	b=gCZb/gl3XnAgtJVf28ibnq5c9hu+3TTP9e9SQKCxOv/wrQt4rzZBGM0X46kU4ftBT
	 wsDobzXGDHQO6GPdwrz/uszzIvge54mnmftZRp5tLEBr2kfd2uTT+/RTNEgzmjZMBr
	 i6EifrYnc/0inBY9Izsmkt2sHtWMfew8F9bFJspXlwz1FDnbRBptYj0+TTRLP8Q3rG
	 N7KgYmkEdy2wty/CHPiQMStGGvWf32+LAkw6yp9fYzptYjQ2GA8mzv0jcUtIhBIP8L
	 3V4csNJOb/669APXdvGFAE+cuOy6sKsTeveChFbIhn5s6CrzbGZNHvYkstKJ8yMCzT
	 QQABUx7si/U8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/12] wifi: mac80211: wake the queues in case of failure in resume
Date: Fri, 20 Dec 2024 12:13:06 -0500
Message-Id: <20241220171317.512120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.121
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
index 738f1f139a90..e8326e09d1b3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2436,6 +2436,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
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


