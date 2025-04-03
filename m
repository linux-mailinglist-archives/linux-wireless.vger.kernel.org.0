Return-Path: <linux-wireless+bounces-21144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EDDA7AB3F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75380188C887
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377826159B;
	Thu,  3 Apr 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjFBthbZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E326138E;
	Thu,  3 Apr 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707071; cv=none; b=PuSUcSsV611ex2V/kzVbqQMQCC1pC1NUUF+sxRxwaxKQGlvDRvUVrE+KkqdxFxA3wEIfQVZ7EQlWk+fU8CVTGj2tYzo+RV3B6JDUOZZ3k4sWglLVhLhla6tCL8lYie3QtKULRtlLq4lj1AwSpDBb4ZQxwwrfgAueuBDc8e85RBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707071; c=relaxed/simple;
	bh=u6Vb1EZTF4X/Ck9xbv0lVTGtdTxKcuTGZs9h9zCs4sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBNR19HYJD+MW5leipMfJQsT/orQkK9HQVuDGMCZ6fWdoEfN2QeN/ludL37h8uO+fTosR7V1i0I/7rGbdt7vdbGxVs6wPp/DKsxJte3fIbCUp4tprmkDscnQmV5dR+4P+jl+hEcOK5j0BQfP5ORxxdXyYrxRnAfCmg0XjUboqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjFBthbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15915C4CEE9;
	Thu,  3 Apr 2025 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707070;
	bh=u6Vb1EZTF4X/Ck9xbv0lVTGtdTxKcuTGZs9h9zCs4sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjFBthbZeZr6dGwVBq0cnC9GX8g42VsAL0wU3eq1uBfZYjM9npE5QRGBoXB3eQKFU
	 O2wmwndQ4Re34ejVQFbyRb3gS8+scfCi2UvYRQ97JXETM4J0D6rvdDlmAKbJQFzRwI
	 6X0iunt3pxV2g3eO9F5ZZCrnE+MceNNPtAajTAxNhMOMR+d931Zib4qcuTdtQ8qDqw
	 WSU1HzQLHsoWy9HoJy3EoqPT3o9odABRkDaRGn2f1W0VVWktQW1U+RSFt3FRZut/oc
	 1IPE+2fqrtKK0U+Gkz8C3NqKobsfUanEfyZCvDqhRD8wBL5v4JospOKzWjgbIVTaHi
	 L0Yjf2k06/Cvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 11/49] wifi: mac80211: ensure sdata->work is canceled before initialized.
Date: Thu,  3 Apr 2025 15:03:30 -0400
Message-Id: <20250403190408.2676344-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 806dffa48ef92..dcae83c717ca0 100644
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
@@ -813,6 +813,9 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
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


