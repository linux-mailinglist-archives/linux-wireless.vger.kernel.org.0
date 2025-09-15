Return-Path: <linux-wireless+bounces-27295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE14B57186
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63240161DCF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03E199949;
	Mon, 15 Sep 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MANXeAah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7972C181
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921484; cv=none; b=gsQxoONy4yDmIE4XhQifcmoM7mfHhsRDH8+On93wVYIcMeh4decgvx4aUCkBhzB9W8g+s+MH4k0VzEdWl9Hxg44qg7I2AEZRKIuRY3U2nkXYSWlDCvj5O/iCSM7Ht9LxdKQ9yxcGz+AhJkEXczLeVTp9v3DiHCCbgWjSjvuQkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921484; c=relaxed/simple;
	bh=tliLl8Yj8qZbSqqAlik/5MffKkDtMhxmH9iigdtxRBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhyjxlroDw/Z3rcXR2fgg1Og0J/ht1CZM0bZ/qeaMufyocI01gquZOtAblZ5Bi/ZHvDZJasy8Dwff+Hs2EIDP+rBGBgv4tU6Z3EWodWz5QxBS8F7/XjRkdFIsbyllQ+hVFlLEddNQRNkPXKAUwu76YOsTkL60cXWbeYc4PWedp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MANXeAah; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757921483; x=1789457483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tliLl8Yj8qZbSqqAlik/5MffKkDtMhxmH9iigdtxRBc=;
  b=MANXeAahdZ+RrzedmNd+uXL7xgqPrNOiiQD7XFuheaIMEMTF7Go+U/RU
   FWajB0U2mbfshe/Wj2Kn9ejz9wBJd1FzHc60YfcP2YMcYUMw9tRRhobME
   FdlnTzj7dvEtG+04IkMkGZYoh4mA3eIMH27cGAiKPQ/Cal0yExtZ8O3RB
   cWVjp2o01rDejHfYf0iGfLD1VhFIxJDGQmJ18HsRbwmNL8al9AqCjbw+S
   wK4yJg3xjxR3eeJf4GevLpZlkUOfOq3bIoLxdTqr3pqiWquw0yxk2U4H5
   lXvTVlw6bf/xhX8UiQ0KX0bSftAirW6atle5tQ07pUxzWL3wBr22UW1oj
   Q==;
X-CSE-ConnectionGUID: HDoAlepYSeG3R2sh+mSdEA==
X-CSE-MsgGUID: GNxSamjYTXO8k+y9tytoYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="70848967"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="70848967"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 00:31:21 -0700
X-CSE-ConnectionGUID: beOxyWSSRsGFD2mtG7eapg==
X-CSE-MsgGUID: Ydz5YDQIQL2yYbMbSEt/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174474670"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 00:31:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	David Wang <00107082@163.com>
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: pcie: fix byte count table for some devices
Date: Mon, 15 Sep 2025 10:30:52 +0300
Message-Id: <20250915102743.777aaafbcc6c.I84404edfdfbf400501f6fb06def5b86c501da198@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In my previous fix for this condition, I erroneously listed 9000
instead of 7000 family, when 7000/8000 were already using iwlmvm.
Thus the condition ended up wrong, causing the issue I had fixed
for older devices to suddenly appear on 7000/8000 family devices.
Correct the condition accordingly.

Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/r/20250909165811.10729-1-00107082@163.com/
Fixes: 586e3cb33ba6 ("wifi: iwlwifi: fix byte count table for old devices")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index d912e709a92c..bb03dad4a300 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -2092,7 +2092,7 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_7000 &&
 	    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
-- 
2.34.1


