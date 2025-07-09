Return-Path: <linux-wireless+bounces-25063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8ACAFDF23
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D89358575C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C8A26A0E0;
	Wed,  9 Jul 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvfCEFCX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539E26B2C8
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038229; cv=none; b=fAoFioHv3X9Xw0Fvy91eNHdEiR7B1CQ36tVg9ZmW7a+eWSAuI75PXOShy7QZqiTyCw6h3rK4JCHgtmAbQLT4rCs0kjwbXnR3mEiOv/nrjV640D7cIWAsR5XdEOK2yqa/MOps40rHTFGyTpOcj3jDvLGikTnry6V9ebvYbXlgGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038229; c=relaxed/simple;
	bh=Jt1LemJ7lyuw0ysHRo6Ek2o3vEj0uvSZY3MobRPaOOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O17TnQnYvHejCi9tdxVCI2snOybsPJ0IeMHbMZTpKQn7OkmzvuYmdRfOcs1iDtmFqmyhimk7shO7PrEgxgvFZLhW0T0gmaYcxQqooMNoUHms37PGWqf3NZcor2U5Fkpl0U0lztXM04XVrjcFQIDlg1ojSp6CBwfK7qJPVzTS/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvfCEFCX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038228; x=1783574228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jt1LemJ7lyuw0ysHRo6Ek2o3vEj0uvSZY3MobRPaOOY=;
  b=BvfCEFCX5B5gQVvTh5xq/V5DX8SDUE5glJSGv/o9jnAnn+yYZ4d1of3p
   gn+MajEhAakluTW7KCyJmfU+P//hi8LC1JKGdVQcCfy9E0HCpwBnCzR7s
   v9iDhBvxbVZ+pNd6c74CDHKqiqCPvvsUqVTsJ5L6cXtZswJoVqLtK8dfr
   elwYcBebYLub/uazY7OAQDYzFtF5E1PEE17oWPTj8V8ouXG92NGeun3Ij
   KHTnUy1mFyPqpRgDSZzVrF6eleeHZXh1TwRKQCo5BODcnyKMpZGkXeMws
   y+va7hfeyZfDrhli240mfrWfsUIhh4MOvIjM/4IaRzgAj+mQ2CQBBHGxG
   A==;
X-CSE-ConnectionGUID: Pdhotem1QaSAtG56Eb0iKg==
X-CSE-MsgGUID: SktJH2WtTfGM6jl0CnKcGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091175"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:08 -0700
X-CSE-ConnectionGUID: dMWZQsoQTEaxv4M1N/PDtQ==
X-CSE-MsgGUID: T7bjkpOjSPy0FF/m9e958g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327880"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:17:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v3 09/15] wifi: iwlwifi: remove Intel driver load message
Date: Wed,  9 Jul 2025 08:16:28 +0300
Message-Id: <20250709081300.fe33c279a45d.I16a9cbcfce92a1d1b8b26a20ea9911e8a5a0b1cc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
References: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's really not much value in printing something just
because the driver loaded, remove that message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 064ff2135411..f62f7c7ee7f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -2049,8 +2049,6 @@ static int __init iwl_drv_init(void)
 	for (i = 0; i < ARRAY_SIZE(iwlwifi_opmode_table); i++)
 		INIT_LIST_HEAD(&iwlwifi_opmode_table[i].drv);
 
-	pr_info(DRV_DESCRIPTION "\n");
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the root of iwlwifi debugfs subsystem. */
 	iwl_dbgfs_root = debugfs_create_dir(DRV_NAME, NULL);
-- 
2.34.1


