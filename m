Return-Path: <linux-wireless+bounces-26094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA0B18857
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5356B3B424B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515022192F8;
	Fri,  1 Aug 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUtxVtKQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE52139CE
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081519; cv=none; b=GXhpmS3oTLr25w264bXIUU67LFoHGk3FrtIQi6twtBD7pEckOMHJvwFU08bz2yyxr2dXdpl5fLZpctMN6fHjLfswuhJpwEYYKjLUoxbCJVN3zNrqiMxSkOEiJySX4EssLbMDD2PKpv7EaaTwMeKWYohGafIfycELM98QUV9ViRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081519; c=relaxed/simple;
	bh=K22ZT0TUew2GC+GNeF/GEnhl4JN79aQxwuRMFEKp9tM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qGuCHlFFNZMfdXtODw7AQ+OwITZBjA+Pp4YeBGFKFbUVGzl7ZB7PvkU2UdWSP59WnuSfpheLjgkDn363sgXiMsmhR9e0E5eLK/so92dNwz1Myxw25qkDYM4gXzyU2gweEszKwZidbCiXI24MeAfP7UEYYk67f317ruLOMpxJIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUtxVtKQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so1866270a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081516; x=1754686316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hgu5/hExLeIXh0/nF2IlpA1nbYqWEHRRYAxdlMghfI8=;
        b=EUtxVtKQT7ckgbt0zQhEG55ZhF1gn+1/a9T895JNfHhboozWWJ4hNrZy8s6YyXsvq9
         oyg1MJIjgJOxFSs86e9S4ghNXfLGAVioWHU9yEWW9VgL9nsgo9GHMfquD9s6gjgqbeSs
         DIHECoCmvWfBTAjJ8nArfSoaFD1IwthiAfsbvmMSbEv0Q5WLp51yQZX79offDyMeYFd9
         3m7z+kWNV4uX1rUlc5idCEyKQXe2318c5pwywF+6BFNEBsDEwn8dRXxlBfz7s6vp3fYT
         1+l7Oi93GOx4tS9JgvwvWFNxhz6u0Tzn5UQgU/ZT7EfRxYhab2SVfqsLWSSOFxmQPWJ+
         kjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081516; x=1754686316;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgu5/hExLeIXh0/nF2IlpA1nbYqWEHRRYAxdlMghfI8=;
        b=UamET2td+YI3cFRwa1LynRuE3cwrVpJG1LsUDyUXnolcbxfjziuE71ynlbpIkytaww
         kOGHjs1XYPSPtzfFavW4fzw43M0U46wg4iZmKmWnmPvZ++eywXmo9Dtg6h73kTG464ax
         PqogQ9x4nIJFcFrn59DfgBtmP1Fp4YHdjL38nAsKV8rcpwsjQvso6mjbbmzhtz4lcuEX
         GXDjFA7PHMsewlMXGuAKY7POVGCO+Q0nDoAVaVFMzFgpdoYtpk76nNvPuV786NYn1lbH
         c17haOLaDzCQFYf09xA6z3SI0+GifvLNERxmYKsri1wp3G0IVmBszYwNvCV2SsPZSOW+
         Q6Cw==
X-Gm-Message-State: AOJu0Yz5yGWOwrNevFelA9fnMqz7YFQ42BC7BhpwPC6GfRysl1XmdFXy
	Ddc7RzgL3dpPh1G44mpoFymYoJj+tB+XzDGc4aM663j3iI8MyMA1o8j6rnM8SQ==
X-Gm-Gg: ASbGncsXQPrhrjYIr0dZNq5tG+Ow0se8QzOht25kUiaDTjwi1t+vheoWvzM/j8KcDVN
	ATDqYT1I7XAQ1LCfkDANeoGZeFcwdL81UGOoHhNlTX8Y41sq5xYQyBu/3zDvV9sJ1jmtQqTECOR
	Izj8ZUuEphQm6CJUaq+96e7KbtVVYlhxHw0QKkuYKAPwJMpH5nWzzIwDAkTXVubh8OMumZAPvx+
	403JyepyHrXfWtrWf31Xo34wE3bHwJApc/mowWEOEByzYKvmvFjEZldbLy3o75hS96QbhI12Vvz
	z1aFVyWSSZ51YulE85X4YYF6WAgXg+y7Je05w+p6hf2Y2jhPO3htTaB6q6/uHdRIndV8PK1rc/7
	ESOFko7owv2RNisPP8VvGCo5Nz56ipJCThXyrOvQ4
X-Google-Smtp-Source: AGHT+IHIWKCmLkbTblRtZCR8V8P1htFbmV6AUWSa3+Xarm1/4StqZYZ63I3Yr0sCfmLwFo2p82GfeQ==
X-Received: by 2002:a17:907:971e:b0:ade:4f2:9077 with SMTP id a640c23a62f3a-af940768702mr135014166b.5.1754081515824;
        Fri, 01 Aug 2025 13:51:55 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076409sm337903766b.12.2025.08.01.13.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:51:55 -0700 (PDT)
Message-ID: <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
Date: Fri, 1 Aug 2025 23:51:54 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix rtw89_core_get_ch_dma()
 for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It seems RTL8852CU can only use TX channels 0, 2, and 8 (for band 0),
otherwise the chip stops working after downloading at maximum speed
for a few seconds.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/txrx.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index ec01bfc363da..318fd0ac8726 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -734,6 +734,25 @@ rtw89_core_get_qsel_mgmt(struct rtw89_dev *rtwdev, struct rtw89_core_tx_request
 
 static inline u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 {
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB &&
+	    rtwdev->chip->chip_id == RTL8852C) {
+		switch (qsel) {
+		default:
+			rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n",
+				   qsel);
+			fallthrough;
+		case RTW89_TX_QSEL_BE_0:
+		case RTW89_TX_QSEL_VO_0:
+			return RTW89_TXCH_ACH0;
+		case RTW89_TX_QSEL_BK_0:
+		case RTW89_TX_QSEL_VI_0:
+			return RTW89_TXCH_ACH2;
+		case RTW89_TX_QSEL_B0_MGMT:
+		case RTW89_TX_QSEL_B0_HI:
+			return RTW89_TXCH_CH8;
+		}
+	}
+
 	switch (qsel) {
 	default:
 		rtw89_warn(rtwdev, "Cannot map qsel to dma: %d\n", qsel);
-- 
2.50.0


