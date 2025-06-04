Return-Path: <linux-wireless+bounces-23665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A365ACD657
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 05:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8112F7A7CD1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2452236FB;
	Wed,  4 Jun 2025 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6t3/dnx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5221FF39
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006820; cv=none; b=FKwZeEq9Ld7xl3Bm0iftHGuE1ilibMCRbdmqBjO5AzpOiAbT0yHc001ojtaqIkPgYxUzfFHweY/ezR+IUSJR9wGydviJPDQRcsmlIPQImoWHAGDFhPSVROMa2yG1wt3AXdacTx1QsQG3geD9f3kQASCdCLW+hBCBHoS9VtFDRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006820; c=relaxed/simple;
	bh=WwXp0OY1CbowbBAAJ60SO8A1fht18F01nuzM7LJmJps=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=f7BMaJlbVizNN25RrXCqMIHGiA4c46m3hEfaSnV20C020fiQWkDWR6st85Vx98rg6kp2A3gON8djS53PSICFIeMsR5MZ9r9Quw61WqTaODkvDBGm8dM2lsRf4BCJJw1qFl9c/9/B7ZBBVJI0eI56yVr6pU5MfnXdXiMlFHreqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6t3/dnx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749006818; x=1780542818;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WwXp0OY1CbowbBAAJ60SO8A1fht18F01nuzM7LJmJps=;
  b=K6t3/dnxef9yk3ji2QNyPUwMBCxg8cHTYsgAMg7YRiioz+CICTjq5rdu
   h15/CV0rBDAEGoP62UnHOf3OI7WTRQI9j3nWl5d8/Y81nXecdjogJ0WOg
   z4GAfQ/y2MeGZKcJanXV2f7zrwv6gdX6FHQfHpNcWoRVcawmMYcm5cIRo
   48WI3rjWmTsEeH9f//zUOEOuqYdzy9bRmG8XZzv0xD6C+Noz5N33NU/QY
   +4u2ChOFGMEPUWhTgAg7NqdxrM/up12scUPnm5Dm4XWrbVxa7Db7gW+/l
   6l/N6Rp1UAs4vukDVyVlxd6n7/5S1b6/W61EVHBv4FomBiTxXOgvrPRQM
   g==;
X-CSE-ConnectionGUID: KT2T9o0YTuClK2qR4T49nA==
X-CSE-MsgGUID: CFnG8yEtSNS8no7EaOXp7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68504615"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="68504615"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:37 -0700
X-CSE-ConnectionGUID: HQX5D70USjuhEIxLQArnNA==
X-CSE-MsgGUID: GteJywliSmefQtyVfmL70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="182227341"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 20:13:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 0/4] wifi: iwlwifi: fixes - 2025-06-04
Date: Wed,  4 Jun 2025 06:13:17 +0300
Message-Id: <20250604031321.2277481-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi

A few fixes from our internal tree.

Thanks,
Miri
---

Ilan Peer (1):
  wifi: iwlwifi: mld: Move regulatory domain initialization

Johannes Berg (1):
  wifi: iwlwifi: pcie: fix non-MSIX handshake register

Miri Korenblit (2):
  wifi: iwlwifi: mvm: fix assert on suspend
  wifi: iwlwifi: mld: avoid panic on init failure

 drivers/net/wireless/intel/iwlwifi/mld/fw.c          | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mld/mld.c         | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.34.1


