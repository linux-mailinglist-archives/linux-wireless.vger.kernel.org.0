Return-Path: <linux-wireless+bounces-9914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E217592579D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87601B25409
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B65C143743;
	Wed,  3 Jul 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXeXZsDg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFA14372E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000776; cv=none; b=jLb1eYUzLcC+D/HSEdMKsclqCW4fkEtPczD3FSEJblqY4xg4NtbKRmvDfowzFqmNGo8+CN+Qe70vtWj0iALu3hQqW/ivYd+q+R8SlkfXH0DsquT0UIOafKJQyPcakwoaWH5hmGXPf45tGL3Retu77ENvOseFakXye2Hn7hY5TxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000776; c=relaxed/simple;
	bh=yh2cII61xmtL8aJrOTv8ttbxnCoCDzgL0AirNeYcuI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOXjTpAClwWeRu6Xyzdx/KAo9Kh08Btk3z68+1DyNc9LDiU3VZCqMZHLDYQkKQoDrCcKpvf8utXFa36KwMjIYemFKgaF2o7jhUxlbWWZFeBz5hjznFQWzj7dRUuYHuC2sHtnQ/8i9FC0BSYoycwf0tMwql50BqNd1hr7fzc5SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXeXZsDg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000775; x=1751536775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yh2cII61xmtL8aJrOTv8ttbxnCoCDzgL0AirNeYcuI4=;
  b=nXeXZsDgdZvndAJyJAwbENjobbrHVJP0nrJPGvZXYLRNEApzvM+JOw/j
   Lysjh/qaQP68Ksf3MENj+/SyMmCb5MKK8x+Oa1rbaJaEL9RtyS2pwkJhQ
   Jy1DiPbNQ/7cZ5rzZJkAV08Qqn+b9a/3mdBB8RyafZG6rdCgjSXx6Bcuf
   VUhhk10coETUNYCR7jm6BL98Y+RV9EN0MDviFlcehbj/tnucdvc7kUNDR
   k7IdKDveaCaDmoPjjuxQY2vO2ial43xVlMMbVF8xC+m2gvLu28B1B1//e
   Q3K8eHjoyeV4KErHyD+MAc+HH9atqAD+eoXFA65Rq9+m2qDc0oeoHZwly
   g==;
X-CSE-ConnectionGUID: 5W5a0Ln+ST22tgzxfw5zag==
X-CSE-MsgGUID: 8bk+2lSITvi1JrFK8wxpBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837557"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:34 -0700
X-CSE-ConnectionGUID: eBaLlnTaTuure/y8VVTQqg==
X-CSE-MsgGUID: sADRezUzRnmW2E8sxEvcTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987843"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/18] wifi: iwlwifi: fw: api: add puncturing to PHY context docs
Date: Wed,  3 Jul 2024 12:59:01 +0300
Message-Id: <20240703125541.8ba6536ea36b.I181d8da205a14f4fcbf1d8cc6011dcf194a1638a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Document the puncture_mask field in the PHY context.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index f192e02e4ba8..4d8a12799c4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -144,6 +144,7 @@ struct iwl_phy_context_cmd_v1 {
  * @rxchain_info: ???
  * @sbb_bandwidth: 0 disabled, 1 - 40Mhz ... 4 - 320MHz
  * @sbb_ctrl_channel_loc: location of the control channel
+ * @puncture_mask: bitmap of punctured subchannels
  * @dsp_cfg_flags: set to 0
  * @reserved: reserved to align to 64 bit
  */
-- 
2.34.1


