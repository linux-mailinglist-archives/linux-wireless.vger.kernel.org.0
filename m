Return-Path: <linux-wireless+bounces-3442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9638511EC
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633041F253AA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43B383BF;
	Mon, 12 Feb 2024 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSmvQS/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9F2BAE3
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736374; cv=none; b=sW0ylxMggeaxJnpDsSEGup6Ky69Ygyl1n4i7W6QO4CCAEDONwdrAC585jjagS4Rttsa+r19qXanN0+3Zesp1iga/xJYLScow9OHgz06Vd/SAHt73Y9fhH4I+5/Mtw8MI1k1J1+kUOWMrEElowbO4xDvReRk7AMzn5APDlZfHjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736374; c=relaxed/simple;
	bh=xb6g2Lh6Q/m6ugN9GaEtnMLMn3L6Af6xeDDDvsp64HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfs7k0yV+sO7sx51bfvKFV37c2kHA/Sh5kHu4980K9QgP58WSgvaMOKVMsZNBaF7smP0JcyGxC6nAdzYmEbypCd0QaOUyUY9QCkTkgOexS0PXcFMEO32Gv5ESi6FWK9y7DxaOv6cwCNhlWDextwct1A7ukArK/fQbQlur92GQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tSmvQS/S; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d094bc2244so37616871fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736370; x=1708341170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHBVPTLCCK1K07+ATMZqLBCAfy1jkjgoH7L1BwVKMB4=;
        b=tSmvQS/S8tD/6PWE/wOHiibjBuWzQyBEMKCqZWAfh/P8IUF81HpwfrEsDHmBZehBaI
         NqInUYAHhMIZJdOwcicuyuC2rUgmmMLWGT1TlfFlaYemOH0SlZuMgw2GKzv2/nG6uv5p
         RDQg3BexW10iShJRSavHOWPu2zeTKK5uBAnx6Zh8AUGIKh05ctKXfVRzSx+eqWBB6IGP
         0ZzratPGyIAk3ro58PBXofHPo3kf1fy8WZvnOubt9Zlki7OTsRMdCpVkq8mPVkJDKtiR
         dgOJv6BYmhnPhU86foFOplJR2wqMxc1nZEgsiHhpIoRDAggph/y5PW61aW+wWU6nvC95
         pfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736370; x=1708341170;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHBVPTLCCK1K07+ATMZqLBCAfy1jkjgoH7L1BwVKMB4=;
        b=ZSW4KYjixQEFtln9hvqSsqNb6tG0OsetspX/SPXYwjQEjmBC73ExkX6kg8+IlPpZqc
         7f+NZn27P2111X86CnhpUK4LVscxhRvfZD+qfUwvG99Y7aqeCatzPfMiz91v8epaXR8J
         Eaje9wEkg7meVCIN61ldOS5CQAMPc/a8CRRalzCHe0jGPVjzUBkbGbMsN6e0PJH9/VIs
         K8i9ExmTB6ejvQ96LEUBuZHQakqastdkoz6ZepclnPOCiaxQ3RNXCU6UPl3eF5dd4uaw
         ay1i6b+n7vEKVKk877CS0wbSkMYpwyjrwTfW621aIZjZQkEmNF1P8siA5i20jDFfABEY
         hu+w==
X-Forwarded-Encrypted: i=1; AJvYcCWeAXGsq3iyjXO5fpQGRFlE6xlLGjXbBBqkkYaBNBhkqUizM25fxbJrkNpG0CtNpTxP1CFy3psgUCS+B15QSs2b1PsTI6UhyfeDRXrSkuc=
X-Gm-Message-State: AOJu0Yx/DZlREkwOaytox0TlEiWxFYEfbYEChfphuY6NuwcrPi0hdVnL
	bHEI1byF6Ce9mZe1uSUQUwRyOV2hmfxHWENgyHpWraa1Whzu5pVs1CHeQife1Ck=
X-Google-Smtp-Source: AGHT+IEa4vK0/xkbABkqYgx6sLNT5sOa2wgD+dsbTeY5TgLxQcqEaEq90er8k3ZLOVrmr08VnFablA==
X-Received: by 2002:a2e:9659:0:b0:2d0:b336:e0f1 with SMTP id z25-20020a2e9659000000b002d0b336e0f1mr4052361ljh.14.1707736370294;
        Mon, 12 Feb 2024 03:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDK3TNDg+4YUkz3ICxegjKKt8gvtMHZKqOC9wcNHxu2Boe8zFK/MZ+eq+BxsNdK0sRGOkG+uFCpaJUCOMNJ5i1fkF05cTUSEY7TuwX8eicCHhWEq63Ah4/fmdDaoG8teSSpRKu6LIp70MdAiq3VFbU19o04uvgz2twSFTkO4mdAquB88ItWcQcdZkCaFXP86mxUs18/pqF8+FaGgVDzuvE++XLDrG5E3e58JmA52HZY6I2sDR4bMywgsdOt4A+4886RDImfAl/2m8M7dsH59i7+qlawfcNqhWx4uiE9aiFpYqAHip5huRGMZzlqtwfmpHyEJHRY7pecAyPItkI2xcEUfBI8VfYyr+fOxOltghQMkHMg7zjd6vwzqUzATd3OS4ryjGxhZXZcAcJGdkpBbRWd0yQjCzdN2fb6D6RWSa0SKxRgF/sKJxEXl9ykgVHXjnDS5Wd3yTseo2AyNylvGMDRFQxrhJXvyQ4j65xbQf1floFdLQjOYHMe6HpduJX
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id a23-20020a05640233d700b0055ff708dee3sm2618622edc.11.2024.02.12.03.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:12:49 -0800 (PST)
Message-ID: <03d5d556-9477-4f2e-a737-c2f6a96d97a4@linaro.org>
Date: Mon, 12 Feb 2024 12:12:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] wifi: ath10k: support board-specific firmware
 overrides
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
 <20240130-wcn3990-firmware-path-v1-2-826b93202964@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130-wcn3990-firmware-path-v1-2-826b93202964@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 17:38, Dmitry Baryshkov wrote:
> Different Qualcomm platforms using WCN3990 WiFI chip use SoC-specific
> firmware versions with different features. For example firmware for
> SDM845 doesn't use single-chan-info-per-channel feature, while firmware
> for QRB2210 / QRB4210 requires that feature. Allow board DT files to
> override the subdir of the fw dir used to lookup the firmware-N.bin file
> decribing corresponding WiFi firmware.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 11 ++++++++++-
>  drivers/net/wireless/ath/ath10k/core.h |  2 ++
>  drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 0032f8aa892f..ef7ce8b3f8fb 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -942,11 +942,20 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
>  	if (dir == NULL)
>  		dir = ".";
>  
> +	if (ar->board_name) {
> +		snprintf(filename, sizeof(filename), "%s/%s/%s",
> +			 dir, ar->board_name, file);
> +		ret = firmware_request_nowarn(&fw, filename, ar->dev);
> +		ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
> +			   filename, ret);

Perhaps it'd be useful to move to a more noisy loglevel

Konrad

