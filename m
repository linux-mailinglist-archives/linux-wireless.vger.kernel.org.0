Return-Path: <linux-wireless+bounces-9546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC3916E83
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE041C22B1F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9517C7B4;
	Tue, 25 Jun 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsR2S9nB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEC17C235
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334312; cv=none; b=lo+nvSVWNn16t8xQ2zWrpRSjqNJCql1sjl96E0N5+uYhU3syX6bBTyNgleCj7shN9tlLrrRuaEhzIh89hwthse5CZ+rSQu4jK8/hLsf587WxFPCEK8LU8JZiMFQvnaH6CJyoTG7pHk2gBVTBAVld5bggBTEqgsG4u3ChB5EkLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334312; c=relaxed/simple;
	bh=12F2cUkiDaDX4KnjoEPsGxMEqv5dQqv/LfjIN6ROw7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYcN6cLPS9dXw3VnJNq+ZU328Hg0MP42QixxIhcSbYdz4alYRumxCohh87CUVoPK7Tq/S7VvXt8gB3KrWV+71nuTwTm9akpLmY5VTEuxhy1eOf1UZiii73XX1Bfd5PTXU+AxlM41Bwhy6zvfE+Rt2pZsuDUTLvbte36Jivg1g10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsR2S9nB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334311; x=1750870311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=12F2cUkiDaDX4KnjoEPsGxMEqv5dQqv/LfjIN6ROw7g=;
  b=hsR2S9nBOLrLqN42VHdMJMzgWabIvj5SKVZgk7MoN+XSBhZ2LkY7vCkQ
   6Dcn8sn1iLRBSBl6TQdSAC98uwaim6cvQyZQUo3dUKcnxk6qN7ntuXbyo
   ure+EiEiMSH6Qr+EiAGJQARdBxUPHBPnjLAjKXGLBpSS2rnZ6O+8FT6Rd
   qak5DdBV3ipPRd0Ktn2Fb/MsYbEmsziXxLIldJD1IV70OUYAvuXtfjKro
   0k6KCNSFPR4ohdzzTpSI9gwsOCqAhOCaAseG4bQGIFO4VakL57XPp/Itz
   EU5PMKCc7ouBYpNX34avDsOAcFwZjKtsoR6WbbQknnVGFL113HBYoFLzc
   w==;
X-CSE-ConnectionGUID: bwfL4rzETve1UdoJaWUIGw==
X-CSE-MsgGUID: Yfwl8At6Sla2zkCRKGmBBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594775"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:50 -0700
X-CSE-ConnectionGUID: 99i+g9AzT7SyYEdPNjUZVg==
X-CSE-MsgGUID: CXz+KmjGQ++tKT1NY3Z34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632778"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/17] wifi: iwlwifi: fix kernel-doc in iwl-trans.h
Date: Tue, 25 Jun 2024 19:51:18 +0300
Message-Id: <20240625194805.4846bf27dec1.I31fdfad01abc82b1340c59e51ece3db2242c8816@changeid>
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

One mismatched enum name, and some missing docs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ac8f8ff5a99d..ecf94ec2c2b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -129,6 +129,11 @@ enum CMD_MODE {
  * For allocation of the command and tx queues, this establishes the overall
  * size of the largest command we send to uCode, except for commands that
  * aren't fully copied and use other TFD space.
+ *
+ * @hdr: command header
+ * @payload: payload for the command
+ * @hdr_wide: wide command header
+ * @payload_wide: payload for the wide command
  */
 struct iwl_device_cmd {
 	union {
@@ -273,7 +278,7 @@ static inline void iwl_free_rxb(struct iwl_rx_cmd_buffer *r)
 #define IWL_9000_MAX_RX_HW_QUEUES	1
 
 /**
- * enum iwl_wowlan_status - WoWLAN image/device status
+ * enum iwl_d3_status - WoWLAN image/device status
  * @IWL_D3_STATUS_ALIVE: firmware is still running after resume
  * @IWL_D3_STATUS_RESET: device was reset while suspended
  */
-- 
2.34.1


