Return-Path: <linux-wireless+bounces-14698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BB9B59DE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E07B22859
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC71990BA;
	Wed, 30 Oct 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HjccAN+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C5194C9D
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254939; cv=none; b=h27Po0PrJbUEtPlUlbgrD9bRZjOf5rXvfL6lba16ZRv5MMz40WqnaF0gAryKX7sNlNky5HnOC+yAg+t6CsxIDWU+nCZdC4axfJWUfdfp1aGrwyxq8v9/6DQWAYZzSIyEEmhPqgE05kPCc2OQWQ8IJVQ+QvtkUT744fYRrrKU+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254939; c=relaxed/simple;
	bh=DNKY0IYgldnjYjNegYbj4hXZR1xxt7HysA5Msp3yxkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsEj7bFThvpRzsl32MsE9udrRUnzCpLMYIH58PtaTOvp22Nxry0APtVCHDKf8BJgmC1LSQbX0ZbVMjGS9Hr+3TudipLHxAJqOm3Tzmi4662CyM/flhkthYTvU5pcA9OUvpnfQqc8UaejoyRgtrQV86P3oQwOp4Op3YtXd4p/Ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HjccAN+Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MEMB03310598, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254934; bh=DNKY0IYgldnjYjNegYbj4hXZR1xxt7HysA5Msp3yxkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HjccAN+Qa1a/p5JwuNc2mnqrWBdExdjRZsbosoRKXAamDbm/u7vJOsT64EZrghBSR
	 zTMqPOn2frXYvVAjpizg/FrLn5dhSpsQ/9BTvoF4R5Hxddg5aYV8TyZr5B6L2hQe2r
	 9TWrKOj5F9NhgSjp8Rn5u8J30EA24XVuN4+EAO3WAYl6+X1RK9QaLK+VJN3bEU3IQa
	 xcHoeWCDa4mjrsALppbFp6f5vHIBId7wZtlD+IG0bU5gJNjWGFRDBJY3XgseC9sKJc
	 27wvuVND+MWdA8fZKnOgr9LiI05bzgZ8GF6fZyWnbW8hwvVplDqFnxPWxHwrAUCO7R
	 WGBwcL9p5ryYw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MEMB03310598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: efuse: read firmware secure info v0 from efuse for WiFi 6 chips
Date: Wed, 30 Oct 2024 10:21:30 +0800
Message-ID: <20241030022135.11688-4-pkshih@realtek.com>
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

