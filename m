Return-Path: <linux-wireless+bounces-20267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062CA5E73F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17667A55E1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80191EF0AD;
	Wed, 12 Mar 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpIFnBvr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E861E2823
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818175; cv=none; b=RHuWtwaoqQen7wZeZ6E3aZ+bJpyFcheVCW1BM85QQpUa8HyuxEjMi3df3yl09jaYJVkmLsEOvlJC7RxN6HJ0W6tel1G8YvHgrgKSxk0ZD9eMIyO8vhWi95KLYuNYwN1QtVbb7BggGSsvho8p7Vcg72jtTK7XVQenBnZxnxQ5xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818175; c=relaxed/simple;
	bh=KvLOg2bYXDl2Hld/Vb7l0+A0g3pa5ZtZ3ZH2HeZuwNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+IQ8DyNd+8Hz4bLh+p5EgYpC/aoqRJHLmFxH6Ytrj1e7ffCVKDo0ox7Fe7nm2+tjEBiZYA+QiFqls3QTgMzSlN3CdrxxW1jtC6b5zG52u1eswquY9YvQckhwT8ULl7Ka3Ej68+ab5lHMFE0/WZikClUVkQhhg0KIzX/UDsyd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpIFnBvr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818174; x=1773354174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KvLOg2bYXDl2Hld/Vb7l0+A0g3pa5ZtZ3ZH2HeZuwNQ=;
  b=IpIFnBvrGhbxIWNd17rUCnVdNZ3OmpuC/eJAEHhs6In9O6z2g7HIRsrD
   KbKsM1vYCvgPOg68ZCarGsXeL5Q6rZlbShSXOOkg5dnNvKJw4kxnpQpn7
   xwqwDDcWIN6F1l4c3xeWdWhA1MmFbP5we2PPR0M8NspAwJm+iP6g5fF7A
   sJ2E9CafZ+Vu+MfSggdISXcQCtvEgZIg6bDHVlXQXfa0Oqc/rWvUzvcBb
   tGZAMuDQkieootIXVHXuwRMHPEpd8U2HGn2Opq1xr5Gx6/rzQhufKBxzc
   c0lZKHGI0no2zwIVxdL/7DOOXpwgJfH8nOSEkMOG3Vhsp9wcjgLRE19Fx
   Q==;
X-CSE-ConnectionGUID: E7PyB06VQQ2UwaYBOhR3qg==
X-CSE-MsgGUID: ouBsENO6RfyhPpFG65L0yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826732"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826732"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:54 -0700
X-CSE-ConnectionGUID: m97gaGs7SEOqEoDJ+pfNFw==
X-CSE-MsgGUID: vAamgqsrSOeZJc53Jw0OfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267346"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: iwlwifi: mld: Add support for WIPHY_DEBUGFS_READ_FILE_OPS_MLD macro
Date: Thu, 13 Mar 2025 00:22:25 +0200
Message-Id: <20250313002008.b0ddb6b0a144.I1fab63f2c6f52fea61cc5d7b27775aed58adfd8d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Introduced the WIPHY_DEBUGFS_READ_FILE_OPS_MLD macro to enable reading
data from the driver while holding the wiphy lock.
This will enable read operations with wiphy locked.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/debugfs.h  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
index 13d97184a31f..900aaed90775 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
@@ -121,6 +121,16 @@ static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
 		.llseek = generic_file_llseek,				\
 	}
 
+#define WIPHY_DEBUGFS_READ_HANDLER_WRAPPER_MLD(name)			\
+static ssize_t iwl_dbgfs_##name##_read_handler(struct wiphy *wiphy,	\
+				       struct file *file, char *buf,	\
+				       size_t count, void *data)	\
+{									\
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);		\
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);			\
+	return iwl_dbgfs_##name##_read(mld, buf, count);		\
+}
+
 #define WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER_MLD(name)			\
 static ssize_t iwl_dbgfs_##name##_write_handler(struct wiphy *wiphy,	\
 				       struct file *file, char *buf,	\
@@ -147,6 +157,40 @@ static ssize_t __iwl_dbgfs_##name##_write(struct file *file,		\
 				NULL);					\
 }
 
+#define WIPHY_DEBUGFS_READ_WRAPPER_MLD(name)				\
+WIPHY_DEBUGFS_READ_HANDLER_WRAPPER_MLD(name)				\
+static ssize_t __iwl_dbgfs_##name##_read(struct file *file,		\
+					char __user *user_buf,		\
+					size_t count, loff_t *ppos)	\
+{									\
+	struct dbgfs_##name##_data *data = file->private_data;		\
+	struct iwl_mld *mld = data->arg;				\
+									\
+	if (!data->read_done) {						\
+		data->read_done = true;					\
+		data->rlen = wiphy_locked_debugfs_read(mld->wiphy,	\
+				file, data->buf, sizeof(data->buf),	\
+				user_buf, count, ppos,			\
+				iwl_dbgfs_##name##_read_handler, NULL);	\
+		return data->rlen;					\
+	}								\
+									\
+	if (data->rlen < 0)						\
+		return data->rlen;					\
+	return simple_read_from_buffer(user_buf, count, ppos,		\
+				       data->buf, data->rlen);		\
+}
+
+#define WIPHY_DEBUGFS_READ_FILE_OPS_MLD(name, bufsz)			\
+	MLD_DEBUGFS_OPEN_WRAPPER(name, bufsz, struct iwl_mld)		\
+	WIPHY_DEBUGFS_READ_WRAPPER_MLD(name)				\
+	static const struct file_operations iwl_dbgfs_##name##_ops = {	\
+		.read = __iwl_dbgfs_##name##_read,			\
+		.open = _iwl_dbgfs_##name##_open,			\
+		.llseek = generic_file_llseek,				\
+		.release = _iwl_dbgfs_release,				\
+	}
+
 #define WIPHY_DEBUGFS_WRITE_FILE_OPS_MLD(name, bufsz)			\
 	MLD_DEBUGFS_OPEN_WRAPPER(name, bufsz, struct iwl_mld)		\
 	WIPHY_DEBUGFS_WRITE_WRAPPER_MLD(name)				\
-- 
2.34.1


