Return-Path: <linux-wireless+bounces-31931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKAxKHJXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14F14BA40
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA0703014C59
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BD33508F;
	Tue, 17 Feb 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crlRBWt7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66991C8634
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329390; cv=none; b=Sk75mOfNl1ahWWkynr57QwmRhMsnd/tTPLBy0svs6FXHy8PcEwVGeWLrPGZXtRKgWfnX7jeysj5ykeUgwUQ7wfc5qXi2ImQg/5eIhh4GPHmynleAUmCZM2mfcuCcnP7NUihIM9iHaj40DRV5MwMj7bcAN51c9ERSzYgTBwDOFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329390; c=relaxed/simple;
	bh=gAw4A4cQTIvO7VwGOMpTDDzHXi7TfQeca3s98SHHTyU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XHAdi5tNIedUpJI7PLCOy19BpvVssQKr1daPAUbv221kKuyTbqmS8wR/gZbGPwkNSVSvL72IrbZfeEnZh057mGWFKvPG6Df0XGXETc77p2nhT6tyae/i/pWtejEtaMRnw2LACTQT2H9Phon88lRdW+px8xnqhaPRU++T9Qg3ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crlRBWt7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329389; x=1802865389;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gAw4A4cQTIvO7VwGOMpTDDzHXi7TfQeca3s98SHHTyU=;
  b=crlRBWt7hW6lAA1dB4ufOAuYvbxDibzjYTv6YLvwOCRsr7e/GYE5A1A5
   foqREu3HoTJdkgRn13LnHxuCy3g9yxSWt2NcfuP2VvgUHyBfYkTbMX8Yy
   90Ruwj285u/AeerNPZbtti1LfRxBfv89dhFUXu/8ci9w9k0PuOA82tm1R
   VdQ2NDKntME2jWOP3TFQMEHw7s9WpXQFQQZc/WWtk8AokOYOmL9drfQjT
   8kydhhCd8xz2PUMycqzxcPptOyOYW+MAqfdwbQ1NJDohPJPqEeLhlf7KL
   +PyKo6W1QGLs1aWZVTCdf5C/5PxtY8JmcKvvJWEp5+EaLI6n8zbKbvC4g
   g==;
X-CSE-ConnectionGUID: RMUhPrb4RpmEbjtpb8mH3w==
X-CSE-MsgGUID: 9V+Lboq/S5iAXCKesdq55Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495857"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:29 -0800
X-CSE-ConnectionGUID: XlXKnxvHS1yGiyxkeVOwcw==
X-CSE-MsgGUID: g6NBgqJ0T3aYGumucBD+Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547051"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 00/15] wifi: cfg80211/nl80211: Add NAN Data Path support
Date: Tue, 17 Feb 2026 13:56:03 +0200
Message-Id: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31931-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A14F14BA40
X-Rspamd-Action: no action

This series adds support for Neighbor Awareness Networking (NAN) Data
Path in cfg80211/nl80211. This includes support for:
- Local and peer NAN schedule configuration
- A new netdev interface type for NAN data communication
- NAN management and data stations
- TX/RX support

Patches 1-4: refactoring and preparaion
Patches 5-7: NAN channels and local schedule support Patch 8: NAN_DATA
interface type support Patches 9-10: NAN stations and local phy
capabilities Patch 11: Peer NAN schedule Patches 12-13: TX/RX for NAN
DATA Patch 14: local ULW change notification Patch 15: NAN channel
evacuation notification

Daniel Gabay (1):
  wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data
    interfaces

Miri Korenblit (14):
  wifi: nl80211: refactor nl80211_parse_chandef
  wifi: cfg80211: remove unneeded call to cfg80211_leave
  wifi: nl80211/cfg80211: support stations of non-netdev interfaces
  wifi: cfg80211: refactor wiphy_suspend
  wifi: nl80211: don't allow DFS channels for NAN
  wifi: cfg80211: Add an API to configure local NAN schedule
  wifi: cfg80211: make sure NAN chandefs are valid
  wifi: cfg80211: add support for NAN data interface
  wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
  wifi: nl80211: add support for NAN stations
  wifi: nl80211: define an API for configuring the NAN peer's schedule
  wifi: nl80211: allow reporting spurious NAN Data frames
  wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
  wifi: nl80211: Add a notification to notify NAN channel evacuation

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |    9 +-
 drivers/net/wireless/ath/ath6kl/main.c        |    4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   20 +-
 drivers/net/wireless/ath/wil6210/main.c       |    3 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |    5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   23 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |    2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   24 +-
 .../net/wireless/marvell/mwifiex/uap_event.c  |    7 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   26 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |   26 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |    6 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   12 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   24 +-
 include/net/cfg80211.h                        |  289 ++++-
 include/uapi/linux/nl80211.h                  |  233 +++-
 net/mac80211/cfg.c                            |   22 +-
 net/mac80211/chan.c                           |    2 +
 net/mac80211/iface.c                          |    3 +
 net/mac80211/rx.c                             |    2 +
 net/mac80211/sta_info.c                       |    4 +-
 net/mac80211/util.c                           |    1 +
 net/wireless/chan.c                           |    4 +-
 net/wireless/core.c                           |  129 ++-
 net/wireless/core.h                           |   10 +
 net/wireless/mlme.c                           |    4 +-
 net/wireless/nl80211.c                        | 1015 +++++++++++++++--
 net/wireless/nl80211.h                        |    5 +-
 net/wireless/pmsr.c                           |    5 +-
 net/wireless/rdev-ops.h                       |   62 +-
 net/wireless/reg.c                            |   27 +-
 net/wireless/sysfs.c                          |   36 +-
 net/wireless/trace.h                          |  209 +++-
 net/wireless/util.c                           |   28 +-
 net/wireless/wext-compat.c                    |    6 +-
 35 files changed, 1976 insertions(+), 311 deletions(-)
--
v2: add commit "wifi: cfg80211: remove unneeded call to cfg80211_leave"
to the series. It was sent separately but should really be part of this
series, otherwise it contains a deadlock

V3: added more attributes to the local schedule API, added 2 more APIs
(ULW and channel evacuation notification), and fixed the documentation.
-- 
2.34.1


