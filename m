Return-Path: <linux-wireless+bounces-9211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5849490D9BB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0302832CF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D713DDD6;
	Tue, 18 Jun 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HF21RM9w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E82143C4D
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729080; cv=none; b=c9ydW1zpWYmjhbDV3toEwbVzjIe/K5XYEwXThg8BsyxUfrr92NP867e8IYWy+dOvG82XmIjKxNUecqC79a/Wp6U/0LnfU4cCS7i7dCmTkKwIkqnNle/SKW0bPbZTO6knmR8xGa/DJ7hSbQpv2ZWawX3HsLGOLAsB19UIp6KsD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729080; c=relaxed/simple;
	bh=ukVGpbVmYHzttJPq1+P2VrqPMsGENnbz/fi8BS+CMvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAS2sIDQFBxNFszCaFdLmO/EpJC0zZCDNxn8PLyXRodUlRFM6O5MFz/JW7kilbmdc6swYQzdeVq4MWc3ti93ZBQ7AKSjwjsTCTk7yecZ6vqybdLgq+b8OU65UiF53n3LFB6gpCmoWaYCGgT1yzQoEq5fMNK1Y1BIKEspbxazreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HF21RM9w; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729079; x=1750265079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukVGpbVmYHzttJPq1+P2VrqPMsGENnbz/fi8BS+CMvY=;
  b=HF21RM9wedIaMKtu8ZPz2j8wncpDNuQ4Ic+P+UdVEepMKAXVmhXO0ipi
   b5mdvtSF7yRQditR/32uUDrGQNCJ4mQpxH34hAXsnL38TRjajBKBfHyeH
   Z2X+JjbpApsURm1WLHK9lDtQih0JoQX4cQqG4pfGW18x/Oxqf/EJF8U67
   6T9yiLMKcQg8kDixcUdOMbQ+eimiM1BbsgGqpiww4TVNJNPrKY6NDBCot
   j3ldOkf4s/6Z3GB3NO7UVS7I0KPFqp42nPqx6Yie4SrZ9eaEk+gEZzpRL
   AhA52F1WX2xTEtLfWbXDejmnjWFCmS4WR3KSzGFc/0QlQNsP0KGZHprFo
   A==;
X-CSE-ConnectionGUID: YJTf8+bsSsGIbLRWoIuacQ==
X-CSE-MsgGUID: zrrdRv9ZTZGeHMPI9dqyYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257209"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257209"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:38 -0700
X-CSE-ConnectionGUID: Lu1gi4YrSmubv78lLHVPtQ==
X-CSE-MsgGUID: 61F+VQbMRkmsb2Hqc1D1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306552"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: mei: clarify iwl_mei_pldr_req() docs
Date: Tue, 18 Jun 2024 19:44:12 +0300
Message-Id: <20240618194245.ca2c55121a04.I889cd47210367ca9110411472ee696b796a37ab5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This isn't related to whether or not "fw can be loaded",
but rather requesting that ME go into a state where doing
a product reset is safe. This is related to FW load only
in the specific case of where it's used today in iwlmvm,
notably when it's known that the firmware itself will (or
at least may) do a product reset during load.

Clarify the documentation.

I was tempted to rename things too, but on the ME side it
really is also called PLDR (which is a Windows term and
may not even match the complete behaviour since doing a
full product reset from the driver also requires calling
an ACPI method first.) So keep the name aligned with ME.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index ee48b86674a6..4900de3cc0d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -456,8 +456,11 @@ void iwl_mei_device_state(bool up);
 /**
  * iwl_mei_pldr_req() - must be called before loading the fw
  *
- * Return: 0 if the PLDR flow was successful and the fw can be loaded, negative
- *	value otherwise.
+ * Requests from the ME that it releases its potential bus access to
+ * the WiFi NIC so that the device can safely undergo product reset.
+ *
+ * Return: 0 if the request was successful and the device can be
+ *	reset, a negative error value otherwise
  */
 int iwl_mei_pldr_req(void);
 
-- 
2.34.1


