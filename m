Return-Path: <linux-wireless+bounces-38895-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qajnNsEEU2pMWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38895-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB62743A40
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Xk+9Nh15;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38895-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38895-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43B59300D629
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D427A476;
	Sun, 12 Jul 2026 03:06:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA092773DE
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825599; cv=none; b=vGlWPkpyC7S6VwtVSY5Q97MVhUUgUXlKGua9RXNu9ljUImYjr0vk/i3pGPl6GdZAfMSLyLi7fFcIdqMyVdsnPxeYraOsR/+nUFxmpedscIOxr0VwrWwxHmutPIbjsu3gGpbBtk3/eDuLmNDCJ8qVZALTjBlO0g2FyA5iU5zTiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825599; c=relaxed/simple;
	bh=buLpGIuHRJntsEoJ/TlrRuzxt75lifCg6msa+La2QMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FshVUSQCYWvzQeAWF9m7jcLcVVF65UUioE7CoKR2PknJO8dDvgxOa3EqIN6zERPDjBgR0UNMj1ByGH4hyWXmnUw9/gCaB/LJuL3yStb96epjtnuJz/W73JnfqprZiTVYGXJN8LKScnblKttNCqyDgA9JpyrodJ/abxj7yTwRuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xk+9Nh15; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36ZpgC525930, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825595; bh=OJO4iqarauj/QNSHfqdtQ+vbA961AaWb2XH8t1QEbO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Xk+9Nh159BMPHcklpoAbwFeDmdAKvJg8lRoPmHKmiXIloatPnolAXCqzV98KVXA5R
	 6t5rY/ygsiSg/JNyJmF94YF3jeMWkSsr6I6cs1tiBpjcx4OkeWRvRTxBW7KIw7FpX6
	 U9rMaQGKgaHtzMLFkvrVvayU3FUYzVWsaKq1jnGnaVvCmjdWc5393lA5+2o06b0fCr
	 uUmBjYJ0u5fw776Lj1gcKN7TsnJedCUqDs0RBJx8chpI0NEugGqw6q7zrOHbCPpxD5
	 zA5IdIjrTNIfNcgsydn9JVHWW4ChEO9dKqfbzCq3CnxxPKqVQfIXbpui3J6ufkhDuf
	 L5lT/97zQzyTQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36ZpgC525930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:35 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 06/11] wifi: rtw89: coex: Refine send firmware command function
Date: Sun, 12 Jul 2026 11:05:01 +0800
Message-ID: <20260712030506.43438-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712030506.43438-1-pkshih@realtek.com>
References: <20260712030506.43438-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38895-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EB62743A40

From: Ching-Te Ku <ku920601@realtek.com>

Because the coexistence offload more register/ hardware setting I/O to
firmware by coexistence itself, and it goes with the same entry with other
control action, so the firmware command entry need to add different
condition to judge should it followed coexistence TLV format or not.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 107 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |   4 +
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ff3345824a2a..07d054f59eb5 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -936,6 +936,14 @@ static void _run_coex(struct rtw89_dev *rtwdev,
 static void _write_scbd(struct rtw89_dev *rtwdev, u8 bid, u32 val, bool state);
 static u8 _sned_h2c_w2bscbd(struct rtw89_dev *rtwdev, bool force_exec, u8 bid);
 static void _update_bt_scbd(struct rtw89_dev *rtwdev, u8 bid);
+static const char *id_to_h2c(u32 id);
+
+static void _reset_h2c_macro(struct rtw89_btc *btc)
+{
+	btc->hbuf_len = 0;
+	btc->hbuf_cnt = 0;
+	memset(btc->hbuf, 0, BTC_H2C_MAXLEN);
+}
 
 static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 			void *param, u16 len)
@@ -945,6 +953,8 @@ static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	u8 h2c_func_mask, bid = BTC_BT_1ST;
+	u8 *buf = param;
 	int ret;
 
 	if (len > BTC_H2C_MAXLEN || len == 0) {
@@ -966,7 +976,69 @@ static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 		return -EINVAL;
 	}
 
