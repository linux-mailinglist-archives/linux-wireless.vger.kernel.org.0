Return-Path: <linux-wireless+bounces-218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B467FD6A8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 13:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F1B21045
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B91C688;
	Wed, 29 Nov 2023 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn9E2SRa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D366D48
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 04:22:49 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d66c7af31so63758085a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701260568; x=1701865368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OI5871w8cbxhn6qPdL5gY/k0HJy2tTjwxwDs37npXE=;
        b=Wn9E2SRaf7ZNl4JWD44iidbdNdzUJ3QfiV+93FywKNKuXJzWwTW4gShzzELoef9XCT
         CqY/LPbp9S/XvPfib4A4CVhpxR29+x0U+YQbW8rG42vNV04PrgzN6xXMosh2LFgOUVFk
         ijHR8T5V+dD5uXwhrNvQelUuMDa9xQlpTIB7frjoIPuJ7uUbnw7STulQ1FyeNxnQIa7Q
         jvtp/IWKO7IyEget9tH0UDtBcS9I8H7auf4tfUcEHlhUL0L2hWd5MqPUp1fRDT6+EGX8
         Xz3w6/FuA8y08KOUH6cjlSQk8BEfNf3SA5wbyeI69PlMtT0bOIOnq774MOEDdrVoBmp6
         X9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260568; x=1701865368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OI5871w8cbxhn6qPdL5gY/k0HJy2tTjwxwDs37npXE=;
        b=vAevdHsYStKdb6ZOfLStZKRCKuYdpju+eUzQeR2p7nLiNkvhjsKYiu0sYVtA60ffPE
         m/VnmFdjWFq1T627XZQwCkOg/Dpm+INglZKCc8ZBvZjeyg1ji3ZBKadvIzXUb9qEmz6I
         KqpvJ2RUxt1yEml2jxWstynqIBBGGGX1TazXnxlJ7oCOeE8CrVvPAg9xiKJzGYqeqlvz
         8AlghvK9+dZAY+yftwq+QArDJOwElE6TIK69vrBG3t7Y7z2ad0TpeD+5Nj5yZx6WYcmA
         F5u/ubQBg905R5haWaY/VIjRNc85+r3nRonez2exT6t0JagCfFsuN2F1bshDco6vdmuu
         2CJw==
X-Gm-Message-State: AOJu0Yxyn2/FG8fWdJeoS6bWPq5wmCvLNHXw9BLbswtonN8e3yz3TOEb
	F+OU69lzBEJNztfO3Zi7B6iA6E8A4WA=
X-Google-Smtp-Source: AGHT+IEwslwiSWk24SlK7Ar0ZoJ+1qIQ+By66eH5O3zEkFHWr0RUZIs2OeCAHpe5fqUB7Ity6+AVug==
X-Received: by 2002:a05:620a:28d0:b0:77d:84d1:a5a3 with SMTP id l16-20020a05620a28d000b0077d84d1a5a3mr24667369qkp.20.1701260568514;
        Wed, 29 Nov 2023 04:22:48 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id rc11-20020a05620a8d8b00b0077d797676a4sm3974207qkn.122.2023.11.29.04.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:22:48 -0800 (PST)
Message-ID: <2bd104e1-2cd1-48dc-849f-e56678eca2fc@gmail.com>
Date: Wed, 29 Nov 2023 04:22:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: add support to allow broadcast action
 frame RX
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20231116173246.40458-1-prestwoj@gmail.com>
 <170125916304.1282598.27815217329600631.kvalo@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <170125916304.1282598.27815217329600631.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalle,

On 11/29/23 03:59, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> wrote:
>
>> Broadcast action frames are needed for the Device Provisioning
>> Protocol (DPP) for Presence and PKEX Exchange requests. Currently
>> just ath9k has this capability so this is being enabled for
>> ath10k (for at least one hardware variant).
>>
>> Add a new capability flag in ath10k_hw_params to indicate support
>> for receiving multicast action frames. This bit is then checked
>> when configuring the RX filter and (if set) multicast action frame
>> registration is enabled.
>>
>> Until more hardware can be tested only the "qca6174 hw3.2" variant
>> is enabling this feature.
>>
>> Note: I went ahead and removed the 'changed_flags' mask operation
>> since it had no effect, that parameter was not being used anywhere.
>>
>> Tested-on: QCA6174 hw3.2 WLAN.RM.4.4.1-00288-
>>
>> Signed-off-by: James Prestwood <prestwoj@gmail.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> This had a simple conflict in ath10k_configure_filter() and I fixed it in the
> pending branch, please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cc9f5dfd74f93ae6f596bccc3a5b92fe3f18c439
>
> In the future please use ath.git master branch as the baseline for ath driver patches.

Thank you for resolving that, and I'll use ath.git in the future.

Thanks,

James


