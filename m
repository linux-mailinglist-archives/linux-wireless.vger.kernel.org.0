Return-Path: <linux-wireless+bounces-20614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B12A6A361
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 11:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C2A171EE8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73422332A;
	Thu, 20 Mar 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fv71Bc/F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A4223324
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465698; cv=none; b=EI0M0FzoySFbFbXCYMNsH2iO9Lm/Vcx7N9u6fsBFSymfpl5qzRlSKRTYZ17FYqpA+yqPwO6VgQaG0JpCdmgX3j5HtDAkSLkmVdfgXDtoXKnRS6M+2Rpzhksul/Hp110O78NmuEhea2vMbiuAGaF9k7SLEBcjFOQBPrX85SW8I2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465698; c=relaxed/simple;
	bh=mad9TF6HWlzgsDYW0Xw2B9cirt0EV2aKRdW2jLlXXxQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lbP4yDNceNeM1epaX02f/5InaZ4H3t7s98ER5aY9JsXvXeXG3xnAsP8v8CWtS3kqOKOBFQJEh/WuD3UqNI3FGESnV4PHWbhs77H15+A883zI10vKDTHwkMbLdSeAQsb9JDZ4c+WV+AuuGEZycyEYb3oVovFykKADKDO7sIIJUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fv71Bc/F; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913d45a148so457978f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742465694; x=1743070494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsTKzQd+0EkTWpAX3OmSlSj7NCNCv0EtzNWUjH+/fWo=;
        b=Fv71Bc/FD3d6wsQD+D34W5hZ+qkWPMI92bhpQx4fOqmzLWzQBv75oEX1O/XOWhLOiv
         QNKA1uHtgThbFPCNI+6XbpiwgFh7ZGY6xnkGjBBP2tApKYaugGJCLK2pMob6GwxkdPT9
         3LvdMJPKS9YSAroLlyqNnlPaGySd3HRVy0DMyjahz012dyGPD2zsd9rH4I9qeU5vdg0C
         yrLtINAhO7VZicm9UtY4dfZW3+dC7LsS9oUJqBRwlG8e3EEjMIuRfekOeaT8DiqEEVdT
         95Y3epCUDLz+Sf5s2xFppVlgSZlQpOXtM7RbflYw4L7h80J5dnZ9OTvVs2H8vHpTlAce
         x+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465694; x=1743070494;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsTKzQd+0EkTWpAX3OmSlSj7NCNCv0EtzNWUjH+/fWo=;
        b=po5//YL2s3OzcNIiER9+eve5nvyh0/wzRYzM2xQwrjEg7ERw61w0Ir46Ouws0TW05+
         hRZIOIuI1LqQRVIvzmvv6Lt7LJxja+V8TZbf+ws+Dz8ptLxOP2GdGRulrc4p333Im/Rb
         Fh1JkhfzwkXy7ctci0EksAn/W3zSoQqmVMEu2Sn0webGrWK9Ya524heNDze5lFtqmM6u
         lLDHjeqB89y01gezRBEn9HPZgg9cLI2ZImVMOQ8RA/yJB69Wwfwf/TWzkIFjdOqKgOWS
         fC9/UiwCIUCjl4od5wdxHsvbyy4HW4rg/DmB+t1u91jpwQKxRHBFSqyGVK4KBqOZP+CW
         V0QA==
X-Gm-Message-State: AOJu0YzIxk8cln5EwXKpms7s8iebingvUVXXGp9BZPNmVKz+9voMvTJY
	vDhC3oZWio/jtQVGvImPhDcpeeoxPQcUH6Zmdq+TiigXIAzpknthxfLNj5d0yBs=
X-Gm-Gg: ASbGnctN8Rw+s9NFAoafwLnCeSB/Di3PmaN99lmUwiwn0vCdtUfTwoSlsrsz6BEeM5P
	ICGDFRI4fzfcaU18wEfaH0zSeFTY3BfgTpmmRxLUNpNSDrAAsT9L7Lgx1blT3AXRXJRyFH9gwfv
	7BlxyjD58L30MyI9ZC0qmQZQlB1kjIguyWASUeNIZAhT4/jmBGBajMB5lWky+4cNeeqg61Mc78K
	oc17y1NWiLO8DkE2eOg0Cp7EdAkRgQi+SZibm2PbmmHDKLqzUJzYGI1R5vjXSXsHEiQWjWrNt5u
	Nw2c/O6SJntsxb4ugLt5XNUilwQkLbSgdinO9TChfvJP1WKnh5HmW89tnX+Jl9EM/JfuW3tZuWw
	pndd1V+i9Ta2MQ/Vg
