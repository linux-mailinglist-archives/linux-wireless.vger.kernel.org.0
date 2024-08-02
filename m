Return-Path: <linux-wireless+bounces-10869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315894626B
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 19:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE07EB22299
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A11537C5;
	Fri,  2 Aug 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T5CHZAyE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334915C128
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619734; cv=none; b=WL14K1ASLBmlZ1PljTqPpUHh+Cw8CpzzZ2m3bP4eWVGe4yKBTRZ3KiDnxCZ3PWNBk/aSLBXiCO/ERROK3e3pCvLOXy9PT2E4JWr0yqxWCcNk6Mkmrvkrxwy9frtnEc5tM6lYlZHGrKwrjuFuxRJwf61NdgNDIoJwV3TFP9INjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619734; c=relaxed/simple;
	bh=ufZpM9JltkFfnggMkkjgC7Um3zuQKBWRiOgCmbbazj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldONeifjKrFbzRAKv1VF6ltvbK8/gWp5sgBT58LRYyYu2t6p4rlmaTnpFj8ugepXLBYLRTPncYIvfKaJt0c2yWCmoq5y7iK1qKHwPmKpb2nxVPRIHwoTAAfbWCcvjCE9eE0xwGLID9+u+KHSu0lLpXvYAz0foTZgsPY5jQIehxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T5CHZAyE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093705c708so8573117a34.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722619731; x=1723224531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Loq2nUhoV/a/FTrOZuQKs+xfpnLLREOs45RNFVOD5TI=;
        b=T5CHZAyEUQFM/we12I82+3O/t8HFHAqEPVDn5I3RSi4IEpXPTXqaaILTWHk5SM4QfV
         BFiPfgW6UzSktbO7x9QopavzYNbpWfmTiKuIzRNEzVnRDUVbh55KTTwFG9uFU2kl2nS9
         i+vRKwsTBg+YnBa7rEX9oEhr8DB+EIlIeoPvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722619731; x=1723224531;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Loq2nUhoV/a/FTrOZuQKs+xfpnLLREOs45RNFVOD5TI=;
        b=Oa4PYTwhZTyY0UMlXDRS2rGu9xveFey/3fMuhQsaPSCMXopTnsXKuyQGksgTickOdb
         ZXs+Gy2wu2BVAKd12uWKOmcXs/nYOv7VUYCLrjhFlcjKLn+dUVYQPTNF0VLgWLH/mEYd
         w9Tagnt+CusE720xG9VyDsr0ggLbNAaPd4nrDMlSUiUtZXl9ffnJWWaQY8EEHz4M5pgj
         Cix2iQyjAIVz8YxuPP97GFhxMSZjpLNfw4KrSqoyzSXZ6ow2WJhwFx44LECv1rXNd4tE
         mJuqNmkQ7qLwKwu2Um8m6esaprECxUYdIWNefkbWYC1Y6bnwXfcqakUjcwRQ2eCVjlqG
         FgrQ==
X-Gm-Message-State: AOJu0YzlTBff5elFvc8SBNEzXJIzFLsmIeWBaLstuIG/DKGuwmlRK40S
	MqCm6kqDPiOFQX9tG8MMZqnyJiy9YUTcnd+bj233aB3uUA4HqjZPMv7cfVcMM47HRADson0GYKc
	=
X-Google-Smtp-Source: AGHT+IGs6KFzCe98hzuwG7TnKln/IZKnkWDmWm72K6VV/kQWhhHTVpj5FW0jnR/uRlunbLa+WUjiAA==
X-Received: by 2002:a05:6358:419:b0:1aa:c73d:5a94 with SMTP id e5c5f4694b2df-1af3ba46a9emr369433055d.16.1722619730724;
        Fri, 02 Aug 2024 10:28:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76f6e2sm8862596d6.14.2024.08.02.10.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 10:28:50 -0700 (PDT)
Message-ID: <f2cc346e-63b0-4fb7-b954-5dc3e597b7e1@broadcom.com>
Date: Fri, 2 Aug 2024 10:28:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT] wifi: brcmfmac: Add optional lpo clock enable support
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Ondrej Jirman <megi@xff.cz>
References: <20240802083400.166753-1-arend.vanspriel@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20240802083400.166753-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 01:34, Arend van Spriel wrote:
> From: Jacobe Zang <jacobe.zang@wesion.com>
> 
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe
> 
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> [arend: handle -EPROBE_DEFER scenario]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

This looks fine for a cold boot case, how about handling suspend/resume 
where the clock might have been disabled, do we need to deal with an 
"always-on" Device Tree property as well as whether the device is 
enabled for wake-up or not?
-- 
Florian


