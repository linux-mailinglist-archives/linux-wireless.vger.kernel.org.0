Return-Path: <linux-wireless+bounces-35972-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMXcDFm5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35972-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD04D5F93
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36D23048DF6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2292DEA9D;
	Wed,  6 May 2026 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E98PIdpr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FD2E424F
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039096; cv=none; b=Kvk9e5w9tl9W9ms27S3200ClRsyugdHZR5hdWVa25cjqA8r8cBK1aNXI/9TZ4nawDlz7uRLX17AkQpwZE6qTDS5V3BkmlyTXI+LnwgakJKgzNEAU1FqlVhNtjhVSNZPh/NCFxB6TV2NduxBEyC2zLx9SU9JuLhtx9CTDo2kmhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039096; c=relaxed/simple;
	bh=YRmVoafECIiyXQPvEZYmXhictBtlZsd3+xCvEcvrIK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdIuDLQ6uAC//9mDRbal8AlOxvMl+wsp2jlMw8oIlk8wkrKKNbCfw+mrJEdKEg4x9VFN4T3SYOIO/dgvYd9auArI0qX/tGnzkyFkDe9midae33bzzXqcmdIBRYk6NY8cq5HgwV2Sbd8Di/XDOFTXsR2hswmhEesJi9db5YG3ZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E98PIdpr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039095; x=1809575095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRmVoafECIiyXQPvEZYmXhictBtlZsd3+xCvEcvrIK8=;
  b=E98PIdpr+6pEcQsc7jtpp0UzDXmuERXH0N8S7u2fTWqrGVkORd7UKh+B
   10xuDe6IWkNY2CN2adE1IoUkz8JVNKJmb22So2rLQ97YFKAa8c1KLhkSf
   urcOICB6dZjt3wICzT4NagC9PeT8wgaVR+g7A8IsCxOE7mI3qo2b5aZMx
   bNgCoY5k0WLGwTknFKr7hC94MZiyrnS4PKii8TuFp3YgibhwCuehDo6ih
   Wem/jwXrnbmjOlB8aBd+nLSVFFCtSDwtyAOXL13PFFWi8F9AXs+gSLL9C
   IDKM+Tf12yhU/EahrJ4EzjyTxHHqhme3agG8P+7tYuEh4B0wzdB7u10Zd
   Q==;
X-CSE-ConnectionGUID: nZuzx2YbTbi+eCDus2w+Kg==
X-CSE-MsgGUID: zDsdLV8VT4WvuuLn4tfQGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791287"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791287"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:55 -0700
X-CSE-ConnectionGUID: L2+ECUhYSJaCh3gztwjM4A==
X-CSE-MsgGUID: UJjBORgUQzyXo6hZmYG3jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777781"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v2 wireless-next 06/14] wifi: mac80211_hwsim: add NAN_DATA interface limits
Date: Wed,  6 May 2026 06:44:25 +0300
Message-Id: <20260506064301.587955b23089.I261b782e5c198726b9465815d59ce037f094784d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
References: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86BD04D5F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35972-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Daniel Gabay <daniel.gabay@intel.com>

Increase interface limits for NAN_DATA interface.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_i.h    | 4 ++--
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 5378f721c299..d182b5117bfb 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_I_H
@@ -39,7 +39,7 @@ struct mac80211_hwsim_data {
 	struct ieee80211_channel channels_s1g[HWSIM_NUM_S1G_CHANNELS_US];
 	struct ieee80211_rate rates[HWSIM_NUM_RATES];
 	struct ieee80211_iface_combination if_combination;
-	struct ieee80211_iface_limit if_limits[4];
+	struct ieee80211_iface_limit if_limits[5];
 	int n_if_limits;
 	/* Storage space for channels, etc. */
 	struct mac80211_hwsim_phy_data *phy_data;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 969ebc28cb1e..3397acfe61c8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 /*
@@ -5631,6 +5631,12 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		spin_lock_init(&data->nan.state_lock);
 	}
 
+	if (param->iftypes & BIT(NL80211_IFTYPE_NAN_DATA)) {
+		data->if_limits[n_limits].max = 2;
+		data->if_limits[n_limits].types = BIT(NL80211_IFTYPE_NAN_DATA);
+		n_limits++;
+	}
+
 	data->if_combination.radar_detect_widths =
 				BIT(NL80211_CHAN_WIDTH_5) |
 				BIT(NL80211_CHAN_WIDTH_10) |
-- 
2.34.1


