Return-Path: <linux-wireless+bounces-24674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE5AEE867
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4740317E590
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D7621A43D;
	Mon, 30 Jun 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyiqXxV0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43653F9FB
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316063; cv=none; b=QuTavSHYCavohULbnk+PVlHIcIDSXQjjj9tI2hPdfcuXhn/K14N5GfeJoxYbVxzYiyXEZMzzD1ZGfaj4xwYHHlQy31Vz88th86O0NHLny8bJswrO8YECv/1d+2mUwSD48bH0Yj6xAu8slTFxCtn458/2StQLh1KxOXJYwVzoq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316063; c=relaxed/simple;
	bh=tqkoqn7y0X5U4yZGGyhbzcXdxnLTXQbDs1n8zdbOZMw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TFuCrBTYAgpG0rl8qRaYydW2wtRRjkuXwefLJe0JcmfCTJVPfVjZxCLoQIovo4+020qVfRrGi5oiKTIB5k1A+Wq/5mTbTM+htLi21DugR1tDOnLSNr0J6v9Aq7BIh6BjTMMTsSdt64sMgdlMYeZurvTmLLpZzYA1xIlbrkoZn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyiqXxV0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so34485095e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316060; x=1751920860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rj3wINvrPhWdB63gAHOXjzJc2oYjWS3vEJan0tHdNk=;
        b=NyiqXxV0yfII0UW8/aMskjgJQxzMdU9KGem6oBvJfTD+luYC4/v6x+arCAnDHsPevb
         Y1Y+op5+ha0YzQQjC/26iipqs1tKFk3WfZ5bM+ZklflCgEAWxPFD5ZtyeVLTugPfsByS
         Brem7mZP2cuktCgd/7x1r4iDpaBdoWbFwHKQzrj3nl3hfv170sIJI4UtPnqKxV3Aq+hA
         Hn1rgHOcDJp87INf4ffAvaleozOD102JrMu7JDrMsqvRbERZ4dPpnxN3RF+WlESJff1o
         dXbBsTDUxMYoju49rs64Tja6Jas/MEAdEy5bS4mMMjZHO/Dx3cJwUqiKUoHTlBZxnyg4
         GHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316060; x=1751920860;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rj3wINvrPhWdB63gAHOXjzJc2oYjWS3vEJan0tHdNk=;
        b=ISQlSxm9yiJcZuQAFIBk/fUkYxsC7rgXsipa5S4DM8hQiivgzcJJiJzDS2jSiJ1OvC
         i2I8Uix9BnxcdDZsDDw2znsUUk+fMKXV15utp0iHrMsQ+5bH8eLWHdgZRA8oMiViXiBs
         u6cOebw9XaXwzlHQoCD3TYnND4vHTl3p0/R2saxKJrp1DB/FuP2gYfm2zxQpevQBxkQV
         +FtUsEIdn6bKgyYWv1QZ7Fc76Li/9IZpoNVrw7C0OmkWG2J7jlEe1sBXFdKe6jOlQ5fh
         eV3tFf1PsWB5zNIkPnA5O2GiTQsMV1SjpZ25fbv4en1hACHYJ2uPLLjb76LCbAj+vf4h
         VrSg==
X-Gm-Message-State: AOJu0YzptY+vNgbn/VI1QnT1QLG0aNGcympO3lo9Pv3Xrry/qLblA6dn
	ugtfXJeS+vOy7XAUDAi4mYhRp3B9mjNFSG2sleTa838aUZH4b7eRoieqj0/v1g==
X-Gm-Gg: ASbGncsv+kNYTjXI2dpHci6bC6XoQDyiyQbx2zMc5Y2tR5xptbgJsGjH1+swDtqE4vE
	Ry51dXECtBoB2npYyHwMCkQf2yzSY7psPGMergE2IYXVdlV5dgCjLxVbowZNOloKMeW8MoNn1Xg
	sDbCDa5Mk9ST4ntIgD7nJEeLqGgTEYkl/kmn4f0RSZWI9jgo8ZQOvp0eTTKA22AJ0jshvgE0di2
	9ARYcswFuBym2fwmk6/agXW2/3Tw9tKFeMKejbNJ8LTT7EBHcf2pujTT/PwBHUZkECNP1jsg/Nu
	VUbqBBdGwWEdcNfbAfdw6PAMvMNcKooSXXRVkF1sicYBL3nlxAtbBc/bsFFI5jdt5Np4QQ==
X-Google-Smtp-Source: AGHT+IHh5ImUECpPXEb9o4H3oYGC2N1UZDCUDSCr9X49+p6MIdjBCQ1ALUp2CVuXutGdJWO8CQBwCA==
X-Received: by 2002:a05:600c:3590:b0:451:df07:d8e0 with SMTP id 5b1f17b1804b1-453a795346amr9055045e9.11.1751316059798;
        Mon, 30 Jun 2025 13:40:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e598ddsm11256823f8f.78.2025.06.30.13.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:40:59 -0700 (PDT)
Message-ID: <6b2a1382-3be4-4038-8005-cf96922e4332@gmail.com>
Date: Mon, 30 Jun 2025 23:40:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 01/14] wifi: rtw89: 8851b: Accept USB devices and
 load their MAC address
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make rtw8851b_read_efuse() accept USB devices and load the MAC address
from the correct offset.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c55833f259de..823c3994fa56 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -461,14 +461,6 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static void rtw8851b_efuse_parsing(struct rtw89_efuse *efuse,
-				   struct rtw8851b_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-	efuse->rfe_type = map->rfe_type;
-	efuse->xtal_cap = map->xtal_k;
-}
-
 static void rtw8851b_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8851b_efuse *map)
 {
@@ -549,12 +541,18 @@ static int rtw8851b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		rtw8851b_efuse_parsing(efuse, map);
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


