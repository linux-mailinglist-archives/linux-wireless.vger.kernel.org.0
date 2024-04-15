Return-Path: <linux-wireless+bounces-6314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA54F8A4AF0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182391C216E9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3944AEFB;
	Mon, 15 Apr 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKG/eAhX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40884AECE
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171307; cv=none; b=qPYlfMKszjofyzrV1bZnJE5R3ZTTBoyVZ9G4o3RNRtrysA3kqQDtwtWnxAI2+bMqA/6o2fqdY+BHeUeZJqnUb5CaAQHF8jqT8QmO9qZaOFEiQHg9ZwrL2U6JNB7QvamHiIgIeVo7LAW8Q/SCy1PF/js6Mr4PE25a6lPeJgYWhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171307; c=relaxed/simple;
	bh=iRjYeiucWNREuXQHihtbDpOzb0jWMKdpAWvZr2ByUJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSSn2Q6gHlzQ6wyZAhvSZmSb8O1PS8JkFeuSpTh1j0B5rqNOhVnNTtA4h51iNV+YMsVbd+RI6LnpGqxx+NfmiU7MeYKLlr8ZU6d0Na1LRvOg+WM+TI/r6ZDy8pQh9/w0kCBE2Zb9lBk8widakaPE6mdkQ8G2YB31nHL9l5Y4iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKG/eAhX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713171306; x=1744707306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iRjYeiucWNREuXQHihtbDpOzb0jWMKdpAWvZr2ByUJs=;
  b=UKG/eAhXtn/yxXWvhKzUiJ2G6j1g+nytxHxgM3gkkPguXzrXqpMv/YQ6
   pryIjylvgwTTn2no1imteJzy+xPJxppE2Rorm3IMhmIxZBqg80WJIQPtB
   D+kK1ecR7u8QcoBujCnUkd8iOuyL0O+cWmEdivd17lodTdUjuJUlBPSe8
   IWuZKC+6rlieKdlPNd7VyZ7g0C93Sdu1CY5a8X+5+hJMl572tBLBmu9qa
   LqNcv9CwzT6PUiZzQ1fCVkCurvMKele0gXY8JWmgl5xVQVtQdnOHVciX8
   KiE5rJYmEnOhiU2vsmsogH+rai5SsI8o/oD+h54nPz5xMkeGXT43FnDJ2
   w==;
X-CSE-ConnectionGUID: nSX7bebiTKyW1yDm9ORlhQ==
X-CSE-MsgGUID: zgKlGSaWSNOAvO1DqSN3GA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9100595"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9100595"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:06 -0700
X-CSE-ConnectionGUID: BSLeKJBCQuG8YvOa1vGxzw==
X-CSE-MsgGUID: Jjc/2D7SQUuI64YN278Zyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21768020"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:55:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: add a device ID for BZ-W
Date: Mon, 15 Apr 2024 11:54:39 +0300
Message-Id: <20240415114847.c387957560ea.I9229336936faa0ed346af469e9c77c7d6e5a2541@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
References: <20240415085444.3840884-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cd2183ccbdbd..fed2754be680 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -505,6 +505,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_trans_cfg)},
 
 /* Sc devices */
 	{IWL_PCI_DEVICE(0xE440, PCI_ANY_ID, iwl_sc_trans_cfg)},
-- 
2.34.1


