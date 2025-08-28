Return-Path: <linux-wireless+bounces-26725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76195B39467
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFA51C22DDE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 06:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274772C327D;
	Thu, 28 Aug 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIE7zGd9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC127B354
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364165; cv=none; b=W9RrLW6JWmrn7ZwuU2INsycYM/DqQSy82B++gXZhrIQrV56l66X88YDErYGfUcpJxCj6SWLOqkWPwADvqFTOl5/4a5sFNsTN44q1EyqZB9tC7UN82sZKUg72+LDhOWcGyotB7l50yKnpaRl0rsYkOtyHb+nEvX62M+3Dao3zSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364165; c=relaxed/simple;
	bh=kwqV5ySvy/KvnXdvnKD3nf2GdtT7rkKM7NALaNxogmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJmXU6EwgHb1U0HrAIkJZ6hdZeDDAfTh1fPSVaNhdEXLq6zDh1wnlf1PsmFjJNYs4QNnsvvQemExV+hzAyrGUq77Ihz6OFyALdaaO75RICu5VMHEsC5QsfU44MHdYvqWwdWQ3GLI3MKimRERnf18/YulwLNN05rWyXzmEokVwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIE7zGd9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364164; x=1787900164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kwqV5ySvy/KvnXdvnKD3nf2GdtT7rkKM7NALaNxogmY=;
  b=gIE7zGd9+BmagXwRlRY/cuyzA75bzyJZoytga8upZjWygWv3itQLsk5H
   AJVUUGryIN6cwqsP6JeDndOYCckTn5RBZpcDM3MvTxBHnT7KZLKU8rdFX
   9bffVLOifGZz37oc3dhO9xqsm01BvKb1sRJKlGQvtDAfrKdG2baj5OSpW
   YuFKIzS67EesU7kFDtTnZWlEA8cXTPsqakibYbQGXyaLHNJZ+5aCPKfYt
   SH5LEpxCx1J3XTV/mH0nxckTBc1UdCr+AbiZcwUanRAYOGYfLfwynmEsh
   IR3INKXvCB9veB+a7agCdS1HugEEAn8q2eto83t7d++u36Sh9vUjqtJNr
   g==;
X-CSE-ConnectionGUID: AcsIuOwDSDuXIN9yx7gsCQ==
X-CSE-MsgGUID: ipieDg7bQNqtbkx5pKhsUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58723689"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58723689"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:03 -0700
X-CSE-ConnectionGUID: iu1kq3QATJW5m1XvV1kLEA==
X-CSE-MsgGUID: jAcwp3BXQnO9R2Tr4D+52g==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 5/6] wifi: iwlwifi: fix byte count table for old devices
Date: Thu, 28 Aug 2025 09:55:30 +0300
Message-Id: <20250828095500.eccd7d3939f1.Ibaffa06d0b3aa5f35a9451d94af34de208b8a2bc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For devices handled by iwldvm, bc_table_dword was never set, but I missed
that during the removal thereof. Change the logic to not treat the byte
count table as dwords for devices older than 9000 series to fix that.

Fixes: 6570ea227826 ("wifi: iwlwifi: remove bc_table_dword transport config")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 84a05cc1c27a..d912e709a92c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -2092,7 +2092,8 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
 	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
-- 
2.34.1


