Return-Path: <linux-wireless+bounces-16893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767D9FE283
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55ADA1881F2C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154A17A586;
	Mon, 30 Dec 2024 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTvaoqtv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F7187870
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534585; cv=none; b=Kiuh+RT41ymW3D3V/DGinu3JSJpmKIXzHk2uypB7fE4jrcrw8gmYZpMONbaktiSkhR9VsiDbzOUysDGA3zhdP6daH67La5X1DFv6bJkFgSF5jpTTgUmYX1PyEklWoqTNSyecLvSw3uPs9RR92aigBX7elCP+xQVGt3v1wbj1HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534585; c=relaxed/simple;
	bh=t94NXzJDDEFmZur5spBMRpCVEoi0FAUVeN+PpXiWezY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYDEW5K7atx7j7mnT4jxy6B5aHHcR8MoLLHC1pjRFVdVjqWUl5gTU1aLNEo+UNw5xpqcorGn8Evo1WeGpQZk5s1AvR5QbHeVc/uc7q+WkJcdKTuC1nhjIfrvs/JS3VhNk6HehZ8Nijy3ggGYUagywMlOvL+NZgS9eLfl+F6z/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTvaoqtv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534584; x=1767070584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t94NXzJDDEFmZur5spBMRpCVEoi0FAUVeN+PpXiWezY=;
  b=aTvaoqtvtmt5h6E4oFjhBUrD3ksOhDd9HBPTrTu79xVR8TXVRawBKY2D
   gOIhbHzRUvX6/xK2w15WJqR96hzq2QC+LLL9FHdZvWt/rdjKDChO7sQ1O
   8OGMxs1pp6A4hDlyv5HVNleW4s7BGrFTJVscAO4dVPKnhal8hFModDbMX
   vOXzx4mB1p30vAIbEgPPiVNTbOaaSIYAaHavzEOSqHNXDS/1MZd5HSxQn
   bwEFKwRLooxeWxVBJVw5lx6umDffwOcEmAlR4uoSSJPIwvEvPcne/P0hD
   pqB9c7H5E6pv3d+UysELuXI4nTwreaMSfUh6sjRnzhN5i7yticcsozqFg
   Q==;
X-CSE-ConnectionGUID: EM1c1sMsRdaWjlrO4JKZWA==
X-CSE-MsgGUID: 4MLlY2d2T2ibGv1jkmYTfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405025"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405025"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:23 -0800
X-CSE-ConnectionGUID: eYh4/g33SXOsOsdwsBEEPg==
X-CSE-MsgGUID: oGsxr9eRTFSx36b1Wu5Vow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758911"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: mac80211: fix typo in HE MCS check
Date: Mon, 30 Dec 2024 06:55:49 +0200
Message-Id: <20241230065327.743c7c1914f4.I1e5888ac6c8324d078fe91d01da31daa76d0e328@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

It printed the AP RX MCS value instead of the TX one.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 956eb265fe78..2d4beb02114a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -419,7 +419,7 @@ ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
 			sdata_info(sdata,
 				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
-				   nss, ap_rx_val, ap_rx_val, ap_op_val);
+				   nss, ap_rx_val, ap_tx_val, ap_op_val);
 			return false;
 		}
 	}
-- 
2.34.1


