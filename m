Return-Path: <linux-wireless+bounces-21147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8AA7AC38
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EF217ADD7
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60E26A0FF;
	Thu,  3 Apr 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHeTfNe5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823326A0F7;
	Thu,  3 Apr 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707181; cv=none; b=PS9d9PCf7EecsTX6cbdK3QVDE3OmwPX+PUOYlxVLRjjKtazlk7DMMUh3JT/iO05qiXrv2R4LFHluVlny/kl22wzaeHIVgbbyq5jgq79XDDa6c3ZD6QrGZxyYDGHzzcgnTaeTaFmbZOHFzQlUJQin54H/d6nMEd9DBZj745NrOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707181; c=relaxed/simple;
	bh=mDYpLGljLMv3xA0BiRkGDSNlyUx8EaUoAYoGIdWRQZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFVi44EM3ml6XlTn1+LPzCthtgcEeqK4XaAFBW4GtxsNH+P4sO0znfnfo+vht2EpRrGAXtVp4MR3xxIHexUur2Bx/u9wZVFfbXhKiGf1woBBwa7tEeEaxbNVdZJeE+GctBoaR/cIpG7gExMFtzcEAkNFT5vGreuokXYkYaY1/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHeTfNe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C7EC4CEE3;
	Thu,  3 Apr 2025 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707181;
	bh=mDYpLGljLMv3xA0BiRkGDSNlyUx8EaUoAYoGIdWRQZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHeTfNe5Pr/jABr3WzNSVi4BCAgdCc3CxdvmGoyEpa3gEu3ZuaTyG/FtVzcGNfU9h
	 Bq+S54P/i9+CM7SbEpg+tvqON/pjzJuOAig1bSIA8Ws5SrN/P8IkznoObgEUzp2KAJ
	 RDpC87YIXLj3HPiaaGdLv7BFV+892wmYBvgN8FjfMNx6E+jjVNmyjMshDkE+B08EUp
	 dtVO/xesc51741B0eVZb9PGzRHuDix1bc8Su3CkSdoO294DvfENp056IbNZpF6ug/Y
	 easXeVZKLac+Jph0soZdizgOjefVen7PXSQX2bYPcsFu/BTRXtUKGZA+u1NZogoSSW
	 bVRWqkbJOJe+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/47] wifi: mac80211: ensure sdata->work is canceled before initialized.
Date: Thu,  3 Apr 2025 15:05:19 -0400
Message-Id: <20250403190555.2677001-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index af9055252e6df..82eb53ea9464d 100644
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
@@ -812,6 +812,9 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
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


