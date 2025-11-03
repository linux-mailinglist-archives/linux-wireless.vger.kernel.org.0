Return-Path: <linux-wireless+bounces-28505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDD2C2B506
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7963AE0EF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83282FC010;
	Mon,  3 Nov 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK9BzXGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C32F3C12
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169077; cv=none; b=AjFcMB27t/8H8tGiIx/v+dgtNUSQDaqXNsQ2pImVm8MfgVXwYUFvag1oTJ/cIwnxmdF7o6EuX/J3JpEtkX2Vk86bTcfXOzNvMLAQpjJQbdkjcXwjhd/RDZnEKuHN4t+1+NGYWgySXSx8c6TslQjS5jpVC54/NcZ9okOTp3hJ30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169077; c=relaxed/simple;
	bh=YuEsN0SJ98qHtrR+p6zDw6xUBC7pj4eKyOEs5rY7AVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aNgJh8OSH81X2jhyG+YE67IAhKIXKXwpz8k1lwMVsohh5XQgxEBd8NlfiBSfLqkLEdWlYdKYodx7oVNvdtzCd9d3hYj9FEU1h5Wd/CF//ATzvPScOb2yrOJ7yTmwiLSxGfEONsrCBckmS3A/ZAQcqDq/e4JAXBdOWPxUTmXdzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK9BzXGC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso29114125e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169074; x=1762773874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcgs04/C+3T9jpceXbHFJFlo9+cVLwBCYvR0EaLGV2w=;
        b=QK9BzXGCCEdcck8ngeOjEv8lJYVC/VGSuaEB9ZU8yPtFdc0e+RvsKMc6n/2+iFe6k2
         +RSd98xPKZckO2idnfRzWmtNcJdRKXFMDm5UbQTi0Q1nmGCrfJHl0mXmfjSaE4q24AWY
         5KLuEuYz3luUx8F06vKH8+fh+01GQK0/ItZZZhnAKO0famLAqKvQpjjkm9jG8v5rAvOU
         DC6l4rXO9FTcrjyszcu8aK4TFiD5IjKjQINNtNLuBQLZvXTNVldIZAolLU8a4wokHJRV
         am/jKXFTj6BfFnqqXruWbbCGbrwxJvIZyCcRzHMxFyk1VyiMOecwS+cos65zqjIHMyXu
         N7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169074; x=1762773874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcgs04/C+3T9jpceXbHFJFlo9+cVLwBCYvR0EaLGV2w=;
        b=ldXHIgKTs6NlZza29+wzCCTguep3TedGC+UL9uOwbu9WTaYcNlyP+JPFHUer5KJucb
         w3LNcZTw/M65//MG+3z/zZLZVKd+vfPvGkYdw5lTq5+NeQJftIvqwmc5BBlRoDRXBR3q
         K/WyBtwle1Z1y099DAg9/LmpKdCvG8xPMYvn3STB9WQ+WZ4xSFtLrAg/dpd+padlewMb
         eLblfDzULT/2h9xNVwomBY5DIjbLaNX3vKDURWKkKWRYexPSuOm7mG9kqto7lbCIoeyv
         oQtOqRVobKQklhm0OeQhDWwP0ItmN2OQsER8nB5edLRq0H0uA0rg56qh3eDwOZIFg6zX
         WgfA==
X-Forwarded-Encrypted: i=1; AJvYcCViAPK+cqjjmQdIg8PYtgZyms5x54IEBhHlSC8fXwD/MMVGl4R11/k9kqyln3uUrVpFwB9KbYvO6JL92Mbrhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKIxFVhnx3NX0ulJjVBbS/Gq0ZeVfDFzxuD0s8VHyHSoYhcuY
	EYGAg9JxPlmxHfB3KQhFpFkERiYFjBednfrhdAW7/w+QXr7SW7w6nVhG
