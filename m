Return-Path: <linux-wireless+bounces-6720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22758AE5BA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DC41C21294
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451AB84A54;
	Tue, 23 Apr 2024 12:13:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B31537F7
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874400; cv=none; b=pSMEwaLEa4L6dvhTM19VltV1wsB5o18F1wdSjRJJM1CjlOe+ddITLWwgX9ScBdeu8vjD6bI2J7PyiJEWk3AaYA0aMIFyMxGj7/ijmkCP6Aw97cDXhNMNGRR+fIgRefkkH1HFRIADxjALQSAWF0uDrZpiTbJzO/+1p5Ekzat2ojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874400; c=relaxed/simple;
	bh=A12YzMWqFfUVPDT8assRu9b3Y0ZCvKTIV6kZGukYtXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZx6a8gMU+WEE0iljHp6kYRnw/FGzJB55gv0lyxlpzkJv6MdgG2MI4lrLb5t3+XeQ6Kfsa+MzMcOXb5toxFSh7vvWd0OhDEYM8TTtL+dyUBHeZXNrV030nszux2SbwmSzEz2W0SiPcuJUcBowBhTRNzO6tOsSB2j4n+PU8DefqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43NCDFXu81225436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43NCDFXu81225436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:13:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:13:16 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 20:13:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 1/2] wifi: rtw89: fix CTS transmission issue with center frequency deviation
Date: Tue, 23 Apr 2024 20:12:46 +0800
Message-ID: <20240423121247.24714-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

The CTS cannot be received by the peer due to center frequency
deviation. This issue can be solved by correct settings to
transmit proper CTS.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 5 +++++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8b34044f7a8a..b78b110ac7b2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3644,6 +3644,7 @@ static int set_host_rpr_ax(struct rtw89_dev *rtwdev)
 
 static int trx_init_ax(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	enum rtw89_qta_mode qta_mode = rtwdev->mac.qta_mode;
 	int ret;
 
@@ -3687,6 +3688,10 @@ static int trx_init_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	if (chip_id == RTL8852C)
+		rtw89_write32_clr(rtwdev, R_AX_RSP_CHK_SIG,
+				  B_AX_RSP_STATIC_RTS_CHK_SERV_BW_EN);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f16467377eab..934bdf3b398f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1751,6 +1751,7 @@ static int set_host_rpr_be(struct rtw89_dev *rtwdev)
 
 static int trx_init_be(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	enum rtw89_qta_mode qta_mode = rtwdev->mac.qta_mode;
 	int ret;
 
@@ -1794,6 +1795,10 @@ static int trx_init_be(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	if (chip_id == RTL8922A)
+		rtw89_write32_clr(rtwdev, R_BE_RSP_CHK_SIG,
+				  B_BE_RSP_STATIC_RTS_CHK_SERV_BW_EN);
+
 	return 0;
 }
 
-- 
2.25.1


