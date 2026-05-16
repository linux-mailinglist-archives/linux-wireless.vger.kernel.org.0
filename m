Return-Path: <linux-wireless+bounces-36518-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hRkQJo7PCGqA6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36518-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:11:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13B55D9F0
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382D930053C4
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AC435C1B2;
	Sat, 16 May 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgoPcNs0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A154654
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962315; cv=none; b=cFlaezjjTg0HK71vj2e0fdz1T7fIQGrCFh80oF57R1Ocn2dn1Y6Nv05H1smfx6q3u0DxjM4i9bKZDfSTXkHxZaAw9Q98mLhUourhcqjY6IUI/mW2UUxpdNaYMt65ZiHALEn0METT278vw+EhIb7GUw8pTXnouhmbJUuJ41wbs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962315; c=relaxed/simple;
	bh=VI3G2VyNdP35wXxCyKl4Viw97f8pJRk7I85hO0LB+hM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aJ0tlLNRyzWAUILLTZKcYr4nMKLZzioIp8e0VaNCc3S9USQtKV8FIfuFPNaEBS2NEsX8RvvHdRTPwo96Aksni/Xu6oVMcfv0IsetQxxA/Rof48K0RGeoidO33vBzUGbx5kmr3JKvXnQuXx8/U2Kw+KxvlNaQ56fnD3Send3dFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgoPcNs0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962313; x=1810498313;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VI3G2VyNdP35wXxCyKl4Viw97f8pJRk7I85hO0LB+hM=;
  b=GgoPcNs0Vhwag6bD/hSCfH/pGGPKXeKa4jAiTMRlsL1lEbVfWMayL517
   uCk+h5cSQFY0AhERCa8GFcVcd3tuEEWFjuYtkC8JDlbOe3tNUzc7Fb5BK
   jq3CIdjkP3MqMoPz4dD4Mao6UFombo/N67cUjI3uvHVZWxO38567dT/yI
   xLN8hVgAjfSHida3U8pSmu0668a2DKYOBlWJRWVK8Twfk2oUEZnFcGBBr
   yDh5BF3q+t0PL3hnHEYgcu26DYjIXaZvIiWA/O6lvXTq2giC+tmge+s5/
   m5B7mnKfsn+0KUg2yyiK03OePYjkw6TphuhQQAYdV9Oin4E7KlEfegj4D
   Q==;
X-CSE-ConnectionGUID: 04ieiyD1QBucZzq7j9+jkg==
X-CSE-MsgGUID: ztXxaDTfTmOLUUMo+rQfbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845721"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845721"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:52 -0700
X-CSE-ConnectionGUID: HrOshm1KT7KgmhLAWm9b5A==
X-CSE-MsgGUID: iHLoaV3sRQKxnFEnMFo/FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130840"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 00/15] wifi: iwlwifi: updates - 2026-05-16
Date: Sat, 16 May 2026 23:11:22 +0300
Message-Id: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC13B55D9F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36518-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hi,

Features fixes and cleanups from our internal tree.

Miri
--

Avinash Bhatt (2):
  wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
  wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit

Emmanuel Grumbach (2):
  wifi: iwlwifi: move pcie content to pcie internal transport
  wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c

Johannes Berg (7):
  wifi: iwlwifi: clean up location format/BW encoding
  wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
  wifi: iwlwifi: fw: separate ini dump allocation
  wifi: iwlwifi: fw: dbg: always use non-tracing PRPH access
  wifi: iwlwifi: fw: separate out old-style dump code
  wifi: iwlwifi: dbg: remove unused 'range_len' arg from dump
  wifi: iwlwifi: transport: add memory read under NIC access

Miri Korenblit (3):
  wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling
    notifications
  wifi: iwlwifi: mld: purge async notifications upon nic error
  wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105

Shahar Tzarfati (1):
  wifi: iwlwifi: Add names for Killer BE1735x and BE1730x

 drivers/net/wireless/intel/iwlwifi/Makefile   |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |    2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |    2 +
 .../net/wireless/intel/iwlwifi/cfg/rf-wh.c    |    2 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |    2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  100 +-
 .../net/wireless/intel/iwlwifi/fw/dbg-old.c   | 1022 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 1292 ++---------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |    7 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |   14 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |    7 -
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |    2 -
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   15 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  123 +-
 .../intel/iwlwifi/mld/ftm-initiator.c         |   30 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   22 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |    3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |    9 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |    7 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |    4 -
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   30 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |   32 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    4 +
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  107 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |   54 +
 27 files changed, 1536 insertions(+), 1362 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c

-- 
2.34.1


