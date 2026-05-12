Return-Path: <linux-wireless+bounces-36327-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNdaIyuBA2pX6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36327-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A65528B2B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5003530AE0AA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15635CB6E;
	Tue, 12 May 2026 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzfLNpSj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E93655EB
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614496; cv=none; b=Ns/NNtUZI7LQSVdrcOzJyG6o/J7cKoW17AciKLSfw7U9rnXhBhzNyUSlMwNB4A2N4kigcNOIC6im0K3CHmvNaydIFEbhGhYT6uSaLrDxk0kFee3QdMC6tz/7OhO1UoAHfHDDefQ1JwmAtLO1MJZP65WRGIilrGjU6WBkgk4Wj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614496; c=relaxed/simple;
	bh=HE4qqxuchr0Nj99uL89mJV4BSgIRf75qUSDUIlpN9AI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=amhrM5InBIkPs7LoodLVs50J9ezslvGaEUbRXBGNKnhf3cQ2uYHa7cYsSJblWVbhZFk2trk3SJ6lumh5zrP665lN5QFS2f1osbGF4xX6ZlCvIAz4QgBUskAFgKu1JYEn5QrepkFtfznWjHqnAusKYc8XeNPUGCYzREiNOIjsxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzfLNpSj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614495; x=1810150495;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HE4qqxuchr0Nj99uL89mJV4BSgIRf75qUSDUIlpN9AI=;
  b=UzfLNpSj9p6TwjjTgAZALrKHxAn+7gm0yVjEba8O4TTqMDm+V+pK0IFA
   RiExGZEhOcbjyhNXYlvA+c3QsOhXNpfQitSiDxJb+YE0MeMNTANs3MzF/
   N/JVxCRCBsnld9C9jqdSX3Cg2djkue8OFn937/4GilzvuVNJ7Gu3A4qJy
   peuWs/MTuNC3GyocY2+DeXbjVs1VCFJeJBV3uMGFrWP8BwTsTa/HkDsz2
   mbfpsDRBFyGMoMjjb0J+j9+gce4CIcEhjWyPCcV1QUIgV58QypmBsR+/X
   d9gnRr3PV0mE6aJMdi+JTwIyPXCzS7Ws56AYk/KYkaNErUW5Bgr+aQSyN
   A==;
X-CSE-ConnectionGUID: cJe9+a3dTgOjdFTNaCkIbQ==
X-CSE-MsgGUID: nPRzTRpbRUqJrerrWmD5yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148764"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148764"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:55 -0700
X-CSE-ConnectionGUID: ip7KfelLQ2yztLxnuKO5BQ==
X-CSE-MsgGUID: wwSchMWGQDmPO80mjvVR+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471630"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:34:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2026-05-12 part2
Date: Tue, 12 May 2026 22:34:26 +0300
Message-Id: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1A65528B2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36327-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi,

More patches from our internal tree.

Thanks,
Miri
---

Aaron Katzin (1):
  wifi: iwlwifi: pcie: add debug print for resume flow if powered off

Avinash Bhatt (4):
  wifi: iwlwifi: Transition to basic uAPSD with MAC_PM_POWER_TABLE API
    VER_3
  wifi: iwlwifi: mld: add chan-load hysteresis for MLO scan triggers
  wifi: iwlwifi: mld: add duplicated beacon RSSI adjustment
  wifi: iwlwifi: mld: Add KUnit tests for channel-load thresholds

Avraham Stern (2):
  wifi: iwlwifi: mld: call iwl_mld_free_ap_early_key() for AP only
  wifi: iwlwifi: mld: add support for nan schedule config command
    version 2

Daniel Gabay (3):
  wifi: iwlwifi: mld: fix NAN DW end notification handler
  wifi: iwlwifi: mld: add NULL check for channel in DW end handler
  wifi: iwlwifi: mld: validate aux sta before flush in stop_nan

Emmanuel Grumbach (1):
  wifi: iwlwifi: implement the new RSC notification

Ilan Peer (1):
  wifi: iwlwifi: mld: Add support for multiple NAN Management stations

Johannes Berg (3):
  wifi: iwlwifi: tighten flags in debugfs command sending
  wifi: iwlwifi: define new FSEQ TLV with MAC ID
  wifi: iwlwifi: set state to NO_FW on reset

 .../wireless/intel/iwlwifi/fw/api/datapath.h  |   9 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  55 +++++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  48 ++++-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  15 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 148 +++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/d3.h   |   6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  30 +--
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 129 ++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  15 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  29 ++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 149 ++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |  12 +-
 .../net/wireless/intel/iwlwifi/mld/power.c    | 177 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  22 +++
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  69 +++++--
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  13 ++
 .../net/wireless/intel/iwlwifi/mld/stats.c    |   4 +
 .../wireless/intel/iwlwifi/mld/tests/Makefile |   1 +
 .../iwlwifi/mld/tests/chan_load_thresh.c      | 139 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   6 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |   3 +-
 30 files changed, 993 insertions(+), 138 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c

-- 
2.34.1


