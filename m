Return-Path: <linux-wireless+bounces-36626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEcCDFgHDGqBUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A238D5784E9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 816533010EE5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CFC395D8C;
	Tue, 19 May 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExEKmOZc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA21DD877
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172826; cv=none; b=dDSnpz1v7hVTstakU3yuPOu/KaF32V8QM54e9uTtRJaxRQso3OLanqL3Kcmp7CtB8ICK0S6L6mnsWJ0q2zUTxDnMV0lI+eHZbjHiIvV1Q4HCw+bBWrtvbqHWQ87xiCLsBACnyY+yhJ6VrHF/i6enCZkas7FvTyXbUJYejtUJe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172826; c=relaxed/simple;
	bh=4zGM97yP/JRBtl/a8APYydQAc56/sVExqpCafxWrTVg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YYuCeFA8hMchTiFMOxjHYH8JeJZuo5f1rZnxqoT4AV9EFlppQqSeP+o8cqM2FhJgGaBoFK/Dq2fb7WfhMp0QaojET5qUxJFogROlB1WqFqoQUf2/EWMc8+Bo2B/P6mPcOcI8eCqMblmKLfVdRqVWbaPUijqu9UU00Dpiqm6MNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExEKmOZc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172825; x=1810708825;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4zGM97yP/JRBtl/a8APYydQAc56/sVExqpCafxWrTVg=;
  b=ExEKmOZc9QxQ9+ORQEXcJ14sh8gAWwYSZlIEJxNNUHFgyIYbSDqXjDL6
   4yQUBGPuz0hnOWYyoiqMU6fQMXpfaHznvFrNQ5DkOkF3QFp9fXtlefC+4
   f3h8z3edToBnUdDxxKf76W2R7xmijaHShNK7WNsCGCjlHAAglSihUwHwS
   KXldwyx4+fWQ590Rm++3hXuSxa3Kkt05pXhN//cZDaSMMkZR5skGbXYQ3
   4MRpYGtjrpGZOqIjjmXg6nnreI3n4giT6BqtGxAQeN90yr2IpIsfGASgm
   yEeclW2Ksveht/glXhkFwXs/n/+yBx7IWNCcWuYFyx254pGd4268SeGk4
   w==;
X-CSE-ConnectionGUID: 4Zsn5K6OSI2FqQ+2Sn3Ekg==
X-CSE-MsgGUID: c8Wmm0oNQ+G6iYhmXJ00AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605625"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605625"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:25 -0700
X-CSE-ConnectionGUID: 93Ce0XlsRaOvuDyICGGnew==
X-CSE-MsgGUID: Ht33bO8zTC+ONTVFL7VVrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227268"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v3 iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-16
Date: Tue, 19 May 2026 09:39:55 +0300
Message-Id: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36626-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: A238D5784E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Renamed dbg-old.c to dbg-legacy.c (maintainers check fails for some
reason)

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
 .../wireless/intel/iwlwifi/fw/dbg-legacy.c    | 1022 +++++++++++++
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
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dbg-legacy.c

-- 
2.34.1


