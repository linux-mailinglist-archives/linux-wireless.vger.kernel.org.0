Return-Path: <linux-wireless+bounces-28078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB444BEE146
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5CFF4E16CA
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E611713;
	Sun, 19 Oct 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOFDVNPd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4DA930
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864077; cv=none; b=amsorLe/ezjMVL89TVyRvlQ0fnQCiEQWLeS+9IDNbJd/iOLaoWjqkRn6TpDyip3szkBPKnDOgMg0Qb1AOK/A3yEOZ/m7F5XD+FLrO193Dqynug2yYNUQYEwWDrFS14q/BKUmTK/4LwA8HguAgpFfl0mMEHXS9reQxso5/oUvxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864077; c=relaxed/simple;
	bh=P7jSDcMFAMX7EH0Ke1boQgSVGSZRniS6xlvqnsuFjAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JtzvuFrePhCk1PTLQ3hdge+UGlpvaIDOIR1Ll6TX6HmXXxwYFPR1F74ykB/aY2eUslr2MoSSI9Ivi3gI1FrwdsW6+YttX8nzFkO2+w+9EjfcqSJsdvcTSmdkM0lxQwfyk9TB/9VT2u7XrCBfNw6F1Ubydn+GRSS6UhskILeUidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOFDVNPd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760864076; x=1792400076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P7jSDcMFAMX7EH0Ke1boQgSVGSZRniS6xlvqnsuFjAc=;
  b=OOFDVNPdSpw8NpbnKhcXghsfFU6lfr4mp3laHBm7VXPeTUwhRuHbk2A2
   BeynFU5VkOGDDjTTvkXlTCaRzR2PLsXkXoRH+ZMgMJcdp+NQxkPvU6yQ8
   BGpyMZWJl0gyAwPJa3LnKDf53yf1hmvrfWsml9RuKOAf/NyGh1hEOxIaP
   dVAafzxcZgwbTFwWgnj7+ZAq6+b1km0mCWIJIYQRlOHvFpffeKj+piJKZ
   TzsBS02PUPN/cPmvR9GfKfzHDIP2FJ4AAImNxM0AhTuF9W+d7bHiUu9oH
   VJoD7oVRQFyl1MhybatAqgfgFZcmGCJfzFFbYOxKyNeDbaw1JKk8H23yP
   Q==;
X-CSE-ConnectionGUID: qw7D0nCdSkuA8q2HIqA6RQ==
X-CSE-MsgGUID: FwA8vwA5TbC111fhVGovIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62933700"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62933700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:54:35 -0700
X-CSE-ConnectionGUID: xDlVKC7mRuCsbrX2vHIu1g==
X-CSE-MsgGUID: /SzFv89wStKmHOuyleSK+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="213703224"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:54:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless v2] wifi: mac80211: fix key tailroom accounting leak
Date: Sun, 19 Oct 2025 11:54:27 +0300
Message-Id: <20251019115358.c88eafb4083e.I69e9d4d78a756a133668c55b5570cf15a4b0e6a4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For keys added by ieee80211_gtk_rekey_add(), we assume that
they're already present in the hardware and set the flag
KEY_FLAG_UPLOADED_TO_HARDWARE. However, setting this flag
needs to be paired with decrementing the tailroom needed,
which was missed.

Fixes: f52a0b408ed1 ("wifi: mac80211: mark keys as uploaded when added by the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: add the destination tree to the subject
---
 net/mac80211/key.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index b14e9cd9713f..d5da7ccea66e 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -508,11 +508,16 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				ret = ieee80211_key_enable_hw_accel(new);
 		}
 	} else {
-		if (!new->local->wowlan)
+		if (!new->local->wowlan) {
 			ret = ieee80211_key_enable_hw_accel(new);
-		else if (link_id < 0 || !sdata->vif.active_links ||
-			 BIT(link_id) & sdata->vif.active_links)
+		} else if (link_id < 0 || !sdata->vif.active_links ||
+			 BIT(link_id) & sdata->vif.active_links) {
 			new->flags |= KEY_FLAG_UPLOADED_TO_HARDWARE;
+			if (!(new->conf.flags & (IEEE80211_KEY_FLAG_GENERATE_MMIC |
+						 IEEE80211_KEY_FLAG_PUT_MIC_SPACE |
+						 IEEE80211_KEY_FLAG_RESERVE_TAILROOM)))
+				decrease_tailroom_need_count(sdata, 1);
+		}
 	}
 
 	if (ret)
-- 
2.34.1


