Return-Path: <linux-wireless+bounces-18282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8BA25313
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D069162BD6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E61E990B;
	Mon,  3 Feb 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H7Vmi5Gy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A71EEA4E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567805; cv=none; b=F4g1wOkUfjWPmAEylsK7AXgwyzQufkiqHlNWAaT8zXplZmTTXhSEXvQ5dz7fgF5W8NXByqfUuf/+QoXPsZbOnU2yXWPbSCLxDWvuWrY06rBkK7bMl0luaKlMNNGJ2HxWJY2B8wAXmDPF0j+oEOCdI2g0/oz2OKXAnkqpsrVwcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567805; c=relaxed/simple;
	bh=8yfAmYBVsoqIHjpHNEoJ5qWcOXyLKC3DAQLvXVFd9uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/fmJP540FIg8Lw/by1c8CfOnKotfs2M80+oAmz+T7Rf4qQljfRctUBU7eBMsQSr789L5GadIcNB2DjHa3PKkC8IXCIlQAapyW1QUzsLD0+7UNFYxOJILQzeIw5tFb3SyArGXPv9r4rYxExl2NpY2ZxSa9IIJULCcUxHe/uZMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H7Vmi5Gy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5137U07C01321562, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1738567800; bh=8yfAmYBVsoqIHjpHNEoJ5qWcOXyLKC3DAQLvXVFd9uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=H7Vmi5Gyb0bo2amRj3jS57Y46W7/Uw+XMWY3/BfMccNB5KYyL1hvoJ4LmRShSP13j
	 TEVFUUEu8WOhKmOMeKH3l1d03+5d0QbEQfCcqdroBgpDZTNvgM0J2UzmRysaIvt7d3
	 QmlF4uahnrl5yXGRbZAIEnPNmQm3+hugRGX/+g7IaEA0sMQVGIDDnTPWLlfjZGOE8z
	 lyIYXV8LZ0NmhAaHcn7a8cU7mntk0+bmkfOi4sAmY0p0NE+TAypnu8y/5xTt+fhdEN
	 ch/dH0HWewqZyMd/PeZQS5If3kgL+9lVylIl2mFdLN2fn48dHV3jMAsFhGmBE/CeJD
	 FbUbyyUv/4wPQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5137U07C01321562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:30:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 15:30:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 3 Feb
 2025 15:29:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: fw: validate multi-firmware header before accessing
Date: Mon, 3 Feb 2025 15:29:10 +0800
Message-ID: <20250203072911.47313-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203072911.47313-1-pkshih@realtek.com>
References: <20250203072911.47313-1-pkshih@realtek.com>
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

A firmeware file contains multi-firmware with a header to represent
contents. The mfw_hdr->fw_nr is to define number of firmware in file.

         +-----+-------+------+---------+--------------+
         | sig | fw_nr | rsvd | version | reserved     |
         +---------------------------------------------+ --
 fw 0    | cv | type | mp | rsvd | shift | size | rsvd |   \
         +---------------------------------------------+   |
 fw 1    | cv | type | mp | rsvd | shift | size | rsvd |   | mfw_hdr->fw_nr
         +---------------------------------------------+   |
 fw N-1  |                  ...                        |   /
         +=============================================+ --
         |               fw 0 content                  |
         |       (pointed by fw0 shift/size)           |
         +=============================================+

To avoid Coverity warning, validate header is in range of firmware size,
and also validate the range of actual firmware content is in range.

Addresses-Coverity-ID: 1494046 ("Untrusted loop bound")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c86a0d328435..68e80e54ab5f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -489,6 +489,30 @@ static int rtw89_fw_hdr_parser(struct rtw89_dev *rtwdev,
 	}
 }
 
+static int rtw89_mfw_validate_hdr(struct rtw89_dev *rtwdev,
+				  const struct firmware *firmware,
+				  const struct rtw89_mfw_hdr *mfw_hdr)
+{
+	const void *mfw = firmware->data;
+	u32 mfw_len = firmware->size;
+	u8 fw_nr = mfw_hdr->fw_nr;
+	const void *ptr;
+
+	if (fw_nr == 0) {
+		rtw89_err(rtwdev, "mfw header has no fw entry\n");
+		return -ENOENT;
+	}
+
+	ptr = &mfw_hdr->info[fw_nr];
+
+	if (ptr > mfw + mfw_len) {
+		rtw89_err(rtwdev, "mfw header out of address\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static
 int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 			struct rtw89_fw_suit *fw_suit, bool nowarn)
@@ -499,6 +523,7 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 	u32 mfw_len = firmware->size;
 	const struct rtw89_mfw_hdr *mfw_hdr = (const struct rtw89_mfw_hdr *)mfw;
 	const struct rtw89_mfw_info *mfw_info = NULL, *tmp;
+	int ret;
 	int i;
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG) {
@@ -511,6 +536,10 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 		return 0;
 	}
 
+	ret = rtw89_mfw_validate_hdr(rtwdev, firmware, mfw_hdr);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < mfw_hdr->fw_nr; i++) {
 		tmp = &mfw_hdr->info[i];
 		if (tmp->type != type)
@@ -540,6 +569,12 @@ int rtw89_mfw_recognize(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
 found:
 	fw_suit->data = mfw + le32_to_cpu(mfw_info->shift);
 	fw_suit->size = le32_to_cpu(mfw_info->size);
+
+	if (fw_suit->data + fw_suit->size > mfw + mfw_len) {
+		rtw89_err(rtwdev, "fw_suit %d out of address\n", type);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


