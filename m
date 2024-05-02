Return-Path: <linux-wireless+bounces-7091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C1D8B9369
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBC91C21FB9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE2171AD;
	Thu,  2 May 2024 02:25:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8717C66
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616740; cv=none; b=G26V2zvVkRvk78AL1/YImjdMetY4kT4Q7aKu4qRv1xHX8O4HMjsaEHhOdzj+4Ql//SKpxwDUdPlAWXYuvkPvl/tyLxjgkSBZHmF1Z4PDaBfKiSl5LQaH0eFFcwbjn6mtWhule+6h1YHFtjoNZXk7u9dQgzMm6uA5AkJPQvE/+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616740; c=relaxed/simple;
	bh=SfGw6tMd7c/QA2H4mrgqIYJ2SMmBybS4PBDBAB4+CDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9E3Rl2r5MwETEJaINFgRbf5JjCqM5mZ7dtTOcVTy3pr73VbOcuGIEcqEpQ67uNCfDvg3UxnMETAUs/kcO6fFn//oMa/ajCc5K/QsyE0F5xrrXBFsQ+0hGddb/pDIWU8w8dR76FtgdpTQuHTEUuVaWc+/52D5jtHyuajUg4iVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422PZDR02026327, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422PZDR02026327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:25:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:25:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:25:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH v2 04/12] wifi: rtw89: wow: prepare PTK GTK info from mac80211
Date: Thu, 2 May 2024 10:24:57 +0800
Message-ID: <20240502022505.28966-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502022505.28966-1-pkshih@realtek.com>
References: <20240502022505.28966-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chih-Kang Chang <gary.chang@realtek.com>

Get the PTK and PTK TRX PN value and transfer to IV value, these
values will used by firmware to generate packets with correct IV value.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  14 ++
 drivers/net/wireless/realtek/rtw89/fw.c   |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.c  | 187 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.h  |  17 ++
 4 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 834e19c533ae..6b456f214fed 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5156,11 +5156,25 @@ struct rtw89_wow_cam_info {
 	bool valid;
 };
 
