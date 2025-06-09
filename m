Return-Path: <linux-wireless+bounces-23865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07443AD2570
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D3716CEC4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8BE21D5A9;
	Mon,  9 Jun 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhWgcR9T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD521D58C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493316; cv=none; b=oUEUQng6LwwQt+KRXn/SRYfy1CgdtfqYuQWkwBL47x5tcDF87tGFFJMU+HjE/WgDkmKMUu7QjCbPtQ2rXKP1LI394IsGjSHlT2njHd2wnY6QUy1RPxL/upEpbMWNiX3Ebnsq76DhMeOYshm2qWgQ3CBvxSRucQCW/Qh7SH9xyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493316; c=relaxed/simple;
	bh=OAVKdxtiMVg920yS4evDJMx+iS7vGknf+KvzIj+nEYM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1EEGy2zF1XJv9F3pCsRnDMniEgATAdVVBPPa5MeyUKJLCwvEDj2YYYtTf/Gxmgwh7Dlhev3mPULq69s89EPm7zS/F82QMfjkHfgD9Zo1pL43tdhS8Y9dgZ3h1B1U9AMj2wR/PHKtuSja/mojqDQ99dC0jrVO8VkRybS/klyKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhWgcR9T; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493315; x=1781029315;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OAVKdxtiMVg920yS4evDJMx+iS7vGknf+KvzIj+nEYM=;
  b=GhWgcR9Th0MvK6R9kj5Lh0Zf7K66EA9qslpDEs7uLi42P7xgUVc19Uug
   y/l1pJXDe8i5jTFlYqkPh/nBW7wZgWM3o0AKrrk6k4uzy78oizd+y0VRb
   WyJSFlae9nt5ZONQbX7oOwTh4BAopjwFNAgOM8qbnAY5cvCETqjdMe8MW
   zGu+Zmorr64Wv8IMhMZAF0Ti6zvaUE0VcuU9t448mpZb4/Rwj7aRdVdjj
   6ln0HwoWugxONDhVduO+H42WHh+Xc9nxGD9w9t7xHiTCTctCuCf7knmj8
   btpRR6Oi773rrk8sVup3Jo6gStGRGHUjioq9stHn/pyHvOXk1VJnImcXb
   g==;
X-CSE-ConnectionGUID: 2WH6ApJkQ6uyuDEA4VebCg==
X-CSE-MsgGUID: pejQVY0mQG+0bdUNYzRM9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237680"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237680"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:55 -0700
X-CSE-ConnectionGUID: aNw9vKXeSH+jlUU5eItlRw==
X-CSE-MsgGUID: e2fXwFTOSM+HglQzGWxrjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510275"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: bump FW API to 100 for BZ/SC/DR devices
Date: Mon,  9 Jun 2025 21:21:12 +0300
Message-Id: <20250609211928.b390724143b1.I53b0c631875af91d6c672d1712260ed2858a1c5d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 100 for those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 05e45fff8b36..600206432c25 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	99
+#define IWL_BZ_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	93
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 45e55cef42ea..5de7a530ae68 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	99
+#define IWL_DR_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	97
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index b2e4d4035296..97545c2a3b00 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	99
+#define IWL_SC_UCODE_API_MAX	100
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	97
-- 
2.34.1


