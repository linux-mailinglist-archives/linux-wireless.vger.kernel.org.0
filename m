Return-Path: <linux-wireless+bounces-12338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE8968ACB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2294E1F22AD4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530C1A2635;
	Mon,  2 Sep 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AuJjMF9y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34071CB53F
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290445; cv=none; b=VxQE06MRBKZhU3sx1PjVDvQRu7q8tghL7JarxnTgQ5Ev5vGAF7H5vEpGxRwpZT5OzvfG/srACLyD7JylOzXZrYnDznrFAXBsa9o4Wkil4ngb/RTGQJeLAzMkX+YZrEaIfWarVcb6l9kY6a0OUfeePSFYjpEusBVw58BeJwmOmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290445; c=relaxed/simple;
	bh=GeH9LMhm4Ne8HqJSfNDQNC9dd/i8G8yAxV2IQi/Yu3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOC+Wjn9De5ILoojm5S4HgoeGkdIe9aR3B77ZGHVyPv6kH+sctLDVuJxome0RTzL028EgXFGgFjnEwh6WuFyX/WjNA3ewRXlHtoVujC0mtW2WSOgkwlGvnMAESAE/O1D64oXQQtLYx5VeCJJa8s+JxkEyKrVm73uLvIygE6tGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AuJjMF9y; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c35ac3a7e6so9863636d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2024 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725290442; x=1725895242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xiBpNTd7P01i/u+Ss9hpT6kKoKywqkPJFpIHasijFy0=;
        b=AuJjMF9ycykit1Su7xNq3NXhWnCD7P3rh1n5tIJjXuthQS2OFhNY5YmSaJmnjSpmqa
         DrRMrdkcQOrI5a3gfcgVIZOE6z+AkvP2FfvE3Gtl56zIHc9/ohtz7/kxuYf91oP/YGZl
         rHOBRgQvyYHOGH4Ixpw4zx6RBAeoc4V/CwKE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290442; x=1725895242;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiBpNTd7P01i/u+Ss9hpT6kKoKywqkPJFpIHasijFy0=;
        b=JI8N1psj/c+8id4kAtXVTUGjnORYFowwdfx3X7s51gKzMtQ3tG9IGimWMIiCCc9SHa
         QxZcL6vMkgOgzA7oA7YT20hQkcSVKm0zY6n00kTfCskaci/g5wGvnt6kobZmvvJ15LCP
         hebSUB9a7yVy1oxfu50+2+s6tXweP2r9peAIXuJ1+mMZtSbDn2WcByOSh+RmZ18YQPK7
         Uk0vgatN67h5UIcxTIWVf/vituP/XMkkb5GLXg48ZUjvt3JVS0KTV6zNFQpHbxzoy8vs
         XNr8GJQfpRkBNquPfo8Yt/m6yTdJ2BGaV5JqpyatiyWMQq7SaLBgd2uKkbCUkRzB33hq
         PErw==
X-Forwarded-Encrypted: i=1; AJvYcCVHdlfLJLNoNhSjBj3b9gH+nLmPxatVBIlfLcn6Y6vvunaVAlw2A1lKp+EfMpG5M4TNsWcqYDWRA9VY1wY1fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyai99TYOdnq20bfT2s2uxprgQ5k6hdJB3C9lf5abi2/5oEskQW
	ZpA4aBiFGu3WK5brK+n/6FbUq8zT60G3f4XeP2WCoHzD//y/sxfYxmHkDn58zA==
X-Google-Smtp-Source: AGHT+IEGddCxgqRqe+vE7jpwRTDhsJODyWT1+afqzlrLtqCjBLp9OyPB0x/+8hLyKZ1oIF+izd420A==
X-Received: by 2002:a05:6214:451e:b0:6c3:54a4:eea1 with SMTP id 6a1803df08f44-6c3551c8ecdmr88033546d6.9.1725290441597;
        Mon, 02 Sep 2024 08:20:41 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82715sm40718581cf.7.2024.09.02.08.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:20:40 -0700 (PDT)
Message-ID: <1e92f33b-9900-4834-80e1-dcbb48cd8394@broadcom.com>
Date: Mon, 2 Sep 2024 08:20:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] net: dsa: bcm_sf2: Convert using
 devm_clk_get_optional_enabled() in bcm_sf2_sw_probe()
To: Li Zetao <lizetao1@huawei.com>, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, heiko@sntech.de, yisen.zhuang@huawei.com,
 salil.mehta@huawei.com, hauke@hauke-m.de, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wellslutw@gmail.com,
 radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, kvalo@kernel.org,
 u.kleine-koenig@pengutronix.de, jacky_chou@aspeedtech.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-2-lizetao1@huawei.com>
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
In-Reply-To: <20240831021334.1907921-2-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/30/2024 7:13 PM, Li Zetao wrote:
> Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
> clk_prepare_enable(), which can make the clk consistent with the device
> life cycle and reduce the risk of unreleased clk resources. Since the
> device framework has automatically released the clk resource, there is
> no need to execute clk_disable_unprepare(clk) on the error path, drop
> the out_clk_mdiv and out_clk labels, and the original error process can
> be returned directly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


