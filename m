Return-Path: <linux-wireless+bounces-27466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E405B833D3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA357B2560
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD12E543B;
	Thu, 18 Sep 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FD0ZzwnZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC352E5438
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178808; cv=none; b=A2AYG8WMCUZMDwIcYQUSU1FYiH0W33U0E4ua+B1bLHJ5nkkLPlMzHJE1Ikkv1mGMHO2hhQu9uO6K/9gNiJRssyNyPPXQf4qLOjKaLop0a8dURl+rFPondN16UemhxB3Z7ommblHCpSs9osAYAf3ZkwipOHjeuvnnqeKSoIjXvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178808; c=relaxed/simple;
	bh=dMPBMjcsgn8U8Ns064JVZeWP50Bq8MfymrupfdTqn3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7G127i39PsDa3OlITllqpGq47Ljwz9qNweEDjLcMhcymRTJZAp9+65eszrTvqxnEfBHXR2azdyUxqZ1/RyamFcygF6aqweqhLcUYQhYEH3qnj/LIj2HaMwJsLML8bRNXU32YBkuOTMC2qpEgtFBouxKoQm/THCf6byWiJW2kG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FD0ZzwnZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3ShUC010955
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbWfmH/pC1nkCgbZSoU/uA31VLtZW7O3InnzSnNVGIE=; b=FD0ZzwnZ9FI5tSH5
	60sE1dFrl1ZPrFfJ5uI7jRgaHHl0uWXeRIY+wI0MxAVQ66fP4cGwJKZjyFeMFRtN
	xB3CDjO6ztTxOWvhK91CiNK9sq0Xtmo0VxWIfJ0Wg194uTKKZsPlXUqtBQUo4GdM
	dcRuMVQGJmySLA1vQvDdrFcFzvJQ+xUFQaubCSCTxF8sMiQsi0zGXuZdMMPgeFyr
	ETj4ZRllZguijOkmDS13EQIgYqeI8EB1NbRVA0EiZKntcIGv3KYF8aqaVqK64wmG
	MyeW2srrKdt7Kc/sKP04VmubzDI7zgCN7AXalJx1vgLW6Btj0Wzx3iKjdHi+2Nv6
	0QE3EA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxw95f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:00:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5529so618157a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178802; x=1758783602;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbWfmH/pC1nkCgbZSoU/uA31VLtZW7O3InnzSnNVGIE=;
        b=SeBavMC5V4ZJ1K1CZxZLeZmqJAiA57URW8EqxF/6401u1+m/Nj9Lg5tQF2S2jNVzjO
         NXo8Zf/gUtcM0d+x+GMJp7ufhi0h0kAi1pfhJXHDh2t0QXlRGokj2xlYtIStQIaqrDns
         5jSbeySYecla3ZDSpmrB2erwUfMmVpuK4fJycnQZbZPjsvJTTshqp7kUcS50j9MPwxZp
         yeRGCqVStwDkCp7WuaIdF7/ERvz5oeFAy1ktDYqYiCtJ9aMDPd+C5egudZFflLbzauYT
         qx8KsmC+rvGZ3R0vugshGfKkjf65eiyc6/eP+OptIPR1OyhiILYDGkEhKYcCXFYLWd6m
         +fhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRv48ujdjT11WFqt+8QKfmxsyYFtF/l7sWTZcGDiYB//3P5QQ5IwQxcHEFYiXg1j9+JFqfpLo4oHsZE1Uqjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzdhSoNvrnEKPZNLrZKTEXcFQbKEjFS/HLfuFT2RzWVdhuS+j
	wjanS89wEUd/w+S267jWyjUjhlZrQdvIWYf8LTLtpOLMiWQ8VgA7IQuA6iQCkB/hsW+Aq9Hq805
	LljPBe4w3Pn6Hs1/WBw6bCQ3vfSbcoK2ueAKaxtjRwQhRLDzGP+yhtqHgVq9AZ/zqJPp8qQ==
