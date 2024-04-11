Return-Path: <linux-wireless+bounces-6138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6678A061F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 04:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6141F1F22827
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 02:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9D13B28B;
	Thu, 11 Apr 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJWp4vl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F8282FA;
	Thu, 11 Apr 2024 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803682; cv=none; b=qLCrkwbs1KzPJvGGOnVIU+joX9dhHKD+mkSR2sQqeBRfNdxJdbz0AFggTLomepf4pO2moPzZygqNBKviKiCak931jzbSFbivq4RlHTw36gbsiXPH8EDf6q1LfNrvjjzTokDY28VPVQrvaMZfpGQmteaW7nR0DmXPpHmgU/TKLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803682; c=relaxed/simple;
	bh=eJphG6hxK5MLkJm07zYc9BIh4Drt2GMMuGsf+W5mEnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dmk70dopWils0BRy/wFpY4IvlIjCRcbrRsmPx48PNhhSxSVtMOyvhZhyNUTPBl7FmYs3DtpnE0SRutQVev3iI5HdqY9h1hwHporpE+6J1LXV3zropPvu6hmXXjO0llPn8bDhUWijV9tovdptjvi52zZAJFDlhmP8Hq7+laTxZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJWp4vl1; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea163eb437so2380138a34.2;
        Wed, 10 Apr 2024 19:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712803679; x=1713408479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0v2VY93AarnBB8OF2yJX5KcU060xyjTJtFzMOCSeicU=;
        b=DJWp4vl1pWy9BLFeGq7d5JxnenILWpy7f6aQNvyUx/SG3k4bQhPlZvG7s0eikTpxzZ
         CSEwqzC2auQYfTASHA78nLypsAzeyti3fT6+Mzno9SvnLUh6KQ6ykY9Q62HbYIUFtQne
         7XrL+e8mzk+dNCKSZMzDHKSoRl0/4dntntZqMThkdEuQzFMQlRT1ZQG6TR/shKJd1wlZ
         SaEH/7u3dbH4gXEzlURyfLc5zj7xoCLG9brXDWdhExMumM1EZR8HkwRUqUmFRpSb3DsW
         pz7njkYD8SDMhIbJNNfiS0PkGugQl9/49yW0ShnFNAy+tqzB7sSz1FFy0wjP8mVPn3u0
         eUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712803679; x=1713408479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v2VY93AarnBB8OF2yJX5KcU060xyjTJtFzMOCSeicU=;
        b=viFfm5vFVAGRChSQbVej/1F2nImXmhwkc3wXggH5UAoHEPhu7URtTiFE++7asCMEvr
         55b1DsEKT2oJ4+3SMQQ4NUNhfAq2RkAQhz0Injh0VwWAh31hIx8+en1m96aq0fV2nC/K
         EwkC+bfCmSQrKteWb+GkZpo8DV4oeFMoLodKSU6j14jvpYZRxPDnHHZXYJXHhVYZ7Ohq
         4XpwKiWhBBvW1QuSJQjh5lea5J+gXtqhiqEtt0B26/YUN+YU27IkoGatMSt9DQ4nLFym
         ystWxWxJ8IcN3EbvsRs1Ya1eVBvNbCouNkJaEF9COiRN392vxrwTXg2p/RCuvBcOnLuk
         o8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+I8C/YUZXkDgmGXMt6fazMw18n068AMae2K1/J4MUVOog9YJV7rzzu3g1rZVzbm0N84PHUwuOi7qFz20vGxPcQJL0reOhiOBreThWWkhXzD+KKnwWZfOzJLcxqi1a2vdbRc0kerM=
X-Gm-Message-State: AOJu0Yydco4xLKPUuS0lvuwB5IFkGjtypW87izd0IbGzsDY9YbI2bCoe
	OZcaZOCqpsL9jUFTavnG289lVhgMRfzLO/axvu63u1xC4zNPr2TghA/qmyID
X-Google-Smtp-Source: AGHT+IF6/ra7tsi778+xsInsEN4ARudNuz9JQnw7btnunKOwMcuuhz3Gm/XqQPaDWRfp0y4IiBMUTg==
X-Received: by 2002:a9d:66ca:0:b0:6ea:2d0d:f531 with SMTP id t10-20020a9d66ca000000b006ea2d0df531mr4811164otm.37.1712803679655;
        Wed, 10 Apr 2024 19:47:59 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y13-20020a0568301d8d00b006ea16d35096sm140824oti.20.2024.04.10.19.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 19:47:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
Date: Wed, 10 Apr 2024 21:47:58 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
To: Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@gmail.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
 <5af71338f3904aac9d2c237637c851e7@realtek.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <5af71338f3904aac9d2c237637c851e7@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 9:13 PM, Ping-Ke Shih wrote:
> 
> Larry Finger <Larry.Finger@gmail.com> wrote:
> 
>> As discussed in the links below, the SDIO part of RTW8821CS fails to
>> start correctly if such startup happens while the UART portion of
>> the chip is initializing.
> 
> I checked with SDIO team internally, but they didn't meet this case, so we may
> take this workaround.
> 
> SDIO team wonder if something other than BT cause this failure, and after
> system boots everything will be well. Could you boot the system without WiFi/BT
> drivers, but insmod drivers manually after booting?

I sent the request to the user with the problem. I do not have any SDIO devices.

> 
> 
>> ---
>>   drivers/net/wireless/realtek/rtw88/sdio.c | 28 +++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
>> index 0cae5746f540..eec0ad85be72 100644
>> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
>> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
>> @@ -1325,6 +1325,34 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
> 
> [...]
> 
>> +       mdelay(500);
> 
> Will it better to use sleep function?

My thoughts were that a sleep function would tie up a CPU, whereas the delay 
would not. Initially, we tested an msleep(150) statement, but that only gave a 
60% success rate, whereas mdelay(500) worked 20 straight tries.

Thanks for your comments.

Larry



