Return-Path: <linux-wireless+bounces-35806-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMhoHOlI+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35806-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8434B942B
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1DEE3002E6D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391842DB7BE;
	Mon,  4 May 2026 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcyAT7Vr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428302DAFDF
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879271; cv=none; b=i96e0wiAOM0vSFgb+wmgXoJz3WUwt638jx3a1oPYqLWL3I6Sg+VHUOOdh59gXe64jAlWRcp6/1AqvuPksMpp5k+S5v0zCaqKfgfMgngmm+Df2RAajl0j64EQscNsfpAh+8VTrkwlRHb6j6erAsHadjPf0GCuWfIROCSMmHoFTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879271; c=relaxed/simple;
	bh=cVXIe26ZF2ppm5Cw4U0R1R/eAQQYxr0R+tnM1STijZ0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=VuaXfvtK+oLqTND0t+EjyCog0a0WWGq2UsLI6lE5joC/LXjz3EZb975N2iQrYeFEINpp3H6H8Ju6mi9lhk+swjYEefAVuMzxqtvai/vD4AKXG8cRVcJt2BWFjKu2PD90wBPXQ/a+yHTvjQJlkVVpe4CaK/QxMuQloGyqD8iAnxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcyAT7Vr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879269; x=1809415269;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cVXIe26ZF2ppm5Cw4U0R1R/eAQQYxr0R+tnM1STijZ0=;
  b=HcyAT7VrUdektpkoTQa0YaOsKrjlOm+ceufQC2Ovm4wejEco0ewPtfOq
   ezejAPYSv1/7UbkSeoSDlx2WV22f/DxYiEjC3GUuOMRjAeKiym+nd5P5D
   +ZKgO49k5J12QUmOXJ/hJvjnKpDR4kG51Ie4OqIPZvlYqPGaLwSgn4Doy
   a2+rivZ61vSNcUZvz0h3SeTt4lslNkY7Lv1UJfNwf/Rzbr1OrmN83kyBQ
   o2HjUpTsn4SOoDM843nLcA53ce4wU4aSqQ65WPSodK3KvsTLTQ77DqkRo
   M92wX9imsr998bI7dVepj4qGhnitU0x+4qNalBHe/fDF3dGE7w8Kr9Q4u
   g==;
X-CSE-ConnectionGUID: 2DvuxHG2RRSbJHERjuvR8A==
X-CSE-MsgGUID: i9W6XSRdSWu6JijRVJF88A==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398310"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398310"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:09 -0700
X-CSE-ConnectionGUID: mCl11uPpQ3KaYnkWFue4/A==
X-CSE-MsgGUID: NjoyJ8ODSXCvkVmQ8gbaOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555206"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v4 wireless-next 00/15] wifi: mac80211: more NAN patches
Date: Mon,  4 May 2026 10:20:40 +0300
Message-Id: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB8434B942B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35806-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER_MAILLIST(0.00)[]

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
v3: fix an "always true" check in commit "split NAN handling into separate file"
v4: fix the unnecessary check for real...

