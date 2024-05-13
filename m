Return-Path: <linux-wireless+bounces-7587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40228C3EE1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AF21C218C7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8714A4D1;
	Mon, 13 May 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZOYI9p+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E914A4C1
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596051; cv=none; b=RdHuLZqu96M3OwItXpngaEE8PLwlzsOpstwPT0Xt7ZvX5CkLtJokfeX1GiRS7K3GNj8bNFkpNZWuAurnbR09KxpvjbH+Q4k3NgNcHoWqDI3wooNSszOTQgonm3zqnWdYrLQah/7Lt/Ub+geXGZhVVdcBoi+GxPHlOndHcM8K2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596051; c=relaxed/simple;
	bh=FeymIdh95AzLVdL9RdeqDlwnsvZjtmwH9DYKFA8kNus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVtooISzc3u1Os5i8YEI9GTk6wesHs5DBXABgAVq+ab58obIwT8iF25OGe1KDGptnXoHGHWfovyWkwShUT+nmakIh9b/iz3sLXGlVajHNvPb37xv4/YgffZOfqLaYWvEzBASCnKXnZjDRU+yV7VTFwGSNft3eNMArgtNwGRKVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZOYI9p+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596050; x=1747132050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeymIdh95AzLVdL9RdeqDlwnsvZjtmwH9DYKFA8kNus=;
  b=UZOYI9p+v92WJ3T1sQmX51oBGn66ir+SpO7uPyNahQasHSnCy/S/IXih
   bVadRihxnaw3JyM8O3JCjdu5v/e1ciz39VO8B403t6MpU6TB9nuNNToYY
   SnzgOcD0Rfvojg04e5wVjMEm6MV3wJAnkjJ/bbZWtq8CYb1nhRbBGaG4S
   DRnbqctsE78Og071YKCJ4HyNptl6JxAy+WHgZZ5Yvd46PQ4Mjos3edg30
   1hXMsiLv42uh6uaIG8ffI/jSqSYRxrs2mV9pF5YJG7B+EG9g9khMPS2QF
   WaP7dkKZPDXZ6rkrmQUqgZ9G0SYOtnyRnpef13FYr8D4Yvp76wCLN5YDS
   Q==;
X-CSE-ConnectionGUID: TJsYucinTaCaBNX5bmI4GA==
X-CSE-MsgGUID: 9WRJUTJKSuCohDi8bTeUJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928667"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928667"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:30 -0700
X-CSE-ConnectionGUID: ExJ+Ww6wRaeInX5pV9j4xw==
X-CSE-MsgGUID: J32SQDG6TQaPA7mtieyvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516419"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 6/7] wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill
Date: Mon, 13 May 2024 13:27:13 +0300
Message-Id: <20240513132416.8cbe2f8c1a97.Iffe235c12a919dafec88eef399eb1f7bae2c5bdb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
References: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When HW rfkill is toggled to disable the RF, the flow to stop scan is
called. When trying to send the command to abort the scan, since
HW rfkill is toggled, the command is not sent due to rfkill being
asserted, and -ERFKILL is returned from iwl_trans_send_cmd(), but this
is silently ignored in iwl_mvm_send_cmd() and thus the scan abort flow
continues to wait for scan complete notification and fails. Since it
fails, the UID to type mapping is not cleared, and thus a warning is
later fired when trying to stop the interface.

To fix this, modify the UMAC scan abort flow to force sending the
scan abort command even when in rfkill, so stop the FW from accessing
the radio etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index bed2cd81f8b5..18134e06b021 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3249,10 +3249,11 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   0, sizeof(cmd), &cmd);
+				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
 	return ret;
 }
 
-- 
2.34.1


