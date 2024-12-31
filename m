Return-Path: <linux-wireless+bounces-16945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA29FEF44
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D92818834E7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DF19DF64;
	Tue, 31 Dec 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFAXLQHn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AD192590
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646389; cv=none; b=hY58M8/cOC6FZBzcIEh3FFydpysnEVxZoOzGYjuM9ezF00LzBeYp5+WsPEPXEVxjZFZ5q1k4CUHmaB/QbW513vSIONTpZCSE9fqbnDJ0i8NMkSu5aQ/Tub+ztusHYSj7DBHD2IoWaLS/CwMiG+oyLsdlXi4hEnUH2R6ytPEN7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646389; c=relaxed/simple;
	bh=K09x1CbBimzRp8gEczuf7sbaL6uyC4KjBIpjhXpKXgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4tw4LDwjv+K5b4Ir6o/2xIeKX7G8Gfs2oiH9fRz7xBTWNpqWlj/HSjUmLVtF5nnFM+lHPz555DfhwtqNiWBi0lvfkTNHP1QJihdeOLXnfHMxnjOu9Hn6zsaUCmcX7kLwjgUNaNSaf9UkZKDxele3mekmtFyAUgt5FYIkQAbJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFAXLQHn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646388; x=1767182388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K09x1CbBimzRp8gEczuf7sbaL6uyC4KjBIpjhXpKXgQ=;
  b=OFAXLQHn3qN99OTKR5QpoukeioCEABf94K1s4XoPI0/iu2SgYqQXHsco
   zCscfh/xVGU6LshwLRMpJrYZqCXw+KO0vlA+aGi18X+/MgJwPE0I+YK+F
   oc6l83JeWVff0NeAyGBHI6Kh0VeqSwKYyu6DXN+kppcFNCKS8XLCs5WqH
   2zEHh+CxDNGZRyhdVqrPh5RT/6FVpFvIzPHK+TVW1N6icWzPCGUksEWFQ
   W7/sUhs2jH2RvxVEe77f/ia/L87yHuW8bwkQ9ghI22nEycb0B56GZQvRc
   3kQWsQCN7tAq4ZmWKU1y7pQrHfqWwrDEPFq6nhXkbcPXCzny2K9stwhas
   w==;
X-CSE-ConnectionGUID: K8ld6OO0QaOQafQg3SgYsg==
X-CSE-MsgGUID: zNHS7GzyQDG6RbLPfyV8tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330198"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:48 -0800
X-CSE-ConnectionGUID: lvQarv3nTHmqBmz24OJuug==
X-CSE-MsgGUID: dK/TBls0SC+vHbNxaWAP1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380347"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: pcie: make _iwl_trans_pcie_gen2_stop_device() static
Date: Tue, 31 Dec 2024 13:59:13 +0200
Message-Id: <20241231135726.060c01653d4e.I3f0675b3977e474b633ff10965fe6512f34ae593@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This function isn't used outside the file it's implemented in,
so make it static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h   | 1 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 617ec598de65..58e5e403a110 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1137,7 +1137,6 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans);
 int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 				  struct iwl_host_cmd *cmd);
 void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
-void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
 void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
 				  bool test, bool reset);
 int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 9bcdca2b19eb..0affb438e545 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -137,7 +137,7 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 	trans_pcie->fw_reset_state = FW_RESET_IDLE;
 }
 
-void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
+static void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-- 
2.34.1


