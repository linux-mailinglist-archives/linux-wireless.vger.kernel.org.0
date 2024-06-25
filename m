Return-Path: <linux-wireless+bounces-9544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52586916E80
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DBD1F22B47
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1BB176AA8;
	Tue, 25 Jun 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fH7jlByW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32D176AA2
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334308; cv=none; b=Inbz3IGuWCDGg0DdsOW4Hi0Zn9Ide3uiaF3r49+3cOc0MsGVSRFnybS6JrlMJMkhzvFBpP3KZ0JNMCoDPCOcT8zsoj5zIVJkaZkSlFM89ygJ/QKTBFBD7i/KBzCmxHcvY0rayhTkBvDg7U493YjF/K+dHQn0CmGD6bcNScuYmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334308; c=relaxed/simple;
	bh=ToKd60Mh+AVt6Q/PEUbh0bFpngBPstdkIITJyPWvxe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/hcgn9vzqpUkyjWg5NANbABU5qQzKiamAHMmqhEIS/R8JYJFvZhBpcSEVwrwgGUq0iJJA+7Hg/aUyZWv72ndJi8iT/HiOwhwc0juRcQSFSsGCRBCfpHfwNv1UdWmJPbf6qCS1HEtjGhzPCZFhISaf//tuSmYseYNhpZj/QDZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fH7jlByW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334307; x=1750870307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToKd60Mh+AVt6Q/PEUbh0bFpngBPstdkIITJyPWvxe0=;
  b=fH7jlByWLesldwGpb+z+EWqy9sp6W5mP4aRRKJnDnn+j0XQ5LnAfMPKS
   j+oP9yosGDrTy1Xown3rxfW6M3V14tY8Cn8V1P47r1/oUuXztKZJ9zy4w
   bAMUZZEXOE7iQ79vJvXeV0UD8YDaHNOFXq0I6cUeZkM0+UnPtl6Y8hgtj
   OJSvn2yJPgUPKyHIwjcD1kZqCurTzZEKO1+LULuR/+FDLaf4aFgjMV4YS
   FXfhzXEOQFnhJIvbkMWAeCGsuzRFErQ3vT1R2GQksL0LohLCNg/3ccsPj
   zR7CjhyjKjOG2qPO/FBUyzYo5WvrXchkqAFRtPVk3t7Jla/KWYX9/LGzF
   g==;
X-CSE-ConnectionGUID: 2PVZ+khUQUW9/SljFbmfxg==
X-CSE-MsgGUID: r6pDBwNrSAqNI3EQ8pqPzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594756"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594756"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:47 -0700
X-CSE-ConnectionGUID: nSvpJdHjRta9sohZ+ofBsw==
X-CSE-MsgGUID: zmA5wnTvR3ytU0Cc7SEKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632699"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/17] wifi: iwlwifi: dvm: fix kernel-doc warnings
Date: Tue, 25 Jun 2024 19:51:16 +0300
Message-Id: <20240625194805.8b12f56bf8c0.I64fa9df72ca0e862b96647c062b8c9464318e649@changeid>
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

Mostly the docs just aren't kernel-doc anyway, and one is a typo.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h       | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
index 04864d3fda63..3f49c0bccb28 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2023 Intel Corporation
+ * Copyright (C) 2005-2014, 2023-2024 Intel Corporation
  */
 /*
  * Please use this file (commands.h) only for uCode API definitions.
@@ -177,7 +177,7 @@ enum {
  *
  *****************************************************************************/
 
-/**
+/*
  * iwlagn rate_n_flags bit fields
  *
  * rate_n_flags format is used in following iwlagn commands:
@@ -251,7 +251,7 @@ enum {
 #define RATE_MCS_SGI_POS 13
 #define RATE_MCS_SGI_MSK 0x2000
 
-/**
+/*
  * rate_n_flags Tx antenna masks
  * bit14:16
  */
@@ -2767,7 +2767,7 @@ struct iwl_missed_beacon_notif {
  *
  *****************************************************************************/
 
-/**
+/*
  * SENSITIVITY_CMD = 0xa8 (command, has simple generic response)
  *
  * This command sets up the Rx signal detector for a sensitivity level that
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
index 23dfcda0dd86..4af792d41dce 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tt.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /******************************************************************************
  *
- * Copyright(c) 2007 - 2014, 2023 Intel Corporation. All rights reserved.
+ * Copyright(c) 2007 - 2014, 2023-2024 Intel Corporation. All rights reserved.
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -64,7 +64,7 @@ struct iwl_tt_trans {
 };
 
 /**
- * struct iwl_tt_mgnt - Thermal Throttling Management structure
+ * struct iwl_tt_mgmt - Thermal Throttling Management structure
  * @advanced_tt:    advanced thermal throttle required
  * @state:          current Thermal Throttling state
  * @tt_power_mode:  Thermal Throttling power mode index
-- 
2.34.1


