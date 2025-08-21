Return-Path: <linux-wireless+bounces-26490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A60B2EDBB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 07:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DAD168819
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 05:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268841D6AA;
	Thu, 21 Aug 2025 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYd2mfqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0012C2372
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755757; cv=none; b=q7aJaVDJSrC4Ljumt0gSKZuMh+Hn476HkQ8KGRhO8uJsxxBvcpkqymBKRATbFq1oDgy72ApLeuLmRkDV6uMOUdm9YJL6p4HxOi74MsSk54TfUfMPwui/F9PHYz9ZHQ/tXdlwvHgQ06qRq3Ilo9Bj0n0RvJU7Njhbb4w0Agx+ICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755757; c=relaxed/simple;
	bh=BIvo3nNhhb6pq2hOpAZto/z9Jz8pBYdUUXgu7fOc0cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUjTzcqYKtrmLeF8xVG3XrSu2rQ/lD2UnqNh4bvIaj46qVPOvDVHJr58lzjZoR5kPXMB4cVa2rX9Bjkyw+uqXDWNKQ09+9pD7Yryj2EhgWdEnN3MWCsegGpA7EhJt3WUOd/WCt7LXlQwWnMH5Lpp1PIPrgrYD8j/twi6k3UtRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYd2mfqV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KGmGUu025096
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 05:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vAQUJRzmvhCQC0jxSCWFX17btFNmXhfAUKzWHJ2kkU=; b=PYd2mfqV0VMmDHkk
	Ytuzn6AvvZQTy6B/O0sXilu63/vHWZ2nRHlC1iMN8uz1EvCcAsNeJHrCQFwm3leY
	gDry8eZRskRF3obqeuOylDoG9XGVfpj0xdWjMqPyS+ReHsyAdVJnyJysiXuF0XrT
	3Y2Utbd9vDU1GLv/c8uhzfLXcOL35ZXTbr5PEZsKGWEqSFWBlZLn8pF4zRqMNpCD
	8HyFYpb9kyLafuCSOgF3kIz9O87Whv8dXgjoLCJ5V5346AIAGvj4CQOL73st1/YE
	yII6LzTLPVj03Hwmbkqn6uUYC91vvFsUzZvv/ZQx3keX1rEgvhotXj9KvIoW7ect
	xQ0K5Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52av25q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 05:55:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce388so14996495ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 22:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755755749; x=1756360549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vAQUJRzmvhCQC0jxSCWFX17btFNmXhfAUKzWHJ2kkU=;
        b=tFUOAXf3o5eQ/3sXh0pxAl/6X0uiRgiTRmD707S/v7moBDSfouYznlrdNvHsAOJWns
         38RtL/qGqS/DbYVVqpDm8/Vrh6f+c/ECVL187wGnxiB16BYYCxHTQ8+C+rY9LsTDjuv8
         beGWvjwnAcMrl1/lo0ZjwQjybYp8LkGLpSv9lvFdHj1oLJY9Rhj8YV5lqFwwM1+F4Bgr
         Z46JUrAn3IAKxgUBQJu5GNuN/U1KbqvhMO+V0plLbjQiHvZfJSmrOlvxHpBunQ6KRy87
         Pa27HmUR6Aaf0jKTMzyc6V5NqKJ+WMHWAuHOsz9XUPjtiUDMOrd1csxWTUNQG7imLS/B
         Omew==
X-Forwarded-Encrypted: i=1; AJvYcCWLpMX4YMhMt3jYguA3OhRV7qT0j81tSiQYhPfMD/z/6Ni0nB8nj7/vB4/GtHriUbWwc4Y59RMTtNjbkTIAeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGzNYafbbkizogVPNwKXUVnUJy4EE/NEegrdWpQRreo6MEuxu3
	toooNzHqGxe5GMa1nJCCYO38kj5a+IFk8ghKh+VodDA20DGEWNjhF0XJWRledg2nOeLRySO4rD3
	McBnlNxo6fdyi5OEU/ogiM3114klyK8qAie6U8F7xv3hcUteh6r/5DmEBZzujfaOithlp1fP2Tz
	ih0w==
