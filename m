Return-Path: <linux-wireless+bounces-35005-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HCOAKGg5WlMmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35005-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF6F426979
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B88B23011877
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CA3112BD;
	Mon, 20 Apr 2026 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="v0+zY3jR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85692BDC0F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656536; cv=none; b=HSHJ9MmBmwQQRWXrcGVm0/66BqlZPvBglW4R//g0AgiNvbUVy75D0MHGT2F7u1iOCHpl6SzxC6QJM/iNFCB/RH8v66GbjaKbfAY7tjai0muRCUbHk44nlFDWAeLu/SENZYsi2tXwHCyvV/tV1Wa9fPZ1+SVkDs1AYGqvlkOFh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656536; c=relaxed/simple;
	bh=ZQBIFHggYLqcxZz2V37jIbRcysLSJKwBfsZSUTjvGHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXl+mXKA6FVehSZggFkNPY/VI0QXpEua8VmCSQRqQ0nkJwF2kPbitKCayYoYyNk6gP0OwySEgz61eL7CnL22jLLoAvkqaNpC1IQ2+A9CFXqg2CVjo7FlUkfYBqHxeHVbak4gpmk0jKfEWYYRn/XF5dAQL4bnNY380W+dszHfHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=v0+zY3jR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3gCeW5427742, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656532; bh=YVXwoi9XuO2An/K4Yr1+LVHgbWxtzt9MxQCGUaLbXBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=v0+zY3jRFA6Yu6VhieH4TRufzywBp2IMgX3cMhEZkTeniGvzFl6g8cYrLE6sYaMXW
	 Mha6WL7G4s8HsdgOQoZ06xT5DyPPmAZxhhyym/xzJf6CA8EPVxZQnjNZu47OahClfj
	 Zl49LJg916mJWxnw/rkhn29/qU69gt2cJOmP0jpojVMzSRTSD3/iitYuwETGBl1ubU
	 Xluf+Jlx5LMnrqDLtMIH0ZV934aWqNl+W6SSUZLOq2GvIqRhmhmMJ9wogtvVtGa1Z8
	 OIKsXgpmgUm3uf95qxzG/vW+ZTizajSBOoSHkwkfBnF1vz5iu4Y8Y+7ztm1aFleg8S
	 d3XaZKlecVyzA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3gCeW5427742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:42:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:42:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 12/16] wifi: rtw89: use struct to fill C2H recv ack
Date: Mon, 20 Apr 2026 11:40:47 +0800
Message-ID: <20260420034051.17666-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-35005-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6DF6F426979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chih-Kang Chang <gary.chang@realtek.com>

This C2H packet is used to indicate that FW has received the
corresponding H2C command. No logic is changed.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 18 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/mac.c | 13 ++++++++-----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4d94a7195708..6ef53fcd0cce 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3886,14 +3886,16 @@ struct rtw89_c2h_done_ack {
 #define	RTW89_C2H_SCAN_DONE_ACK_RETURN GENMASK(5, 0)
 #define RTW89_C2H_DONE_ACK_W2_H2C_SEQ GENMASK(31, 24)
 
-#define RTW89_GET_MAC_C2H_REV_ACK_CAT(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
-#define RTW89_GET_MAC_C2H_REV_ACK_CLASS(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 2))
-#define RTW89_GET_MAC_C2H_REV_ACK_FUNC(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
-#define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
+struct rtw89_c2h_rev_ack {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+} __packed;
+
+#define RTW89_C2H_REV_ACK_W2_CAT GENMASK(1, 0)
+#define RTW89_C2H_REV_ACK_W2_CLASS GENMASK(7, 2)
+#define RTW89_C2H_REV_ACK_W2_FUNC GENMASK(15, 8)
+#define RTW89_C2H_REV_ACK_W2_H2C_SEQ GENMASK(23, 16)
 
 struct rtw89_fw_c2h_log_fmt {
 	__le16 signature;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index aac14d768bc3..6ad411149c3e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5406,16 +5406,19 @@ rtw89_mac_c2h_bcn_fltr_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 }
 
 static void
-rtw89_mac_c2h_rec_ack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+rtw89_mac_c2h_rec_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
 {
 	/* N.B. This will run in interrupt context. */
+	const struct rtw89_c2h_rev_ack *c2h = (const void *)skb_c2h->data;
+
+	u8 h2c_cat = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_CAT);
+	u8 h2c_class = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_CLASS);
+	u8 h2c_func = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_FUNC);
+	u8 h2c_seq = le32_get_bits(c2h->w2, RTW89_C2H_REV_ACK_W2_H2C_SEQ);
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW,
 		    "C2H rev ack recv, cat: %d, class: %d, func: %d, seq : %d\n",
-		    RTW89_GET_MAC_C2H_REV_ACK_CAT(c2h->data),
-		    RTW89_GET_MAC_C2H_REV_ACK_CLASS(c2h->data),
-		    RTW89_GET_MAC_C2H_REV_ACK_FUNC(c2h->data),
-		    RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h->data));
+		    h2c_cat, h2c_class, h2c_func, h2c_seq);
 }
 
 static void
-- 
2.25.1


