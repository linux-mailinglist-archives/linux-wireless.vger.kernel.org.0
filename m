Return-Path: <linux-wireless+bounces-35598-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP4tJFfu8WmulgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35598-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8F493A50
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA41E3025148
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243593EFD39;
	Wed, 29 Apr 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1oWejxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42637F746
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462865; cv=none; b=MYt9N5ra+HCl0Fg0AbEgrLgFY72UmR/KsVFcXlc2h+XBtDuohnT/oXW5ypKvbohrj8IFe/ZCSk0M8TL9THJOQ2s6K/gFdOFttQdpT5d2om3NLo7RsWDCnHd6GQYQSA037Qn5MyW2UYqaQOp2gwOSHIUlcEXeOIwoxRHVy3p+/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462865; c=relaxed/simple;
	bh=U0Fh4wxu9C19NYra7wFWY6D4h5H1mEEdUSu6Het0Hhw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RRDI/bbCYxIEcMIuX0aIXb2EYABBxqh5JPoWtrCIrpCjFgGTxrHnspea+DTNdykhW4g/zpgDoQH6gjdzlnT1ukrdjHH13YkjAcHKRsyIIZFWM3Tzm9yYbZxtUKJ2AFP7u3BWlUrNZx0mbpAOFYNGi2idYHeas851AJV5GVS3vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1oWejxb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777462864; x=1808998864;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U0Fh4wxu9C19NYra7wFWY6D4h5H1mEEdUSu6Het0Hhw=;
  b=P1oWejxbcfU5LoidbX/AyCRlQkLYYzudbmZwLZJol5ENtEKdMd8lHxwL
   x7hFf/xYFO79Hb53WfCRnQL9anzPEwolOjcFR+2pI3W8vxIy5zmPDzT3N
   CbGbzVggJAA5NoQswpNuka9mUOFEMqw0uXgH/RCO71Bs/zl2A/ZOq/1m4
   NGUOGRmN+Y7GMgKNe6G7LP9YIyaG1FusYBdJ1hTBzP9qSqYyefhHp26YZ
   D9kbCZfhdyRokGBo52e75pDLTko39iAjci8sNq0jTHkmc9RB8WK5Vz5uo
   zI/gkm5hskkjjZjyXBQnjL/bK2enLHs6ookN6BxIKoEC4u5yzNIkBLEWS
   A==;
X-CSE-ConnectionGUID: 2BPfr3X9S9e4DEIQHh2dRQ==
X-CSE-MsgGUID: OKKVdfHNShyJg2Mz+Xp8mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88986104"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88986104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:03 -0700
X-CSE-ConnectionGUID: ym2AMQR2QlS3KW1hLCkjdg==
X-CSE-MsgGUID: KqBiNWKxTLSU29xILIXHeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234505099"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 04:41:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 00/15] wifi: mac80211: more NAN patches
Date: Wed, 29 Apr 2026 14:40:34 +0300
Message-Id: <20260429114049.4167111-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38D8F493A50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-35598-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]

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

 MAINTAINERS                                   |   2 +-
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
 16 files changed, 786 insertions(+), 409 deletions(-)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_i.h
 rename drivers/net/wireless/virtual/{mac80211_hwsim.c => mac80211_hwsim_main.c} (94%)
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.c
 create mode 100644 drivers/net/wireless/virtual/mac80211_hwsim_nan.h

-- 
2.34.1
---
v2: fix MAINTAINERS file to include the newly added files

