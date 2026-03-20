Return-Path: <linux-wireless+bounces-33561-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OyBJmoCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33561-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F04292D70F5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6B130DD351
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B778377567;
	Fri, 20 Mar 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJtPyDbj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1EE37269E
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994173; cv=none; b=hHyYieWQ0y+12N7NROw4EMEZxZeSj6axgxE3jxNTpMSRtd6yCd8e3FHLsAUm9WZPUl8N07OPDPhrVp4NaprlVjVjBzlN+zYHkLxtZpESGktrZAfzPChJ57ygKHGdHfIusdeJbuzBdvMjaAjCpBp6OUT9iy+Q1KPQd+br0R7grVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994173; c=relaxed/simple;
	bh=5KIjacq4CxJ0vnBQqRBnMSs29J6tnKhTH2S4iIXZVvY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XVWnIGiLunAh7uw8UgK0mQ7G/D/GzuQq7LB0KfHPqz+X5HNErSCxEQb1QtfT+QkIJbWX5A6rt4e5mfEJ+pWHZnNQn8rWWE8WJjOlisAEg+qBY3Vwwa5Lj3YM4TtqZg1fqV1NxZZb/HEBuROXgWC5cAnOoyvw+5Bxdf6svcjQQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJtPyDbj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994173; x=1805530173;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5KIjacq4CxJ0vnBQqRBnMSs29J6tnKhTH2S4iIXZVvY=;
  b=oJtPyDbj8No88f8bl5AFFCrRBCt0M7JjsDkH19HA5jCYfqXnnwJYDW9h
   kHH0UqdWHDOF0Nl6QQY1yPrCmBpz8bvovdBqIuiVNRClGaVi6gHg3/A1J
   4ABw9xeJ9OSpVzwFdsi9CD2Wlbc1gfFlF5Xeb5lb9+Xr092qLt6vcKuWL
   4PLUqGD/0gTSpD0wGZo3peBA79EaIbDObw/YkJq5T3C8ZDsFLrQ2lIHJ6
   0ow1wNYL2DDlgaKZdJlPQfm+ixBnA0P2yp1xLYD3F/HBhP1pFSTmhT8c4
   /iJeHHkRbTCjKu1vvmzWL4T5Xdrw2LYhTmE7X6AwUKLfnT0i8Jp3lsrxW
   Q==;
X-CSE-ConnectionGUID: Bi1Fq+nhTYyomddZ174kTQ==
X-CSE-MsgGUID: BvU9VqKQSJyq5VGHJB1vqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154105"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154105"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:31 -0700
X-CSE-ConnectionGUID: K6iQiAlGSPWytTt4t0MXfg==
X-CSE-MsgGUID: wT63/VXuTkO/1eka5ij9Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692546"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-03-20
Date: Fri, 20 Mar 2026 10:09:03 +0200
Message-Id: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33561-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F04292D70F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

features and cleanups from our internal tree.

Thanks,
Miri
---

Avinash Bhatt (1):
  wifi: iwlwifi: add CQM event support for per-link RSSI changes

Emmanuel Grumbach (1):
  wifi: iwlwifi: add support for additional channels in NVM_GET_INFO

Johannes Berg (8):
  wifi: iwlwifi: mld: enable UHR in TLC
  wifi: iwlwifi: mld: set UHR MCS in RX status
  wifi: iwlwifi: advertise UHR capabilities for such devices
  wifi: iwlwifi: mld: support changing iftype at runtime
  wifi: iwlwifi: use IWL_FW_CHECK for sync timeout
  wifi: iwlwifi: pcie: don't dump on reset handshake in dump
  wifi: iwlwifi: mld: make iwl_mld_mac80211_iftype_to_fw() static
  wifi: iwlwifi: mld: remove type argument from iwl_mld_add_sta()

Miri Korenblit (2):
  wifi: iwlwifi: bump core version for BZ/SC/DR
  wifi: iwlwifi: validate the channels received in
    iwl_mcc_update_resp_v*

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: fw: Add TLV support for BIOS revision of command
  wifi: iwlwifi: mld: eliminate duplicate WIDE_ID in PPAG command
    handling
  wifi: iwlwifi: mld: add BIOS revision compatibility check for PPAG
    command

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-pe.c    |  24 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  37 +++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  15 ++
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |  32 +++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   8 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  21 +++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 158 ++++++++++++------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   2 +
 .../wireless/intel/iwlwifi/iwl-nvm-utils.h    |   3 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |   6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   2 -
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   2 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  27 ++-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  25 ++-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  12 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  26 ++-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |  28 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   2 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |  13 +-
 26 files changed, 379 insertions(+), 92 deletions(-)

-- 
2.34.1


