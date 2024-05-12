Return-Path: <linux-wireless+bounces-7539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22808C3677
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681261F2203D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF528DA4;
	Sun, 12 May 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrM5JTY+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CBE250F8
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516722; cv=none; b=IA7xcVjJ0bm+tolkpO10M6mhLZ6HGqpTyuvwsqiC3bE5OkCUrrxjTdOKCo+P43q4Hk+1j1xn8zBGx3VqG983GjJW+pjwhT0CgG9vVnj6kIlQyMgYGVKuEanDF/epecKPD3tWoQ1IKh97ZZsLRa/iM4xWetsP63unZuihdsMfqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516722; c=relaxed/simple;
	bh=6Bbc8AeZLnsSq3wzyk5UJ8COSr0MZymdtvxCqmVnyCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8+FwRASXtbYGY3Vt5eJZaN38BeopaIwQyX0BjeegKVRJhDwhw2Nknd0LWm8/rMvZaRbkQc8w/rJZkkxwjt++EgzxhvYiOjVoesmke/HilB97GP5tsXzAXAOG+PdYvn/giO2UkOjwOeEb1zzOIQLBje86ebjCKKjOtHJ3VYfW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrM5JTY+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516721; x=1747052721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Bbc8AeZLnsSq3wzyk5UJ8COSr0MZymdtvxCqmVnyCU=;
  b=jrM5JTY+WOQQFCZpkFlGFclotbVoisk/V/rbH3X3/jxNbFFoRUpEJoCz
   sYyZRBAk2+gKiGX7c0ugf8c3lAkpjOFVeWCT+xY0UftThAwf5C+ghehYR
   L7GsnXkeq55EIta62xOu3irEFjJeMOOyc8TPRct2USBJG4sybPz/KcvcU
   MOUm8ufDoqupRHrbX8Qa8iVq18M7Cu4fM4G8DUjDExulzF3oEpKLTZCzj
   CGWDdmp3GsSCUj/fSB7wt2FQmuiDxMSi9Xi7q6C3Z7uZxJajj27u10eB5
   BVf6PEMInp4d1sfohW+loIZ9zFfZLmKyzrtbE+Kl4flpLuUioG8kDuV79
   w==;
X-CSE-ConnectionGUID: UPsSb9huTBCZPf1p47Q8UA==
X-CSE-MsgGUID: wKkDLIU8T82XA4J6SJJ5/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397194"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397194"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:20 -0700
X-CSE-ConnectionGUID: nLqn+ShhSWW0Q+deGeZInw==
X-CSE-MsgGUID: fxhsaId4S5iQHpLIZIVlMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: simplify TX tracing
Date: Sun, 12 May 2024 15:24:57 +0300
Message-Id: <20240512152312.a3d3b4796460.I85bd3029baee24ebf0be04db7d6bf01834090869@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to calculate again whether data should
be included or be handled externally, just check if any
space for it was already reserved.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
index 2c280a2fe3df..0d4a0896a2c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h
@@ -3,7 +3,7 @@
  *
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019, 2023 Intel Corporation
+ * Copyright(c) 2018 - 2019, 2023-2024 Intel Corporation
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_DATA) || defined(TRACE_HEADER_MULTI_READ)
@@ -28,7 +28,7 @@ TRACE_EVENT(iwlwifi_dev_tx_tb,
 	TP_fast_assign(
 		DEV_ASSIGN;
 		__entry->phys = phys;
-		if (iwl_trace_data(skb))
+		if (__get_dynamic_array_len(data))
 			memcpy(__get_dynamic_array(data), data_src, data_len);
 	),
 	TP_printk("[%s] TX frame data", __get_str(dev))
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
index b9aa04cf1d83..ead72c3d33bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
@@ -99,7 +99,7 @@ TRACE_EVENT(iwlwifi_dev_tx,
 			__entry->framelen += skb->len - hdr_len;
 		memcpy(__get_dynamic_array(tfd), tfd, tfdlen);
 		memcpy(__get_dynamic_array(buf0), buf0, buf0_len);
-		if (hdr_len > 0 && !iwl_trace_data(skb))
+		if (__get_dynamic_array_len(buf1))
 			skb_copy_bits(skb, hdr_len,
 				      __get_dynamic_array(buf1),
 				      skb->len - hdr_len);
-- 
2.34.1


