Return-Path: <linux-wireless+bounces-19904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA76A549FF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168DE188BA30
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAC20AF6D;
	Thu,  6 Mar 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4Z7pium"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFF1A0711
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261768; cv=none; b=GTtuyer/XZEmniXKddf6TwT+rlUboZjtA1McFSybxftRjxl+lrMDnTFGCLkqnzmF35d3hk8wtiTJ3ToCW0MrWSHYZChSjBAsnkxbNWpJLhmBr+2e0I2jNbg9ppQonpYwtglfQxoYLgmnPTBKsD6jotitJibLs69qkw6/87hEPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261768; c=relaxed/simple;
	bh=Lvi7BfNv2bRCFi4MHBrGC8IskUYwUo2kII2i6+tJ10A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWC45k+65UR7765L+gDbt4ckC9SE9V7MULBTkesVwc1qaaEvRJd59OsUEhnJOAVMqXVriQq5JCDMBsmmBA8pzal9OxMpDTs+ReGiBPeV0wfTFjRmFUb3g6dwOdKHSW0DsT7A99jutkaf5a9X+fnP2ttlpS689Vl0j25kOefCNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4Z7pium; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261767; x=1772797767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lvi7BfNv2bRCFi4MHBrGC8IskUYwUo2kII2i6+tJ10A=;
  b=n4Z7piumru24r39Mv9cKw4/eFHnsS9K3HI2r/7V2FLfzGBunFbE7jlo5
   Rmkrr3FI+s05YtKzpmdwA0bLyYQERkn7qTorHLVj8z6PkyFM/QPbOV4Tx
   Azi17jvdKXdQmW2nlshHHYnSAeV1OKQYCfMyNyvMAd4KYn/2g/SD3daAQ
   lgW3z9Fqzyi00iXs9G1H/yzhKleHhlpdhBpQsvBESVEVsVwDPKOyB6pav
   9SCQ/nz8vuDWNtgiXmXL8ZXBoiq1nT9ph5lGGRvF44VcED0YxPhNwa2xN
   c+dHSZQPJveDDzWx2tERSr9mSMpm/WSn5Qwgr47krCaYOBvFhsI1b09HW
   A==;
X-CSE-ConnectionGUID: YONWPvgkQzemfaS+14xwJQ==
X-CSE-MsgGUID: GE5l7o3yQviNAWLsdAlEow==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474541"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474541"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:27 -0800
X-CSE-ConnectionGUID: 4BrJMTU4TXmU+EIm5UQplQ==
X-CSE-MsgGUID: 1Jo0zl1kRtCUQSgwyBLvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915572"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH wireless-next 11/19] wifi: iwlwifi: mvm: Fix bit size calculation in iwl_dbgfs_tas_get_status_read
Date: Thu,  6 Mar 2025 13:48:47 +0200
Message-Id: <20250306134559.6894035de050.If2cea63035333b07849e5a2c2a4f5dc5c5239595@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
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


