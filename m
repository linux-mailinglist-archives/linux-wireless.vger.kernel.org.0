Return-Path: <linux-wireless+bounces-26966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96581B418B8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204A91BA10FC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971A265631;
	Wed,  3 Sep 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRKWoGzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D762EACFB
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888679; cv=none; b=RUcjJktXeKCvyhhsC2Gi+9Iusg+GNMsQtSpkw2skQEFCWuhL0jdum0uxzx1CnKLCOfRjYwXKXu1C34rWUZyjl0eVVsX/uJTSVHFm1PUoKgIwJxqlkasHpVWlMR7Kfk9jlNSkiurb6+OmS3AyWb3w+VPpZqhC0vDgE0VfpnbnYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888679; c=relaxed/simple;
	bh=AgB0wQ8CrwfPKNQqOUyEa0RUQ678yNyyU4LlKwnjq/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAHbwrWUkh6N6SAxESOwnMjA2qvXt9TlC/tktoJ4b6Xa3QaWH/mvX1pMq99Tt5duIQb8ILL5ENxEDYO4QYJ9sHXshw6pwO5jQM53dAHFDHbgSBCHcWub6TM5W+JKw4/EuQtAaqn7im+mlef+kgdPiWch+HPSAlvH3KM1IKje7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRKWoGzE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756888678; x=1788424678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AgB0wQ8CrwfPKNQqOUyEa0RUQ678yNyyU4LlKwnjq/4=;
  b=ZRKWoGzEWT3NNxNNB3N80T5tHpWG39vGtpQbFlitO0MtYXjrNjmFwXLt
   tltcE0vPPtoBbdYj8lptua330cFMwswwu8QbzyURW88tatAIzXgkJWPmo
   F7ML0W1ueBZO1kR4NNCIw0aFNGZJj3fbFRbBmffomp4vxHur6SMMhUKet
   yh3OcQSvA+EJdfdVPYQ7oy7BPHJGf3JwtLSvSmutzLYtiRgd15EgHgrJf
   HJ1K89GmyyAmXwKy/+eqQYoZ9Jhxwb71MfZIiJo3VThuR/96L3iX6mAvX
   Z3kMvJzLoGBckzEgRpfkSr5Y6g0d4faPSQ1FFeyc5WZyUd0V0wPxLt12X
   Q==;
X-CSE-ConnectionGUID: RypnbjdTR5ytPZUxYs4Krw==
X-CSE-MsgGUID: A8/o+6UFQWWfsOUgI0LWGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69455674"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69455674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:37:57 -0700
X-CSE-ConnectionGUID: i8WObJfaTGePRuMZ3EbS+A==
X-CSE-MsgGUID: caOlwm2zT661jV0EIYkeww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="172340617"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:37:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: count reg connection element in the size
Date: Wed,  3 Sep 2025 11:37:28 +0300
Message-Id: <20250903113714.5889b4d8c036.I03442382e8a07f6f9836bcdac2e22ce8afbe6a21@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We currently don't count the reg connection length in the per-link
capability length. Fix it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1008eb8e9b13..353e89973d1e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2104,8 +2104,11 @@ ieee80211_link_common_elems_size(struct ieee80211_sub_if_data *sdata,
 		sizeof(struct ieee80211_he_mcs_nss_supp) +
 		IEEE80211_HE_PPE_THRES_MAX_LEN;
 
-	if (sband->band == NL80211_BAND_6GHZ)
+	if (sband->band == NL80211_BAND_6GHZ) {
 		size += 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
+		/* reg connection */
+		size += 4;
+	}
 
 	size += 2 + 1 + sizeof(struct ieee80211_eht_cap_elem) +
 		sizeof(struct ieee80211_eht_mcs_nss_supp) +
-- 
2.34.1


