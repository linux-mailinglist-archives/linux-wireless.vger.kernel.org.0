Return-Path: <linux-wireless+bounces-2733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B011C841349
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE161F21AE2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324624CB24;
	Mon, 29 Jan 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOhI/jv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245196F097
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556172; cv=none; b=Fm8A/rPfD+pZo/F1id2q0554NJTSOXOOatxmpKaPD2R1i3eN9rAmYPOCoccXmjE0UrNtChWTBXwTBcx5EDnuSIiLcgEoUiTsyfYs9ypvIB4MZx0qVBwtHEUW7BVQptQpG7txDNSDGg38ExfBIQtA/77ztqGWjQhCVZtC16nbpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556172; c=relaxed/simple;
	bh=bvG3FsJilsj3MvwF97Snbcu91O9tfBlRJDPv5wzY5Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+doPWdtK+fPQIaWDkNASj/TOO4KY5nO1E5UQ1ywNgVbLP2NOUF0ltnJ/58kf044lpsTcXCo/UDV0G0coMrMgrdN0ECRA045ctiqV7PjKPRs3SNUItGLuOBqhseqZVgHuUqbxvd6dKCEQvFBfqCBQnMNfPoPO5pF+7Cbw93hI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOhI/jv2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556171; x=1738092171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvG3FsJilsj3MvwF97Snbcu91O9tfBlRJDPv5wzY5Yg=;
  b=mOhI/jv278zRxTNNwD0jtRzWmCl3muqhQErzw8GYuUSsKw1tzZOYCbKE
   LxT/2UdzxypEgSaC4vM4XRYTbwkWzWoqEbGHoIfUboY8AMY5PLIEDm7Aq
   u7S3VZujMcJlYLw4j2EH+xrIODgq105tIJRHJhNXoZbzLFg1fOg7Yuik1
   CVLDlP3q4Ups0bmoc0gyJaHNvgoQ7NqxseOf6SoczZ7S+45PT7s2nInOa
   hTyV6QpAR5DDTIWZII7K4F1cVNagQ4BoVdfkZpWtjACdnh+8LCiuAmXHU
   bZ0MTFcXdXpShblU5EqbyonxDz6s0SRRY0WXDNUps18QyGZSYmKDFJ6Ko
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943056"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943056"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459154"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: pcie: Add the PCI device id for new hardware
Date: Mon, 29 Jan 2024 21:22:00 +0200
Message-Id: <20240129211905.fde32107e0a3.I597cff4f340e4bed12b7568a0ad504bd4b2c1cf8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add the support for a new PCI device id.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index c80b02503b41..bbc8dc390bdc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -502,6 +502,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
-- 
2.34.1


