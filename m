Return-Path: <linux-wireless+bounces-28066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FB2BEE10D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3654E8AFC
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058829D29F;
	Sun, 19 Oct 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGGoIPwL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D029D270
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863547; cv=none; b=o3DWOY4CPFFixdSVTQNXPJ3LP42OP63VZ129NHovjxlWSGWWl6yFklerD7fP/eCKHVVSXcMqHVRIkDGoj5tT1L2oZua5UWI6Abp5yPQ2SDh9DFmzTYjDEdynTlGo1ucLCBxxvXwMHKMTg44OrFEKV0dO9vK2wF+T1oPuAxICDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863547; c=relaxed/simple;
	bh=UmmB2+s8mHGQJDlvQMLBO7+zH5Af/o6Dv1qv5FcSCxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3C9R6Y07hch88w8A6SpwIMW/3G3bq+34ShwrJXFFXZVKgH/5puwwgOtPPGoV5Z+vfdwrcyVXvVQEVZQ+Ny6hsmFr0CdBUQEzb6LvfrQw1/M8GfyjNCwArE0HYIREEPbwTRbou3hccK3lREeg2L9WWM2hq0yq7nLDZ5bZfQL028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGGoIPwL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863546; x=1792399546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmmB2+s8mHGQJDlvQMLBO7+zH5Af/o6Dv1qv5FcSCxk=;
  b=iGGoIPwL+fg/GWtEn5MhPiefk9tKMHJCagr05X3PT1K1ICCMPQpaX3MN
   3tuWC9240Qav6xQZG3ZiALX77WzyB8zS/pdaQNIrBkeJeb4d8q1bhsCud
   we0WdlH/X0P8pBT/FlJ6pTgOS/lXxsHXVvPRy0/a8mY07hHU8FcNjpSTl
   bgiQQlwgKSY8t2iqwY0Fb5q8ii0AslfxRuCRfwZrmI/28Rk59Vny8/4E0
   4f/bc90iqjXrC45PP58mdRM+AvXHKJY9T+FUREAOapGw4Aoc0ZhtN/Mah
   Pe40bDBRygl2rub7919LEjOf34KCoG7WhUuzefTShaBrPLIxuQUypUp4h
   Q==;
X-CSE-ConnectionGUID: 5mXK6eTDQU6L8yNVqzKpJw==
X-CSE-MsgGUID: p70dNNrxRQuaHTqNdUB1UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363191"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363191"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:46 -0700
X-CSE-ConnectionGUID: 70XxlDi+RiC26g5aGZASUw==
X-CSE-MsgGUID: Gzh5i8CAT06tGzS9u2QUmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279899"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: bump core version for BZ/SC/DR
Date: Sun, 19 Oct 2025 11:45:12 +0300
Message-Id: <20251019114304.23300d52cd8b.I6aad50aed469d7734c165086796dfa9cdf9d81bd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Start supporting Core 101 FW on these devices.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 28005f25c38b..d25445bd1e5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	100
+#define IWL_BZ_UCODE_CORE_MAX	101
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index c1c6174534d7..a279dcfd3083 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	100
+#define IWL_DR_UCODE_CORE_MAX	101
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index d9943d252ae0..ee00b2af7a1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	100
+#define IWL_SC_UCODE_CORE_MAX	101
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	100
-- 
2.34.1