X-Gm-Gg: ASbGnctgyHDsL2vOVMg3PzzwzHwBvZC5QYD0V/MJDc0XuDRABP4S6ic4wNAbuA8mAiN
	BQ5QATNKEGEqxS/ASSA5ehrsRnASInnD1fL9NtyhhThsR137plfn4UX8L/HKoLxQ0YgGNBWdO79
	5xsL9vF+RDWsJbJqN2vUV2Jlz5aLYaY959glqd+UjoMMRKjBt9CCzGmJibefYWAUPK8vjU3S87Q
	hKZCXNvXqx8zgE+fESDwpeWVJ5BKv9yLGqr9MqoTsqFSN1pOFy2n02iwIpKq6zCdEkvGijIWBxN
	Dw3awvdUIFylfKypxkCNBqYuv2Kyz6HOtF7DSb6scMx7hDeCf4BduvkyIWvqat8T94WsjV9W+TO
	mZeyMzyFEjpsd7d5YnQlsIXT6ArTXkn6ndWsF3tcMY9PGbEHfUAHJE83oIL7fKcASUHglmdliQR
	YpE5tp4Irj
X-Google-Smtp-Source: AGHT+IE3o64gHgn4CYtymiKMvyi3D1eCCSztLe1+rnmq2nOmSvwtrkaSZh2jedYofPM9j0RyggjaRw==
X-Received: by 2002:a05:600c:3149:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-477307e486fmr102924685e9.17.1762169073881;
        Mon, 03 Nov 2025 03:24:33 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2fea93sm151321665e9.5.2025.11.03.03.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:24:33 -0800 (PST)
Message-ID: <e955e80a-c63f-48ad-badc-df6f13d363d7@gmail.com>
Date: Mon, 3 Nov 2025 13:24:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v4 01/12] wifi: rtw89: 8832cu: turn off TX
 partial mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
 <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
 <ae01e924471e442c897b3087bdf0dff7@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <ae01e924471e442c897b3087bdf0dff7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2025 02:47, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> From: Ping-Ke Shih <pkshih@realtek.com>
>>
>> The TX partial mode in USB devices will cause timeout to wait for payload,
>> causing SER 0x999 and disconnection. Turn off this mode according to
>> design suggestion.
>>
>> rtw89_8852cu 2-4:1.0: FW status = 0xee001108
>> rtw89_8852cu 2-4:1.0: FW BADADDR = 0x18605fc8
>> rtw89_8852cu 2-4:1.0: FW EPC/RA = 0x0
>> rtw89_8852cu 2-4:1.0: FW MISC = 0x1010000
>> rtw89_8852cu 2-4:1.0: R_AX_HALT_C2H = 0x999
>> rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO = 0x71020010
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f554
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f556
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55a
>> rtw89_8852cu 2-4:1.0: [ERR]fw PC = 0x2013f55e
>> rtw89_8852cu 2-4:1.0: --->
>> err=0x999
>> rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO =0x71020010
>> rtw89_8852cu 2-4:1.0: R_AX_SER_DBG_INFO =0x71020010
>> rtw89_8852cu 2-4:1.0: DBG Counter 1 (R_AX_DRV_FW_HSK_4)=0x00000000
>> rtw89_8852cu 2-4:1.0: DBG Counter 2 (R_AX_DRV_FW_HSK_5)=0x00000000
>> rtw89_8852cu 2-4:1.0: R_AX_DMAC_ERR_ISR=0x00000000
>> rtw89_8852cu 2-4:1.0: R_AX_DMAC_ERR_IMR=0x00000000
>> rtw89_8852cu 2-4:1.0: R_AX_CMAC_ERR_ISR [0]=0x00000000
>> rtw89_8852cu 2-4:1.0: R_AX_CMAC_FUNC_EN [0]=0xf000803f
>> rtw89_8852cu 2-4:1.0: R_AX_CK_EN [0]=0xffffffff
>> rtw89_8852cu 2-4:1.0: R_AX_CMAC_ERR_IMR [0]=0x00000000
>> rtw89_8852cu 2-4:1.0: [CMAC] : CMAC1 not enabled
>>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Though this patch is from me, but I think you did some cosmetic and agree
> this patch, so I'd add
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Is it okay to you?
> 

Yes, it's okay. I only added the output from dmesg.

