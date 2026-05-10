Return-Path: <linux-wireless+bounces-36162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AJKLELvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E642A50654E
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB9E93001A7C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357A313522;
	Sun, 10 May 2026 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUmB8a0A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE33D64
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446138; cv=none; b=OIS1i/fGdv+ggsE+367C78OSdqDOjbRbdVK+qG6AElTu9+j7zEpDaAOx+ilauFRNY/8LbnRTKSw+sQ1roUN3/i7wiIv6ZJVM6r4EltiNehtNomiS1GceW6TXxbb2rul4jHIBAls4Re41FqiN0pqoFFk44S9fxyCn2H5gaWL0hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446138; c=relaxed/simple;
	bh=dC5O4YyUUcxLh3VF79YSGsIUrPogoLL2TMBOLwEIlWU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UwwtfrXvwgQaCkFKDdRr6fQjFNf5qdeOkZOVjON9R4djoognKx3swsj9QOzINPKVQoRNWZpvXa2EpRryMJc4JWStjO3ReE32k+4TRwqaqZiyu/nKw/ylml6vY1wjvvStZGUfIu8Zbo0g+uFbLiggMgOtQC2WQfsVdSMPToxUSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUmB8a0A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446136; x=1809982136;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dC5O4YyUUcxLh3VF79YSGsIUrPogoLL2TMBOLwEIlWU=;
  b=IUmB8a0AHd1EieOMi8j3kaL1OwWnwwj9pOYYPQSL0rrH6xT1KCCH2YVu
   4SgnCKSxg8CGk/dOkzwmizSLQ7DtmjZUmL4RfKu09XbBvkioNGwHYKxus
   0QktsNAHG/73m0McdmCqanTVt+JM5FoJ86Js3Io5NJJbg08U6MB5v4T8o
   6DxB27zKs0vPbuBkqjc/728PiPRqvfh2ZsTPQfxq/H748hJp9+KAiBD/K
   tikNZ4TUU/RfL3OWYBYzU4/9uf09Itsg0h7zTv5GNYufU8/NaDFT8LCv4
   wlqwdhak9/c5/87/sD+mwJvGWTzrApVi3lYs1y75bHHBu+fsjn0VCil/6
   w==;
X-CSE-ConnectionGUID: Dx+J/qNxRIWStoYw9e3zoA==
X-CSE-MsgGUID: fomEwUhQRIahnum1rIsp1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904746"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904746"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:55 -0700
X-CSE-ConnectionGUID: eEo9J78YQAupIcgHxWX7aw==
X-CSE-MsgGUID: 08gIZQMSSGaliSm+jn3DHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095022"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:48:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: mld: add NAN DATA support - part 1
Date: Sun, 10 May 2026 23:48:25 +0300
Message-Id: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E642A50654E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36162-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Hi,

This series adds support for NAN DATA.

Miri
---

Ilan Peer (3):
  wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
  wifi: iwlwifi: mld: Do not declare support for NDPE
  wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID

Israel Kozitz (1):
  wifi: iwlwifi: mld: fix NAN max channel switch time unit

Johannes Berg (7):
  wifi: iwlwifi: mld: tlc: separate from link STA
  wifi: iwlwifi: mld: disable queue hang detection for NAN data
  wifi: iwlwifi: mld: support NAN and NAN_DATA interfaces
  wifi: iwlwifi: mld: add NAN link management
  wifi: iwlwifi: add NAN schedule command support
  wifi: iwlwifi: mld: implement NAN peer station management
  wifi: iwlwifi: mld: add peer schedule support

Miri Korenblit (4):
  wifi: iwlwifi: mld: set NAN phy capabilities
  wifi: iwlwifi: mld: use host rate for NAN management frames
  wifi: iwlwifi: mld: extract NAN capabilities setting to a function
  wifi: iwlwifi: mld: don't allow softAP with NAN

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  66 +++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  46 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.h    |   8 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 147 +++++-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  31 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   7 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 100 ++--
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 452 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  27 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  96 +++-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   4 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 267 ++++++-----
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  27 +-
 18 files changed, 1082 insertions(+), 224 deletions(-)

-- 
2.34.1
---
V2: fixes a bug in "wifi: iwlwifi: mld: tlc: separate from link STA"


