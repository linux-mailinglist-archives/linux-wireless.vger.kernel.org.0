Return-Path: <linux-wireless+bounces-7472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74C58C2664
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9161F232FE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D817277F;
	Fri, 10 May 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkuYjKJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51853171E69
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350034; cv=none; b=m8VL5z2gLG/hy1a7Gh2UWD+NFaH3gCKkiaihHcyxf+7IUa5ZtKGbSEhNYCDfZwSFdojBqiX0rTVTcu2snq+E9dzKrJEgqEQCxnsGIurdmJT4fanN0ESQ8CS5XSkvXKCNYs8zRYrTCnF8oiItcXCzmvuatS1NKqtgod6TzAyMFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350034; c=relaxed/simple;
	bh=PiIqq6yArVgDmLRf9jFoejr7pGAJ8ecUyKiCbxu22jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWrAf7gHG4NytoqchCg+RdfE/Gz0Q9Podye3VdXJcLIZe84CYoWn440P882RB8BwKRmnenqMXJIeZyMiEdRblMOpVawwk+nDlTvFZu6u9fs8IMqmvpoTk5K9MjoVldmPkdGk2X24YZxxfq4IXhAjtcHTLjEUwqBklahAB0E37J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkuYjKJy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350033; x=1746886033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiIqq6yArVgDmLRf9jFoejr7pGAJ8ecUyKiCbxu22jY=;
  b=DkuYjKJyx9ts7FaQYFWEK388iWFUFTAAHuf9iMA4TUXeCexCFPSx+XTq
   n9dDAC1EcHymkq/P7en+31545THM1AOAXt/KGmG5mzDW2goGab/4lXf5E
   1w3VYbDkBbX9dMMDSYjUdG+bOHtuG0UIyfszWtEBIbpgSxaXBT10zNrKD
   sNZ22pd7XU3o6p8bWESConuuCOtZJvF2lRw49/c5yIYL92e52Woz5l/i+
   4MkiNX20sp1fzVtTG5I8p4QR6FIfhvxWQbpH7woNH4frItUo96FyDTwQ6
   kIidk2YEzIrk1Ig7qRZ/gDHahldC/v58Up1LAI6a0U1zdpKM2L4eMP+yp
   w==;
X-CSE-ConnectionGUID: i0RM6dKLTDCjcxntzVmbDQ==
X-CSE-MsgGUID: sj29NyWJRqqaeqlu30HTPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125616"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125616"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:13 -0700
X-CSE-ConnectionGUID: 0QywtXvtTACBDMtLIfSalw==
X-CSE-MsgGUID: 4N+ivUqqRLSXTqOxRz3huA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101905"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shahar S Matityahu <shahar.s.matityahu@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 12/14] iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef
Date: Fri, 10 May 2024 17:06:39 +0300
Message-Id: <20240510170500.c8e3723f55b0.I5e805732b0be31ee6b83c642ec652a34e974ff10@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The driver should call iwl_dbg_tlv_free even if debugfs is not defined
since ini mode does not depend on debugfs ifdef.

Fixes: 68f6f492c4fa ("iwlwifi: trans: support loading ini TLVs from external file")
Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index ec756e50091d..caa9b9187794 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1823,8 +1823,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
-	iwl_dbg_tlv_free(drv->trans);
 #endif
+	iwl_dbg_tlv_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
-- 
2.34.1


