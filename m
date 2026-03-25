Return-Path: <linux-wireless+bounces-33810-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CzwKeuNw2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33810-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:25:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6530320A92
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05B223063204
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8BA365A1D;
	Wed, 25 Mar 2026 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rz1S05VE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AF27F18B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423327; cv=none; b=NrzhvNHbR2O+vTxE86xD4eTfH0DcSoWoe7yl5b4jbiZyFX6gBqICe7ZKrq5AmiCG9pqHnwNyx4V3ILZtZwqCOxCdH+BhS9NyRB1j8HkvbgGiRPSAYVe8CPTa76tdb6yR2s5XjxfsSvA6GjsjC9Tb94k/n7O+7m9ts0ad2X8hwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423327; c=relaxed/simple;
	bh=Dz6FEOvxD3a7NRHiTz3WXNC/G+aa+fsOw+6i1hYJams=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djfGGN02SOU4n5iJL+1Q9zFil9ofCwavbtdiovdSueqKgxgu8aatu0IvnWv2yGpVptXBXiwzg9FZrpzX1UyzYqS25B4focWiVFAAtmISgF5fVgTdH7qfq8kp9tfHRsMeDACQdyOr4PC6ChjixWOwSvV+DzwBKl0m46PWJ2ByITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rz1S05VE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7M2Av82939407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423322; bh=HdsHrVkCwdVQQhjDjBjVb4sSx+t0OwpP3LmuGVyvE+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rz1S05VEr6HbMEKQw+WH7NHw1DAhtgkTwkbpvreCuLVYZDgkrCaoPOm08xy1jluCa
	 6oQXVQia++RiuhnPj1KnB5q0XiOA89vJoAzQyEr9Auqhm6UeCdEreHetER9ycf1q9J
	 pfWRIi13LK2ToCYLEsobmmoV5pVpLnEPRPZteuqUMkYJMkbx5Ruxr2umNojqmjrBXo
	 CMUl3VcGhEVH/cEPQ7qVq6c+O9wBQNEcEnRq64Zs/vUqeYzOqQ3sTHN5GHH3tch+0H
	 R+s3fo8HqN7If10M3SI07/eoB7d+mXf82FZDUdQJLdmFvuYo8lJtXrNNfSLW2wRBrW
	 oFuSwIOlMkfeA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7M2Av82939407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:22:02 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:21:54 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:21:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/8] wifi: rtw89: wow: use struct style to fill WOW wakeup control H2C command
Date: Wed, 25 Mar 2026 15:21:23 +0800
Message-ID: <20260325072130.41751-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325072130.41751-1-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33810-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6530320A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chin-Yen Lee <timlee@realtek.com>

The WOW wakeup control command is used to tell firmware the content
of wakeup feature. Use struct instead of macros to fill the data.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 21 ++++++----
 drivers/net/wireless/realtek/rtw89/fw.h | 56 ++++++-------------------
 2 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 45d8c5e70084..701cea9a771e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -9705,38 +9705,43 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtw
 	return ret;
 }
 
-#define H2C_WAKEUP_CTRL_LEN 4
 int rtw89_fw_h2c_wow_wakeup_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 bool enable)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	struct rtw89_h2c_wow_wakeup_ctrl *h2c;
 	struct sk_buff *skb;
+	u32 len = sizeof(*h2c);
 	u8 macid = rtwvif_link->mac_id;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_WAKEUP_CTRL_LEN);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for wakeup ctrl\n");
 		return -ENOMEM;
 	}
 
-	skb_put(skb, H2C_WAKEUP_CTRL_LEN);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_wow_wakeup_ctrl *)skb->data;
 
 	if (rtw_wow->pattern_cnt)
-		RTW89_SET_WOW_WAKEUP_CTRL_PATTERN_MATCH_ENABLE(skb->data, enable);
+		h2c->w0 |= le32_encode_bits(enable,
+					    RTW89_H2C_WOW_WAKEUP_CTRL_W0_PATTERN_MATCH_ENABLE);
 	if (test_bit(RTW89_WOW_FLAG_EN_MAGIC_PKT, rtw_wow->flags))
-		RTW89_SET_WOW_WAKEUP_CTRL_MAGIC_ENABLE(skb->data, enable);
+		h2c->w0 |= le32_encode_bits(enable,
+					    RTW89_H2C_WOW_WAKEUP_CTRL_W0_MAGIC_ENABLE);
 	if (test_bit(RTW89_WOW_FLAG_EN_DISCONNECT, rtw_wow->flags))
-		RTW89_SET_WOW_WAKEUP_CTRL_DEAUTH_ENABLE(skb->data, enable);
+		h2c->w0 |= le32_encode_bits(enable,
+					    RTW89_H2C_WOW_WAKEUP_CTRL_W0_DEAUTH_ENABLE);
 
-	RTW89_SET_WOW_WAKEUP_CTRL_MAC_ID(skb->data, macid);
+	h2c->w0 |= le32_encode_bits(macid, RTW89_H2C_WOW_WAKEUP_CTRL_W0_MAC_ID);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_WOW,
 			      H2C_FUNC_WAKEUP_CTRL, 0, 1,
-			      H2C_WAKEUP_CTRL_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 57e3b464c0a2..cf86fade84a2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2219,50 +2219,20 @@ struct rtw89_h2c_cfg_nlo {
 #define RTW89_H2C_NLO_W0_IGNORE_CIPHER BIT(2)
 #define RTW89_H2C_NLO_W0_MACID GENMASK(31, 24)
 
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_PATTERN_MATCH_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(0));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_MAGIC_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(1));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_HW_UNICAST_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(2));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_FW_UNICAST_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(3));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_DEAUTH_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(4));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_REKEYP_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(5));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_EAP_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(6));
-}
-
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_ALL_DATA_ENABLE(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, BIT(7));
-}
+struct rtw89_h2c_wow_wakeup_ctrl {
+	__le32 w0;
+} __packed;
 
-static inline void RTW89_SET_WOW_WAKEUP_CTRL_MAC_ID(void *h2c, u32 val)
-{
-	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 24));
-}
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_PATTERN_MATCH_ENABLE BIT(0)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_MAGIC_ENABLE BIT(1)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_HW_UNICAST_ENABLE BIT(2)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_FW_UNICAST_ENABLE BIT(3)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_DEAUTH_ENABLE BIT(4)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_REKEYP_ENABLE BIT(5)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_EAP_ENABLE BIT(6)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_ALL_DATA_ENABLE BIT(7)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_MAC_ID_EXT GENMASK(23, 16)
+#define RTW89_H2C_WOW_WAKEUP_CTRL_W0_MAC_ID GENMASK(31, 24)
 
 struct rtw89_h2c_wow_cam_update {
 	__le32 w0;
-- 
2.25.1


