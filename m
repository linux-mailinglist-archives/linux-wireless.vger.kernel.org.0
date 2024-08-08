Return-Path: <linux-wireless+bounces-11135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953A694C59B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39ED1C2093F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F3148308;
	Thu,  8 Aug 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yet1paOn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAB9460
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148584; cv=none; b=HrQrt7d/5NeR0uPJUJt8MsBjhrnM7XAUAXP5BJIu37cBHioOnWdZX6MAwNCsQtPsq5O67L69BbvxEPRuEjY0rf1xrnIaejUvxZBGHVpxPfHFHMn9KstJN4xELqDbOkL8hLZdPJRYAkdl/tw6LDzrEEGXTduL2W2cbTQB5mwakKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148584; c=relaxed/simple;
	bh=6OJmwqK6+LQOw/idpRunFsxhTge0BOw0JO/2ojyISXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iUxmOj0Hoj5oP+1LO6szZxSRggm30WgEEt8IraYOcU/6Q+XvJWQoYM2+PowtsPGo2hCc3lZtKyUw4S3EKaAcmQtHaPEbvp8UuH+UgqxXnw1/ZpKuUWx7xtyOr6xLEauBUUlm7/eglBabIjU/hpOVu9eNmC2Qo/9s7Aau4Y9LTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yet1paOn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148582; x=1754684582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6OJmwqK6+LQOw/idpRunFsxhTge0BOw0JO/2ojyISXY=;
  b=Yet1paOnAx94dw0kMYcHvxZwpub8mi6qQOERCOEfllVrF4lNwfFYXTla
   zsN+owFHT6T6O1B4Y9c/hPLVTPGCs1yUYq2zk/7cj/2N2IbkTtKrHJs+H
   6NTY9CmL4SipveU4R4vZo3NE1obdGdo2elPkt2hCc1Dvb/f1nG6fGOTf6
   9z/VoPsaIKCsRscmgXKp7TgRAEZzNqKuowtNhsqC/v1pWMaFry8aEdIcx
   6LpoZ9RotKwtA+n7Ia4FxvmwEZr3os+8Gbk+OQjCGYQ1m+YMrZyCih3v3
   EadvWDCSwjSg9a18U36rl7Y3GxZUy7UaHk7256ME/70gf/gsKlvFSP1Ye
   w==;
X-CSE-ConnectionGUID: L3fLV0h7SZWWfTEPkOkFwA==
X-CSE-MsgGUID: vbSfJ2NaRtmH3eM9RJ0oNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808824"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808824"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:01 -0700
X-CSE-ConnectionGUID: nmXEeJQOTkiIQVfgnbe7fg==
X-CSE-MsgGUID: njQmzAF9TzaE0uUmHWo3OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305266"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:22:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/13] wifi: iwlwifi: updates - 29-08-08
Date: Thu,  8 Aug 2024 23:22:36 +0300
Message-Id: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
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

This patch set contains a few features, bugfixes and cleanups.

Miri

Anjaneyulu (1):
  wifi: iwlwifi: allow only CN mcc from WRDD

Daniel Gabay (1):
  wifi: iwlwifi: mvm: Offload RLC/SMPS functionality to firmware

Emmanuel Grumbach (6):
  wifi: iwlwifi: mvm: rename iwl_missed_beacons_notif
  wifi: iwlwifi: mvm: add the new API for the missed beacons notification
  wifi: iwlwifi: mvm: handle the new missed beacons notification
  wifi: iwlwifi: mvm: exit EMLSR if both links are missing beacons
  wifi: iwlwifi: mvm: add API for EML OMN frame failure
  wifi: iwlwifi: mvm: handle the new EML OMN failure notification

Ilan Peer (1):
  wifi: iwlwifi: mvm: Stop processing MCC update if there was no change

Johannes Berg (1):
  wifi: iwlwifi: mvm: drop wrong STA selection in TX

Miri Korenblit (3):
  wifi: iwlwifi: use default command queue watchdog timeout
  wifi: iwlwifi: mvm: cleanup iwl_mvm_get_wd_timeout
  wifi: iwlwifi: bump FW API to 93 for BZ/SC devices

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  2 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  5 ++
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 55 ++++++++++++++
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  2 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  2 -
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 -
 .../wireless/intel/iwlwifi/mvm/constants.h    |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 74 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 25 +++----
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 14 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 49 ++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 16 ++--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 64 ++++------------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  4 +-
 23 files changed, 241 insertions(+), 111 deletions(-)

-- 
2.34.1


