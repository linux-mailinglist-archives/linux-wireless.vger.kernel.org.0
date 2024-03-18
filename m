Return-Path: <linux-wireless+bounces-4844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AC87EE0A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B501F2383A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A254BC5;
	Mon, 18 Mar 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxdi2Mw6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C754BCB
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780826; cv=none; b=OGbj/JE0gro6/fnh3iRKJmTaIkp94Zfsbno4v4MdqRATJ8nmqxgzvog+8lkL0z+JyIOmGZlfnUKQpWYInONU2P2XaZYcomDI73O7HS2ZsIrzm08mkgMcsaLvDDqa7w0M8JM6j0ARCSK92uQMEWaxRMCN5p+LiH0eblKBPCZykkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780826; c=relaxed/simple;
	bh=LC7KSzX8Asy1IJyThL538uB12yz1fIdl+eE35n42N6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWE1DTySeHwqmaF/YRj59CCc6TAajCsnFR+gCkzi5/1JaHw8D4F4nSmd7UpenrO40v0wYf18ysY6C+ghu+96WyXIKlHVoVCEwEwYv7BYStiubVRt0jjJA6iAA4l0uIY0rRA14Z1Lf1Cu0DdXtndoMllwYuWhu3ulCctaevBL4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxdi2Mw6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780825; x=1742316825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LC7KSzX8Asy1IJyThL538uB12yz1fIdl+eE35n42N6U=;
  b=kxdi2Mw6gjswgR6dJ4JyWQ8T2Dy+RbNP6jiRjKL1e1h4I9Ul4UVWaIox
   zHDOh2kAs1VaffB8GClnLnZZweB+AEAAFwNnxo+BCJvN28DiH1AmRs/5F
   PLiysEsfbVxJzJuo0NbbvhL1JlnShN2fRheUZt455eQ7sTzSBCxG677JJ
   eAdEsSQ8SWcJ1OIS2jaf+wMCmx8SYF9FAtIuWBLRIH0spB3JnobI21Op8
   71UhTXwRDPyQ03GobnWMlen/C6rqu19jIbJVL7j+peXr19GFrDb4S8EQZ
   M6y6WBOzGH/e0w0F4+nzrI87tx1nc28jxb0uBVhv87MflJv8zC/qZUWh3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819368"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819368"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909729"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: ieee80211: check for NULL in ieee80211_mle_size_ok()
Date: Mon, 18 Mar 2024 18:53:17 +0200
Message-Id: <20240318184907.4d983653cb8d.Ic3ea99b60c61ac2f7d38cb9fd202a03c97a05601@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

For simplicity, we may want to pass a NULL element, and
while we should then pass also a zero length, just be a
bit more careful here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 3385a2cc5b09..a99f048404b8 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5166,7 +5166,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	bool check_common_len = false;
 	u16 control;
 
-	if (len < fixed)
+	if (!data || len < fixed)
 		return false;
 
 	control = le16_to_cpu(mle->control);
-- 
2.34.1


