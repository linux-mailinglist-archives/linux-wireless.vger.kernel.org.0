Return-Path: <linux-wireless+bounces-26736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95506B396DE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500923AFD5C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5292E7BD0;
	Thu, 28 Aug 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgSEEAqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633B2853E3
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369607; cv=none; b=d9D2K21ao2aVND6WQwQnjFZE6zqnJ2E9VqzrAfZk/E997HynWQjjfI+BSPmmJdAUPLX/CjhSBPLvMcTr32HrZ9iwNDVzRGS4IbEqOvTsFcqA3nLF6fsCjR+w9GLbrh/CXnpV2uShT9ehflNBhI81WAJUtgGUNeMOPdIpizUk6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369607; c=relaxed/simple;
	bh=Z9zEr8GGnejR1JARw6qoSwQDey9svLHjwIF/GKSjnns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GT3jF/3j+c/2xbNrpC6Hzfs1D1qH9/YVuksTyaz5iiiqYW0Dp1ChOQJgSf5B4UtvmRAESDe8cjQrubPlmeNcf0pWG/lvuwYnoC/d8rzS6x7HfT+d5cBIagVO/SKRiKVohDDUblgLzxBshPIoqrG6VRRc9MWSI6kUwBe4BqXm/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgSEEAqX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369606; x=1787905606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9zEr8GGnejR1JARw6qoSwQDey9svLHjwIF/GKSjnns=;
  b=RgSEEAqX9qmk7zn02fJpRpucC3peA+yZc8hF3S4yRmxdSEO6VI+7W1hP
   EYtoBMPtNgbDd5BvXBwLugbULAbJv6B4F1Zb0wEeuYf865UZkdMXocpp8
   2LHIhJ7msH/JLICxA2udl1Vd1kCQCLvS39Cf5x4EdmKgIV+HxPFzSfE4G
   RxfLVxjzoCCH7dxQTK9o8RNzM791IKoNCOfQzZxe6OYhJjisnL89reuTA
   trnbN8eeD0XpbWsFBRuUmylBflOWsRuVsb0NyJpAf4Mohrij3S+8WL4pI
   cA0xhYl+L6svlqUsPTAegW/S6+i/iPiE9aPfLbVqGN+aVGuRsWFysg6Tw
   g==;
X-CSE-ConnectionGUID: I0dRzhu0SyK0ELLq6ptz0A==
X-CSE-MsgGUID: XX3PKxjvSjSj6rNepAM5HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003337"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003337"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:41 -0700
X-CSE-ConnectionGUID: pTp/hTmfRDWymzV+Jgg6pg==
X-CSE-MsgGUID: oaU9lnA/SpiOKEfXI9MMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224502"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: really remove hw_wfpm_id
Date: Thu, 28 Aug 2025 11:25:53 +0300
Message-Id: <20250828111032.78e84f722963.I1bc574a315cd5a587439974ee250887954589321@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This was meant to be removed, but seems it was re-added to the info
structure eventually.
Anyway, it is not set or used so remove it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 277fd4131999..9f09629e2ac5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -813,7 +813,6 @@ struct iwl_txq {
  * @hw_rf_id: the device RF ID
  * @hw_cnv_id: the device CNV ID
  * @hw_crf_id: the device CRF ID
- * @hw_wfpm_id: the device wfpm ID
  * @hw_id: the ID of the device / sub-device
  *	Bits 0:15 represent the sub-device ID
  *	Bits 16:31 represent the device ID.
@@ -829,7 +828,6 @@ struct iwl_trans_info {
 	u32 hw_rf_id;
 	u32 hw_crf_id;
 	u32 hw_cnv_id;
-	u32 hw_wfpm_id;
 	u32 hw_id;
 	u8 pcie_link_speed;
 	u8 num_rxqs;
-- 
2.34.1


