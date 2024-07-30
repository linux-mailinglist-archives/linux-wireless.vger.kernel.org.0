Return-Path: <linux-wireless+bounces-10667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3A9940874
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 08:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A9D283405
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1916C440;
	Tue, 30 Jul 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UNxOmMl+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCF7FBAC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321436; cv=none; b=kgYKMkr1gpgvL/MvkffXmj2WFsOIi5kMFcehq4HV/u/354iaBsGB6QhM3wt2lKj21nlf6OC0xqDIhqwDGDSHtQbaTf9NNWHHKc4apN8KeIqjMeQuHuLnnCQ0cLZsE7DqSdKJZpex6x0SsGIdcNawOzj7morCgyCXWP9hH4nYslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321436; c=relaxed/simple;
	bh=N47Qs6ylcphzAUtYxaZMJgXp9Hzc7IfQwO9V19FO3ms=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rzpWM84MpxojoWEw3L7N2fnWoi/ydzUA/0H851ElqLY/dSREKczcPJRmIRXKu45dati+FRapM5OEisDsHQIrstuAkLh2DZmpQtLP/3nUcUGB5j2aQMFyGOEIxg6ophdhWX1cwlhA9kGWqzoxCIBjtgdO/coSRn0sK+j10Cd7RIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UNxOmMl+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc5549788eso30510005ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722321434; x=1722926234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8n8rYBKoxfcGnZbJLvEREPokWsFDiloFhCfdKHeZA0=;
        b=UNxOmMl+jxkf6YnKJctgui1i7rf8X2l5K0keWflVRIkS1DItWOrNWcPJrspO2gAkjI
         WBH/fXwA7G8oPkTTE4/ZVuy3j+/9tGyASds7ghFKPU2RNcjTZDAUvTvnFfb5ccK+cxHW
         0Ahfm7d5beHfMwrRS7PxuAw9NXYnhmcwF/O3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722321434; x=1722926234;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8n8rYBKoxfcGnZbJLvEREPokWsFDiloFhCfdKHeZA0=;
        b=WkWsqnU6fv5SSA5A2VzZspUaE+ZnutS3qKk3uSM5j5Nks/MgrQNORvc1NzWOx76sRD
         X2f6HhEVHpwGOqjp7CceqDFnxr+nmtvpJvymMDL8wDWRsI2ZIE2asfaBCTG2wBq3ys0n
         lbG5SO9UkY7klXeBiiXnWpQ/VU8ribCkjmRnGLoeSeZDBCAFTk3GFkdAZ6hqzQfabIJ/
         A7V74BssMesgX/EJ9huSqH3FacHpHMSULBED/SoLQoVvX00VspeTtQSxiN3HT0641MXT
         LJLw3M30zecDJ9IACm86d14cP3R47207t/I2LitEGNs+NfHd7S9GkPm/TxSUUhkeU69L
         LM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVol3fyRkDoaPFA1D455863pVUBHv9A5SZjdkuhyiduTnF0HlxOfKd8++ZyQGwqvTo9BjoBTd5OV7zoIlwNUcL79MXphlm2Ya4sAwIfZVA=
X-Gm-Message-State: AOJu0YzfeBRhkHXb3TVI1t+Qp9unR9N02cT3S+XeJNnPxUaUmr40BJkB
	X0PNq44I8S94wiDnEgHICLBX1pLCKn0rlDewG0bkIxeFuEh4LSsJW2z40HGavA==
X-Google-Smtp-Source: AGHT+IEbAYsTcrcjdD3UrZN6PQy+Do67Ei8GuSEd9YQg6UqH56tJFOZ2LAJA39UhwaNb5oNVG9ACLg==
X-Received: by 2002:a17:90a:6b4c:b0:2c9:7ebd:b957 with SMTP id 98e67ed59e1d1-2cf7e1df0abmr10618508a91.11.1722321434495;
        Mon, 29 Jul 2024 23:37:14 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb7608b88sm11733257a91.56.2024.07.29.23.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2024 23:37:14 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Tue, 30 Jul 2024 08:37:05 +0200
Message-ID: <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240730033053.4092132-3-jacobe.zang@wesion.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

+ Linus W

On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
> external low power clock input. In DTS the clock as an optional choice in
> the absence of an internal clock.
>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
> diff --git 
> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml 
> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index 2c2093c77ec9a..a3607d55ef367 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -122,6 +122,14 @@ properties:
> NVRAM. This would normally be filled in by the bootloader from platform
> configuration data.
>
> +  clocks:
> +    items:
> +      - description: External Low Power Clock input (32.768KHz)
> +
> +  clock-names:
> +    items:
> +      - const: lpo
> +

We still have an issue that this clock input is also present in the 
bindings specification broadcom-bluetooth.yaml (not in bluetooth 
subfolder). This clock is actually a chip resource. What happens if both 
are defined and both wifi and bt drivers try to enable this clock? Can this 
be expressed in yaml or can we only put a textual warning in the property 
descriptions?

Regards,
Arend



