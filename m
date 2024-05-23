Return-Path: <linux-wireless+bounces-7999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC28CD005
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030EB1F2389B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0713D2AC;
	Thu, 23 May 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="drPd5hvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE413D517
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458995; cv=none; b=FKmmvvv2uUBGirQj0gkWXr7gVQXem32Ww9Vohg6Jpf6NIg8cELG+9OqALU2dJ2oPHl9UgO+XIe54CtKphOqvSBXJ8Uez+ncuegUjMMTBjO0ukz4/u1iKX6Fhmwr9NRh+mfw03JUIVAbM5BbYycaO6Kezv8wmVtQ1pHCB66Da3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458995; c=relaxed/simple;
	bh=Qq/ARgZ2wS414T44JYv22YUhyC5BBe4YEShCXpcphnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw5PmTu8kgeEk2FinG0nRcA2RAZa/e/9/b7eU5C0TVMnO8uIW5Zsa+C2nVIqDHRhBrG4ZP9XhqdXnKx1mfJCv3E8dHT6Qw/nGb41s16NoM1LkEMNbBBuBSz4Ihx2FqoHu+JQNIUUfcttqM5XPVR9O3MA+Mh6VwyGkcmCSOOwnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=drPd5hvL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LR7TBvHO2r2evYszkTOJxdd5UmNYoDhs+rNUz5WTWrk=;
	t=1716458993; x=1717668593; b=drPd5hvLIVJTSGWwpQqSGimnCq79wfEo/pWPXbNK4d+rxW2
	wutTYerVllZ6K7mDq82wOliWetznqEEf0i1amwcVUNpFh2W2sBa3WeZ0RCR7He3S0scu+NX0m5Kyd
	CrIqeQXKZ6FTzbLDRjV1iLqq3B/VA/Wg6UoNOXUC1ZXykT2D6YyQaFQWWlpnju9+YDrRZJbsraFFK
	juRP63eY47z2PlAiZralFcp+M0uiG+pcro972Irs7hhQ3apys8wY95koDFp8euxwtjspqVDfcRm+i
	VUjk2zJoh6h4Dx7Mw6g6O9Hm4U2dKHd9c/vyn1O5tqWLiorAslwW+iZe/668Hxtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OR-00000005wvn-02nx;
	Thu, 23 May 2024 12:09:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 4/8] wifi: cfg80211: move enum ieee80211_ap_reg_power to cfg80211
Date: Thu, 23 May 2024 12:09:45 +0200
Message-ID: <20240523120945.962b16c831cd.I5745962525b1b176c5b90d37b3720fc100eee406@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This really shouldn't have been in ieee80211.h, since it
doesn't directly represent the spec. Move it to cfg80211
rather than mac80211 since upcoming changes will use it
there.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 20 --------------------
 include/net/cfg80211.h    | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 456a55bd6c6b..30cef3b940eb 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2406,26 +2406,6 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 			      int mcs, bool ext_nss_bw_capable,
 			      unsigned int max_vht_nss);
 
-/**
- * enum ieee80211_ap_reg_power - regulatory power for a Access Point
- *
- * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
- * @IEEE80211_REG_LPI_AP: Indoor Access Point
- * @IEEE80211_REG_SP_AP: Standard power Access Point
- * @IEEE80211_REG_VLP_AP: Very low power Access Point
- * @IEEE80211_REG_AP_POWER_AFTER_LAST: internal
- * @IEEE80211_REG_AP_POWER_MAX: maximum value
- */
-enum ieee80211_ap_reg_power {
-	IEEE80211_REG_UNSET_AP,
-	IEEE80211_REG_LPI_AP,
-	IEEE80211_REG_SP_AP,
-	IEEE80211_REG_VLP_AP,
-	IEEE80211_REG_AP_POWER_AFTER_LAST,
-	IEEE80211_REG_AP_POWER_MAX =
-		IEEE80211_REG_AP_POWER_AFTER_LAST - 1,
-};
-
 /* 802.11ax HE MAC capabilities */
 #define IEEE80211_HE_MAC_CAP0_HTC_HE				0x01
 #define IEEE80211_HE_MAC_CAP0_TWT_REQ				0x02
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 08d49fc6a55f..0e548507fd8d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6081,6 +6081,21 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 void wiphy_delayed_work_flush(struct wiphy *wiphy,
 			      struct wiphy_delayed_work *dwork);
 
+/**
+ * enum ieee80211_ap_reg_power - regulatory power for an Access Point
+ *
+ * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
+ * @IEEE80211_REG_LPI_AP: Indoor Access Point
+ * @IEEE80211_REG_SP_AP: Standard power Access Point
+ * @IEEE80211_REG_VLP_AP: Very low power Access Point
+ */
+enum ieee80211_ap_reg_power {
+	IEEE80211_REG_UNSET_AP,
+	IEEE80211_REG_LPI_AP,
+	IEEE80211_REG_SP_AP,
+	IEEE80211_REG_VLP_AP,
+};
+
 /**
  * struct wireless_dev - wireless device state
  *
-- 
2.45.1


