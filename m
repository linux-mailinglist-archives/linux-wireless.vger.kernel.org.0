Return-Path: <linux-wireless+bounces-24991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BBAFD79C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A88D7B8165
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B524291A;
	Tue,  8 Jul 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaAgspLz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456F241662
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004293; cv=none; b=sR+f3o5YebgkIBOglbFKa0DP3XTGynU+OCG/FhmOK860lsGIaOAdZk+RtqMiWs43eOqLKudRN9IK64sh/wvBCiTlKFuGTCvZZLeAmgxeA7ixHTAuZeWl1aWzWowCp6N/2M2m3/UY5GNaI68+GaY5zGBaqCo/iqJ8IB29kX23rg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004293; c=relaxed/simple;
	bh=8yeWEnOClSHq/cStlqAnOCWfXIKcCR/r0ZVSPuE6+l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLcn9umgubjia4I/lVXfInZqC2sIgW1EfYCuvNIY/RQkpPiCCohsGgL4qWXVTYV/iwr86L51Di3vIgb3hDQcq6KLijiNSHd5RojovosZmCvPmXh0bpC7kDjyecQDxiYNi9a4RXE9uWUnlv5HKOoPdZzGSwJSqFItBR+/Xk5Z/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaAgspLz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004291; x=1783540291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yeWEnOClSHq/cStlqAnOCWfXIKcCR/r0ZVSPuE6+l8=;
  b=OaAgspLzlmjG+kxvwbSlDX3Jq38qX+YEgWw9d5Cx0HPCLbF92rwCZDvI
   arN7CSIumHYFo8lr7ygvG+FKuKw2aq7rPDkajjMij414/FmriBY4LiqLH
   jFrwXGFf4140A4RS9bYywqbpbqlSkxXXDuGg8FuzUAYBwWFjI+4ZzcXK1
   1okd4iMYZNmk/p4ejMypAKc8a4ZGS0yzVJYoLtCGQTElEguqkt0edu7X1
   X8V07dAUDCN7sC9Avhq4D2YTxch0ETzDho1KIx6iQCtwh/Tt/pjKZxI7+
   SGXwzgQmy2nQwZWkIPlH9i0xj/nVoUi02dsYe8ZQpYj+oqCyyS15Kd6Cn
   w==;
X-CSE-ConnectionGUID: W60KIyQ0RXSKr4rOoVhW1Q==
X-CSE-MsgGUID: Jc8PA4TLQAaswBYnrniiHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229732"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229732"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:31 -0700
X-CSE-ConnectionGUID: GK3MaEG0TcS1SBl2WnMN7w==
X-CSE-MsgGUID: Une5Mf/zQr2v1C9tBFa9vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155669000"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: bump minimum API version in BZ
Date: Tue,  8 Jul 2025 22:50:52 +0300
Message-Id: <20250708224652.181beb1a97ec.Iea4f3d36e18029a817ec5d6641d08ac5ee025678@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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


