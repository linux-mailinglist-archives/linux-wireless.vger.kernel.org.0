Return-Path: <linux-wireless+bounces-9207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B390D9B7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AEA283367
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12291448C8;
	Tue, 18 Jun 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENcmyMg2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93C143C4D
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729074; cv=none; b=HQcwpFRyDYoNksKzfepGJDDel8cQMVUQqBhMgKiV/1QjYkF2v13BSvlW2IiwVDaNc8BDp5exWMPrJGbJXThXcUTLWkUkTJpmKr+UrdbvVrKj5JfRBwRMkEXIrzOEkcbWRHoPkjyy8UIRY/HfOF+aQJYe7TBGFAI7oLhMbCEfZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729074; c=relaxed/simple;
	bh=L7+YJirJdyN/71kR/kzISMlh890mmMMWF2m8a5k2T2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TC5JyVfW+iI0X+YOtcsazLL7nMX4Kyl2zMO27OH9HWA6mlDy+69muzEM4jnVcSkBVBTDRHSN17PMjTphQzRuxLaJcqA1Cr4XV1BaKQKQE4v4bToBu2DZO+Oax8i2TU9Kg9thHyWadL3oxEIkC0Y1GIJLMVCQaPzjh+HPRCcIzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENcmyMg2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729073; x=1750265073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7+YJirJdyN/71kR/kzISMlh890mmMMWF2m8a5k2T2s=;
  b=ENcmyMg2uOjDb3iAUali41NmpasPUNOq86bwgcvfDgv1mLWFQSgzHYsT
   ArrQnqeGxj+D/XwdwBmJYltF4Sup51Ft5lMASbTA9smnbV7F7uLWr1FdD
   ukNl9T2XMVQrmeP8YnBp4f0J8SuGsG6UziMu3dY9cTyP3qtwylOC2/KzL
   tBUB/68z2ppC3sknmUB5+zRsTCm761zmqZotylNR1Z9Elw9F0mttRcP7h
   zLtDcZexsWtfv8qgrbZDz5F0oq5h2PTSd/PMbfs0L9BwiA+qNSrdAlPep
   S1eZJLtFNlq8vanmvZd1A5rwXIAA66Ehp202K+kktVs2wMt2HGQBWrieq
   A==;
X-CSE-ConnectionGUID: 7Jjv6+mASTyWMDa4OVrIDQ==
X-CSE-MsgGUID: VGdajU50TUSV2IlSdngxDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257185"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:32 -0700
X-CSE-ConnectionGUID: +JcJoHhFSjGdNyb1Vo878Q==
X-CSE-MsgGUID: vHClCOcrS6+Dz0bGEU0dEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306527"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: trans: remove unused status bits
Date: Tue, 18 Jun 2024 19:44:08 +0300
Message-Id: <20240618194245.cd26318d9513.I035ec7f3f022cdc19a650eca3b89455e3b5eca18@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those bits are never used.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 006eb51a705f..ac8f8ff5a99d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -291,9 +291,6 @@ enum iwl_d3_status {
  * @STATUS_RFKILL_HW: the actual HW state of the RF-kill switch
  * @STATUS_RFKILL_OPMODE: RF-kill state reported to opmode
  * @STATUS_FW_ERROR: the fw is in error state
- * @STATUS_TRANS_GOING_IDLE: shutting down the trans, only special commands
- *	are sent
- * @STATUS_TRANS_IDLE: the trans is idle - general commands are not to be sent
  * @STATUS_TRANS_DEAD: trans is dead - avoid any read/write operation
  * @STATUS_SUPPRESS_CMD_ERROR_ONCE: suppress "FW error in SYNC CMD" once,
  *	e.g. for testing
@@ -306,8 +303,6 @@ enum iwl_trans_status {
 	STATUS_RFKILL_HW,
 	STATUS_RFKILL_OPMODE,
 	STATUS_FW_ERROR,
-	STATUS_TRANS_GOING_IDLE,
-	STATUS_TRANS_IDLE,
 	STATUS_TRANS_DEAD,
 	STATUS_SUPPRESS_CMD_ERROR_ONCE,
 };
-- 
2.34.1


