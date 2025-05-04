Return-Path: <linux-wireless+bounces-22398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90580AA85FB
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413C6178A56
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068281A76DA;
	Sun,  4 May 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngaW9ZdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA61AF0AE
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354432; cv=none; b=tKSgFBOQUZpGTwtshELX4cFnleJ8eKXSrYijnFn33t8Mq3aAibCzfl7kZxxrDQht6KqfcdlKFLAWt4mDpbiY8pBgGuAgCw1mx+5+lmI4An2KZWmEKqqf7NRfyZq7iAl6Iwxziq+/JteJNEiAV1dTFYyvUzSJsJYVLHWJDjsoG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354432; c=relaxed/simple;
	bh=u3cHt+kL3TPmssUYJk6cQXVabLllB1lUpzZJfgFeCuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpboslL7cJHcjpXRVLQWRpHGFNevlP0tL56MxFyN11r89udgEJuH/jeQu0dlmgGE25rhTfZAZQIOAa2OxMEwHgWtt8vEGnXJffyySkY/1/fAalxhX0MpZpKsn/ghuOkjK915hxB19Y8puEVJl9qq+Aopqh7YhWSqKF4Gv8vaZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngaW9ZdN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354431; x=1777890431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3cHt+kL3TPmssUYJk6cQXVabLllB1lUpzZJfgFeCuk=;
  b=ngaW9ZdN5fiwKalL7ffXjk6+lYmHtLVMzY0WtnhW3QiPXKw/YkOcmA21
   q5gTcc8QDFQtcEEDhSfW6YhoxZi5D37yVSi0sfaZh0lXXqQrzUahhMZYg
   Aa063U+Y6uo3SM/c22A4oeZJlGscZoGsAqAlVNBGNOdx+kwrhqs6fJIkS
   PINi0qqT2lJqY1cUX0E568wPu3VL4TzLKcGClKafuEZCVwYY3cMl2m/aO
   +ZewxLrtykDY3jm3RqIzeP1lTJ5zu8MqAQLeHzRihnl+9FWuJoU6JVvmT
   GN/TavcUaeiqn1sJhLqNW46foRaiCtiSDEZET6muUWCGdTFoIt5VotBOh
   Q==;
X-CSE-ConnectionGUID: Qebt8xmwQAma0EOOWkH1Cg==
X-CSE-MsgGUID: aM3aRGPKRnKKY7zRFJj5DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511513"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511513"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:10 -0700
X-CSE-ConnectionGUID: 9KJ4P10rSEuhr6Ox8EVntQ==
X-CSE-MsgGUID: +GjKCEI0SkKAedPTH5Ir/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778913"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: cfg: use minimum API version 97 for Sc/Dr
Date: Sun,  4 May 2025 13:26:28 +0300
Message-Id: <20250504132447.2ab49f2265ce.I45623943fdcac3462d96e54dbb7fdad68bdf3693@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For Sc 97 might get used (at least for now) and for Dr
the older 96 won't get used. Change them both to 97.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index c4f637627901..c041b9c11810 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -12,7 +12,7 @@
 #define IWL_DR_UCODE_API_MAX	99
 
 /* Lowest firmware API version supported */
-#define IWL_DR_UCODE_API_MIN	96
+#define IWL_DR_UCODE_API_MIN	97
 
 /* NVM versions */
 #define IWL_DR_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index a0b5c4b8fc57..40e671e69fef 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -13,7 +13,7 @@
 #define IWL_SC_UCODE_API_MAX	99
 
 /* Lowest firmware API version supported */
-#define IWL_SC_UCODE_API_MIN	98
+#define IWL_SC_UCODE_API_MIN	97
 
 /* NVM versions */
 #define IWL_SC_NVM_VERSION		0x0a1d
-- 
2.34.1


