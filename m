Return-Path: <linux-wireless+bounces-14395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B69ACBEA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35A91C20D1B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF311AE014;
	Wed, 23 Oct 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU6rR7Is"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4B1B86F7
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692509; cv=none; b=N+76z1mORFF3Q77FE2ZLzXjWdqBFeJcN8yd66Y392NwBupaU56e9qslxM8gF61MRTeQ/WCaygKM0dxkVwMqmXCqMcq72pNSLrWJoIDhawmU4iOd1fY+PhP+y58ox9l1ftRlVoUEFQBEsPiSiZxKws8SdbfMcYR3IlusC8SJJC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692509; c=relaxed/simple;
	bh=/knmoZmfe78elWM/HVo9W18+JFZb82rnd4ppvDk2YeU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e8dAHKBN8IFJC+rpxxdpG7LnOSskDn2yz3Nq9hF02r2Ar5/buonZcBROuE7agZ4awPvRaZ/4wrV528lsZWN6ZaSquqIvl0bQE4iFm5zrn96/wLV0f9gGV01YR1HdkGX8v04iZx/oAR3WjfBsg9VJiD6OO94myDw2gBQj9hTCQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU6rR7Is; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so7249813a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692506; x=1730297306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CberAkrAt5G7MtIQGyhCmTizI+ppLFAydWgmdPdShHs=;
        b=eU6rR7Is5tQy3YiBpyGn0LD6GgXfLocq2OxsoMoOWgFsV5t6i9qJJWJkd006dHj7yJ
         u/haf7aqoQV24CLhC5GAUyIsBAPuW7q67tFJblkfzM8MzkM505w7/4InOaLUkdxnJrBu
         dpaJMhJUfA0xNN662gicRzzc8B/vR5Lhr2th+JGz4y47feMVLU+SeMopfIXwMDgSPnlY
         Lgk22uJdGn/PWEbWq8dnpIPgPvRYgpm8sO7RgVOD+QRnDuuz7CvpRebhhrDR2KF90S0I
         aiHE6DjImNbh0r4I9yFySVQZLs4SueZA0Sx/Wp2PYpowt0++e0XPhwZfIaGXC4OXAdSg
         h5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692506; x=1730297306;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CberAkrAt5G7MtIQGyhCmTizI+ppLFAydWgmdPdShHs=;
        b=xHxwOCxdrgmbVtKRzu9wpbLLNLy2bg7cvjdWtRmAcK5+OaTn1ZAbwoxGcWppHKB8E/
         jLqgJrWleauXFizTpNrHpX7YlmeDsVdmYmMct5AUCCv7zAMroq4Vqa4p7LWS0C6dJCan
         LDWDypaQEcveyP8a4zcX3RAOW0altwu7liBfEI9NorYzfFTIWASjbY8WvbJau7M67SZg
         LBinKA651qi2pZiOylswMNI6+qXNtoMDha7J6YqzHNj9bn05rt3fwxfWDBGLZdVeHpWE
         wadw+hSnpbm65AqAYf/s67hdE+RkyV+FWgPpYXkNm5bmand8XKUPuMyAIxQn5VOgQuSG
         Zzlg==
X-Gm-Message-State: AOJu0YzxSuxWudi7zhQntTB82yqpK16kxm4UDv4cltLh0ll5QxuC61Lx
	64eqh/PRxStIzvzXfVgDguAffWXyBPNQSxdB5W5YYoySjDHLoc3igMBnxg==
X-Google-Smtp-Source: AGHT+IEKZEzQpFdjpUjrCbiIaVGG0QQIaRTxWeBG5/zS82yvXGKhu1d9vOfmlZp88kTmQ9gmv3JCLA==
X-Received: by 2002:a05:6402:280d:b0:5c9:62c3:e7fd with SMTP id 4fb4d7f45d1cf-5cb8acecbbamr2582829a12.16.1729692506297;
        Wed, 23 Oct 2024 07:08:26 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a734sm4496255a12.58.2024.10.23.07.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:08:26 -0700 (PDT)
Message-ID: <1bee6b74-6eab-44a3-9f40-794ca006c72d@gmail.com>
Date: Wed, 23 Oct 2024 17:08:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 04/22] wifi: rtw88: Extend the init table parsing for
 RTL8812AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The chips supported so far only use the first condition, and so the
parsing code ignores the second condition. RTL8812AU's init tables use
the second condition also. Make the parsing code check it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Initialise structs with {} instead of {0}.

v3:
 - Check for !(cond.rfe & 0x0f) in order to reduce the indentation
   level.
---
 drivers/net/wireless/realtek/rtw88/main.h | 15 ++++++
 drivers/net/wireless/realtek/rtw88/phy.c  | 62 ++++++++++++++++++++---
 2 files changed, 69 insertions(+), 8 deletions(-)

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
index d57a2aabd89b..739c619460ca 100644
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
@@ -1080,8 +1103,29 @@ static bool check_positive(struct rtw_dev *rtwdev, struct rtw_phy_cond cond)
 	if (cond.intf && cond.intf != drv_cond.intf)
 		return false;
 
-	if (cond.rfe != drv_cond.rfe)
-		return false;
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8812A ||
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8821A) {
+		if (!(cond.rfe & 0x0f))
+			return true;
+
+		if ((cond.rfe & drv_cond.rfe) != cond.rfe)
+			return false;
+
+		if ((cond.rfe & BIT(0)) && cond2.type_glna != drv_cond2.type_glna)
+			return false;
+
+		if ((cond.rfe & BIT(1)) && cond2.type_gpa != drv_cond2.type_gpa)
+			return false;
+
+		if ((cond.rfe & BIT(2)) && cond2.type_alna != drv_cond2.type_alna)
+			return false;
+
+		if ((cond.rfe & BIT(3)) && cond2.type_apa != drv_cond2.type_apa)
+			return false;
+	} else {
+		if (cond.rfe != drv_cond.rfe)
+			return false;
+	}
 
 	return true;
 }
@@ -1090,7 +1134,8 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 {
 	const union phy_table_tile *p = tbl->data;
 	const union phy_table_tile *end = p + tbl->size / 2;
-	struct rtw_phy_cond pos_cond = {0};
+	struct rtw_phy_cond pos_cond = {};
+	struct rtw_phy_cond2 pos_cond2 = {};
 	bool is_matched = true, is_skipped = false;
 
 	BUILD_BUG_ON(sizeof(union phy_table_tile) != sizeof(struct phy_cfg_pair));
@@ -1109,11 +1154,12 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
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


