Return-Path: <linux-wireless+bounces-36012-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGy7M0c++2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36012-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:12:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDAE4DAC6A
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C024C300B607
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE046AF04;
	Wed,  6 May 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MWnrlB3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842464657F4
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073016; cv=none; b=uIP/P4zqrdodMbPNi9pZv8O9EJIAxhnbL7p2eIq6Y+7Ncdsc3NJy7kMkPyALhOkiM2wKiad4mWzZfe2uMe6SIkDbzDEEAXMsP5XLenI8rfQdd5W/cUmcmUJpJ82WWO2qxGmp+qzV5zPy3VFQmlJ3bSUL07r+y0wrQWFaSPzGY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073016; c=relaxed/simple;
	bh=ns+uiuwn6+Nn2JsqebIbMHJiTk2yfD+YUM8bxVhy7U0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJ5EKlJFv3/Hk/pasT8qxMa2BBRaXXVN5kD1w4bUQPVY+fntSv7wm94MuzuNScAP4MdzmKCFrrYQvUTbhDlKvSW1eonv6uzBnjO31VoHkK3QaKNBRLDX0F7f9a1i/uJ01xGy+xzaBaiSiTDjEE5tbHKCk4R+15oC891He1B7USU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MWnrlB3s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DABxT41986824, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073011; bh=JWy1EdNnNtqVsYRoCg4BIKRKeY4g7j5e6C4kuHjYlwE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MWnrlB3sXDSS6FmlWCJh9iPM6B04k7HtXdTsS38mmcj3sM2LNSRMoc4/7iFBcWzc5
	 nTVJEjqHktkscBOLmunOZpWV5p8cxqfSNJ2sBiAL6fWrUXV/IMMaYck6vdda9LjrU7
	 0p7hz+H2RqojzigkJjD3eeZ36Bk5FT0mx9U3TRVTL9I43Pb7gDNMONaFk6/uzAzU5Y
	 f65zHa1jRckNC98VAIjoarfJwIUSdrOWs3NTku/c9AmBL6dOvBVgYrxj+uyH7eiYUu
	 yPOf7REd1HbTdGXT8u+GB8+cBCpmIQPlPosx46hw/QY6oQy2lU+vCECO+csTK610Zm
	 TtAM9wy8u3Hsg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DABxT41986824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:11 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:11 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:10 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 02/14] wifi: rtw89: add VHT beamformed to radiotap
Date: Wed, 6 May 2026 21:09:48 +0800
Message-ID: <20260506131000.1706298-3-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 2DDAE4DAC6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36012-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Set VHT beamformed bit by PHY status IE-01 report.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 240502b25b2e..d6bf1d57e8e1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2099,6 +2099,7 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 	phy_ppdu->chan_idx = le32_get_bits(ie->w0, RTW89_PHY_STS_IE01_W0_CH_IDX);
 	phy_ppdu->ldpc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_LDPC);
 	phy_ppdu->stbc = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_STBC);
+	phy_ppdu->bf = le32_get_bits(ie->w3, RTW89_PHY_STS_IE01_W3_BF);
 
 	if (!phy_ppdu->hdr_2_en)
 		phy_ppdu->rx_path_en =
@@ -2115,7 +2116,6 @@ static void rtw89_core_parse_phy_status_ie01(struct rtw89_dev *rtwdev,
 	phy_ppdu->ofdm.avg_snr = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_AVG_SNR);
 	phy_ppdu->ofdm.evm_max = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MAX);
 	phy_ppdu->ofdm.evm_min = le32_get_bits(ie->w2, RTW89_PHY_STS_IE01_W2_EVM_MIN);
-	phy_ppdu->bf = le32_get_bits(ie->w3, RTW89_PHY_STS_IE01_W3_BF);
 	phy_ppdu->ofdm.has = true;
 
 	/* sign conversion for S(12,2) */
@@ -3146,6 +3146,8 @@ void rtw89_core_update_rx_status_by_ppdu(struct rtw89_dev *rtwdev,
 	if (!phy_ppdu)
 		return;
 
+	if (phy_ppdu->bf)
+		rx_status->enc_flags |= RX_ENC_FLAG_BF;
 	if (phy_ppdu->ldpc)
 		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 	if (phy_ppdu->stbc)
@@ -6848,7 +6850,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 	hw->radiotap_mcs_details |= IEEE80211_RADIOTAP_MCS_HAVE_FEC |
 				    IEEE80211_RADIOTAP_MCS_HAVE_STBC;
-	hw->radiotap_vht_details |= IEEE80211_RADIOTAP_VHT_KNOWN_STBC;
+	hw->radiotap_vht_details |= IEEE80211_RADIOTAP_VHT_KNOWN_STBC |
+				    IEEE80211_RADIOTAP_VHT_KNOWN_BEAMFORMED;
 
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-- 
2.25.1


