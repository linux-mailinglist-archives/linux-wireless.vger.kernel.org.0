Return-Path: <linux-wireless+bounces-4953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6A880DC2
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D77A281A32
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2013FE2B;
	Wed, 20 Mar 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TW0Iflep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F353FE27
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924589; cv=none; b=IFJhZ1kqit4WkXM/HiNXcejIAEUm4mUfNCzAO3TWbtHzAUrNA5tNHzPMobsk1Hc2GRa3RE2FM/05BCPO8yrO4QjM5ZusJ7lzMa8VXa1UhjT6o7MTFyUXRrAkQgP00bhnSTQIwxFPe2TPSzGMKyK2Y+Az5e5IVZkZ/hc+n25bid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924589; c=relaxed/simple;
	bh=zvPFpvqYZD8vg3PXOoCtGQM5cwZqfKzESC/ZEm9ZLdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oj/wzk4V4HHc4eaav/2G6eP+Df2RJZa5c49Tvlb9DRm4IspW2TxQ1qRYmPOPjNYeY9UzeN2ksHsqEiLe5TRerWbjEghm+Yw5eK6WOyj/qKDd+SOfO8j94crX3Ufq0zpHx9f0BcutEpQkjVDp4VfwPMFf91Xbasm/HN32Jx8dm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TW0Iflep; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 8A81E673D1
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:43:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1791:0:640:98f4:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 4E219608DE;
	Wed, 20 Mar 2024 11:43:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PhAfFV1OduQ0-YHJNSitx;
	Wed, 20 Mar 2024 11:43:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710924206; bh=JTC22T6aH2M2yDh+ektwg8ZL1CoSoiWy+e9cJivbNSA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=TW0Iflep7EzMV58eBzGoB4V9V9kFcF7sanN2raP6xd+fL3iggTLeSqw5eCDS07LyA
	 X4bq/pHGOEO5zTcJsmufgl6to5om6mzttwBowmqrg0A4DMxWenuR4pzHD/8X7ju0DG
	 3TpDKBq2TQjyOkjfkO8uZA1VCE8YSiwHCRp201Vc=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtlwifi: drop WMM stubs from rtl8192cu
