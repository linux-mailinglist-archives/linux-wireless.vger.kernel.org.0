Return-Path: <linux-wireless+bounces-23899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F567AD26BD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FE188944C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8A1CD1E1;
	Mon,  9 Jun 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXIt/KN0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E9145B25
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497372; cv=none; b=jYK2pzR2lehiaQ2c3CC9rWYppvY6izljc3LsYz7WVs3a5113AQcudRdztfxfRntdxha1m5wG1L3M9K89HjxSWrHVlO21slUOwYP/0anmOJ8R5bXX4D+HzoLYCHn94AyxDSJsRby1IdJLjKYOtxD0g1WtGxOUwWKq+IiJbV0J8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497372; c=relaxed/simple;
	bh=WsJ62ab6FlciHrU9PObjSVCQj9lmy8ZeO1TBjfKIOH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jYvSOhDBBC05Sap225eYNBbNd+j2ZDzzQHtkUQoojttSgnyACm01CgMi7jzMaAkI8I4d6IH6+x6r+135cO09PXGFIE14GdrOvF/IH7LSJZlB7Mq0IWOlWkMYUc1uDvWPyEjm4sxI+G5p2IZppZDI0BQgkAaQYUoOROvH8o7RIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXIt/KN0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so8033142a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497370; x=1750102170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhUB7RftpmwHWGfjyASjgengEyioY0Z4TfCTEFo+R3I=;
        b=LXIt/KN0/uAl/6Pn/wJJAZcubSIe0Pk2YkNi5le6VMmBbrGETWymaNxR/0iU0rEv+V
         Qhepc2pyfp2oweCUPQho+1NZzCYQ0Qigf818OFBTFMnaHZcS2kTNbYLf24JOzKOhu535
         Dq76b5DaVhrqQbdWslfR+zxqVFdf1TenWMidh5WULslcpJuILjhk6i+Qy3OssKnmG+tF
         H49itbWAydOa3glwqErl1jC9lCjAa/TaFR/+eZXcK5smgNxHyAdt85+WjnaZuhtoq6lg
         8U7OjOvno7jqcwPK8RLfm6oIEpbZJicICqt3aRsD65NEfKxYVgDJY4Z1kj+pg/FBH7xQ
         6vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497370; x=1750102170;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhUB7RftpmwHWGfjyASjgengEyioY0Z4TfCTEFo+R3I=;
        b=ek2OU1Xv77ob/d5IDGRMHg4MmvHEhQQ2kLfzybN1OM4/zsIOwzmiAxwm5ZGkHCMraj
         Uv0jsumkgsUXHsLN68RWJmSWYMtlvNnFoB9y46esEClVJ8Dbz1er4BO8j3QHROM7LgSI
         gjlTKyuwK29lq9jDH0k74sE30pQ5dKma0mvWgjS2bH4Tj6I29AUEPLB0G7SNhYnfxcjs
         WKuSG6oFaky+57Eb3wVp/USbsSqgJEOFavkJ80L1ML+ypFZ3n4RDIzeybQebLpyRM2IG
         yGbYo4wHJPE1LWFLbr85NBWnBrArXyYEHcmTh2i2ic4hJDYkrwWBpruwVDtRF8Btdqmz
         nPJA==
X-Gm-Message-State: AOJu0Yz0G9xQiH87fvteGZX+bMLS8fhw9p9yUXeUR62MohLJvpAqQvvG
	9N0yyAx1NGodLZYJAjLTemAZ9eHoA1NXsNV62jgkf2gb/ot3X0IkcN8yz9laHw==
X-Gm-Gg: ASbGnct20QdPpfOuyoGncsy2peFXEa15+v4NIEQ5lWq5k1jWMRs43KtxxOgYLvugkIQ
	20HOHMluIhJYw0RJLbhXNendboSRY1WxzIyR/kkLRFxN1IDqNAYJHrmWnRj7D7D7zl59nDsXwkl
	Id9ACo/2/gwhMSOKpdDnlC/cX3+7/dsiuUZDy7B7wjfUoPZFb1lxmjUWv2HJZSsqbKuATC5Ky21
	T/cQV1V6wQWXKZa5yMbh4NflUl8wBD2dCqXyVR3PWrQFte0MDDh6kDiKs0X11EFoVJL3Y6JboIK
	/LA8QiditgAHQN5lINdXOeXO+SExmlqBjbrrnYR7tDKYmgchnqSuZdkZXTQGHAzfw3+D/g==
X-Google-Smtp-Source: AGHT+IE0unOzn3aF4/nXqna15HdvDBk8JzUIT0HiBdimGD8fBnber+U7VjKwV7Bkk4dJ0AbH5lpfmg==
X-Received: by 2002:a17:907:da3:b0:ad8:9909:20aa with SMTP id a640c23a62f3a-ade1ab0872emr1402648066b.40.1749497369573;
        Mon, 09 Jun 2025 12:29:29 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b25dsm588265666b.156.2025.06.09.12.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:29:29 -0700 (PDT)
Message-ID: <9f307332-928c-475e-9545-8dddcb33aa08@gmail.com>
Date: Mon, 9 Jun 2025 22:29:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 08/14] wifi: rtw89: Hide some errors when the
 device is unplugged
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few unnecessary error messages are printed when the device is
unplugged. "read swsi busy" in particular can appear ~1000 times when
RTL8851BU is unplugged.

Add a new flag RTW89_FLAG_UNPLUGGED and print some error messages only
when this flag is not set. The new USB driver will set the flag when
the device is unplugged.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c  |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d4c7b47c3ba6..3f0ca65431ef 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4927,6 +4927,7 @@ enum rtw89_flags {
 	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
+	RTW89_FLAG_UNPLUGGED,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2cebde9e9229..875c1a3c5ca8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -88,7 +88,7 @@ int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val)
 
 	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
 				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
-	if (ret)
+	if (ret && !test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
 		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
 
 	rtw89_write32(rtwdev, R_AX_LTE_WDATA, val);
@@ -104,7 +104,7 @@ int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val)
 
 	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
 				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
-	if (ret)
+	if (ret && !test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
 		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
 
 	rtw89_write32(rtwdev, R_AX_LTE_CTRL, 0x800F0000 | offset);
@@ -5885,13 +5885,15 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 
 	ret = rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_2, &val32);
 	if (ret) {
-		rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
 		return ret;
 	}
 	val32 = val32 & B_AX_WL_RX_CTRL;
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_2, val32);
 	if (ret) {
-		rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
 		return ret;
 	}
 
@@ -6015,7 +6017,8 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_1, val);
 	if (ret) {
-		rtw89_err(rtwdev, "Write LTE fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write LTE fail!\n");
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 76a2e26d4a10..87dc88ea38c4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -895,7 +895,8 @@ static u32 rtw89_phy_read_rf_a(struct rtw89_dev *rtwdev,
 				       30, false, rtwdev, R_SWSI_V1,
 				       B_SWSI_R_DATA_DONE_V1);
 	if (ret) {
-		rtw89_err(rtwdev, "read swsi busy\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "read swsi busy\n");
 		return INV_RF_DATA;
 	}
 
-- 
2.49.0


