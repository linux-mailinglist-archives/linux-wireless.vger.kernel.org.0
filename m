Return-Path: <linux-wireless+bounces-33947-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CyrBIIMxWkI6AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33947-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:37:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA513338AA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF166308F3F0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6310134DB78;
	Thu, 26 Mar 2026 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eL2RghMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C438736E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520103; cv=none; b=Dk8qZOMrJGsZFjArNCxHaGanYi00kWeysj26eLrI4y1eBByRmlvIRnNBM6RnmbARwreBg9r7eMhcJ5gantwRIhj83h39eUhKPs8mDZL1UsPYOE94nRZD9l4UhUjgn4Lwn7uRdxN4oz2I7lbbGKiqCPkAKHXrQ9zp907TsQzfJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520103; c=relaxed/simple;
	bh=QDXbIh97eyXOBDhHFGlgocCzokaCx+brsIUF7TsqSCs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KbhR0z2RR7/3HO+Aiv2C9DbAHIqAx0feGkp/WGLhWZOeMv4VO2CX5MOgTZcqIHbF8K5xeB95ImddBcqcMaN5zaE+d57RplO4g/MGXeBRzpAl4/rglb2KHSjD55kkYeLBjTLfEPngu9+LkysYsD50TaVnyTlKZo9O4nZVflzI4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eL2RghMv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520102; x=1806056102;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QDXbIh97eyXOBDhHFGlgocCzokaCx+brsIUF7TsqSCs=;
  b=eL2RghMvTDDO9Fl7047+em1IZGq3861udALFWeZdGp7RgQuqqneXqfyQ
   HnqtYFjXG6GzbXAVVn+H2/UrHEsdk8me4DCQVjPkJvYX9KYjPSttwc+Yj
   06kzxj7gT5+IPInR8A2KjOCiHZQPg66elBIXB4IWcUcSF0MvqI/iyfpyA
   thKUXswfSHNDz6b+kyR62VxqVlOdwAIfSMD9Ib2Y5SUUyz3OC964hcW64
   qnynPeRsjk9dz42cEWcoDW/b5ss1LVM6/ZwYcLwcsXS8i8DaO/bwo6F83
   YXr3AWc16FHre2lYPtYEYwd2n3ZIj6xh/XdbA9cRbLLi9FpZEUfHhEFAH
   w==;
X-CSE-ConnectionGUID: CPBpV3GJSNG3mj65H5A64g==
X-CSE-MsgGUID: yckL2iCVRjm1Kb8k/zJLmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048548"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048548"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:02 -0700
X-CSE-ConnectionGUID: 23xKvHtTRUSnH69i4w8Odg==
X-CSE-MsgGUID: Xj3ccRT1QHa7LA4Y4pkD7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653039"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 00/15] wifi: mac80211: add NAN support
Date: Thu, 26 Mar 2026 12:14:30 +0200
Message-Id: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33947-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 5CA513338AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
This is the first series of patches for adding support for NAN in
mac80211.

It contains (mainly):
- support NAN local and peer schedules
- basic support for NAN DATA interface
- support NAN stations
- support configuring keys on NAN interfcase
- support Tx/Rx over NAN DATA

Thanks,
Miri
---

Avraham Stern (1):
  wifi: mac80211: allow add_key on NAN interfaces

Benjamin Berg (3):
  wifi: mac80211: add a TXQ for management frames on NAN devices
  wifi: ieee80211: add more NAN definitions
  wifi: mac80211: export ieee80211_calculate_rx_timestamp

Miri Korenblit (11):
  wifi: mac80211: run NAN DE code only when appropriate
  wifi: mac80211: add NAN local schedule support
  wifi: mac80211: support open and close for NAN_DATA interfaces
  wifi: mac80211: handle reconfig for NAN DATA interfaces
  wifi: mac80211: support NAN stations
  wifi: mac80211: add NAN peer schedule support
  wifi: mac80211: update NAN data path state on schedule changes
  wifi: mac80211: add support for TX over NAN_DATA interfaces
  wifi: mac80211: Accept frames on NAN DATA interfaces
  wifi: mac80211: allow block ack agreements in NAN Data
  wifi: mac80211: report and drop spurious NAN Data frames

 include/linux/ieee80211-nan.h |  37 ++
 include/linux/ieee80211.h     |   1 +
 include/net/mac80211.h        | 157 +++++++-
 net/mac80211/Makefile         |   2 +-
 net/mac80211/agg-tx.c         |   3 +-
 net/mac80211/cfg.c            | 195 ++++++++--
 net/mac80211/chan.c           | 132 +++++--
 net/mac80211/driver-ops.h     |  21 +
 net/mac80211/he.c             |   7 +-
 net/mac80211/ht.c             |  19 +-
 net/mac80211/ibss.c           |   2 +-
 net/mac80211/ieee80211_i.h    |  52 ++-
 net/mac80211/iface.c          | 104 ++++-
 net/mac80211/main.c           |   4 +-
 net/mac80211/mesh_sync.c      |   2 +-
 net/mac80211/nan.c            | 710 ++++++++++++++++++++++++++++++++++
 net/mac80211/rx.c             |  61 ++-
 net/mac80211/scan.c           |   2 +-
 net/mac80211/sta_info.c       |  29 +-
 net/mac80211/sta_info.h       |   3 +-
 net/mac80211/trace.h          |  31 ++
 net/mac80211/tx.c             |  52 ++-
 net/mac80211/util.c           | 146 +++++--
 net/mac80211/vht.c            |  16 +-
 24 files changed, 1641 insertions(+), 147 deletions(-)
 create mode 100644 net/mac80211/nan.c
---
v2: fix s-o-b
-- 
2.34.1


