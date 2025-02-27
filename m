Return-Path: <linux-wireless+bounces-19542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623CA47EA8
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F94F3AD713
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246A22F166;
	Thu, 27 Feb 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZlI88Hw6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10E22FDF7
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661982; cv=none; b=nCliP2KMnyl8YNlfeBK2jX44Le3Fb7g5Yv7BnHJSrJBER95zu7aspBNyWh1rXjgqpExrJn6/3ykDpIxkSLs9sCH0Y6XVRSid2DgQWF1Gm0GWeHtVIV4g2VSr/GPAgamylmT50F8a0pEj+HkRfdtbghYR2tKF0HkmakKgx5odN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661982; c=relaxed/simple;
	bh=mQl79HBGcBsG5mBWkYwPI7UIpF8NCNdfT6rOM0HTbTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQ8C7U7Sm2fKJ5rdXTulrjUgU6JhECDNENyxnmp5Rdxq8JZiLMf/D5X916ON3GwjmBx+pGTQ/cibBaVnNjOYQfUHqL6NjJ0tPenUt7KY8K5+pM1Xo0OJXYPk+bH0bwAyjh/mJcabHkBLl4AR8r8MitOgdnDA4bcYzPeeOd7aQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZlI88Hw6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51RDCvpeE2008960, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740661978; bh=mQl79HBGcBsG5mBWkYwPI7UIpF8NCNdfT6rOM0HTbTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZlI88Hw6htATZC9BIr3Y/2RfeFaAkc6VGSHqheTwIUP7gaiGI6rKAN6i/BoHkxPAI
	 O8og+gq24wJn+H+/ZYBmGonOZCHKg5nM4hNk84+QMdzWhr3qEtl6c5ELwkto217K8k
	 mChbZjhSd+Rt+kiGO2hNWd2W1L4A96C+GLCqzyWP72w0iw0OwbAcv81GANRV9Sna33
	 lMINatGsXXDczJurTQhKf0tFmQ3cpoMRSPUHuS9qGnbUUEZ8jy2ccAntkGOizdL0I6
	 aSduce15ydrjlV8qJmSV6ZiEh/ftN1exeJ1ZOb8rh4n9IRf58aU5g0xmwcM60f7V/F
	 769IF0AQ6+6og==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51RDCvpeE2008960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 21:12:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 21:12:58 +0800
Received: from [127.0.1.1] (172.16.24.143) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 21:12:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next v2 4/4] wifi: rtw89: fw: don't reject firmware in blacklist to prevent breaking users
Date: Thu, 27 Feb 2025 21:12:28 +0800
Message-ID: <20250227131228.8457-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227131228.8457-1-pkshih@realtek.com>
References: <20250227131228.8457-1-pkshih@realtek.com>
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

Once update driver blacklist of firmware, users' firmware might be in
the list, and then driver stops working. Since breaking users is not
expected, report a significant message instead of stopping.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: added by v2
---
 drivers/net/wireless/realtek/rtw89/fw.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 15d6bda1fcf0..d0a246f415ff 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -372,7 +372,7 @@ static int __check_secure_blacklist(struct rtw89_dev *rtwdev,
 		return 0;
 
 	if (!chip_blacklist) {
-		rtw89_err(rtwdev, "chip no blacklist for secure firmware\n");
+		rtw89_warn(rtwdev, "chip no blacklist for secure firmware\n");
 		return -ENOENT;
 	}
 
@@ -380,14 +380,14 @@ static int __check_secure_blacklist(struct rtw89_dev *rtwdev,
 	bit_mask = BIT(section_content->blacklist.bit_in_chip_list & 0x7);
 
 	if (section_content->blacklist.ver > chip_blacklist->ver) {
-		rtw89_err(rtwdev, "chip blacklist out of date (%u, %u)\n",
-			  section_content->blacklist.ver, chip_blacklist->ver);
+		rtw89_warn(rtwdev, "chip blacklist out of date (%u, %u)\n",
+			   section_content->blacklist.ver, chip_blacklist->ver);
 		return -EINVAL;
 	}
 
 	if (chip_blacklist->list[byte_idx] & bit_mask) {
-		rtw89_err(rtwdev, "firmware %u in chip blacklist\n",
-			  section_content->blacklist.ver);
+		rtw89_warn(rtwdev, "firmware %u in chip blacklist\n",
+			   section_content->blacklist.ver);
 		return -EPERM;
 	}
 
@@ -427,7 +427,10 @@ static int __parse_security_section(struct rtw89_dev *rtwdev,
 		info->secure_section_exist = true;
 	}
 
-	return __check_secure_blacklist(rtwdev, info, section_info, content);
+	ret = __check_secure_blacklist(rtwdev, info, section_info, content);
+	WARN_ONCE(ret, "Current firmware in blacklist. Please update firmware.\n");
+
+	return 0;
 }
 
 static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
-- 
2.25.1


