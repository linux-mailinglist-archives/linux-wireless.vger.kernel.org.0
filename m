Return-Path: <linux-wireless+bounces-5514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3668910C0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C9B240DD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966513C482;
	Fri, 29 Mar 2024 01:54:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295E3B797
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677261; cv=none; b=NMkoCHMwUJoEzo9XXXhq5/bwWivIW+WE0u0ijbkGIctaaYv1IP8Vv+bWgeZE1/KwOqsocGZDoA0lXlKpQmjqIVEBGTmVe8RhCMyeUGifu3KrtKl6/I9G/Tq7/QyADvY4nI7gR87zYccGsVMbV/hoAn7RIRHyWf26aPldet17Rss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677261; c=relaxed/simple;
	bh=W4Fi5BajZTas/9OFXUc1+YvQjd0szV3muYUvIVC0bqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7M4L5mdkEOz4KJH/hAiKg4+6V+MjA9hPMhovOsbf/UNs3d8pWns0TYVsnu7uxAAdBR1PR3lt0H3oZf5y1WV5D60UMH7yHPKEODOZqZyVtR7bcmWuPXe3DhZcOL0BwEqPF09TPdSiIxmN777WX9kNSPl+F/+7fMrXtFD1TjmfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T1sG1s93183197, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T1sG1s93183197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 09:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 09:54:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 29 Mar
 2024 09:54:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/4] wifi: rtw89: download firmware with five times retry
Date: Fri, 29 Mar 2024 09:52:48 +0800
Message-ID: <20240329015251.22762-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329015251.22762-1-pkshih@realtek.com>
References: <20240329015251.22762-1-pkshih@realtek.com>
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

From: Chia-Yuan Li <leo.li@realtek.com>

After firmware boots, it reads keys info from efuse and checks secure
checksum, but suddenly failed to access efuse resulting in probe failure,
and driver throws messages:

  rtw89_8852be 0000:03:00.0: fw security fail
  rtw89_8852be 0000:03:00.0: download firmware fail
  rtw89_8852be 0000:03:00.0: [ERR]fwdl 0x1E0 = 0xe2
  rtw89_8852be 0000:03:00.0: [ERR]fwdl 0x83F0 = 0x210090

Retry five times to resolve rare abnormal hardware state.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 27 +++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f27486d35cbc..e3a07b3d2c72 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1349,13 +1349,12 @@ static void rtw89_fw_prog_cnt_dump(struct rtw89_dev *rtwdev)
 static void rtw89_fw_dl_fail_dump(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u16 val16;
 
 	val32 = rtw89_read32(rtwdev, R_AX_WCPU_FW_CTRL);
 	rtw89_err(rtwdev, "[ERR]fwdl 0x1E0 = 0x%x\n", val32);
 
-	val16 = rtw89_read16(rtwdev, R_AX_BOOT_DBG + 2);
-	rtw89_err(rtwdev, "[ERR]fwdl 0x83F2 = 0x%x\n", val16);
+	val32 = rtw89_read32(rtwdev, R_AX_BOOT_DBG);
+	rtw89_err(rtwdev, "[ERR]fwdl 0x83F0 = 0x%x\n", val32);
 
 	rtw89_fw_prog_cnt_dump(rtwdev);
 }
@@ -1394,8 +1393,9 @@ static int rtw89_fw_download_suit(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
-		      bool include_bb)
+static
+int __rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+			bool include_bb)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
@@ -1433,7 +1433,7 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	ret = rtw89_fw_check_rdy(rtwdev, RTW89_FWDL_CHECK_FREERTOS_DONE);
 	if (ret) {
 		rtw89_warn(rtwdev, "download firmware fail\n");
-		return ret;
+		goto fwdl_err;
 	}
 
 	return ret;
@@ -1443,6 +1443,21 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	return ret;
 }
 
+int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
+		      bool include_bb)
+{
+	int retry;
+	int ret;
+
+	for (retry = 0; retry < 5; retry++) {
+		ret = __rtw89_fw_download(rtwdev, type, include_bb);
+		if (!ret)
+			return 0;
+	}
+
+	return ret;
+}
+
 int rtw89_wait_firmware_completion(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_info *fw = &rtwdev->fw;
-- 
2.25.1


