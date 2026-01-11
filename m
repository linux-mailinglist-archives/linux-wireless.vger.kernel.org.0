Return-Path: <linux-wireless+bounces-30649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0703D0F850
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE5A302A973
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637821ABBB;
	Sun, 11 Jan 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+LDw/0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8093349B17
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153177; cv=none; b=GSRWvgagWM3baqT8mEuBORqMEZb8QNFy0v8RvuUVef5Wa9tPk2uFwwsbTRyViClr9Wlb2bf6tnCnLUNQUM4ilohGTKIU6iQRokTuGFjMPCfU2XqVoTtWqVZFPSrRzFBAN9d//J6UkmskT61G9tcPZe3u6jo9AGtil6O9ZDaNrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153177; c=relaxed/simple;
	bh=LEcTMqlw9rIi6ZTpTDzV1T/DmD1IvIhFkRz6MrCbZRw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ECXv0/4vz8rEdWu98gxydPgrF3TryX2dSCpjR7pXfYNSGrx+lp/Xhp0APoek4YlKHgsDKflKafTuf2KefGUtEEmjOPLEJsmUtrvDUEyIBR8MS4iKZpd/ri4xbt5S+UjKwqTlJf7ZgEEpmO9SUTw8NtFkXbPIuO7Yv4N3K/bCs30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+LDw/0B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153176; x=1799689176;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LEcTMqlw9rIi6ZTpTDzV1T/DmD1IvIhFkRz6MrCbZRw=;
  b=N+LDw/0B6WAQd4SwpfLnoInCp4Y2eGDCtV5dETCCj9TYvo1hkeZMsUXG
   zzDjAWZNRAPVqg5D8VSB6MwbA/Zu4I2x3mVQhZcAyEr1HxyUqTVBAjkw8
   mykcmFuvJ1eb31SzNgi1CbPQAECX46Tg0JQelptxu2XhJRlXaLSEsdPr1
   urP07WOweVAyQT4qKJL+iJYnvJO8WkVt5svRgnkZZB4BJ2ogFluwP8ITb
   r3CnN0OpSpAJZgl9+/e+rC1sxA7pezAwC94tleG0ReKjkWxyWnECl1N7S
   JOdSHHBthGdCfPkki5dOlGjv0QXyLNTtKh1ll/bXjb58Z+GtQ9Ag5Wr9Y
   Q==;
X-CSE-ConnectionGUID: NdbBr8C9S7m9xj68B/tBeg==
X-CSE-MsgGUID: HqR/vd/uSpeKGl0ELhN7NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521080"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521080"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:35 -0800
X-CSE-ConnectionGUID: gBBK1v82ScCZlT03lQb3WA==
X-CSE-MsgGUID: ygY5eizYRXuBTnE+kWijqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393762"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-01-11
Date: Sun, 11 Jan 2026 19:39:11 +0200
Message-Id: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
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

features, cleanups and fixes from our internal tree.

Miri
---

Benjamin Berg (1):
  wifi: iwlwifi: mld: change cluster_id type to u8 array

Emmanuel Grumbach (7):
  wifi: iwlwifi: move lari helper functions to the op_mode
  wifi: iwlwifi: move iwl_get_lari_config_bitmap to the op_mode
  wifi: iwlwifi: acpi: cache the DSM functions
  wifi: iwlwifi: uefi: cache the DSM functions
  wifi: iwlwifi: split bios_value_u32 to separate the header
  wifi: iwlwifi: support V13 of iwl_lari_config_change_cmd
  wifi: iwlwifi: rename struct iwl_mcc_allowed_ap_type_cmd::offset_map

Johannes Berg (1):
  wifi: iwlwifi: cfg: remove iwl_be221_name

Miri Korenblit (3):
  wifi: iwlwifi: mld: fix chandef start calculation
  wifi: iwlwifi: mld: add an helper to update an EMLSR blocker
  wifi: iwlwifi: mld: prevent EMLSR when NAN is active

Nidhish A N (3):
  wifi: iwlwifi: mld: Fix primary link selection logic
  wifi: iwlwifi: mvm: Cleanup MLO code
  wifi: iwlwifi: mvm: Remove link_id from time_events

 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    |   1 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 117 +++++++---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   9 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  34 ++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 206 +-----------------
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   9 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  17 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  72 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 -
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   2 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  26 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  59 +++--
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   5 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  |  34 ++-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  66 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  51 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 202 ++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  22 --
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  11 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  68 +-----
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  29 ---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 193 +---------------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  28 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  60 +----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   8 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |   4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  39 +---
 .../wireless/intel/iwlwifi/mvm/time-event.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  51 +----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 -
 34 files changed, 598 insertions(+), 856 deletions(-)

-- 
2.34.1


