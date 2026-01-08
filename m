Return-Path: <linux-wireless+bounces-30550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C2D03F2E
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB6E3048B8C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84B497B34;
	Thu,  8 Jan 2026 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IqkM23sU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11177497B0C
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873837; cv=none; b=fr1c3hHmKPJrXfL51QCFl2jnyKs+yQpmzVBtBchhmrSKlVaLMck3IvpC5teS0ODaWAppskt1i6QKd5W64/MYdWSqmi2RepdXqOB1DqlW3ZLohvyGgMEel2HH8iZP4EETChjIEgDPlVPN1njdQ9tJwjIXlUY007dbn09KG2dY5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873837; c=relaxed/simple;
	bh=eA6/hiIs4dL35Y/zssj0Ql4K3tbniywAkPvOciKyxC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seQqTPiGo4aG2IhOBIzEo/rJ4vzn/ySLKQel/SiXRN9wP/sCoAhSMtdOujeX24vsy72ao84uqgWbPG4YpTrDq9kYnEVz2yH0Pu8rK9DLGDzK2S6bgV1cbkTnLNrlLtQGBmd4OZ1dHOcIaBStBQzqEfOk/CHNIqDgSNaS/Hu29mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IqkM23sU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3pl66970633, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873831; bh=OLoBJvefQ4vEn0Y4EvSuAi2HsHMbTyzvz2dXv6UkJJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IqkM23sUXFEDk3u6s5oBiDRJD9/nylvGRfQeRlZVBbtoGAo6Y4LcLzKJPKPlz9VRX
	 PWL0bOvZ6b1BlkgDFiNaoCe114Sc8jddu4BCUjDj2QmvHAYvKczo0OmO4RKzq+vq1f
	 F2eXz3Xqz61b+wChd4mxalOZVooIaX8n5t99tWtQre6xnVLkmJJ2J+98xwmlgZheOq
	 cbAOwfngjkNBXjmladEPhJL7Q/UpGZHLfrzMiJ7p1olKESv8caOtxR1qyx+QmBCxzW
	 ckhMdGwNEBBu3PsVsw2/DktezHCzl7/pvx1wOvmKaU0hxubtn7c0/Dy4SZf4dF83Fu
	 eCiByT5/t7LGA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3pl66970633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:52 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:51 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 06/13] wifi: rtw89: mac: set quota 13 for PLE SNRPT
Date: Thu, 8 Jan 2026 20:03:13 +0800
Message-ID: <20260108120320.2217402-7-pkshih@realtek.com>
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

The RTL8922D has additional quota 13 of SNRPT for PLE (payload engine).
Set value to the quota according to predefined tables.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 5 +++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 06538122c57a..aff9855f184a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -331,6 +331,11 @@ static void ple_quota_cfg_be(struct rtw89_dev *rtwdev,
 	SET_QUOTA(cpu_io, PLE, 10);
 	SET_QUOTA(tx_rpt, PLE, 11);
 	SET_QUOTA(h2d, PLE, 12);
+
+	if (rtwdev->chip->chip_id == RTL8922A)
+		return;
+
+	SET_QUOTA(snrpt, PLE, 13);
 }
 
 static void rtw89_mac_hci_func_en_be(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index de36cf5ef1a1..9ac1c169d25c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5514,6 +5514,10 @@
 #define B_BE_PLE_Q12_MAX_SIZE_MASK GENMASK(27, 16)
 #define B_BE_PLE_Q12_MIN_SIZE_MASK GENMASK(11, 0)
 
+#define R_BE_PLE_QTA13_CFG 0x9074
+#define B_BE_PLE_Q13_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_BE_PLE_Q13_MIN_SIZE_MASK GENMASK(11, 0)
+
 #define R_BE_PLE_ERRFLAG1_IMR 0x90C0
 #define B_BE_PLE_SRCHPG_PGOFST_IMR BIT(26)
 #define B_BE_PLE_SRCHPG_STRPG_IMR BIT(25)
-- 
2.25.1


