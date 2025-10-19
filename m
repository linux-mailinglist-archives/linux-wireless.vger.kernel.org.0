Return-Path: <linux-wireless+bounces-28062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E778EBEE0F5
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8032C4E6B77
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44811189F20;
	Sun, 19 Oct 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD2AKj+K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFB2BDC3F
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863541; cv=none; b=L6Ne+Jsl68aSa/qFPxuktJ+pYQQ/kEJSzA9gXYUxkSXB0ud41BxbdkHiiz93IWH3My6L+t58gtstok83XAiieurpDjWIom86CcV8som8iRRPBbYuI7N3utxcK8Ue8UL9KutM74v7ZEQ0wrATqIBPvo+jsS7K+0T3qyH60qV1d98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863541; c=relaxed/simple;
	bh=Fb90WG/ihwOkzWCs4YR8noz6kYTlIsNdoT+bZx3BxBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhlZK8MsUB7P8On2s7tNol60oMbJChI7uGJ9IgW0fRu+VWV2akhoeD5d8gRXgGYJqIeHLKyK+D/FXTvee2ytlpBYPEOCdRvo78xeAzA5rldOyi2sr+fklEE3SDXTEzR4PfqIQrSzYPBrWIVqrcM+uMdSAGu4tQBJvAme1Oz4KF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD2AKj+K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863540; x=1792399540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fb90WG/ihwOkzWCs4YR8noz6kYTlIsNdoT+bZx3BxBU=;
  b=SD2AKj+KNRi+Ecvx5AhP/mkQQN09F+dKoJYaxcSUdnR8P+S2yTf4v8g2
   nZ3UPZEyXEgBtGJDFs3lz6xTjO1MkZiXgn6VcVgOXFIr/fBwGI4e3ajfp
   FNH2tComOvnwJzeBJjwVlNa03sNRuiQGV7nLXJN3lCBQtxg7xqjumqS/J
   vJK9UiZFuMqES+rCVDZ2WNprdtNob8jg36qyzogNxSMHNPkdJ7eqMWIoM
   Q6qbaYFeMaXNwgbJfXDqYyi3BFwH+6ogYzDuTY+1oPqqFXbMzmtefpPB5
   b8qj5mXF6+ZkrLWg+ZvgTfSBTeOyxWQDaqnd/ol65RJjabpTUgjILe1Ni
   w==;
X-CSE-ConnectionGUID: vpSUd+mORleKc7gTdWQ7OQ==
X-CSE-MsgGUID: UcwVLK1gRsqwJbdJywyl9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363185"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363185"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:39 -0700
X-CSE-ConnectionGUID: f+kFRXj8Tm687wUPYLXcYw==
X-CSE-MsgGUID: IJi1ZdKMTyqlNCcbrMrZbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279885"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: fix build when mvm/mld not configured
Date: Sun, 19 Oct 2025 11:45:08 +0300
Message-Id: <20251019114304.615810979e7b.I9a215f955bb3208d99239be8496d19e0f186b4d0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When neither mvm nor mld are configured, we don't have the
iwl_bz_mac_cfg symbol and thus cannot check for it. But in
that case the relevant device entries aren't and cannot be
present, so just ifdef the test code for that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509170625.BAJBe7Bi-lkp@intel.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 3054bc0a9c67..6bf2ad18b009 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -274,6 +274,7 @@ static void devinfo_pci_ids_config(struct kunit *test)
 		if (s->device == PCI_ANY_ID || s->subdevice == PCI_ANY_ID)
 			continue;
 
+#if IS_ENABLED(CONFIG_IWLMVM) || IS_ENABLED(CONFIG_IWLMLD)
 		/*
 		 * The check below only works for old (pre-CNVI) devices. Most
 		 * new have subdevice==ANY, so are already skipped, but for some
@@ -281,6 +282,7 @@ static void devinfo_pci_ids_config(struct kunit *test)
 		 */
 		if (s->driver_data == (kernel_ulong_t)&iwl_bz_mac_cfg)
 			continue;
+#endif
 
 		di = iwl_pci_find_dev_info(s->device, s->subdevice,
 					   0, 0, 0, 0, true);
-- 
2.34.1


