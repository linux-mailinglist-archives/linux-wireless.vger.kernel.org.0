Return-Path: <linux-wireless+bounces-4848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19687EE0E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8FA1F23B97
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DC55775;
	Mon, 18 Mar 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/rPQ2JQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E75576C
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780836; cv=none; b=kbNduYc+IsxOdmjzm7D0CfM2oBlFs35NpHIQIfTR0MeAcduo+WtEdEyXnq69dR8iVK0JFGuHpm39fcqHBTajXdJVyKH+v9foS+0d25HzGFlnktEF32qtHFrbkYV6c5BoOSrihCY6PTBcTE4QCJML3xEH8zqmr00DypmUVBiuvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780836; c=relaxed/simple;
	bh=L03e1PnEyC7If33Ek/e3BuquoNhxptWVv1cs2SQj260=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APYuEZPJsick/se0aO/RkEiTyxyn9iBOP1qj//x7X/RdG8PUNzw1GXloug2NdJgbkxQqi0cf7x900dH7tUqCInt5jbPA+rd3dYxhH//uAlkIXByGsqSRZUcodQlRgt8dEEfqlYmmmFHOLDXlhLfX+Em1t/Qzg8IPRn/ZTErVnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/rPQ2JQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780835; x=1742316835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L03e1PnEyC7If33Ek/e3BuquoNhxptWVv1cs2SQj260=;
  b=T/rPQ2JQqzOvhHtP/ccxR0Kh6eDzlsnWgKkbGj5gQy48vSo0jkD0at2O
   Hxct+bWtG343rlIpU9J+CBubLTrfgZYrzqTHFM3WzOilswrFkZbr1iF4r
   TpRWjUyGr+m4UOX0ApC7SlznuesAYbOTrHnke2/CIXaxfCCWWeCMuC8ZD
   bl+GU6FPIx2XyywJbRbQbV8gYxF1PG503/MQw6puSSzcOL7wKf/Zcx4oN
   8dvI2s5qkMBBj7eRbynNx7MDAeUFmsWCudBhZ1mOzHnoTLW+3oOlWb2XJ
   1JM87ZIDc2hb6qzd05Ieqrf7DkmyMhpfo1HOLsX2XwpYx42ll1kTINnKr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819395"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819395"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909816"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 05/15] wifi: mac80211: fix BSS_CHANGED_MLD_TTLM description
Date: Mon, 18 Mar 2024 18:53:21 +0200
Message-Id: <20240318184907.52b893a70758.I2dcb322b389441f33605fb952450cc2724eb9efd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

BSS_CHANGED_MLD_TTLM purpose is to let the driver know that
negotiated TTLM was updated and as a result MLD suspended links
status was change.
Fix the description to better reflect it.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 47fa73a62f8a..757ec33882c2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -361,7 +361,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
  *	status changed.
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
- * @BSS_CHANGED_MLD_TTLM: TID to link mapping was changed
+ * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
-- 
2.34.1


