Return-Path: <linux-wireless+bounces-36365-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPTODg4QBGouDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36365-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74952DB30
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEED30AD7E5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC32030A;
	Wed, 13 May 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih+8Eo2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E93A6EFA
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651070; cv=none; b=FMbTfAptQUivgInbqo1K06/+EB51AINugGASWu+rXolQrZ//RY7qTxvHPldO2BYEg2OxQfvgcbjt+56hicYz59N6r4U2x9Q2Sgk6JJczH73s+Cpcj+7+awN5nczxukHU45qTW6NEd8KwoYkBXPVvTc8oV4zgI+u3+JteXY4rz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651070; c=relaxed/simple;
	bh=9L9zQgrlrIwvDY23ThPKfEmW/J7TXNASKt8R+1LGyX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nm74mbcFgIL/qgYATbnT+hR9yVzNGQvoH9k5+fo3O8I9H4KAQaXMVIYHOKeemYpFhyuSQsU7As3XtNCqP1HMHNEnp8wxucINKsHGseYcRupd3XLF0suz6ZfMgZO1fkku4QNDovbmEBTjMoOIL0W8eGJY0/wP8ZyGr82LTlkur90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih+8Eo2O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651067; x=1810187067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9L9zQgrlrIwvDY23ThPKfEmW/J7TXNASKt8R+1LGyX8=;
  b=Ih+8Eo2O87eKApRUIdZWQTx1d4w09Pxs1zfdL5HFWwtK5HlGNWb30zI4
   lht3asLACLIOcZh2DGB7XVOlHHRX8+KcyTZui/TYzc1B3wBN21ljyR+nt
   E1Ayh8hEI/ROrE7SqcSk0gz3sHYyIu2I3A/FQC/Y/3z9nRVFwPxy8JBcM
   /emRH1se43X6HvQqQFqDOsCf+OsaRlQETDJN6N8bKs0NjLD68Zt2/OS3f
   sAd3/Dv1nSsWa/qt4kqVUB6bPk/NuPOExSyK4m/S+9qhSLGQTcGiuvBt9
   QkdtQLW6g6KdgyT3971u44o5xFjpOjWLGjvk3vJo5dY23N3yJh+3Spdo+
   w==;
X-CSE-ConnectionGUID: bkxu6KhtSt+YQwjTxJTa4A==
X-CSE-MsgGUID: Vv/SfM8iT5mSP5k4sERHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552836"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552836"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:27 -0700
X-CSE-ConnectionGUID: U8gqoXhkRPGKUIezYmNM6w==
X-CSE-MsgGUID: 0cf6sMMjRS+/JfEzv0ifKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077933"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: give link STA debugfs files a namespace
Date: Wed, 13 May 2026 08:43:55 +0300
Message-Id: <20260513084215.4421f114bb33.I0de78b6b184935bc2a3d77fa649888da31b5a0fb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E74952DB30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36365-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,intel.com:server fail];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The generated data structures and function names used are
just the debugfs filename, which is a shared namespace and
could lead to confusion. Prefix these with "link_sta_" to
disambiguate.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/debugfs.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 9ec8ddce0c38..ba5a47519aa1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -1049,20 +1049,22 @@ static ssize_t _iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
 	return ret ? : count;
 }
 
-static ssize_t iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
-					  size_t count, void *data)
+static ssize_t
+iwl_dbgfs_link_sta_fixed_rate_write(struct iwl_mld *mld, char *buf,
+				    size_t count, void *data)
 {
 	return _iwl_dbgfs_fixed_rate_write(mld, buf, count, data, false);
 }
 
-static ssize_t iwl_dbgfs_fixed_rate_v3_write(struct iwl_mld *mld, char *buf,
-					     size_t count, void *data)
+static ssize_t
+iwl_dbgfs_link_sta_fixed_rate_v3_write(struct iwl_mld *mld, char *buf,
+				       size_t count, void *data)
 {
 	return _iwl_dbgfs_fixed_rate_write(mld, buf, count, data, true);
 }
 
-static ssize_t iwl_dbgfs_tlc_dhc_write(struct iwl_mld *mld, char *buf,
-				       size_t count, void *data)
+static ssize_t iwl_dbgfs_link_sta_tlc_dhc_write(struct iwl_mld *mld, char *buf,
+						size_t count, void *data)
 {
 	struct ieee80211_link_sta *link_sta = data;
 	struct iwl_mld_link_sta *mld_link_sta;
@@ -1091,12 +1093,12 @@ static ssize_t iwl_dbgfs_tlc_dhc_write(struct iwl_mld *mld, char *buf,
 
 #define LINK_STA_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode)	\
 	debugfs_create_file(alias, mode, parent, link_sta,		\
-			    &iwl_dbgfs_##name##_ops)
+			    &iwl_dbgfs_link_sta_##name##_ops)
 #define LINK_STA_DEBUGFS_ADD_FILE(name, parent, mode)			\
 	LINK_STA_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
 
 #define LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(name, bufsz)			\
-	WIPHY_DEBUGFS_WRITE_FILE_OPS(name, bufsz, link_sta)
+	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_sta_##name, bufsz, link_sta)
 
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(tlc_dhc, 64);
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(fixed_rate, 64);
-- 
2.34.1


