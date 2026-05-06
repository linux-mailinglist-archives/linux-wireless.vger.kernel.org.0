Return-Path: <linux-wireless+bounces-36016-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K0tMNw9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36016-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2824DAC0D
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 251CB30086A2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F893F076B;
	Wed,  6 May 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IWaRgTxZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD133FA5C8
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073036; cv=none; b=DpPxCvNE1shYXUcqcFlCqW4KEUbHejvvtxMl92q7Ee0L8ZKtJx/ppE/wErSR3ZYenRpqAZerUjgQ1hHPcbvKxIcuCyAjnzpHiqVDXy7dZhaFKfbAcOAEwnGyzip2Zggg4X4vgAh26InOKbdqaGIK9L0t2dEYbIVJ2BHLj+5zrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073036; c=relaxed/simple;
	bh=MCvBTS1JolyomRzBUHxrSV4xzQ5uH0oi/zUn80JKEEM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0OAAv7QZbQWB8QZ7uHEoehjRN8Zq3GU3ZBvOZfzqavnl5qBO8ARZDIpgqmRk8r2uCawawzXUzpBL2sDsa9efpQWVnjpjQxj4y64Qc4lhy5IOFUQKXP28Ewh5oQwEn0j4u1QSJiMTSf0du/5LDfNAPNELHJo3hBUZcY6GTlMIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IWaRgTxZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DAXkX41986897, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073033; bh=GYTOnRmluiCbi+tVJUVuuJ4S/rT4ngk8WWy6hzFIkxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IWaRgTxZJON5zyjoi/HXoIl+s/MJdf+SdaD3GCSByEq5XEBNDPjyg12vh65+Q8qIG
	 mTUhFQmRNNCCOa5xCQf+kdyVFahIgDiK/tw3a4f7Ifw//uVxcbk0noKydcqWRvnEuj
	 HiX+QbVdW67atMcHYTxIFXydTKdGYI+iZbQdR14yHLiXP6+v/OwjFJKhlPqfhPDJmY
	 MbuUn4TEno4g4ol25e8LJfZkbW52a4nZYhS91lSBT5Qj/JkdNgzYyeJDPhF7Wvc+3v
	 M1FzmMZqns/fvfegDPKPJrE9AREoLYCmN+wt8DUGOojsuIXDYDBu1/ndEYYerx79Xs
	 ujTRzI2peMiFA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DAXkX41986897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:32 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:32 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 06/14] wifi: rtw89: move HE radiotap to an individual function
Date: Wed, 6 May 2026 21:09:52 +0800
Message-ID: <20260506131000.1706298-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: CD2824DAC0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36016-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

To implement more fields of HE radiotap, move the code to an individual
function ahead. Not change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 36 +++++++++++++----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index f877c2707c84..a27e482e38a6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3176,6 +3176,24 @@ void rtw89_core_update_rx_status_by_ppdu(struct rtw89_dev *rtwdev,
 		rx_status->enc_flags |= u8_encode_bits(1, RX_ENC_FLAG_STBC_MASK);
 }
 
+static void rtw89_core_update_radiotap_he(struct rtw89_dev *rtwdev,
+					  struct sk_buff *skb,
+					  struct ieee80211_rx_status *rx_status)
+{
+	static const struct ieee80211_radiotap_he known_he = {
+		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_CODING_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_STBC_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
+		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
+	};
+	struct ieee80211_radiotap_he *he;
+
+	rx_status->flag |= RX_FLAG_RADIOTAP_HE;
+	he = skb_push(skb, sizeof(*he));
+	*he = known_he;
+}
+
 static const u8 rx_status_bw_to_radiotap_eht_usig[] = {
 	[RATE_INFO_BW_20] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_20MHZ,
 	[RATE_INFO_BW_5] = U8_MAX,
@@ -3250,25 +3268,13 @@ static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb,
 				       struct ieee80211_rx_status *rx_status)
 {
-	static const struct ieee80211_radiotap_he known_he = {
-		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
-				     IEEE80211_RADIOTAP_HE_DATA1_CODING_KNOWN |
-				     IEEE80211_RADIOTAP_HE_DATA1_STBC_KNOWN |
-				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
-		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
-	};
-	struct ieee80211_radiotap_he *he;
-
 	if (!(rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR))
 		return;
 
-	if (rx_status->encoding == RX_ENC_HE) {
-		rx_status->flag |= RX_FLAG_RADIOTAP_HE;
-		he = skb_push(skb, sizeof(*he));
-		*he = known_he;
-	} else if (rx_status->encoding == RX_ENC_EHT) {
+	if (rx_status->encoding == RX_ENC_HE)
+		rtw89_core_update_radiotap_he(rtwdev, skb, rx_status);
+	else if (rx_status->encoding == RX_ENC_EHT)
 		rtw89_core_update_radiotap_eht(rtwdev, skb, rx_status);
-	}
 }
 
 static void rtw89_core_validate_rx_signal(struct ieee80211_rx_status *rx_status)
-- 
2.25.1


