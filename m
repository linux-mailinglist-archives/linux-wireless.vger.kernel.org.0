Return-Path: <linux-wireless+bounces-16960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0129FF2DB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B410F161AE2
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555ACDF60;
	Wed,  1 Jan 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPJXdUJp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E5F9F8
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707969; cv=none; b=CUomsDysDGz9a7fr686Wz3sIepFqKka9SoohLfnmoU5BNXQQUlZyy64/pIwP0JYnoNcdr2JawafHgbeGHc3pqYDcnE5WXPfu94vPCxjxbge7Q640qSls4NKbHAHYWlILUtlp5H61R+ssyo3DgbCKqP8Gh3lzEmkWvVXZVIPsFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707969; c=relaxed/simple;
	bh=t94NXzJDDEFmZur5spBMRpCVEoi0FAUVeN+PpXiWezY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auoA5Rrx94Omnvv4oeNHioix0AB32bVb5A6j5GxWxh5xyMeEC9JGrDMjDGp5OoMQeQkuRxdbTDKWGRVmxzyWN0ufTi4xiu8QmnXmNyg9lvIFdkgd1rdCQAK63wV/H0L3+kipMA3wyctH4VRbjIzct9+mcWF6lu+QUvNO5002kJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPJXdUJp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707968; x=1767243968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t94NXzJDDEFmZur5spBMRpCVEoi0FAUVeN+PpXiWezY=;
  b=MPJXdUJpOeMh9c9V+ryn2ARsnHnyAPqWave4I0pMDckr0beIcxAL6kwJ
   m/hQF0BSUk2oYRXlFtRueBgVWV2r4mC3kXcZ80YKimCTHhbqSS9CmAzEp
   yKKvFK0iK2GoYF6PX6BmZvu7IZXEtVhm62w6HnQIQihFtmmhBwb7D+pxf
   3XBV38Bp4/R+DWLBMasL446LecNV7NcR4nZnD0OS4s85wPN/buvJu/C0I
   MOBvQCGlKkYhIxL5I+WbZjAml+wxilV/sCeZOWBs9tLeghspBPHhB7KXd
   M60wpDR3/8z7SQ1j+VXJwQubZqIgYKutvC/w8Qm/iTsmfQHaGSDZSGUFS
   w==;
X-CSE-ConnectionGUID: YbCoXnyvTOyTKo3pE8abJA==
X-CSE-MsgGUID: ZzI8tZZeTn64pww3ebHaUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194424"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194424"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:08 -0800
X-CSE-ConnectionGUID: E6CAzMk5QxmUfPqTD7f1zw==
X-CSE-MsgGUID: aCcSeZyLTmSF4euGpwjNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618916"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/19] wifi: mac80211: fix typo in HE MCS check
Date: Wed,  1 Jan 2025 07:05:30 +0200
Message-Id: <20250101070249.743c7c1914f4.I1e5888ac6c8324d078fe91d01da31daa76d0e328@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


