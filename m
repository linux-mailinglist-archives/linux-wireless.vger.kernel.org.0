Return-Path: <linux-wireless+bounces-28799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF1C474F8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51312349C0B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BE310645;
	Mon, 10 Nov 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="LhklI7FQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3B30F945
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785977; cv=pass; b=ZI2yMpne7n8OoPylaMWR6tAVtEPzTmKSRTEpqmiFy+AjSg1iP5u5HTZXxPOOixWrNYufJ+txLkI6aCOzSfxLHkK7UAcBpp+2gXwDLCZ5eQFzm2Xa17Xh8TMot53jht9cf1iXEzBWvifOs0BbWg1kaN2NP1gtlAPshiLGJSDuKK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785977; c=relaxed/simple;
	bh=7Q7pBPsVJNzOjF84gtF5jKmTpnW+EiFvPIOF+LsJ84U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3RCP17yzueQAwEIBiaKTZNLZr3vz9NNrZSpCrDK4PZG47QDB/kJVsfr2LhNdul1RMr0K8Kz/Bb7eaP923VS3TUENMTRIEEY9K4h6hSz4uEcX6mdsk1Cpyd36hNtLxsgrUuqCay6zxNJu6GbQxz4FFYeecMXqzuuIa4JyM/eavw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=LhklI7FQ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762785973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hpjT6DrksDAxVkgacX3IMrcyriW5Blb4hshdJ7tuZr7mG6AIMkDU7IABud7ILESjVn1GcwQ7qPAM+Hipaje7rSuH5MgxnhFgKyI1TTYClc3EcXwcItwYxeSA94c0D0h1jTNxVUMtIAc5SAPDVkutq+dIa2cil//B2+8HgxiSHm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762785973; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W+YhPHwkgfQ3bazOsaYuH2CfniGhEbSBernYj7q/jjE=; 
	b=Hjx31zPef1Q5W9FswW8i8WLvg0+kquBnlgFAAZ8XOI5W/cugKSzjnTmnFbsgw1F1qwghTXTD8l02ACqy/lP1VlmFNS8b8dy0Jdpde7l57yS3Z2aMiroHzFqDfsrnuVIcdgQ48Ftk/xrSMJreeVoYzxgtCQ29+Aipf/xJHnEbpb0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762785973;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W+YhPHwkgfQ3bazOsaYuH2CfniGhEbSBernYj7q/jjE=;
	b=LhklI7FQ994V9UXxP3WoUdC93k27799zuCvlFZrg7IbeA1jg7tmVPD9IeIcmV/UH
	D2UiPMSt0Izl7aDXbZ8g+2stG7okzo/BUj1Jl2mrVxGEVf41ZxQSvI1BoOeyAUJRVRN
	uG0i/PPm10WCfsCruUOP76t2JV3PHW/TLRQhzTJM=
Received: by mx.zohomail.com with SMTPS id 1762785956852328.095097448788;
	Mon, 10 Nov 2025 06:45:56 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/6] wifi: mac80211: add generic MMIE struct defines
Date: Mon, 10 Nov 2025 22:45:42 +0800
Message-ID: <20251110144545.15149-4-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110144545.15149-1-m@xv97.com>
References: <20251110144545.15149-1-m@xv97.com>
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


