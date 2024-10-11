Return-Path: <linux-wireless+bounces-13904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669099ADAF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EC21C224CC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6821CC162;
	Fri, 11 Oct 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggu1o+dS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768E199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679683; cv=none; b=d2PghgVWuGtMCHbf7jSbXW2O+vz1w8+nquqWHWNLw1OJiicm/q4XlHpZGsBGISyhDem5Ti50dZen2HDYU8ryNFjuLOgM7x1n/f2sZF/dj7i8SrVUsflz+M3wsWXd4uX+g0DFt8Vd0UMSPG4R3jr5MfpiuJ5rlg8mZPwVjygmuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679683; c=relaxed/simple;
	bh=jsJ+21SFe18ja5qxJlNAsOmJZ5M3j+/L5i3dWiJ7Zow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=np8RbjQJZMk8WCwYLUTZj9RXlxIyjlB/Y0NSNNnTArA64R8+0/w+yxmrpGw8eUxEVaFVQJdMzOExMBUvhJJD6W6he/bk/fM5yk0twEyO7Dtmmx7NiHWRWY7oZltL1G/6II4wFQ1XAup9BRxVFFuwawaFhsBtlZttAwsv5+88zkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggu1o+dS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43124843b04so3540525e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679680; x=1729284480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzAtkfQs3Nt7HFrIuM4sG6958ejpbG9Udaxil4BShcM=;
        b=ggu1o+dS0ARFpmDx+3AZwMGTig6HeuJbdFXyVoxcpK5W7Md4HlWIr5baW3dju+ksUU
         wmgt/Ec0wIMpjqKHtjkxHx5PGhUNBb17bpdgwZVX3/3+WROwtEvada1FDVIUMn40VgOm
         ZL9NMKo6aZc+lzmxjGPtEWXmz8dHbn1aVeUHv5S1yUwSytfYHD+3rcs5kPLfFzPn4hXS
         bHPvlHYxIUkSbn2kZGjTRstsexn5XqMZPqQaHeOKgWruEolzzccslPOUAWq18xVSVDsy
         9Zbjqtv0N2aVFvlW/afg+9Atoewg+ZoGPsZSGRFluS9PkMgX1EiEwn2CrlGbxOmR/g/o
         Lyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679680; x=1729284480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzAtkfQs3Nt7HFrIuM4sG6958ejpbG9Udaxil4BShcM=;
        b=VDAUBhS9A2NLq3wThi/SnHFirqhwNQZMwWX/a6TTk6hZ2Cgq12P7s2JXRDNx3NEEJs
         GqRfbj+iHRkxZ1mwKPBow+lDafV5RzYOnjWTM/KrZrTUoQ8X1dxbn4Y8vya/RZmdaun9
         NCAD2yHRkj6UqyD7uO5Or5vQUY47J/i4l+myXKJ2zzL72q/dG+mVTjDwybbBtyw7Fl49
         CVQqPDwp7USDkgRGYNR0un/qZY9sPL2ZrfwFUPk8Y0HAdXi5UPu/bEMzfvKG6woANYLt
         ZhGN/eXsMZC+QDomncC5LahxDXVak7ZaSjnS/0pTbdf8HEXbsnfndgwlgMcXkBocUJJf
         L0UA==
X-Gm-Message-State: AOJu0YycGfGAAqA/7lDveeNF1wB/VozOjSElbLLu9sZgd9nxZ3Gxngjp
	rJAtOPxcS+1Ckj9Uuf61R1uNkn0onwHd9omCsYbclaOGAb9qs0C0HuHIDA==
X-Google-Smtp-Source: AGHT+IHUqgRelhBEdi6XXZfAam8neVN7MlnGOlzZNQ41/aw4L/eD5k8kcn7in7TsoqeuyKTVlYNZsw==
X-Received: by 2002:a05:600c:4507:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-4311df56c63mr30032295e9.31.1728679679694;
        Fri, 11 Oct 2024 13:47:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffc75sm50291605e9.17.2024.10.11.13.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:47:58 -0700 (PDT)
Message-ID: <25058b20-8001-4ebd-bd9b-932dff9710d0@gmail.com>
Date: Fri, 11 Oct 2024 23:47:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 04/22] wifi: rtw88: Extend the init table parsing for
 RTL8812AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chips supported so far only use the first condition, and so the
parsing code ignores the second condition. RTL8812AU's init tables use
the second condition also. Make the parsing code check it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Initialise structs with {} instead of {0}.
---
 drivers/net/wireless/realtek/rtw88/main.h | 15 ++++++
 drivers/net/wireless/realtek/rtw88/phy.c  | 61 ++++++++++++++++++++---
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 6161db5fcba6..297da821704b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1835,6 +1835,20 @@ struct rtw_phy_cond {
 	#define BRANCH_ENDIF	3
 };
 
