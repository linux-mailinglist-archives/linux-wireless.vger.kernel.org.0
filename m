Return-Path: <linux-wireless+bounces-19953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239FA55957
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB79516AA75
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85727CB08;
	Thu,  6 Mar 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzJw8qpI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A127C876
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298725; cv=none; b=dUbD7vzJH0NtjYcNhUK9NPrkmG38d+5bH0moZKplA45eAGxQkTL7rQ7s8qfTVRcHZdSBHtRLwYgDwm4hDgsKjCkR3a054dSs/LT3a4Y/jgGUiIDbhbrgpN4SbtKtN0pHFozTQli1vR7lRsUn95DfKh2IhL81GGD8dYzGu4HcovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298725; c=relaxed/simple;
	bh=Lvi7BfNv2bRCFi4MHBrGC8IskUYwUo2kII2i6+tJ10A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKKd2i8Id6m5RmqsX2bAvRZuRY4SRT84jsq3Qw4Q/KgqcWPhII1Wutj2CPO4EZWoPJAKfP1blRDDRNCa0HceZBBtbB8LFslmX8vcKQ+USbjpRWDK39herw3uZ2v4P6pLsMGrsBuo6taLcJNd7WpfZKLmsCt+xYeng3JWq401RUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzJw8qpI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298724; x=1772834724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lvi7BfNv2bRCFi4MHBrGC8IskUYwUo2kII2i6+tJ10A=;
  b=TzJw8qpIZilW9tr+jOxi6BcuFDmwK3HtvmTaiKojqIoV5elcpdCkJFC9
   SMbsHujvkF3V2ioZYibKbVVZyuuSMzli/3vPk/dbRNPxZJv4/Y4uY+Dd+
   Fotcm2TRXusRiJOVpVZwTaxDWL3Wp2hi/eF6QA9XxgXH0+n9/tx4B7m/y
   t3v0MRZnvCs3hq0Cc/u0wUqwjU+HmxRfWwl64v65mAxyuiIW6w6QC4weP
   JTbRZQH5bpLbsh4o3WX4fRAeoRxOmGJKd/1Tw7t5rJhl5/T4UOfVtUoAj
   EaV+Jog1rm05S9lEbjYxk+gF93/y31wkixZOjV6bqHZbnEzvmExF9jBW/
   Q==;
X-CSE-ConnectionGUID: CnayEIhyQq+yabRQGogPoA==
X-CSE-MsgGUID: kuNIR/dbQGGKuhv9Z9iZ2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474276"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474276"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:22 -0800
X-CSE-ConnectionGUID: 5KudqO2sRIu84BSJYIPKrA==
X-CSE-MsgGUID: BjRhgVSSSRS/9qn1Y0cocA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061908"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: iwlwifi: mvm: Fix bit size calculation in iwl_dbgfs_tas_get_status_read
Date: Fri,  7 Mar 2025 00:04:49 +0200
Message-Id: <20250307000213.a105314a94f2.If2cea63035333b07849e5a2c2a4f5dc5c5239595@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Corrected the bit size calculation in the for_each_set_bit macro in
the iwl_dbgfs_tas_get_status_read(). The previous implementation used
sizeof(dyn_status), which only accounts for the number of bytes.
This has been updated to TAS_DYNA_STATUS_MAX to ensure the loop iterates
over the correct number of valid bits in dyn_status.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 6ffc04a23c6c..1289ff3ab162 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -698,11 +698,9 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 
 		pos += scnprintf(pos, endpos - pos, "Dynamic status:\n");
 		dyn_status = (rsp->tas_status_mac[i].dynamic_status);
-		for_each_set_bit(tmp, &dyn_status, sizeof(dyn_status)) {
-			if (tmp >= 0 && tmp < TAS_DYNA_STATUS_MAX)
-				pos += scnprintf(pos, endpos - pos,
-						 "\t%s (%d)\n",
-						 tas_current_status[tmp], tmp);
+		for_each_set_bit(tmp, &dyn_status, TAS_DYNA_STATUS_MAX) {
+			pos += scnprintf(pos, endpos - pos, "\t%s (%d)\n",
+					 tas_current_status[tmp], tmp);
 		}
 
 		pos += scnprintf(pos, endpos - pos,
-- 
2.34.1


