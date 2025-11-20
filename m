Return-Path: <linux-wireless+bounces-29169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD8C7477B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E30732B383
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB09346E7F;
	Thu, 20 Nov 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVq5mwVk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061D3451CB
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647964; cv=none; b=FzSvG+VF2Solgdjon3nVT/BEewBl/7h75/5yRXMva61j4ybxssWfbdPAB4J4IFBC/JEwHaonLbRURPdS/N0rl3XCj0CFB2WlhRRTojQTCuA011crXGY+3U5n4CC8iBNPSdpqDcYabIohA4ToXhcATclvZ8cRF71fUBVH3SkJ9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647964; c=relaxed/simple;
	bh=X0h4350s8jE1eFAK8CVLB3q1qtVi1CuDdaXMXELNFuU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cUrbwMylFzydn1AHJJaopPItUm2pcLr924lWemyDz8q6sDquOJtD2KtZLrFnyDQ81GWhOk+hL7CUJJAdIrJtQR80shJVJjs7tMH2+5JiSkedd+XOM7l0aw3glyg5CVfZS5kfeTNjkQ2hv5B0FfgW01FCaW5GkoJNWLkN3AJOOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVq5mwVk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a1c28778so11323095e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 06:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647958; x=1764252758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r5kUeFyS/MxASb27jWVBt/JDaWMSwpQx2i6eLyrMD1A=;
        b=DVq5mwVkPe1rE7WN+kLI56F8k8/QSY8wBb5O+5AhVFIsYmsPeqf6tpEU8gWSVkqlus
         PXOH0cC28YtM4LrlRFv62Nftm71P2fT4ONA0EeSm6bNUcOK+AfOG5b+J8ZM6wxJbPj5d
         wQmq4/+5CoNmtwnrKQahP2Fpc5lC+wUmTbMCOvBTUon7AzNYIZS8skiVsfoDkmImVL9i
         4oW6mYKyUZmZ58igH7ekoLKDDJ+h3RSQRz+Kjta/6ubiz3FfsEdOGzT8Fxl1cbb8b/M5
         f9PV76xx9udI9+A/ITksrcP/Cl2vTPOxCMM8jVx5F6dpflp84JbplKaLReI55YON1Zvk
         COUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647958; x=1764252758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5kUeFyS/MxASb27jWVBt/JDaWMSwpQx2i6eLyrMD1A=;
        b=VOWK5hWPnONPCFT/CWDOHJkiHzZNOd3sMJWbnH7xvlD9xGmDQ6seLSsh5RwLgSV+dc
         YT8bFt25Rffyi6+azbon/xpLGX3rdBk/J5RQ9arlOfiOhtn8OTIKKrK3nOSMUcTqzA7I
         2316+fuZBo+TMvZ82HVraWr+fRKzyXicLWmhoEwPCi2BYbD7IxSwCnURnxyH/uB+kFVW
         HJHWiBfmY9hAiE6wxvsx5Z+/q4jmXO1ONLsDyc2wKY+bSsEniGpRZHygbee7uPZylmNR
         iEjhh2QuHiOcBSzUOt+FzADgDelX556Ld5TcMyTHvQlDjOd3Lxqvn+Jcml9kFM9aXWOK
         j0sg==
X-Gm-Message-State: AOJu0Yyg650mDwS/BkcL1KAhh79x11z5q66XSRYW37IE++5B4htCed65
	bti0fnwleyLYVHvRoR1OW7ksuo/fjN48j0cWfxjJDWn22IphT+0yahsQOIMXCQ==
X-Gm-Gg: ASbGncsske9gQ97bJ7ZCUW6XpngKmSmWBG3tFS28BslxCPBh+2h+/GpD5wkpSxb1k7e
	P7fKta2b14YHZUkPnnfx442DHwjB2ISnTS+bonxi58a0jpDu29ViYihAXXDkGEGA+pGHwJXHEKo
	H8LdDMzi+bzRyptrNX2hRniudRuSIHJHI+YjSycaCsSXPuwQoSl3+/6v/fdsnoGbdlWYj4yZ95O
	xzKCFCRqSdNQ3xnrO+9tc5vct3I0FB5qdPbigBj6qtXaummY5ngqCho1vz5eWGz28GbYKoNTIB/
	UQ6Z7s01tjXup8TMJYVGJxxHf/KZlTESV16J9I1JatjDk+77d1xIQP36DaN3KGm6pX4R45grO0u
	FWzAzJ3KLYhWicKV8gtCw4iUQOe7zY4Rldr6JuSZGYYcgm3uZ+RaJ+qCNDV7AgHhBxK+m3vW2Kl
	q4FbQFTCIi1439fBKw97o=
X-Google-Smtp-Source: AGHT+IHG8IE/6Ec57U2uRnZp8sUui4ErZhNRHcE8OXaLhQ7aaDjgAk1Qp3F7nHaWLEHrBTnBAUDBOQ==
X-Received: by 2002:a05:600c:19ce:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-477b8a89ed0mr35104385e9.17.1763647957957;
        Thu, 20 Nov 2025 06:12:37 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffd37bsm114626045e9.3.2025.11.20.06.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:12:37 -0800 (PST)
Message-ID: <a5de8d39-45c1-4667-ab4c-7109de6eb13d@gmail.com>
Date: Thu, 20 Nov 2025 16:12:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 3/5] wifi: rtl8xxxu: Fix the 40 MHz subchannel for
 RTL8192EU, RTL8723BU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Language: en-US
In-Reply-To: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl8xxxu_gen2_config_channel() was missing the subchannel setting.
This function is used by RTL8192EU and RTL8723BU.

This change seems to make no difference in my testing on channel 13
with either chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Reviewed-by.
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 7700e4074dc3..739456640ca8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1373,9 +1373,11 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw)
 		    hw->conf.chandef.chan->center_freq) {
 			sec_ch_above = 1;
 			channel += 2;
+			subchannel = 2;
 		} else {
 			sec_ch_above = 0;
 			channel -= 2;
+			subchannel = 1;
 		}
 
 		val32 = rtl8xxxu_read32(priv, REG_FPGA0_RF_MODE);
-- 
2.51.1


