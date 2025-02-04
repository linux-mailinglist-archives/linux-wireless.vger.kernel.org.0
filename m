Return-Path: <linux-wireless+bounces-18453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12045A278E1
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50C81886921
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE5216609;
	Tue,  4 Feb 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chJW5q+/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE5216E06
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691030; cv=none; b=g2WFkWoIciXGopWdDD3fWjmOKybeXOxIWHIEj1SIq8Joi6CWFQn+aP7MTJZgECvQwcBdJt2iUud3WTshbGs/MRA6Eid1x5ob1KTUVteIgDLfSFE1ztaVbjl9zmP5RsRisRpDVg/XiXmr8hSEXDowUcakhRV3LF+ji3GjLBZBhCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691030; c=relaxed/simple;
	bh=MNlP4Dk8vhDgQu2Mvx+0N+59VI6PM+9CJtlfN6vCKWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAlpXUktDzXbyrTJBClkeSF+Zmh2H1wfg2QR39dHwWB9AixEcVHMmD0rYvj96auQK/AnhxKtq6atvMXKTkhl+u8OmabR/0h+7veUUXpcLTGnTJo8brxLqoM8Wrml2n0t/8PqMBoVL+/YcnRdHog+ytJyV6J2n/t6pDRs4riIyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chJW5q+/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691029; x=1770227029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNlP4Dk8vhDgQu2Mvx+0N+59VI6PM+9CJtlfN6vCKWs=;
  b=chJW5q+/qKy+CH5upVHWYufsnvfHjka2aofouAgfLkwmqppeA5eswZZE
   P4yDVfoVM5nAhVaV+XLmqt/fWOpyOL5jcXP9HTiJ9Q8d9rjtxgtyuc9mx
   OtWrzGHOFypw+481d/cphMuuyWCX+jgqBPqnQFAa7rmaMMcoLpknYxDM0
   ZVSIDVuz8f0KXjRoCZaVropw/uef8j7MGFuzBBLj9U5ZId288tjlz7YQJ
   Q8085vXKl6IvUuJz9i8Szqy+n9VLTUysaSL1lCbAFyvwY96c+6eSqIIDm
   EbxbYAr8fFj4Byk0VEjuwd8SZifhOE8Q/YDxwtLfUXhTCkH9TdhQLEZA6
   g==;
X-CSE-ConnectionGUID: PXU1w2pRRbaFvXhKBqh/Fg==
X-CSE-MsgGUID: tbzTLiLoSOWwVogHqIYXgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585442"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:57 -0800
X-CSE-ConnectionGUID: BioZUFisRlSwGzDvWnOpPQ==
X-CSE-MsgGUID: 19Ersva0QhyIjcXWumx1cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696808"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 14/20] wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
Date: Tue,  4 Feb 2025 19:42:11 +0200
Message-Id: <20250204193721.2fc6ee9c1367.Ie6a3cdca070612a0aa4b3c6914ab9ed602d1f456@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We might not have called drv_mgd_prepare_tx(), so only call
drv_mgd_complete_tx() under the same conditions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c2bb78002a4e..d44252c0c27a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3976,7 +3976,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.34.1


