Return-Path: <linux-wireless+bounces-33677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGjXOBSzwGm5KAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:27:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0572EC345
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F6C3011138
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 03:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652714A8B;
	Mon, 23 Mar 2026 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PQg7SksR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CE15539A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774236404; cv=none; b=WDN7PEWsgoTQy9Nr2+rJzLoO4NkhWYs/Vi8t5ABvyG2Z74x2Ye3KpX+dZruM1rGUn7Yu5Kevq14HvwCcvlgWd1ekXHPTr+rMF90S+id/lHtdLzpUBpqM/T9XpkqPImSjO8I9OC9n2BsIpA0an9aQSeiEsyh+Icv6xK39tM1cUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774236404; c=relaxed/simple;
	bh=evd/NBSdD7JKHQXGMRfCEqNi/T1YeN3GkTbns1W7hjg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA3JhqzZ49Dpzdc40h+leXaz3uM1Y6YEQ1G6X40wmH2VrwkJMKpQV9KXeIG+2rxgEhABHirvrMJb/hKzgKg98tEFmIaRzsaKvODugn5Tw+A6ZQYKQPyUq9O0jPoo7eik/JhPesffWHpSxQszTNflhyCzVLRUkIC3SlPn8h/L4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PQg7SksR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N3Qey262375632, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774236400; bh=eK38cVlWK4gPfAgxXiLwmtr7TprW92DQ89A5Ni8pKlI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PQg7SksRSMH9gBueBZfadXUTB/ogXcrrE3eyV4PwEDM1swTas8hq3wS+PpqKDVKpW
	 pmOZG20DRQmX78gPT0aEFmDyx5gKEkXnX1wY9gH2GGpuhMZERizwgqAiC6Gu2+olXv
	 mBigVhzJCoT322+/kyD2eRYwBLQbpmFuW4m6W6m4KJtyRqImcOne6bFexhZCaj6kHO
	 dXlQJdSKonC37Sk6gM3o8A3aGDScXDdSthxihGwIgEL5bxEgtxjWRSsqesrw98m4Nn
	 uQSW0clR7ftWzAHtXC0tm6MfKzuLHnYkztCYi+y+ir0MfA0VUXqqI7vur0WR99KJXx
	 zSn7vyFOdPgrg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N3Qey262375632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 11:26:40 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 11:26:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 11:26:40 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 11:26:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 5/7] wifi: rtw89: 8922d: add set channel of MAC part
Date: Mon, 23 Mar 2026 11:25:54 +0800
Message-ID: <20260323032556.19825-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323032556.19825-1-pkshih@realtek.com>
References: <20260323032556.19825-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33677-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D0572EC345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The set channel is a key function to switch to specific operating channel.
For MAC part, configure hardware according to channel bandwidth, and
enable CCK rate for 2GHz band only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 179006c8e499..2195f576facc 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6801,6 +6801,7 @@
 #define R_BE_MUEDCA_EN 0x10370
 #define R_BE_MUEDCA_EN_C1 0x14370
 #define B_BE_SIFS_TIMEOUT_TB_T2_MASK GENMASK(30, 24)
+#define B_BE_SIFS_MACTXEN_TB_T1_DOT05US_MASK GENMASK(23, 16)
 #define B_BE_SIFS_MACTXEN_TB_T1_MASK GENMASK(22, 16)
 #define B_BE_MUEDCA_WMM_SEL BIT(8)
 #define B_BE_SET_MUEDCATIMER_TF_MASK GENMASK(5, 4)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index cbe8e067ae55..a341734ef54d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -5,6 +5,7 @@
 #include "debug.h"
 #include "efuse.h"
 #include "mac.h"
+#include "phy.h"
 #include "reg.h"
 #include "rtw8922d.h"
 
@@ -835,6 +836,97 @@ static void rtw8922d_power_trim(struct rtw89_dev *rtwdev)
 	rtw8922d_pad_bias_trim(rtwdev);
 }
 
+static void rtw8922d_set_channel_mac(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan,
+				     u8 mac_idx)
+{
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_BE_TX_SUB_BAND_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_BE_TXRATE_CHK, mac_idx);
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_RFMOD, mac_idx);
+	u8 txsb20 = 0, txsb40 = 0, txsb80 = 0;
+	u8 rf_mod_val, chk_rate_mask, sifs;
+	u32 txsb;
+	u32 reg;
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_160:
+		txsb80 = rtw89_phy_get_txsb(rtwdev, chan, RTW89_CHANNEL_WIDTH_80);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_80:
+		txsb40 = rtw89_phy_get_txsb(rtwdev, chan, RTW89_CHANNEL_WIDTH_40);
+		fallthrough;
+	case RTW89_CHANNEL_WIDTH_40:
+		txsb20 = rtw89_phy_get_txsb(rtwdev, chan, RTW89_CHANNEL_WIDTH_20);
+		break;
+	default:
+		break;
+	}
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_160:
+		rf_mod_val = BE_WMAC_RFMOD_160M;
+		txsb = u32_encode_bits(txsb20, B_BE_TXSB_20M_MASK) |
+		       u32_encode_bits(txsb40, B_BE_TXSB_40M_MASK) |
+		       u32_encode_bits(txsb80, B_BE_TXSB_80M_MASK);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_mod_val = BE_WMAC_RFMOD_80M;
+		txsb = u32_encode_bits(txsb20, B_BE_TXSB_20M_MASK) |
+		       u32_encode_bits(txsb40, B_BE_TXSB_40M_MASK);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_mod_val = BE_WMAC_RFMOD_40M;
+		txsb = u32_encode_bits(txsb20, B_BE_TXSB_20M_MASK);
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+	default:
+		rf_mod_val = BE_WMAC_RFMOD_20M;
+		txsb = 0;
+		break;
+	}
+
+	if (txsb20 <= BE_PRI20_BITMAP_MAX)
+		txsb |= u32_encode_bits(BIT(txsb20), B_BE_PRI20_BITMAP_MASK);
+
+	rtw89_write8_mask(rtwdev, rf_mod, B_BE_WMAC_RFMOD_MASK, rf_mod_val);
+	rtw89_write32(rtwdev, sub_carr, txsb);
+
+	switch (chan->band_type) {
+	case RTW89_BAND_2G:
+		chk_rate_mask = B_BE_BAND_MODE;
+		break;
+	case RTW89_BAND_5G:
+	case RTW89_BAND_6G:
+		chk_rate_mask = B_BE_CHECK_CCK_EN | B_BE_RTS_LIMIT_IN_OFDM6;
+		break;
+	default:
+		rtw89_warn(rtwdev, "Invalid band_type:%d\n", chan->band_type);
+		return;
+	}
+
+	rtw89_write8_clr(rtwdev, chk_rate, B_BE_BAND_MODE | B_BE_CHECK_CCK_EN |
+					   B_BE_RTS_LIMIT_IN_OFDM6);
+	rtw89_write8_set(rtwdev, chk_rate, chk_rate_mask);
+
+	switch (chan->band_width) {
+	case RTW89_CHANNEL_WIDTH_160:
+		sifs = 0x8C;
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		sifs = 0x8A;
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		sifs = 0x84;
+		break;
+	case RTW89_CHANNEL_WIDTH_20:
+	default:
+		sifs = 0x82;
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MUEDCA_EN, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_SIFS_MACTXEN_TB_T1_DOT05US_MASK, sifs);
+}
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
-- 
2.25.1


