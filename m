Return-Path: <linux-wireless+bounces-36145-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LcjCv/QAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36145-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:39:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B8505B6D
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57D6B3002318
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91393002A0;
	Sun, 10 May 2026 18:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jc795Fyq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124026B75B
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438394; cv=none; b=eteeP1MBSuWegqLL2uB1TIUqo795Og00+MMjeWxo2txDO8fo/TRsrWe2VpDAuicbkJmQ+AMUlsEnGKqb5wccg+yZxGCJSy/6ymPssZ/+m4Y48sAe1kP3LhJgM9KRhY6LBot5XgRkAJwh+GxIyMwCz/xtj/OQGOavD77hDt0pGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438394; c=relaxed/simple;
	bh=76SBvI9QVf4xh/g0dEOU7t5pmwpD25srxLgzeGjdTaQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kibIu602XcMfUEmmnbhilx9VgHw3/Fnpm6gSp75gi/ip0Vhf1sWa8irFp7bYrvIqXBrhzLuQ5XbxZK/QeZhpjHmXRZdvS4c8DaQT8kWy2iRvE3fO7SKNL0DcSlYRKaE+xWrDq51VUKDsWfCUGYW6IVqiR3JC8zgXY2RQuHXfaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jc795Fyq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438392; x=1809974392;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=76SBvI9QVf4xh/g0dEOU7t5pmwpD25srxLgzeGjdTaQ=;
  b=Jc795FyqTnhceg3QGFJIhY3916L688vfa6yqshzT+H4CB9/T3/69Xtqk
   zkFRuqjzEz6EEJXblYZq4nxWnfw84rS1mQBxWU+tpgJwCvknHBusWYVJ9
   XPTfgjgpil1a7YB9s6d+r4bml6I3u/xRGv0Cx4PxAV0Xh3CJUFIKf3iZr
   3nOZAADzCvbQRd6GWh7tCmo0j/yj645E1IKpchk2kEE5MbwJ+ljt1PCHZ
   snygfBzAhDTiR3VVLfqtqPG2LwFVM1a7ioPgKYOHEU5JTOPx+l3PSH3VK
   W5r2WRatLXvD/QpjT+jLwVbsZsNPKhDzTnJ+CTmNaxGz0OON4hptp2g8r
   A==;
X-CSE-ConnectionGUID: IboLu4knQTeFLECYQwQ9Bg==
X-CSE-MsgGUID: R2QMkTPmQHSb6Jb1AYNtvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208967"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208967"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:52 -0700
X-CSE-ConnectionGUID: UYgmpZ8pRYG7o7ND8Hc9rg==
X-CSE-MsgGUID: IOclAXmbTKmw6X/88dZ9mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626749"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: mld: add NAN DATA support - part 1
Date: Sun, 10 May 2026 21:39:23 +0300
Message-Id: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 846B8505B6D
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
	TAGGED_FROM(0.00)[bounces-36145-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

This series adds support for NAN DATA.

Miri
---

Ilan Peer (3):
  wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
  wifi: iwlwifi: mld: Do not declare support for NDPE
  wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID

Israel Kozitz (1):
  wifi: iwlwifi: mld: fix NAN max channel switch time unit

Johannes Berg (7):
  wifi: iwlwifi: mld: tlc: separate from link STA
  wifi: iwlwifi: mld: disable queue hang detection for NAN data
  wifi: iwlwifi: mld: support NAN and NAN_DATA interfaces
  wifi: iwlwifi: mld: add NAN link management
  wifi: iwlwifi: add NAN schedule command support
  wifi: iwlwifi: mld: implement NAN peer station management
  wifi: iwlwifi: mld: add peer schedule support

Miri Korenblit (4):
  wifi: iwlwifi: mld: set NAN phy capabilities
  wifi: iwlwifi: mld: use host rate for NAN management frames
  wifi: iwlwifi: mld: extract NAN capabilities setting to a function
  wifi: iwlwifi: mld: don't allow softAP with NAN

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  66 +++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  46 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.h    |   8 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 147 +++++-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  31 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   7 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 100 ++--
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 452 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  27 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  96 +++-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   4 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |   2 -
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 263 +++++-----
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  27 +-
 18 files changed, 1078 insertions(+), 224 deletions(-)

-- 
2.34.1


