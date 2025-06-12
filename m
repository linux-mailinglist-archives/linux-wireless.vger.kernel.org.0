Return-Path: <linux-wireless+bounces-24056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E6DAD6F66
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273721778D8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2923BCF5;
	Thu, 12 Jun 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftyMGAgY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FA239562
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728960; cv=none; b=VpIxI2KtGQudysuOl8VWG8iLdAEnXyr3a4KUGqa67JfEBLB4ijEdtxk8mu6WwDUdCMTsqTuD0xxX25pWjYZiiRicrtirRl3NgFrQI3rrUi7Og7BUGoLqOXAQpG6jRWJaAeVdMAtFSEkJzYtSxloPsjjIqhahoK80qYtJ9g6xoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728960; c=relaxed/simple;
	bh=BANYJwEArmKp6Zf/0v7rJtpYLiS1lJ5vDe5WFrDUJxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gowJdS5eSgGJtBQ8QWbcpvmedFY5WXmm6rCq6yFhceqwZPF+Or09KkSXG8f5yWeny0Pstd3ttSUMjDbuxhVV2xUK11jBxKdXqV2pBaZns0lSK8k3R1oyfQgD1avi3ichBUMIAlMOQM28+GzNXZORwuLwxotI7D+YYyBmRRvMQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftyMGAgY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728960; x=1781264960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BANYJwEArmKp6Zf/0v7rJtpYLiS1lJ5vDe5WFrDUJxo=;
  b=ftyMGAgY/aJVkJOpxeCedvpsODiVnPUYkuCjYG0v3ZMZVDeYPQ/wKahO
   PiWpFo1dk3I/jRD1qcHy/1ZOoxRLS/KNBx2/5zfTgH3skHEfhw0OVP5Uv
   N2loHzrAFrYO20HnoneEhb3pGEYsBoAIHgKueleJg1JzGRrue0BE7Icl6
   hBrhtl9gIdaTPQqu0lXkq+FeZxhCgv3sccd3IdJnO5adgEr+BdaQlMksJ
   UR5D1kEaDpurw+thnDJD2XypOH4uOlrCIz2o0XABIQd1lGR2jEfeGyXiN
   F5D1Gv2BKr8G3EIksRJlJlYgo5NXUHQxc2YUDjVU7oLFvxPONEcjrn7Fa
   w==;
X-CSE-ConnectionGUID: T6J+gWZfRtaOQgaxRQ6ACQ==
X-CSE-MsgGUID: IK/qCeGORgGpXMfmkCx0+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248325"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248325"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:20 -0700
X-CSE-ConnectionGUID: x+XoHHK4ReOuEDRzHKCCEw==
X-CSE-MsgGUID: Mvculz5XQSWZS68TcxIn1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382100"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/13] wifi: iwlwifi: add HE 1024QAM for <242-tone RU for PE
Date: Thu, 12 Jun 2025 14:48:48 +0300
Message-Id: <20250612144708.5716b631c59a.If81456c73a2d5834c29cbf410f7e642184c32b82@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

For the new PE RF, this should also be supported.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index c5c80f72696f..1e4162f1bb44 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1047,6 +1047,7 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	case IWL_CFG_RF_TYPE_GF:
 	case IWL_CFG_RF_TYPE_FM:
 	case IWL_CFG_RF_TYPE_WH:
+	case IWL_CFG_RF_TYPE_PE:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[9] |=
 			IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 		if (!is_ap)
-- 
2.34.1


