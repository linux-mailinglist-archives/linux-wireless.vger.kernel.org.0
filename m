Return-Path: <linux-wireless+bounces-8695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493E9005DB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6801B23510
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8A194A54;
	Fri,  7 Jun 2024 14:03:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8B190686
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768990; cv=none; b=URLQ6KFtXIbqaQp+VhDR+1Iti+VGNG1deBMNmYM3VP8CK9f+FaCQ+WO8cAaIH5L3YUF88sWsI/k45yXOx3abcyHK5oL46TQuu0daTBslduJaXlkRndfvpVv7Zcp9YZRtaqon1jzAxZ044s1DGQL7K98ha2vQFTsgH+DU0dGIQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768990; c=relaxed/simple;
	bh=qX/vM3s+q6KV+yaTK8KpX16IXjr9bJlDOkVsfiaat7E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=slptfBwFVkkR2jc/BCj8/6SV79id7m0jq2p2HNvhIYYqi4oBh6mr9bd6gKf+TF2O2f0PkouToFNANqFfagHVgbGL/NIPoBXLzdgVb5T/9A75r8ZHT9WpMXocYqZJW+WlnkRtOvq6fZyXCmnGFQlBk1ydBoO1EpOvryEeDkd4P/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 457E36Ja84079174, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 457E36Ja84079174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 7 Jun 2024 22:03:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 22:03:06 +0800
Received: from [127.0.1.1] (172.16.16.228) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 22:03:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: adopt firmware whose version is equal or less but closest
Date: Fri, 7 Jun 2024 22:02:51 +0800
Message-ID: <20240607140251.8295-1-pkshih@realtek.com>
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

Version C of 8922AE hardware will use the same firmware of version B, so
extend rule of firmware recognition to allow less but closest firmware
version. Originally only accept firmware with matched version.

Tested on version A/B/C of 8922AE.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 34 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index be39a8468d32..23204b2706c9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -462,7 +462,7 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	const u8 *mfw = firmware->data;
 	u32 mfw_len = firmware->size;
 	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
-	const struct rtw89_mfw_info *mfw_info;
+	const struct rtw89_mfw_info *mfw_info = NULL, *tmp;
 	int i;
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG) {
@@ -476,15 +476,27 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	}
 
 	for (i = 0; i < mfw_hdr->fw_nr; i++) {
-		mfw_info = &mfw_hdr->info[i];
-		if (mfw_info->type == type) {
-			if (mfw_info->cv == rtwdev->hal.cv && !mfw_info->mp)
-				goto found;
-			if (type == RTW89_FW_LOGFMT)
-				goto found;
+		tmp = &mfw_hdr->info[i];
+		if (tmp->type != type)
+			continue;
+
+		if (type == RTW89_FW_LOGFMT) {
+			mfw_info = tmp;
+			goto found;
+		}
+
+		/* Version order of WiFi firmware in firmware file are not in order,
+		 * pass all firmware to find the equal or less but closest version.
+		 */
+		if (tmp->cv <= rtwdev->hal.cv && !tmp->mp) {
+			if (!mfw_info || mfw_info->cv < tmp->cv)
+				mfw_info = tmp;
 		}
 	}
 
+	if (mfw_info)
+		goto found;
+
 	if (!nowarn)
 		rtw89_err(rtwdev, "no suitable firmware found\n");
 	return -ENOENT;
@@ -606,10 +618,16 @@ int __rtw89_fw_recognize_from_elm(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_fw_suit *fw_suit;
 
-	if (hal->cv != elm->u.bbmcu.cv)
+	/* Version of BB MCU is in decreasing order in firmware file, so take
+	 * first equal or less version, which is equal or less but closest version.
+	 */
+	if (hal->cv < elm->u.bbmcu.cv)
 		return 1; /* ignore this element */
 
 	fw_suit = rtw89_fw_suit_get(rtwdev, type);
+	if (fw_suit->data)
+		return 1; /* ignore this element (a firmware is taken already) */
+
 	fw_suit->data = elm->u.bbmcu.contents;
 	fw_suit->size = le32_to_cpu(elm->size);
 
-- 
2.25.1


