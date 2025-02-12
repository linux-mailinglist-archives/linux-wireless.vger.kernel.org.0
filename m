Return-Path: <linux-wireless+bounces-18810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFAA31E1C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2110161057
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95681FAC58;
	Wed, 12 Feb 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JV/H8BY6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC681FAC4F
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339036; cv=none; b=RJWWADLvpAs/UyotFolC1aTakqobYnBgC2XHIE1+rax8wTvEOkN+CFVxtOs3cRvZLK2ZskRtrOteO815Pat+o1zr/wSlzoJ4k0U1/qgEqCI1u/qJ4dL4Y3neWMcQtVSr9XEWIFW1PyGl997PJDiJ/IgPhtAs2vL2WZ0JbWMV/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339036; c=relaxed/simple;
	bh=GRHgJhQ3YjSnvDxzk+WwEvWGkokdjBuwq7vghdfnmBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIgJT3T0nUzazF61yuJ6m8ZZEweJMJtWFzCy7l1LybVFn8b8UQJc261V2gHqGYkLRB/kRobtLKqBIIaVJdn+6KT74RYMRlh8DUg54mQdLr/XmS2FLlWeCLx+LcqSn5a6325Icnp4yBAV5djcvLpclCXgNrvjyZ+6P8wFgbg9RqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JV/H8BY6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339035; x=1770875035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRHgJhQ3YjSnvDxzk+WwEvWGkokdjBuwq7vghdfnmBA=;
  b=JV/H8BY6jVOKRThpwggrdJ1mHKlzaXe4br+5rk6ujUckO20BkENUul/h
   DIv9UYtBEFf4QajQSsYsn9ogaRE0vRcpPN6Hh1xozdQGSJOnr91oEn3ON
   Fam4tJ/rtnP4yLiXlanRRpm9wX7PLppWChHYA62rqt0LFA/HzKEjg0MCf
   kpFvhzalynon3HmbshKkR9DHChf1X/8cLK8pP8HC3rGQ7fYTT/Udo93Ow
   ebVvu3fj0nwQL9d5lLM2z3ttgWH7jVS2q8OVcP5ez7ysXq++o/2xiIXtq
   a1941dCV+8s9crBVn0qtl7gMEn4RqJFWCQPcCs0G4ZEMCibLT8v3Bbr2G
   A==;
X-CSE-ConnectionGUID: r+Le0N6/T7WuMMbHeSl2Aw==
X-CSE-MsgGUID: X3EyBxM/S0KLDFl71tec5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172215"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172215"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:54 -0800
X-CSE-ConnectionGUID: Nxhb+TuQTEKr5mqOsgJMpw==
X-CSE-MsgGUID: b4AGMy5RSHO7LSpRLjY0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893851"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 05/12] wifi: iwlwifi: mld: add a debug level for EHT prints
Date: Wed, 12 Feb 2025 07:43:26 +0200
Message-Id: <20250212073923.9b1e0d87e7e4.Iea6c1329f7b6312a73896f9a9d9bce72bd6548e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is required for EHT related debug prints.
As there are no more available debug levels, delete IWL_DL_EXTERNAL,
which is not used, and replace it with IWL_DL_EHT.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index 5377dda9ad53..ea32dc88584f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -166,7 +166,7 @@ do {                                            			\
 #define IWL_DL_RX		0x01000000
 #define IWL_DL_ISR		0x02000000
 #define IWL_DL_HT		0x04000000
-#define IWL_DL_EXTERNAL		0x08000000
+#define IWL_DL_EHT		0x08000000
 /* 0xF0000000 - 0x10000000 */
 #define IWL_DL_11H		0x10000000
 #define IWL_DL_STATS		0x20000000
@@ -176,7 +176,6 @@ do {                                            			\
 #define IWL_DEBUG_INFO(p, f, a...)	IWL_DEBUG(p, IWL_DL_INFO, f, ## a)
 #define IWL_DEBUG_TDLS(p, f, a...)	IWL_DEBUG(p, IWL_DL_TDLS, f, ## a)
 #define IWL_DEBUG_MAC80211(p, f, a...)	IWL_DEBUG(p, IWL_DL_MAC80211, f, ## a)
-#define IWL_DEBUG_EXTERNAL(p, f, a...)	IWL_DEBUG(p, IWL_DL_EXTERNAL, f, ## a)
 #define IWL_DEBUG_TEMP(p, f, a...)	IWL_DEBUG(p, IWL_DL_TEMP, f, ## a)
 #define IWL_DEBUG_SCAN(p, f, a...)	IWL_DEBUG(p, IWL_DL_SCAN, f, ## a)
 #define IWL_DEBUG_RX(p, f, a...)	IWL_DEBUG(p, IWL_DL_RX, f, ## a)
@@ -218,5 +217,5 @@ do {                                            			\
 #define IWL_DEBUG_FW_INFO(p, f, a...)		\
 		IWL_DEBUG(p, IWL_DL_INFO | IWL_DL_FW, f, ## a)
 #define IWL_DEBUG_PTP(p, f, a...)	IWL_DEBUG(p, IWL_DL_PTP, f, ## a)
-
+#define IWL_DEBUG_EHT(p, f, a...)	IWL_DEBUG(p, IWL_DL_EHT, f, ## a)
 #endif
-- 
2.34.1