X-Google-Smtp-Source: AGHT+IFim8WXF4Bw641hmtsIGi/r9529B0IxX/j4bUMRvtVtznNxhRUIgBVI1Lkw4lHn3sf2W9z0JA==
X-Received: by 2002:a5d:59ae:0:b0:398:9e96:e798 with SMTP id ffacd0b85a97d-399795a8cb5mr3197534f8f.13.1742465694455;
        Thu, 20 Mar 2025 03:14:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3bd:568:f697:d1a2? ([2a01:e0a:3d9:2080:3bd:568:f697:d1a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b7656sm22861868f8f.40.2025.03.20.03.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:14:54 -0700 (PDT)
Message-ID: <2fafed58-4959-41ca-b0e1-c10a8da60aa1@linaro.org>
Date: Thu, 20 Mar 2025 11:14:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
 <770daf27-ae9c-4ed5-87d0-aadcc3b74bbd@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <770daf27-ae9c-4ed5-87d0-aadcc3b74bbd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

On 19/03/2025 19:32, Jeff Johnson wrote:
> On 3/19/2025 3:27 AM, Krzysztof Kozlowski wrote:
>> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>>>>> ---
>>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>>>>
>>>>>> Best regards,
>>>>>
>>>>> NAK since this will break QCN
>>>>> There is a series under internal review to address MLO issues for WCN chipsets
>>>>
>>>> ???
>>>>
>>>> The original commit is wrong, this fixes the conversion, nothing else.
>>>
>>> Nope. Driver changes to enable MLO with WCN chipset are not there yet.
>>> Setting the mlo capability flag without having required driver changes
>>> for WCN chipset will likely result in firmware crash. So the recommendation
>>> is to enable MLO (in WCN) only when all the necessary driver changes
>>> (in development, public posting in near future) are in place.
>> Really, these are your answers? There is regression and first reply is
>> upstream should wait for whatever you do internally. Second answer is
>> the same - public posting in near future?
>>
>> Can you start working with the upstream instead?
> 
> There is a lot going on in this thread. I want to address the big picture. It
> is no secret that Qualcomm has historically focused on downstream drivers, and
> upstream was mostly an afterthought. But that mindset has changed. Qualcomm is
> fully embracing upstream kernel development, and has actively recruited (and
> is still recruiting!) experienced upstream Linux Kernel engineers. And in
> places where there are shortcoming, Qualcomm has partnered with companies like
> Linaro to bring in needed support. So Qualcomm is very much "working with the
> upstream." We may not be working well sometimes, but many of us are still
> inexperienced with working with the upstream. We are coming up to speed.
> Specifically for Wi-Fi, we have a large number of engineers who have primarily
> worked on downstream code who are now working on upstream (including me!). And
> we still have the issue that many of the products we are shipping now still
> have a lot of downstream DNA, especially when it comes to firmware interfaces.
> So please bear with us as we learn and evolve.
> 
> Please keep the constructive feedback coming. And remember, the more detailed
> the feedback, the easier it is to incorporate the feedback.

Thanks for all the feedback, all this escalated mainly because the 46d16f7e1d14
commit doesn't do what is written in the commit message, and there were no clear
sign MLO support with WCN firmares would be removed shortly and redeveloped later.

As final note for this patch, do you have any timeline for when MLO would be enabled
again on WCN chips ?

I'm happy Qualcomm is embracing mainline development, but Qualcomm still ships
hundreds of different incompatible firmware and downstream drivers variant in the
field, and this makes system integration very hard.

And as you mention the partnership with Linaro, we are very happy to help
and support your mainline development over time by reviewing, testing and
reporting.

Thanks,
Neil

> 
> Thanks!
> /jeff
> 


