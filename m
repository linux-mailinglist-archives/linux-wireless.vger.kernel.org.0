Return-Path: <linux-wireless+bounces-8129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292AC8D07FF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A942A8E63
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8C16ABC5;
	Mon, 27 May 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCPJwurf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2216A387
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826007; cv=none; b=sU8uYoNQn3q4rubdXLKZj4AGlGvNwEAFdh+Qk+sCWKN/hgBrSoKtpG1hTd8oB2mpq0yIcCWN+S4A0sy/M9GhW57nkJebqGu/Y7Cvi6bgKqy4+8ks1g0bXVRKhqQ2oQKraQlSXE29kr0lSvP+u43aatsA/sywvukoBDoV8GhfVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826007; c=relaxed/simple;
	bh=6PlQHpmLhVTDr2w6PgBCI+VbOS76xIY47fqcHkDY5+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTFc+Cfo5klhm0QLXqTZD3qednu1rq9id1ZVvRx/sQDSbbcXsWxaOZRb95ghJEe7eWQ5xahI+OUmfHpvoycRakKDhZ0io52KH3Q/sIcXuYBLkO9/v2+PuTbe7uHgQJeUMkvabqKIe1qBiyRaIiwJXsRSoG2LdwwJ/d1W0iA1+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCPJwurf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826007; x=1748362007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6PlQHpmLhVTDr2w6PgBCI+VbOS76xIY47fqcHkDY5+I=;
  b=NCPJwurfGXwLdNF8aFmECT8ECQru+TnuKn/UKirled2yvnVek4zAMzJm
   4SewWeFpKRQUF8suKBlqQSOMLNpsr7Ze+YjzwkZ+YqsbtdSCeP6mBIUri
   6bbDKz5n1nVwYSqJD6Ii0PTCyEawxn/T5K1YqBnKY2UYfM1kfqidGifqS
   gX7sRsVkulr8rEm0ft4VE6aCyfKMPvf8zI6DIsOulD/3vKeR+YO+2dV3k
   c2ZfEu7J1bpW0nhiKDN6eD0oz611jKjMyS9NS6E9z0Um5DYRqF5cDOJ++
   kS+QXYoy9qH5BpEbX00VhflSIlE4OvGDvtM+Bol0HfR4zYwBTJJQ2bF1d
   Q==;
X-CSE-ConnectionGUID: TSDsabagRGGNVnq4G3FkNQ==
X-CSE-MsgGUID: 09z4feUMQViBarDouxjxuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002110"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002110"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:46 -0700
X-CSE-ConnectionGUID: 9e0J9YlTQ12Kxhz3na6Bgg==
X-CSE-MsgGUID: IJil7A2cRGm3vmbMfLgnVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407124"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/20] wifi: iwlwifi: mvm: show full firmware ID in debugfs
Date: Mon, 27 May 2024 19:06:10 +0300
Message-Id: <20240527190228.527a1c72996d.If7588b854149d51605031fc9a70a650534351ef4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware prefix is unused today, but it might still be
useful to have some information. Since the prefix will get
the intel/ directory in some cases, replace the prefix by
the full FW id which has all the information.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 1504cbec69c9..cb164b733cb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -754,7 +754,6 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	struct iwl_mvm *mvm = file->private_data;
 	char *buff, *pos, *endpos;
 	static const size_t bufsz = 1024;
-	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
 	int ret;
 
 	buff = kmalloc(bufsz, GFP_KERNEL);
@@ -764,8 +763,8 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	pos = buff;
 	endpos = pos + bufsz;
 
-	pos += scnprintf(pos, endpos - pos, "FW prefix: %s\n",
-			 iwl_drv_get_fwname_pre(mvm->trans, _fw_name_pre));
+	pos += scnprintf(pos, endpos - pos, "FW id: %s\n",
+			 mvm->fwrt.fw->fw_version);
 	pos += scnprintf(pos, endpos - pos, "FW: %s\n",
 			 mvm->fwrt.fw->human_readable);
 	pos += scnprintf(pos, endpos - pos, "Device: %s\n",
-- 
2.34.1


