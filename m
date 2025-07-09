Return-Path: <linux-wireless+bounces-25137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646F2AFF32C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24249188EEA3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A624DD10;
	Wed,  9 Jul 2025 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giHXG/Mb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A615248F52
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093515; cv=none; b=lg817ZlTWYvl/FmJNLT56jWjmy04gfw2PZ0Vlp8c8OQ+mHmAW7pupng1IQMM7y14TSfIpW3rg+kjW5Fndk/4P3PyOxti0PeaXzpuL+g09XTfuBDLM7xJSVmo8VmHC9F3P/qfIb467qfhEZgUBk5U9zjkKfA3vKwnrx5yLGlqJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093515; c=relaxed/simple;
	bh=hnqAYHyu/P+TsgHx8FhV0MyVAf6k6TeqlcrRWm9iDQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhqc0ROH61+f7XPBT3bVk/eZccB/B+b4UsYfllEIBbyrz8nyKm+yWM/M2YTI38hBal5rKYNZ+pi9zuvNcvNjpDrpal7dqAjiC2neAv0jNt2Eke7kKwdYrE+S+TtxfYy9AktEX5+RrIOiUbOIvZbJOzxj/4Jb+qn4D+JHiP2p210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giHXG/Mb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093514; x=1783629514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hnqAYHyu/P+TsgHx8FhV0MyVAf6k6TeqlcrRWm9iDQs=;
  b=giHXG/Mb9laaxPt4w+DNkQYtkQX8Tf4C/HoXtlOM4cljExugcZXaLqco
   z0zwb6UsyoRGoG8d4zZh8Vw+CGu4SlIwsu6IcdESr3CDoCkEklwIR28Lq
   Jrw/tdDl4t5VNVf0KaH4ZwJDgKDq9AghUBbCtUlg1g64tiSJxtmDX5bcg
   vLoJpZjsYX4siRe4zXw79cDgSVLa1AJO60enZI33zNa5ADq9+nDTBr6Mq
   JefcD9anCPR+ju9DnhO6YDUS7Oy5yaNRu7CkRDkt3n/LRxWYwcVLJtTnO
   LeaHC8Afj++0ovZ0FZEoF/yUvITEPV6GQ5+L/QbRYt0s24MmTxbet4IQg
   g==;
X-CSE-ConnectionGUID: HeeyEqxZTYKIPFuv5y9NBw==
X-CSE-MsgGUID: dqCAFKc0Q6GaqfppdmBkow==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974452"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:34 -0700
X-CSE-ConnectionGUID: R3kwH4tyRkObtNrfU5Sf0A==
X-CSE-MsgGUID: pLSaPwx0SjqHzmwiEDsXeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161533106"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/11] wifi: mac80211: don't mark keys for inactive links as uploaded
Date: Wed,  9 Jul 2025 23:38:00 +0300
Message-Id: <20250709233537.655094412b0b.Iacae31af3ba2a705da0a9baea976c2f799d65dc4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

During resume, the driver can call ieee80211_add_gtk_rekey for keys that
are not programmed into the device, e.g. keys of inactive links.
Don't mark such a key as uploaded to avoid removing it later from the
driver/device.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index dcf8643a0baa..997892da8886 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -510,7 +510,8 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 	} else {
 		if (!new->local->wowlan)
 			ret = ieee80211_key_enable_hw_accel(new);
-		else
+		else if (link_id < 0 || !sdata->vif.active_links ||
+			 BIT(link_id) & sdata->vif.active_links)
 			new->flags |= KEY_FLAG_UPLOADED_TO_HARDWARE;
 	}
 
-- 
2.34.1


