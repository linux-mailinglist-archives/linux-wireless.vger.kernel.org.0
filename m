Return-Path: <linux-wireless+bounces-17154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519AA04824
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EFC1888FBC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7AF1F4E44;
	Tue,  7 Jan 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ff6NadFu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FC1F3D4C
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270779; cv=none; b=EWaLFiTX2S+tjBT0xiELx0QJFoBG1TGvpSaFXCjtLQL23kO4scs2JnxtrVC8c2zzjOn86W2BXbAXYKO9qFVpQrzK+yJcewpa4j3/mKSNmc1pGwX7xszaCgN1nPeayZ3E9mDFRMNVWYP71JrbaMT6Emrbwsv0SdUeUrMXaUsw2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270779; c=relaxed/simple;
	bh=Zt4TBGCxBxlNsn64qjo4ZDFH4I7vbh601R/MnrLSgcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XZyVd6fvEbF/bGswYKBypn+mIzHySMI3prtB7jezTZg34KZ4c52/07QVuAQ6dHdjlWUq+peq9xeI91D8bLgm3oCHbF7yqKmfhep88yQYg65UB/4uErqSoN4u4SgOIX5zGTevyMjyXFUAHhLVCQLF22l58I9lihqJeudAk1WwVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ff6NadFu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21644aca3a0so56497115ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 09:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736270775; x=1736875575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a2x6Czl6GO65kHVW9zAO9v64ouXW8ETVJWZJ2hxoejQ=;
        b=Ff6NadFupAbTIMFEvKRWqzVU7pmntgqaWJCsm6oZ4W3UHeKGBzT5LEEOgivcBLtsHv
         2jk8klLCMePt63KF1IDSMfGMjtgC6rQa/+5MBepUypFlKoXloPQtvkltQ16ffEtSFAUe
         gGMkaVyA/qOCYTlxGQc6knhgaOXB+vxLZ0CFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270775; x=1736875575;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2x6Czl6GO65kHVW9zAO9v64ouXW8ETVJWZJ2hxoejQ=;
        b=AGf3oUxTbXmgM80+YWhXYJBQqAV3RbW6MfUURHwc2ye/RBf42vAmaVBy9qaau98E2t
         RvcAPQCvHYTWXNAaMdfx1As3yI6zfch7Bgyjznh5b23WYQGD6OGTZFmoii5n0KNTXZ/K
         o/NN6PTkka9QHoHksLAXgvqun3ERXrF/aqY7B2AAuJ9NNVIClr/pYilyIgusLXsvToAP
         LKcbTk8ZmTuBLS41Q5CgxuKNzeOEKoskXxtjXQOa+J1SOXWMlWNVFULQDx5wnxmiBA6Q
         R1jXq9wLkCxcwKVjHh/BEa/nJM4HkJWdqQfglMiLaprpB+J/wp1Ib+XWT03Y3SxDyzoN
         opGw==
X-Forwarded-Encrypted: i=1; AJvYcCUkk5T5igFb30Lw9kEQfzEWoIx3PTWGcTmnp6R8ivtRini3Hv6gmj2t101WZdWCtFBh5fJ0IUSMwPn2ea3lgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZr9YQOCsYLvaudfpHtDD9MUxnVD1Pv27rTuCNQ+2nbljqpsd2
	w7CdJxZAgmmbSgldhm5zhq2+x8Bwc9IXD3uaT2ZPgqYM7LCX9dvimTp/EaJ79w==
X-Gm-Gg: ASbGncuHzPoXFBNnBjHcx6jOn1ERlJbhziZKFvfW5SbHRFDNfaim01tRYORvrQgiHuO
	iV5WDITK2SswvPnp6qAtn6Z3oGrczWRvZSN+O/iJRzgD/HCMcUsMMQrA2XBEhVK9l/uLCV0hWIY
	ckfAmeJivH0Kxy2qgjzGWas2a8Vr9Y0kfQ0mTx5KF+rzpLAF95YXJzL38u6d+j7TZ4n5tIKBwHb
	V2VEucTGE8S4YubqWgawf8o6S9yfTGhFqZqKnDLzMNMn8ayTNsPTswPEZYQQAVVTH5jowza3RlD
	kMK+aoqDUlenIdyQtKvv
X-Google-Smtp-Source: AGHT+IFzu1VIJT9VJiC2aXWDy+NgNyxkD0g/GqwTMrp+Om0AwR+ht03XX6NjXXazKeHe7i80AzxoTg==
X-Received: by 2002:a17:902:e886:b0:216:5e6e:68cb with SMTP id d9443c01a7336-219e6e9fd95mr929686065ad.16.1736270774736;
        Tue, 07 Jan 2025 09:26:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9716b3sm314412505ad.90.2025.01.07.09.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:26:14 -0800 (PST)
Message-ID: <901992c2-4c48-4534-bbfb-7b6b70d15d48@broadcom.com>
Date: Tue, 7 Jan 2025 09:26:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Correct indentation and style
 in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Kalle Valo <kvalo@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Dario Binacchi <dariobin@libero.it>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Brian Norris <briannorris@chromium.org>, Frank Li <Frank.Li@nxp.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org
References: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 04:56, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/net/amlogic,meson-dwmac.yaml     | 14 +--
>   .../devicetree/bindings/net/asix,ax88178.yaml |  4 +-
>   .../bindings/net/brcm,bcmgenet.yaml           | 32 +++----
>   .../bindings/net/brcm,mdio-mux-iproc.yaml     | 46 ++++-----

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> # net/brcm,*
-- 
Florian

