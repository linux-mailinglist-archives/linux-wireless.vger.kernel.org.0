Return-Path: <linux-wireless+bounces-14701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7F9B59E3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE851F23E86
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00ED1A2564;
	Wed, 30 Oct 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mwmzlIhS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EB1991D6
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254947; cv=none; b=PVIvhgj+y7adlgx+6elMRy5jdU3y4psl73HvQhBLmkED8lFG5e6HbLItFRnxSpAVeGvaFjGvDgkhmLhOEvSw3V188L+tgGQOGX04/3D/BiBhaGDiGUp1LWhLgXW/Fos4Ch6i6YkXBd5YA8mFg0njv1Ddwh3fJFFgIydw6TjRmBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254947; c=relaxed/simple;
	bh=RHRue5nrfMWuyVnFp7PNDAQRQAiZM6idUvTtIz1cpbM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQcASJHeWoqxRbHc5vI+r2I1E29jd9qQhD6QomWJYQ9fD4eDVJezArM/okvo9K5vl8hmgiFxKYvTG9FTWTMK+KNeON52GPdlbwPNOU6ITVoWJSafsVeYvv+ay0PVemrDgsNAQizApf/JXS+EZjo4ozhPZMbGFj+TSFghW/Lxjvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mwmzlIhS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MOPv83310665, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254944; bh=RHRue5nrfMWuyVnFp7PNDAQRQAiZM6idUvTtIz1cpbM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mwmzlIhS1wMRpaSzZsNibZtpIOY/kSYkcAHmqExQhwnsgKjyVHtAeG6JOIWpd5Oln
	 OOuZGSZsPSV/QH/KxhWfqTJPN38WE6BczCAuFx0z1JpPraUZxKE5IvyWJCYvbUxCAO
	 8ZKqcZixNNzrCJ4rpI6COw/QZBC1+XXBJylvNUF45s5GD/LCifa0Pt0HHVwo62GySp
	 TMbPP6Q4Q6cubMVSALshZ8uKrkU/SOcMXgo2UvU+Q2jqtNburvd5mECFrXqb99yzkL
	 uWa0M8x/Q7vfnjY5N1v+aZkZqMYiycS63iLFPb6WsLiQfZtyPa0HVy2z1MA2kxUhAg
	 TxhJYsaplL3ew==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MOPv83310665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: fw: move v1 MSSC out of __parse_security_section() to share with v0
Date: Wed, 30 Oct 2024 10:21:33 +0800
Message-ID: <20241030022135.11688-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030022135.11688-1-pkshih@realtek.com>
References: <20241030022135.11688-1-pkshih@realtek.com>
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

The security section can be a common parser for v0 and v1 format of
firmware header, so move retrieval code of v1 MSSC from the function, and
then sharing becomes possible.

Not logic change at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0b2987bd662e..4229065e07e8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -241,7 +241,6 @@ static int __get_mssc_key_idx(struct rtw89_dev *rtwdev,
 static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 				  struct rtw89_fw_bin_info *info,
 				  struct rtw89_fw_hdr_section_info *section_info,
-				  const struct rtw89_fw_hdr_section_v1 *section,
 				  const void *content,
 				  u32 *mssc_len)
 {
@@ -324,18 +323,14 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 static int __parse_security_section(struct rtw89_dev *rtwdev,
 				    struct rtw89_fw_bin_info *info,
 				    struct rtw89_fw_hdr_section_info *section_info,
-				    const struct rtw89_fw_hdr_section_v1 *section,
 				    const void *content,
 				    u32 *mssc_len)
 {
 	int ret;
 
-	section_info->mssc =
-		le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
-
 	if (section_info->mssc == FORMATTED_MSSC) {
 		ret = __parse_formatted_mssc(rtwdev, info, section_info,
-					     section, content, mssc_len);
+					     content, mssc_len);
 		if (ret)
 			return -EINVAL;
 	} else {
@@ -401,8 +396,11 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 		section_info->addr = bin;
 
 		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
+			section_info->mssc =
+				le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
+
 			ret = __parse_security_section(rtwdev, info, section_info,
-						       section, bin, &mssc_len);
+						       bin, &mssc_len);
 			if (ret)
 				return ret;
 		} else {
-- 
2.25.1


