Return-Path: <linux-wireless+bounces-36431-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHwhNVgmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36431-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F9546792
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7D130589BF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C23B6344;
	Thu, 14 May 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irQZ4rLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC53B9928
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787906; cv=none; b=SwKgcqdPnh1R6++WQyXsi8ytzvul0D3E+3mDZQIdijVNu8eM9FgPD98EBbATPWb6XvBhwmYcDP7pMK6RW25WkSWpWOCPl5TZK96JZ2Hcji1hONN96QqitgLIY3rmGlqpR4D7pjcaLnNGS5Y08lKc4ILS2s1H8YyaW+EK72jzMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787906; c=relaxed/simple;
	bh=eZmu9FgnX6OI7O1TVIjaL0XW2oeiJzCbd0ref62RtwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ew4yx2bL39yaTWcjY4H1vrYzbT17jR+pMz2R7olImtQsb9A85N74r09MQREep+tU6g27Wwdrxo1xHkKuzCsE9CkCo/DC4R6+lgvLiFtY5j0OqyKIrgmS06VdmKvJtZ4wrBzq5FEFH+0xnvadZOjjyYAE5HmYUY/Xrybqt9vyXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irQZ4rLZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787905; x=1810323905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZmu9FgnX6OI7O1TVIjaL0XW2oeiJzCbd0ref62RtwY=;
  b=irQZ4rLZFoi4tcCI7/KEKqnschNjFfG2xkdrq87A1Hu/99waM89NEAY9
   xpaBZJziUmUD5qWS3YLWYa5t2nPLFjdjyC3+6/azzYJv8nRyJ6gmDJxuX
   qThqAN2JQCA9NkiMRFPex55VfPaVa2fovlk5g2+wUDemlBM7spB9tXVIO
   Kz5d5W8h5m0SfuX2H2ju+WEhPGuIAW7VA6H6GsMmpRMymW4n7oqACr1CM
   7VaYPaAszOG35fs+q59kxLWZZzuOmrW+hfn9u0XkYEaHNdbkLwXjAYiPP
   QuAGbyo32a2ykpnoXOyZ+moZX/DKua5RMqd++f8oLTAkOOJ6s3FTQKGqJ
   w==;
X-CSE-ConnectionGUID: rO/eMUqoTReKtM2vjVkllQ==
X-CSE-MsgGUID: 8CRdcbYzQ/+tU93QGniH9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352607"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352607"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:05 -0700
X-CSE-ConnectionGUID: 9liKJIvfRlufO6l6wXJhtg==
X-CSE-MsgGUID: gz4A1neVRvuo6twSsizPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616351"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: api: remove NAN_GROUP
Date: Thu, 14 May 2026 22:44:30 +0300
Message-Id: <20260514224230.1427beb76b0a.I6faacff99020984b14a76d9387f3aaa6281f3552@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 927F9546792
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36431-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

This is no longer used by the driver nor supported by firmware,
and the kernel-doc reference to enum iwl_nan_subcmd_ids is long
dead. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index dcac0ba8cccf..24bac3f00310 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -22,7 +22,6 @@
  *	&enum iwl_data_path_subcmd_ids
  * @SCAN_GROUP: scan group, uses command IDs from
  *	&enum iwl_scan_subcmd_ids
- * @NAN_GROUP: NAN group, uses command IDs from &enum iwl_nan_subcmd_ids
  * @LOCATION_GROUP: location group, uses command IDs from
  *	&enum iwl_location_subcmd_ids
  * @BT_COEX_GROUP: bt coex group, uses command IDs from
@@ -43,7 +42,6 @@ enum iwl_mvm_command_groups {
 	PHY_OPS_GROUP = 0x4,
 	DATA_PATH_GROUP = 0x5,
 	SCAN_GROUP = 0x6,
-	NAN_GROUP = 0x7,
 	LOCATION_GROUP = 0x8,
 	BT_COEX_GROUP = 0x9,
 	PROT_OFFLOAD_GROUP = 0xb,
-- 
2.34.1


