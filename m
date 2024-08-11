Return-Path: <linux-wireless+bounces-11275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB894E325
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8334F1C208BF
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D61547EA;
	Sun, 11 Aug 2024 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijBB81Us"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C179F4
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409746; cv=none; b=JISoigwg5KimH7oXiuCsvWBUT9MOfFqbAcwvvYq5AbW8dUwEpD9bEctqvwChkImK78PwGneLuL6W6AYJuD//x96/RwWeKgXrGEux97V7mmySsW6uBh2oGOw3cPKLjtIUnhVM+y/aXtXvBf/C67E5/MCRk8CJ1wa+1R0oSokaEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409746; c=relaxed/simple;
	bh=/lOAnzVZm0ipMW/AmZofsXdRuRow0DTi8V2fMuqlsKk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZFcomF4o+Wx2b39abJsKKmvF15HRzeI0dleD/UzWCCh/19iH8mLVR++aMb9AYpdMmaovAc3Jlv9k3piswV4dw8V2JfCScbK+42AMQuJj5xGGpTEVjMElafF0RDD67ouK4L1Pk/OLg6NFkWc9267lqfwFc3pXr5PJLPHe5GFp8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijBB81Us; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bd13ea7604so1680936a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409743; x=1724014543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i9tzsbeHAJCPOE0lRKdfCTac6k4LPHj6+Gxv4dzlblw=;
        b=ijBB81UsuO3dabIVsK8B1CDLM83W7rZo+upy+dBAFbhE1lYK4Ehi6Nau6udF7RL5zF
         YqQbllzydz4utuF8owdRdnCE7V2/VWK8tdnbiC/NGMrPVnqIOta4HR+pUX9uhrGdUAlF
         X+mbw4J19xCJ7vG0HSVQIXEJomyaG9241rMQrLDWbPqnc2oV/pat/N9wy+eGI5t1M9eo
         Sb1asT31JtbFoe4Yf41vLyHIlDyNJANq+zxdg6T22hiIXry6V3z9LlxBtIhAEFBjKGG6
         aMGLsZuKDdbb4i6FvDj1s9hmwTucnanc7QU7tCuPSgw+ay31P0hCnThl2k+omHCbrmXS
         pYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409743; x=1724014543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9tzsbeHAJCPOE0lRKdfCTac6k4LPHj6+Gxv4dzlblw=;
        b=kzB9EO5wwqIm6F41k661NK7LwV0Tu0Zr9Q5HQBWaAE/CfYNDICUNBYuHEOzcmYgM38
         1Vn+onqVzTKM4a6PTQPu49RP1jzHnAhluJKEoHHpNs8Mpj5zzlAYuQYjqZDUPTvJTsnT
         nQgeFSit/pOldfKo6N7/AQnCnV5uDlLPq55q1/8u4rSbPdiFHGs/CoXt6TEHGw9rp7qh
         FHzt8pZZsIBllFdUySN69NPTOETa6LWMpMgDqBHZV22Fc/LdQ7GMV1uSJXdqW2lIq45S
         Zq32YNyF/ox9gfUGRLfnPrSBi31EnlAlDhFkOBKakGHcjMWyhv4rwjU6o4cxT7TARRuM
         B3bQ==
X-Gm-Message-State: AOJu0Yy2oWLf7GXeTcxukMpZhCz39GWTroET6WUMpziBZkUKLQJZc90q
	lEtQFgMKyugPFqPWHXLy0QZnGGqvehDyWnyEKHZpjq/+4zYllgaGDwXF4A==
X-Google-Smtp-Source: AGHT+IGI0DP0i0rqGZMWWOtEAHrirh18Yf6gwQ7do8d3U7S/djkH1D2ZsjsJ7YSFeLOsK/7NNP38Hw==
X-Received: by 2002:a17:907:e9e:b0:a7a:afe8:1020 with SMTP id a640c23a62f3a-a80aa5dd4bbmr540676366b.31.1723409742530;
        Sun, 11 Aug 2024 13:55:42 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fe69sm171776466b.43.2024.08.11.13.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:55:42 -0700 (PDT)
Message-ID: <91c776d8-2ace-4ffe-8a34-9e3c9c990f35@gmail.com>
Date: Sun, 11 Aug 2024 23:55:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 04/20] wifi: rtw88: Extend the init table parsing for
 RTL8812AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chips supported so far only use the first condition, and so the
parsing code ignores the second condition. RTL8812AU's init tables use
the second condition also. Make the parsing code check it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 15 ++++++
 drivers/net/wireless/realtek/rtw88/phy.c  | 57 ++++++++++++++++++++---
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index baf3098e93ba..c827320c1b9b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1837,6 +1837,20 @@ struct rtw_phy_cond {
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
@@ -1918,6 +1932,7 @@ struct rtw_hal {
 	u8 oem_id;
 	u8 pkg_type;
 	struct rtw_phy_cond phy_cond;
+	struct rtw_phy_cond2 phy_cond2;
 	bool rfe_btg;
 
 	u8 ps_mode;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 37ef80c9091d..70f3cf06323b 100644
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
 
@@ -1042,6 +1045,7 @@ void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg)
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_phy_cond cond = {0};
+	struct rtw_phy_cond2 cond2 = {0};
 
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
@@ -1091,6 +1134,7 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 	const union phy_table_tile *p = tbl->data;
 	const union phy_table_tile *end = p + tbl->size / 2;
 	struct rtw_phy_cond pos_cond = {0};
+	struct rtw_phy_cond2 pos_cond2 = {0};
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


