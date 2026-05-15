Return-Path: <linux-wireless+bounces-36491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAuSFrMaB2rnrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:08:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE35550335
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 530673147CB6
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3E47ECC5;
	Fri, 15 May 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJiuTTUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D547F2CA
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847324; cv=none; b=KfCJl+abv61kRZMjJJIO53SATOke68KvSZZ7wrPccY+VyUrX+12DdaF2lawdRza8stIqGLs8M6tFCwYQ4DzOmQYqf/67GGUNOek+lu56PAf8v9TEOcqYKsafYZkJ2HJcEoOxAQRXUtg1I6DB1PKtvxu61Qfwuv64JKMAUzQG2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847324; c=relaxed/simple;
	bh=vEH4g6DQ104S2FgvOZv30HIlTG80m5IoryEPhQjlUj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UO6E7C/wLFZHpdMB9e7cGkhimfzZUAbqSGZeGoo7uF/WKIt9hR7EgBYJBFFAGvfAegnaIkrcg6BuhwnQJzULLNFnSVPAcDwGCDrBqgzVbB/RtOEBEgmhnMZIig8IT4nCIUBRgm1hbivxXA9JGl16alb08EEaUGZgEJMO8a4K874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJiuTTUl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847322; x=1810383322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEH4g6DQ104S2FgvOZv30HIlTG80m5IoryEPhQjlUj8=;
  b=JJiuTTUlAHzlrtiRvp4uZIBZM4JxuCVUaCM1SpG6KjzklTrX36y1KQbz
   TcsuVnG7zeNhcFg9hOZCIuD7qGj6an8Nz4cSymwFYo8EnIxjF6BCwxam2
   aqTmbO1YdHVBb64V2yiJESFa19JyhByhTGgMM0EtNY0wkbi/P7qELVCAm
   dmwEH4J+4ItomsJUZAmazFc6bWrInpeB092NMpCoBzx/AlfwKGJZBERum
   tqSHztk0hUyTgOQu88o2qrEhW3WmSnQPCfIs1zr89pZ4Ta5AaFYj/IKlW
   NqMWXc/S1vTvcL5Ey6HwndElk9KLWJRRriCYlH68fZSbRpIA3MoOl6b+9
   g==;
X-CSE-ConnectionGUID: 894ilQ87S5av/8KolXpGNw==
X-CSE-MsgGUID: SfX16tpESOuHpCfBIj8jCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79657847"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79657847"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:21 -0700
X-CSE-ConnectionGUID: 6ES/Oa/HRBKwVBSus8vxBQ==
X-CSE-MsgGUID: PGT3nYLHQAG+egPuWKNZEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262201067"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 5/5] wifi: iwlwifi: mld: disconnect only after 6 beacons without Rx
Date: Fri, 15 May 2026 15:15:00 +0300
Message-Id: <20260515151352.c4ed0d849f98.Iefa2e8be9edfc74683997eea60bb53c2002f31f0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
References: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5BE35550335
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36491-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

After 4 missed beacons since last Rx, the firmware will send an NDP to the
AP. If the NDP is ACK'ed, it'll reset the missed_beacons_since_last_rx
counter.
Disconnecting after 4 beacons doesn't give enough time to the firmware
to send the NDP.

Wait until we get 6 missed beacons since last Rx before disconnecting.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/constants.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/constants.h b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
index e2a5eecc18c3..890abcab3837 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_mld_constants_h__
 #define __iwl_mld_constants_h__
 
-#define IWL_MLD_MISSED_BEACONS_SINCE_RX_THOLD			4
+#define IWL_MLD_MISSED_BEACONS_SINCE_RX_THOLD			6
 #define IWL_MLD_MISSED_BEACONS_THRESHOLD			8
 #define IWL_MLD_MISSED_BEACONS_THRESHOLD_LONG			19
 #define IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS		5
-- 
2.34.1


