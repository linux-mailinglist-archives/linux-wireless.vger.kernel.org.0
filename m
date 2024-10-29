Return-Path: <linux-wireless+bounces-14636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A975D9B4ACB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A02841DE
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90710205E3F;
	Tue, 29 Oct 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoNBmOBG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D79204013;
	Tue, 29 Oct 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208018; cv=none; b=oQkjrcPYfi3M+32TP+96yRJXL9SSfnUdQzXe8242DTlCjQ8kB8r/ijqlCQT+q1GMr58ekqcrlZjWin6MEk81DOcPYw1JpfCbeZE+g7XJtCtSsRZuwyuPl8WTcAI4itQZkvuNmlOmf4gs6lqLCfZBQacpUwPuEsGDEJHz0eBGd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208018; c=relaxed/simple;
	bh=Nxl2dUZ/hQzuO7aiKZsu3S4MKYp9aE1j6RkycrXwFwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOf8u+rVad5ueDU1K04QQYwIIp30KtSJrH1dVco5z6jDWXk1aCKn9d3dfCliTaitBbwcN9lbFVOGSdts4Zvft+7s7N7b0TrxSwVLD8VN4B/Y+144o1SIQUig7n53UUCtcq4w9zBl486sU/D25087no2H5tT0GT8q+QzIvHdkyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoNBmOBG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43155afca99so44318145e9.1;
        Tue, 29 Oct 2024 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730208015; x=1730812815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2lAHyAlERYWmRIkmnxQFe8GGe97yMGstwaP2vMtsNs=;
        b=QoNBmOBGX2BBHpnLaLKhQJ6YYIH3YNKWyBhprER3B41IbOaILffwX5TiPcoOIRg9JY
         MUiK28KLbEMr0uJS6cpQE8CocB66rEP/7GxXEfMnEYbJUjmY96Y6SUct1mRnt9tC1fkr
         3RRRNPn3wSapx5GPhs2j/k9EDEXBL9Z3OeDyejotRfgf9u0QjFZlW08DDvchIFXm9ml7
         /QGDGdMwKJYwo2JOb1ssJa/39gm4h5PwJXDbbDxXPkt90EwoxoqY1LRC3cVAWsw/d4LN
         6BXwMJ/1fmixqIadQO+fHrmQJ/q8ZjMrhM8EkL89fGkPfmRT1XGiyHmF9L6eNwZ4+53t
         FLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208015; x=1730812815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2lAHyAlERYWmRIkmnxQFe8GGe97yMGstwaP2vMtsNs=;
        b=HCyqqVqE0TK+5UwCzAqJTuQrUQzxOJcgxzTJoVpO3sXs/fAPLd3l8k8RVy5S9y1mvC
         dfqYXsSKgaoS4ToMHdTLIlZkb5uIUsEt7/oJ7YfNW0zorzrf86NLQVoYylChLXNEDPuf
         tzdexGLA+Merq9zA36Akrzxp+9zQLc/UMRZ7T/v08fnKY8Pxn4KbCRY9NPUX27Qvz3f+
         +GbiDtlswYfMfwWDBTZi5osvz3rTt7Jfqowjf8bw6InXG+8Jes28A47S9wR8x0+J43hh
         D1funS3d6z+M1OHgqoxyJPB5aiSYqRcTIsMyXkLToP5rouCwRoL19XC9kwPwDoL6+A80
         b98w==
X-Forwarded-Encrypted: i=1; AJvYcCVtJeYD1FisK1osNv0UD180Ww3R0GGwTn0OCGg5F0Ne8i8qmF8sFIm9V2JhnwCz5QJrV2gbUGCW@vger.kernel.org, AJvYcCXdMukq4G7F+DgFIKXCHoaWhT7DLEVzpXqWRWF4P5fp3KigMpJUYeEROlM9C6z8Fvy60VyGev7BFs1R/Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNt4fiI4DIeLZSiOTDKC54QsKstvOO2l3pFSaelIoxOHcgwLdI
	hB8cDy1CGevmR9AAMTWtNjmu3ShjJ5O+teCYPlEpKtR3I/kwUflCI1w+1w==
X-Google-Smtp-Source: AGHT+IFFLzBuHzf002XUNntKaCdWplad9gWsC99BpmYqcoUrhRgiYAzllmbhX1sXf4KKPgbFJ7N83g==
X-Received: by 2002:a05:600c:3594:b0:431:9340:77e0 with SMTP id 5b1f17b1804b1-431b5727b99mr19343585e9.9.1730208014536;
        Tue, 29 Oct 2024 06:20:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567e18sm172490005e9.26.2024.10.29.06.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 06:20:14 -0700 (PDT)
Message-ID: <14c3164c-0e1e-4d9d-89d9-28d3240861c6@gmail.com>
Date: Tue, 29 Oct 2024 15:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
To: Ping-Ke Shih <pkshih@realtek.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
 <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
 <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 02:50, Ping-Ke Shih wrote:
>>
>> But can you help me on finding a USB adapter that runs this path? If you
>> know a commodity model that uses this specific driver, could you point
>> me so I can buy one for testing?
>>
> 
> I don't know that. Maybe, Bitterblue Smith (Cc'd) can share how/where he got
> USB adapters. 
> 
> 

I got them from Aliexpress. Both listings are gone now, but I still
see others:

https://www.aliexpress.com/item/1005007655660231.html
https://www.aliexpress.com/item/1005007688991958.html

Mine was only 6 USD in March 2023. I don't know why this obsolete
product got so expensive.

For RTL8192DU only modules are available:

https://www.aliexpress.com/item/4000191417711.html
https://www.aliexpress.com/item/1005007343563100.html

Someone gave me this link (I didn't buy):
https://www.amazon.com/Netis-Wireless-Raspberry-Windows-RTL8188CUS/dp/B008O2AL0K

Note that the Netis WF2120 can have newer chips inside which will
not use this driver.