Date: Wed, 20 Mar 2024 11:43:23 +0300
Message-ID: <20240320084324.109506-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since WMM support was never actually implemented and related TODO is
more than 13 years old, it might be reasonable to remove all of the
WMM stubs from rtl8192cu and simplify related code. Minor comment
style adjustments suggested by checkpatch.pl, compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 165 +++++-------------
 1 file changed, 48 insertions(+), 117 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 4217c9a08d01..76bedfec55a3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -489,7 +489,6 @@ static int _rtl92cu_init_power_on(struct ieee80211_hw *hw)
 }
 
 static void _rtl92cu_init_queue_reserved_page(struct ieee80211_hw *hw,
-					      bool wmm_enable,
 					      u8 out_ep_num,
 					      u8 queue_sel)
 {
@@ -505,66 +504,39 @@ static void _rtl92cu_init_queue_reserved_page(struct ieee80211_hw *hw,
 	u8 value8;
 	u32 txqpagenum, txqpageunit, txqremaininpage;
 
-	if (!wmm_enable) {
-		numpubq = (ischipn) ? CHIP_B_PAGE_NUM_PUBQ :
-			  CHIP_A_PAGE_NUM_PUBQ;
-		txqpagenum = TX_TOTAL_PAGE_NUMBER - numpubq;
-
-		txqpageunit = txqpagenum / outepnum;
-		txqremaininpage = txqpagenum % outepnum;
-		if (queue_sel & TX_SELE_HQ)
-			numhq = txqpageunit;
-		if (queue_sel & TX_SELE_LQ)
-			numlq = txqpageunit;
-		/* HIGH priority queue always present in the configuration of
-		 * 2 out-ep. Remainder pages have assigned to High queue */
-		if (outepnum > 1 && txqremaininpage)
-			numhq += txqremaininpage;
-		/* NOTE: This step done before writing REG_RQPN. */
-		if (ischipn) {
-			if (queue_sel & TX_SELE_NQ)
-				numnq = txqpageunit;
-			value8 = (u8)_NPQ(numnq);
-			rtl_write_byte(rtlpriv,  REG_RQPN_NPQ, value8);
-		}
-	} else {
-		/* for WMM ,number of out-ep must more than or equal to 2! */
-		numpubq = ischipn ? WMM_CHIP_B_PAGE_NUM_PUBQ :
-			  WMM_CHIP_A_PAGE_NUM_PUBQ;
-		if (queue_sel & TX_SELE_HQ) {
-			numhq = ischipn ? WMM_CHIP_B_PAGE_NUM_HPQ :
-				WMM_CHIP_A_PAGE_NUM_HPQ;
-		}
-		if (queue_sel & TX_SELE_LQ) {
-			numlq = ischipn ? WMM_CHIP_B_PAGE_NUM_LPQ :
-				WMM_CHIP_A_PAGE_NUM_LPQ;
-		}
-		/* NOTE: This step done before writing REG_RQPN. */
-		if (ischipn) {
-			if (queue_sel & TX_SELE_NQ)
-				numnq = WMM_CHIP_B_PAGE_NUM_NPQ;
-			value8 = (u8)_NPQ(numnq);
-			rtl_write_byte(rtlpriv, REG_RQPN_NPQ, value8);
-		}
+	numpubq = (ischipn) ? CHIP_B_PAGE_NUM_PUBQ :
+		CHIP_A_PAGE_NUM_PUBQ;
+	txqpagenum = TX_TOTAL_PAGE_NUMBER - numpubq;
+
+	txqpageunit = txqpagenum / outepnum;
+	txqremaininpage = txqpagenum % outepnum;
+	if (queue_sel & TX_SELE_HQ)
+		numhq = txqpageunit;
+	if (queue_sel & TX_SELE_LQ)
+		numlq = txqpageunit;
+	/* HIGH priority queue always present in the configuration of
+	 * 2 out-ep. Remainder pages have assigned to High queue.
+	 */
+	if (outepnum > 1 && txqremaininpage)
+		numhq += txqremaininpage;
+	/* NOTE: This step done before writing REG_RQPN. */
+	if (ischipn) {
+		if (queue_sel & TX_SELE_NQ)
+			numnq = txqpageunit;
+		value8 = (u8)_NPQ(numnq);
+		rtl_write_byte(rtlpriv,  REG_RQPN_NPQ, value8);
 	}
 	/* TX DMA */
 	value32 = _HPQ(numhq) | _LPQ(numlq) | _PUBQ(numpubq) | LD_RQPN;
 	rtl_write_dword(rtlpriv, REG_RQPN, value32);
 }
 
-static void _rtl92c_init_trx_buffer(struct ieee80211_hw *hw, bool wmm_enable)
+static void _rtl92c_init_trx_buffer(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8	txpktbuf_bndy;
+	u8	txpktbuf_bndy = TX_PAGE_BOUNDARY;
 	u8	value8;
 
-	if (!wmm_enable)
-		txpktbuf_bndy = TX_PAGE_BOUNDARY;
-	else /* for WMM */
-		txpktbuf_bndy = (IS_NORMAL_CHIP(rtlhal->version))
-						? WMM_CHIP_B_TX_PAGE_BOUNDARY
-						: WMM_CHIP_A_TX_PAGE_BOUNDARY;
 	rtl_write_byte(rtlpriv, REG_TXPKTBUF_BCNQ_BDNY, txpktbuf_bndy);
 	rtl_write_byte(rtlpriv, REG_TXPKTBUF_MGQ_BDNY, txpktbuf_bndy);
 	rtl_write_byte(rtlpriv, REG_TXPKTBUF_WMAC_LBK_BF_HD, txpktbuf_bndy);
@@ -589,7 +561,6 @@ static void _rtl92c_init_chipn_reg_priority(struct ieee80211_hw *hw, u16 beq,
 }
 
 static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
-						    bool wmm_enable,
 						    u8 queue_sel)
 {
 	u16 value;
@@ -614,7 +585,6 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 }
 
 static void _rtl92cu_init_chipn_two_out_ep_priority(struct ieee80211_hw *hw,
-						     bool wmm_enable,
 						     u8 queue_sel)
 {
 	u16 beq, bkq, viq, voq, mgtq, hiq;
@@ -638,67 +608,47 @@ static void _rtl92cu_init_chipn_two_out_ep_priority(struct ieee80211_hw *hw,
 		valuelow = QUEUE_NORMAL;
 		break;
 	}
-	if (!wmm_enable) {
-		beq = valuelow;
-		bkq = valuelow;
-		viq = valuehi;
-		voq = valuehi;
-		mgtq = valuehi;
-		hiq = valuehi;
-	} else {/* for WMM ,CONFIG_OUT_EP_WIFI_MODE */
-		beq = valuehi;
-		bkq = valuelow;
-		viq = valuelow;
-		voq = valuehi;
-		mgtq = valuehi;
-		hiq = valuehi;
-	}
+
+	beq = valuelow;
+	bkq = valuelow;
+	viq = valuehi;
+	voq = valuehi;
+	mgtq = valuehi;
+	hiq = valuehi;
+
 	_rtl92c_init_chipn_reg_priority(hw, beq, bkq, viq, voq, mgtq, hiq);
 	pr_info("Tx queue select: 0x%02x\n", queue_sel);
 }
 
 static void _rtl92cu_init_chipn_three_out_ep_priority(struct ieee80211_hw *hw,
-						      bool wmm_enable,
 						      u8 queue_sel)
 {
 	u16 beq, bkq, viq, voq, mgtq, hiq;
 
-	if (!wmm_enable) { /* typical setting */
-		beq	= QUEUE_LOW;
-		bkq	= QUEUE_LOW;
-		viq	= QUEUE_NORMAL;
-		voq	= QUEUE_HIGH;
-		mgtq	= QUEUE_HIGH;
-		hiq	= QUEUE_HIGH;
-	} else { /* for WMM */
-		beq	= QUEUE_LOW;
-		bkq	= QUEUE_NORMAL;
-		viq	= QUEUE_NORMAL;
-		voq	= QUEUE_HIGH;
-		mgtq	= QUEUE_HIGH;
-		hiq	= QUEUE_HIGH;
-	}
+	beq	= QUEUE_LOW;
+	bkq	= QUEUE_LOW;
+	viq	= QUEUE_NORMAL;
+	voq	= QUEUE_HIGH;
+	mgtq	= QUEUE_HIGH;
+	hiq	= QUEUE_HIGH;
+
 	_rtl92c_init_chipn_reg_priority(hw, beq, bkq, viq, voq, mgtq, hiq);
 	pr_info("Tx queue select :0x%02x..\n", queue_sel);
 }
 
 static void _rtl92cu_init_chipn_queue_priority(struct ieee80211_hw *hw,
-					       bool wmm_enable,
 					       u8 out_ep_num,
 					       u8 queue_sel)
 {
 	switch (out_ep_num) {
 	case 1:
-		_rtl92cu_init_chipn_one_out_ep_priority(hw, wmm_enable,
-							queue_sel);
+		_rtl92cu_init_chipn_one_out_ep_priority(hw, queue_sel);
 		break;
 	case 2:
-		_rtl92cu_init_chipn_two_out_ep_priority(hw, wmm_enable,
-							queue_sel);
+		_rtl92cu_init_chipn_two_out_ep_priority(hw, queue_sel);
 		break;
 	case 3:
-		_rtl92cu_init_chipn_three_out_ep_priority(hw, wmm_enable,
-							  queue_sel);
+		_rtl92cu_init_chipn_three_out_ep_priority(hw, queue_sel);
 		break;
 	default:
 		WARN_ON(1); /* Shall not reach here! */
@@ -707,7 +657,6 @@ static void _rtl92cu_init_chipn_queue_priority(struct ieee80211_hw *hw,
 }
 
 static void _rtl92cu_init_chipt_queue_priority(struct ieee80211_hw *hw,
-					       bool wmm_enable,
 					       u8 out_ep_num,
 					       u8 queue_sel)
 {
@@ -716,12 +665,7 @@ static void _rtl92cu_init_chipt_queue_priority(struct ieee80211_hw *hw,
 
 	switch (out_ep_num) {
 	case 2:	/* (TX_SELE_HQ|TX_SELE_LQ) */
-		if (!wmm_enable) /* typical setting */
-			hq_sele =  HQSEL_VOQ | HQSEL_VIQ | HQSEL_MGTQ |
-				   HQSEL_HIQ;
-		else	/* for WMM */
-			hq_sele = HQSEL_VOQ | HQSEL_BEQ | HQSEL_MGTQ |
-				  HQSEL_HIQ;
+		hq_sele =  HQSEL_VOQ | HQSEL_VIQ | HQSEL_MGTQ |	HQSEL_HIQ;
 		break;
 	case 1:
 		if (TX_SELE_LQ == queue_sel) {
@@ -742,18 +686,15 @@ static void _rtl92cu_init_chipt_queue_priority(struct ieee80211_hw *hw,
 }
 
 static void _rtl92cu_init_queue_priority(struct ieee80211_hw *hw,
-						bool wmm_enable,
 						u8 out_ep_num,
 						u8 queue_sel)
 {
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
 	if (IS_NORMAL_CHIP(rtlhal->version))
-		_rtl92cu_init_chipn_queue_priority(hw, wmm_enable, out_ep_num,
-						   queue_sel);
+		_rtl92cu_init_chipn_queue_priority(hw, out_ep_num, queue_sel);
 	else
-		_rtl92cu_init_chipt_queue_priority(hw, wmm_enable, out_ep_num,
-						   queue_sel);
+		_rtl92cu_init_chipt_queue_priority(hw, out_ep_num, queue_sel);
 }
 
 static void _rtl92cu_init_wmac_setting(struct ieee80211_hw *hw)
@@ -810,8 +751,7 @@ static int _rtl92cu_init_mac(struct ieee80211_hw *hw)
 	struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
 	struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
 	int err = 0;
-	u32	boundary = 0;
-	u8 wmm_enable = false; /* TODO */
+	u32 boundary = TX_PAGE_BOUNDARY;
 	u8 out_ep_nums = rtlusb->out_ep_nums;
 	u8 queue_sel = rtlusb->out_queue_sel;
 
@@ -821,22 +761,13 @@ static int _rtl92cu_init_mac(struct ieee80211_hw *hw)
 		pr_err("Failed to init power on!\n");
 		return err;
 	}
-	if (!wmm_enable) {
-		boundary = TX_PAGE_BOUNDARY;
-	} else { /* for WMM */
-		boundary = (IS_NORMAL_CHIP(rtlhal->version))
-					? WMM_CHIP_B_TX_PAGE_BOUNDARY
-					: WMM_CHIP_A_TX_PAGE_BOUNDARY;
-	}
 	if (!rtl92c_init_llt_table(hw, boundary)) {
 		pr_err("Failed to init LLT Table!\n");
 		return -EINVAL;
 	}
-	_rtl92cu_init_queue_reserved_page(hw, wmm_enable, out_ep_nums,
-					  queue_sel);
-	_rtl92c_init_trx_buffer(hw, wmm_enable);
-	_rtl92cu_init_queue_priority(hw, wmm_enable, out_ep_nums,
-				     queue_sel);
+	_rtl92cu_init_queue_reserved_page(hw, out_ep_nums, queue_sel);
+	_rtl92c_init_trx_buffer(hw);
+	_rtl92cu_init_queue_priority(hw, out_ep_nums, queue_sel);
 	/* Get Rx PHY status in order to report RSSI and others. */
 	rtl92c_init_driver_info_size(hw, RTL92C_DRIVER_INFO_SIZE);
 	rtl92c_init_interrupt(hw);
-- 
2.44.0


