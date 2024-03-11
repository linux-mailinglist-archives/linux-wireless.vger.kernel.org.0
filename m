Return-Path: <linux-wireless+bounces-4547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF144877AF6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501361F214B7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A41182C5;
	Mon, 11 Mar 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djvIGZRU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AE17BB2
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138541; cv=none; b=Lvq0mlB2VImHaSZ80aNKyD59Lnk1weT1fHopfPTYIPXKySZ+58wdKEKpfzBnt9FK/MqR/OPMO3fKHiddQ5UyL2ZV7aHM4oy2Unysl0pxibvSdg1YFt7OHdIs2bdleiqjUurcf6xYD9+DwqtjdO/4OUhm9CD/cSgxzwmqQSJVv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138541; c=relaxed/simple;
	bh=HN9jDELeNgPwkau1K3EXArOheSJBCAPlfkQxEiAfK/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byO16FkAruv/C2/IGfIwx0r1vfHD7lE6ITR9E+GJaC/TGkWFNphmapGPMEuX5iggJuI7rPcTa44bSerVaYgiZIyFyBDJVq4cQbdzkeCfuLelmjZmiu8+/6GaeCMp0Gj6+NM7Y4wNogAeCqI4uP/H2OSL8fAIhLvFG7ud0uf9QEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djvIGZRU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710138540; x=1741674540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HN9jDELeNgPwkau1K3EXArOheSJBCAPlfkQxEiAfK/0=;
  b=djvIGZRUT+Q8AgViIfoOx9zDGgNluGiz9zZcRw7cXS1yuSeqJ8NnSl2h
   NTKT9f5I1c4C3Y19JAAgSAPRPCzHYaSv4FGNFlWsfq8sG/p+2H0IA20q/
   vedja0mCydoqW6Vb9op5XZBAKBFd842mv79bl1OwUss6U3EA7gZkcyg7S
   EBITLqZh9y9fnDeosLShXKWQMLwmtfN1arr38TF2T/MUJAKnHn4YRLkg8
   sEinxesudMJwRXePw3HUjeGqtJKlA6uLZitHnrUHAY05r5eZmEorKAgCF
   QYowR9Eg3+kOGMs+F74uVr32azRtiGfCKO3c6t7BWL7p/UXmtHT0Yp1CU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="30226810"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="30226810"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15657737"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 23:28:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: pcie: remove duplicate PCI IDs entry
Date: Mon, 11 Mar 2024 08:28:15 +0200
Message-Id: <20240311081938.3e995954d519.I0d028993e17e26b63c0ee89d7b1714ec88f2a158@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
References: <20240311062815.4099838-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's a duplicate entry for 0x51f1, which shouldn't be present,
though the first entry will correctly be taken. Remove the second
one.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4a657036b9d6..916d417886e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -492,7 +492,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x7AF0, PCI_ANY_ID, iwl_so_trans_cfg)},
 	{IWL_PCI_DEVICE(0x51F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_imr_trans_cfg)},
-	{IWL_PCI_DEVICE(0x51F1, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x54F0, PCI_ANY_ID, iwl_so_long_latency_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7F70, PCI_ANY_ID, iwl_so_trans_cfg)},
 
-- 
2.34.1


