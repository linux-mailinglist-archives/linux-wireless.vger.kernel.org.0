Return-Path: <linux-wireless+bounces-752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE059811DC0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04287282C1C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFE65A82;
	Wed, 13 Dec 2023 18:59:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85598D5;
	Wed, 13 Dec 2023 10:59:32 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d9e756cf32so4798964a34.2;
        Wed, 13 Dec 2023 10:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493972; x=1703098772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeK0cW3CYjJ4+DfiuKUFos/Az6mhlvyWdViJpwMXZc8=;
        b=T3IaK71925yG97S8veP7f09+NxVq3MtNvm8lA3x52KRmE+PxrlWwmzasBUPM1JU3U0
         Bs2F5Yd/LlWf+xsDIzVrYQrjD7nusWLEIzPKIcZiVZjnGcqEBx//cHQwZQsCKb/8SEim
         rSPvm2qGnd1Y+UZ6scAozAHefS5VJ8Uk+k/8yOCzoFJpGpm40OEW0XfsAYq0xPx6R/7P
         TS5JAyeF54KP8v/WmgXfVl0dbq2d7zqPXnWbcTpK+MIanDjpwwzKz8F0FlerXicw7tRN
         lwxGXWm/6v+HLdg15tBweIeFUZCjXP86zEkH3a8JGpJYWd2F19UdMIDUc6ETIq4pv4NM
         u/UA==
X-Gm-Message-State: AOJu0YxWA9xmIImfuiewPMFrIjZBEHk6fh1GC+CdAkcYIq83h/ZdaKvv
	thWNcNTBzUhZbR5/mziqfw==
X-Google-Smtp-Source: AGHT+IG0Cq8wvVnID/6qOI5cs3vksMULR/gsiDuT8TlocRTc5hlZ5/6MWbi6jQSItp2CJI63aNiItQ==
X-Received: by 2002:a05:6830:1e4a:b0:6d8:74e2:a3e2 with SMTP id e10-20020a0568301e4a00b006d874e2a3e2mr7477380otj.62.1702493971838;
        Wed, 13 Dec 2023 10:59:31 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g19-20020a9d6a13000000b006d99e0667e4sm2901837otn.28.2023.12.13.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:59:31 -0800 (PST)
Received: (nullmailer pid 1720212 invoked by uid 1000);
	Wed, 13 Dec 2023 18:59:30 -0000
Date: Wed, 13 Dec 2023 12:59:30 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: wireless: brcm,bcm4329-fmac:
 allow local-mac-address
Message-ID: <20231213185930.GA1713843-robh@kernel.org>
References: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>

On Sat, Dec 09, 2023 at 05:05:05PM +0100, Krzysztof Kozlowski wrote:
> Some boards come with local-mac-address property.  Allow it, and
> mac-address as well, to fix dtbs_check warnings like:
> 
>   apple/t8103-j456.dtb: network@0,0: Unevaluated properties are not allowed ('local-mac-address' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index 4aa521f1be8c..4c8a7950c83e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -67,6 +67,9 @@ properties:
>      description: Name for the OOB IRQ, this must be set to "host-wake".
>      const: host-wake
>  
> +  local-mac-address: true
> +  mac-address: true

This doesn't work because the schema for these properties are never 
applied. There was some work to split them out from 
ethernet-controller.yaml to a network device schema[1]. Perhaps you can 
revive that.

Rob

[1] https://lore.kernel.org/all/20230203-dt-bindings-network-class-v2-0-499686795073@jannau.net/#t

