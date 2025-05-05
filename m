Return-Path: <linux-wireless+bounces-22526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10209AAA6A1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C05B463811
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757E32AB83;
	Mon,  5 May 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlZrx60g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C229673F;
	Mon,  5 May 2025 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484501; cv=none; b=e3ojB8WJbO0LBP4pWUMhu8p8aJsWeMKJnoJ/rN9WeRfzSU/8LZU/Uh7N/5so9LcxiEUA/FJWvxQHrOUvWcU2HT5hnNd15W9FBCoRKCFs+sBortoRswa5i49Dt37NzBtVmcSdmD0Kfbq96sYgVZa+YiW6NJyHzyeMhPL7c/UogvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484501; c=relaxed/simple;
	bh=mZGoNHX7kzC6i8SSbCkQgV40eNut3/40B0+hesX5SvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDq3xshYvR7Er8vKZJsCEmoQ8mWlRQ/ETo0dE/1FxJvldsKLh+vYfnC6u/0AeX2GNghXNEeIJde8xrkUN6hGf71BGDAn86OWr2oyzn0U4uP+rs2kvqHFaTcmXYbjTYCRgFG+xjagvXCj1IBHc3GsPx0Or+W/EFpE0DZlrNMiZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlZrx60g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A306C4CEE4;
	Mon,  5 May 2025 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484500;
	bh=mZGoNHX7kzC6i8SSbCkQgV40eNut3/40B0+hesX5SvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlZrx60g8byffb0zeabrZQLguoSbtnM4pfE7oHyqrLmYGS0T5NKBaOcW3gW4HOIKP
	 WA3RbXCw5HTs+0cSMs/W5fY+m4askBjD9Jq4DdDvZ5VwpCIgX3zacu1SdJQKr/iW84
	 +C0q84M+wmyphM3DFBhAY0/DkNhidvcxPXMkQdJLYZbyF9AuRKo3ranoC6bUekriNh
	 v4rF8ngE1FxJ8e0tQTlQOr3778U1AvxHN3Xr5ONk/LM+bwLlt0JMsm5Jxf5MHFWMv3
	 VNTXG7GvnN/sLMoqw2ond8zCj4O8S1BlH1VEo2U28dI6vrFsoo0BD4emBa7GY6c7oW
	 gN8UyDjy5biLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 504/642] wifi: mac80211: set ieee80211_prep_tx_info::link_id upon Auth Rx
Date: Mon,  5 May 2025 18:12:00 -0400
Message-Id: <20250505221419.2672473-504-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index dcbb2e54746c7..b421526aae851 100644
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
@@ -3829,7 +3829,7 @@ enum ieee80211_reconfig_type {
  * @was_assoc: set if this call is due to deauth/disassoc
  *	while just having been associated
  * @link_id: the link id on which the frame will be TX'ed.
- *	Only used with the mgd_prepare_tx() method.
+ *	0 for a non-MLO connection.
  */
 struct ieee80211_prep_tx_info {
 	u16 duration;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5acecc7bd4a99..307587c8a0037 100644
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
index 39cfb926354a5..9904018383fc9 100644
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
@@ -4579,6 +4579,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	auth_transaction = le16_to_cpu(mgmt->u.auth.auth_transaction);
 	status_code = le16_to_cpu(mgmt->u.auth.status_code);
 
+	info.link_id = ifmgd->auth_data->link_id;
+
 	if (auth_alg != ifmgd->auth_data->algorithm ||
 	    (auth_alg != WLAN_AUTH_SAE &&
 	     auth_transaction != ifmgd->auth_data->expected_transaction) ||
-- 
2.39.5


