Return-Path: <linux-wireless+bounces-28864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2989C51495
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD731885B2F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA62BE02C;
	Wed, 12 Nov 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOytXA2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362382F3C32
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938635; cv=none; b=gupABYjFD8zot7s21SdtwdD0fG2dYI3C6oXL0leLQEHR4gQW3zqIl7qmg7A0T8k26bEIjpU/zK591zECqOCwogLBF2M//u5ucQNKvp83otp4dUfN+jIdb8MConwg/voo9NowfP5TnTC5HDZvMfmGUsomyLWxT2hqTcmYV+ryzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938635; c=relaxed/simple;
	bh=tTaeeujxB/vIeQuGfBgI3A9tTBJzxrLxJ0ppBO+fqOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7iiHsLiwu2PSghRDZvlY3vXkiqkhDzwF3QrWzCFBKJsKhvLRYmXBPdUDWu4VN0to36/OyyH2HyCK4lCm7MqdPPxCIAs/BghoYf1WjHqRQLjuYsqZJv0eQ0cjU8wVjL5HBbkWsneTPS0WQxjLl22Z4hHHOsvQCHS+Xk9AaJiwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOytXA2n; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762938634; x=1794474634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tTaeeujxB/vIeQuGfBgI3A9tTBJzxrLxJ0ppBO+fqOA=;
  b=JOytXA2n+heb41OILOgm0ETXQFb6azWY4r06Cll52YIiSspxCF1CJAMY
   Qvbdn22Jzjb2FQ1aZi/ErmmzkPtR+2vv9SNICG/AmWaE2+DbODN3S/HtO
   naMvtnEzaWK8OitGgo6yWu+30nz7AQlNiAPwEiJNhVUnU29LMd6tnFfrQ
   rV6Exq0wUpok2gB3l6e6v0Ks18ynfVRkAdgln9FJ4OG91uzevzlfHYXUK
   qrd632r5qdYfwZ6L/u1G18yqMdS23uYVhP+kfs/LCrSQWXz9kGYo+4AaD
   o6gnQQxYZZILbXWvMY9JfUv621nBlXJWCsENsu9/EXpn4xrejV64h4x/5
   A==;
X-CSE-ConnectionGUID: 7+tbjHERRFenWmISNgK1ng==
X-CSE-MsgGUID: RtHJc/RISLWg3IGZnrDaCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="68847644"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="68847644"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 01:10:33 -0800
X-CSE-ConnectionGUID: kgt9ChqjTr+kfg//ZkmSfw==
X-CSE-MsgGUID: SWft/CvRS2CMEkqNNUfRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="219899791"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 01:10:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: Add support for 6GHz AP role not relevant AP type
Date: Wed, 12 Nov 2025 11:10:23 +0200
Message-Id: <20251112110828.856283677cc7.I36138a34847c3b4e680974bf347dde844448f3bc@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add IEEE80211_6GHZ_CTRL_REG_AP_ROLE_NOT_RELEVANT
and map it to IEEE80211_REG_LPI_AP for safe regulatory compliance
when AP role classification is not applicable.
Use LPI as safe fallback to prevent power limit violations.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211-he.h | 1 +
 include/net/cfg80211.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/ieee80211-he.h b/include/linux/ieee80211-he.h
index 904d50db5bb8..a08c446fbb04 100644
--- a/include/linux/ieee80211-he.h
+++ b/include/linux/ieee80211-he.h
@@ -548,6 +548,7 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 #define IEEE80211_6GHZ_CTRL_REG_VLP_AP			2
 #define IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP		3
 #define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD	4
+#define IEEE80211_6GHZ_CTRL_REG_AP_ROLE_NOT_RELEVANT	7
 #define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP		8
 
 /**
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 625cb2c78361..3d3ed1932262 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10148,6 +10148,7 @@ cfg80211_6ghz_power_type(u8 control, u32 client_flags)
 	switch (u8_get_bits(control, IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
 	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
+	case IEEE80211_6GHZ_CTRL_REG_AP_ROLE_NOT_RELEVANT:
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
-- 
2.34.1


