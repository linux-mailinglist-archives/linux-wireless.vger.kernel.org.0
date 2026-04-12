Return-Path: <linux-wireless+bounces-34654-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ETNLP+L22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34654-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA13E3BA0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1496530128D2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76C3783DB;
	Sun, 12 Apr 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1rWU+JG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2D3382F1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995899; cv=none; b=fYZm/b9ONOFcutiYgH4ItGAkNNNYBoWBf1PMGYWcsTedFcYpBGZoBdouw5usaylgS9YEOgLhC65ggFvv2zuLLoeetNFrkKeZcY4haCWuxKTeROTDOv9BQhrRxK7ya3hxQrJJy/7M8fC8xTBC0cdHvF2VIQi3VzthqbirxWOh+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995899; c=relaxed/simple;
	bh=cJ3eVAKB7QYPfGqcDIvEdpzSmy5wP02JQk9mAFmnrsA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=adrFe94Tfmq0PK1DFyJaHC7dM/Jom+Wcd7pbrD/ebB1HQgv1nTuwRZAifFGeSxcSvB8ir3HjkLnozyCJp0yuRGh8k8ZmGnGSdWnD4JH0YVck5PEeyOZuGO1Kn46/SN3TkelF2HkCvv8ovstuygk9/9WW5/jyZqpjzm2g5bC43fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1rWU+JG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995897; x=1807531897;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cJ3eVAKB7QYPfGqcDIvEdpzSmy5wP02JQk9mAFmnrsA=;
  b=F1rWU+JGvk8dP6w+dh6mdMStmRCwk6NJFD1D5X7FKcGiDSJLucDYuJed
   uQO/jAKeouS2YVMkEfH22yjye+3bZ1xdcPgCYd8RePytNQR7/qjZobyBp
   k9DqvdPv30FcG/vsUEYl2QRiFJ0nmp45VppR7tgNbhDpnVSsNKqVLfpsC
   4YpQJDZijY5Wa14BKt+FrQlP7+6x6GbFBPL5+Mk+/u3nVR5TSviFi4fHr
   RROPLnX23oAZfivp9I8wdvX5oHT7FRZY6jkyMAkBiUEgYh63oMFtl37gB
   l7Zw5VhQy+nqTsKD2vNKm4x1peJy8jd0x6swem/EAC8ongOwR5Aj2f76S
   A==;
X-CSE-ConnectionGUID: B43ndSOaTkqlh9bxuBww4w==
X-CSE-MsgGUID: c14DsiR2QGS/QTnkzsR1cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028453"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028453"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:36 -0700
X-CSE-ConnectionGUID: zuW88HEzSQWf0dBWrWATbQ==
X-CSE-MsgGUID: rxS78OhVR5+ecPy6LOFQ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411877"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: mac80211: more NAN patches
Date: Sun, 12 Apr 2026 15:11:09 +0300
Message-Id: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34654-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BAA13E3BA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
This series adds a few more NAN features to mac80211 and mainly hwsim
support.

Thanks,
Miri
---

Andrei Otcheretianski (1):
  wifi: mac80211: Fix a kernel panic in ieee80211_encrypt_tx_skb()

Avraham Stern (1):
  wifi: mac80211: accept protected frames for NAN device

Benjamin Berg (8):
  wifi: mac80211_hwsim: remove unused nan_vif struct member
  wifi: mac80211_hwsim: move NAN related variables into a struct
  wifi: mac80211_hwsim: split NAN handling into separate file
  wifi: mac80211_hwsim: rename and switch simulation time to boottime
  wifi: mac80211_hwsim: move timestamp writing later in the datapath
  wifi: mac80211_hwsim: register beacon timer by calculating TBTT
  wifi: mac80211_hwsim: refactor NAN timer handling
  wifi: mac80211_hwsim: switch to use TXQs

Ilan Peer (2):
  wifi: mac80211: allow userspace TX/RX over NAN Data interfaces
  wifi: mac80211: Allow setting MAC address on interface creation

Miri Korenblit (3):
  wifi: mac80211: track the id of the NAN cluster we joined
  wifi: mac80211: avoid out-of-bounds access in monitor
  wifi: mac80211: add NAN channel evacuation support

 drivers/net/wireless/virtual/Makefile         |   2 +
 .../net/wireless/virtual/mac80211_hwsim_i.h   | 139 +++++
 ...mac80211_hwsim.c => mac80211_hwsim_main.c} | 508 +++++-------------
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 233 ++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  36 ++
 include/net/mac80211.h                        |  29 +
 net/mac80211/cfg.c                            |  19 +
 net/mac80211/chan.c                           |  28 +-
 net/mac80211/iface.c                          |   7 +-
 net/mac80211/main.c                           |   4 +
 net/mac80211/nan.c                            | 126 +++++
 net/mac80211/offchannel.c                     |   9 +-
 net/mac80211/rx.c                             |  26 +-
 net/mac80211/status.c                         |   9 +-
 net/mac80211/tx.c                             |  18 +-
 15 files changed, 785 insertions(+), 408 deletions(-)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_i.h
 rename drivers/net/wireless/virtual/{mac80211_hwsim.c => mac80211_hwsim_main.c} (94%)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.h

-- 
2.34.1


