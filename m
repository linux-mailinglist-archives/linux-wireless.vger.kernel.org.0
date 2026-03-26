Return-Path: <linux-wireless+bounces-33977-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPMEFakxxWkP8AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33977-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 14:16:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF273335CD9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 14:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED7BD301C6D1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB622236F7;
	Thu, 26 Mar 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx0jE3c5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E191245014
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530614; cv=none; b=uczpb4IeupL3Wf1LFVTtzVhzefYptAX26fyBGQxoIl6G1ARuuDTcimSGyAV2haPBp4bianU5FsHD7sOcRM1DbWrNQmHuQqo5pivfJIRAS+bavaYKNnojifWYk0VqMtZ+OQtvOqY8uoAyLuXIVn/3HNJS3nRVIEtVVDJ7ByVyRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530614; c=relaxed/simple;
	bh=/BTY/bju8juKMiPv6KMmBaFgb1YzXi1o6CFBMQIgtiU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u4egxLZAKHqw1LfDHuyA7V5McIfxhs9VhF28UVAO/G7bCSbGyMFWZ2O55G6W2UEycaFXZ5/r2KjeE1SEq6man/shRBXOjJTXj/ZZiKZ6l1Y3eTVpdHZow8byi/jrABoPWQCv+nJSagDBhnZ8x5maxbVli5G8Q8vAE36qVa+5+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx0jE3c5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fb439299so9044855e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774530611; x=1775135411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5T/06PnZQDDMs+KvURgz2r0ZPGg12B/UFXU9prTTL0=;
        b=Yx0jE3c56aZC9S4hUV0eVd3IY7nSwPUyEPirSk73YGAmVuZiqHuOebB1SCTA7BmZnm
         dJJow7FLK7/7tAXkEK2SmBYJ7lvdmCY7asObTTGoslNAnWVjm3TXUxWVqJUNJ+IizhOG
         vy7cnU/ec7v3wdsw88CexgSA43aVyzL2Iy/6v2PhoT0e9gY6EBuaeEqtfY897mHhAQlA
         uAtLPO4Bbfx9Bh2m373StUNHrwgECbLW/+fpM5+0IXyLiIEyRngXuzRwThiZZhEOYeeB
         3XDCE9hNzBCSQk1gLZLWCQySnRu+vpK5fbsSyvGnNLM2znhAqlxNJcLosgBJEjpDt9yI
         H+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530611; x=1775135411;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5T/06PnZQDDMs+KvURgz2r0ZPGg12B/UFXU9prTTL0=;
        b=U4UlFDopuepYypNnRU/Z08O0jaNIct3Qjc0ga393GHR+o53PwLN6fBliJY0xqntDg4
         1P2KuFd0lbxV4sMyLDXl7+uN6voF3BrNXMau/He7+4ATPuplcxZAxcBixmDJt2ZtWwx+
         mqfodT4VubY/6iL/v1PEsxKlsBS5hGTuMOLLsccgBxgxc5RHmHTd9tsPtETZLTwVhUMn
         18dgHCBnTBwa11wH1k4piiOIGRTNeZ7vyljob8jtZWu91vUbHe/HiD2JdRDR6QhCNMmV
         FJBgr5BbdxQPRFSm3bzflXH/Gh5DkB6wc2rFLlPmg2J2tPnxzU12VwnzVHn4ONstVACH
         I2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkNmvUrfXxpVMedznqoQZYQ5dQS/q6H/WYKO0LRv9YpnahdoOjHsR9bkJxABCvIZIce++Un3M26ymsaupAmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6xsaLeUNBXzGAkeJArHM8htjf+GszFWGeYtP/RKIcixkGd3c
	ph2fOV1fHHBoIaBWaI+x4bAUo122BtxBlpf/V+pvnmOtHV3sRfaTWTkzKKDSmS9yccU=
