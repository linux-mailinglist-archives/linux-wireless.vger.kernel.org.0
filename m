Return-Path: <linux-wireless+bounces-30553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF796D045B8
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FEAA323C565
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96C498494;
	Thu,  8 Jan 2026 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="edovtRdG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618B497B31
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873852; cv=none; b=jbTC4kfx1npxgtNAjy4Cms21P7n9DyZB9zIbeqN/9d0VjiN1DxOBTDamRBY8dH/WMKMIIDnEcYoSoQrB/qxVqxt1urn1qQ10MhZO2FUzrOfJfOXDFkQPgJrFMjgGwTRXlDzbHi8L4JLetESwUh5rrNXNyXbCtaypDCU0zwm4LPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873852; c=relaxed/simple;
	bh=9FvPWRf6rcNUYskzA6y9BBJ4JOFa63J2Ekw0rjQsn5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8K3DRHkwOg4ZmaaqUzF3XCJR9fzMhSG2Ui9T7caSoDSXsRR/0qzOX0Jvr3V73PmyKEfzGhKu1BRW56fo9jUYXTLCPAGCTfW9TPwfMH8flePHXSf6yXmvJ4CUPTJTHbI3uuQMlbLVwVGlR+kn9sczz4oXddtLdlRV0yfH0W1UXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=edovtRdG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C47rdC970677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873847; bh=x+Z9V/aAmc9vZnUa9DdbhpYutIkzf0i5RA2ILmiTwV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=edovtRdGVpZ6LU6X18tnQqI1rcOG62i6asY9pCwprgB4J0/62UJDVKLRc+64nPsa/
	 K0JXOCuFyrwfPl8F3zB6Fatmivn4guPeBrcpUa8GyeGveW2nENcTB8Oxli2z6/L/a2
	 AKLhFL59KoDXyYRGv+A/GajH2qQgfg1RgYRLFJcES5ot9Fp5iog6VhwdRTwulSYcM1
	 xOmnHpDznunfUNjo26NpqZZhN6ETkr5opoXmzxKhU+rZgnZUZ2k6vNDVIo1frA1p3p
	 oz/cSIzIMXeEgu35TJO2eh9cMsbwD/XowqzcJfNv4lnXHdRW08a6c770jW+UKgwkl/
	 uAAi16gKtOAwA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C47rdC970677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:04:07 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:07 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:04:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 09/13] wifi: rtw89: mac: define preload_init for generations
Date: Thu, 8 Jan 2026 20:03:16 +0800
Message-ID: <20260108120320.2217402-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The preload_init is to define preload size from memory to transmitting
buffer. The different generations should call its callback respectively
but suddenly it is missed. However, the register definitions of WiFi 6/7
are the same, things are well. For the coming RTL8922D, settings are
different, so abstract it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 8 +++++---
 drivers/net/wireless/realtek/rtw89/mac.h    | 2 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a008a1a02fe9..5bf81ef0313b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2283,8 +2283,8 @@ int rtw89_mac_dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 	return ret;
 }
 
-static int preload_init_set(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
-			    enum rtw89_qta_mode mode)
+static int preload_init_set_ax(struct rtw89_dev *rtwdev, u8 mac_idx,
+			       enum rtw89_qta_mode mode)
 {
 	u32 reg, max_preld_size, min_rsvd_size;
 
@@ -2312,13 +2312,14 @@ static bool is_qta_poh(struct rtw89_dev *rtwdev)
 int rtw89_mac_preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
 			   enum rtw89_qta_mode mode)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev) ||
 	    !is_qta_poh(rtwdev))
 		return 0;
 
-	return preload_init_set(rtwdev, mac_idx, mode);
+	return mac->preload_init(rtwdev, mac_idx, mode);
 }
 
 static bool dle_is_txq_empty(struct rtw89_dev *rtwdev)
@@ -7287,6 +7288,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.sys_init = sys_init_ax,
 	.trx_init = trx_init_ax,
+	.preload_init = preload_init_set_ax,
 	.err_imr_ctrl = err_imr_ctrl_ax,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index fd1e3a395891..7254a653c220 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1037,6 +1037,8 @@ struct rtw89_mac_gen_def {
 			    enum rtw89_mac_hwmod_sel sel);
 	int (*sys_init)(struct rtw89_dev *rtwdev);
 	int (*trx_init)(struct rtw89_dev *rtwdev);
+	int (*preload_init)(struct rtw89_dev *rtwdev, u8 mac_idx,
+			    enum rtw89_qta_mode mode);
 	void (*err_imr_ctrl)(struct rtw89_dev *rtwdev, bool en);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 5df243cf448e..475d941d41a7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2832,6 +2832,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
 	.trx_init = trx_init_be,
+	.preload_init = preload_init_be,
 	.err_imr_ctrl = err_imr_ctrl_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
-- 
2.25.1