WiFi 6 chips could program secure information in v0 or v1 format. Use
existing v1 parser or newly added v0 parser to recognize firmware key
that is going to be used.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  |  5 +-
 drivers/net/wireless/realtek/rtw89/efuse.c | 86 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5fa59cd138c1..ccee011c9975 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4516,11 +4516,14 @@ enum rtw89_fw_mss_dev_type {
 };
 
 struct rtw89_fw_secure {
-	bool secure_boot;
+	bool secure_boot: 1;
+	bool can_mss_v1: 1;
+	bool can_mss_v0: 1;
 	u32 sb_sel_mgn;
 	u8 mss_dev_type;
 	u8 mss_cust_idx;
 	u8 mss_key_num;
+	u8 mss_idx; /* v0 */
 };
 
 struct rtw89_fw_info {
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index a02b04eecd05..6c6c763510af 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -16,6 +16,20 @@
 #define EFUSE_B2_MSSKEYNUM_MASK GENMASK(3, 0)
 #define EFUSE_B2_MSSCUSTIDX1_MASK BIT(6)
 
+#define EFUSE_EXTERNALPN_ADDR_AX 0x5EC
+#define EFUSE_CUSTOMER_ADDR_AX 0x5ED
+#define EFUSE_SERIALNUM_ADDR_AX 0x5ED
+
+#define EFUSE_B1_EXTERNALPN_MASK GENMASK(7, 0)
+#define EFUSE_B2_CUSTOMER_MASK GENMASK(3, 0)
+#define EFUSE_B2_SERIALNUM_MASK GENMASK(6, 4)
+
+#define OTP_KEY_INFO_NUM 2
+
+static const u8 otp_key_info_externalPN[OTP_KEY_INFO_NUM] = {0x0, 0x0};
+static const u8 otp_key_info_customer[OTP_KEY_INFO_NUM]   = {0x0, 0x1};
+static const u8 otp_key_info_serialNum[OTP_KEY_INFO_NUM]  = {0x0, 0x1};
+
 enum rtw89_efuse_bank {
 	RTW89_EFUSE_BANK_WIFI,
 	RTW89_EFUSE_BANK_BT,
@@ -397,24 +411,96 @@ static u8 get_mss_dev_type_idx(struct rtw89_dev *rtwdev, u8 mss_dev_type)
 
 int rtw89_efuse_recognize_mss_info_v1(struct rtw89_dev *rtwdev, u8 b1, u8 b2)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
 	u8 mss_dev_type;
 
+	if (chip->chip_id == RTL8852B && b1 == 0xFF && b2 == 0x6E) {
+		mss_dev_type = MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_NON_COB;
+		sec->mss_cust_idx = 0;
+		sec->mss_key_num = 0;
+
+		goto mss_dev_type;
+	}
+
 	mss_dev_type = u8_get_bits(b1, EFUSE_B1_MSSDEVTYPE_MASK);
 	sec->mss_cust_idx = 0x1F - (u8_get_bits(b1, EFUSE_B1_MSSCUSTIDX0_MASK) |
 				    u8_get_bits(b2, EFUSE_B2_MSSCUSTIDX1_MASK) << 4);
 	sec->mss_key_num = 0xF - u8_get_bits(b2, EFUSE_B2_MSSKEYNUM_MASK);
 
+mss_dev_type:
 	sec->mss_dev_type = get_mss_dev_type_idx(rtwdev, mss_dev_type);
 	if (sec->mss_dev_type == RTW89_FW_MSS_DEV_TYPE_FWSEC_INV) {
 		rtw89_warn(rtwdev, "invalid mss_dev_type %d\n", mss_dev_type);
 		return -ENOENT;
 	}
 
+	sec->can_mss_v1 = true;
+
 	return 0;
 }
 
+static
+int rtw89_efuse_recognize_mss_index_v0(struct rtw89_dev *rtwdev, u8 b1, u8 b2)
+{
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u8 externalPN;
+	u8 serialNum;
+	u8 customer;
+	u8 i;
+
+	externalPN = 0xFF - u8_get_bits(b1, EFUSE_B1_EXTERNALPN_MASK);
+	customer = 0xF - u8_get_bits(b2, EFUSE_B2_CUSTOMER_MASK);
+	serialNum = 0x7 - u8_get_bits(b2, EFUSE_B2_SERIALNUM_MASK);
+
+	for (i = 0; i < OTP_KEY_INFO_NUM; i++) {
+		if (externalPN == otp_key_info_externalPN[i] &&
+		    customer == otp_key_info_customer[i] &&
+		    serialNum == otp_key_info_serialNum[i]) {
+			sec->mss_idx = i;
+			sec->can_mss_v0 = true;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u32 sec_addr = EFUSE_EXTERNALPN_ADDR_AX;
+	u32 sec_size = 2;
+	u8 sec_map[2];
+	u8 b1, b2;
+	int ret;
+
+	ret = rtw89_dump_physical_efuse_map(rtwdev, sec_map,
+					    sec_addr, sec_size, false);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump secsel map\n");
+		return ret;
+	}
+
+	b1 = sec_map[0];
+	b2 = sec_map[1];
+
+	if (b1 == 0xFF && b2 == 0xFF)
+		return 0;
+
+	rtw89_efuse_recognize_mss_index_v0(rtwdev, b1, b2);
+	rtw89_efuse_recognize_mss_info_v1(rtwdev, b1, b2);
+	if (!sec->can_mss_v1 && !sec->can_mss_v0)
+		goto out;
+
+	sec->secure_boot = true;
+
+out:
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "MSS secure_boot=%d(%d/%d) dev_type=%d cust_idx=%d key_num=%d mss_index=%d\n",
+		    sec->secure_boot, sec->can_mss_v0, sec->can_mss_v1,
+		    sec->mss_dev_type, sec->mss_cust_idx,
+		    sec->mss_key_num, sec->mss_idx);
+
 	return 0;
 }
-- 
2.25.1


