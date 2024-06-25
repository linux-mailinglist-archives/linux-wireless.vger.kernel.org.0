Return-Path: <linux-wireless+bounces-9539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E26916E78
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EDB1F22BC6
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E197178CD6;
	Tue, 25 Jun 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+efVuyG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12E172BB4
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334301; cv=none; b=G7DYnXCuT/onC8/sDPqSure13Hxgn+19/jzMJEm7jw3RSS4OKlew7rpVAELVD3c1RQJa6PwVse8l5H7fdVMxxhvvtFAc6vhBnAaIy9HJxEAKQ6GxO5MCX/t/bBeBkd3gVx3+MWp8BSBBD4DyGsXEDh7DVj+DJMbXbQBR0upt0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334301; c=relaxed/simple;
	bh=Rnc/Uo5VrNU5yw3xc+8iUkHu1ZheKYIvBwaqtYcegtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYaQVj5JNNYhpWgmew57IhETx8MLK5X5b19itzZqBB98jD37gj7+zWUph285zEIPnMZUwSeRHLZ/U+83rKPvNPShuhk88/oSklBtvYkw57BqX9de524gFE0XgnpmeUhid1sQKnUe5vAU886mngZCPl/6OHhgrIZraB9tLvnLj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+efVuyG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334300; x=1750870300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rnc/Uo5VrNU5yw3xc+8iUkHu1ZheKYIvBwaqtYcegtA=;
  b=d+efVuyGSIlhMlyubq4qLo+fI1JFuL+xQc9FrltlLPB/fg22jYL/ZQ4p
   3hln7tiW6J5xcNA0L1/8RFjQnMMzUpOpiyHc2ycNV7OpHUa0O4e2tU4bc
   KJ/vlO0dkFhjb8n7dJs05RlIbRr1CdtGLIc8Vqvr4ADPfZ+RA/GTj/Eee
   jc8ergHnPdmAjziHaqLpcUIDceNHS0VeLmJf5FL3zNaXXtUjA5sdLF6ns
   zT/XRU/9YnES1snWCRiqDXDeRmKU86HOOfIxfDEOKVyP0KrM8uN4lqBaU
   Deg52S6ZIID6V4VWbf4Srds5OyHpASRGi9OzlwiChQrxXuR4ftjEXL4iA
   Q==;
X-CSE-ConnectionGUID: xIzZtAFiTqusITLWNXEhGg==
X-CSE-MsgGUID: 4wgw6823TxOkSUHbz5WNWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594710"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594710"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:39 -0700
X-CSE-ConnectionGUID: Px+QROgOSg+ttrZdzhaJUQ==
X-CSE-MsgGUID: nf5pzxD4T1qarR/DmS1MZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632540"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/17] wifi: iwlwifi: update the BA notification API
Date: Tue, 25 Jun 2024 19:51:11 +0300
Message-Id: <20240625194805.3d7887e2e374.I37bf709969d069ff0392e0976e62e06fb7a87bc9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We don't use the new field, but at least, document the change.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index bbd176d88820..71669f81d93b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -698,6 +698,7 @@ enum iwl_mvm_ba_resp_flags {
  * @query_frame_cnt: SCD query frame count
  * @txed: number of frames sent in the aggregation (all-TIDs)
  * @done: number of frames that were Acked by the BA (all-TIDs)
+ * @rts_retry_cnt: RTS retry count
  * @reserved: reserved (for alignment)
  * @wireless_time: Wireless-media time
  * @tx_rate: the rate the aggregation was sent at
@@ -718,7 +719,8 @@ struct iwl_mvm_compressed_ba_notif {
 	__le16 query_frame_cnt;
 	__le16 txed;
 	__le16 done;
-	__le16 reserved;
+	u8 rts_retry_cnt;
+	u8 reserved;
 	__le32 wireless_time;
 	__le32 tx_rate;
 	__le16 tfd_cnt;
-- 
2.34.1


