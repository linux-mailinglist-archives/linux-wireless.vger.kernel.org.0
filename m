Return-Path: <linux-wireless+bounces-16861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47E9FDF3E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD5D1882196
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C3172BD5;
	Sun, 29 Dec 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byEQCkSH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C328691
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483508; cv=none; b=ResQHpABeEjqv0EKP4bZlXm+kgNNscIWRJlL3RIFI374TyN9vNgAj54j6KzZAbc72HFohpSSp0G203qHOsPLr1YeZLVMWx7LW105twRxQJC9NZTCf8+ON5kbijQxIR8lU7zci/OFN2hAzU/qcJ2K7k9op6tqZfyVed2IaSuq6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483508; c=relaxed/simple;
	bh=jV93yQsCP9l7jmawnrtNnyTqDMJ5KGkVovBB7UIYXiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cS2iQKv4EM+j008iCTnghD5WCYFSiKM54WM+0XGlBS5HPUk2VJqy2+mKuabessO1qr1y0XolzqXVWrFjGhWZVzEyo5g93cQqr2V7HK3pZwSeGNy0yIxHogmBuD7pA9LDe/rEa9LtqxqvvcBTutYi+TE0y4GdHF9vlvN76VVBOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byEQCkSH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483507; x=1767019507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jV93yQsCP9l7jmawnrtNnyTqDMJ5KGkVovBB7UIYXiI=;
  b=byEQCkSH/pu5TbJPNyvsB6Cp1JTF1WQOlt77mG/uTwFNVH2bppP8j9TR
   lGQF42Yyvq4sdVLSDldGDoTfd4RjrV12bfXL/P78gCcw84rgrgSm2rZBE
   QSSy17YN0iT8THRdMxt095JCZGcMNng8Wx4G9W5/qnGQvq+4oOZNnNPgF
   ZIJXk9Zwd8DbVMnlqe+gje1PdQUqXoZGkEisb3Rft9qb3aSYte1jHwFxV
   2JqR7PIFHyamWSnZ9GuPfPtRRBa9l7zIwXWsVk2yLqQlUCYE0sRrqyEw3
   Ae9rD1Vw+EKJ1mHT3ePNiu0BE9YlaZCAuA55R8ICcVYpZedJgfkFEs6M/
   Q==;
X-CSE-ConnectionGUID: CWIa9REkRTS0sAy8NctsZg==
X-CSE-MsgGUID: Bru2yoZBSJm8lThppSKGzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572422"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572422"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:06 -0800
X-CSE-ConnectionGUID: 0mhQle9VRfm9ZLkmpZymxQ==
X-CSE-MsgGUID: EO/uFGoYRy29I8bnd7PYOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656732"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: iwlwifi: updates - 29-12-24
Date: Sun, 29 Dec 2024 16:44:35 +0200
Message-Id: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

A few patches from our internal tree, along with patches from the
mailing list.

Miri
----

Daniel Gabay (1):
  wifi: iwlwifi: mvm: don't count mgmt frames as MPDU

Deming Wang (1):
  iwlwifi: api: remove the double word

Emmanuel Grumbach (3):
  wifi: iwlwifi: cleanup unused variable in trans.h
  wifi: iwlwifi: mvm: s/iwl_mvm_aux_sta_cmd/iwl_aux_sta_cmd
  wifi: iwlwifi: mvm: remove unneeded NULL pointer checks

Gan Jie (1):
  wifi: iwlwifi: fw: fix typo 'adderss'

Jason Wang (1):
  wifi: iwlwifi: mvm: Fix comment typo

Jilin Yuan (1):
  wifi: iwlwifi: fw: fix repeated words in comments

Johannes Berg (2):
  wifi: iwlwifi: fw: api: tdls: remove MVM_ from name
  wifi: iwlwifi: mvm: fix AP STA comparison

Juan José Arboleda (1):
  iwlwifi: mvm: Improve code style in pointer declarations

Minjie Du (1):
  wifi: iwlwifi: Remove a duplicate assignment in
    iwl_dbgfs_amsdu_len_write()

Miri Korenblit (4):
  wifi: iwlwifi: mvm: avoid NULL pointer dereference
  wifi: iwlwifi: mvm: fix iwl_ssid_exist() check
  wifi: iwlwifi: mvm: Use helper function IS_ERR_OR_NULL()
  wifi: iwlwifi: mvm: Fix comment typo

shitao (1):
  wifi: iwlwifi: Fix spelling typo in comment

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  6 +++---
 .../net/wireless/intel/iwlwifi/fw/api/tdls.h   |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h |  2 +-
 .../net/wireless/intel/iwlwifi/fw/error-dump.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c |  2 +-
 .../wireless/intel/iwlwifi/iwl-context-info.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  4 ----
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c  |  9 +++------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 18 ------------------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c   |  1 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c   |  3 ---
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c  |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    |  4 +++-
 19 files changed, 28 insertions(+), 55 deletions(-)

-- 
2.34.1


