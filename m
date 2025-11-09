Return-Path: <linux-wireless+bounces-28703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2455C43F98
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D263AD9BB
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625E2FC007;
	Sun,  9 Nov 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="VdSXc+Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CE2FBDEA
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697106; cv=pass; b=eNeToa1rOxVOq0chxKHIYVoWfb2YH8FUGsA2bkeiKVpbuNWe8qWm3ajY9VUCm43qBvfawwOmWIqL+r/R3+U4Y9Ho4cg+1hPeUlKCK2yeyXNd/PvmIQTXIU0wpPHWgdOmtgDyE7cm3vCsG1NAcadjAU0hG/jLbm7JA2iGqXuuk14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697106; c=relaxed/simple;
	bh=itFnr3FOaMcSGcbtecH7pg6zacqOJAZT7ci9WCu8N1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGR0REk/ko2taUbmA6juj0E+yHqg8C03g5JXBRMTDFqDKlVTvZ9kFg6E20nuod9zsHl23VT/EnY1jsAjRm57jvto7AaRYT2UyK4qopdPVy98DKAN+R/H4JSS6b6yEba+M7SIX1UogE58//eOOrBmtBbwOYKkW9zdMtXXJhT0gtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=VdSXc+Sa; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762697102; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=baQOvvxSBP39PQErc4OSkZwS356KlMZw3kq0495pHa/DIHYgnDIU90F3Lpto5PHL6xzZ95zBuY3F1uEi3ePUHlAZ0tpK70V/aA/NGEIeRXQw9bA9JhAY4wDLKvMoEKv7Zu+FzQ5cXRhUa7kD71r63GasoaFkJWDRQdK5DJrpCGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762697102; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vT8PwjJs/MqnxCJbMRL0ZiWvmcDBoPoV80d2JqZHeJs=; 
	b=ME8O6Jl/s1yRf7kvw6PEg2Nya58HkPnBcijFkHr47jawvwWyf/t0TCtZX1cEX3nIgjDN3aTVZSLBtI5dXgZgwMPbLVHVHnbBNjLIwINie4+bvFPil0gje3kvK6twsuBuTT0VGNtpBOFRg9zd9ST5O0sEOZqFFyv0s3Rcs5FUpFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762697102;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vT8PwjJs/MqnxCJbMRL0ZiWvmcDBoPoV80d2JqZHeJs=;
	b=VdSXc+Sazxkj3EJYaqKfzZrgD0BXAGnRB7ARn8MfnvdLUzVHbkD7BPwn2iUnMZEq
	H+GyeiracZQ043qHr9xMr3nQjYPB9OzFqt+aLoH4BJnLCQ/BvTlCCtROHP737obhBay
	qmAiDTnT1oZHan507M3LIHM0NbYxXVKio2DGBnTs=
Received: by mx.zohomail.com with SMTPS id 1762697101734821.2888887594104;
	Sun, 9 Nov 2025 06:05:01 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] wifi: mac80211: add generic MMIE struct defines
Date: Sun,  9 Nov 2025 22:04:47 +0800
Message-ID: <20251109140450.118106-4-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251109140450.118106-1-m@xv97.com>
References: <20251109140450.118106-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The added struct is needed when writing generic handler for both CMAC-128
and CMAC-256.

Compile test only.

Signed-off-by: Chien Wong <m@xv97.com>
---
 include/linux/ieee80211.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ddff9102f633..9392fc11d4fb 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1633,7 +1633,7 @@ struct ieee80211_mgmt {
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
 
 
-/* Management MIC information element (IEEE 802.11w) */
+/* Management MIC information element (IEEE 802.11w) for CMAC */
 struct ieee80211_mmie {
 	u8 element_id;
 	u8 length;
@@ -1651,6 +1651,15 @@ struct ieee80211_mmie_16 {
 	u8 mic[16];
 } __packed;
 
+/* Management MIC information element (IEEE 802.11w) for all variants */
+struct ieee80211_mmie_var {
+	u8 element_id;
+	u8 length;
+	__le16 key_id;
+	u8 sequence_number[6];
+	u8 mic[]; /* 8 or 16 bytes */
+} __packed;
+
 struct ieee80211_vendor_ie {
 	u8 element_id;
 	u8 len;
@@ -4064,6 +4073,9 @@ enum ieee80211_radio_measurement_actioncode {
 #define IEEE80211_GCMP_HDR_LEN		8
 #define IEEE80211_GCMP_MIC_LEN		16
 #define IEEE80211_GCMP_PN_LEN		6
+#define IEEE80211_CMAC_128_MIC_LEN	8
+#define IEEE80211_CMAC_256_MIC_LEN	16
+#define IEEE80211_GMAC_MIC_LEN		16
 
 #define FILS_NONCE_LEN			16
 #define FILS_MAX_KEK_LEN		64
-- 
2.51.2


