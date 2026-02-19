Return-Path: <linux-wireless+bounces-32010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GvGNDvclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:47:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9C615D7FD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89E8B300788A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844362EC0BF;
	Thu, 19 Feb 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5IMPMBZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC121ADB7
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494457; cv=none; b=RpPFv1ekYG9/XfKT2xECqdJ3lbHDdVHdGyAD/PZkhCxsVtcaDR4TYLGpeUjv5EbIwvZv0aR2+7JWlueJViWpqxs+N/29+vCalTEuU8bvWxB38WnWTvFWWSR9+GOAsOR/cIra0wx69YKTj5DpIesSeI1mdPjEINAwLMuJyPE1W88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494457; c=relaxed/simple;
	bh=2TzlPDcdCLm77TVc925lJG3BEF/Cyzl5GtNJsR5FUjM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UuB2XxrBphC5k6df8Xj01prF1Z4vPDDdPt8LN36fa9l/5WqI0q7l1Si9ofozcKqRJruAtBXbmR8xpDbMNYEG1qqiFh9LfhwvwPZHsqEFrZ0L8keWUWbowywP3FqvSdBphum8nMfx2uFJ2582K2Pe0MY0kpfDy+RK5rYVHQTJ2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5IMPMBZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494456; x=1803030456;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2TzlPDcdCLm77TVc925lJG3BEF/Cyzl5GtNJsR5FUjM=;
  b=m5IMPMBZacUB6q8n5P12bH8DVrWu1xYjmqHgs+fvPD+DZz/LzZpBy2Mb
   m09Fz5iwDiSo2mMeIApkd4ZMrUkk6je5M7UFHXQFwXIs4IABfSOj25Zi4
   AKvUMQzS4XTTr7+Gtv5yI6kfZ6Efbv4CVgB9aMV1+SQo8XVuzVTnnf1fR
   /sd9siZxNDAr74yzOt7tHlJY21pqNWylWwP4LLXdTyyG6MLciH8aT1hhe
   4x09ZHHn0xue2lh3K8w2i9tSnFmZIdk5a4ll6Q9adAc7nJNZQzIym05yc
   qdftmWo8P55RQND3xZo8HYT19NsaawZgBpQlbieN0swMZcWPhOtpyAzdT
   w==;
X-CSE-ConnectionGUID: 4MjMiFKySE+qEus+CZYUUw==
X-CSE-MsgGUID: NA81ThybRkyJG3e5fzSY6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680067"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:36 -0800
X-CSE-ConnectionGUID: cp+bacU4T1G+0gvVI9CSKw==
X-CSE-MsgGUID: jMYUDWVZRdqCPQmxW0x8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218988983"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v4 wireless-next 00/15] wifi: cfg80211/nl80211: Add NAN Data Path support
Date: Thu, 19 Feb 2026 11:47:10 +0200
Message-Id: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32010-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 7C9C615D7FD
X-Rspamd-Action: no action

This series adds support for Neighbor Awareness Networking (NAN) Data
Path in cfg80211/nl80211. This includes support for:
- Local and peer NAN schedule configuration
- A new netdev interface type for NAN data communication
- NAN management and data stations
- TX/RX support

Patches 1-4: refactoring and preparaion
Patches 5-7: NAN channels and local schedule support
Patch 8: NAN_DATA interface type support
Patches 9-10: NAN stations and local phy capabilities
Patch 11: Peer NAN schedule
Patches 12-13: TX/RX for NAN DATA
Patch 14: local ULW change notification
Patch 15: NAN channel evacuation notification

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
 net/wireless/core.c                           |  131 ++-
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
 35 files changed, 1978 insertions(+), 311 deletions(-)
--
v2: add commit "wifi: cfg80211: remove unneeded call to cfg80211_leave"
to the series. It was sent separately but should really be part of this
series, otherwise it contains a deadlock

V3: added more attributes to the local schedule API, added 2 more APIs
(ULW and channel evacuation notification), and fixed the documentation.

v4: Fixed not closing NAN DATA interface before the NAN one in case the
socket is closed
-- 
2.34.1


