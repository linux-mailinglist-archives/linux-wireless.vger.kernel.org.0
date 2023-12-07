Return-Path: <linux-wireless+bounces-473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDE806A12
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6CD1C20F76
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218619455;
	Wed,  6 Dec 2023 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CY+WjroR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF537109
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701852569; x=1733388569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IeHX6Wu/w+NO+M0i+a2CEmxIM81e8VaERENzim3fk4U=;
  b=CY+WjroRc5uOM9xP+j+4ufjEceneq2gh8k460Q5YmBJI0Ik1xv8uKVXQ
   q6VKeU0dERqmd/f/l4tbiigynU/d2GMGaMhlSiNauvDvIW2UObGClxyEk
   7ctWxPDb/TSSmAz6PPU4o5M87EjGvsCQQppena1k40FYAtqrAQZ1757o7
   smkMeEOMd8hcZHTwzG3lACAz98X8t5nupI9XU550n6ove9pKPp+trBb6H
   K8uWcU1YcM2SMeYkyHN4AWb2Ld/hxRFiELkRPJ7T33Jem13tt+7f6abSc
   ZWAzZgvwf97emUC09hDxbCcegG+yhgh7e64pUXIEddZrE08ioO0kuaOIk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397916493"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397916493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805575339"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805575339"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:49:27 -0800
From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org,
	miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
Date: Thu,  7 Dec 2023 04:50:05 +0200
Message-Id: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.8

It contains a few bugfixes and cleanups.

Thanks,
Miri

Avraham Stern (1):
  wifi: iwlwifi: avoid a NULL pointer dereference

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: add a debugfs hook to clear the monitor data
  wifi: iwlwifi: mvm: do not send STA_DISABLE_TX_CMD for newer firmware

Ilan Peer (2):
  wifi: iwlwifi: mvm: Use the link ID provided in scan request
  wifi: iwlwifi: mvm: Correctly report TSF data in scan complete

Johannes Berg (7):
  wifi: iwlwifi: refactor RX tracing
  wifi: iwlwifi: pcie: clean up device removal work
  wifi: iwlwifi: pcie: dump CSRs before removal
  wifi: iwlwifi: pcie: get_crf_id() can be void
  wifi: iwlwifi: fw: file: don't use [0] for variable arrays
  wifi: iwlwifi: remove async command callback
  iwlwifi: pcie: add another missing bh-disable for rxq->lock

Miri Korenblit (1):
  wifi: iwlwifi: don't support triggered EHT CQI feedback

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 10 ++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  7 ++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  1 +
 .../intel/iwlwifi/iwl-devtrace-data.h         | 15 +++---
 .../intel/iwlwifi/iwl-devtrace-iwlwifi.h      | 17 +++----
 .../net/wireless/intel/iwlwifi/iwl-devtrace.c | 17 ++++++-
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h | 21 ++++++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 11 ----
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 --
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 23 +--------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 16 ++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 13 -----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 31 +++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 14 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  5 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 51 +++++++------------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 34 ++++++++++++-
 24 files changed, 178 insertions(+), 138 deletions(-)

-- 
2.34.1


