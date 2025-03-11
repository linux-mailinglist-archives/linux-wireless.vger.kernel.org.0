Return-Path: <linux-wireless+bounces-20171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91209A5BEE8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 12:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CC01886E8F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB3254AEE;
	Tue, 11 Mar 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XPYcaLPE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA342505AF
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692350; cv=none; b=JrtrPVZBPFhURMmAqraqsnblwpUxSJEeOOBmVnvciYdvirooglpVzX2yJbNWlTKP0vZepneg5pjLnFykpd22VdqeM4mfFUr1cJ4BhvfaQBnF/CW46sR7akc0FbZKH8MPNkcam5KiiML66jl0iBNkY4plov5B6aBDGz3gK/YG/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692350; c=relaxed/simple;
	bh=qmV/51nMzil95N7jO2Vss5glDfmbd2sGisxzrHlUOeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFv0PrKFcrUS15mwfC4WIeNd9dFC7eENsoANhkQo5+k7rkPBgencc/sg9lRp3elwJM/PV/znJqAyNuOMRvms/RjrrR+wCjEog5mFL+jeXns31Ah44KGs63BlN2hmsOMwK+DPLfK4qjsaUj8LU327sD6/42Zv61nNfdWBxsA2Gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XPYcaLPE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=DG8hw/8mcxksQnUVaY4542MmKEpS5h2wXccKasru3JM=; t=1741692349; x=1742901949; 
	b=XPYcaLPEWAH2MJTDtqAQdIqmPR6mUkeFabCcglPMkOmH5ZuyZF+qsZ3PeUyWC9EpEYAZ/L3nHv+
	bzr/BgWkBND5pq2ZgSb+iekrynrgJoAfv6MMgrkm/1Xj+zteywwmOUXUlvUc+QdLUziiIvs8ziLsq
	FbPzdTRCf8nVI++ljSjjMGu3gnrnYqglvfyjPwQ07Uj/4vC26A+FHT57LBoDDscUWpqnT74Xp7WJr
	q+YNg3XuuBaH/HOwnVlds7XldMQi/JSeYe6B+xLeWc65i7Da27EYYQK4vqnCwpGkBfcCpG0eA1/8R
	8VjrHQqBQwsd6tlfFIQYefTPpZ72rim2p1ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trxk1-00000007pEA-4825;
	Tue, 11 Mar 2025 12:25:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: expose cfg80211_chandef_get_width()
Date: Tue, 11 Mar 2025 12:25:34 +0100
Message-ID: <20250311122534.c5c3b4af9a74.Ib25cf60f634dc359961182113214e5cdc3504e9c@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This can be just a trivial inline, to simplify some code.
Expose it, and also use it in util.c where it wasn't
previously available.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/chan.c    |  5 -----
 net/wireless/util.c    |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 73f0e75cc814..efbd79c67be2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1008,6 +1008,17 @@ cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
  */
 int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
 
+/**
+ * cfg80211_chandef_get_width - return chandef width in MHz
+ * @c: chandef to return bandwidth for
+ * Return: channel width in MHz for the given chandef; note that it returns
+ *	80 for 80+80 configurations
+ */
+static inline int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
+{
+	return nl80211_chan_width_to_mhz(c->width);
+}
+
 /**
  * cfg80211_chandef_valid - check if a channel definition is valid
  * @chandef: the channel definition to check
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 4cdb74a3f38c..193734b7f9dc 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -55,11 +55,6 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 }
 EXPORT_SYMBOL(cfg80211_chandef_create);
 
-static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
-{
-	return nl80211_chan_width_to_mhz(c->width);
-}
-
 static u32 cfg80211_get_start_freq(const struct cfg80211_chan_def *chandef,
 				   u32 cf)
 {
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 60157943d351..ed868c0f7ca8 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2023, 2025 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -2908,7 +2908,7 @@ bool cfg80211_radio_chandef_valid(const struct wiphy_radio *radio,
 	u32 freq, width;
 
 	freq = ieee80211_chandef_to_khz(chandef);
-	width = nl80211_chan_width_to_mhz(chandef->width);
+	width = cfg80211_chandef_get_width(chandef);
 	if (!ieee80211_radio_freq_range_valid(radio, freq, width))
 		return false;
 
-- 
2.48.1


