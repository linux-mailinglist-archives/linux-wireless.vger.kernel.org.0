Return-Path: <linux-wireless+bounces-6319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB28A4AF5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0171C218E1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C923A1B9;
	Mon, 15 Apr 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw5rqJz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD534EB39
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171318; cv=none; b=BpQ5qdCSNCPVGYEEs0B6JnBzpImEL/1riantL5TVnTtP9j/Kpqgp2oXNYJaFHiRpM5H4R9yc/DUP50AUaXRhS1GD6cbwIdJbQm+mrcPYRez2yUxB7hoPVf6yek8EdUt22xI4Rsbz9KguNmhh4AVO74vTBOCnvvRYjIzQ98uc9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171318; c=relaxed/simple;
	bh=hOtVHfKT997P8Yr7sfmjjIjRzTT93brS+LNASc7QOXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MurcIHUhL1+6B4F9p3qC18dToPlkyA/JVS43qSIYyyC/3QeKUd3OCjZvKFrBP2i5xHW5lfWfnpHTKDn13w8lOhqCijiRqsIDwJoP6WQIpAL67MqlA+6Ny9nRQh61iYJeacL2phLJrkZuqGWaFy+rLPlWAFEbDs7GQ1RoFHjFMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw5rqJz0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171317; x=1744707317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOtVHfKT997P8Yr7sfmjjIjRzTT93brS+LNASc7QOXQ=;
  b=Gw5rqJz094P638uuRimNiP8jhoy1XmBG+GbTZf33TVdgJVuTYX8KHpuq
   R5UrKWtfnwU1Zf4H3gNn0BHbTCAbPjDnPnkDUBMqc1UqWtqzEQy/LP7DK
   tNlVTMq1PKhywVYdYaZpBXEdwV7OTCqU903PddQ8lXacV7wtX4MzRw/p5
   UliYyhZrLzoBDJx/RFYBmHIPHsDozZm9sK2DuyS+F6bnUti9FOaMWhsZ5
   YvI4uOND2AagnoV4jLIYzX5ykCwXNnCBDpRCPsUNtUk4stUt/FPodmLI+
   QVdqmrHIlrylFadjRtf4keyxVXHoQ/llmERyL2NFcb/J/e3AU6KeboS8s
   g==;
X-CSE-ConnectionGUID: pTqVmpyoRwKi2DDTnBJUUw==
X-CSE-MsgGUID: Ycnzm8pqQ2KpQW06gSD/XA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100632"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:17 -0700
X-CSE-ConnectionGUID: wLgx1ELfQ5eaKeIbYV8uBw==
X-CSE-MsgGUID: zp4d6z5qQw6vt08t65DBHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768096"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd
Date: Mon, 15 Apr 2024 11:54:44 +0300
Message-Id: <20240415114847.5e2d602b3190.I4c4931021be74a67a869384c8f8ee7463e0c7857@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This function is supposed to return a uid on success, and an errno in
failure.
But it currently returns the return value of the specific cmd version
handler, which in turn returns 0 on success and errno otherwise.
This means that on success, iwl_mvm_build_scan_cmd will return 0
regardless if the actual uid.
Fix this by returning the uid if the handler succeeded.

Fixes: 687db6ff5b70 ("iwlwifi: scan: make new scan req versioning flow")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index f2fe9ee83d68..2f55de11cd52 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2831,7 +2831,8 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 		if (ver_handler->version != scan_ver)
 			continue;
 
-		return ver_handler->handler(mvm, vif, params, type, uid);
+		err = ver_handler->handler(mvm, vif, params, type, uid);
+		return err ? : uid;
 	}
 
 	err = iwl_mvm_scan_umac(mvm, vif, params, type, uid);
-- 
2.34.1


