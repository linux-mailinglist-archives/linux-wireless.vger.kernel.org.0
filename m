Return-Path: <linux-wireless+bounces-9548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD1C916E85
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885A92891AB
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AB2175573;
	Tue, 25 Jun 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxDn71gD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863B176230
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334316; cv=none; b=kC6JuiO2cUnWlEe60+RRCciCxsfTW8ZPYihqTJkUuBil4+mWwOVIPRJf9b3nqMpT+JtWffsZmLXBxyvezNBtfR4C+O9Z+OA10m9v0FOEGO91TwIF8ecmLZSCVRligGx3mRmjIKy6apCx9C705qOeawBLce16x1qM5Hq+MWj0J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334316; c=relaxed/simple;
	bh=MV0X6qAhp8f5VAa/OhcT1wsrNp7O4w1ir50I4Htxuso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbF5NJ19jOLPVMvFfp99dlY7ePaPQbgyVtgT8JM32Z+7HOqD5yVGPzgOAhhi9GFEeETQQPcaGx0EMSv0X2M0cJIbUBFERMwo4gyW+6wTIe9aTs0iU+zQsC519HY8xFxfh8hJ/nuFeoxUFGh5XQTmGFBOX1WKD9xp2VcnTycGPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxDn71gD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334315; x=1750870315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MV0X6qAhp8f5VAa/OhcT1wsrNp7O4w1ir50I4Htxuso=;
  b=hxDn71gDtaD68nefwmfpVTVBGBjJF0NCNN34DZDPPU20d87um46wQ1T0
   n8kCwrVsffxhhbLPARoAkzRAwg8wY35oRBWiUVnNuFk0hgD8WH1yK847A
   +RtHO7WiUWhu7ix7I4nd5rvI4btZHsNbae8939qKaVPuVlDkGYLeSyxyp
   oGifqLxcSd4v84aYyg7UZX0xV8YkRD3WfHH8dxBUvFMls85d6rurDhd2l
   qu+NrNs0hl8F5zAGDpVqTiCHqr+MuNQwVII0j/kflx9gw9OecGJPJOmRJ
   uGq5Z+KneVtt1wSZyALYAjAEahd3Ujzb+K3VFymMFlesxP2CCv/bsEFcq
   A==;
X-CSE-ConnectionGUID: WrLyQO3RT4GOvLm98hC8CQ==
X-CSE-MsgGUID: zdwi3iU9T9O3Zy0C7mjdUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594792"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594792"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:55 -0700
X-CSE-ConnectionGUID: 8/jk3GOeRAWzszvT+U1Idw==
X-CSE-MsgGUID: vFRS339WRqqputYp1toXxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632855"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/17] wifi: iwlwifi: fix remaining mistagged kernel-doc comments
Date: Tue, 25 Jun 2024 19:51:21 +0300
Message-Id: <20240625194805.98119856de4b.I9ca0cee675b166c4a7d58d619ce3278494398ea2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are some comments left that aren't really kernel-doc,
remove the extra * that tags them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  | 6 ++----
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 4511d7fb2279..98563757ce2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -304,9 +304,7 @@
 #define CSR_HW_RFID_IS_CDB(_val)       (((_val) & 0x10000000) >> 28)
 #define CSR_HW_RFID_IS_JACKET(_val)    (((_val) & 0x20000000) >> 29)
 
-/**
- *  hw_rev values
- */
+/* hw_rev values */
 enum {
 	SILICON_A_STEP = 0,
 	SILICON_B_STEP,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 898e22e0d1ab..dc171c29eb7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -96,7 +96,7 @@
 #define DTSC_PTAT_AVG		(0x00a10650)
 
 
-/**
+/*
  * Tx Scheduler
  *
  * The Tx Scheduler selects the next frame to be transmitted, choosing TFDs
@@ -169,7 +169,7 @@
  */
 #define SCD_MEM_LOWER_BOUND		(0x0000)
 
-/**
+/*
  * Max Tx window size is the max number of contiguous TFDs that the scheduler
  * can keep track of at one time when creating block-ack chains of frames.
  * Note that "64" matches the number of ack bits in a block-ack packet.
-- 
2.34.1


