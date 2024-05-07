Return-Path: <linux-wireless+bounces-7271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA08BDB5F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86DA283E12
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10527D3FE;
	Tue,  7 May 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CB/HxcOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C871750
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062961; cv=none; b=b5cj/KvSq2FwQJxGi/PvPFpj1Ji6flikoCX2bEI57u+udc0oHed9bhSj7pOQTKmTbDmPosdkDSw+nqpBjNvKcu4QPsi2u+2pz+8CjnI/Im+j13HIbT8W83/5wRwIr7AGVMd8YCxfPuynKXdSZHynOdwC8aeXTDgHzzBFledCv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062961; c=relaxed/simple;
	bh=Q9AC4r0AoK1M0oAdVpTsYKUhXM2mN3GI1mDvVnQGC2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O14a7omZWVGlI/XVAYHoPXPBcNOMAqTO3llfaqtmlU5IExlhG9yfym3jJ3Upctg7o1I3sonHoQlRHD1kCPcxKC/yWqUHXR+YLCunB0PoBkBRO5yzT8Dqr1nwKamy9saRTr3DHkUGmY37bFHn74j3A0KdR0F15LcP9OEaB2GBghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CB/HxcOU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a5f81af4so692743066b.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2024 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715062957; x=1715667757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=beiw27RTXIH5HRrfx88EYC36+Lb2A/WvRn/ALhCTLBU=;
        b=CB/HxcOUN7v7THf5jYm/wD96f8cvjw+PfTEUE3TLz1YNchRtjijJHLILhYwoWUfVoF
         z0Ry8VZZkdfYS+CMHeQZvIOPmevJ8Cpd3HR+Kv4/Oh0pxmSo4ATh1RXDulFNLl66c8gw
         SJMjTIPqLIbSsfEah1Wy1RxXLzClrousGEooFwX0PGc+q+0rO2679QYl7S4SQhBuo6Lu
         PlesTyVDtfA0MvIP2Q060xyWL3qazZV6P+AGgQKRppNEkem4vlbOL6Y0U/mVoNwovwcH
         RYYGWiM1lngShA2lYiZVirs35+bT44HeoEegBN3F4geQZgppN52egBk9816Np4yWINe8
         bKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715062957; x=1715667757;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beiw27RTXIH5HRrfx88EYC36+Lb2A/WvRn/ALhCTLBU=;
        b=CLyumKhjUP6zU3chkmVgbFb4PNV+VIH9BUMWY82JPVl2iVk8qHWH1kBcSgfa2povmk
         8SBqbkbVGB0e7iqm9nypqXpip0y4C9Crlv7oaSrjAjoPzJPg//3tTPdVjqEJsHIoMBVZ
         1EBDxbkyg2eUdmIi+ucYfK6AaBRGcjcPnVtTcs0NdwieBpESZDPF6U80GNzf94Qc+MLM
         5Awn948CmhdXTiYNWDmdwu8fmRh+60PTHUv7ze1si3sn27lpLlltO7s+g7eK99SkwBtf
         E6nWLJ6QbqSewoHJ/yOA3eQzXvh0LG6mC8yxPunW3b+F2kR4QyRNMSxNC8kuQnzXjwyq
         xeFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfrITMD+yKcrgRFnnJyLOGRmnIt4RG6zgm7x+DCbB/FZQcKJadq+OoLUI9d5pWmsJI3Xiri3NY/aV8TGMRPkcIW1ANCBGEsxtb9TitDc0=
X-Gm-Message-State: AOJu0YwDHQM67b+xI6FsULIs1ktQBxzw5qMRyJNyfmBEBQK1VpA7zB6h
	bVOfktS7LJKIMEFkL6KjFDygCLjPZeu2VHmc3wfS5xIIw+AD8RiLIM+zhrxWD0M=
X-Google-Smtp-Source: AGHT+IGkmasyA6LmWUlawvuHFNSmPuwvaCT3lWPXH/IhCvTJz5otxmN9wRBrgft7QO7QH3iambCjZg==
X-Received: by 2002:a17:907:94c1:b0:a59:cdf4:f940 with SMTP id dn1-20020a17090794c100b00a59cdf4f940mr3536242ejc.28.1715062957112;
        Mon, 06 May 2024 23:22:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a59b2683971sm3305778eja.187.2024.05.06.23.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 23:22:36 -0700 (PDT)
Message-ID: <d3f9f091-37a5-42fb-aebf-62109db6fa42@linaro.org>
Date: Tue, 7 May 2024 08:22:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: nci: Fix kcov check in nci_rx_work()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, Jeremy Cline <jeremy@jcline.org>,
 "David S. Miller" <davem@davemloft.net>
Cc: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Dmitry Vyukov <dvyukov@google.com>
References: <0000000000007b02500614b66e31@google.com>
 <550cc81a3dffd07ec1235dc32fd7bbde22d9bf57.camel@sipsolutions.net>
 <CA+fCnZe_fuT2y4ryFeb8A49k19MY3Nct79JCoGwQh0hjcq6bqA@mail.gmail.com>
 <6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2024 12:36, Tetsuo Handa wrote:
> Commit 7e8cdc97148c ("nfc: Add KCOV annotations") added
> kcov_remote_start_common()/kcov_remote_stop() pair into nci_rx_work(),
> with an assumption that kcov_remote_stop() is called upon continue of
> the for loop. But commit d24b03535e5e ("nfc: nci: Fix uninit-value in
> nci_dev_up and nci_ntf_packet") forgot to call kcov_remote_stop() before
> break of the for loop.
> 
> Reported-by: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Debugged-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


