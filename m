Return-Path: <linux-wireless+bounces-24066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46299AD6F77
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276641BC4E3E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE933246769;
	Thu, 12 Jun 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro3sAMKI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2C24337C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728971; cv=none; b=IdwAl6J2EqCdIRARtj5+vFRxyLCN6N8NEBV5JSvvRh4xeN0g4ssWeSFy1x/EuBeHRMwuFkeKmcjm5QcBHq9ASZqTPNrhuyJwL0TYjr5cn5asAWyt4kndc4Rg9M38tfW109N/HvurqiOlclKiM/4JAHnki49o8I2MSn1eGZIog5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728971; c=relaxed/simple;
	bh=PH2H5Iy6b5UA2uGzi9GH9Bv+OYejN4iKyi2d+lj6OCE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmUoX8NZwRcgHfqq+e5UtQwKn1Nlwair5wuoMQmf0eJzQPvraT88clJW/H3YziVdCRMwj6D1QwZyya9GwI2Y9MNbi62USA8Ok2QDuLJw1lUBYLKr6M5EjU6XjDryXTM92vTwaGNHS1NM3trRkiG+gqJ0gjckNEwimF/YgSbaU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ro3sAMKI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728970; x=1781264970;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PH2H5Iy6b5UA2uGzi9GH9Bv+OYejN4iKyi2d+lj6OCE=;
  b=Ro3sAMKIl3JQkR1BQjOzp306juR/JtCaIGYbB9+YO08aZbAj/Roc1/Hj
   nCY7ZyTZZVKg5xQ157BJnHC7rRyUzkOcuiq1JK87hGAGQ3s+zjeOnLOrp
   u9dFXqQzgLL1dCTcQBd8YT+gieZxekUfFojvJxGBKZjfkRExXW7JONBQf
   KBiFVouWfEkTU/j/9OBJObN3d8VTeg1GSdJ7F9KqB9Qdom1knGuDncP5M
   4ASlYWaAsZzjTvc5aIazYyToj2iPzlLYYrLPYywPrUgLRYDsEFfoKfoEX
   7/O0LQ624XUbe9jblVvYW85XzQmhUkFspgneBsAVcvqVf9jupZWahdo+B
   A==;
X-CSE-ConnectionGUID: ayO3+c2VTci62OwH0th6Ew==
X-CSE-MsgGUID: jXnc3NNwS2yOTkBR8f+cVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248349"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248349"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:30 -0700
X-CSE-ConnectionGUID: jWB9FZ0YTVqvV4Isvd1O2A==
X-CSE-MsgGUID: W1dKlf+zSwuQ922i0TLYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382181"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 12/13] wifi: iwlwifi: bump FW API to 101 for BZ/SC/DR devices
Date: Thu, 12 Jun 2025 14:48:58 +0300
Message-Id: <20250612144708.218feea370ba.Iae8edc9212fe5b470a07d8e54db27f2046554fbd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 101 for those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index e616c0381360..cc47fef682fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	100
+#define IWL_BZ_UCODE_API_MAX	101
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	94
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 4dbf3d3694b0..f7052b396d79 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	100
+#define IWL_DR_UCODE_API_MAX	101
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	98
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 44bc0274bc47..a9b1932657e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	100
+#define IWL_SC_UCODE_API_MAX	101
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	98
-- 
2.34.1


