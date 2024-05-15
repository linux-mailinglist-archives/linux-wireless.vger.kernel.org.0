Return-Path: <linux-wireless+bounces-7673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A428C61DB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E38283DCE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211C4AEF4;
	Wed, 15 May 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Pnpvm8oJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86847F78
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758749; cv=none; b=bM32BUJZ4JNbqJNWdPwBP9iQ3ex7x9xgUnZADHsEneSfHrwyb1UmS8cqMD1p9Ewk2SES4ovvIkaOhGULIJPxnsQEppUEIlPtJ0EzhiM0z+uC25zFknHIBtM/JLm22o/1/6LJkcEwplqsg0Onl2kTiYiWliIIZmBLgEkzQLYKESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758749; c=relaxed/simple;
	bh=yq1Mq2gs0gC0KAxEjFCmGz91agtgyakecfU/RP5JT70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOdlHfEugOT0P6EUk3SiZWKJQoARF/V0NwkS7rewkPY6j0LdHucN7abQZMxXvqQ1qV9SKkgaPKIcAOlWM0x5lKljuWqVV1fSuO9MwiAWFdl9Yd2dB1nhgzBqzf/A4zdfRf8eEAYU5sl7icRw7cts/5MQabPH2r8nWtol1cbofCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Pnpvm8oJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X9WTqttk+8SrOJn82P1W7v6AhIuayiPTDGMBySZ37ac=;
	t=1715758748; x=1716968348; b=Pnpvm8oJPVuTzWrF2byYP/PRZpZLrxqdj+Ic/tpJqBSOfpj
	iqB9tt+lcXA5LvfIVMOnAOqhSpQR83nfWi+4ffLKbkT/jaR9+MTuL2SPVWDrY4zFmGLYwfVuQqB6V
	Ier9VsGZQB4fP/v9KZA04CzghCoJQpBAGcHIj8sLHnggdGImbHghmfJVHrJxzS9VhOfnyqdSjQiS3
	0t5WXlbZfUAt+TyMlYBkmLqTsEpEVEfrFd9dmAGd7WwZN/FszYVp9QB1mcKdqbimq+QsdRkqeUG10
	D940f6W1bkEkAQripoPiT5/UhHg4GtcUdkfPXB48iv6gqLvZ/LtBfUlCAg/lHNNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79E9-000000063rL-36X3;
	Wed, 15 May 2024 09:39:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4/6] wifi: ieee80211: remove ieee80211_next_tbtt_present()
Date: Wed, 15 May 2024 09:38:38 +0200
Message-ID: <20240515093852.774ced74dea8.I152525b4cff6e6a25be6c48fe6a4b89f17bab8a9@changeid>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515073852.11273-8-johannes@sipsolutions.net>
References: <20240515073852.11273-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is actually completely equivalent to the other function
ieee80211_is_s1g_short_beacon(), but open-codes the logic.
Implement the necessary logic in ieee80211_is_s1g_short_beacon()
and remove ieee80211_next_tbtt_present().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 713266ce48a7..72b351abb4f6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -604,25 +604,15 @@ static inline bool ieee80211_is_s1g_beacon(__le16 fc)
 }
 
 /**
- * ieee80211_next_tbtt_present - check if IEEE80211_FTYPE_EXT &&
- * IEEE80211_STYPE_S1G_BEACON && IEEE80211_S1G_BCN_NEXT_TBTT
- * @fc: frame control bytes in little-endian byteorder
- */
-static inline bool ieee80211_next_tbtt_present(__le16 fc)
-{
-	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) ==
-	       cpu_to_le16(IEEE80211_FTYPE_EXT | IEEE80211_STYPE_S1G_BEACON) &&
-	       fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT);
-}
-
-/**
- * ieee80211_is_s1g_short_beacon - check if next tbtt present bit is set. Only
- * true for S1G beacons when they're short.
+ * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an S1G short beacon,
+ *	i.e. it is an S1G beacon with 'next TBTT' flag set
  */
 static inline bool ieee80211_is_s1g_short_beacon(__le16 fc)
 {
-	return ieee80211_is_s1g_beacon(fc) && ieee80211_next_tbtt_present(fc);
+	return ieee80211_is_s1g_beacon(fc) &&
+		(fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT));
 }
 
 /**
-- 
2.45.0


