Return-Path: <linux-wireless+bounces-471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E558069B5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698E01F215AF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94AE1947C;
	Wed,  6 Dec 2023 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GB6qQH2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9AD1A4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701851740; x=1733387740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6PnsMg4rP7Gr5XYlr9YFhOvgN9KD9C/P5ep/0T+MY/c=;
  b=GB6qQH2nqiky7GNTRCU7aL14tRKVDYXoJ7L3GVL8hFgXnjxCcDBPX48W
   6KWRoxfatZY/69VufAiaV/Vx6ymopaFDXMle/x25UmtE0pgxj/V1xd0PS
   gqagLPWb6jEtVa9AjE/2mebMWpsFpsuiBprBCIWooWzb19YIbq5GzmJSU
   /nFBUDT+g+63xaAJC4BeGXU/xnzeY7B68PdYcXCcak3aRi8/hO8JDsnmE
   nKlBesgX/mK4jaeAPEjSJr/GhHtcBJrw0LbvE6HomKQyYXWtoYBbMaVdg
   l1cQefz2SQJu9rK6od53wkwAjqVsHjquPmhhtfI1C8YT1vu2SBpRzLmPZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="397915212"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="397915212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="805572477"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="805572477"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 00:35:38 -0800
From: miriam.rachel.korenblit@intel.com
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
Date: Thu,  7 Dec 2023 04:35:49 +0200
Message-Id: <20231207023602.968890-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

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


