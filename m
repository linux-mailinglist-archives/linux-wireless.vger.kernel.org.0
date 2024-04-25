Return-Path: <linux-wireless+bounces-6866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99138B27E5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CCEB225AF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125231509A2;
	Thu, 25 Apr 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp6+kNjl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE014F118
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068566; cv=none; b=H0NOWtSd5hPBQ/mQ4FASL367kEwLmXa1nCZ7KYgGs5cznAsnQ3GuJvwSDvzZtx+c1M4cEPbXdX71PtGEZeq8VeraztuRfiwTDZuuwayP2ESxIL8Cy2Sfp+6XwHePMYI+JqP3EvO+l6WDbXEmPMI0Y4kvkb8ZqNiMN239jaqSNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068566; c=relaxed/simple;
	bh=9W6jT4FlH60EUJEXBAImjRpE84dPClXciOWHK16juNU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VD2Mpi9tTgawQmgEnBMeLx73BP1W64escJcRPPetioukf7I9HNQC2dhcCZVp6ClqKkme7PTOYDFd6db01Lkz1pyOwRKp1OCgQiTunssp4lZ4d7zv+J84zBsDDAx5xPn4icctPEzFq76fJXw1w34xNCwLs1TYyDUGd74h11im/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp6+kNjl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so1986746a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068563; x=1714673363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYzpg8HQMkckI9ood2pyrAUO2Ua1NZitpYA8isI//9c=;
        b=Vp6+kNjl41WAPSDmuSsZrBmqjOaiFUEyrpE2PzVn+6QJ+Bdnk1aGrZex4EkWWsv64B
         SvxjHG2/2Zmj7VKEazMf0f4X2w+1TpUzVHx28KQ45dSUoTOmbKoWIk/Ijxqk66f2D9Jo
         k1JW8Y9HCaDhqg5KAZwdZNnjq4Fs/+SI3sveQFoPfFx7grQ/SYP8znBkkE+WxZvSSbvt
         aIjb2nafT43VPPOtYhiIpBfsos+3BgfavW9WCnekDhJUrpdqwoVI7Rk/zxkYeIP2qq/D
         4bV6h7l5KObtncbWve+780pb65nnvxXe2y/SjPH8rn+BOuqsVhPwMPkxLeLxOtgQF2aZ
         1u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068563; x=1714673363;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYzpg8HQMkckI9ood2pyrAUO2Ua1NZitpYA8isI//9c=;
        b=d3XW7RBMhGXKovYodkeZ4iyMFb76r7HmFuGvTD+W5z9kc2ULad6IyxlMNM7t1ijhpt
         7OgnpAN+NEI8tu+pfmx8BjY4E5vBfJ0OAq3vsdKNOTxl2oiXmAypD3VCa5z81S4g6K+O
         4IbZABSpmExo41vGoaNlyEHO+vikeBhg0kamYWpNxo58zU0r1ZnkoS44+4dqZ1PTzfHT
         VdmJRNLQFjoo81ybu/DUlXfhxK4h0SOxLIxLouchR6Yn/lU41EHzshI1QvX3NHHXXr2I
         L4FsUU872r3DD+ldA2779TqhXxb949KlXHbtmi9z8cBna+IKrXMjq3iM6fcjbqhM9+uu
         J8Hw==
X-Gm-Message-State: AOJu0YxJ3aZefO8p6KViLsfWAhrFFuWmWuvWa2aGjIb6B5jmkXeU28uv
	ikh7zHo4zkr55akR8NcV65UUaHW6h0PWOfUu7R/oFQ9qOb2BLCgdzexC6mxo
X-Google-Smtp-Source: AGHT+IEI5CvqnY5F+I0AkCdO6BNJ+FMs98cmSISrPzZxZxf+EpK58kujy/mVBbb/mJGiu9MuCulUAQ==
X-Received: by 2002:a17:906:b210:b0:a55:387b:eef9 with SMTP id p16-20020a170906b21000b00a55387beef9mr368147ejz.10.1714068562513;
        Thu, 25 Apr 2024 11:09:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709065f8e00b00a559bbe8a00sm6983034eju.100.2024.04.25.11.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:09:22 -0700 (PDT)
Message-ID: <c7653517-cf88-4f57-b79a-8edb0a8b32f0@gmail.com>
Date: Thu, 25 Apr 2024 21:09:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 1/6] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
Content-Language: en-US
In-Reply-To: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Different channels have different TX power settings. rtl8192de is using
the TX power setting from the wrong channel in the 5 GHz band because
_rtl92c_phy_get_rightchnlplace expects an array which includes all the
channel numbers, but it's using an array which includes only the 5 GHz
channel numbers.

Use the array channel_all (defined in rtl8192de/phy.c) instead of
the incorrect channel5g (defined in core.c).

Tested only with rtl8192du, which will use the same TX power code.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - No change.

v6:
 - No change.

v5:
 - No change.

v4:
 - CC stable.

v3:
 - No change.

v2:
 - No change from v1, which was originally sent separately:
https://lore.kernel.org/linux-wireless/9995b805-ef8b-47c9-b176-ff540066039a@gmail.com/
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d835a27429f0..56b5cd032a9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
-- 
2.44.0


