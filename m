Return-Path: <linux-wireless+bounces-7469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD18C2661
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F381B247A6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C07B171677;
	Fri, 10 May 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHpfyKoN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CE171E41
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350030; cv=none; b=KstMcy+6+/j3fgUAwI7dU0UGuxXBtc9D7k1/ssPIUWkjQlH3iOFpOHwkzkMj8HexpVHWg/IXfLXajfQraC29qdxx962qXhF1SvoHqHr6ntdBVz5joGuE+b53o21wrchd+7+gY3ymo4gbL2byBieD7vbfzKlIl4bby1L5dOUPoMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350030; c=relaxed/simple;
	bh=bSCMDDHOlbU7WYyYd9t56ZYseP7YqPy7iQDGD2pBZMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mA6cIXXL5ZLNz1qtIJID3TL6tzEfnB/zc8CDvwcCJyQND5nAXsAS84ZzFY7uifiwoEvU9QAX6jJ93VR6vxfou5gcCZNavf68OMbdrPLtP0krnO1u60BvgLZ4DvOKTUr+KCC0ArukbOfhsLwfNXl7wugQvTJ9Faekom9lohadWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHpfyKoN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350029; x=1746886029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSCMDDHOlbU7WYyYd9t56ZYseP7YqPy7iQDGD2pBZMM=;
  b=dHpfyKoNtJXL9M3pIrzT6nec6uDc0unmOSN52K/MC6BjHdm2qe2w37gE
   el8atNpEYd/z6P4tn4ZW54UVed74zRasYP99CxSi5Qwfba8SP8n5VwHjL
   UjbP3opKZlKF4XEynYooH1u/ypUaXyZbxfUQFmBK6Vf8me2V4tbv9Vr08
   175dJ3oq6GzsRtlTMmcu3+GMnHi9RsAsBcJa1BEmJWjATmHUyU+5t6Ef7
   EOKso08jHhDUtTy4LesRHXpgv7+e5NnKvH35Vsqo59v3dvuWmBwOeXAXg
   DYHK5szwdXO2QkUp4LqVZzpwSWaXQL/WXI3IyEozbQ8T9ZL9V+Zb1iYMA
   A==;
X-CSE-ConnectionGUID: VvV0Nf/9QRutUN+X6UBu/w==
X-CSE-MsgGUID: 07vnZpFsRE2kPhjH3ZPo1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125582"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125582"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:08 -0700
X-CSE-ConnectionGUID: 1DuAY+ztRbye4MX1nhxF3g==
X-CSE-MsgGUID: C6eGGUKPRkukoM4dYNOPIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101880"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/14] wifi: iwlwifi: mvm: set amsdu size to the correct link
Date: Fri, 10 May 2024 17:06:36 +0300
Message-Id: <20240510170500.4de5c1a031ca.I063bc1508e5068b32e321b0f268bc51dba0c0747@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The exising code sets the max AMSDU size to the deflink, set it to the
given link instead.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 884fd56e7426..031b5e70d181 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -653,7 +653,7 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	 * since TLC offload works with one mode we can assume
 	 * that only vht/ht is used and also set it as station max amsdu
 	 */
-	sta->deflink.agg.max_amsdu_len = max_amsdu_len;
+	link_sta->agg.max_amsdu_len = max_amsdu_len;
 
 	cfg_cmd.max_tx_op = cpu_to_le16(mvmvif->max_tx_op);
 
-- 
2.34.1