+struct rtw89_wow_key_info {
+	u8 ptk_tx_iv[8];
+	u8 valid_check;
+	u8 symbol_check_en;
+	u8 gtk_keyidx;
+	u8 rsvd[5];
+	u8 ptk_rx_iv[8];
+	u8 gtk_rx_iv[4][8];
+} __packed;
+
 struct rtw89_wow_param {
 	struct ieee80211_vif *wow_vif;
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
 	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
+	struct rtw89_wow_key_info key_info;
 	u8 pattern_cnt;
+	u8 ptk_alg;
+	u8 gtk_alg;
+	u8 ptk_keyidx;
 	u8 akm;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d9ab781fa0e6..0bc7fcd5b27d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6402,7 +6402,7 @@ int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WAKEUP_CTRL_LEN);
 	if (!skb) {
-		rtw89_err(rtwdev, "failed to alloc skb for keep alive\n");
+		rtw89_err(rtwdev, "failed to alloc skb for wakeup ctrl\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index dcae75128c71..185e24626691 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -27,6 +27,192 @@ void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 	rtw_wow->akm = rsn_ie->akm_cipher_suite.type;
 }
 
+static const struct rtw89_cipher_info rtw89_cipher_info_defs[] = {
+	{WLAN_CIPHER_SUITE_WEP40,	.fw_alg = 1,	.len = WLAN_KEY_LEN_WEP40,},
+	{WLAN_CIPHER_SUITE_WEP104,	.fw_alg = 2,	.len = WLAN_KEY_LEN_WEP104,},
+	{WLAN_CIPHER_SUITE_TKIP,	.fw_alg = 3,	.len = WLAN_KEY_LEN_TKIP,},
+	{WLAN_CIPHER_SUITE_CCMP,	.fw_alg = 6,	.len = WLAN_KEY_LEN_CCMP,},
+	{WLAN_CIPHER_SUITE_GCMP,	.fw_alg = 8,	.len = WLAN_KEY_LEN_GCMP,},
+	{WLAN_CIPHER_SUITE_CCMP_256,	.fw_alg = 7,	.len = WLAN_KEY_LEN_CCMP_256,},
+	{WLAN_CIPHER_SUITE_GCMP_256,	.fw_alg = 23,	.len = WLAN_KEY_LEN_GCMP_256,},
+};
+
+static const
+struct rtw89_cipher_info *rtw89_cipher_alg_recognize(u32 cipher)
+{
+	const struct rtw89_cipher_info *cipher_info_defs;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rtw89_cipher_info_defs); i++) {
+		cipher_info_defs = &rtw89_cipher_info_defs[i];
+		if (cipher_info_defs->cipher == cipher)
+			return cipher_info_defs;
+	}
+
+	return NULL;
+}
+
+static int _pn_to_iv(struct rtw89_dev *rtwdev, struct ieee80211_key_conf *key,
+		     u8 *iv, u64 pn, u8 key_idx)
+{
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		iv[0] = u64_get_bits(pn, RTW89_KEY_PN_1);
+		iv[1] = (u64_get_bits(pn, RTW89_KEY_PN_1) | 0x20) & 0x7f;
+		iv[2] = u64_get_bits(pn, RTW89_KEY_PN_0);
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		iv[0] = u64_get_bits(pn, RTW89_KEY_PN_0);
+		iv[1] = u64_get_bits(pn, RTW89_KEY_PN_1);
+		iv[2] = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	iv[3] = BIT(5) | ((key_idx & 0x3) << 6);
+	iv[4] = u64_get_bits(pn, RTW89_KEY_PN_2);
+	iv[5] = u64_get_bits(pn, RTW89_KEY_PN_3);
+	iv[6] = u64_get_bits(pn, RTW89_KEY_PN_4);
+	iv[7] = u64_get_bits(pn, RTW89_KEY_PN_5);
+
+	return 0;
+}
+
+static int rtw89_rx_pn_to_iv(struct rtw89_dev *rtwdev,
+			     struct ieee80211_key_conf *key,
+			     u8 *iv)
+{
+	struct ieee80211_key_seq seq;
+	int err;
+	u64 pn;
+
+	ieee80211_get_key_rx_seq(key, 0, &seq);
+
+	/* seq.ccmp.pn[] is BE order array */
+	pn = u64_encode_bits(seq.ccmp.pn[0], RTW89_KEY_PN_5) |
+	     u64_encode_bits(seq.ccmp.pn[1], RTW89_KEY_PN_4) |
+	     u64_encode_bits(seq.ccmp.pn[2], RTW89_KEY_PN_3) |
+	     u64_encode_bits(seq.ccmp.pn[3], RTW89_KEY_PN_2) |
+	     u64_encode_bits(seq.ccmp.pn[4], RTW89_KEY_PN_1) |
+	     u64_encode_bits(seq.ccmp.pn[5], RTW89_KEY_PN_0);
+
+	err = _pn_to_iv(rtwdev, key, iv, pn, key->keyidx);
+	if (err)
+		return err;
+
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d pn-%llx to iv-%*ph\n",
+		    __func__, key->keyidx, pn, 8, iv);
+
+	return 0;
+}
+
+static int rtw89_tx_pn_to_iv(struct rtw89_dev *rtwdev,
+			     struct ieee80211_key_conf *key,
+			     u8 *iv)
+{
+	int err;
+	u64 pn;
+
+	pn = atomic64_inc_return(&key->tx_pn);
+	err = _pn_to_iv(rtwdev, key, iv, pn, key->keyidx);
+	if (err)
+		return err;
+
+	rtw89_debug(rtwdev, RTW89_DBG_WOW, "%s key %d pn-%llx to iv-%*ph\n",
+		    __func__, key->keyidx, pn, 8, iv);
+
+	return 0;
+}
+
+static void rtw89_wow_get_key_info_iter(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct ieee80211_key_conf *key,
+					void *data)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_key_info *key_info = &rtw_wow->key_info;
+	const struct rtw89_cipher_info *cipher_info;
+	bool *err = data;
+	int ret;
+
+	cipher_info = rtw89_cipher_alg_recognize(key->cipher);
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (sta) {
+			ret = rtw89_tx_pn_to_iv(rtwdev, key,
+						key_info->ptk_tx_iv);
+			if (ret)
+				goto err;
+			ret = rtw89_rx_pn_to_iv(rtwdev, key,
+						key_info->ptk_rx_iv);
+			if (ret)
+				goto err;
+
+			rtw_wow->ptk_alg = cipher_info->fw_alg;
+			rtw_wow->ptk_keyidx = key->keyidx;
+		} else {
+			ret = rtw89_rx_pn_to_iv(rtwdev, key,
+						key_info->gtk_rx_iv[key->keyidx]);
+			if (ret)
+				goto err;
+
+			rtw_wow->gtk_alg = cipher_info->fw_alg;
+			key_info->gtk_keyidx = key->keyidx;
+		}
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_WOW, "unsupport cipher %x\n",
+			    key->cipher);
+		goto err;
+	}
+
+	return;
+err:
+	*err = true;
+}
+
+static void rtw89_wow_key_clear(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+
+	memset(&rtw_wow->key_info, 0, sizeof(rtw_wow->key_info));
+	rtw_wow->ptk_alg = 0;
+	rtw_wow->gtk_alg = 0;
+}
+
+static void rtw89_wow_construct_key_info(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_wow_key_info *key_info = &rtw_wow->key_info;
+	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
+	bool err = false;
+
+	rcu_read_lock();
+	ieee80211_iter_keys_rcu(rtwdev->hw, wow_vif,
+				rtw89_wow_get_key_info_iter, &err);
+	rcu_read_unlock();
+
+	if (err) {
+		rtw89_wow_key_clear(rtwdev);
+		return;
+	}
+
+	key_info->valid_check = RTW89_WOW_VALID_CHECK;
+	key_info->symbol_check_en = RTW89_WOW_SYMBOL_CHK_PTK |
+				    RTW89_WOW_SYMBOL_CHK_GTK;
+}
+
 static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
 {
 	__rtw89_leave_ps_mode(rtwdev);
@@ -645,6 +831,7 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 	int ret;
 
 	rtw89_wow_pattern_write(rtwdev);
+	rtw89_wow_construct_key_info(rtwdev);
 
 	ret = rtw89_fw_h2c_keep_alive(rtwdev, rtwvif, true);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index d9cfd2beda39..165c75083721 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -5,6 +5,17 @@
 #ifndef __RTW89_WOW_H__
 #define __RTW89_WOW_H__
 
+#define RTW89_KEY_PN_0 GENMASK_ULL(7, 0)
+#define RTW89_KEY_PN_1 GENMASK_ULL(15, 8)
+#define RTW89_KEY_PN_2 GENMASK_ULL(23, 16)
+#define RTW89_KEY_PN_3 GENMASK_ULL(31, 24)
+#define RTW89_KEY_PN_4 GENMASK_ULL(39, 32)
+#define RTW89_KEY_PN_5 GENMASK_ULL(47, 40)
+
+#define RTW89_WOW_VALID_CHECK 0xDD
+#define RTW89_WOW_SYMBOL_CHK_PTK BIT(0)
+#define RTW89_WOW_SYMBOL_CHK_GTK BIT(1)
+
 enum rtw89_wake_reason {
 	RTW89_WOW_RSN_RX_PTK_REKEY = 0x1,
 	RTW89_WOW_RSN_RX_GTK_REKEY = 0x2,
@@ -31,6 +42,12 @@ struct rtw89_rsn_ie {
 	struct rtw89_cipher_suite akm_cipher_suite;
 } __packed;
 
+struct rtw89_cipher_info {
+	u32 cipher;
+	u8 fw_alg;
+	enum ieee80211_key_len len;
+};
+
 #ifdef CONFIG_PM
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
-- 
2.25.1


