Return-Path: <linux-wireless+bounces-22627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C132DAAB211
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 06:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A1F7BB0E2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 04:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1E4208FA;
	Tue,  6 May 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAc1wjV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91012D4B40;
	Mon,  5 May 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485654; cv=none; b=vF8b6jaQ17uIPzZH7aIAEPsCa47CCsC4gsUMf78aKWtA8IKI5/UeLEkRto6zuLqBbkDM8hviVqyGq4YeqiScK4impKsoWaT9KAk/UHn11iJi0DWv5qlHu75fqQw85CeX95D5u1eTDbisgYodKfmERI24hYSexxswa6lCiqbxy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485654; c=relaxed/simple;
	bh=Y3NM0MCMk7+ECI9zSepJUk3C8iwhZLPPEjRgymiGBg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbDLVNLFS3L80kdUXrPijHAa6bloKes2rDWp9SZcRCsSMLS0rRbPfw9TLXt8XhnDpFo+D3iag3r6fImnHTNA/8gMNMxHGAvcZHylRbOSVUggXtMExvQQk7G1VxDGy4CmLFyxkW361+OmrXxSjxgfuQ4F2tQYV+wAlCV2kMcrNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAc1wjV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C87C4CEED;
	Mon,  5 May 2025 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485654;
	bh=Y3NM0MCMk7+ECI9zSepJUk3C8iwhZLPPEjRgymiGBg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAc1wjV25fzx265dx51qm6afU6Hnu90v+impB8MGyOshFExxZtDXHluj4dTA+FZwM
	 xs1am1/x0vZpyUXsVmS7xKwwWEOxa7QMFXNDv91SmmOIWHP/AELTFoO1vE5rI1+IxT
	 JmELJ9XVoKhxx3TGl8uyv5BBDZFR+lGlGLM1+YLENk+wFOj717i3nvoG176JbsblDD
	 5kvxNuVWpaU1eVtCVCBGJIyMF4E/wW9nWW5aAOg3SIU0JAO0OE/uuwsffFVHS6/60H
	 j3SKjGM9xpArJS9ULA7TB9K3ejtMKTfNwxo5xldMAUWjTgqAV6RN9rVyi2SLkR2vkv
	 7YAhdRuFwC3TA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 410/486] wifi: rtw89: call power_on ahead before selecting firmware
Date: Mon,  5 May 2025 18:38:06 -0400
Message-Id: <20250505223922.2682012-410-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index f82a26be6fa82..83b22bd0ce81a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4862,8 +4862,6 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 
 	rtw89_hci_mac_pre_deinit(rtwdev);
 
-	rtw89_mac_pwr_off(rtwdev);
-
 	return 0;
 }
 
@@ -4944,36 +4942,45 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 
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
index 04e254bd6b17f..9b09d4b7dea59 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1491,6 +1491,21 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
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
@@ -3918,14 +3933,6 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
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
@@ -3958,6 +3965,10 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 	bool include_bb = !!chip->bbmcu_nr;
 	int ret;
 
+	ret = rtw89_mac_pwr_on(rtwdev);
+	if (ret)
+		return ret;
+
 	ret = rtw89_mac_partial_init(rtwdev, include_bb);
 	if (ret)
 		goto fail;
@@ -3989,7 +4000,7 @@ int rtw89_mac_init(struct rtw89_dev *rtwdev)
 
 	return ret;
 fail:
-	rtw89_mac_power_switch(rtwdev, false);
+	rtw89_mac_pwr_off(rtwdev);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 5ba1133b79d64..7974849f41e25 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1120,6 +1120,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 	rtw89_write32_set(rtwdev, reg, bit);
 }
 
+int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev);
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
-- 
2.39.5


