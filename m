Return-Path: <linux-wireless+bounces-24057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A2AD6F67
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0483A3C54
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8F423C50F;
	Thu, 12 Jun 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG73wr1C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB8239E8B
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728961; cv=none; b=jcbxwSWUyhLZFwPUo4IMP4j+SDVPUzGXfwdh/jauJ5n3EJNEpoe8cAhzVtzcplQaYJbY9o+tss6lpjeGV75NojUXoQEE1gdHbOQULwWkMp7UWNq4M7iix6ytjoWJb8Ef5qnuayVwLuLRPALH6SzxIZrKkIkBUr4Ykqt3O+LxBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728961; c=relaxed/simple;
	bh=vXfvkRcwrv23a/YURCR2qfK5qj7J5ZZBCerlfNLsiFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCvye9AToRgU3YhDjE8JJ/Yk4WkwIGzdOovPG9PT8MF+rZogIMwe4F00nRwvrRrDHs/e/aD8iRYUd1bmymwp1SBcv5lVf2+kCADuBRh15Z9VfrnPqMNcJvIHxrOE9dm+nkzIvPiV1S51mJNvwZgGc7FBnCbTepDJcZUPEt5kxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG73wr1C; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728961; x=1781264961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXfvkRcwrv23a/YURCR2qfK5qj7J5ZZBCerlfNLsiFY=;
  b=QG73wr1C2t8KEIR2qWWXojS9QsC0gVeyPUP2VoN2Uv/1VCArz/p1dewg
   4T0PwI5FIXDPyOXJe+8EufrM2eKjvUo7ivDwenxasvyWSLnYBuD9uCHRg
   rS/Smy9yDK3bNOU/y5eCQKre5kBBxxLoUjkxT0TrAkPD9l1WOloXeP4KI
   H1ddGTdZROgafAFXo2x1fFHF+J/440uqMzJxhBG2edgAbiYMD+ertqg6V
   5Hud6eTV2F/tzf4QelV6tn9BAlXKidhs5eMDXCBedDgLrRzhzt5cY/7SD
   8BW1JXgi+r3I01nDh/ZtIjYaP+pqpHeJsGjKX41+BiTc4xhb7eEUWV6PM
   A==;
X-CSE-ConnectionGUID: I/sbgOINT8m1QT+8I+bSlQ==
X-CSE-MsgGUID: 2Mq3l8T/SpqvRA6oa1W/TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248327"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:21 -0700
X-CSE-ConnectionGUID: dcu4EYKpQbqtGH6uKZGKxA==
X-CSE-MsgGUID: stLNIof/QG2ohnwwUhzxKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382105"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:19 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/13] wifi: iwlwifi: support RZL platform device ID
Date: Thu, 12 Jun 2025 14:48:49 +0300
Message-Id: <20250612144708.0c509d05fc51.I462e2ca5b636b88764177b9e41a63f7717f50793@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
References: <20250612114859.3094387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add support for a new device ID that we will have on RZL.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index a42a6da5d2ea..4201c4b07e3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -545,6 +545,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xE340, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_mac_cfg)},
+	{IWL_PCI_DEVICE(0xD240, PCI_ANY_ID, iwl_sc_mac_cfg)},
 #endif /* CONFIG_IWLMLD */
 
 	{0}
-- 
2.34.1


