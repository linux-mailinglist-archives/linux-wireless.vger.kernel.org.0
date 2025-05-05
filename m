Return-Path: <linux-wireless+bounces-22621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B4AAB1EB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24B8189DB12
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242737995A;
	Tue,  6 May 2025 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX7swX2g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28072D47AF;
	Mon,  5 May 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485622; cv=none; b=Pd4o0tYbcYwEonuErFNYGt5Lp4scs1epExEir7b8WBlWuAWeg2GN+344749XM92wXn3xkDIfSCyoSDDqh9V4HiZESsA5cGts9AjTM9SINPxiREqw1OTZkAvPGdr02JJW4wYi6rmjO+LIsSH2XaImXvyRFcWz9CMjaNXIrrFGYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485622; c=relaxed/simple;
	bh=qvJ9ZW9IfQ0fmmxErwoQfYX7wZ0NMd2P88EYDj4tlq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrcBDhsmxpvEo+zBzA7qKWQDFB17qiEfkW/kmYT8SigNY7i6yK9VojJQtOsVPaxYwILtvEGMzcPUEXa1n01+Il94guIdo2v2CCXvWInvpa7gsnH6m0T4EmdR9JcjTva2l+ar2YDhkq0k/XgC03IN5Gg/hRvMRmuVyIMhQUNMllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX7swX2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE213C4CEEE;
	Mon,  5 May 2025 22:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485621;
	bh=qvJ9ZW9IfQ0fmmxErwoQfYX7wZ0NMd2P88EYDj4tlq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TX7swX2guYKZySJ4xcIRm3+3fp5pgt649Xm2qiKg4vONp3t7qINJEheu0imwH9esr
	 0qBSFLLVeehqgG/dIKoamSFs1CjOgNKFrvPthzJRlACzFneYRGyp5Z7Wkjihx/B51s
	 0axU9R6FLscYt70v0eo/3f5kx37xSd7JQ8kAqYRh3JRwUpZH66ZcSeUQhHCHNc2lgp
	 G0t6OisWeHniXfX8hm2emvw6QoEjAQRsU54ZZTsJlMJdE/3tOv7srgy3C6a8yx6eLy
	 rZv4TBCOvynrjo8/5FVglUi609Dv35kBB9h7NLsRhiArpNjETuA+blfhd5okoN7ZLC
	 +UySVn3eu/6WQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 392/486] wifi: mac80211: set ieee80211_prep_tx_info::link_id upon Auth Rx
Date: Mon,  5 May 2025 18:37:48 -0400
Message-Id: <20250505223922.2682012-392-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 8c60179b64434894eac1ffab7396bac131bc8b6e ]

This will be used by the low level driver.
Note that link_id  will be 0 in case of a non-MLO authentication.
Also fix a call-site of mgd_prepare_tx() where the link_id was not
populated.

Update the documentation to reflect the current state
ieee80211_prep_tx_info::link_id is also available in mgd_complete_tx().

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.6a590f189ce5.I1fc5c0da26b143f5b07191eb592f01f7083d55ae@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h    | 4 ++--
 net/mac80211/driver-ops.h | 3 ++-
 net/mac80211/mlme.c       | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3b964f8834e71..fee854892bec5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -3803,7 +3803,7 @@ enum ieee80211_reconfig_type {
  * @was_assoc: set if this call is due to deauth/disassoc
  *	while just having been associated
  * @link_id: the link id on which the frame will be TX'ed.
- *	Only used with the mgd_prepare_tx() method.
+ *	0 for a non-MLO connection.
  */
 struct ieee80211_prep_tx_info {
 	u16 duration;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index a06644084d15d..d1c10f5f95160 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016 Intel Deutschland GmbH
-* Copyright (C) 2018-2019, 2021-2024 Intel Corporation
+* Copyright (C) 2018-2019, 2021-2025 Intel Corporation
 */
 
 #ifndef __MAC80211_DRIVER_OPS
@@ -955,6 +955,7 @@ static inline void drv_mgd_complete_tx(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
+	info->link_id = info->link_id < 0 ? 0 : info->link_id;
 	trace_drv_mgd_complete_tx(local, sdata, info->duration,
 				  info->subtype, info->success);
 	if (local->ops->mgd_complete_tx)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7d76bbcfdf48c..e156ae4ab6b86 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -4307,6 +4307,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	auth_transaction = le16_to_cpu(mgmt->u.auth.auth_transaction);
 	status_code = le16_to_cpu(mgmt->u.auth.status_code);
 
+	info.link_id = ifmgd->auth_data->link_id;
+
 	if (auth_alg != ifmgd->auth_data->algorithm ||
 	    (auth_alg != WLAN_AUTH_SAE &&
 	     auth_transaction != ifmgd->auth_data->expected_transaction) ||
-- 
2.39.5


