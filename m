Return-Path: <linux-wireless+bounces-24733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F62AEFEE8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55311164E43
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3318927FB3B;
	Tue,  1 Jul 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYJ9GLZU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F027E7DE
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385731; cv=none; b=Ug31nOT22cPLoZ0QYcFuk9TSQIQFHYIkkGn02PyT8YfgCeof2Z52c2/KCKgQ9/CM/STFoWVLoemQpk9AzuO3VxhI2x5iviJEJ0r/BWMC5UsefwPEukn3EBQ/TqwIMgilD+ckmENGhXND2pbGMpmPDyfxZPMZGwGNJCaejc13lOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385731; c=relaxed/simple;
	bh=I8if2S2Pm4D50LD63cx/fGk1nCz4jjZDT2+opQ1GmbE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dqH/j15UOLdiGsm4VmK3gLLRYOGPsEdhhtDH9E5yoL62d3mwxggJM0Wvg3DYHsCoVHRHv5F7ngBusqQjLPfV2mRrXgdN8Eb2F/igod1oXG3FiI2VmgfpWY3Uu1WUxwaIg3Z/5LPuxoy9sD0lld/kczWRq+Jozhjqkqzt/iQywbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYJ9GLZU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3764848f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385726; x=1751990526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cjMGiLU6ShnmXUQNL/bbHMo7YrIpnpGbmcZVIsZRl8=;
        b=LYJ9GLZUJjrvTdgI0Nu3RlWI2xOigzQ9tR3sQulk/sJhQQD5Cx31uKY7+nDPF8tm3S
         AsAvl3rpuMFOwyun9rStKZj+lGMtw4N1X47ORikMBne6YWDznhn+Pyqdw1UA2bYOwxCF
         x1/xZ0kI2yR1WmPfNdfGsZrk71FQOjtoRDJ+Wko99NBqNyWW2u+5gciPpH4BUl8gGsps
         hMPGRkefbayP43/1El+s+53MEx/x0kZH0oBYL2y1Su96H7ljM6AGypQBGB9po6N4pV42
         gRS2SI24C6oRzT2fI6VYABBIbZkZxS2BA13wqgawFrYeuUuprF66MqXyY0/TAiHNzfdM
         L9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385726; x=1751990526;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cjMGiLU6ShnmXUQNL/bbHMo7YrIpnpGbmcZVIsZRl8=;
        b=dmfAEFe2kxOVAdT0Y/NcNwJ2buUfVr08dGXmedf9GJ81vOWxJtPjlSUqFCiPvUydoO
         gll+xTqCmM8xD/gTkeTO1FvmROdqJRcsAmC1nBkru2ui0fsNBlM68G5DVMaG5xUTedGJ
         0cPSAHbg3ukE1034TZk1ofV/dGlhYEiBJ7oI4jEpndgVyxGqtu2d5vor3bLcohRHYs23
         DvFz7/CrvORY+VbaEPeaKtal1dQRkLyAnuypXdF9EngUpnRxJogKcB8OiOaQnrIQCeSI
         +ovNW2US6C+VRTw0ecd0pNb9BqjV1wPtIo8MPNbc/k0wAOyELiKHg4p00Nw7f/q+mS8H
         bsRg==
X-Gm-Message-State: AOJu0YzUqPMcdnTiIxdX+nbpHWyzIlaw0oRgiEWrNsYr84h+GDezxvpc
	sFfSgUxv/A1fbzpG7ATsXF0mFhAwX8Ue6r1DDYloREn8vxR3fuP9lVK221q9+g==
X-Gm-Gg: ASbGncvsuyQPJ8ncrgeT5INmMFt1oB9PXvr0Q7HfZSwRtv0KSp1YrGNiJ/KVqZ3KxMH
	WkirvajAuZzjWh6JhDBX9OKYLifLORG7Rqb5F15zvtXEPlQ5ZM4mohqrYYluS1wiSXy4ELwQaUo
	1pHVJquBMWTNilo72Kq1zN6tU3MWlW0ec9JhXMrePGvWU2TGzs/3rl+QmvHmsQW6n8cL2BT6fTZ
	x9M8Q3C1rqKDSf8Y6fatfVCiVJ+ywFsVEYRrn9trqNeNhUDpYNEpGSR+hlm4UtNNwmlCOeiZJTL
	iVtwUprVce6luARa/QU0P9LgWxjoaaX5e33ODkgI5NASvDEldi88T26Ck23WxxQoRd1azg==
X-Google-Smtp-Source: AGHT+IHM92cU6P91pfNZd1TMC3o0xXAyNOJGFpUnWMqn9qU8oJKaEjlyauc+/GSZC2FjHat4JFBdug==
X-Received: by 2002:a05:6000:2d81:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a8f435e16dmr10838323f8f.4.1751385724850;
        Tue, 01 Jul 2025 09:02:04 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c99sm13467067f8f.49.2025.07.01.09.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:02:04 -0700 (PDT)
Message-ID: <b4ab007f-078e-4e06-965e-d6e4dd43124f@gmail.com>
Date: Tue, 1 Jul 2025 19:02:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 1/6] wifi: rtw89: 8852bx: Accept USB devices and load
 their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Language: en-US
In-Reply-To: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make __rtw8852bx_read_efuse() accept USB devices and load the MAC
address from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../net/wireless/realtek/rtw89/rtw8852b_common.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 0cf03f18cbb1..3fb2972ae6f6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -172,14 +172,6 @@ static const struct rtw89_reg3_def rtw8852bx_btc_preagc_dis_defs[] = {
 
 static DECLARE_PHY_REG3_TBL(rtw8852bx_btc_preagc_dis_defs);
 
-static void rtw8852be_efuse_parsing(struct rtw89_efuse *efuse,
-				    struct rtw8852bx_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8852bx_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					 struct rtw8852bx_efuse *map)
 {
@@ -261,12 +253,18 @@ static int __rtw8852bx_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8852be_efuse_parsing(efuse, map);
+		ether_addr_copy(efuse->addr, map->e.mac_addr);
+		break;
+	case RTW89_HCI_TYPE_USB:
+		ether_addr_copy(efuse->addr, map->u.mac_addr);
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+
 	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
 
 	return 0;
-- 
2.49.0