X-Gm-Gg: ASbGncuNgvzkxHvlWZBh85jbB2jVm4nbAOkqMlcjkdu+rezqFlvBvpCViNgiTbrkh7j
	sOaeG4QA6TD/jyuZUm5VwBFeJEeZ8tFZUuneaEygZfzT3TiIMnPuxjWZT67gXXppSAvPoABcbeQ
	C+AYZYaJPTTDf7zUUAcdXCc49MpgBolYiZXebr6Clv4u3w7DyRz8vBP/UYviZmNuoijb1Bo3GFn
	5Gl27ALLANcgwZLqMMBk0w20JoEoi9RV8yCtji8w7ZM1y327ydhXnlfVSuptXfSd+R2LEqorwd+
	dsAl8/e5ae9DvfLLn+S4Jw6pX8G6YJZSxpK9Wm73dmC6tFr3YuhGKZMj7c5h4IEY1t1o7FZb7U9
	EE5C/u4h/cEix/rCBtgBOMoQKsawbWTaC/IQT
X-Received: by 2002:a17:90b:3c8c:b0:32e:3f93:69e2 with SMTP id 98e67ed59e1d1-32ee3ef0806mr5833895a91.13.1758178801460;
        Thu, 18 Sep 2025 00:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqOU3X6jq0DY1ti5vQYDwFxJTrFdx2WWG+GVUcFRyYIyCcd6DpTKmCSc0wqBeP9DA1iegvZA==
X-Received: by 2002:a17:90b:3c8c:b0:32e:3f93:69e2 with SMTP id 98e67ed59e1d1-32ee3ef0806mr5833868a91.13.1758178800933;
        Thu, 18 Sep 2025 00:00:00 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607f0deasm1526418a91.23.2025.09.17.23.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:00:00 -0700 (PDT)
Message-ID: <e01fd1ed-0b7e-442c-9524-3248a9cb32cf@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
To: Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250808151822.536879-17-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzVFqCuTKt8Nr
 JbtkQCWrFx6YAdKqPkbeEiZWfLBeYjrQBs8I7SCV8ymZdRyNiwEdzu3KpHZsdP+cHgFDYnhDukP
 F7JKBIxhiFJM34AqrI74Z3BOnz63gm7YNBuIvXBf/Lj0tK2v5HrGWKb3ijbbcAL1tRqRr71Drm2
 /kzAw3hPh+gLgwFKlJZL98d00mBIKsLAjvRueAuF9FG1IvpHMJQaXuQ5GrDL3jGxeUXaxWdhkRo
 2wu/WtxDyCxksYgXRvYK7O1UyiO4OJfNAZLly1gf6MYOw/KYVOrEYHez7Y+gmzVUyKh56dPDEaA
 Ttzmroqko+Qf6gBEG6+lhYPRsB2X3Vf+84fMsX7ESz1TvzLYUfxj1cNDzVZywE9M1MvtR+NH4Pq
 Tv0hDTWs
X-Proofpoint-ORIG-GUID: t3eIIkJ5XU4zrKmLn2vBhMMiu23jB7hr
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cbadf2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uLrbQztoRsBK_tCdPC4A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: t3eIIkJ5XU4zrKmLn2vBhMMiu23jB7hr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/8/2025 11:18 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The leds-gpio traditionally takes a global gpio number in its platform
> data, but the number assigned here is not actually such a number but
> only meant to be used internally to this driver.
> 
> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
> 'gpio' number field is going away, so to keep ath10k building, move
> the assignment into a private structure instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ath/ath10k/leds.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/leds.c b/drivers/net/wireless/ath/ath10k/leds.c
> index 9b1d04eb4265..3a6c8111e7c6 100644
> --- a/drivers/net/wireless/ath/ath10k/leds.c
> +++ b/drivers/net/wireless/ath/ath10k/leds.c
> @@ -27,7 +27,7 @@ static int ath10k_leds_set_brightness_blocking(struct led_classdev *led_cdev,
>  		goto out;
>  
>  	ar->leds.gpio_state_pin = (brightness != LED_OFF) ^ led->active_low;
> -	ath10k_wmi_gpio_output(ar, led->gpio, ar->leds.gpio_state_pin);
> +	ath10k_wmi_gpio_output(ar, ar->hw_params.led_pin, ar->leds.gpio_state_pin);
>  
>  out:
>  	mutex_unlock(&ar->conf_mutex);
> @@ -64,7 +64,6 @@ int ath10k_leds_register(struct ath10k *ar)
>  	snprintf(ar->leds.label, sizeof(ar->leds.label), "ath10k-%s",
>  		 wiphy_name(ar->hw->wiphy));
>  	ar->leds.wifi_led.active_low = 1;
> -	ar->leds.wifi_led.gpio = ar->hw_params.led_pin;
>  	ar->leds.wifi_led.name = ar->leds.label;
>  	ar->leds.wifi_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
>  

With 'wifi:' tag added ...

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


