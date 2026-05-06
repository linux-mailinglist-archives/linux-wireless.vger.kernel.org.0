Return-Path: <linux-wireless+bounces-35966-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I2rDje5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35966-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:44:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A74194D5F5B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4CA530238D1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268928B4FA;
	Wed,  6 May 2026 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwhLZ+ow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CD285C8B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039091; cv=none; b=WqoIgcO4EkJGBlV0sA12sCBsIw+OXd/4CDolMbz8IdbC2o97Hiq3oiJBJ4QTOq+HpFgAKZkF3Z+Oz4KTClkI9P5KmaMg0//zJ1pajWKgl4uUj3eNRrlT8GxmJgWOhAZ1PpawRMV36moyJUdKezm5KoDX0EdHhwkuud8nSSjciKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039091; c=relaxed/simple;
	bh=tTkyv9tcWN+7UXuZKGppe5/7X65WoXlDHA2N8W2AG2Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=T6nkvVodt8VnLCH+hgTr2oY3lX7jnZ7P7QAEOUBrkivEySksYn3EGiqzeDsqThz4dZx4RNynYR1701YTAEnoBbpRZa2sjHhTaLdwu/rtOlB7y8lgECOOiYpT/z5Tc1nwn1jwo5jKbpPLBhVDxeYbl2n8SqByzl71IZ/zf5sXmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwhLZ+ow; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039090; x=1809575090;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tTkyv9tcWN+7UXuZKGppe5/7X65WoXlDHA2N8W2AG2Y=;
  b=QwhLZ+owsKqgfc+Bxep5HTNQYMHdyUt/Xjq6DbF1m3uEoQRlhyb85Um+
   GqUg2hpid+2RNVsVxh5cagMMxmnVA/erfY/GZKw+jKNZyPD+6lbIiWeOr
   kldhM79gH/kNZhtblmLTgQ40m/8b9dP7NJ8tYnLABLWojTfyfmlTReo0q
   8WUNjcEb9r7K0Ne54WCv7cd645gqDKk7DPQ7F0YZYROqUprKkoYvdOK1c
   hvD0OeshcWHw7vBmEgw+C/e2JI124DINdjMDI0QvO9otTnLxL659hG6vv
   23yo4+UtFQgBpETGilQVR2Lqd8tb9HIqiLbFM2qOhcgavRnz6vewSJ4WY
   A==;
X-CSE-ConnectionGUID: PQ0WsmQ0Slyk1fqSJMkL5w==
X-CSE-MsgGUID: 61J3wEAeTTibx6SngD6Uwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791274"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791274"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:47 -0700
X-CSE-ConnectionGUID: aCXbz28dT9+vlDOS+djkAQ==
X-CSE-MsgGUID: YOLV7C6EQCii5a+7p1dycQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777735"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 00/14] wifi: mac80211_hwsim: some more NAN patches
Date: Wed,  6 May 2026 06:44:19 +0300
Message-Id: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A74194D5F5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35966-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

This series completes the hwsim support for NAN.

Thanks,
Miri
---

Benjamin Berg (5):
  wifi: mac80211_hwsim: limit TX of frames to the NAN DW
  wifi: mac80211_hwsim: select NAN TX channel based on current TSF
  wifi: mac80211_hwsim: only RX on NAN when active on a slot
  wifi: mac80211_hwsim: protect tsf_offset using a spinlock
  wifi: mac80211_hwsim: implement NAN synchronization

Daniel Gabay (7):
  wifi: mac80211_hwsim: add NAN_DATA interface limits
  wifi: mac80211_hwsim: add NAN PHY capabilities
  wifi: mac80211_hwsim: implement NAN schedule callbacks
  wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
  wifi: mac80211_hwsim: add NAN data path TX/RX support
  wifi: mac80211_hwsim: Declare support for secure NAN
  wifi: mac80211_hwsim: enable NAN_DATA interface simulation support

Ilan Peer (2):
  wifi: mac80211_hwsim: Do not declare support for NDPE
  wifi: mac80211_hwsim: Support Tx of multicast data on NAN

 .../net/wireless/virtual/mac80211_hwsim_i.h   |   33 +-
 .../wireless/virtual/mac80211_hwsim_main.c    |  263 +++-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 1191 ++++++++++++++++-
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   74 +-
 4 files changed, 1454 insertions(+), 107 deletions(-)

-- 
2.34.1
---
v2: fix checkpatch in one of the patches


