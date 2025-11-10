Return-Path: <linux-wireless+bounces-28748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F248C46415
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B4B189760E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A6211A14;
	Mon, 10 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAxWjKjS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57D302CC7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774017; cv=none; b=HTMbq0fPdl3yUhSZdqrP7UIXsINoeiYVBUekfjClN9CG+u73S8Z2m6+SVmbelLwL0hUTYh72DI2/9wzh4YRRDJKKtoifav3frXKgvEaNioJn5oypd518z6L3E1iM+HBqdlpmKl5VW9U/uOUr2pa1zB38g5KBRcI6iklUm5nBUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774017; c=relaxed/simple;
	bh=3sLicHUtp3P2lWJbljl0wSiU57coMcsvJSbl9KCOvMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dn6iSVTPPX7eNH1Sf03xXQh/Z2PsS1tZg94BsoDbVXwdD9K2CdwccT/srNKUigDi03lkzQCTccbaiCHgQxn/U3QXq2MU4tPyvpz3HteNK85hV/Y/tTK9ZGhmtAmD2Ip2RhZrha4gLO3UmEx/1+OwC2S2x8DZcfq4T0DuzbmpHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAxWjKjS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774015; x=1794310015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3sLicHUtp3P2lWJbljl0wSiU57coMcsvJSbl9KCOvMU=;
  b=eAxWjKjSacyVI/0bKIUKyeXofKa3d2kA5zqDHFabiSaZDhVDkwLXU4Ow
   EDe07AE7Ah2SCZ7JRSdRfoWoSQW9QZa/GD1e4IAKw9ivkliZyFcjEJO+y
   r4bkzABLE1K1TQ/zccL+omqZSwpcRoS4wqqxjIGwsq1ELJHkFmblTs0um
   va8DzQcBYBCibqnbcX/eOtFGg4vP0uDCGRpdczRB1VCiSn+sudR0OV021
   M7vLpdms6nPejl1fPV+qkMcxd+aWMBD48hQoEVyvNdSSBY8nfXgNklu0y
   aSeOF+hghGgEH1jxc9J9yKCFOLYiBn44ljDlyxprPAmA6jvSJPsO+oQmv
   w==;
X-CSE-ConnectionGUID: 5heILR9DQ32cagOkSyppzA==
X-CSE-MsgGUID: Qc7/lKj5SW22XiLQdeSl8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64856412"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64856412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:26:55 -0800
X-CSE-ConnectionGUID: S9pAFknPTcuA+6FYsvXNIw==
X-CSE-MsgGUID: uqKxBZ8RRIq8839ine8Ltw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:26:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/6] wifi: iwlwifi: add NAN support
Date: Mon, 10 Nov 2025 13:26:42 +0200
Message-Id: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This series adds support for NAN in iwlwifi driver.

Thanks,
Miri

Ilan Peer (6):
  wifi: iwlwifi: mld: Add support for NAN
  wifi: iwlwifi: mld: Handle rate selection for NAN interface
  wifi: iwlwifi: mld: Declare support for NAN capabilities
  wifi: iwlwifi: mld: Extend the NAN configuration
  wifi: iwlwifi: mld: Support changing NAN configuration
  wifi: iwlwifi: mld: Advertise support for multicast RX registration

 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 129 ++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  21 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  88 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 287 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  28 ++
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   9 +
 .../net/wireless/intel/iwlwifi/mld/notif.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  11 +
 13 files changed, 569 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.h

-- 
2.34.1


