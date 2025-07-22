Return-Path: <linux-wireless+bounces-25781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C947B0D06E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0135543E20
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC285234;
	Tue, 22 Jul 2025 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRYa+aMq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F828B41A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155712; cv=none; b=X1BA0BYGgfUFomRT9/4quDdvpLOqQtYpGQOz+mLgcLsvKuFjHjeYHcSlNx4sITJ0iRXsH5NX5sSlOWR6/GLg+8zT5zEFFv7nH652SpwHtm7IyXkfdpgHPkRMBDvslaKN84TXwdZ3zQEX+2UsaaDkUo/gvXkwU3Tv05F4toj43kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155712; c=relaxed/simple;
	bh=cWjpFwDfidXPLma0uB/H/EnMavUrsWBUswXHiggqOdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHfLUd+NT2Pd2EhWo7FzXMH7dQChdXe7DWduGLT8FZI8QhW4BxYGLTsJoZfC53PUnLGp9f34TRYUYsRBMD+MHE7qEKbWCHPK8uvS67xcmafKhZos7XbDgAdeJJZmTVAwYpISgpwfa1wGsPYTURurifRgFZhQ5zYB8xhc5Kz8LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRYa+aMq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155710; x=1784691710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWjpFwDfidXPLma0uB/H/EnMavUrsWBUswXHiggqOdE=;
  b=fRYa+aMqNtzu2an22W635+7bGXbXppxUEH8cOm+aI+nlN9zqj1BPJDLW
   V+RUdjS9BRIGfHVVbboDeKnPWfd2AFqKgfAkzdp+021UdsS0T0RC0Mkp5
   N51LtyewPYRu4+a3QstyuEJK71HqZdjGBP2RAAtQ5Ab9GpMK8mbiL3VH0
   OrQfM1JWFvB+joEIWP3YwyZdZudYpVB6Vi3Fi2bsE+C0fqbDj8MjbaA9U
   69+X313jUMJ7bjBDZs+StMJA73xZOGQMXsfERw0ahivG5nqHkSH+YR5VW
   9mL2fhtKHAmr/JCxC9c8OyduxmGUu52gVMFsmqVkTO4/ZkDq0Po5lITeP
   g==;
X-CSE-ConnectionGUID: Max4uoQvSaq/jbvszlH2Lw==
X-CSE-MsgGUID: lEWY+lxUSJ+fsMfE/rGuKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006153"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006153"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:50 -0700
X-CSE-ConnectionGUID: QhArYPBkQPq7Aaz0nXHZqQ==
X-CSE-MsgGUID: PA1GWV7VQvuwbYGFfWBzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338060"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: don't consider old versions of PPAG
Date: Tue, 22 Jul 2025 06:41:12 +0300
Message-Id: <20250722063923.f22dda654643.Ie77dc9c3ee8275d1c2e4eafa27f1c7899c2660ce@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

There is a utility function, iwl_fill_ppag_table, to fill the PPAG table
according the version of the FW API and on of the BIOS table.
But this function handles really old APIs that iwlmld will not support.
Also, iwlmvm will no longer have new APIs of PPAG (because it is loaded
on frozen devices only). So in the next versions we might introdue
regressions to iwlmvm.
Simply fill the PPAG table separately in iwlmld code, without using this
utility.

Reviewed-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 75d2f5cb23a7..40571125b3ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -163,18 +163,32 @@ int iwl_mld_init_sgom(struct iwl_mld *mld)
 
 static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 {
-	union iwl_ppag_table_cmd cmd = {};
-	int ret, len;
+	struct iwl_fw_runtime *fwrt = &mld->fwrt;
+	union iwl_ppag_table_cmd cmd = {
+		.v7.ppag_config_info.table_source = fwrt->ppag_bios_source,
+		.v7.ppag_config_info.table_revision = fwrt->ppag_bios_rev,
+		.v7.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags),
+	};
+	int ret;
 
-	ret = iwl_fill_ppag_table(&mld->fwrt, &cmd, &len);
-	/* Not supporting PPAG table is a valid scenario */
-	if (ret < 0)
-		return 0;
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits going to be sent: %d\n",
+			fwrt->ppag_flags);
+
+	for (int chain = 0; chain < IWL_NUM_CHAIN_LIMITS; chain++) {
+		for (int subband = 0; subband < IWL_NUM_SUB_BANDS_V2; subband++) {
+			cmd.v7.gain[chain][subband] =
+				fwrt->ppag_chains[chain].subbands[subband];
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table: chain[%d] band[%d]: gain = %d\n",
+					chain, subband, cmd.v7.gain[chain][subband]);
+		}
+	}
 
 	IWL_DEBUG_RADIO(mld, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   &cmd, len);
+				   &cmd, sizeof(cmd.v7));
 	if (ret < 0)
 		IWL_ERR(mld, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
-- 
2.34.1


