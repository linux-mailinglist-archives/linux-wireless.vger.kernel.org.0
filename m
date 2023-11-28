Return-Path: <linux-wireless+bounces-171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE907FC05C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8984282B31
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F25CD3A;
	Tue, 28 Nov 2023 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25976D5B;
	Tue, 28 Nov 2023 09:37:38 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fa619735c1so1176032fac.0;
        Tue, 28 Nov 2023 09:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193057; x=1701797857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euvcKpX30ZVsmfkaXJTTyAJfHCgabkUtlIpVB4OOtdk=;
        b=xOe/8aW/yzPAouFlm/9KNzmqQCl7sYE76Cm6nOsqAty0nH+f4Et94IyIv2NSZizNXG
         8VQ3ueyHpVc99OI1n5jU9li3vmKpCI1qup5fCVb56W8N6RSmOIAEbwd2rmu7TxTJCPb6
         RfNhN4DODohegHTJJrPl2gvWOWLk2SHQkzsOfB9LnwDWw5NcmSv2CNTwJPgt4yJgd7f/
         2Nxc68g7qVmLitpy/CnoGCXHEXxIZ1eD+cM+okXYj86GOiwkdHxn94rZayHjwRrYQFwz
         F7g1hKAszsiRMQ66Xw0mLfnVmnYnsg2ruIYww5z7wqhxT6akWe+JecvtXOMJsYtmP3n5
         Dt+w==
X-Gm-Message-State: AOJu0YwtJd0DkDnVpm12DZ0u6B5D3zbXBQ01WKrPF/f3RbaZWkTMhiPq
	WVffMz/IOvbsoFC7keosVw==
X-Google-Smtp-Source: AGHT+IFqYYn9X2TZT97zZ6qFLfge2tyuoZxVF9rjnkiko+nm/6218G7n1xYaCVZdrESr/DQLfEbS8w==
X-Received: by 2002:a05:6870:d3cb:b0:1b0:2f63:4ff6 with SMTP id l11-20020a056870d3cb00b001b02f634ff6mr22471768oag.1.1701193057389;
        Tue, 28 Nov 2023 09:37:37 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id wx20-20020a0568707e1400b001fa38903b92sm1518933oab.15.2023.11.28.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:37:36 -0800 (PST)
Received: (nullmailer pid 3544147 invoked by uid 1000);
	Tue, 28 Nov 2023 17:37:35 -0000
Date: Tue, 28 Nov 2023 11:37:35 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Ryder Lee <ryder.Lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: wireless: mt76: add interrupts
 description for MT7986
Message-ID: <20231128173735.GA3537931-robh@kernel.org>
References: <20231128035723.5217-1-chui-hao.chiu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128035723.5217-1-chui-hao.chiu@mediatek.com>

On Tue, Nov 28, 2023 at 11:57:23AM +0800, Peter Chiu wrote:
> The mt7986 can support four interrupts to distribute the interrupts
> to different CPUs.
> 
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index 252207adbc54..20f5f2ead265 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -19,9 +19,6 @@ description: |
>    Alternatively, it can specify the wireless part of the MT7628/MT7688
>    or MT7622/MT7986 SoC.
>  
> -allOf:
> -  - $ref: ieee80211.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -38,7 +35,8 @@ properties:
>        MT7986 should contain 3 regions consys, dcm, and sku, in this order.
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
>  
>    power-domains:
>      maxItems: 1
> @@ -219,6 +217,24 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: ieee80211.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7986-wmac
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          items:
> +            - description: major interrupt for rings
> +            - description: addditional interrupt for ring 19
> +            - description: addditional interrupt for ring 4
> +            - description: addditional interrupt for ring 5

This list belongs in the top level. The if/then schema needs to set 
'maxItems: 1' for the cases with only 1 interrupt and 'minItems: 4' for 
the cases with 4 interrupts.

Rob

