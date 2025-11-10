Return-Path: <linux-wireless+bounces-28773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63325C46BF6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A7B188EA30
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30C2FB970;
	Mon, 10 Nov 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9RTmrXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABF30FC3D
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779763; cv=none; b=TBD5rsczX3mPrInAYNIIGjZwVzUQCMjfMOytjpefSoCzJ335YBbFc84n+MVt/qFR6H7YNcx4uzA6sPTypvv3ite8u8qYbtkNa3NecdrB+7Dl89cXPTdVqntW9mCX99bvixktRNjVFSXPGLuM6MSQHXOJyAzCWT9zQCpuQRPCtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779763; c=relaxed/simple;
	bh=nCLEMIzAF1cMulDENPj3CBmYENmwisVYq2nQIWpJmzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrTX0vtX4T/idT8ZNl/Dn1gvdlS/oaB2s23Oknax1nuLfUrtUnbUaQoef7aLWJEA8F3/uwmi8dOu9skXhSJGfNW41E+hkIutXxVzo4wc0KF9BZaCqmFkFF2TfuH0fBrrtYoWJ4BCZ2k1x4hw3EiHR9IkNCFdDgH2DhfjOt65sDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9RTmrXa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779762; x=1794315762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCLEMIzAF1cMulDENPj3CBmYENmwisVYq2nQIWpJmzE=;
  b=W9RTmrXaLKhlR1F93W5Cy4NBHaE5raECxxXvFOSjUg/YDGXKoGvwb5/4
   h0iI4HSrYHzZIrVdR1rBJS8AnUfRzgt9IOK2AdLEUYLi+e+G7YzMyZ8cV
   nB/dxkIohN78luPzvI5vu1g933RJfz3t1KU1RcUSyKPpagglkb39Iel6N
   eiDhDnHth4xnvFekcQBjG6KjaIvOfnqW54s/TeTxbnqDAlOJrA41HnlkB
   EiKxp1Te2qpqP+r4dOSA3ofwaHQucO5Q2TeKqoG3vnky7tDHSlYPlBuo9
   +B9BnCVvQaq7ujniu3p0eMUCkGBJTEFzz9tFRPMRlwHBd1i5OsGiyPkHZ
   A==;
X-CSE-ConnectionGUID: bQUb7UehSqCq2mXLHiWenA==
X-CSE-MsgGUID: 92FVGgilQwyUYkvhmX+UHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454881"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454881"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:41 -0800
X-CSE-ConnectionGUID: QqjdRrT0QX266xCpf1V8RA==
X-CSE-MsgGUID: uIVnouvtTimEp/E6uLhMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928520"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:39 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: trigger a dump upon notification if needed
Date: Mon, 10 Nov 2025 15:02:17 +0200
Message-Id: <20251110150012.d6d7e69c7da6.I40f891ece6f98983e0fd2cd0c6863f8620ca08aa@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware can request us to trigger a dump upon specific
notifications. In order for that flow to work, we need to call the
firmware debug infra when we get a notification from the firmware.

This was missing.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 555542dc5e37..35356b244c0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -540,6 +540,8 @@ static void iwl_mld_rx_notif(struct iwl_mld *mld,
 			     struct iwl_rx_cmd_buffer *rxb,
 			     struct iwl_rx_packet *pkt)
 {
+	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
+
 	for (int i = 0; i < ARRAY_SIZE(iwl_mld_rx_handlers); i++) {
 		const struct iwl_rx_handler *rx_h = &iwl_mld_rx_handlers[i];
 		struct iwl_async_handler_entry *entry;
@@ -580,6 +582,8 @@ static void iwl_mld_rx_notif(struct iwl_mld *mld,
 	}
 
 	iwl_notification_wait_notify(&mld->notif_wait, pkt);
+	iwl_dbg_tlv_time_point(&mld->fwrt,
+			       IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF, &tp_data);
 }
 
 void iwl_mld_rx(struct iwl_op_mode *op_mode, struct napi_struct *napi,
-- 
2.34.1


