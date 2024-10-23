Return-Path: <linux-wireless+bounces-14396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32A9ACBED
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169E5283741
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E1146018;
	Wed, 23 Oct 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MArVHLXy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536351BD4E1
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692550; cv=none; b=ljU+Yo5uZ7TLA9wujt48gQLxH/7sXXpLuQiUz8aVRXEp62zRwo7Hwu5/R1T0Gzc14GYiKC18LTuj0kRz6FCXSBLQ34UKxMIpNwXcCfI6sgHyqVltXn5P0kLB5oiP6aNQRxNalH16fP1eFj9Vva9ugVXKCCHwnOzIrlOg2vA5e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692550; c=relaxed/simple;
	bh=K/RGMe7nj1swC3vxCmlZPwNecjJFoW5RUMsAr8JQxp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qmp+9+qNAJcIz+2Vt8LWSluftNdtAfgBqWgeLW3EAzj3jNyJvRKpK5Q4ee4NoVAm6S99Aw+E3pVY5Ay39HbmTe/Cc+qjnU+P9QA6wM0Ds/ydSsmGqDjorpq+Yy5IKE3XiFvYocBAK/NO2l0uyFoONGT54Qz1JVz/Cyi0FMZg/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MArVHLXy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so943291a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692547; x=1730297347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xlIlRcWd81fB7b9jUxCOPudXC2qgp6+JWB2kzpDBeOY=;
        b=MArVHLXyRWcp61Nx2BCaYthdJUUHhToZGoj3AtpHRK0CkS6dJTtX6vFIAy8+hkaVwj
         dQm/4yz7V9D1oqpQpcENd7tbAkVoNFgPFrUDv5gOJZbXDhHMiM+bAHUITIU+vMWryn7f
         gXljRbwOgQfAD5kbbCDzsAxJHjDdOCatodgZSHGZqZSTykHt3insmjInSIECcWZSpBW8
         fiZ5C1PI/7QnWLRGHgiS+vENJtcaAQw+JLEfeHglKhocw9qwD2ops2Kb6qC1/1p2vKVj
         9ezEVnPAtbX+j08C7ZhmM5meiEIzxD5P2Iq7VsIYliPOASdSH5VdulorizJcL4LewSRA
         U2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692547; x=1730297347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlIlRcWd81fB7b9jUxCOPudXC2qgp6+JWB2kzpDBeOY=;
        b=Q4EqEaeV8OxJcfra1XudubXsl6qNciQkX4EnVKqbIudmx2v2a3vUu1K9Kix2/SXh7W
         +qAyqivA0UL4dP/WvKCtoneGQixrg4Rj//6TvxHnv3+TyToCTknT5P3bGHxhb55ENhvO
         vqK6U0jcr6ZFW8Wvd/+sOyZ2RoB7W5FNypSu4jj4bLioqLBFzOHs94JKfpUhYGzMVBuZ
         L3monweDJQjdAtukOpFMxdAYUOT+P18Z/KC0Uo4p8tbwYfySxJli2BPL8g/3LOxywM+8
         vQK/Wd5OAizY5OFUZcXEkoftufN1U5WI8KNXD4bCkozu4mz94+WPr08r4sA5AAetJpSw
         cWeA==
X-Gm-Message-State: AOJu0YyycIYJ0m2JRqWtDvMQohA+9GNKmzQ1WbMcRhjp44cKdV3LRGtI
	tlgsgD0f+xEEy/TqkmoC45D06Xq8QBkC75YNFxfyTAIv0rMEzVYu8AfvCw==
X-Google-Smtp-Source: AGHT+IHG4t803OlqsvLkV+AXLqvPRN8jgIzmcQ/8P0HQNPixI/WxyADIXOvGvE994WpPwbFAeS1nsQ==
X-Received: by 2002:a05:6402:d07:b0:5c8:bbc3:9dff with SMTP id 4fb4d7f45d1cf-5cb8b510457mr2984783a12.5.1729692546543;
        Wed, 23 Oct 2024 07:09:06 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b553sm4504326a12.3.2024.10.23.07.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:09:06 -0700 (PDT)
Message-ID: <d1004817-1760-41d1-9136-3d799757c444@gmail.com>
Date: Wed, 23 Oct 2024 17:09:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 05/22] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be
 NULL
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821A doesn't have this. Trying to use it results in error messages,
so don't try if ltecoex_addr is NULL.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.

v3:
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


