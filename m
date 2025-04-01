Return-Path: <linux-wireless+bounces-21018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E25A77310
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 05:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2583D3A37EC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CE9461;
	Tue,  1 Apr 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3O1accv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044481386B4
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743479180; cv=none; b=VgkuIUIdIc5rMPgiSuD2eI0IvPJJM2V58GXNR9/cOPL3plQSbHhsHClBgtPUwe/qMs8C0ycM2UVaENoq2tioE9zn+B7tTvxA3kR7UID1DQEAS6AEag1MPCEqoa0juefsCkxyqUH4Xt62M+o3twprpDJWc03a9bid32Q8VpvcEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743479180; c=relaxed/simple;
	bh=XbEPOFo6l0QAGv8KrQmrZCKLXc76zmqX4mpp6JYk/p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogFkO4M4taRACCCTC6IEhy4HWKbOF+mATC+2lUzAq1MOPvQFOQkh/h2ZYBCu7h0ttJ9biYg03VxC/xFPI5gn6CBahaOS+1IRxQolW0dRuCixOH5MC9PWtKa45Vg/u1xiPs1CloSFOwKq/7nDuEMhwqgR6eH/70tz4FewTfJJo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3O1accv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743479179; x=1775015179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XbEPOFo6l0QAGv8KrQmrZCKLXc76zmqX4mpp6JYk/p0=;
  b=K3O1accvgeLXLG67pfNUHoctkHD/5Gb7/nDDJ0UR4EYp4slyKDTQhlXo
   I0WrVodN/8DYnV8pikqW4+h3T/l03y0gOOI2ou1rCnK9UoTPatv8TJteC
   KalM5dZEZODp71eMJm5Xk2HxQoQGL27AYoR5clC3DsSAJWcV1Qv2YZ/+z
   lkFq0QTEiElHBsyMahPkXKMq5AJpN3xRtxb0khsIlfFzIxAJL2NJ4QM/w
   SxiwWvKvYvhoQSTXY5lRRpdy2w7vfKl+vdXpxXHUdwbfup0kGqYY1NPuq
   9REj8TxDEdIMtbCjchuLFoeuDJiBPBe+n/0SEDSM7OXl7WmCZvuN1KFY5
   A==;
X-CSE-ConnectionGUID: svG5gl04SnGOie0LnaECLQ==
X-CSE-MsgGUID: D7J5dxEWTTSPCBvyJRPRdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="48573175"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="48573175"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 20:46:18 -0700
X-CSE-ConnectionGUID: QAJbbBU1RA2SipUro9FqOg==
X-CSE-MsgGUID: z3IQ5Y1EQi2k+Kg+vw5gsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="126156067"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 20:46:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Yedidya Ben Shimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH wireless 2/2] wifi: iwlwifi: mld: fix PM_SLEEP -Wundef warning
Date: Tue,  1 Apr 2025 06:45:55 +0300
Message-Id: <20250401064530.612020bcdaad.I4e885e6646576e29fb236250a1b5038d3f14b08e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401064530.769f76a9ad6e.I69e8f194997eb3a20e40d27fdc31002d5753d905@changeid>
References: <20250401064530.769f76a9ad6e.I69e8f194997eb3a20e40d27fdc31002d5753d905@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Config symbols are not defined if turned off, so need to
use #ifdef, not #if.

Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Yedidya Ben Shimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index d1d56b081bf6..ec14d0736cee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -166,7 +166,7 @@ struct iwl_mld_vif {
 
 	struct iwl_mld_emlsr emlsr;
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 	struct iwl_mld_wowlan_data wowlan_data;
 #endif
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-- 
2.34.1


