Return-Path: <linux-wireless+bounces-10610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B093F08E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7C61C2180F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CB13A89A;
	Mon, 29 Jul 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CanKCy4e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551112DD88
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243727; cv=none; b=qU+I1QhMPtLK0va/JzrTr9lAGKNWuScig+eQG1omajTwwi9bvOQPMiweM3ncAfAgFISQJZXd/Dl6pWhmlM74K1zvbdj3fOwgAjSnw5QfJZs9vJPKAWn96nU5ktvyTCxWDH2Eau/VWBkNuzMr+UPjKF0yUu3bQPnIixoPFkE66G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243727; c=relaxed/simple;
	bh=p+Q7HMNfNEC+Eu29iPw6j+62HUX/9UJFi/4nW9MpsLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvjdfrhy8tO195OGT08q8Uf9JyDZv7eVpKIkRhnyel52hn9t/1QKq0dcoEYK/sZcHI5D+Czf2f1JbsAvj6wy+JwnYLpzs5BnU0/oScTEECztal+ovRiF2e4U6rcj4TOna4kBvEYbAlyrdctq9mgRq1t2QXRc7UEiGRSpxD90LCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CanKCy4e; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b78c980981so17230366d6.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722243725; x=1722848525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yW1OO+skBc1eCv7kSQixud2h2uSiGX+bRNa0JQW8fcc=;
        b=CanKCy4ecAmWcD9E/VN3Kgy8thITCHF2C1To5Gop8yOQ/AQOrvHWsGJo2eGxUTW3qW
         PByGHSBJVAVXFUl7W54Qw8A94lbkNhEhGfumYld1I7Bp62GNe5E41qS5VItyK/mG3dIv
         6Ka14rRy5ayKiaFfzfMZNF64+GB/Jw6Jf8LO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243725; x=1722848525;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yW1OO+skBc1eCv7kSQixud2h2uSiGX+bRNa0JQW8fcc=;
        b=nUwfqFbVX5PoB1AGKmWdF+T1ZfsqNtwQfO+6Jf/B/Uh53aXooYc3C9XPUJVyPpR8bq
         Zcn5wcLZvCtNkchhYhMRbcVMCTRBdYc0RfCwrMwqqkOnCfwruGMD/Lar54DRrsU/P6tt
         16Y1kEPMQYY/t2EDiCKjzgWrPYIDDOYqMFuB1tlWmFx3+LRYwrrEvoBZafQbDNiANIMG
         ocOLvHVfEJ+F7adMlm+5+ujx8Az6xwlmGPJSiVJsPNE46NtHldJqV3jVE3OcSbtrLzmh
         12L899ym6PEDdOKXBLffadi2P9Chl7YUZm3E+1tbo/qR2Lgi8XK5zO/WqCONfLUU+LUP
         6bUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QO9DjFk8QgC+kInMus77TOohJCUkw9gViHgqxSgCE9PitlAEKjME0Hd6aZTE2y3JROLEmumxehFivWP93ym6etA6sBOJnlPeBs7sAe0=
X-Gm-Message-State: AOJu0YzKMyX8jNm3CnkOSqABcKKVbghTgDgrCrEF/VorAIMxWxi/EUlk
	C9u/ahPdCmvjcvXvcv/NERGs3GXBfka+x/DgSGdMy3XEjwKpYIpUFbL96A1gKg==
X-Google-Smtp-Source: AGHT+IGfVpIWeoLiZdliqYD6w6MUHUy5e1ltf8zZbU1y1lynDYoJKE4YmHmc0uMuWNlwhLCGFfNsjg==
X-Received: by 2002:ad4:5be5:0:b0:6b0:9479:cdd7 with SMTP id 6a1803df08f44-6bb55acbe54mr103099816d6.54.1722243724747;
        Mon, 29 Jul 2024 02:02:04 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d81e2sm49047726d6.25.2024.07.29.02.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 02:02:04 -0700 (PDT)
Message-ID: <225279b3-882b-4d97-b7f4-08129c1f05a7@broadcom.com>
Date: Mon, 29 Jul 2024 11:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P Wi-Fi device
To: Jacobe Zang <jacobe.zang@wesion.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "heiko@sntech.de"
 <heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "efectn@protonmail.com" <efectn@protonmail.com>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arend@broadcom.com" <arend@broadcom.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
 <megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "minipli@grsecurity.net" <minipli@grsecurity.net>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 Nick Xie <nick@khadas.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
 <20240729070102.3770318-3-jacobe.zang@wesion.com>
 <1724f480-369d-4b4a-9384-1c6b33b00433@kernel.org>
 <TYZPR03MB7001247E93FB6473128FEB2480B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <TYZPR03MB7001247E93FB6473128FEB2480B72@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/2024 10:17 AM, Jacobe Zang wrote:
>>> Add clocks and clock-names for brcm4329-fmac.
>>
>> Why? Which devices have it? If only your newest addon, then squash the
>> patches and add appropriate allOf:if:then disallowing the clocks for
>> others. Or maybe all of them have it? Why commit msg does not explain
>> anything about the hardware?
> 
> Alright... Becuase of the datasheet said hardware has one LPO clock input. So
> I will add allOf:if:then for this specific hardware

Maybe this can help clarifying the commit message. All Broadcom wireless 
chips have this clock input, but often the chip end up on a wifi module 
that may or may not provide the clock. From chip perspective the clock 
input is always present, but it is optional as the chip can also use an 
internal clock.

As such I would not choose to make this specific to this AP6275P 
hardware (just my 2 cents).

Regards,
Arend

