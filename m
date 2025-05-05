Return-Path: <linux-wireless+bounces-22536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC648AAA6ED
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C612217E6C0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48001331084;
	Mon,  5 May 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dInbJfDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EF33107B;
	Mon,  5 May 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484547; cv=none; b=rKSmJTD/DW4M/EUxN1CWe7Ky6o/axGFP+8jbx8e47KoKFmayHBxw2Mwz61DMxMT4UtKcwqXhiS283u/Z4TZDQk5w+9/8otecVS/kkINlK+fzvSZhlZ2/S5TLj8fkJntP5DEy/QtImfQtuDFRcyZjpl7YMLY9DagvYM0HHdXL0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484547; c=relaxed/simple;
	bh=AiItp+61vcabD+hEJKHmr/MFEQ4C+WBDvuijjLFywEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foj1thZD3QRIYt4kDij7OWR4LppkhY+1nIU+jZ5S7zeEZMK8x0EiF52blVz16UrYvIRVlFJm54WiOCJEnwVvRgbVxyZdbngwGIvm25phpfsWxnxbYMAtrx5TuRkgN0guWb11cFVv7/RL3pCkpNbJy012NuVGklpKxrdA9ROylps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dInbJfDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F92C4CEEF;
	Mon,  5 May 2025 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484547;
	bh=AiItp+61vcabD+hEJKHmr/MFEQ4C+WBDvuijjLFywEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dInbJfDwseifdN7qWNBVfz3RY+PFTPB34pIVVw3c/MCRCNB+079u3Alc2GETeWgju
	 fQSc1eJMRQWyFGfmvxgyaO18l0w5QGb45B1X55CIryfU9p6xTI3904R8Di/flCp6ON
	 I6H0+629Zs1cO/UDXija+/UezWiptZ5rP1WpU6u2gEr8sEvKVg3ithFr+dBh1Qiwcx
	 8MdesiWy5Dp1gm+xuBB5/6/0xtx/3f79R9GrQ5Rp7SXT7i0GrpZZAiKY4HNpIcl/W3
	 9tABV7llJmI1S8KRqxXD2SkuTMrRMY9s24krUecPiGGscPHlW28X0CsD1ZhFoojnse
	 ulA6/xYvHbdpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 529/642] wifi: rtw89: call power_on ahead before selecting firmware
Date: Mon,  5 May 2025 18:12:25 -0400
Message-Id: <20250505221419.2672473-529-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit d078f5857a00c06fa0ddee26d3cb722e938e1688 ]

Driver selects firmware by hardware version, which normally can be read
from registers before selecting firmware. However, certain chips such as
RTL8851B, it needs to read hardware version from efuse while doing
power_on, but do power_on after selecting firmware in current flow.

To resolve this flow problem, move power_on out from
rtw89_mac_partial_init(), and call rtw89_mac_pwr_on() separately at
proper places to have expected flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250203072911.47313-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c | 23 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.c  | 29 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.h  |  1 +
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c84446ec9e4f4..422cc3867f3bc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5086,8 +5086,6 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 
 	rtw89_hci_mac_pre_deinit(rtwdev);
 
-	rtw89_mac_pwr_off(rtwdev);
-
 	return 0;
 }
 
@@ -5168,36 +5166,45 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 
 	rtw89_read_chip_ver(rtwdev);
 
+	ret = rtw89_mac_pwr_on(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to power on\n");
+		return ret;
+	}
+
 	ret = rtw89_wait_firmware_completion(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to wait firmware completion\n");
-		return ret;
+		goto out;
 	}
 
 	ret = rtw89_fw_recognize(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to recognize firmware\n");
-		return ret;
+		goto out;
 	}
 
 	ret = rtw89_chip_efuse_info_setup(rtwdev);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = rtw89_fw_recognize_elements(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to recognize firmware elements\n");
-		return ret;
+		goto out;
 	}
 
 	ret = rtw89_chip_board_info_setup(rtwdev);
 	if (ret)
-		return ret;
+		goto out;
 
 	rtw89_core_setup_rfe_parms(rtwdev);
 	rtwdev->ps_mode = rtw89_update_ps_mode(rtwdev);
 
-	return 0;
+out:
+	rtw89_mac_pwr_off(rtwdev);
+
+	return ret;
 }
 EXPORT_SYMBOL(rtw89_chip_info_setup);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2c74d7781bd40..def12dbfe48d3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1495,6 +1495,21 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 #undef PWR_ACT
 }
 
+int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_mac_power_switch(rtwdev, true);
+	if (ret) {
+		rtw89_mac_power_switch(rtwdev, false);
+		ret = rtw89_mac_power_switch(rtwdev, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev)
 {
 	rtw89_mac_power_switch(rtwdev, false);
@@ -3996,14 +4011,6 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 {
 	int ret;
 
-	ret = rtw89_mac_power_switch(rtwdev, true);
-	if (ret) {
-		rtw89_mac_power_switch(rtwdev, false);
-		ret = rtw89_mac_power_switch(rtwdev, true);
-		if (ret)
-			return ret;
-	}
-
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
 	if (include_bb) {
@@ -4036,6 +4043,10 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
+	ret = rtw89_mac_pwr_on(rtwdev);
+	if (ret)
+		return ret;
+
 	ret = rtw89_mac_partial_init(rtwdev, include_bb);
 	if (ret)
 		goto fail;
@@ -4067,7 +4078,7 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 
 	return ret;
 fail:
-	rtw89_mac_power_switch(rtwdev, false);
+	rtw89_mac_pwr_off(rtwdev);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 373366a602e0b..71574dbd8764e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1145,6 +1145,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 	rtw89_write32_set(rtwdev, reg, bit);
 }
 
+int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
-- 
2.39.5


