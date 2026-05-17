Return-Path: <linux-wireless+bounces-36536-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mq2Op11CWolbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36536-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 509DE55FD2C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E81A300CC1C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190D0199931;
	Sun, 17 May 2026 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYOdSijU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FAB67E
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004827; cv=none; b=GEG4jpKj2toORTVwbSUad2pujOzOrfwMrkcx7cA6FYJYXCFl53GJvKP018HpG+grj4+9D+TTGRBJubjZS9Gr+VQODXUE7D3GLx18lvy9fVjrUUFxnzOdAUkIHvLvzn7PwzVpLl+Fz/du8aifitgffhcQaAyR8A71ScLJ7P/21Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004827; c=relaxed/simple;
	bh=a0hiSeWsb7C0hlz60/+DfMfB/m8Q7h9vje7CH+3AaYo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=b6f+vwAqUKCskHYY65k29gzzN1DFL/XduIPrzZlXdQt81x9FQqnFOkfhe0GFlkY4VWL0jYY+QeM4ugVoVGZJ8pJXy8QpqwF537aQx4x2Bnkx/djqAImyqzej1NcNXZZshqJbsMLpafvs5ds+YHyQVEe0kXyTC9MoPs3xajwAzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYOdSijU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004825; x=1810540825;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a0hiSeWsb7C0hlz60/+DfMfB/m8Q7h9vje7CH+3AaYo=;
  b=KYOdSijUadG6n6yyhVMW7ypCJdCI4/Kpj4Ej1/TsDsSJkS8hg0nf+3Cg
   qU+/9D7zpvlRtVZAVtjJTTGARxV19IT8BIURwjjsIvafYx2DR6rjblvay
   B0XO4r1YGMdeB3zNVg3fFRc214OfsT0il6hucJVDZIBEJV8FebAU+jlbE
   n7HNPlX50JcgaHvbDbucQFtu93HK3CX6JYqi2mRlgTWOVF+CT6Bfe8B6E
   NEx2TZlU0RAaUF6RtNshFOV1uirjN8NSlslDhGY/Nxlxm568yy8JklomB
   xzS8S/GG9fTzd4Un7wk7t6CsmbF19yPRkN9hKiAgG8g/uV//VjsYvM524
   A==;
X-CSE-ConnectionGUID: S2DMI5pdRVGuCFbHNmB1nA==
X-CSE-MsgGUID: +40jrJqeRiCu/QnIRQPH0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606948"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606948"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:25 -0700
X-CSE-ConnectionGUID: AIT6Id48TISTPj9U/xo8/g==
X-CSE-MsgGUID: 7ZBUTep8R0iNzRa2oAqbNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490353"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-16
Date: Sun, 17 May 2026 10:59:44 +0300
Message-Id: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 509DE55FD2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36536-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi,

Resending to the right tree...

Miri
---

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


