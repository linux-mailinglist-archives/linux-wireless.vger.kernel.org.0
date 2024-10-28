Return-Path: <linux-wireless+bounces-14588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884449B2F5B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7871C20EFE
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398091BDA8C;
	Mon, 28 Oct 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YazF9+aV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E676189B8D
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116519; cv=none; b=ciwZ5+WyhKf8flk0xeQ7NO7ZkX2oJ5ywvvrNdNjkP6GsElH9PWvpzuYvxPcI7J8GYSAQ6RtZD2QcnsDOs6C1Q7yRHi0/8KY6xqOUseMPJD4J5zO9GZMC/gx6c44JHxs7NqTpNOu2tpU9Qkz2YqqkYJwqRmG01A1HhaC71s+ab3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116519; c=relaxed/simple;
	bh=xA9ntN5GIbqBTHRJB+l0ZLCwkcwNE2z74HXrb5sNJUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLIwfQNAQREHuivt+eMHtUQ74jJc/qAIjXufOj0Af61Wn8Io02blANDDImTBRqw72f3f7d0hpRG+ZbeQI3WQyP1YnkZnKByZnl584N+YAMyWf4WwXWYKQz4xwsM6DP5kItAkpGYZMgqEKVVIXJMjOo4Hy4HlbgY94d1UPtYByB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YazF9+aV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116517; x=1761652517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xA9ntN5GIbqBTHRJB+l0ZLCwkcwNE2z74HXrb5sNJUA=;
  b=YazF9+aVSQY1mC/BTGasaKKHVjFISjk61JkTfONyvFrdP6OxUWZjSq+r
   CwLAjtJXkUY01K67VApugqJjc5bqnxwsgSmlpzB/zmyLKxV57VDbDzHOP
   s4lLVaFhxygX9CAbue+gsFsHbL4R4xsUOvc8xd412VAmRb4lNpCQ6Nmdr
   fvQW49MkVb82SXZXZYdjkuwA2kC8e/WEvmgXhYk38KtobPotNFqZ06aLk
   v3mb3qkeznJio7c+FFxPsXUHK70zSVbaBbHhl2Tmg8E2ZMvMIdMLuktyV
   Svjj4yPxqHIPRjzaXfwsllNCvDxbHKJ39+VHX8U6p7gjwwSAycyq8g3GD
   g==;
X-CSE-ConnectionGUID: h7LHmjw1QTaO7mjO5p7y5A==
X-CSE-MsgGUID: Ytzd2u6dRHyc/fX40FYkOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813865"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813865"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:17 -0700
X-CSE-ConnectionGUID: wEK+Mip7Sn+FmKhrEhPpUQ==
X-CSE-MsgGUID: AUpqYfKaR8Sk9opOUXWs6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432557"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] iwlwifi updates - 28-10-2024
Date: Mon, 28 Oct 2024 13:54:45 +0200
Message-Id: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
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
Features and cleanups from our internal tree.

Miri
---

Avraham Stern (1):
  wifi: iwlwifi: mvm: support new initiator and responder command
    version

Emmanuel Grumbach (6):
  wifi: iwlwifi: mvm: support new versions of the wowlan APIs
  wifi: iwlwifi: mvm: MLO scan upon channel condition degradation
  wifi: iwlwifi: allow fast resume on ax200
  wifi: iwlwifi: mvm: tell iwlmei when we finished suspending
  wifi: iwlwifi: be less noisy if the NIC is dead in S3
  wifi: iwlwifi: mvm: don't call power_update_mac in fast suspend

Johannes Berg (5):
  wifi: iwlwifi: mvm: clarify fw_id_to_link_sta protection
  wifi: iwlwifi: mvm: unify link info initialization
  wifi: iwlwifi: mvm: allow always calling iwl_mvm_get_bss_vif()
  wifi: iwlwifi: mvm: use wiphy locked debugfs for low-latency
  wifi: iwlwifi: mvm: clean up FW restart a bit

Miri Korenblit (3):
  wifi: iwlwifi: move IWL_LMAC_*_INDEX to fw/api/context.h
  wifi: iwlwifi: bump minimum API version in BZ/SC to 92
  wifi: iwlwifi: s/IWL_MVM_INVALID_STA/IWL_INVALID_STA

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../wireless/intel/iwlwifi/fw/api/binding.h   |   2 -
 .../wireless/intel/iwlwifi/fw/api/context.h   |   3 +
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  69 +++++++-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  30 ++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  11 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |   2 +-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 152 ++++++++++++++----
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  66 ++++++--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 -
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   6 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  11 ++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  22 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   2 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  14 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  27 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 .../wireless/intel/iwlwifi/mvm/offloading.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  24 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  52 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   6 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +
 33 files changed, 408 insertions(+), 180 deletions(-)

-- 
2.34.1