X-Gm-Gg: ASbGncv9vTTPOAQ8MkIXpYa6sraQSgIZIJgRkjplFXAEjHMn5V8sl4Nk7ivbXC5on0B
	gnbwg5vOiud98fsZb0K5UcIrtPYntwEFb25rbvAYkVpwuw5wDD5ack4Wc0/n1gKiF/B65It9Iar
	YIOx2qutWbmjD0Od5T06OTadIHHBd71ZjRHhCuVA3e/id09HDasOsYUVB/AxbO7TL+cnPE/ZrJt
	gobql8j8dDMDRPsRXx8KZHrZNQ8zCcyHj4ddWtFuQ+1PGj/TqSDofL1/FTl3m7MlILXU5tdl1do
	XxlWMQv9WE7Hxs72gedj0Qs7WZmVjxXi1E7cbzkKVsGMIeVp+wSUEr8A2flnE1bukSJZFe37dNA
	lzaHHi4acuLg=
X-Received: by 2002:a17:903:1786:b0:242:e38c:89db with SMTP id d9443c01a7336-245fed7e64emr15944995ad.35.1755755748893;
        Wed, 20 Aug 2025 22:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdHZMqwJ6N5/TcADw+wqbTRuW4Egpz+Ak9mM6X1MOB+PLpuwRJZ9j1D324y0FeF/bKUoWuTQ==
X-Received: by 2002:a17:903:1786:b0:242:e38c:89db with SMTP id d9443c01a7336-245fed7e64emr15944835ad.35.1755755748478;
        Wed, 20 Aug 2025 22:55:48 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.248.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24608c9daafsm6158455ad.141.2025.08.20.22.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 22:55:48 -0700 (PDT)
Message-ID: <86ddae9a-4931-b160-51a2-f89d45d4038d@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:25:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath11k: switch to of_get_mac_address
Content-Language: en-US
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250821032755.636661-1-rosenp@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250821032755.636661-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX51om3YA/3ClX
 dRxhRgTcPeCQyGQv0Z2b8BaViNcSEBNY4oBJ2j1mmTMcE9uMXsKTwOh0mwmdPZYBw7ZAtoDuq96
 1lOliCZFxXvpsJG8jxIDJ4SL18BUU5m8ate7VWJvSBPbJ8v/d3CW3GgDs/FGf5zZB/Hly60k5pu
 oRE+6KKICXMlw7auD/RS08CwYdITs6vYpAPpiIsyZQwAxJepKhgq3PNkUP4kDh65JXOD22N0Z6V
 oOHZ+fyhz8dAH5HEkj59qwS3ef/MZo5oiV3OC7ySF0u1KKZkmLns8SG7bj17nlHdabfJdyt5SgN
 ZU0sun03+3p2MqwLsBsh1ldCLlMjqw4IzXbKLLK8nqk1N/Xri6DoPYi3+i2ziYZH6qQawuKUn7E
 mRprxTN29eRclemimcO+7z/mf9cWRw==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a6b4e6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=pagehsHO18wfKU6DcLw+7w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=xJH9kgDew1csY8MGnM4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: _L9VdmdEDTsDdx8S3IojfAxQx1JY_Wwg
X-Proofpoint-GUID: _L9VdmdEDTsDdx8S3IojfAxQx1JY_Wwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/21/2025 8:57 AM, Rosen Penev wrote:
> This is needed to support nvmem defined MAC addresses in DTS.
> 
> In addition, check if the probe should be deferred as nvmem can load
> after ath11k.
> 
> For brevity, ACPI is not a factor here. ath11k is too new for that.

This may not be accurate, pcie devices are widely used on x86 where
ACPI is not certainly new.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 1fadf5faafb8..801db15ca78b 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9,6 +9,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/bitfield.h>
>   #include <linux/inetdevice.h>
> +#include <linux/of_net.h>
>   #include <net/if_inet6.h>
>   #include <net/ipv6.h>
>   
> @@ -10434,7 +10435,9 @@ int ath11k_mac_register(struct ath11k_base *ab)
>   	if (ret)
>   		return ret;
>   
> -	device_get_mac_address(ab->dev, mac_addr);
> +	ret = of_get_mac_address(ab->dev->of_node, mac_addr);

I still think it is better to keep the generic API and add the the one specific
to nvmem when the generic one fails.

> +	if (ret == -EPROBE_DEFER)
> +		return ret;

Please note that this error does not impact the device probe as this is
being done in the event path after probe returns withis complete.
Also, this will result in device registration failure even when
the device is not really looking for mac_addr from nvmem (or it is not
there) as firmware can also provide the mac_addr from the hardware.

Vasanth

