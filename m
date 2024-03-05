Return-Path: <linux-wireless+bounces-4366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB0187162C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 08:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08021C21B5D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 07:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AEC7B3CA;
	Tue,  5 Mar 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLJ8aalq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEC3398B
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622304; cv=none; b=tKyA1/3raVtbv2fQpwRFDA6RPDkQzbiZobPrTqlZIJSpT0pwF3mEpvN3/diY0AYR8pBe6PmKRottu+y8EyMzgPrTMQXB/kvtF90tpoYGoPakLBYN8z70mLp7bUZozdApsqUbhJKuUZ1pIXB0GTLOVfD1pZVNm5bI9WEWQezp/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622304; c=relaxed/simple;
	bh=4JVBcQ6LdCwPj9B/t1Wya3EcqQrrvRPH9O9H1yxsNkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NURnsThQBSk8oOGOnhNjoiN6cnwEkEA0nKJuqa86HeXAV7nfq1NvE7N5MbT+C0BYVSACsTYOfbuKuKED1d2noJvsknITK0cVRY1fSvsCApdmnOOWFjarUGSqzK5j5M+uGLtF+ETO3AbelhH+tkOVka75BKMthu0SlFuqE4SiJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLJ8aalq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a446b5a08f0so700891366b.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 Mar 2024 23:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709622300; x=1710227100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2klNA+6HuLnelVwHd/hZlMG6axojhHck2M9xbp1Yk8s=;
        b=FLJ8aalqhn2eWmScY22ave2vpQj0G4uaYFVT1+00K08sciosNQbMeHC7iOR4VAGF2K
         eLPiWOAennGNZFRsOWMgpbXnlW1LlzBNCMKjtX3CJzOPaDJ8qI+8ubI/Sz0funbkWX1E
         hqLO7Y89VQkmwcxSGbEOvkQWg1x4iXmxImkP124pzWVkH7Ny3uR1IfHMeifL60jcsfLR
         qvkUkFf8c4qVXFYn/ZiIxg1dAKV3lWBzfysx+RYxELON7V5TskuFAKnCb6wLbLznzCnc
         /WrMVkr16lyY9q1fRpBmrQUNREUX3V1t3JLt3FtbWylyqEfF0BkEO7RASRxtzxuxOto+
         gMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622300; x=1710227100;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2klNA+6HuLnelVwHd/hZlMG6axojhHck2M9xbp1Yk8s=;
        b=oVE3CFfx3+KbU0U0AHwvomuXrFIvsFdxm3Fm/iZByLXTXNsao086mdViHlnFiLVil0
         hb8bdv4DR5iyh9RbJFJ3tJ8A19PV+YSbmQSVSKi4HA8cvS423NEG3MzYiOCEkFjQU7g7
         6XS3w4g9ZzLOPQs/NeL3iJKyFa/bDHKTSaPLatcpgn3o55ZPDOOwoq1vl1GpmG+Dq16c
         2MnhXwOHpZ4FXaAX28BQBR1NNPdYY/FVpRMYaD6Ul/6nJfGWUwC99KfrHT8R+Vz7NpJa
         iLSOhvfhmM8eEBtaP1T3drxs3wDG6SLi8BQu2HKnzPOcDN8Fa4jAll5tHasCZqOp7v8I
         kxTw==
X-Forwarded-Encrypted: i=1; AJvYcCWQmc6qm9Gu7s7MmMHbAtMOr7cvTkVO/+w3kO89XvTmGiUZiX5h19pLhfDqMeLx/bB6sOx4AecQYb58z+R9HU0vBwTQ5CofGYPQwn7YKC8=
X-Gm-Message-State: AOJu0YyEPQdnPgtahoEELn8++sOeR2pgVq4Uc5ppCvHZaOyDU6W4iGuQ
	snEdw3/uTyZgtWzmVR/kMcCaPQ6Ip5Sd/KGWxK3MtDdYtyiW2yEwc4aWa1uRyWQ=
X-Google-Smtp-Source: AGHT+IHykJXFdxa0ufKnr7SX2KdXakqLJaJBGEg6y0UVS/JVEwPwDx64f3vuGcfAf79RDyfILrpubw==
X-Received: by 2002:a17:906:3648:b0:a45:96ab:28af with SMTP id r8-20020a170906364800b00a4596ab28afmr1883345ejb.10.1709622300408;
        Mon, 04 Mar 2024 23:05:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709064a0900b00a44f0d99d58sm3266126eju.208.2024.03.04.23.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:04:59 -0800 (PST)
Message-ID: <17f958e0-b5f3-46b3-8522-a26fd65eaf79@linaro.org>
Date: Tue, 5 Mar 2024 08:04:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: build ath12k as a module
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20240219084610.11007-1-brgl@bgdev.pl>
 <CAMRc=Md0H4=UZWNOoZR3-b50BrF-ch=34aPdqm2JhOXQzNi-mQ@mail.gmail.com>
 <228772c6-034e-4727-b410-391316d8f340@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <228772c6-034e-4727-b410-391316d8f340@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 22:46, Jeff Johnson wrote:
> On 3/3/2024 2:34 AM, Bartosz Golaszewski wrote:
>> On Mon, Feb 19, 2024 at 9:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
>>> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
>>> defconfig.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Would have been nice to cc the ath12k and linux-wireless lists (done
> now). Just happened to stumble across this.

This is arm64 change, not wireless.

Best regards,
Krzysztof


