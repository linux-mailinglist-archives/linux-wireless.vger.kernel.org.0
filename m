Return-Path: <linux-wireless+bounces-28849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 208ABC4EAD7
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3BD04FAB0B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F327814A;
	Tue, 11 Nov 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="hDDBWNsg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B630C635
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873098; cv=pass; b=QSY0pU/Ol9SVoXKOBNl1yacttQ0h8Uf/uKxzV2caAx6/YEDm3F6RXDhmccrFIMYHnLK2w6awOd5EKbqQFZw+7YOCy384xfXcPgY1hxtSQ8pGlYHs4CyCc8skQ1eLEVByjVVNqaMcONz/VD6GuRYSlceVLQbZ6zkoIj7YOc9fB6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873098; c=relaxed/simple;
	bh=7Q7pBPsVJNzOjF84gtF5jKmTpnW+EiFvPIOF+LsJ84U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pztThxtxtmzzo14KxupzkC7v08RjWi8O6/bqabjb+B1DZ4veBBVZeJ6Dxjv0jUCSG0ZTiMrutisPBzRq67EiSuR7aVAlvqUV2r8XY+hwABNCE6r81FzjPIAbPxQvQPgbyq4u6ddG+opm5qKhlrUNjJhe0G51+d24e9EbFtZwZK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=hDDBWNsg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762873094; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TYptTYnvgDiL+mEPtMvjNThNpMRwdL10A1dp5j9MBQddOZlXNJWrFoK+/zfDmsDyW0xw4/ch3V6DzxJKx/CgjjFwxLh4xbnEgOQWBkWyl9loHqYsGvH4EORw/AuZ88bJj50bnw7JnAi6C261F5A1g9tL/LiRkGjwJ6JylF/oNBs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762873094; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W+YhPHwkgfQ3bazOsaYuH2CfniGhEbSBernYj7q/jjE=; 
	b=jAGDulCaqmajIyFcAlRUJm+FzubVlZbybKZ9pl7ccHVOCgb7wHIII14rMteNjAtpEusbyyOaMAyR3s4c3625nxrjH5L8AZS+oMkg1OM1c99npujNH24wfjdGu1qDDa4xxOuDoMCZGd2rnc3QqLrXYhrLQChmPWB5lChXXoJhmWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762873093;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=W+YhPHwkgfQ3bazOsaYuH2CfniGhEbSBernYj7q/jjE=;
	b=hDDBWNsg6IfSEhGuHYtI21NZObXYAh3S/IuLjC/VXDM5/o4lvwVh4lZ5E0JhaLy6
	EG/kSmhNTjWF49xl4i537yA6YhgPut4VyjmDQfD3nsoOv4Yd6yLS0TLUEkNwGvOCkGm
	SucElRkkRW+gQQP3MxRSfD1g/8aXB/BImiaovqlo=
Received: by mx.zohomail.com with SMTPS id 1762873091346406.88144386683405;
	Tue, 11 Nov 2025 06:58:11 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 2/5] wifi: mac80211: add generic MMIE struct defines
Date: Tue, 11 Nov 2025 22:57:56 +0800
Message-ID: <20251111145759.111691-3-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111145759.111691-1-m@xv97.com>
References: <20251111145759.111691-1-m@xv97.com>
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


