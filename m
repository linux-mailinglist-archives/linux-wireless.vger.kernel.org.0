Return-Path: <linux-wireless+bounces-4368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0281587178C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 09:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263CD1C209BC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5157EEF6;
	Tue,  5 Mar 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yX9x5Av2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CF7EEE1
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625898; cv=none; b=EdFuYcM0uPs4wKr5yRpdEJ4b5FDp7q5GXf/tphZK4gBIm5chnpxwl8vU1ErgAxqe2TTbYJQjr72qknkwjrPYDG+TdQZekjmGRcYZcxKZPVXYGzZwbPj7bjiiS2LoNMe9wOVicH9ZTxWGzMpoA0y0rgAcEqELbRe3A68wiOOyTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625898; c=relaxed/simple;
	bh=8XsLYUrP2htFSti77UN9KCuakQBBAP/QjFIhg07svrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7WerYulGB8Tpmd1k4lfbPLOTu0it8R09ywUhoNR7usw6gFhQvvjo7aMpst7V6NbBbTe3Tt0be/YE3z6ZIDMQcL4Z1k19WavLp/Au2wBg94wX4cQincpqdq364jqL9m1gbLhDxhHVof+1iDXC9bqdDiodpTCyCtaqnCrFOPv9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yX9x5Av2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45a15f2bafso47949066b.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 Mar 2024 00:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709625895; x=1710230695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z321qTKWtk15yH3t9Ej/fGlBYVjhkASl76YshRID/ZE=;
        b=yX9x5Av2Ox4HYhnfUeYC9osJP2kX9SgUo22fS6VOgqfu9rwfiW2axVQU9/lK9MbfPN
         zlYAG/royXBHWrONBi2iqUXztZ+YuIU0LGIjgcmSguRqkfDIowyp+n1HKobjB/LJqqDe
         HO8KazqNl5FbFf4noXGNY7n7ykfNV1QfY+1GgPzdDk8+s9+qVMcMwe2tBJIgKR0Og9dj
         n7hFFKTgPTncDR7uhE3IQSf3tSuKfsptqSfgeuZVtY+XuDL/S5uitRipLVvSn5RHNbVa
         M+ManUCxFli2/+0H/tFuAMLHnPqRmhQnsfNpB5MCy0WRghzkTWSQCGQBABNZS9njpeeI
         QlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709625895; x=1710230695;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z321qTKWtk15yH3t9Ej/fGlBYVjhkASl76YshRID/ZE=;
        b=rAGeM6Robz/BL4PTy2xZWnOwwpWtR4Jf3EySJdafAJYV1ejPwz0J7FTMQPY/eMC9Ht
         c6UvCoWRwXcQT+PPI68coUsiEnHzhueKA6XM/ZSvC/ET//p91HXe/J1qLfhjeDbnnNcW
         l9oE4txjoCZQfC9S9irWniyc6EKRPwUEcP3dgNPmsmqDGiw6vkfnNXeFeYMeYKsDzbSB
         hZqkelE793meic/mgssYBSQ0LWOBps0fJkax7iFhZ58Dlu8odLNyfAxZWAQUufORBuTd
         d+TvpVcZU3HiKdW8GJ2Nl3cg16ZX1KiBhKltIumdcpjTvY00ps5EkHtheBiLqzxvd5yS
         jXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuG0ltLTEnwCXODfcvWGr0wG9AlFS6ZjMjQ+vpmZmuxbCMX9wwmQjfL4sqPtl/ec1mQoqgDKEQO9xpeP/j+/UkH7iHJWqCvkbKgfrHTjs=
X-Gm-Message-State: AOJu0Yz9iYzt8QRMDM6HZM1jVvB1IeyrGfRMANciwYUgvnw11V0u3dc7
	uZNflQH2m63+Quit6hAffjLwU5cz3m1vVJZc4VI8YIVtu5H1VzpKbtZ9NL1C3m0=
