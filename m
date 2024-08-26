Return-Path: <linux-wireless+bounces-11954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC0C95ECA2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CA6B229C4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1327404B;
	Mon, 26 Aug 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EV+frhXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617EEAFA
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663102; cv=none; b=FhCU/yjtHlEkeJvvLTo0AR5ssk2ARm/zQ+bSe8B9dzGCh/6Y61srQxB4v/bNQx3qFHQrMKlNrkZlAExlqMcDWBWpOAy2BbqrVFvn6NwIh+Hqr0HSbR+UiDRAfNVDpi2aya4cJ5yeiNW41Iqf6c9H7JnrjYN1fYXQxGLSgbms8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663102; c=relaxed/simple;
	bh=vP7bwZKK2PySTNCrXkB5er0ljc/YMe826ml6tPK5qp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFtZfLFEQvErzWUvQWW9/G05nXJtl+lPDmjnWIVYut6zRir7qQv123anPZmkcnW6ULotCJxe49I/jpm2Gq84pS0/NHY0RAwjZMVrsVTtLMFoEAZZGWCWSzNb1osOjmRQ+MfR3MFqLywek9J1GWq0/i+kLFy+YPpDS4JrteSbRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EV+frhXv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47Q94v2hA3828661, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724663097; bh=vP7bwZKK2PySTNCrXkB5er0ljc/YMe826ml6tPK5qp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EV+frhXvo7BPADe/+UwWxNsM5omfbpyJFkT5hjbbp3UVEBdmhXgeJm5qxBcXIm96v
	 LSm4zNFLhwye0U7fTpJLbpW9V1ZCC2jj5278WULED/A915HwY2hMYhjLWPpbaCJ7c2
	 vuiU5AhoXOlOUTgLsYV29/GNYo2iuvLITN8KnlRjo4UvB8yvuEjx0lvG4/r0R86XyJ
	 C2uTJqY1Unr/eqxaPm5BBJQv+t5Pzp5DU8wm66oKw2MQsrNgItcMLMI7rQUzMG3S7i
	 W1OhXTPaADI/X5Q//0KsUSH2ZkbMBZFEYTqowlCwaUr3CoOlchQrU6WcL9g+3DZqbX
	 WXaK34OXYnO6Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47Q94v2hA3828661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 17:04:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 17:04:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Aug
 2024 17:04:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: wow: add wait for H2C of FW-IPS mode
Date: Mon, 26 Aug 2024 17:04:37 +0800
Message-ID: <20240826090439.17242-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826090439.17242-1-pkshih@realtek.com>
References: <20240826090439.17242-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

The C2H packet of FW-IPS mode is not handled by driver in the suspend
flow, and lead to WoWLAN firmware fail to enter PS mode and even some
SER happen. So add wait function for H2C of FW-IPS mode to check driver
handle the C2H packet before disabling interrupt and make the net-detect
function work fine.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  1 +
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 13 ++-----------
 drivers/net/wireless/realtek/rtw89/fw.h   | 16 +++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac.c  | 13 +++++++++++++
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index df34f613c736..80cb3d1080f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4316,6 +4316,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtw89_init_wait(&rtwdev->mcc.wait);
 	rtw89_init_wait(&rtwdev->mac.fw_ofld_wait);
 	rtw89_init_wait(&rtwdev->wow.wait);
+	rtw89_init_wait(&rtwdev->mac.ps_wait);
 
 	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
 	INIT_WORK(&rtwdev->ips_work, rtw89_ips_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a9c91f794139..ee7f3e07bb29 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4395,6 +4395,8 @@ struct rtw89_mac_info {
 
 	/* see RTW89_FW_OFLD_WAIT_COND series for wait condition */
 	struct rtw89_wait_info fw_ofld_wait;
+	/* see RTW89_PS_WAIT_COND series for wait condition */
+	struct rtw89_wait_info ps_wait;
 };
 
 enum rtw89_fwdl_check_type {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2638003e9f6e..7f2dc4bbd99a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7179,10 +7179,10 @@ int rtw89_fw_h2c_wow_gtk_ofld(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		       bool enable)
 {
+	struct rtw89_wait_info *wait = &rtwdev->mac.ps_wait;
 	struct rtw89_h2c_fwips *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
-	int ret;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
@@ -7201,16 +7201,7 @@ int rtw89_fw_h2c_fwips(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      H2C_FUNC_IPS_CFG, 0, 1,
 			      len);
 
-	ret = rtw89_h2c_tx(rtwdev, skb, false);
-	if (ret) {
-		rtw89_err(rtwdev, "failed to send h2c\n");
-		goto fail;
-	}
-	return 0;
-fail:
-	dev_kfree_skb_any(skb);
-
-	return ret;
+	return rtw89_h2c_tx_and_wait(rtwdev, skb, wait, RTW89_PS_WAIT_COND_IPS_CFG);
 }
 
 int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 147358772560..997843c9ccb2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4023,9 +4023,19 @@ enum rtw89_wow_h2c_func {
 
 /* CLASS 2 - PS */
 #define H2C_CL_MAC_PS			0x2
-#define H2C_FUNC_MAC_LPS_PARM		0x0
-#define H2C_FUNC_P2P_ACT		0x1
-#define H2C_FUNC_IPS_CFG		0x3
+enum rtw89_ps_h2c_func {
+	H2C_FUNC_MAC_LPS_PARM		= 0x0,
+	H2C_FUNC_P2P_ACT		= 0x1,
+	H2C_FUNC_IPS_CFG		= 0x3,
+
+	NUM_OF_RTW89_PS_H2C_FUNC,
+};
+
+#define RTW89_PS_WAIT_COND(tag, func) \
+	((tag) * NUM_OF_RTW89_PS_H2C_FUNC + (func))
+
+#define RTW89_PS_WAIT_COND_IPS_CFG \
+	RTW89_PS_WAIT_COND(0 /* don't care */, H2C_FUNC_IPS_CFG)
 
 /* CLASS 3 - FW download */
 #define H2C_CL_MAC_FWDL		0x3
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f336362ad45e..c70a23a763b0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4887,6 +4887,7 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 {
 	/* N.B. This will run in interrupt context. */
 	struct rtw89_wait_info *fw_ofld_wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_wait_info *ps_wait = &rtwdev->mac.ps_wait;
 	const struct rtw89_c2h_done_ack *c2h =
 		(const struct rtw89_c2h_done_ack *)skb_c2h->data;
 	u8 h2c_cat = le32_get_bits(c2h->w2, RTW89_C2H_DONE_ACK_W2_CAT);
@@ -4907,6 +4908,18 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 	switch (h2c_class) {
 	default:
 		return;
+	case H2C_CL_MAC_PS:
+		switch (h2c_func) {
+		default:
+			return;
+		case H2C_FUNC_IPS_CFG:
+			cond = RTW89_PS_WAIT_COND_IPS_CFG;
+			break;
+		}
+
+		data.err = !!h2c_return;
+		rtw89_complete_cond(ps_wait, cond, &data);
+		return;
 	case H2C_CL_MAC_FW_OFLD:
 		switch (h2c_func) {
 		default:
-- 
2.25.1


