Return-Path: <linux-wireless+bounces-28915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B44C57E9A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 15:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AD8421834
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1026F2AC;
	Thu, 13 Nov 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="apmFXLbp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7826E6EB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042726; cv=pass; b=djhDqLAOUV+Xq91gDQhP0CU6b3l/+QUXUrnNBVC9ee+rUYTglhj/Xt62h1H+2Gt/42ss7jv+0EyLfHW4gidIdyHXRS7++1VrlkStFeNKe3IyCZGFXf2gbj2CmwKLJ8RDeJ1vd/TEcSZmfE7hJowkE0l/30A4RA6XpRz+fnaZ5WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042726; c=relaxed/simple;
	bh=ybaCH1ZkYh2FhHUIJq7h5Ipb53DofDvW+TJt42bhNhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJy7anHtQacQwp3TEkp8Si0WlOXY0y8WW6i8vduU1dSC7C5FOk/d3ccpY1stVr8SRKDK3kPaKY8hAcAOseyRpN0EUbJHlkevyRLzdKX48bngf6FgcG3VzPFV3t6bbTpKjiF/rx1hDqhUBwp9iQLNYXd2hBOm7npyOTvpCMMvFGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=apmFXLbp; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1763042722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JoMlUkvh4+xQbaoVSSj4HkjEfadyqNxn9dFlf0hw3xnyqSrs/gkmvwwBKpXvsxPhQcWsb+DhnpIJVnK/F0VPmgmV1ChDBVcHrTHEI/+CQWHTrm044GZetvZRL7wbV18SSM/5PlRNW1BZx4ZQF4U369R/imjeiArKRkYICup5AEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763042722; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tF9Kds6jMEK8pCDIhVJDs+sOeNMUyLQIj7mqMkcgNIk=; 
	b=ezkW8chhTYXy7NvtOwFc3ly520cM1y6aBoclE+k77HSzy0n3WPWshn/Pn8vbmlbpzkkHs+/45pOcZD8AEC8CGdTOkizPSOYiYD/IWXla9xwO9sisl0oF/PhjWL46aXCIMEQ0DeuMIuHhnt1+gPswZctaZpQCnMgF+jj5oOS07CE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763042722;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tF9Kds6jMEK8pCDIhVJDs+sOeNMUyLQIj7mqMkcgNIk=;
	b=apmFXLbpP7ZpTjScIAf/K0jVHi1AXximOHf6XObSv3aH6nH6/hJixNebFP8l99AD
	6mayNlH3bP31GSeGgpfyIpEVlwpoCvtz5T3UQHcWC1uLP679rLJhUdkK21eBGF3V1ia
	NnMSAClPPdTL9Wxq2nMaiPqbDts4f3W9gQkKWLR0=
Received: by mx.zohomail.com with SMTPS id 1763042721505714.5277609161955;
	Thu, 13 Nov 2025 06:05:21 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 2/5] wifi: mac80211: add generic MMIE struct defines
Date: Thu, 13 Nov 2025 22:05:08 +0800
Message-ID: <20251113140511.48658-3-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113140511.48658-1-m@xv97.com>
References: <20251113140511.48658-1-m@xv97.com>
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
index 6d4bc80caf96..d55d8ea3a8be 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1207,7 +1207,7 @@ struct ieee80211_mgmt {
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
 
 
-/* Management MIC information element (IEEE 802.11w) */
+/* Management MIC information element (IEEE 802.11w) for CMAC */
 struct ieee80211_mmie {
 	u8 element_id;
 	u8 length;
@@ -1225,6 +1225,15 @@ struct ieee80211_mmie_16 {
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
@@ -1889,6 +1898,9 @@ enum ieee80211_radio_measurement_actioncode {
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


