Return-Path: <linux-wireless+bounces-21139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2DCA7AA06
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8D178ED1
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3B2561CB;
	Thu,  3 Apr 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3rYHcqx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB00253B6E;
	Thu,  3 Apr 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706959; cv=none; b=qAzv7iJa/ETJF+gX2FITdVw3gRfAhbVxAJ6XDC9lQaHTehYJJ66+OppR/mLXpZWOsOMkJiQCZnTVxOJW+Byu35i27kCbGxKTDe7SRV0cpglzC9oxC54ehdFA918ofRfrQdXsjM5syzJWXZRY5RQ8NLWyyiZkKrKTX7FjM/Mo1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706959; c=relaxed/simple;
	bh=Hr8jxDpVQqNKw09qnAHqDGLlOF048gJxHmZ2OIOWl8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hB3yZw2/GmGVFK2Q+WarByW9YYE/XqN2512VT8jep2YnKFTvfVGYuTa/IJvUX4aY6IyP34+0GShTLmHMRD7Tw+K96WxBTfO1bvzFLSpdszjaRQZzxe4tDWGY8ldzv80NVg9SkWrpUZQnrtbZUwHyxWZ1qegkqXPhKsN34P4//fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3rYHcqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5888FC4CEE3;
	Thu,  3 Apr 2025 19:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706959;
	bh=Hr8jxDpVQqNKw09qnAHqDGLlOF048gJxHmZ2OIOWl8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3rYHcqxdS6d//KoRctO1A6NXXYkaaQMMJ8G5SGWQVmjCZTW+MYb/JPfuBgD4Bx5b
	 1YWKhbN5DtOpBXC08YKy1z3jxABVCb4R8xDqrG1dqdY5lkcVHoudGGCUP8WshZQ9hF
	 1p4t0bogYLQaeCLOVE1mjKDSF5n3to/MB4CeSrMitR/bG39WTUN05+9HtsbkvlJ3x7
	 22n8b2kb0PdFltuo8i8ydeToh31Fq6rrywDV8XWMeDOIIr0toabZPu0G78KrU7aY8V
	 7/WKOBwv37sKs22TII5ZtlyObaetOi0ESVmNNhv1LqXlAwsIOw949qt3fliwMnfrMJ
	 vK16n1VN/sNwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 13/54] wifi: mac80211: ensure sdata->work is canceled before initialized.
Date: Thu,  3 Apr 2025 15:01:28 -0400
Message-Id: <20250403190209.2675485-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 6c93fd502023dd919b5987ccbe990735410edd49 ]

This wiphy work is canceled when the iface is stopped,
and shouldn't be queued for a non-running iface.
If it happens to be queued for a non-running iface (due to a bug)
it can cause a corruption of wiphy_work_list when ieee80211_setup_sdata
is called. Make sure to cancel it in this case and warn on.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20250205110958.99204c767c10.I84ce27a239059f6009cee197b252549a11426046@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/iface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 738de269e13f0..459fc391a4d93 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -807,6 +807,9 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
  */
 static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 {
+	if (WARN_ON(!list_empty(&sdata->work.entry)))
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
+
 	/* free extra data */
 	ieee80211_free_keys(sdata, false);
 
-- 
2.39.5


