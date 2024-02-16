Return-Path: <linux-wireless+bounces-3672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C1857C26
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D26B218C7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51478669;
	Fri, 16 Feb 2024 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEAxM/lY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7B77F3F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084498; cv=none; b=Bos1HJAqzLL8ILv5Goo6ZdRg9jW7Y7XBpX30YqtydUDhewousWrgNJqNlhMBCK2Ks5+1OSIcSA5tItTjxSmqoEcOZfnsHz/OGBlcB/jOkErSwwOAycZy9MlKdyHAONmH9C2uL+ZQ0hWozpsYM4pF9Ia1aA4IAyCSyAbGKYqi4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084498; c=relaxed/simple;
	bh=BjldIYSrBiB+GBQlfKKhorsMTLtAV7zoHOVeu2b+tb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol1DxROLnASOxWL9GBecpikcBlTCzy36rka60LHHzI2WnrXD/Q3G6KyGuTdZFQHiWEQDmO9NOxu305859STpLZso6ytqExgiUjQDrGolcYhorPeFdjpxzTOjvOerEZl3vYtApxazDRY2kHZHhhRtFxc9SGwVkJUhu93Zdf4f6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEAxM/lY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084497; x=1739620497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BjldIYSrBiB+GBQlfKKhorsMTLtAV7zoHOVeu2b+tb8=;
  b=OEAxM/lYHqIz9MvWOEzRUN1Z1G2Afn40ap51KjM8YNkJ80e71ks3+keW
   PmMviv3tm7MveFf/UHsytuqcFzpCXEVHXMHRthwLBlLw0bfCKU4r70yiA
   GMpzygqoj05Uj4/9uO8rV1MOkWZMj2SY6BZT+pXOAxVVvYjvNHUokBd1U
   yH9MCEGAETOTdN35KmtmIew+GhHfTda/of8aukYcg2jpj9x0hSzKu7QjB
   ymIEg26zBriV/tCf6t0ZAJjmpwvzisxSLbArOZvBzdQapgpOXv6Dk2Ipa
   cagRVpHSyqargIYnNVYWb86TgVzj3prw77W51QHsEh0mlyHc8VM8jDsH4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321925"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321925"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795601"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/7] wifi: mac80211: align ieee80211_mle_get_bss_param_ch_cnt()
Date: Fri, 16 Feb 2024 13:54:31 +0200
Message-Id: <20240216135047.583309181bc3.Ia61cb0b4fc034d5ac8fcfaf6f6fb2e115fadafe7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
References: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Align the prototype of ieee80211_mle_get_bss_param_ch_cnt()
to also take a u8 * like the other functions, and make it
return -1 when the field isn't found, so that mac80211 can
check that instead of explicitly open-coding the check.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 11 ++++++-----
 net/mac80211/mlme.c       |  9 +++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index e4322238f273..303c75459897 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4990,17 +4990,18 @@ static inline int ieee80211_mle_get_link_id(const u8 *data)
 
 /**
  * ieee80211_mle_get_bss_param_ch_cnt - returns the BSS parameter change count
- * @mle: the basic multi link element
+ * @data: pointer to the basic multi link element
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
  *
  * If the BSS parameter change count value can't be found (the presence bit
- * for it is clear), 0 will be returned.
+ * for it is clear), -1 will be returned.
  */
-static inline u8
-ieee80211_mle_get_bss_param_ch_cnt(const struct ieee80211_multi_link_elem *mle)
+static inline int
+ieee80211_mle_get_bss_param_ch_cnt(const u8 *data)
 {
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u16 control = le16_to_cpu(mle->control);
 	const u8 *common = mle->variable;
 
@@ -5008,7 +5009,7 @@ ieee80211_mle_get_bss_param_ch_cnt(const struct ieee80211_multi_link_elem *mle)
 	common += sizeof(struct ieee80211_mle_basic_common_info);
 
 	if (!(control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT))
-		return 0;
+		return -1;
 
 	if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
 		common += 1;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e1554666d706..2f13451ba003 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4202,13 +4202,14 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		 */
 		assoc_data->link[link_id].status = WLAN_STATUS_SUCCESS;
 		if (elems->ml_basic) {
-			if (!(elems->ml_basic->control &
-					cpu_to_le16(IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT))) {
+			int bss_param_ch_cnt =
+				ieee80211_mle_get_bss_param_ch_cnt((const void *)elems->ml_basic);
+
+			if (bss_param_ch_cnt < 0) {
 				ret = false;
 				goto out;
 			}
-			link->u.mgd.bss_param_ch_cnt =
-				ieee80211_mle_get_bss_param_ch_cnt(elems->ml_basic);
+			link->u.mgd.bss_param_ch_cnt = bss_param_ch_cnt;
 		}
 	} else if (elems->parse_error & IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC ||
 		   !elems->prof ||
-- 
2.34.1


