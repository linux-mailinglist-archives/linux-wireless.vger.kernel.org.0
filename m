Return-Path: <linux-wireless+bounces-33463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DSVGurBu2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3D2C8AAA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1816F32B47A9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8045C3B38BC;
	Thu, 19 Mar 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpBOTMcS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A03B3BE7
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911382; cv=none; b=XvK3V2Tz8nxP2q6OVQDpdkH2n0Cd9nCgzcX57kP37wMt7qm0elKOovTJ1Mm9YEKhLwglNsmUYesboVy0J0GFIQv1oD96dwR1Af3T3jan6I/4J57InoZkzy6RemUrAi29+YspVZ6SKteMwxwgAz+mwza85X7IrcK+xuR6A7w5qPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911382; c=relaxed/simple;
	bh=PvatvaslY3ciI6YSBH88jMNcKajbc7tbcqurymjEMsk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JJ9GjttsxxhZeffWMnxOi5UNWJ6s2wt3fR3r5/1m73y2uqvpPNGWOhqxgOjWzBhtChF6N4fNjkik07bOLBlN2UsFob5p6dUy1gxbG4OrRFdoW+ItSRl6CMmgk7YjfmnN79vc+wYG9bjo85PAWG5iZF3GaFLwmmS3960cTgeBUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpBOTMcS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911380; x=1805447380;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PvatvaslY3ciI6YSBH88jMNcKajbc7tbcqurymjEMsk=;
  b=VpBOTMcS7sh4oOidNF3DKXYXcbdzh/f8a/T5hfppMeVwp8NWgMCLQUxw
   Ioz1PtssJHm8x+KMPEHt6eE+fKoj5TAbb9syWm5deSpMciMNksNhsWLHN
   xkssez+bFRY4Jk/RtFkmVGSI2+ZKzyP/HjpN3nNW38P8x2UpY+XJNbVUL
   O4Jjz5y7hhNvlS8CDnxxeCD76/9i/I9rHVDmt1Esul9lELMAACrh7+x6q
   tTkyQPh3KvlUNC2QT7lz4jmNZpsAw9PmrulBDUvCSRH76QC4Qw12MYQSD
   1INU0kZy3LUf65zEssLCmb8yRuXg4/Ho1gypQYwnKKrS2KMOzBiHPU31A
   w==;
X-CSE-ConnectionGUID: j74zSPJ9Sd+VVPt9IPKKaA==
X-CSE-MsgGUID: G3Ubxg6ZSCm8WuyGeGi9eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992686"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:39 -0700
X-CSE-ConnectionGUID: YSJotpiFSjKez2M6W1M6oQ==
X-CSE-MsgGUID: ymIti7CXQ9O2nUeln/9lmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387115"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-03-18
Date: Thu, 19 Mar 2026 11:09:12 +0200
Message-Id: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33463-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D9F3D2C8AAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

features and cleanups from our internal tree.
Since the remote next branch wasn't updated, this series didn't apply. Sending
again after updating the branch.

Thanks,
Miri
---

Emmanuel Grumbach (9):
  wifi: iwlwifi: mld: add support for iwl_mcc_allowed_ap_type_cmd v2
  wifi: iwlwifi: ensure we don't read SAR values past the limit
  wifi: iwlwifi: uefi: decouple UEFI and firmware APIs
  wifi: iwlwifi: acpi: better use ARRAY_SIZE than a define
  wifi: iwlwifi: uefi: open code the PPAG table store operation
  wifi: iwlwifi: bring iwl_fill_ppag_table to the iwlmvm
  wifi: iwlwifi: regulatory: support a new command for PPAG
  wifi: iwlwifi: acpi: check the size of the ACPI PPAG tables
  wifi: iwlwifi: acpi: add support for PPAG rev5

Ilan Peer (2):
  wifi: iwlwifi: mld: Refactor scan command handling
  wifi: iwlwifi: mld: Introduce scan command version 18

Johannes Berg (1):
  wifi: iwlwifi: mld: correctly set wifi generation data

Miri Korenblit (1):
  wifi: iwlwifi: mld: add support for sta command version 3

Nidhish A N (1):
  wifi: iwlwifi: mvm: cleanup some more MLO code

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mld: remove unused scan expire time constants

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  31 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  21 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  94 +++++-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  14 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   8 +
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  45 +++
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 151 ++-------
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  10 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  60 +++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  32 +-
 .../wireless/intel/iwlwifi/mld/constants.h    |   1 -
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 101 ++++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  19 ++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   1 -
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  98 +++++-
 .../wireless/intel/iwlwifi/mld/regulatory.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 218 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  42 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 153 ++++++++-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  46 ---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 132 --------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 291 +-----------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 -
 27 files changed, 834 insertions(+), 757 deletions(-)

-- 
2.34.1


