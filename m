Return-Path: <linux-wireless+bounces-33974-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDseKLksxWnb7gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33974-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:55:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E33358F8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A3173034535
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB6285C88;
	Thu, 26 Mar 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ8ufbuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1E257459
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529718; cv=none; b=Hj1nMw0zMfVw+UnUVPelTuaPaRKPTVv0w3N+EnC3Kmm/wm/hnZ0CyN/N7cFa9xbu9JjPEPM84GqK+R0aFZR0g1UsD+3BzBvcO9AyaWkIuWhsJ4ftahuj0lKxmP68tjqddoAX1dZTby/U/BO2oS0QCPk9FsIW4nOiLWfX4sPti/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529718; c=relaxed/simple;
	bh=Y0FF9WEp5KmFXbC+L8OjWx066EP02rkF8OEbRbkcYEg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eOiAkyMyQxeUerKqBeJnIDiQ90tH8rhnqhRmjrJ0tGX/f6cTOuYvoQSkAkfiak16v2k26LDC3zsi7wtjomdplKlErvbfl7gu1d5Wy1hbis+ZF07vr8tIWin+N9XXMtbK/nBfLgt4YVOTXrg4MWHS5LvjrSEYA+/gigpN1jSgYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJ8ufbuQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso8203865e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774529715; x=1775134515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X67yw9hp70DJW5SbayvQBOmUIp03R92/bYFmSlkehKU=;
        b=KJ8ufbuQUFmOzhQDZvCLZ6XVPxV0h6G5EVwow/IApzRkh/cr0RTs94Nvvn5GWcmRm8
         0kYHkw5xqF3W5fR4MfNdp7XkttG9TpmjSKIS7ccHHwM4+CZD8cFEhsi3jzDp+zMRLHon
         ooUmd85gyEX6sAo2VmMsSPxgkpNPO6x5Jgw496YopxCOoMqaAc35ql8xhhtlSFVtfFuO
         XlTvhuzLydszWUNQG2vNjWiKrjsIp3DGG0fcnbnzC9wP9KYBvvxNchZdmGtN21UnGPKm
         pvC47s7rP1SSXvLU7NofnInnhtY69HsiJfaVHtnlx806r5tkeRPX2gIioZNKSPWjpxwG
         OxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529715; x=1775134515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X67yw9hp70DJW5SbayvQBOmUIp03R92/bYFmSlkehKU=;
        b=nd+p/9Uoau46ZLxQMFhkXmwKjMayKT/XC78R2LUI7b0QDsqM5cJ5W59av/tW9TUk5e
         ve1ecw+OAssbWHurHsZnl1XLwrsvl0WD5OOiFjqesYidYwYwz5wfQKbsgQSlssalmTW5
         024QrsTu97oCvEpTNKeu0kWMLsQyL1ma2K4UI/ffRGQwAtBhr6cjNrnDFFTB7s7E9pWW
         X9cRXlfphLJR7wwR8y0MAbIKmynaHaFD/Eu//hkeWM2w1klyaLJ2tCLF3lDx0l6+lZh/
         wCUee1mOezZyDa16qv8uI7MCHIIJ8u4QIvkXcYh8rarghgI9nplRCpvk/BUYjoLnbIF3
         dnlg==
X-Forwarded-Encrypted: i=1; AJvYcCVwAvQA+ov3Tuqzkw1ydDivKR4BRJxAFERMztrg3Y+miKcY4sTfPeBIiv3ncL9R8S8wkQhoEDnUUey4B1cP6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCDC8EYxBLCm5PVW5yuITCY9bxcZIv5Jc5SH8aB+dVdgsD5vt
	1Qh+5UgXU7kn060Fon62axO9KqlSeWcm4zlxSmcAgqcis4M8BOOkW6RUR1eUJiMPzeg=
X-Gm-Gg: ATEYQzwgsuuuvBJNDzX4HUVja+vqcQmlUOzcc9ielqRm+bTfMwSMXRD3WFHcGX8qCiL
	d1OVfzsjChssReK8+hft35xTU9bSHwP2KuHXmNeLabhlpHURHZE1RTk6BxtgfOr9yQ5Xcrq82F9
	g4FkBt06kuKTRnNUESDHhfIWU8TSGUKmhPtaxe+BMj2NQBThHcd+aARO7co5C2Po9EhB3x6N6C3
	CTNbiY5ziyhDqGkW6ZcRWyMifBelKN++gZp2h2+U56m2Ufxiw1Z/CjakZ6xAYb9qaI2BzxG2EhA
	d52R0lP0qG8b5gAKaEL1HKmf18VKOA/syQkKiRN4UPxVgR4MuWl6HuMUVWjApAhygZRkEi60Ang
	6wSK6rXErgddrTDRtLHvDqJFOXC69zewPM+6UgHwU/ZPDPi5szzxvzBvYN4yy9o5uJpgviIrIHP
	F2NRdX3XX6AOQlKMFI9dfsIjMm8yUIxDB3hdWvLKnW+dc9JgpiiY07WNvOAxKkfI2b/CAinXNqb
	QdjztVm0cZSm4zcXw==
X-Received: by 2002:a05:600c:1f12:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-48716050758mr107584965e9.25.1774529715255;
        Thu, 26 Mar 2026 05:55:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487209378e2sm14061155e9.31.2026.03.26.05.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:55:14 -0700 (PDT)
Message-ID: <9bc23f1e-1cf3-43d1-935a-c4738d576c29@linaro.org>
Date: Thu, 26 Mar 2026 13:55:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 8/9] dt-bindings: net: wireless: brcm: Add compatible
 for bcm43752
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <20260326-add-emmc-t7-vim4-v5-8-d3f182b48e9d@aliel.fr>
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
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-8-d3f182b48e9d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33974-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[aliel.fr,baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliel.fr:email,linaro.org:dkim,linaro.org:replyto,linaro.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email];
	HAS_REPLYTO(0.00)[neil.armstrong@linaro.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 506E33358F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 10:59, Ronald Claveau wrote:
> Add bcm43752 compatible with its bcm4329 compatible fallback.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index 3be7576787644..81fd3e37452a6 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -42,6 +42,7 @@ properties:
>                 - brcm,bcm4356-fmac
>                 - brcm,bcm4359-fmac
>                 - brcm,bcm4366-fmac
> +              - brcm,bcm43752-fmac
>                 - cypress,cyw4373-fmac
>                 - cypress,cyw43012-fmac
>                 - infineon,cyw43439-fmac
> 

I'll apply all the other DT patches, please send this one alone with the [PATCH net-next] prefix so it gets picked by the wireless/net people.

Thanks,
Neil

