Return-Path: <linux-wireless+bounces-32401-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJrOKr/wpmk/agAAu9opvQ
	(envelope-from <linux-wireless+bounces-32401-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EFE1F17ED
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DBC3081062
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36D242D70;
	Tue,  3 Mar 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iE4PLKVJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4363DEAD9
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548011; cv=none; b=uOzb4bt9wjAJBnwIwTwrB2zmyMVGRwW/75aW/yjiUi6ZcrIJgYE73qgc2US1Yu/SPsM24FjcNpeHZNOTlpnyt8mQV7WTrDyE088qQ49iKY/HNIGArC9NMWggC4LsZwm1q8GaBtHcp6/r+/l6AyYkY0rjy6bcs1sHMPisZhrs1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548011; c=relaxed/simple;
	bh=cm2eHJmMHfT/rcDbHQOhZ/6MHWSdh7ERKsRpPA4PNa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMt96Ab7CMVnT9tQAyAkmvuyqSJuJzG2YqJjkOky1NdT0Ln3t8QABjZgiZBM2jxGzSWL/QSvyCAsSksPG5db06787e81HlWTvo4ngq7pcXX/Jy7FSlSU2IYk4tAOVdT977FhZAYsJbUX89Glzs/8i4pY/MPymwf0TRW9lPpY2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iE4PLKVJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=klNNHpPY2K7rKRqCxMs1hn/kYQfiQCAqHBjIYthtkQs=;
	t=1772548009; x=1773757609; b=iE4PLKVJ4GwSo4Ei4PJxrsaDFlaqHt8DlN/XshbKVNgC1dj
	tvSg5bRt/pUrdxCkNhMd/TubQssTlVZunSlgQnw8+y+n8B8CBeV+Ovz04znOl6FnuyWOw0ICrVL27
	Zb/aaO2gQSjZGTTLYG3PwIjLjNtl3Fy55no+T3A2Z85UNFPEWY4+oYRZIPT2kdgLT5pVQjBkEwFI+
	3YZeX0QBYC+vRDuJo1LCA5jUpUaq80sKvUczBBij7FRRpZZl0B+hToUZrjJ/zaUYLXUKp5kFoiuqc
	2Mvb6Wm3xuGDqhfh+S7z4Y42J5AmZTnlhqeQOflzg4Z9HPIXt4QxHrWs0FXOjfFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQhy-000000079iZ-0N40;
	Tue, 03 Mar 2026 15:26:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 3/3] wifi: cfg80211: split control freq check from chandef check
Date: Tue,  3 Mar 2026 15:26:19 +0100
Message-ID: <20260303152641.11b31e4878a7.I534669506008e12ffcd6c115161777e528fdc838@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303142641.273071-5-johannes@sipsolutions.net>
References: <20260303142641.273071-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06EFE1F17ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32401-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

In order to introduce NPCA later, split the control frequency
check out of cfg80211_chandef_valid().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c | 98 +++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 44 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index d9d4e043bb39..e3c18a4392bb 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018-2025	Intel Corporation
+ * Copyright 2018-2026	Intel Corporation
  */
 
 #include <linux/export.h>
@@ -339,6 +339,58 @@ static bool cfg80211_valid_center_freq(u32 center,
 	return (center - bw / 2 - 5945) % step == 0;
 }
 
+static bool
+cfg80211_chandef_valid_control_freq(const struct cfg80211_chan_def *chandef,
+				    u32 control_freq)
+{
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_5:
+	case NL80211_CHAN_WIDTH_10:
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
+		/* checked separately */
+		break;
+	case NL80211_CHAN_WIDTH_320:
+		if (chandef->center_freq1 == control_freq + 150 ||
+		    chandef->center_freq1 == control_freq + 130 ||
+		    chandef->center_freq1 == control_freq + 110 ||
+		    chandef->center_freq1 == control_freq + 90 ||
+		    chandef->center_freq1 == control_freq - 90 ||
+		    chandef->center_freq1 == control_freq - 110 ||
+		    chandef->center_freq1 == control_freq - 130 ||
+		    chandef->center_freq1 == control_freq - 150)
+			break;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_160:
+		if (chandef->center_freq1 == control_freq + 70 ||
+		    chandef->center_freq1 == control_freq + 50 ||
+		    chandef->center_freq1 == control_freq - 50 ||
+		    chandef->center_freq1 == control_freq - 70)
+			break;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_80:
+		if (chandef->center_freq1 == control_freq + 30 ||
+		    chandef->center_freq1 == control_freq - 30)
+			break;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_40:
+		if (chandef->center_freq1 == control_freq + 10 ||
+		    chandef->center_freq1 == control_freq - 10)
+			break;
+		fallthrough;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
 	u32 control_freq, control_freq_khz, start_khz, end_khz;
@@ -393,50 +445,8 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		break;
 	}
 
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
-	case NL80211_CHAN_WIDTH_20:
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_1:
-	case NL80211_CHAN_WIDTH_2:
-	case NL80211_CHAN_WIDTH_4:
-	case NL80211_CHAN_WIDTH_8:
-	case NL80211_CHAN_WIDTH_16:
-		/* all checked above */
-		break;
-	case NL80211_CHAN_WIDTH_320:
-		if (chandef->center_freq1 == control_freq + 150 ||
-		    chandef->center_freq1 == control_freq + 130 ||
-		    chandef->center_freq1 == control_freq + 110 ||
-		    chandef->center_freq1 == control_freq + 90 ||
-		    chandef->center_freq1 == control_freq - 90 ||
-		    chandef->center_freq1 == control_freq - 110 ||
-		    chandef->center_freq1 == control_freq - 130 ||
-		    chandef->center_freq1 == control_freq - 150)
-			break;
-		fallthrough;
-	case NL80211_CHAN_WIDTH_160:
-		if (chandef->center_freq1 == control_freq + 70 ||
-		    chandef->center_freq1 == control_freq + 50 ||
-		    chandef->center_freq1 == control_freq - 50 ||
-		    chandef->center_freq1 == control_freq - 70)
-			break;
-		fallthrough;
-	case NL80211_CHAN_WIDTH_80P80:
-	case NL80211_CHAN_WIDTH_80:
-		if (chandef->center_freq1 == control_freq + 30 ||
-		    chandef->center_freq1 == control_freq - 30)
-			break;
-		fallthrough;
-	case NL80211_CHAN_WIDTH_40:
-		if (chandef->center_freq1 == control_freq + 10 ||
-		    chandef->center_freq1 == control_freq - 10)
-			break;
-		fallthrough;
-	default:
+	if (!cfg80211_chandef_valid_control_freq(chandef, control_freq))
 		return false;
-	}
 
 	if (!cfg80211_valid_center_freq(chandef->center_freq1, chandef->width))
 		return false;
-- 
2.53.0


