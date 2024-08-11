Return-Path: <linux-wireless+bounces-11276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B394E326
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172F1280F42
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826D136352;
	Sun, 11 Aug 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hduv2qo7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92C79F4
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409830; cv=none; b=MhC4Vr5TJ4C8i+vmDFzYYGW5O7KSwBtjcV4T8wEBgXDaeO0Hqu8nGXnoW3x3NT0JpT3NQvw+wKaWZCV5fHDRrpsHeQSyfRrsOD/OQ5vMCyM0Umg4tzCcqYiN5Kqx2P4l+9mWZd6iOfZ+Bu5ns/3OkOFujf1GfHQTXhb8tpIGTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409830; c=relaxed/simple;
	bh=IvMn9VdrhZvo1Z3fRbPFi+gRD/qsLdO2PtmZthGeDK8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WRYSXotRpRDFNlcAH9saprTdv2k5UNV6b4KKNHIfjvuCozUw5v4hIN1guFUCLsUIX7G6U348r48PIYcXMA8f1nhHM5hkAqLHWi9jIPYosMU9P6+NBoxjiPQkIEd/vHIKDjzf1m7kRExlR4MkHPSYN5XTECuMgXoyczQMKFZNnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hduv2qo7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so5106422e87.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409827; x=1724014627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zgMOW41NITJEZRX0OYRcA2kvW/49W9j04j2Ln9BYDg=;
        b=hduv2qo7LfeEzDE6TBfJiol0nPizCLHhLEI9hpcDZXNv8Q96JTUfUTe2RSFy0UZlx8
         aovskD9ew+8f1QMC3RnbuUTtkg5nXo3wZI4FT1MAl9cULWIGHQycLetJrWKqHKJI7Ygo
         U1/BEJPqFBv/MzZQIYEVO4z5FxrdhFREMm2V7SFSfuyV6tYDanjcPu2kS15ppf9inWB2
         NNTgUUduSQr4YWSdcSBS+cS6mtWLrEhuM50Nkz72QpNMyGwF4MxqRZvRm1xj4uIkRwJY
         /yNLwEV5SkWBl+aO/etQ6tdPqq6I8z2COptP77nUZJkeR3LdiBhFPQdZ8CXSYxDPZuBP
         q0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409827; x=1724014627;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zgMOW41NITJEZRX0OYRcA2kvW/49W9j04j2Ln9BYDg=;
        b=r+HQjR7+a8BCJWFPRGWnVnr48Oj4E8PRJhPhOgET8VO88u2qpX/cWMNT+vk72ymveG
         ve9NrqghgMVPb9nJPXyPRg2dSPT2lXn/q/wKOyA5noOIbfwo5IAiGfpunviwylH7qk8q
         cr0LTfvYqQ5+zYmZCvLtg7LG9hkkaec/UWunK5LfjRDLCBJWAIBPw8DnEuhl0Zrna7fB
         NSTCyf62Ca93Qdf8Rnl8H9mrdTt2EAhSRqaqd8UZsiUb6oOhdmJVXhJcL95htUEXVwtl
         td3tZUdmkzEDyt/FhkDPfAO5Aq1zGuQpHD3GB2xoXT+4I97EVCYsNggviHYu5RtYQAon
         hrjg==
X-Gm-Message-State: AOJu0Yw/CUqMLkGStKxWPPIkaGd/wdG8jEnOHDohj4/RqbViKjBrfry0
	fOXFfY6/GnKNWsn3Jl4uvMDye7j9rZm3uoefcj4mtolB5uaezmgddNrXJg==
X-Google-Smtp-Source: AGHT+IHI3OJgJBELdCe5ukIFA/CQIR6zE7iXHkIKDXKq5W6ghLEnw0hfCK+hGTeSaHgovuczjUXmnQ==
X-Received: by 2002:a05:6512:33d1:b0:52e:fdeb:9381 with SMTP id 2adb3069b0e04-530eea25081mr4985613e87.43.1723409826245;
        Sun, 11 Aug 2024 13:57:06 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb213798sm171147966b.182.2024.08.11.13.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:57:05 -0700 (PDT)
Message-ID: <6d4194e2-8c8c-4d37-9b44-aada8d1d519f@gmail.com>
Date: Sun, 11 Aug 2024 23:57:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 05/20] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be
 NULL
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821A doesn't have this. Trying to use it results in error messages,
so don't try if ltecoex_addr is NULL.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index de3332eb7a22..47d32a6f3345 100644
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
@@ -3922,7 +3928,7 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	u8 sys_lte;
 	u16 score_board_WB, score_board_BW;
 	u32 wl_reg_6c0, wl_reg_6c4, wl_reg_6c8, wl_reg_778, wl_reg_6cc;
-	u32 lte_coex, bt_coex;
+	u32 lte_coex = 0, bt_coex = 0;
 	int i;
 
 	score_board_BW = rtw_coex_read_scbd(rtwdev);
@@ -3934,8 +3940,10 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
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