X-Google-Smtp-Source: AGHT+IEJoL4rNXit1Wc4e/+msPDAwWm73giIGlMLyDcfuCOmEdIZnp7eAMTy35qiUMPZ+j61jG1zOw==
X-Received: by 2002:a17:907:7677:b0:a44:7bbe:d770 with SMTP id kk23-20020a170907767700b00a447bbed770mr9366046ejc.7.1709625895391;
        Tue, 05 Mar 2024 00:04:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ld13-20020a170906f94d00b00a451ab833c5sm2635117ejb.21.2024.03.05.00.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:04:54 -0800 (PST)
Message-ID: <f2c02ebe-47a5-4035-9bd5-c4c1f13e27a5@linaro.org>
Date: Tue, 5 Mar 2024 09:04:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Conor Dooley <conor@kernel.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k
 <ath10k@lists.infradead.org>, wireless <linux-wireless@vger.kernel.org>,
 DT <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <871q8wk7o3.fsf@kernel.org> <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
 <87wmqoilzf.fsf@kernel.org> <20240229-ageless-primal-7a0544420949@spud>
 <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
 <20240304-component-animator-e2ee0ab7574a@spud>
 <CAA8EJpq5HQaO2E2Pd7yqUTsWyQ_pLDdyoWng8QmWTzYn5fv3PQ@mail.gmail.com>
 <20240304-superior-vicinity-3dc6ca88141a@spud>
 <CAA8EJprMG=fY-G-X03bm7MMhcua9axjw5ULZz0efgHxwzgrdVg@mail.gmail.com>
 <20240304-privacy-registrar-93c48ab1b9c5@spud>
 <CAA8EJppoc9Mu7s8bzXjW_NJDQ5go2+MvoFG_JCnwP-6hC1SRow@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJppoc9Mu7s8bzXjW_NJDQ5go2+MvoFG_JCnwP-6hC1SRow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 21:21, Dmitry Baryshkov wrote:
> On Mon, 4 Mar 2024 at 22:17, Conor Dooley <conor@kernel.org> wrote:
>>
>> On Mon, Mar 04, 2024 at 09:59:13PM +0200, Dmitry Baryshkov wrote:
>>> On Mon, 4 Mar 2024 at 21:46, Conor Dooley <conor@kernel.org> wrote:
>>>> On Mon, Mar 04, 2024 at 09:37:00PM +0200, Dmitry Baryshkov wrote:
>>>>> On Mon, 4 Mar 2024 at 21:34, Conor Dooley <conor@kernel.org> wrote:
>>>>>> On Mon, Mar 04, 2024 at 05:21:37PM +0100, Marc Gonzalez wrote:
>>
>>>>>>> Thus, anyone porting an msm8998 board to mainline would automatically
>>>>>>> get the work-around, without having to hunt down the feature bit,
>>>>>>> and tweak the FW files.
>>>>>>
>>>>>> How come the root node comes into this, don't you have a soc-specific
>>>>>> compatible for the integration on this SoC?
>>>>>
>>>>> No. Ath10k uses WiFi SoC as an SoC designator rather than the main SoC.
>>>>
>>>> Suitability of either fix aside, can you explain this to me? Is the "WiFi
>>>> SoC" accessible from the "main SoC" at a regular MMIO address? The
>>>> "ath10k" compatible says it is SDIO-based & the other two compatibles
>>>> seem to be MMIO.
>>>
>>> Yes, this is correct. MSM8996 uses PCI to access WiFi chip, MSM8998 uses MMIO.
>>
>> Thanks.
>>
>> A SoC-specific compatible sounds like it would be suitable in that case
>> then, to deal with integration quirks for that specific SoC? I usually
>> leave the ins and outs of these qcom SoCs to Krzysztof, but I can't help
>> but wanna know what the justification is here for not using one.
> 
> We can probably start with "historically established" here. From the
> hardware point of view msm8998, sdm845 and several other chipsets use
> a variant of the same wcn3990 WiFi+BT chip. The actual issue is in the
> DSP firmware, so it can be handled via the firmware-related means.
> 

The WiFi+BT chips are separate products, so they are not usually
considered part of the SoC, even though they can be integrated into the
SoC like here. I guess correct approach would be to add SoC-specific
compatible for them.

Best regards,
Krzysztof


