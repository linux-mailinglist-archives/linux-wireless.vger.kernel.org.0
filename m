Return-Path: <linux-wireless+bounces-4156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F4386AA8F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B5B1C23325
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD42E419;
	Wed, 28 Feb 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lBmcRLfd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2A2D61B
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110646; cv=none; b=J9HZLDjs6gVJd7KOuctf2BnKW4oPMcr6+Te2DJ7G7gn93cMFMTgAzqi2EwHWbal3f+yyEa9aoZQr5bxny4XCSqRKK7flab0AxEPyb5jLmXp8VaHpyads+NCJiEgAfU0+W9GcO0g1pK0RYaGcBlpdHJ1ff67Vrfo7+FgHMzbNcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110646; c=relaxed/simple;
	bh=unoY2XgpOx2haF1FpOwYK6BEYX9KfplgFeWzcJ8Ji9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HivW1uNZYe4QCeqBgDvFnc8bAs0hEb4AwHbjA0xs/Z5n4MwjwTuBL0GmHAgdqt8LcTqUDUmQJojrAtZAURe/4Bd862lAZb6sChWZVBwruzmnw+WQZvjitUTdCpa3jeFdc/b8n8ZH1TsMrQIgQ+/zzuHgEQdTYA16j3DMHvnPntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lBmcRLfd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xvQFWgR58WdetjbmpxFYW/BL/w6Ue2IZ1kqCG/z9/ZM=;
	t=1709110644; x=1710320244; b=lBmcRLfd4VaHYjfZ/xIw5uNx06sIro2u5B9ppufdZEvd+mV
	G538fJTR9OWZKTQEVcMd/1bDPErJNe+hIdJwbu6wtog0PYwkG/uLGlUdg9EBJIAEclUmq3N/DmoPj
	VU3BnlldjXKdLxwqIOZ9YpgvP8BUXWFlDqA387Sbck0+6JZdtJlTmOlJR+kESNF8AM2AIGGGvaurA
	E0yPX1moHda1UxOsNO45RVwhNF3Du4IHdnmjLPq7iEap9hGOptlZ86V6ZocUKJXONIz+lFy46ajCS
	1M4+Bly4L/LBM/Xig54pQY5hdjmPk38U7JkQWpIk6pCKuiUrlhM8Wj7P05w8yUWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkf-0000000C0hJ-3svJ;
	Wed, 28 Feb 2024 09:57:22 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/8] wifi: cfg80211: expose cfg80211_iter_rnr() to drivers
Date: Wed, 28 Feb 2024 09:55:41 +0100
Message-ID: <20240228095718.0954809964ef.I53e95c017aa71f14e8d1057afbbc75982ddb43df@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In mac80211 we'll need to look at reduced neighbor report
entries for channel switch purposes, so export the iteration
function to make that simpler.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 32 ++++++++++++++++++++++++++++++++
 net/wireless/scan.c    | 20 +++++++-------------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f9eada2a26ec..53653d234d39 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6870,6 +6870,38 @@ cfg80211_find_vendor_ie(unsigned int oui, int oui_type,
 	return (const void *)cfg80211_find_vendor_elem(oui, oui_type, ies, len);
 }
 
+/**
+ * enum cfg80211_rnr_iter_ret - reduced neighbor report iteration state
+ * @RNR_ITER_CONTINUE: continue iterating with the next entry
+ * @RNR_ITER_BREAK: break iteration and return success
+ * @RNR_ITER_ERROR: break iteration and return error
+ */
+enum cfg80211_rnr_iter_ret {
+	RNR_ITER_CONTINUE,
+	RNR_ITER_BREAK,
+	RNR_ITER_ERROR,
+};
+
+/**
+ * cfg80211_iter_rnr - iterate reduced neighbor report entries
+ * @elems: the frame elements to iterate RNR elements and then
+ *	their entries in
+ * @elems_len: length of the elements
+ * @iter: iteration function, see also &enum cfg80211_rnr_iter_ret
+ *	for the return value
+ * @iter_data: additional data passed to the iteration function
+ * Return: %true on success (after successfully iterating all entries
+ *	or if the iteration function returned %RNR_ITER_BREAK),
+ *	%false on error (iteration function returned %RNR_ITER_ERROR
+ *	or elements were malformed.)
+ */
+bool cfg80211_iter_rnr(const u8 *elems, size_t elems_len,
+		       enum cfg80211_rnr_iter_ret
+		       (*iter)(void *data, u8 type,
+			       const struct ieee80211_neighbor_ap_info *info,
+			       const u8 *tbtt_info, u8 tbtt_info_len),
+		       void *iter_data);
+
 /**
  * cfg80211_defragment_element - Defrag the given element data into a buffer
  *
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 7cf36b8d3ae7..9377a43aa5f7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -611,19 +611,12 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 	return 0;
 }
 
-enum cfg80211_rnr_iter_ret {
-	RNR_ITER_CONTINUE,
-	RNR_ITER_BREAK,
-	RNR_ITER_ERROR,
-};
-
-static bool
-cfg80211_iter_rnr(const u8 *elems, size_t elems_len,
-		  enum cfg80211_rnr_iter_ret
-		  (*iter)(void *data, u8 type,
-			  const struct ieee80211_neighbor_ap_info *info,
-			  const u8 *tbtt_info, u8 tbtt_info_len),
-		  void *iter_data)
+bool cfg80211_iter_rnr(const u8 *elems, size_t elems_len,
+		       enum cfg80211_rnr_iter_ret
+		       (*iter)(void *data, u8 type,
+			       const struct ieee80211_neighbor_ap_info *info,
+			       const u8 *tbtt_info, u8 tbtt_info_len),
+		       void *iter_data)
 {
 	const struct element *rnr;
 	const u8 *pos, *end;
@@ -675,6 +668,7 @@ cfg80211_iter_rnr(const u8 *elems, size_t elems_len,
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(cfg80211_iter_rnr);
 
 struct colocated_ap_data {
 	const struct element *ssid_elem;
-- 
2.43.2


