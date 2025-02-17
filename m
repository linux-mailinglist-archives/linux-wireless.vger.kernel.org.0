Return-Path: <linux-wireless+bounces-19048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B629A37BA5
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D628188D6BE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9518F2C3;
	Mon, 17 Feb 2025 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NvDBsMU3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CD18DB3A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774657; cv=none; b=A/GXUqni7f8cOuRnGRtiMIudHPFZlXKm6JJd5O4kLAPnjHQKtBMmji0hXhn8aeJK5NnK8TJ71DW8Xwhbi/guIXOwRqBOfp8X5kvWJaGYFozpb1VHeh12FDw+7vMsE9KK4XqjDEztvXR8s9Z4uOrwV5rjnds0ZesN8u7dxrPudWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774657; c=relaxed/simple;
	bh=i6LML01k6ox02Cmep8wWm/EbJHTch9V8ckb/pf+uh9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLraZ05OD+m3hmffy70bDgzZwEJHyXeryVTcBgQdhhku+Zd91rpNcEm1MTA4Q5rkUekcfdhgiuhMW76rSABRs/mSGxaekBuDWTpBncx+1dibuJj/RHhqcD3vjHSVrqTXaKko03byhOjixayq9Do8CBAWoDnzZeeaGHzZau4U7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NvDBsMU3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6iDdwD2646958, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739774653; bh=i6LML01k6ox02Cmep8wWm/EbJHTch9V8ckb/pf+uh9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NvDBsMU3OTeC/c/2+GTOORdhTC7rOFhv8j9VbLaTLbSbn2MvcRz48MwhFjsZQh3pu
	 aFurYDaXJwX8tnzrvSKYUclejdkOEz9cEgnzJHdoWXzWF8Mvb0zYfek+SdM801mvfp
	 BrOx71d0z2ZMZF7ZTk8KHV4EYxX6tIk/lxOmZCP5zJNgnLJCL9qMRsI4Dw788MVV3Q
	 PuF+ZBDtvJxMQ/U3mMl2bpkWS2uet5OwwogdTgDc7/aPeWuolSn9ygqXhoRKATXHHS
	 dHxHuIuvMIYwbpB6/1QvzpCUD2M9O4s1vE3ICeuSdiV29E8XgjJnnfw2JYuRZM9oMh
	 xjZ2cLeoIEQMA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6iDdwD2646958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:44:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:44:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:44:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: fw: safely cast mfw_hdr pointer from firmware->data
Date: Mon, 17 Feb 2025 14:43:08 +0800
Message-ID: <20250217064308.43559-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217064308.43559-1-pkshih@realtek.com>
References: <20250217064308.43559-1-pkshih@realtek.com>
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

Check size of struct mfw_hdr within firmware->size before type casting
to ensure to validly dereference fields from mfm_hdr pointer. Then,
check if signature field is equal to RTW89_MFW_SIG to assert current
is multi-firmware.

Addresses-Coverity-ID: 1494046 ("Untrusted loop bound")
Addresses-Coverity-ID: 1544385 ("Untrusted array index read")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 30 ++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index abbf406a202d..7a591ddb910f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -542,6 +542,23 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev,
 	}
 }
 
+static
+const struct rtw89_mfw_hdr *rtw89_mfw_get_hdr_ptr(struct rtw89_dev *rtwdev,
+						  const struct firmware *firmware)
+{
+	const struct rtw89_mfw_hdr *mfw_hdr;
+
+	if (sizeof(*mfw_hdr) > firmware->size)
+		return NULL;
+
+	mfw_hdr = (const struct rtw89_mfw_hdr *)firmware->data;
+
+	if (mfw_hdr->sig != RTW89_MFW_SIG)
+		return NULL;
+
+	return mfw_hdr;
+}
+
 static int rtw89_mfw_validate_hdr(struct rtw89_dev *rtwdev,
 				  const struct firmware *firmware,
 				  const struct rtw89_mfw_hdr *mfw_hdr)
@@ -572,14 +589,15 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const struct firmware *firmware = fw_info->req.firmware;
+	const struct rtw89_mfw_info *mfw_info = NULL, *tmp;
+	const struct rtw89_mfw_hdr *mfw_hdr;
 	const u8 *mfw = firmware->data;
 	u32 mfw_len = firmware->size;
-	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
-	const struct rtw89_mfw_info *mfw_info = NULL, *tmp;
 	int ret;
 	int i;
 
-	if (mfw_hdr->sig != RTW89_MFW_SIG) {
+	mfw_hdr = rtw89_mfw_get_hdr_ptr(rtwdev, firmware);
+	if (!mfw_hdr) {
 		rtw89_debug(rtwdev, RTW89_DBG_FW, "use legacy firmware\n");
 		/* legacy firmware support normal type only */
 		if (type != RTW89_FW_NORMAL)
@@ -635,13 +653,13 @@ static u32 rtw89_mfw_get_size(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const struct firmware *firmware = fw_info->req.firmware;
-	const struct rtw89_mfw_hdr *mfw_hdr =
-		(const struct rtw89_mfw_hdr *)firmware->data;
 	const struct rtw89_mfw_info *mfw_info;
+	const struct rtw89_mfw_hdr *mfw_hdr;
 	u32 size;
 	int ret;
 
-	if (mfw_hdr->sig != RTW89_MFW_SIG) {
+	mfw_hdr = rtw89_mfw_get_hdr_ptr(rtwdev, firmware);
+	if (!mfw_hdr) {
 		rtw89_warn(rtwdev, "not mfw format\n");
 		return 0;
 	}
-- 
2.25.1


