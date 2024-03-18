Return-Path: <linux-wireless+bounces-4853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030587EE13
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170411F23EB2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7555C3F;
	Mon, 18 Mar 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX7rCKvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825655C0E
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780847; cv=none; b=O9WCXzt2ur5PekKwvMBc8H+g2TXeo40QlBVdYfS+nTtwjtbtQ3G1Ew1ShUrWExIykAdQpP7ioht/Hh+Pjn0KMzNjfHomHx1KckLqMQddGb/xU2RGdbECEHsksmyj5rK1iv7kyLAyfdw81fye27VzbiXT+UaFkB5GoavOz6i+ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780847; c=relaxed/simple;
	bh=9mKzi/KlUctikmemDUwh4CbXuzghf8ptUFFFioOwJ+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jj/s8rr5GOWIa9zg2UUwtD9oXsPmnJ2zFpoR9p54XKwYu1UVEw/wD9hFr19nA3UgBo1TR1msxx5ISqeMcW5orbvx+ouSKNjVWSXeODzph4XwEM0SL2WJS4/GZ5CciBVOGNNKGt2qmDHOHhYUqkj6/7SDdBSrERGehU5QdhcgAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX7rCKvZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780846; x=1742316846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9mKzi/KlUctikmemDUwh4CbXuzghf8ptUFFFioOwJ+o=;
  b=hX7rCKvZSCED0JMSerD9tH/MEzf/Fj1KlKrwrSpFrn4NpUZUi4TjT0Vi
   9RsYssQ8g+YMg/oeJo3b0Z9T9gxuQ2XidYpz1L6h1WTazspau7QVCR2ET
   e0/+KOUBuVdSEjgQAOqSZpf52lOFrGyY3brlnd3EwrUYq+TToHUHotI6p
   PzreorfxPB/1qJgM/7uUn9UDBShavAf45M4uEvY8rbbuXh5jZlTxfaCIF
   R47IZYZWkeFy40NIk0Zn1MruqRrU+O186ahDuaF5SMh1zXf7zuFfVt1e2
   mVdUlErdgvwdDtBRKVc/k05LWLnF5NPbJRKVLT0Ev+QRW2/jJ9JfWHyRL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819432"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909888"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: mac80211: parse puncturing bitmap in 6 GHz
Date: Mon, 18 Mar 2024 18:53:26 +0200
Message-Id: <20240318184907.e74b88ee45af.Id0dca4624127fa8f8e8aba1dcf9890b6327a3795@changeid>
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

In ieee80211_chandef_he_6ghz_oper(), the HE/EHT information for
the 6 GHz channel is parsed, but ieee80211_chandef_eht_oper()
calls must be paired with extracting the puncturing bitmap. Fix
this.

Fixes: b82730bf57b5 ("wifi: cfg80211/mac80211: move puncturing into chandef")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a237cbcf7b49..a5d5e05688b4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3136,6 +3136,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_local *local,
 	} else {
 		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
 					   &he_chandef);
+		he_chandef.punctured =
+			ieee80211_eht_oper_dis_subchan_bitmap(eht_oper);
 	}
 
 	if (!cfg80211_chandef_valid(&he_chandef))
-- 
2.34.1


