Return-Path: <linux-wireless+bounces-6342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF888A5C27
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 22:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0731F22A30
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0413AA31;
	Mon, 15 Apr 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC0y+ZrU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A01156895
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212648; cv=none; b=A4Kcm2TZKqo+TzYwjPxgSHk1dXcbrbKevZsDuCT1J15DJTTDTmtVHK4gbLfYpqZV9VXGv5qT0QfreLUTMpd6bS1PxdhL43f2EYrOhfWqovYC3aC+tmvJnL4VcoLHn6VXVd27eILDWGk9ls2BFgnr3f9NZyw2y84Af3fagHvbh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212648; c=relaxed/simple;
	bh=5I0efjvpIeawo7lfy24c4hveb80cN98ELJcFfoLRl3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PRrFnBYqGz0UGZtvlZxNiu5SNnz1cZPiYgiGKedxRyteJ/IevV8udESUsf+dV0TpWeKw9PhBCbi/Qw39S4Zh28UM681FFZbuxEpuWEfd1BiDFdKqYrxpH9mEQKNi7tbhZzdNtPs9uPbmmr7lp00u297AdTDw5+LyAJxp6JSmduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC0y+ZrU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3465921600dso3261327f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212645; x=1713817445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtJFuOC3/fRJxqMHqwB9y5A8cASPoPbE2DaPne0jciw=;
        b=IC0y+ZrUX7hZWvKzqHz6ZbM2NXs7s53j/UE3cv/3OA0snWbq2Hym48mQIg+x+kSosd
         FpTYFA7qg6n/n4yooQnH7BsEv4W8QTTzd84jLdpKeOZuN9G08/OoQPkJAnCBHIZ0vPey
         0proejDx4zGEmI4OHC++V8Om+/p3wX5JVgC7obnkc7vuathmEd0dB6RcYkDxRCBHlJOw
         vIJCtMQFk4pReoCopw+uHeZEjhcrivzJNgmH1vnrVnADZJxm1/MPedAgR/vPl1Q1TRfG
         fxWVjTEBOgcUqxmSxuOznqdQdpU0Di/xLbYsA4y/580lxCR0eJz3AimnFJQ2D29x8dBa
         FCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212645; x=1713817445;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtJFuOC3/fRJxqMHqwB9y5A8cASPoPbE2DaPne0jciw=;
        b=vyPXGiNJG7y5v9bpWh83tmJ5xPjoR9vH9FGWbvJmuXZATA7nu0kU1VBMYtU3mpqRx2
         uPJXcYMVGqHhmWYF+uuKEWmjWt+Tz/u2/GL+h2l6WY2BNDAb9Kssbs3gWI2Avla/6kT/
         Wud4/AOo4oLAr1fu6JpiI2btY814kySXztQNJuFLJP04v7WByodkN9Qx6bs4L+gvJzLE
         kTPoET/UVFTBwCcFHfD4Q804e1w7pyiQ+R8gYazM2+nEU5wcd0NFRQFRfo6xDWq5Vfhx
         mz9dxxJMupJ/bLPIOt7P+pwgqJRF3Ta0s6VVm9OoleqcyQHWl4+Kj0Rt5p4lbjWDTClp
         tAVw==
X-Gm-Message-State: AOJu0Yw75M7K0hOukViJQLiU6hjU9Pph1EiJsVL4o0Tu41FlmIiAwDXx
	NoU8dIUQY4K5vcbVX9dECsjT39/ubs6+V3myq2fqpqsYd9/imn8BVln7oBwi
X-Google-Smtp-Source: AGHT+IFqQ4OoO79VFCUY2J0DR3N2EoNcOenEc6miC9NtILsPLSLleRioh8I2L0FLzwbN1TgjAbnCOA==
X-Received: by 2002:a5d:640b:0:b0:343:77f4:e663 with SMTP id z11-20020a5d640b000000b0034377f4e663mr7336843wru.18.1713212645314;
        Mon, 15 Apr 2024 13:24:05 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b00341c7129e28sm12906396wrs.91.2024.04.15.13.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:24:05 -0700 (PDT)
Message-ID: <2d1ba355-c722-49b6-8a56-8ab32074b76f@gmail.com>
Date: Mon, 15 Apr 2024 23:24:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/6] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Content-Language: en-US
In-Reply-To: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
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