X-Gm-Gg: ATEYQzxpp+zHatwFf4GPSTcFNmrgna5DzmMYqB8leN/A8EfVfUHZNA+EW3Zz4Wrc0my
	Hs6uAGY771HWaISOqerH8iH20gU6xomggenZPJELdMtnkvsg3A6eNC5GjS1JC75aDP3vfCwBKzQ
	olPXa9ZyG+tvQH94oUsgtGMxeNMQxO1DsaYCSnYSeJuZAFvBPMX4HJXjwwyQkepluPnw3+gxhSc
	39lP1W1kmbFboPHvq2py3XliwJo49Qgql9pUA3n9UIOsSmst7P907ZYk1TF93cMoFJjCjkplmbb
	4q98DGsIHmoj5EAdLzlCzsNHNjaNywDQW93BBwyjOw5z5L1lZJ/p9eDRPfGflKCDeH/wM1xlO5q
	TfWfLwEtxyjtZZQUxqAYo/lEKoqU7W1a9RTjNvpYwEZVZKbmtkvNFQW1XHV9vOkEFmilKa2XGnL
	pT4U6v66lQaQmqDS4Ybjj5aR+bHQc6XSt/Y2FsvGMWD/NGt7nhlpQY7DtLSqiTi3PKgoLxwns4O
	IwXavg=
X-Received: by 2002:a05:600c:620b:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-48715fdebd2mr120329765e9.11.1774530610950;
        Thu, 26 Mar 2026 06:10:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c78bc2sm29702165e9.5.2026.03.26.06.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 06:10:10 -0700 (PDT)
Message-ID: <c54566e1-f0e2-4584-bc4d-484ebfd40324@linaro.org>
Date: Thu, 26 Mar 2026 14:10:09 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v5 0/9] arm64: dts: amlogic: Add MMC/SD/SDIO
 support for Khadas VIM4 (Amlogic T7)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>,
 Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Nick Xie <nick@khadas.com>
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <177453048347.439230.1647215482099213609.b4-ty@linaro.org>
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
In-Reply-To: <177453048347.439230.1647215482099213609.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33977-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[baylibre.com,googlemail.com,kernel.org,linaro.org,sipsolutions.net,broadcom.com,aliel.fr];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neil.armstrong@linaro.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: DF273335CD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 14:08, Neil Armstrong wrote:
> Hi,
> 
> On Thu, 26 Mar 2026 10:59:11 +0100, Ronald Claveau wrote:
>> This patch series depends on Jian's SCMI clock patches yet to merge
>> https://lore.kernel.org/all/20260313070022.700437-1-jian.hu@amlogic.com/
>>
>> This series adds device tree support for the MMC, SD card and SDIO
>> interfaces on the Amlogic T7 SoC and the Khadas VIM4 board.
>>
>> The first patches add the necessary building blocks in the T7 SoC
>> DTSI: pinctrl nodes for pin muxing, PWM controller nodes, and MMC
>> controller nodes. The amlogic,t7-mmc and amlogic,t7-pwm compatible
>> strings are introduced with fallbacks to existing drivers, avoiding
>> the need for new driver code.
>>
>> [...]
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v7.1/arm64-dt)
> 
> [1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and SDIO pinctrl nodes
>        https://git.kernel.org/amlogic/c/fb69fa2cabc68da247bcc0bc99a14dc857b16842
> [4/9] arm64: dts: amlogic: t7: Add PWM pinctrl nodes
>        https://git.kernel.org/amlogic/c/b1e49f6c1ac15b2c947bdb1d22a82b823de22d27
> [6/9] arm64: dts: amlogic: t7: khadas-vim4: Add power regulators
>        https://git.kernel.org/amlogic/c/60eff75ac67bbf5445bdbd2842b0109ac591441c


I'll pick patch 3,5,7 & 9 once patches 1 & 2 from [1] are merged.

[1] https://lore.kernel.org/all/20260326092645.1053261-1-jian.hu@amlogic.com/

Thanks,
Neil

> 
> These changes has been applied on the intermediate git tree [1].
> 
> The v7.1/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
> 
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
> 
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
> 
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 


