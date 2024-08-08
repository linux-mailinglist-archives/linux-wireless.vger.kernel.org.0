Return-Path: <linux-wireless+bounces-11146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C294C5A7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0501F218E4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65915B98F;
	Thu,  8 Aug 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W33accMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC19158D7F
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148598; cv=none; b=f6zkVRKjlhV6niUB9LGWjYLJiUoQG7Re5l7ATaj1SKY1WObBwshVr/Bzgyy40/wKs1PTP8kMwZW2CRygYZICyq2v8WC6c3aK6DuhX8NgBnbsvTlB53ysl4yAhdN04kHD7nagNjhE9S5GREYX8Nc+7VKobcB+Crr9ccz8jgpMHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148598; c=relaxed/simple;
	bh=g6NeEu2zkzsKnxuFEANQO7J0+43y/BINkKTkrvJKd3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qePSpJGbTCZO2LyMrXSHSp/8rq6IKReZ4OFLdRujmBTSmMnIUutJdUOBA5n0Or6qv8fQU/hPQaGo7s1Kj2/h6sf4hMltZgjh6fP7JN0MVsVvud9VpaB7HqD+NkWgXFXBkWtXUPHWJaLT4X/Wgvpj7CPGfFdiOpuijSecPmCKCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W33accMK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148598; x=1754684598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6NeEu2zkzsKnxuFEANQO7J0+43y/BINkKTkrvJKd3A=;
  b=W33accMKjo0+MbFtvwHbsOJoDWNHGP0bqOwm6b4c1f/zHiBbw2EZmAmQ
   zFEZF/yIHM74SJn5y8mBVYgvWze1I3k9vdNDSxi1GLqpI/P74l0EEluJx
   DylpLe5pYmWetSNy8ornwgE5pbwaNtKMHr18esUj/ZXz6K0uSyv4JSZYj
   WidBGesh5q6ZltcO/KUpynilQVLO9HNPYFh2PpdT9WDgB7bENRIixmq87
   t1ZkWwWq0msv0vXLosIbHJoWi468dzOFKT0L7bHT7vsr6C/02zzHkmejB
   SeMKZLYnxYmrGvyoA2MEB7sRqGCVSyyQpw8IycGtEBMSkxj0sBkUBhmE5
   Q==;
X-CSE-ConnectionGUID: MFIbsa2UTGWIANmP2beZAQ==
X-CSE-MsgGUID: SkPRXt/4QA6TeAgejoTnQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808864"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808864"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:18 -0700
X-CSE-ConnectionGUID: rVNMSKbpSoaopJyZDkIcfg==
X-CSE-MsgGUID: sa5vjnnjTt+2mYzpBXzApQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305339"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/13] wifi: iwlwifi: bump FW API to 93 for BZ/SC devices
Date: Thu,  8 Aug 2024 23:22:47 +0300
Message-Id: <20240808232017.5c9846f4c2c3.I6c825bc93aa23db302f24db5617f9b9b06042ec8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 93 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b230441abc16..fa1be8c54d3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	92
+#define IWL_BZ_UCODE_API_MAX	93
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	90
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 4ccb0b7bdc20..f1dd1c29f305 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	92
+#define IWL_SC_UCODE_API_MAX	93
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	90
-- 
2.34.1


