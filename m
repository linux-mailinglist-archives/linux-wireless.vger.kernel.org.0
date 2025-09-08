Return-Path: <linux-wireless+bounces-27094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCDB48BDA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6031B26F79
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23BF30146C;
	Mon,  8 Sep 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHmZaL23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FE3019C1
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330035; cv=none; b=TWTSzNsRSd/NnHyEfic5qgf9Q+DHZgUamFWqBanowkuJYmApBEuzU6AqFhGFC5bQAS9yHzXV7nd+Tmt4Nr9n+ZsWTViRyZQDHr0Fbej3i5pf7N2J4E/LfY+Ff4u7EiUlmSRFNTs8dh9gRa2Qhp7RYyslQGQul3QrMVq6Btj37Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330035; c=relaxed/simple;
	bh=fHfitP35SFmurRTfdZLSgYVX0vLbcIblhy9fpgq9g24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1iojkclNIpZkno+oyk7TY4kKwfYHDROQWQJ4MUqGVHhoQP65ZbSNW1Q4hsfhmSLE2BZ0jaPDUT4hj50YkSW9a65uHVafGNNvwSI8S2KvPTadC9KBkUulTYM/QH1GIWm08WpkbD81q4X3RQnxflOQMvo06/eQ3i6yDvTjNky6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHmZaL23; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330034; x=1788866034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHfitP35SFmurRTfdZLSgYVX0vLbcIblhy9fpgq9g24=;
  b=fHmZaL23esv+FbWJrrQBHiXlxok7+9EpE+K2jclRjZ2pVdiK4j7HKTlY
   JHvbbgkp9apwk+SH9z4rn73dgxRqPFWo0CLuvJx0INDlc+wraGQmjOn66
   Yjy2nuTp+hBG3YN16fP5cnBI6Ly4RnWZmjjnmGEL2dWkQRgf5XNbPkkj2
   aWI8xaeFAzG+lbiuIqX7SexpMe+ZXPGwzgxnSLNSZ7Zlwhe/PUacKpEsp
   /gv1mSf5BtsHInfW8sAA1V+JkOcm+UFsftotTkQelC8f5byKZkJcU7U/o
   /hdVkEnU3dVDByNhNzqgGwb7ruE17BPQk/XyuN23ebJTX8jUWw5e7rEGz
   Q==;
X-CSE-ConnectionGUID: zTYxLFVqQ560En1G7IENmQ==
X-CSE-MsgGUID: IGrpGNx5T3KLQJPXreD+ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037923"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:53 -0700
X-CSE-ConnectionGUID: tgXSEJ3HTjSv5kJ/VyP8HQ==
X-CSE-MsgGUID: +ZoyScB6Rb+R8B8awoURsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126608"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 12/14] wifi: mac80211: Export an API to check if NAN is started
Date: Mon,  8 Sep 2025 14:13:06 +0300
Message-Id: <20250908140015.c69652f77eb6.Ie4f3d197e0706e742e3d97614fadc11b22adfbc6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

So it can be used by drivers to check if NAN Device interface
is started or not.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 6 ++++++
 net/mac80211/util.c    | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a5140ecf334b..a55085cf4ec4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7838,4 +7838,10 @@ int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
 					 int n_vifs,
 					 enum ieee80211_chanctx_switch_mode mode);
 
+/**
+ * ieee80211_vif_nan_started - Return whether a NAN vif is started
+ * @vif: the vif
+ * Return: %true iff the vif is a NAN interface and NAN is started
+ */
+bool ieee80211_vif_nan_started(struct ieee80211_vif *vif);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9eb35e3b9e52..123842b841f2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4512,3 +4512,11 @@ void ieee80211_clear_tpe(struct ieee80211_parsed_tpe *tpe)
 		       sizeof(tpe->psd_reg_client[i].power));
 	}
 }
+
+bool ieee80211_vif_nan_started(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	return vif->type == NL80211_IFTYPE_NAN && sdata->u.nan.started;
+}
+EXPORT_SYMBOL_GPL(ieee80211_vif_nan_started);
-- 
2.34.1


