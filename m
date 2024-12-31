Return-Path: <linux-wireless+bounces-16944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4909FEF43
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1C161BD1
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8E019D060;
	Tue, 31 Dec 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYdCSCS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3D19DF64
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646388; cv=none; b=rnnXqOsQUh/+WuHb5biB12oxQBQDKdCnjGvllVdUe+XtRGZWC4WmnH3DkoeLPmYHBNwE2zOIWpL/c+AsANmgDcXALwhV5vfVfv2v43/cuU1EE2fQudro2DuQc6ZMUpuHp1ItWhMafOllZfMhOemNgD++PswcARw8pEHqUVIunVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646388; c=relaxed/simple;
	bh=ksb6Zi3q7JEHU3bEAGHLDPn6Cftt+XMqneTU8HvaQvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3bLQoEBsMI7KM+khymKDDWlGbXwQKwkkO0NyxoyoOTnW+VWc4tg7PPce/+POJpkMRHQshgzocQxJxSqdYQNUFuethHPxT46EZ/oT4Nr8I2tHVO0wvgf63qlk6e5Glm+I0ychHYTBhsr9aj3GVOartIu6uYcAuz2ERWj44x/4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYdCSCS0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646387; x=1767182387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ksb6Zi3q7JEHU3bEAGHLDPn6Cftt+XMqneTU8HvaQvk=;
  b=FYdCSCS047BWvJSMUyRLocgdvvkuP0A/E12n8i+iQqEWSeyhitfjMIpA
   0vbqM8pg6y9cGJa8k2O1CuycYHIiD7Fe5Zh0XJCOkN0ng6UKxtqoKdkDE
   OdacZRDzQmVC+LTj1UUmCrBbZ54QzqLKdw9SkwOyGFpdvpfSB6Yhdc2Wt
   v1JYgN3FZgpZ11YhoHwaDmzR4mHAkAk6PZWRkhzQHOf3/9TmQo5ez55TX
   3zvgRHfYQOdJhM1G+GzXj4t7QkDjE3T8ywEpdg5oW+qG5wiDUcDPRsVCV
   GhBmTBn+kgleln3G8gwttvifwQHIOkKe74Pk4ma1OpLwB3BVfDJsVbg4n
   g==;
X-CSE-ConnectionGUID: zbqyzvfGR0qyUmHHt2kTnw==
X-CSE-MsgGUID: 6FMBBuSNRPGEcaAgV0nu7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330196"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330196"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:47 -0800
X-CSE-ConnectionGUID: 8BEkzykzQgqHBRJo0OX0Aw==
X-CSE-MsgGUID: tXl5jJllRtGIJMGQlyy3UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380341"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: remove unused tas_rsp variable
Date: Tue, 31 Dec 2024 13:59:12 +0200
Message-Id: <20241231135726.fab845da5c6f.Ica84a4c0df33db9c9b6baef28893bb42e1f367b7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

optimize local variable usage in iwl_dbgfs_tas_get_status_read().

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index f6f5117b93c0..83e3c1160362 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -542,8 +542,7 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 					     size_t count, loff_t *ppos)
 {
 	struct iwl_mvm *mvm = file->private_data;
-	struct iwl_mvm_tas_status_resp tas_rsp;
-	struct iwl_mvm_tas_status_resp *rsp = &tas_rsp;
+	struct iwl_mvm_tas_status_resp *rsp = NULL;
 	static const size_t bufsz = 1024;
 	char *buff, *pos, *endpos;
 	const char * const tas_dis_reason[TAS_DISABLED_REASON_MAX] = {
-- 
2.34.1


