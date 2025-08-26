Return-Path: <linux-wireless+bounces-26650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF8B36F16
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163997AC603
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E6369325;
	Tue, 26 Aug 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1LfNcO3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D5352063
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223755; cv=none; b=pjbtTpnyhx61W1kBP7f1GX5pyh1jBTO7z5BjsA7t35LxRGDSkIE6RrG+CXgZ+1+icPRKn4v7IZIM7j1gL1BuWpv6YocjHuQmdvalZHK+RNIXRfpNO7we7EOFlOQb7Uggf2R4IaxEc6HvIiTYfCc6KxAP6dPRwvWimIhTDN4Is20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223755; c=relaxed/simple;
	bh=f3w1lsFBJHsQ8GOQk+CJA5z19j+eFSyYcT1084iiUHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JtCafdaYeSpl9P6yTj3as/MuNClBBaux5s25nlItZ0HXoZbU5TTodL7D58FWm1Y9F/Xmex+p5B5pPjZQsP63QUQA+lyN/Skmr0aLtquTAtv3HEYV8wcxRPt7zzMUKfzFHgoj8yGcdqOY63OchV2JQIiD1Mmv4TuzfPvBu30C4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1LfNcO3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223753; x=1787759753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3w1lsFBJHsQ8GOQk+CJA5z19j+eFSyYcT1084iiUHs=;
  b=W1LfNcO3WmyR1KBywwU1JTpljiXkylf064VKKlb2sEQCjJhSzkjRyP08
   HckiZshh3ItiVYF7PGJqDfFbGwrGbJq0SMnlkQ74Mh/tYB2UaxQH0Foo6
   BHcF1WoMYT8vzEP5il40hlKNxiKC8oDQkx9qTq0XXNtmJFa1IQSXfX0h0
   0rsv08FSNeBuPZ9ZqAPrt/0thK6D9VLGnHgOEo4njEOL7B7ln+XrQ0LK7
   HrKI26HDYErNAR5rzV43SiImJWncKS4IF3VhoOJGu8PtM7Lnm8Kip9+mO
   kEr0prWva9kU+NVNSCgMT2pOKg4k775Yb2StZBfFwZ/KJzFU6C4r0Mfj7
   w==;
X-CSE-ConnectionGUID: Xlz1s+KhRmqOlcafk1OHjw==
X-CSE-MsgGUID: mpKcIglzQpKSwAZyXS36eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108440"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108440"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:48 -0700
X-CSE-ConnectionGUID: LykcFHK1SXu8YxhzpEadOw==
X-CSE-MsgGUID: 4KMwQV2ZQI2CFL8WPYHSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218368"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: iwl-config: include module.h
Date: Tue, 26 Aug 2025 18:55:03 +0300
Message-Id: <20250826184046.82a9e8f37c37.I5f4b310784bd49273ac905a79e8e3e0f39e15107@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This file declares a macro using MODULE_FIRMWARE, so it should
include module.h to always guarantee it being available.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index d27c9ec151f4..a607e7ab914b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/ieee80211.h>
 #include <linux/nl80211.h>
+#include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include "iwl-csr.h"
 #include "iwl-drv.h"
-- 
2.34.1


