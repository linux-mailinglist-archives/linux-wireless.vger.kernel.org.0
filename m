Return-Path: <linux-wireless+bounces-13905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058F99ADB0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A79B2812AF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8231CC162;
	Fri, 11 Oct 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQz4OpXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834B199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679716; cv=none; b=gZq3FcForsrspEj3to79EDdmtqOFgh2hGkBafoTLoJwxxSNdMx9UEoHmqjASctn6Ld8fgcp6FRl4SVfbUHIR1jTZwuCW08ORqurs/zb1YJ0cT6SaUR08hX8zypHUlq3IrmsaFH9feubsd8Afv8epr24Cr5dZi5n3MxHRavljb3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679716; c=relaxed/simple;
	bh=KuiZSuQw/EKItmGgkfbfeArDeOsG6zsacK1JyEkvGcA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aUTQVCfQUhvE3p3gbRTrpv3NBeK1UIAAtrCotBXC9+FUhhrdp2G96Jioeha8DKrr6YRdiYURd61GXeEOqaekxGkHyJpeu7Rfv5tFjogcbDRhdTWX3Fsvj7xZfx7Ub5rxGeazEqLev9PEzYxEMBgn0KhoZbTT4aVlqglf2/fI6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQz4OpXC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43118c9a955so17458035e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679713; x=1729284513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tN/yQNtjPjLE8WyClrMj2SdwBcaYVAAqYPfU0KY/CnI=;
        b=BQz4OpXCCIKSiFn9USPoAD6jXS0maJNqPmMVE0GRKVwiIS5boIajkK86H9fSGXGd0L
         4Am+ymAZl/PgwUQQU9q+EB+IZoyQlPK61zGceIQehDN/wd1WPr6C02ticl21HodbIzPs
         DLBSSp40kJHUX+k/x1oYy1GrTjbQdw4bL3lasP8JfgXOUcQd/9xpytT/6LieNfYX1DcX
         VlupSwPeZdaznv3JE3/AyAClAWy48Egs3DHxpjXfF53R6Ce/0ruW64g+M3GEG2CM776i
         fR5MkRpPOp+9yZEMb8g7lYL7LS7H7zvR0VWf7dJ1iZ9svJVaEaVT6OIZBZrmafbjyBE7
         puew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679713; x=1729284513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tN/yQNtjPjLE8WyClrMj2SdwBcaYVAAqYPfU0KY/CnI=;
        b=J8x6dOxtXsQri8v8Cw9kABLThrun5qXvinGHXPGe+KO0f+j9eD58RntZeeM0EtY849
         Fs7VBO4zI+t08pYqmfWv/vmoHUJf6HKxIMKo7AL5oKEyixteuFlbiaUGhRh2ClzZYvQg
         iLTvXW8K7G4NR1GkFIdpO2Vn1YAfCrTiIK11FWKfeu5zT5r9KZPRoIeiKeiOFZJAOjlg
         Isu/KErZCINsIthZ8kRwslvBA3v9eEE5E81wg9TUBYuLSZnVCtwrSckNbpY9SrKyWkWm
         zPwURe5JpTgOIdj/Vxd0P23qyX0Sbt4KZ9Iyiz8pBphl8rT3jylQJgrX8GyMsq0YR2yC
         m0oQ==
X-Gm-Message-State: AOJu0YxQRk24nUNpSBccAlHLW0NDqHT5LmWl106MA6bnblsIiLJlL201
	vStKOlF/GBUZZ2cD20/Dfvg9C/qGAIYdhN22y5zpvP0bJ8bN6V+0jQgMHA==
X-Google-Smtp-Source: AGHT+IF4LA/JfykD6N36n9C9XtoxvUWSFCiOHNfcHGJGTmcb0jRkgGwPuGwCgVDQyRz4pTZHn1aJpA==
X-Received: by 2002:adf:f38b:0:b0:37d:3541:5643 with SMTP id ffacd0b85a97d-37d552cb091mr2473611f8f.51.1728679713260;
        Fri, 11 Oct 2024 13:48:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa0asm4709544f8f.83.2024.10.11.13.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:48:32 -0700 (PDT)
Message-ID: <ef1b6e96-83fd-4a95-b5b1-85039e7b77e8@gmail.com>
Date: Fri, 11 Oct 2024 23:48:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 05/22] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be
 NULL
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821A doesn't have this. Trying to use it results in error messages,
so don't try if ltecoex_addr is NULL.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/coex.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index a99776af56c2..13096fa7025c 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -950,12 +950,18 @@ static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
 
 static void rtw_coex_set_gnt_bt(struct rtw_dev *rtwdev, u8 state)
 {
+	if (!rtwdev->chip->ltecoex_addr)
+		return;
+
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0xc000, state);
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0c00, state);
 }
 
 static void rtw_coex_set_gnt_wl(struct rtw_dev *rtwdev, u8 state)
 {
+	if (!rtwdev->chip->ltecoex_addr)
+		return;
+
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x3000, state);
 	rtw_coex_write_indirect_reg(rtwdev, LTE_COEX_CTRL, 0x0300, state);
 }
@@ -3904,7 +3910,7 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	u8 sys_lte;
 	u16 score_board_WB, score_board_BW;
 	u32 wl_reg_6c0, wl_reg_6c4, wl_reg_6c8, wl_reg_778, wl_reg_6cc;
-	u32 lte_coex, bt_coex;
+	u32 lte_coex = 0, bt_coex = 0;
 	int i;
 
 	score_board_BW = rtw_coex_read_scbd(rtwdev);
@@ -3916,8 +3922,10 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	wl_reg_778 = rtw_read8(rtwdev, REG_BT_STAT_CTRL);
 
 	sys_lte = rtw_read8(rtwdev, 0x73);
-	lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
-	bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
+	if (rtwdev->chip->ltecoex_addr) {
+		lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
+		bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
+	}
 
 	if (!coex_stat->wl_under_ips &&
 	    (!coex_stat->wl_under_lps || coex_stat->wl_force_lps_ctrl) &&
-- 
2.46.0