-	ret = rtw89_fw_h2c_raw_with_hdr(rtwdev, h2c_class, h2c_func, param, len,
+	h2c_func_mask = h2c_func & (~BT_H2C_FUNC_BT2ND);
+	if (rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT)
+		bid = !!(h2c_func & BT_H2C_FUNC_BT2ND);
+
+	if (btc->io_oflld_type != BTC_IO_OFLD_BTC_H2C || btc->cli_h2c_cmd ||
+	    h2c_func_mask == SET_H2C_MACRO ||
+	    (h2c_func_mask == SET_DRV_INFO && buf[0] == CXDRVINFO_TRX) ||
+	    (h2c_func_mask == SET_IOFLD_SCBD && dm->scbd_write_instant) ||
+	    h2c_func_mask == SET_BT_LNA_CONSTRAIN) {
+		h2c_class = BTFC_SET;
+
+		ret = rtw89_fw_h2c_raw_with_hdr(rtwdev, h2c_class, h2c_func,
+						buf, len, false, true);
+
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s():class=%d, bt%d-func=%s, len=%d\n",
+			    __func__, h2c_class, bid,
+			    id_to_h2c(h2c_func_mask), len);
+
+		if (h2c_func_mask == SET_H2C_MACRO) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s():Send H2C-MACRO cnt=%d, len=%d\n",
+				    __func__, btc->hbuf_cnt, btc->hbuf_len);
+			_reset_h2c_macro(btc); /* clear H2C MACRO buffer */
+		}
+
+		if (ret != 0) { /* Send H2C fail */
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s():return by rtw_hal_mac_send_h2c\n",
+				    __func__);
+			btc->fwinfo.cnt_h2c_fail++;
+			return 0;
+		}
+
+		btc->fwinfo.cnt_h2c++;
+	} else { /* Fill H2C MACRO buffer(TLV format) temporarily */
+		if (btc->hbuf_cnt == 0)
+			_reset_h2c_macro(btc);
+
+		/* Type:1 byte, Length:2 Bytes, Data:len bytes */
+		if (btc->hbuf_len + len + 3 >= BTC_H2C_MAXLEN) {
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "[BTC], %s():return by MACRO buf full(%d)\n",
+				    __func__, btc->hbuf_len + len + 3);
+			btc->fwinfo.cnt_h2c_fail++;
+			return 0;
+		}
+
+		btc->hbuf[btc->hbuf_len] = h2c_func;
+		btc->hbuf[btc->hbuf_len + 1] = len & GENMASK(7, 0);
+		btc->hbuf[btc->hbuf_len + 2] = (len & GENMASK(15, 8)) >> 8;
+
+		memcpy(&btc->hbuf[btc->hbuf_len + 3], buf, len);
+		btc->hbuf_len = btc->hbuf_len + len + 3;
+		btc->hbuf_cnt++;
+
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "[BTC], %s():Buffer H2C-MACRO cnt=%d/bt%d-func=%s/len=%d\n",
+			    __func__, btc->hbuf_cnt, bid,
+			    id_to_h2c(h2c_func_mask), len);
+	}
+
+	ret = rtw89_fw_h2c_raw_with_hdr(rtwdev, h2c_class, h2c_func, buf, len,
 					false, true);
 	if (ret)
 		pfwinfo->cnt_h2c_fail++;
@@ -9249,6 +9321,7 @@ static int _show_bt_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 #define CASE_BTC_POLUT_STR(e) case BTC_PLT_## e: return #e
 #define CASE_BTC_REGTYPE_STR(e) case REG_## e: return #e
 #define CASE_BTC_GDBG_STR(e) case BTC_DBG_## e: return #e
+#define CASE_BTC_H2CCMD(e) case SET_##e: return #e
 
 static const char *id_to_polut(u32 id)
 {
@@ -9529,6 +9602,38 @@ static const char *id_to_ant(u32 id)
 	}
 }
 
+static const char *id_to_h2c(u32 id)
+{
+	switch (id) {
+	CASE_BTC_H2CCMD(REPORT_EN);
+	CASE_BTC_H2CCMD(SLOT_TABLE);
+	CASE_BTC_H2CCMD(MREG_TABLE);
+	CASE_BTC_H2CCMD(CX_POLICY);
+	CASE_BTC_H2CCMD(GPIO_DBG);
+	CASE_BTC_H2CCMD(DRV_INFO);
+	CASE_BTC_H2CCMD(DRV_EVENT);
+	CASE_BTC_H2CCMD(BT_WREG_ADDR);
+	CASE_BTC_H2CCMD(BT_WREG_VAL);
+	CASE_BTC_H2CCMD(BT_RREG_ADDR);
+	CASE_BTC_H2CCMD(BT_WL_CH_INFO);
+	CASE_BTC_H2CCMD(BT_INFO_REPORT);
+	CASE_BTC_H2CCMD(BT_IGNORE_WLAN_ACT);
+	CASE_BTC_H2CCMD(BT_TX_PWR);
+	CASE_BTC_H2CCMD(BT_LNA_CONSTRAIN);
+	CASE_BTC_H2CCMD(BT_QUERY_DEV_LIST);
+	CASE_BTC_H2CCMD(BT_QUERY_DEV_INFO);
+	CASE_BTC_H2CCMD(BT_PSD_REPORT);
+	CASE_BTC_H2CCMD(H2C_TEST);
+	CASE_BTC_H2CCMD(IOFLD_RF);
+	CASE_BTC_H2CCMD(IOFLD_BB);
+	CASE_BTC_H2CCMD(IOFLD_MAC);
+	CASE_BTC_H2CCMD(IOFLD_SCBD);
+	CASE_BTC_H2CCMD(H2C_MACRO);
+	default:
+		return "unknown";
+	}
+}
+
 static
 int scnprintf_segment(char *buf, size_t bufsz, const char *prefix, const u16 *data,
 		      u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a928140300b9..cb3a740e4719 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3820,6 +3820,7 @@ struct rtw89_btc_btf_fwinfo {
 };
 
 #define RTW89_BTC_POLICY_MAXLEN 512
+#define BTC_H2C_MAXLENC 2020
 
 struct rtw89_btc {
 	const struct rtw89_btc_ver *ver;
@@ -3839,11 +3840,14 @@ struct rtw89_btc {
 	u32 bt_req_len[RTW89_PHY_NUM];
 
 	u8 policy[RTW89_BTC_POLICY_MAXLEN];
+	u8 hbuf[BTC_H2C_MAXLENC]; /* H2C Macro buffer */
+	u8 hbuf_cnt; /* H2C cmd count in buffer */
 	u8 ant_type;
 	u8 btg_pos;
 	u8 io_oflld_type;
 	u16 policy_len;
 	u16 policy_type;
+	u16 hbuf_len; /* H2C used length, it sshould be <= BTC_H2C_MAXLEN */
 	u32 hubmsg_cnt;
 	bool bt_req_en;
 	bool update_policy_force;
-- 
2.25.1


