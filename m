Return-Path: <linux-wireless+bounces-3446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251185128E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4E8283146
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C439AEE;
	Mon, 12 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLkvrCYQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC539AE7
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738412; cv=none; b=okg+qLr2818TSw6jKUDMPgeDTN9vp0ncLyZof8uoJ65f9HkvIhOzuevRE6uVRxG5Efm7dyt/MP4hQe3zlnf1xZla2gm0my418V6GHOuvFiFwVB2tJ6GALvyMjbMIm4/hZ/Zlt7d6x8JjXOmDvFySaLTRiDFumXAex+kSH6HxUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738412; c=relaxed/simple;
	bh=YZI0iWYIs4Bh/cvrE2Q1viIQKQR4G93YPr/aYKc/beU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Glxv4KtId8cWPjfzEfo3Xf4W1+/l7W3eXU+g5oFry30jZf3j0+tcJcBhyumNxkEgkxMIA4dog6c+D7rrRePA+kapaGZjep1FWUWMmZMC+p2nuGYC1L3bYvrtSQzbe/QbVYaGg+f6vH7Fe9tgR95siSkggO9VPqSezhWOQqwNKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hLkvrCYQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a383016f428so328290266b.2
        for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 03:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707738408; x=1708343208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6igGhHE0Wmh8X+D47XGNFybq2+vq3ZSP8U8DuXuJZOc=;
        b=hLkvrCYQfeMwRdjvmFwF7kO4qJYU7n/XYGYMGxOCMvRK/a79/z41s3KlKvXaK+UCc9
         x3/dwSmUqwrEtCz8uUGuDY9EJGUxsQhQyUwnrnEwVHyVAfJcjx/Q1EpKj6jauiy24dKA
         VLtl7KuAfa0VQPrXFJitrBe1BeyC7pU/cEBojFO6iQCkqm4tOYUjpK0/AJo7EN1nG2TD
         xz4Z4AE78w/+9wi42RCYejqF5uhr4F5dZCP3ifq+02osWPeohTxj8FzSUEM7ZGN3Q/rW
         k/E4MQHqKd0DPs4DfcYS8tA147XermheknVtkECbK2YyZBmBDIAtFz3DX6eVIULXuwAD
         TxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738408; x=1708343208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6igGhHE0Wmh8X+D47XGNFybq2+vq3ZSP8U8DuXuJZOc=;
        b=KPz9A372X5fcly0gaxmshK6G+5KwqGGgpCsloC7WoIkk8EQCt6ET2Rg41zCHJ8VqKQ
         FZxbXyZAq9JrCFqpPB4DD+9x13cuTsgks/L1Qkw7lCESjwqOtl+zCY3NSKbv1aQ28x7G
         f4pA79MQbhWtPYM0JBE0/TWxBMpQzVaCTjEVSigd4y8ou32290dfnpoMXrSe2+aZH4xl
         /IiLQ9KA9sI/ZPjYON0F2U+qov9jxWx3B6FxViUuNaAW61Lkzdbf4XzOJ5P7GUhxCfA1
         h+LKY3lMHVKsUzCwCT4MJ41lE7oNtHOQpeHx9VbrnPe11pgzC1WvORUhv8dagmq+qiEI
         N+LA==
X-Forwarded-Encrypted: i=1; AJvYcCXwG+Y2Ecdt4uyGRjvoWMc4cKZSAQ9Se/Zm3i6YV3OZfLvNnNSs8fphYAFBDWzb56ZQ/IcrxlueKTpyPw6HABMI4o5+bVYrB4s6pLp/7wk=
X-Gm-Message-State: AOJu0YxiGlMhd8XmH2IjjVzifjxJ4wlHrGv6qFq6csfJ2Hak/MKi7FsN
	SMX+oOuGCDrhqV+r0n3D/s6ztltBvUiUH0pAjrwrZBgOQgFh7hGyo65OPRMgshw=
X-Google-Smtp-Source: AGHT+IHtMO/k7BQoK4cFgFlk4EAZ+OtEN24JAjUYza+tSEgNVW+iUAxv4YEHSUvFdsrBYJxx0+EjlA==
X-Received: by 2002:a17:906:46c3:b0:a37:2bb1:7517 with SMTP id k3-20020a17090646c300b00a372bb17517mr4477352ejs.45.1707738408616;
        Mon, 12 Feb 2024 03:46:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmdlD4KAro5iEc1Dr31HuIN4wk6LEz6e3kSziAz1hQ9NyQk1cdScqmB8JnycEV/4aRK2lP0ug8ho26cKPWBmAbgNK4TCs32ts4W+u7m3j+b0V1DJzCYhuv2XM96rBMFUy5fAo+Fj1Wnesw3KvBx0FXphgcajzpJBux4hJ0A38Pih44RzZWPZ/vPH+AGqIYQPSZ4/DV0ucix0Z8+SFYLbvfGbJbwo4kinntjvjW9m8sUnSKHT1lts7Li2WLXMLzpR6YNq3vtjTJrVNAlaqWcXHqIEqLgGmFYMp/FHOuo8SyL9uQY7Xo2O2wDfW8tz9cip5fiD19wmGWWQtV2CqmXwdwcpChYAydTZuSjz9j7xKgkl3OpodD/RCH3l74Ml8NoDQbVyDkZdXaNzssexbdh3+91cGzgm6Njw+eEEmY9xZGy1ILDPJ34WUd7QInVpo2D92LHfqYUo5kq1k2D/cDyoVLl7dp2ZSHOVGlBD/DVGDGxvJSk1+zEaGkqTW3sIpC
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709067f9100b00a3c89e226f7sm123069ejr.181.2024.02.12.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:46:48 -0800 (PST)
Message-ID: <bfce2357-129d-4eab-ba7e-99f96f79ade1@linaro.org>
Date: Mon, 12 Feb 2024 12:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: qrb4210-rb1: add firmware-name
 qualifier to WiFi node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
 <20240130-wcn3990-firmware-path-v1-4-826b93202964@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130-wcn3990-firmware-path-v1-4-826b93202964@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 17:38, Dmitry Baryshkov wrote:
> Add firmware-name property to the WiFi device tree node to specify
> board-specific lookup directory.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

