Return-Path: <linux-wireless+bounces-25034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE301AFDE89
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8551E7B9C33
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACF227E83;
	Wed,  9 Jul 2025 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGtDGHfF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC872264AA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032656; cv=none; b=fmz93K83VthBZ/8FRzVJDi672D7SZ7fYPRyrGvZEq6Qb+vtLggmv+C35m4vYf/8po1e6ZYuwTaXQvdwzazhCYoJMLpWpNwA3UeTWTVPd9t6RP5RPmxR1HHih2qwF3XJPkH2vCNFarQynu0tWfzZ/yaQa6AsPEA46TG4NW4kUa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032656; c=relaxed/simple;
	bh=8yeWEnOClSHq/cStlqAnOCWfXIKcCR/r0ZVSPuE6+l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKXlb+NvlYdsWKoqozPOqtRiy+SXwKouIAXo/fKXHWuAr+IXCIfNA0JY4sSFGrFGPMAWcgsDj2JmU0guFllRV1QW57SIR9GFpNsXwSTI0ZrTQXh5ztx1M4938c+wx0AsGbSY0sEPf5MSMcyTkeL3F2Ix/B92q8gTQcoiksAk37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGtDGHfF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032655; x=1783568655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yeWEnOClSHq/cStlqAnOCWfXIKcCR/r0ZVSPuE6+l8=;
  b=SGtDGHfFn0NEpXr0pRCOC+avL8hXHW+05WqmPMvZjGI3hmHQP30DcZYe
   Lk49lPxROC1PqOSpZnKgeKmc9aJE7LSchpFs4QMF7hbSgpfEbJ8H2fury
   Kc+y2Oqq7Ga2CY5GEvbFpB6iLs7Ifiq1p2GdSttT9zPn5sXdZ1IzofL/S
   tD28vNP3fZ7qdTaoSJ1eC2MaeerYK+tGK+d7hgqdewVq4GshkTDSHfeXO
   WdETZaQeT2WF6qOEli45QktieFYe0SDx4iwZIsI4Gj3QLFTsKswDzuflg
   dSUj2YvTAwv0F+259RbHNYwVXBoS1fUsB6hBLTanIkptTx1M7e2Qi9HPj
   g==;
X-CSE-ConnectionGUID: WTZb8Le5ROe+WzZCE+YKBA==
X-CSE-MsgGUID: wt+vm58OTmuhwW2d+AunRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720668"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720668"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:15 -0700
X-CSE-ConnectionGUID: OBKYppzdR8acZ6ALRJWFLg==
X-CSE-MsgGUID: sJaeifl0TOG+fv0A1Hq7Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390576"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 14/15] wifi: iwlwifi: bump minimum API version in BZ
Date: Wed,  9 Jul 2025 06:43:38 +0300
Message-Id: <20250709063858.b1d64e0fec93.Iea4f3d36e18029a817ec5d6641d08ac5ee025678@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting older FWs

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index c6cd892bff69..50d454514fe5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -13,7 +13,7 @@
 #define IWL_BZ_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
-#define IWL_BZ_UCODE_API_MIN	94
+#define IWL_BZ_UCODE_API_MIN	98
 
 /* Memory offsets and lengths */
 #define IWL_BZ_SMEM_OFFSET		0x400000
-- 
2.34.1


