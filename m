Return-Path: <linux-wireless+bounces-33383-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MR4K0GdummHZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33383-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:40:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E02BBA1A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39A223037278
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685C3D6CA7;
	Wed, 18 Mar 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDXrX1Gj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0920E030
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837579; cv=none; b=gXb0KFA0iAtUEbVe/ukQwrxo77xg7n20zFTpxOj7sDrXDjBqX5vvnHr74r73alAS/lulEJl6xry83fFj4ZUJDNlSKF8rpOqSRz+YkS086kDJQeI6YqEmNAJClIblLos3wYys/VZvoN3rW8agIom3MjsCs8iXbJDxAgES9hUswKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837579; c=relaxed/simple;
	bh=qiVZEaJZQzG+Y8B6qwun0nd9Pli4jZEAZbr8H3sgDaQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XVpQVHyCqIE4z4UZhGsw6tYm9R055d51tBl2oy5VaMxf+5VchsxVjuMpoSnDhUZYdFA/1LwiFxaoNPYB3977QC2At60WUwy3YNqTK7OtSa4MlHtT830EXoCcXFpVofzheiyxk11FmvKN7mBvSL0gToVkQFA9pAPar9IVt8U2QjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDXrX1Gj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837578; x=1805373578;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qiVZEaJZQzG+Y8B6qwun0nd9Pli4jZEAZbr8H3sgDaQ=;
  b=BDXrX1Gjp980n8zWsZ4c6wvvLoOgpF9pW5Z0iyyQ7gkGVmOg7D5UM2sk
   Y+gZ7530wp0VmnaoQU1rBrPS4IUDbaCtt5iygy0R7ce0WtPowfTT1a40u
   8sOp4UhZykxm3E/5815KIKskZS0o8iIpMEWQZngjAx/b0oWM8dInM1r4K
   6O3cq3QT4dtUYUA/qwXDEvSlCsb3cR4A8PJDyQAfhns22UwEDcc8B/EZ2
   W6XzQx8U75nX4+hOfj1oXycmI0f3byinogc+9WQnk+cav3yu6IPFUohKR
   v6usPLxF6Y/dsaHfG++i9q3QKCR+h5yYZMR5Rn+aOrFTFTreklsZ2pwo/
   A==;
X-CSE-ConnectionGUID: mTwgugx2TRWkHvUYm1QBUQ==
X-CSE-MsgGUID: kFzF1wR2Qv67Payfb2FEuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519258"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519258"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:38 -0700
X-CSE-ConnectionGUID: 07HGXfcEQ3qvuUYMQ48QWQ==
X-CSE-MsgGUID: 7oEyive0QsG7LZGsK6tqvQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v5 wireless-next 00/12] wifi: cfg80211/nl80211: Add NAN Data Path support
Date: Wed, 18 Mar 2026 14:39:14 +0200
Message-Id: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33383-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C4E02BBA1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for Neighbor Awareness Networking (NAN) Data
Path in cfg80211/nl80211. This includes support for:
- Local and peer NAN schedule configuration
- A new netdev interface type for NAN data communication
- NAN management and data stations
- TX/RX support

Miri
---

Avraham Stern (1):
  wifi: cfg80211: allow protected action frame TX for NAN

Daniel Gabay (1):
  wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data
    interfaces

Ilan Peer (1):
  wifi: ieee80211: Add some missing NAN definitions

Miri Korenblit (9):
  wifi: cfg80211: Add an API to configure local NAN schedule
  wifi: cfg80211: make sure NAN chandefs are valid
  wifi: cfg80211: add support for NAN data interface
  wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
  wifi: nl80211: add support for NAN stations
  wifi: nl80211: define an API for configuring the NAN peer's schedule
  wifi: nl80211: allow reporting spurious NAN Data frames
  wifi: nl80211: add NL80211_CMD_NAN_ULW_UPDATE notification
  wifi: nl80211: Add a notification to notify NAN channel evacuation

 include/linux/ieee80211-nan.h |   7 +-
 include/net/cfg80211.h        | 265 +++++++++-
 include/uapi/linux/nl80211.h  | 232 ++++++++-
 net/mac80211/cfg.c            |   1 +
 net/mac80211/chan.c           |   2 +
 net/mac80211/iface.c          |   3 +
 net/mac80211/rx.c             |   2 +
 net/mac80211/util.c           |   1 +
 net/wireless/chan.c           |   2 +
 net/wireless/core.c           | 130 ++++-
 net/wireless/core.h           |  10 +
 net/wireless/mlme.c           |  13 +-
 net/wireless/nl80211.c        | 905 ++++++++++++++++++++++++++++++++--
 net/wireless/rdev-ops.h       |  32 ++
 net/wireless/reg.c            |  27 +-
 net/wireless/sysfs.c          |  27 +-
 net/wireless/trace.h          | 105 ++++
 net/wireless/util.c           |  26 +-
 18 files changed, 1713 insertions(+), 77 deletions(-)
---
v2: add commit "wifi: cfg80211: remove unneeded call to cfg80211_leave"
to the series. It was sent separately but should really be part of this
series, otherwise it contains a deadlock

V3: added more attributes to the local schedule API, added 2 more APIs
(ULW and channel evacuation notification), and fixed the documentation.

v4: Fixed not closing NAN DATA interface before the NAN one in case the
socket is closed

v5: Allow local schedule setting with no blob if the schedule is empty,
i.e. in teardown case
-- 
2.34.1


