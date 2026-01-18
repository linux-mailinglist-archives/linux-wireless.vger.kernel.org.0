Return-Path: <linux-wireless+bounces-30931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B11D3931D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 08:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A75AE300486B
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D7236A8B;
	Sun, 18 Jan 2026 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUtrtCW7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275215B971
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768721322; cv=none; b=P6MJIYo0c8BA3JQbltx3NkiUSpOv1Gc1JkUuwvcnlPHP+yRVqSrbrg2ISYCnzmztZG3lMXuh+t/P3hN3rbf6rr5Shq9BLB3cKTl+yI6xJgESnHgdQ1EVDg9hT5YfelJ1Mm8JHWfMr+CCT9BM3yf9Xbi6TjAoNkzzLm9AMEYeB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768721322; c=relaxed/simple;
	bh=0xgLQq09e7uc9GQoNEUoxElzjhMxFADEkIC7pxz/04k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=INmzAqtc5Mo4H946aluwN1/d9162qSc0Oqvov4SlUPcok5LYOycv0u1y/WeU4GWzi4OCpgATXNXtECpYw8TPi2Nc+7VtugFvpn0EKk3uQCWUBdKQ0YiNC2fYkBkWQH7C9FoJPjdKo3UlI1V5wjSS4y92579IepQ6iS1XsNAatfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUtrtCW7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768721320; x=1800257320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0xgLQq09e7uc9GQoNEUoxElzjhMxFADEkIC7pxz/04k=;
  b=YUtrtCW7ohyF4PvMLeReZ0hXpKREHcfNW15qBtDPbmRWEtBOFlefa2EB
   wRA/qDIZZzGwzQqwJTjaajVH1IZ6hQohFMvhhdnUQ4BmkTEWyg3+NGXlN
   GV+lrejj4OIxqIQHk3dp0MOZkuvkVjszq5s7k/Q+Y5Iq314H3ibOfebnv
   c4RNtGmn5QQkIl8bRSosCJFg0HQNDSuRHNWU4ABWtnYgPfcXf1UIoQlEu
   D8Yv8GuiA4LUUoCr5wyTGEuOEjCqqAi/BtJQSp6uy9i1fKCsBy4H7Qxa3
   e9h6xKTLQL6nB9L/uwv9z4sMgSfPl6fSE+mSHQBnOexfG9AjFOQPyqMyv
   w==;
X-CSE-ConnectionGUID: YzVLDPtCRcK3ZHpnLnAcGg==
X-CSE-MsgGUID: yIiYf4G6Re61u/oLQ+ZCow==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="92639674"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="92639674"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:28:40 -0800
X-CSE-ConnectionGUID: M7oJxvhFS4uj81c5G/sMFQ==
X-CSE-MsgGUID: d9cZx4fWRdSqOYnB9pe6+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="205494967"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:28:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi] wifi: mac80211: don't increment crypto_tx_tailroom_needed_cnt twice
Date: Sun, 18 Jan 2026 09:28:29 +0200
Message-Id: <20260118092821.4ca111fddcda.Id6e554f4b1c83760aa02d5a9e4e3080edb197aa2@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In reconfig, in case the driver asks to disconnect during the reconfig,
all the keys of the interface are marked as tainted.
Then ieee80211_reenable_keys will loop over all the interface keys, and
for each one it will
a) increment crypto_tx_tailroom_needed_cnt
b) call ieee80211_key_enable_hw_accel, which in turn will detect that
this key is tainted, so it will mark it as "not in hardware", which is
paired with crypto_tx_tailroom_needed_cnt incrementation, so we get two
incrementations for each tainted key.
Then we get a warning in ieee80211_free_keys.

To fix it, don't increment the count in ieee80211_reenable_keys for
tainted keys

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index d5da7ccea66e..04c8809173d7 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -987,7 +987,8 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 
 	if (ieee80211_sdata_running(sdata)) {
 		list_for_each_entry(key, &sdata->key_list, list) {
-			increment_tailroom_need_count(sdata);
+			if (!(key->flags & KEY_FLAG_TAINTED))
+				increment_tailroom_need_count(sdata);
 			ieee80211_key_enable_hw_accel(key);
 		}
 	}
-- 
2.34.1


