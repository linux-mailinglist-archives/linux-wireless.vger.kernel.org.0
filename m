Return-Path: <linux-wireless+bounces-4850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECE87EE10
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F4F1F23D1F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5155784;
	Mon, 18 Mar 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE7jXflu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834405576C
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780841; cv=none; b=lAfZcnuDXY5bpYKa3SPB1TfBXEnjN3mQgUnmNkVOghFNXO7fnsJnL2w/CWjeRdYT5mgv46dIXc2JPl5pNY4dVBp6lIieGWI0BZ/rc7/gkMLySklK0hKZF48NuwfgX6gFl4pce/D6wFTChO1AlRIscdWJ7lfAHdq4QcqBETaazdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780841; c=relaxed/simple;
	bh=4gXm7BW4Fbc4rYY7vho4sV9pl/TYnLmrxMwIeoQJY40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3Y7++/F8E8JwDwtogQ1S1WMypp1Ty3NhnvA0qM7G4XQS1womHx4v/fqe88Wy6dFfQyTwOIZffYVfh4615wctan0W/1F75MKp106uyZETfgxBOYAwg0HYOW5LpwQQdOUxicfX9w/LB46yN4lHIbV/iwSMde5+D6eidwB0O4Zb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE7jXflu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780840; x=1742316840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gXm7BW4Fbc4rYY7vho4sV9pl/TYnLmrxMwIeoQJY40=;
  b=TE7jXfluvCl4ousx9djxneLvPXxlk88qSIXnwvcP5HjZF/iTlsV+fefB
   mT4wrI9hnJhzfu2uPKQ/2nLMH73W94cf5tz0g8jIedaT90GP/bC3xeWax
   q3C8cskAhvlGqFLPYOkvVCOVU+QL6Z7s1KFZFYNKTEDbwJAPpiKXvYz3m
   Qc70fp+XMDBMrH2eM8GJpBtD3pDcpNFjNaIB4r/xpZg3iosxXX+17UQ+I
   846vKdyIfZwDM8AO9gzbIobtbqUGxzcs4zlb5FOMqFvUxtgp9iuh2lT5O
   u5lO5sfcbjapK2ZxRtK5YcMXl4iYigDeg0jExSlvubhjvG8tlDuj95usO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819413"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819413"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909847"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 07/15] wifi: mac80211: handle indoor AFC/LPI AP on assoc success
Date: Mon, 18 Mar 2024 18:53:23 +0200
Message-Id: <20240318184907.89c25dae34ff.Ifd8b2983f400623ac03dc032fc9a20025c9ca365@changeid>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Update power_type in bss_conf based on Indoor AFC and LPI power types
received in HE 6 GHz operation element on assoc success.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 8 +++++---
 net/mac80211/mlme.c       | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 4fd9735bb75e..7f9b829dcb1e 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2742,9 +2742,11 @@ static inline bool ieee80211_he_capa_size_ok(const u8 *data, u8 len)
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
 
-#define IEEE80211_6GHZ_CTRL_REG_LPI_AP	0
-#define IEEE80211_6GHZ_CTRL_REG_SP_AP	1
-#define IEEE80211_6GHZ_CTRL_REG_VLP_AP	2
+#define IEEE80211_6GHZ_CTRL_REG_LPI_AP		0
+#define IEEE80211_6GHZ_CTRL_REG_SP_AP		1
+#define IEEE80211_6GHZ_CTRL_REG_VLP_AP		2
+#define IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP	3
+#define IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP	4
 
 /**
  * struct ieee80211_he_6ghz_oper - HE 6 GHz operation Information field
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 30cba84e7053..a0f9fdc8b0d3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4429,9 +4429,11 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			switch (u8_get_bits(he_6ghz_oper->control,
 					    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
 			case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+			case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
 				bss_conf->power_type = IEEE80211_REG_LPI_AP;
 				break;
 			case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+			case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
 				bss_conf->power_type = IEEE80211_REG_SP_AP;
 				break;
 			case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-- 
2.34.1


