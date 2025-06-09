Return-Path: <linux-wireless+bounces-23859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E788AD256A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0722188CE6C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB26218593;
	Mon,  9 Jun 2025 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF7bXFLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B027718
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493310; cv=none; b=hlsJx2OpOQ8yH1oVOI2G8y6Wl+AcKSqdWf+WDbkshZtcGFC23OTd1wtRERcjLdolaLuMYNAFCS3KBd8R0jHHiH7QTpGKrlrXmNTeqMaoXJbDDefMeECDt6SJOzIzOnG+67SHIODguJm24WtDtpWAOq5Zb43bRvt4skTl62ohhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493310; c=relaxed/simple;
	bh=kjFpZD/tPBj5P4msdOb1LFaTq7XXaZuG7bjakyMkrx8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oaQpF3X03AKY5fIWk2iSfh7XReoDksu6xJ8O4VKFxIPw7ypS9qyitYoEKBgVvw0I5NHHMFzL+gvj2t3h/8oAjhr3UgNNSVNLn6tulPU3po5WYg7Im6ZPbbE4Jj89lBSuRQoftDImRBaBtl8yYEusqgvdFcV/gPR08unIpUe+Evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF7bXFLs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493308; x=1781029308;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kjFpZD/tPBj5P4msdOb1LFaTq7XXaZuG7bjakyMkrx8=;
  b=OF7bXFLs4S9iygo7nW0zIOXXkIU//bwyznCkSj+I/40rVnq4DZvwdZ8X
   ULOCOML6TYaJENMIgjmZ1Hh/iQyA1lIXWHK2ouyOWtCtsqn4nBy6z9AKq
   App0kw2eywStpBbBwhw6TerD58DI9ssQkHWfq6CLBnjOOkfUloQkSnlA4
   AmLBJzkqH3PFadcuj88hhEZG4o320nsoCxbf5iMk0qiK0+n2KC+95kB+/
   DpUzYyF/Kipcz9quOrs5wPJm071PfNjAKMkRWCIMQ1gQ5IFM8bX7hR0aC
   70WhR3pEQtHpxJoqCcLAVnIs3wwWUcnWe+LeWJoFmPfRg+ub9GC57umBB
   Q==;
X-CSE-ConnectionGUID: tJPO1LVDTT+JdenusWwuEQ==
X-CSE-MsgGUID: UTZn7YwbRli+iin6JAJXeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237657"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237657"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:47 -0700
X-CSE-ConnectionGUID: eB4OLPi5SB+l6WghJWQCqA==
X-CSE-MsgGUID: TflGRhWqQweNqXpUe6ZYLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510217"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:21:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-06-09
Date: Mon,  9 Jun 2025 21:21:06 +0300
Message-Id: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

Features, cleanups and bugfixes from our internal tree.

Thanks,
Miri
---

Benjamin Berg (1):
  wifi: iwlwifi: move dBm averaging function into utils

Daniel Gabay (1):
  wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_retry_emlsr()

Itamar Shalev (2):
  wifi: iwlwifi: mld: respect AUTO_EML_ENABLE in iwl_mld_int_mlo_scan()
  wifi: iwlwifi: mvm: enable antenna selection for AX210 family

Johannes Berg (4):
  wifi: iwlwifi: pcie: add missing TOP reset code
  wifi: iwlwifi: pcie: initiate TOP reset if requested
  wifi: iwlwifi: mld: fix misspelling of 'established'
  wifi: iwlwifi: pcie: reinit device properly during TOP reset

Miri Korenblit (5):
  wifi: iwlwifi: mld: remove unneeded compilations
  wifi: iwlwifi: move iwl-context-info header files
  wifi: iwlwifi: bump FW API to 100 for BZ/SC/DR devices
  wifi: iwlwifi: bump minimum API version in BZ/SC/DR
  wifi: iwlwifi: pcie: move generation specific files to a folder

Pagadala Yesu Anjaneyulu (2):
  wifi: iwlwifi: parse VLP AP not allowed nvm channel flag
  wifi: iwlwifi: Remove unused cfg parameter from
    iwl_nvm_get_regdom_bw_flags

 drivers/net/wireless/intel/iwlwifi/Kconfig    |   1 +
 drivers/net/wireless/intel/iwlwifi/Makefile   |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  48 +++----
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-utils.c    | 113 ++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-utils.h    |   4 +-
 .../net/wireless/intel/iwlwifi/mld/Makefile   |   4 -
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 117 +-----------------
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-v2.c         |   2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   2 +-
 .../iwlwifi/pcie/{ => gen1_2}/internal.h      |   3 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/rx.c      |  18 ++-
 .../iwlwifi/pcie/{ => gen1_2}/trans-gen2.c    |   9 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/trans.c   |   4 +-
 .../intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c |   0
 .../intel/iwlwifi/pcie/{ => gen1_2}/tx.c      |   0
 .../iwlwifi/{ => pcie}/iwl-context-info-v2.h  |   0
 .../iwlwifi/{ => pcie}/iwl-context-info.h     |   0
 .../net/wireless/intel/iwlwifi/tests/Makefile |   2 +-
 .../{mvm/tests/scan.c => tests/utils.c}       |  43 ++++---
 31 files changed, 220 insertions(+), 193 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/internal.h (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/rx.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans-gen2.c (98%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/trans.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx-gen2.c (100%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ => gen1_2}/tx.c (100%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info-v2.h (100%)
 rename drivers/net/wireless/intel/iwlwifi/{ => pcie}/iwl-context-info.h (100%)
 rename drivers/net/wireless/intel/iwlwifi/{mvm/tests/scan.c => tests/utils.c} (63%)

-- 
2.34.1


