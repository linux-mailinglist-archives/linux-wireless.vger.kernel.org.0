Return-Path: <linux-wireless+bounces-7460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0A98C2658
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4A1F23333
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136214C7D;
	Fri, 10 May 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSMsf5FM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5D128386
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350014; cv=none; b=Ri6Jkfbuy78LpLUGNh8LJYX9m8cqE3XIa0VLN9jTJ7dQFJNjezemekvW7VDTdOlrT7XFcR3wnMnKnr8eNmmSkLLPMafAA1OdRHdL0+5RuUmEktAyYxJ9oC9F8YwI2YzdOWXcj/ShDEch43BnBjFSC3V4q6CuOII+VNFG2M98iwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350014; c=relaxed/simple;
	bh=JCRab7RCHvv7o1jaodmVFqe1/6QrZwJGVJc3jROsaW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idutuLc8QXLbp/5lw/LkQE943mdYp5dRj/mthAnEf1DRygq/zccGLqL7yF8dgPG1zT15wmMTR+ZWRF0NmyWPxnIRABqrFNoFNHPXqPgVZDc1QOlxCm1QXX0t7VSqQqRcFMYX5IDLLa9+xTqpX9QahOkseJwei8NB2D5p5F8+u+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSMsf5FM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350012; x=1746886012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JCRab7RCHvv7o1jaodmVFqe1/6QrZwJGVJc3jROsaW0=;
  b=QSMsf5FMh6+FNRiW378VtcWTmcDYEMq9L0pbAQwSHEhYzjSVVLJMoW6N
   Y11GHDPfJxrELtt20WfogR05mEq7eixd5sQStJFd70bSPaPvgoswcpjN1
   nUIfAZiuCzuzL5s+ITVveVcCIlQoynSBcvCY4OklpPiLAk/GKn6tuuadW
   llNdSFcyAfE8f4BK6GqKaL6eLtoK3lpQL/x8cavK1MJ8MvHE59sJDASgL
   sCsNwaIkfMxbmdIjReGCxCtvcOKcX8J1cFs32nDkgz5pk6BwFyuviPDrN
   yrOJMmvvw8RWLtKdebQ5hmnI1raz5g2XaQEMhbyOwERpqLD7wXyvLYEjt
   A==;
X-CSE-ConnectionGUID: 436HtbF+QSa3I2ZpYZ+JEQ==
X-CSE-MsgGUID: n2vF014NRZGbSmQUS0YClQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125509"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125509"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:52 -0700
X-CSE-ConnectionGUID: 7FuHgseKScWXZzev9aVgww==
X-CSE-MsgGUID: Kp7kBH47R2q4QCHUQQ0ibA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101791"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/14] wifi: iwlwifi: updates - 2024-05-10
Date: Fri, 10 May 2024 17:06:27 +0300
Message-Id: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Andrei Otcheretianski (1):
  wifi: iwlwifi: mvm: Don't set NO_HT40+/- flags on 6 GHz band

Avraham Stern (2):
  iwlwifi: mvm: allow UAPSD when in SCM
  wifi: iwlwifi: mvm: debugfs: add entry for setting maximum TXOP time

Chaya Rachel Ivgi (1):
  iwlwifi: remove redundant reading from NVM file

Emmanuel Grumbach (1):
  iwlwifi: mvm: simplify the uAPSD coexistence limitation code

Johannes Berg (2):
  iwlwifi: dvm: clean up rs_get_rate() logic
  iwlwifi: mvm: revert gen2 TX A-MPDU size to 64

Miri Korenblit (3):
  wifi: iwlwifi: mvm: define link_sta in the relevant scope
  wifi: iwlwifi: mvm: set amsdu size to the correct link
  wifi: iwlwifi: mvm: call ieee80211_sta_recalc_aggregates on amsdu size
    update

Mordechay Goodstein (1):
  wifi: iwlwifi: mvm: set properly mac header

Shahar S Matityahu (2):
  iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef
  wifi: iwlwifi: remove fw_running op

Yedidya Benshimol (1):
  iwlwifi: mvm: Change default value of lookup_notif_ver

 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   | 21 +++---
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  3 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 14 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 38 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  6 --
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 65 ++++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  9 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  8 ++-
 13 files changed, 109 insertions(+), 71 deletions(-)

-- 
2.34.1


