Return-Path: <linux-wireless+bounces-2882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1A843908
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08FE1C284B8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0261D5DF25;
	Wed, 31 Jan 2024 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbl8Gmk3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC55FDC5
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689676; cv=none; b=QBOrjPLglVv9WdYiCchH4Xyv7i2wlT34yHqx6sMRPUEXc/T4tDrEzg50A4XwQNfkVFQRMZjK5/asHK4SIY3zkHkOULdBrGofEIFLBxmYGV1GfsMZnngmIXcLFy/ikvwO0qJp88KnrSJLtku+lWchAl+JvnrWMpczZpdmoSJFuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689676; c=relaxed/simple;
	bh=MY2r9mYRhywVE6Zyf3jdHEdPVodHSx4Ti1w826wtNY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pty+0RhN70AezLn2aCr3e2dp5uy7hojkdeULkt6NNT9fzL+fnKABoNFdKfjU/AvCox+uvhq4KsQe2kDCUrsi/KrmILnwzUKwn29tKw2p2ZsDjyGpsly6HLxFl+7zqVoEJ5yhWn/JOlwuxkvvwQ7M1F22kyd2c3zDTR9gM3ymqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbl8Gmk3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f082c2c92so4226996a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 00:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689673; x=1707294473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSyq8T0dgaUi5zrT7v/7kxWNYaOkrtZjbuuR7I5khSc=;
        b=hbl8Gmk3qMc+AYYVkZrzQ8PzHxin/u9ObcWRCz+Cz6kPsMSntwh5WCUg77IG8S/UmH
         jrti9tl85wFnxOChMY62kO0zI+B2A+wMGOHgc/mEDtjNp+8eBdqPQ3TjY+lUd0jnZANp
         /63hUyPbUytKY5d6qO8JQLb/TwsXMYJaOrK8H2ZPDvkLiNZ4kWYz7NhupSlJl7f9OibP
         dlU3+MJCgzZY7zF+Uvog26drxJIy5i6uoEkEbHQCAuEpYLMjKKhu1QYVSAefKYJZgnuj
         YRSc3MdnRTm9Cr2FtVnOC1pqS7Bz4o+MKAKCflrGHgQsqsTG6I9dzyqL/OSD55A+TDIR
         uUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689673; x=1707294473;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSyq8T0dgaUi5zrT7v/7kxWNYaOkrtZjbuuR7I5khSc=;
        b=FlS9XUpgHKpNIJXF9cLlPYo49TKY5liD9rO/l/tJdQfsSAB5xmLQiCsfTmPqTkVrVJ
         loCM5n/hX94N9FqstlE6xxhYTkLwXwjASHklrVsEn3O0/Q26Q1D0fPuR/VCXaBBKbsUl
         Bf6l8ldQPWkvinaBkUPB3ytn5bmK6VNOgOn7dVszYO/w4JRyGF1en9wkJ1/f7/tJtxg8
         CjLrDXFU3qR7dm0FyJEybrNnvpVJbs3HW3PSvYgvyLWSzBXTKYyKJCtBttAhX3ncoylV
         lZ26FGXjKTziLPyOgzbZYqi6LytpHbSKlPJR9XOOnL2MugqaXb82ynuslFJkNj2PTqQO
         ropg==
X-Gm-Message-State: AOJu0YxjkSXGONPJ84f7rTcU+f+9uvY99qeSIjsMgpGH9UMtj1KU6scp
	wvu8djziIiF2WNXXbq/9auY/WQUXnLtEkdiS7qLKFflO6vxGtxOLCt+wUjkSWi8=
X-Google-Smtp-Source: AGHT+IELjYRIc3zYE0j0jPirvie0a03AwJKzNe6ScjTg0S9BDZYPz9H0ESnHsbPbuzr/vd+kofGQbg==
X-Received: by 2002:aa7:c2cc:0:b0:55f:314:6890 with SMTP id m12-20020aa7c2cc000000b0055f03146890mr580405edp.22.1706689673084;
        Wed, 31 Jan 2024 00:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWts5SGByEezZ9xzA8RTu72RZOePLNR39WdTnddJ5XM+N/q+2c5XWBt8goBlk/BLIbgaRudJSYf8AfMLwzgPvaQQ2jI0kyioxLoIp1zqe0HK2zVHEt/4kh+0Mjo1fawrAmwItsvhvf0NB8YS3s4cZU7i6DUqiiRY+FBOFZiN5Qg/Uss7GcpUOFC2qLpRQh3uZQpOcfufsGmSfIWeZJKJ82VeYzX2udbXp+ZegcTGuDE8yFKRzvoRirMm1fnqmp2D3wiKsJ5QH/mFVlN0TZK8pQN8dnaqWIzIoJPxqD9hGGav0wAqnnTtdk3Vui/F1I7oVIxf5HJ06I6hDPFBOMSoS4/ZQW62KZvfIY6UGxKTnCR3Woer5MOE+Qmu1434FI5MqV9Np4agZM2Q64SbuVCn1/my6fsFfnCT1WP06+xvMgv9ApfZFtXbVnKT+EXRooH5tp7IbBWKbWX2tVnyk1CT7BQRPfSin1v2PN0CqO101HSjNot8Gbx0x4tlBaxOAgwHl/XWpOm3TLsa2/ZsA/Li1WeFeHWGZhjBks=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id x6-20020a056402414600b0055d36e6f1a7sm5442819eda.82.2024.01.31.00.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:27:52 -0800 (PST)
Message-ID: <f5d3cf5b-9e3b-4904-8edd-fa1e18652990@linaro.org>
Date: Wed, 31 Jan 2024 09:27:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-bindings: net: wireless: ath10k: describe
 firmware-name property
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
 <20240130-wcn3990-firmware-path-v1-1-826b93202964@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240130-wcn3990-firmware-path-v1-1-826b93202964@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 17:38, Dmitry Baryshkov wrote:
> For WCN3990 platforms we need to look for the platform / board specific
> firmware-N.mbn file which corresponds to the wlanmdsp.mbn loaded to the
> modem DSP via the TQFTPserv. Add firmware-name property describing this
> classifier.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


