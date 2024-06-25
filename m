Return-Path: <linux-wireless+bounces-9545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D8916E82
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DA6288A7A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA617C23A;
	Tue, 25 Jun 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwCvzIjU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FE17C225
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334310; cv=none; b=ud6I4wmyfWDGM+y7DeO9kdhlXb70B5Uf1+vRW1pjf1r84em2rPSrBkKSVm2zWlfTeZIwzRb1IkJ4qYz1Ztrv0HBAMYecwgbSiHkLMHx73a8RrEsA6TO1E8BcO0PqvTlR1pjJvMlItASUlH7RZ40Gkj/zNNM9Gf32JvTtaNs/28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334310; c=relaxed/simple;
	bh=cHkNc/A4HWC7LbmLPYDCVyBgeJUyPDAttKc9RZbKHn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uieirBmAd3fwdKoFMtY7KmCTCtFgJdKtZpoiaNkjzWF9CeKhSDkVyxUW6/+BTnkrIQ3YrupXdxVwMKmp3cwMw8xGggBqzZ2I/p2wNwVjxu7iIPnAvJvvO6vLG7HDLSrYm7Ktegh6hhm6SNw8elFecIrViQQwVhzDlcQJsF9cxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwCvzIjU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334310; x=1750870310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cHkNc/A4HWC7LbmLPYDCVyBgeJUyPDAttKc9RZbKHn8=;
  b=QwCvzIjUkxSymQsHVgYp9550aVfTITeri48ahExvrHadgHQa+qMdjO1D
   Yn2lCH7548EXYadsslwKVFAQuO6rFoYRTiIafhGZyE8gvy3sQ3ktvbAzW
   wvB8CySM6nZfnCEm4pAghmPASZoFLGXnyDLgde2nYyHYBwXkQReyIaR4u
   vgI8+uW/GTLvtXYteqCHMli7pWcEXlSoyWqlX0u6Kmpxfwj4VTzBQ/5RY
   bzoBjXjD2yHQ8Wkoz6xn41TbrIBZAiFxdlXI+KcDyTvmboSdgscOsCt9M
   BLUkf1C7bkxfGeOQp3UguaScm0wKU2eoCIjY6d8RTB/Wr3ZXsqfj9+N+l
   w==;
X-CSE-ConnectionGUID: hr+v4bH+SEyaRH9cdIWN7A==
X-CSE-MsgGUID: 68cT/Xc5SwSKZ+WNr8tOnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594765"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594765"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:49 -0700
X-CSE-ConnectionGUID: OLum9V+lT9KwrU7+sijQHA==
X-CSE-MsgGUID: MzOZv99KQ/GX+P6ntB8eVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632744"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/17] wifi: iwlwifi: pcie: fix kernel-doc
Date: Tue, 25 Jun 2024 19:51:17 +0300
Message-Id: <20240625194805.c667bc035757.Iae0e5903a35f8e42f86deb27429131f22329b8dd@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

One typo, and a few things were missing. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 2040e00c744a..f2bb34270ccf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -272,7 +272,7 @@ enum iwl_pcie_fw_reset_state {
 };
 
 /**
- * enum wl_pcie_imr_status - imr dma transfer state
+ * enum iwl_pcie_imr_status - imr dma transfer state
  * @IMR_D2S_IDLE: default value of the dma transfer
  * @IMR_D2S_REQUESTED: dma transfer requested
  * @IMR_D2S_COMPLETED: dma transfer completed
@@ -300,6 +300,10 @@ enum iwl_pcie_imr_status {
  * @bc_tbl_size: bytecount table size
  * @tso_hdr_page: page allocated (per CPU) for A-MSDU headers when doing TSO
  *	(and similar usage)
+ * @cmd: command queue data
+ * @cmd.fifo: FIFO number
+ * @cmd.q_id: queue ID
+ * @cmd.wdg_timeout: watchdog timeout
  * @tfd: TFD data
  * @tfd.max_tbs: max number of buffers per TFD
  * @tfd.size: TFD size
-- 
2.34.1


