Return-Path: <linux-wireless+bounces-35930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAlyGUoe+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D43984D18A2
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B31043067732
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722D4921AE;
	Tue,  5 May 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+6mDfXX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541D492183
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999362; cv=none; b=GOxrA+WfLK+kYw76lXWJiYw6toMMV82A1l6iTJuxGakKAX4h+80DtfP4xBbfbocODdsVhIEdG4tJRyZeLuN5EW7nbplDLbrNKXBESK0pxEZTt6MT6aWLtS2I/5oNJEWboNIdLcH4MSagrIWwnqS5jjPt+/FOxKGyKJ61KXn9Qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999362; c=relaxed/simple;
	bh=YRmVoafECIiyXQPvEZYmXhictBtlZsd3+xCvEcvrIK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7rI67F6suXAiH7eq4ZgoYuaKPlOSbxGg5h1LjQNPWVSCxo0CWTNHieXPi/cueE62ThJh/vn68Bek75lKA0znfrQjLNP87cveLsjJV1mYslO/4w+9u3zCeDuaT9aYJ0ZmcHuH0igJlZr9uGmgxrLmTvs9TzTiQAkzWl0vtA7DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+6mDfXX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999361; x=1809535361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRmVoafECIiyXQPvEZYmXhictBtlZsd3+xCvEcvrIK8=;
  b=T+6mDfXXSLqqqJept13/MS7wXa2T8uRqJx9P7EK61wVEM7F3C0hTLsit
   uYt19N7u9zM2iyim9xU6/D+mdpGoDyXu4mueigIjqmEmG/jEu1pLEP/NF
   xv6J5wT53k0/MQZAh1Lp5FTPaNNdPdKt7tNAXRMakwOFCl8wiNMaNfCtE
   hU5Zpl509+TZIPU4IMvktz/cHv6NhRh2P2p37oQJwh+zm9bxNuDJHrSeA
   vPjaKFuVtWzUYFyiro549gp9D7xSZiuOrTLDJQHXEqwIUmn70jE3LYGVv
   HubFrf108ReMckBXRm4Qp2r9T3HhBw9nXxvxSkaozgkaDJnU5ury5Jyaq
   Q==;
X-CSE-ConnectionGUID: eH6Z6qWlR7CmJkELR4LpcA==
X-CSE-MsgGUID: qEUfvIy1SXKAHXaYTqkbFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898978"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898978"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:40 -0700
X-CSE-ConnectionGUID: SRt51L3eSGeme0iEqC3T0w==
X-CSE-MsgGUID: o12DpaX+S3mh554E7WbGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206394"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 06/14] wifi: mac80211_hwsim: add NAN_DATA interface limits
Date: Tue,  5 May 2026 19:42:11 +0300
Message-Id: <20260505194007.587955b23089.I261b782e5c198726b9465815d59ce037f094784d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
References: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D43984D18A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35930-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,w1.fi:email]

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


