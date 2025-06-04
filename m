Return-Path: <linux-wireless+bounces-23666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D5ACD658
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9C188567A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951F230BE3;
	Wed,  4 Jun 2025 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A97BS69F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAA86337
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006821; cv=none; b=u1nJzfJyYUAbjQvA6vh18M2N9KghWuL8xFXuOTp1NXE9QdVJ7+iWYToSry2Z8X14Ll2gcTpXNi4XgqxMut+WFTajIubAutr3RxvkdPP/9n0ucoNMxBC3Rgli+lk7ro+EAn15Rs0ws8gyCOMWUXGU8DRG098ylHW+iQ6L43F85hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006821; c=relaxed/simple;
	bh=xxpr9jgU8GPAbQ0BSl8egJF02glbNakBXw84GiAVdPs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfRjIbx3hlWXThy1jDM/J11f9PJ5SXqOQqHgMvOhjUamfUWfnSZjJvchTZs/p72pJtxsl3BW3L5qp3CX3F+LC73NI7PC727fUPLXEJats0WauDYH8N8CELg1OV2ZRG/m/295UxgprP3G9wMXx95dnfWd+Sn1MfewWaKnDE2a/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A97BS69F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749006819; x=1780542819;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xxpr9jgU8GPAbQ0BSl8egJF02glbNakBXw84GiAVdPs=;
  b=A97BS69FjMS8bwEnKYK6dsdEBoLKzsZbjGRH9PHvCPyW+xa7sAf0Ks0j
   b9B/nHPfhty18doLGtNa7i9o+5J4ZnD59bbcZeuJZOQ3kPpeiORDuZECt
   aizSVBfczlBg78tDGn15k1w+T7V2bgXfNp7TlNcflWWQbGjNAR3CLC0Mb
   gakjH4Llpc27FY/tOUjocIN8t0lAQ77G0bS2bHDxTMezp45qtDGcM9Kxx
   dn0JNezP454mAAoBwzwfWQgX1Xk/8OfUKUrotZnM7g7bDuilC28/eEXK8
   zl8Gfy8ZjYPEf0KG9sdtOJFSToCsLZOdzJ5TphMfo8ZCJMQZe3PsYt0n4
   g==;
X-CSE-ConnectionGUID: 83mvhxU/QSyo1vVAX9ZACA==
X-CSE-MsgGUID: 8aLEbDfgQZ2USCpd9lfXJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68504616"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="68504616"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:38 -0700
X-CSE-ConnectionGUID: E915stqTQQe6jlc6fXNlhQ==
X-CSE-MsgGUID: JH0iKT/cTYKJZJ0Nz5E2Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="182227348"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 1/4] wifi: iwlwifi: mvm: fix assert on suspend
Date: Wed,  4 Jun 2025 06:13:18 +0300
Message-Id: <20250604031321.2277481-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
References: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

After using DEFINE_RAW_FLEX, cmd is a pointer to iwl_rxq_sync_cmd,
and not a variable containing both the command and notification.
Adjust hcmd->data and hcmd->len assignment as well.

Fixes: 7438843df8cf ("wifi: iwlwifi: mvm: Avoid -Wflex-array-member-not-at-end warning")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0f056a6641bd..956b491ae5a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6360,8 +6360,8 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 			(struct iwl_mvm_internal_rxq_notif *)cmd->payload;
 	struct iwl_host_cmd hcmd = {
 		.id = WIDE_ID(DATA_PATH_GROUP, TRIGGER_RX_QUEUES_NOTIF_CMD),
-		.data[0] = &cmd,
-		.len[0] = sizeof(cmd),
+		.data[0] = cmd,
+		.len[0] = __struct_size(cmd),
 		.data[1] = data,
 		.len[1] = size,
 		.flags = CMD_SEND_IN_RFKILL | (sync ? 0 : CMD_ASYNC),
-- 
2.34.1


