Return-Path: <linux-wireless+bounces-28093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C450BEFC3E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37C254EDE2E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42632E2DFB;
	Mon, 20 Oct 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMfwFU3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F92E0B69
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947077; cv=none; b=qCSF8POb/iuAxhHTL2zVtXtvWXUFEzkizNFcrQGwtKJ7rWSUqMEGP7c1Dg73798ZmChGKajtHu+6r3gaR6ebdzOpnF3SMXfMqF/8P/sEJyEZ2clOP7tiFiQDlzQd8xxnglZHCav5uM86dECcOtOPxl/rIFMVnHP8RFU/qAbevyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947077; c=relaxed/simple;
	bh=0C/qpsnQa528Gx2RPfg5LwAFLrZEVXKQAgEhMrDQ8ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbW6JG5rtuAiTSfEHJe/g6osnnl6HtXKpyXt6pScv53wEmdiG2944FKjzypmTZJCbivskQNCW/tP7n08+lj/wGcmkrNrtPzhTZ0y6ifFXZpfub9m7KZZsfmiQhcS0gI8D4r2LPpeWadZbDQLnsqDLS+HUdiLyU23nEHkHxQvNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMfwFU3Q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760947076; x=1792483076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0C/qpsnQa528Gx2RPfg5LwAFLrZEVXKQAgEhMrDQ8ZE=;
  b=mMfwFU3QqvXftEk0v8719PJ4cjH5onSWz3Y0t4ci7HhNFq5MXAEblM1S
   hbi+hEdwy2Ejb3LpKIOfsRLHtdMOZ4CmPg1NRSXnELqx32aHPp6BhilTx
   J2GWhBNcWZY0abI9IYS/ja/Zlc8o/r4VrtHbZ+UgLUwCrq4FQ8buMgT6i
   NUTL/8OB2QxHOD+J+k3ai74PWWWelocWcZKzue7yeWXAZu3DBQ1VQP7pD
   jk0pj+o6QfPkKZPSSvM+K23B4tlp+s9BfQI/GR+j2TjonjErpHqVssfAB
   yBB3HfbgMV56br13+7SsVjP9XymZpaY2n5lbhFQ/5e2izIcP9MAsYPyh+
   Q==;
X-CSE-ConnectionGUID: OifCfyHgRfm65JNzgnZmPQ==
X-CSE-MsgGUID: QVYdDByBSimWU6pjIZ0Dmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62968181"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="62968181"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 00:57:55 -0700
X-CSE-ConnectionGUID: 5lbYBYjES9uFuX2D7J25IA==
X-CSE-MsgGUID: f6nBpHy2RUazSnO11Wd+pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="214234432"
Received: from egrumbac-mobl6.jer.intel.com ([10.13.65.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 00:57:55 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: nl80211: call kfree without a NULL check
Date: Mon, 20 Oct 2025 10:57:45 +0300
Message-ID: <20251020075745.44168-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity is unhappy because we may leak old_radio_rts_threshold. Since
this pointer is only valid in the context of the function and kfree is
NULL pointer safe, don't check and just call kfree.
Note that somehow, we were checking old_rts_threshold to free
old_radio_rts_threshold which is a bit odd.

Fixes: 264637941cf4 ("wifi: cfg80211: Add Support to Set RTS Threshold for each Radio")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 net/wireless/nl80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 346dfd2bd987..03d07b54359a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4136,8 +4136,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.txq_quantum = old_txq_quantum;
 		}
 
-		if (old_rts_threshold)
-			kfree(old_radio_rts_threshold);
+		kfree(old_radio_rts_threshold);
 		return result;
 	}
 
-- 
2.51.0


