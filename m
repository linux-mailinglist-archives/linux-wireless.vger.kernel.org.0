Return-Path: <linux-wireless+bounces-33569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA4zM3QCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5BF2D710A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4B823059B48
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E93371053;
	Fri, 20 Mar 2026 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvLQm2wY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B137D10B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994183; cv=none; b=YO4lQCuymXLCOK/CLRBrKhxgyqmuu86m6npkWn0a8Oo8mpg05FKidAfmjOKeE8OEea3jhxHwOtM63CtNHIzaI0QNJZwZdTxRjEfVXATCQ851jQ49Z97vXXrFJ4+K/8dZIzaU0Dfjw9wcL7sxDAV6sIafotNdq/yPWPjD3VSESXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994183; c=relaxed/simple;
	bh=yon2T/GowPrWFYoSyHWebX415jrOCuiccWaIEDuZjY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DUeXTXIRZBgKxD441aYCkqY9XRvimzHpGZwObsL0K1KrJEq63fEt7i2jF7emYmsrmj7M+qiNdMfmKdXNfq2lSlkiKl7crhCsRn5e87TVS2Q1OtGyLgY715UAJ5awQrXat+iAmy/VSkx1RasLjXObWTTzAgTcERhTFOQZZt2pNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvLQm2wY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994182; x=1805530182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yon2T/GowPrWFYoSyHWebX415jrOCuiccWaIEDuZjY8=;
  b=YvLQm2wYF+hgnxe9vrdegUD1tDH3uHbZcFZHRiAMTGbzmRjqIKeLaj6P
   k6OdOG8e6mkRSJVLhwKoNc/PIqF/81hJdtxB1dsFx/MdBK7fQrAmIzuCN
   6NAGT2g6zJqnQ1v6I8VadTJZ++ZTrv7olniR/K7RlVGE/Nr19IfIm59R2
   6m9Tg7YA0VxF7Am1Oj04AByyfpcssgjBDEB82uGVGt8J/1X2TANa4WDIB
   114//xCn8K0O9e3Vf6Y25tB99sycuiZaMso+p4B4zIODz4PskJQCMl+/A
   JFoi4bzx6mN+9Y4vOtI4kwD1XCcaxhxd1yw4iyOfmXTPYYXCuXo8MNpNc
   g==;
X-CSE-ConnectionGUID: 2oeIKW89SPWmMpfhegSMcQ==
X-CSE-MsgGUID: 7pEHPR31QYGqRoEI/YKjQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154131"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154131"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:42 -0700
X-CSE-ConnectionGUID: vC6JX8QAQsubmzOOCjJUbw==
X-CSE-MsgGUID: mnNIcQw5TvmFvbeW65kuzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692588"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: eliminate duplicate WIDE_ID in PPAG command handling
Date: Fri, 20 Mar 2026 10:09:11 +0200
Message-Id: <20260320100746.7b7e6315e2cc.Icffcc47ac1e876708b6219a89fd546a018797d44@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33569-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CD5BF2D710A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Extract the PER_PLATFORM_ANT_GAIN_CMD command ID into a local variable
to avoid duplicating WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD).

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 2486d78d6fc3..f91f61ca9b2e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -211,10 +211,8 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 		.v8.ppag_config_info.hdr.table_revision = fwrt->ppag_bios_rev,
 		.v8.ppag_config_info.value = cpu_to_le32(fwrt->ppag_flags),
 	};
-	int cmd_ver =
-		iwl_fw_lookup_cmd_ver(mld->fw,
-				      WIDE_ID(PHY_OPS_GROUP,
-					      PER_PLATFORM_ANT_GAIN_CMD), 1);
+	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD);
+	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 1);
 	int cmd_len = sizeof(cmd.v8);
 	int ret;
 
@@ -271,9 +269,7 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 	}
 
 	IWL_DEBUG_RADIO(mld, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
-	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(PHY_OPS_GROUP,
-						PER_PLATFORM_ANT_GAIN_CMD),
-				   &cmd, cmd_len);
+	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, cmd_len);
 	if (ret < 0)
 		IWL_ERR(mld, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
-- 
2.34.1


