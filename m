Return-Path: <linux-wireless+bounces-36465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBQNKMwbB2r+rwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:12:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CC55044B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C87363046AE1
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D645BD57;
	Fri, 15 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7TEZb7c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC41EFFA1
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847006; cv=none; b=lIIrxC9g5VTnnzV8NVISyheidx1oV9/UANpEhvNQkrjwm8yiE0IrVnVPXPGHcqJRpfMOp/exTB/1oLSgtuIx74lUVg0ezn6hpWO7ci2ZpwcRwKxKUd6LoJtqADioZGnyFkbSBdnUYRXUcqbYsVJrUAxInQeN3KlYJWuQgvD6q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847006; c=relaxed/simple;
	bh=slvWUGiath0wCOHojIjD8NwNNxCC9JbTKSFhd9hciXo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CynzOl3NdI1aLJrp1YldjPIEx/4N7uBkV7CJHopMEDj2e0bV96fIu1k7FICcuYHoyR0cfuFGtMDYubvsmTBkb7DVkUKzJLgQnHYC+NerrEr/rb97wQTKmyy3ar0w5HR4ULlWeKGLuJI7LLYY51mh1CCM5PL/n9ZtfLq1Fnn0m3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7TEZb7c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847005; x=1810383005;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=slvWUGiath0wCOHojIjD8NwNNxCC9JbTKSFhd9hciXo=;
  b=P7TEZb7cXc5y5qvGn9MPGR4IONI8iZoAYQpLfVZSkH1F7baG905vQ6wJ
   1z8UtwlT06+Un3Geu3Nbvbk5B5pz3c3vYF/VSZqQ6Vxt07sfgQ9mc4ANE
   9a0l9IVq99xbn29tQpimogYE4QC3fMjIABu7q8ssuIow1hP44uFk+Ong0
   uFacJc6lalPbQyxQT1csHJ3PLZpt4FEHm8k8AxQBclbOBY/cBJbs5pUPJ
   JXvfjE36Tq6wHpprJqDSBBt6j0bajaPz6ehl9W2HHnLmMStVEmYjnht46
   KOCpp07htKnHmbsd/bt3DuvJ33KmJkq7sKig9Fdfq+J7ksHEEAZydT1ig
   A==;
X-CSE-ConnectionGUID: f8KOyPRbQw6u+DQ/c12DoA==
X-CSE-MsgGUID: aOFQMQ5WSg+qYDNvs/ggBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185661"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185661"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:04 -0700
X-CSE-ConnectionGUID: U65vpsSoSW+/aEstqliZ+w==
X-CSE-MsgGUID: T5RI5859SRC9uBjwNZh4TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649932"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-14
Date: Fri, 15 May 2026 15:09:33 +0300
Message-Id: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E2CC55044B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36465-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Sending again after fixing a commit message and rebasing

Avraham Stern (2):
  wifi: iwlwifi: mld: nan: add availability attribute to schedule config
  wifi: iwlwifi: mld: add support for deferred nan schedule config

Daniel Gabay (1):
  wifi: iwlwifi: print UHR rate type

Emmanuel Grumbach (1):
  wifi: iwlwifi: reduce the log level of firmware debug buffer size
    mismatch

Ilan Peer (1):
  wifi: iwlwifi: mld: Disallow using a per-STA GTK for Tx

Johannes Berg (7):
  wifi: iwlwifi: mld: add UHR DUO support
  wifi: iwlwifi: mld: implement UHR multi-link PM
  wifi: iwlwifi: mld: rename LINK_DEBUGFS_WRITE_FILE_OPS
  wifi: iwlwifi: mld: add link and link station FW IDs to debugfs
  wifi: iwlwifi: api: remove NAN_GROUP
  wifi: iwlwifi: api: clean up/fix some kernel-doc references
  wifi: iwlwifi: pcie: add two LNL PCI IDs

Miri Korenblit (1):
  wifi: iwlwifi: mld: evacuate NAN channels on link switch

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mld: disallow puncturing in US/CA for WH

Shahar Tzarfati (1):
  wifi: iwlwifi: mld: expose beacon avg signal

 .../wireless/intel/iwlwifi/fw/api/commands.h  |  9 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  7 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 33 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |  5 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  1 +
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  | 53 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  6 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 10 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  3 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 97 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  | 13 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 60 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  5 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  4 +
 .../net/wireless/intel/iwlwifi/mld/stats.c    | 47 ++++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  2 +
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  8 +-
 18 files changed, 344 insertions(+), 20 deletions(-)

-- 
2.34.1