+struct rtw_phy_cond2 {
+#ifdef __LITTLE_ENDIAN
+	u8 type_glna;
+	u8 type_gpa;
+	u8 type_alna;
+	u8 type_apa;
+#else
+	u8 type_apa;
+	u8 type_alna;
+	u8 type_gpa;
+	u8 type_glna;
+#endif
+};
+
 struct rtw_fifo_conf {
 	/* tx fifo information */
 	u16 rsvd_boundary;
@@ -1916,6 +1930,7 @@ struct rtw_hal {
 	u8 oem_id;
 	u8 pkg_type;
 	struct rtw_phy_cond phy_cond;
+	struct rtw_phy_cond2 phy_cond2;
 	bool rfe_btg;
 
 	u8 ps_mode;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index d57a2aabd89b..dda212a721ca 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -18,7 +18,10 @@ struct phy_cfg_pair {
 };
 
 union phy_table_tile {
-	struct rtw_phy_cond cond;
+	struct {
+		struct rtw_phy_cond cond;
+		struct rtw_phy_cond2 cond2;
+	} __packed;
 	struct phy_cfg_pair cfg;
 };
 
@@ -1041,7 +1044,8 @@ void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_phy_cond cond = {0};
+	struct rtw_phy_cond cond = {};
+	struct rtw_phy_cond2 cond2 = {};
 
 	cond.cut = hal->cut_version ? hal->cut_version : 15;
 	cond.pkg = pkg ? pkg : 15;
@@ -1061,15 +1065,34 @@ void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg)
 		break;
 	}
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8812A ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821A) {
+		cond.rfe = 0;
+		cond.rfe |= efuse->ext_lna_2g;
+		cond.rfe |= efuse->ext_pa_2g  << 1;
+		cond.rfe |= efuse->ext_lna_5g << 2;
+		cond.rfe |= efuse->ext_pa_5g  << 3;
+		cond.rfe |= efuse->btcoex     << 4;
+
+		cond2.type_alna = efuse->alna_type;
+		cond2.type_glna = efuse->glna_type;
+		cond2.type_apa = efuse->apa_type;
+		cond2.type_gpa = efuse->gpa_type;
+	}
+
 	hal->phy_cond = cond;
+	hal->phy_cond2 = cond2;
 
-	rtw_dbg(rtwdev, RTW_DBG_PHY, "phy cond=0x%08x\n", *((u32 *)&hal->phy_cond));
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "phy cond=0x%08x cond2=0x%08x\n",
+		*((u32 *)&hal->phy_cond), *((u32 *)&hal->phy_cond2));
 }
 
-static bool check_positive(struct rtw_dev *rtwdev, struct rtw_phy_cond cond)
+static bool check_positive(struct rtw_dev *rtwdev, struct rtw_phy_cond cond,
+			   struct rtw_phy_cond2 cond2)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_phy_cond drv_cond = hal->phy_cond;
+	struct rtw_phy_cond2 drv_cond2 = hal->phy_cond2;
 
 	if (cond.cut && cond.cut != drv_cond.cut)
 		return false;
@@ -1080,8 +1103,28 @@ static bool check_positive(struct rtw_dev *rtwdev, struct rtw_phy_cond cond)
 	if (cond.intf && cond.intf != drv_cond.intf)
 		return false;
 
-	if (cond.rfe != drv_cond.rfe)
-		return false;
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8812A ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821A) {
+		if (cond.rfe & 0x0f) {
+			if ((cond.rfe & drv_cond.rfe) != cond.rfe)
+				return false;
+
+			if ((cond.rfe & BIT(0)) && cond2.type_glna != drv_cond2.type_glna)
+				return false;
+
+			if ((cond.rfe & BIT(1)) && cond2.type_gpa != drv_cond2.type_gpa)
+				return false;
+
+			if ((cond.rfe & BIT(2)) && cond2.type_alna != drv_cond2.type_alna)
+				return false;
+
+			if ((cond.rfe & BIT(3)) && cond2.type_apa != drv_cond2.type_apa)
+				return false;
+		}
+	} else {
+		if (cond.rfe != drv_cond.rfe)
+			return false;
+	}
 
 	return true;
 }
@@ -1090,7 +1133,8 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 {
 	const union phy_table_tile *p = tbl->data;
 	const union phy_table_tile *end = p + tbl->size / 2;
-	struct rtw_phy_cond pos_cond = {0};
+	struct rtw_phy_cond pos_cond = {};
+	struct rtw_phy_cond2 pos_cond2 = {};
 	bool is_matched = true, is_skipped = false;
 
 	BUILD_BUG_ON(sizeof(union phy_table_tile) != sizeof(struct phy_cfg_pair));
@@ -1109,11 +1153,12 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 			case BRANCH_ELIF:
 			default:
 				pos_cond = p->cond;
+				pos_cond2 = p->cond2;
 				break;
 			}
 		} else if (p->cond.neg) {
 			if (!is_skipped) {
-				if (check_positive(rtwdev, pos_cond)) {
+				if (check_positive(rtwdev, pos_cond, pos_cond2)) {
 					is_matched = true;
 					is_skipped = true;
 				} else {
-- 
2.46.0


