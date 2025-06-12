Return-Path: <linux-wireless+bounces-24055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC8AD6F64
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930787A4AA4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256422F744;
	Thu, 12 Jun 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtzAsLpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F43231825
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728960; cv=none; b=ieIihsi0HF6kScHGwDV8LKCebGYyboqZEfss47VwLJxpZGWtSTetZ6JzGwDR+RVGjAQtw3WMm1Hfc6fjlC6OKAyspSmEagK6BqPpmvRhak+uiyGdBawKNBlRIw42baCO83XNgVO1YdSi+BZg4RIwY3rfHfAqnuGX860Vm+EMVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728960; c=relaxed/simple;
	bh=TuLtIJyr02/VJFEvpI0QjQ0m+8WNPNUdtfkuk4llNBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9lfTjBAu1Ui2OWWhCzTIVY/lmLwfJzTMgJNPUscTpJ5NzkjTIZw09bd5SiDO5vscMgaIUEu2CYUPGxis101Y7ceakJ+/RVX6YMTIYApQXXz8HVuVw5kA7OnXr19cxTiuSyeLrqEore3oHJCXt+Hjpd8CO8I0ZqoRdTb4P5Dx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtzAsLpG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749728959; x=1781264959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TuLtIJyr02/VJFEvpI0QjQ0m+8WNPNUdtfkuk4llNBo=;
  b=YtzAsLpGBM/p8KHfAwjKySG0g34qtpVlkvbZoIYK2oVay5yxOqWlEb+u
   auNoeBaCs9E7asZQaZ94lYDLbMgtWs3FZRhNApl0c62BnSP4lxRHGGzzy
   44+aJsngw9ngpD8LATFzuTNWVUBX56B2Ba6ntJhLLTJUXj8UH3+XrqUwe
   slxty4ettYqj70HAYnSuMKy4XFnCgm6rSQxZF/YthdKwDz8QYpNBZzI5H
   ALU6y1rSK9xk/irtX7fk3EAkQCUvSGJ3QhguRITBD4GtoDnjKSzn/H791
   hW7EAeKB4bcd2y7QO8IiHpgow8fXSXQdXuB2ZCq9g+bzSVL4UH8Bu3X/p
   w==;
X-CSE-ConnectionGUID: 5QVkSEQaQLGIwcv5j8VeGw==
X-CSE-MsgGUID: GHEDe1FDTGmukAyXwveT6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63248323"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="63248323"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:18 -0700
X-CSE-ConnectionGUID: qUfiYYlDQ+uA7r1roEhsMw==
X-CSE-MsgGUID: Yc2MUnq/Q8qvTkeIfNxfog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147382093"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:49:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/13] wifi: iwlwifi: make FSEQ version a debug message
Date: Thu, 12 Jun 2025 14:48:47 +0300
Message-Id: <20250612144707.dce85795612b.I24807178fa7ddc7c2edfce3dc30f81bced846b35@changeid>
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

This means nothing to a normal user and really has no value
for most people, print it as a debug message instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 9504a0cb8b13..6492bc7d1680 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1276,8 +1276,8 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
-				 fseq_ver->version);
+			IWL_DEBUG_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
+				       fseq_ver->version);
 			}
 			break;
 		case IWL_UCODE_TLV_FW_NUM_STATIONS:
-- 
2.34.1


