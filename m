Return-Path: <linux-wireless+bounces-11662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C69585C9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EE21C22DBF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8218E052;
	Tue, 20 Aug 2024 11:28:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D318CC00;
	Tue, 20 Aug 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153280; cv=none; b=Lxc/Y/gSrQw75xoT9u3MdQsERFJO/gW3sK7GX3AVcRpE+KQCEOZDcJ34UFG8LUuaFZSgJZSs6Zs3ijtTcxu//SB4+d5tD77O5/dMp1mKNGLMON0IO65qLlYolHRWA+2shB2Bxs6KesY578Zdi6YbL9+pQIEKMJ29I4l9L7yYmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153280; c=relaxed/simple;
	bh=kxkNIlKTbbf5LYAvFtvHUZQ4o+3AlflRZEjAQQUgBmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTeuOkMIdewbtoei+9BkIBz86qJtmNivWhcqeAHAzKuUd7+fdn9AqXag4g4aMmEcEdLpkZqDMhiNVwT3Z4lvQylDa8tCl/3fLCwU2FRypjbAvU/PUaQxqyM0aqbcU6JPoiEr+maSUUnpZS2WQJwyCn4ucSO8vZbtpYgNLP/WreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37196681d3bso2673463f8f.3;
        Tue, 20 Aug 2024 04:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153275; x=1724758075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwO5zmlyTts2R3hD8kDJpY5JPORTb+evazmHWAEiBRA=;
        b=sX0Lf/3hNA1sPQ1b8noHmIe6QQd5pDMpHQo/ctDwP5VRXTmqsp/QVvjs4miTnS1s0c
         FNzy/dHSe1dFFXIp/SnBw8RSkD5fSnsH2UFSqZBSQd7nGrjRS7VDN36tUhhjVYAnZGF+
         3V8UcCNJD3BurQ8vimhenQLCMcpDxE/sUTBwdbSnEpYC+yFRki1JDBZ1iydSfbTPoYfw
         Rfr9vKVIGc++l99YjVdFhCqDSe0VMhO8lnTQZwwy75XxFjy+AMINkNgFqbGC3mAIoy40
         /KIQO1+Pr4CowsYYc/eg8KAWCiO5kWslORU2dbr4lp97G6sXw5MuWW13bu2UynkYIPFG
         C6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUfnmQ2J5Qfu0/19GSNhu1eqeNNM6q09jj19glyrd4imMfjo961xGfHqODJ049NZlyJp0T3lpWQlyt0vZ0xIJcNxlTZHZvW2DJh/nGhjznAW6443ZrRKoxr1oT64wdTH1au/XYuTYKPCBcS
X-Gm-Message-State: AOJu0Yz2SgqNuoDcWdKPNz/H6gFcEbaGNckTjg1TRlSKk4ISD7JK4zKj
	7xpc04U5Zu0iPLRQpZ6ZalH0BD9dqKgh4/kfim3/D5Xbk+hgVT5B
X-Google-Smtp-Source: AGHT+IG2rDlkuGVefnnHq/7qnkUTqjqn6xXXHLqUGu2Nni013rybNQdMNlIZiITetwIcDm/A6J7i9Q==
X-Received: by 2002:adf:a39a:0:b0:371:79f2:3d5c with SMTP id ffacd0b85a97d-3719465360cmr9314993f8f.31.1724153274516;
        Tue, 20 Aug 2024 04:27:54 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded7cfc6sm195655675e9.42.2024.08.20.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:27:53 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:27:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property
Message-ID: <mbvhz3wosnykejgs65es2sfedxoevysbqu3jxmpgdze2b2tl6o@grx4mxas2bmf>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820101216.355012-2-arend.vanspriel@broadcom.com>

On Tue, Aug 20, 2024 at 12:12:15PM +0200, Arend van Spriel wrote:
> When extending the bindings for Apple PCIe devices the compatible property
> specification was changed. However, it was changed such that for these
> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
> string in the compatible list property as it was before that extension.

Apart that this was never tested... That statement is not true. Look at
"fixed" commit - it is not doing like that at all.

I don't understand the reasoning.

> This patch restores that constraint.
> 
> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> index e564f20d8f41..47f90446322f 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Broadcom BCM4329 family fullmac wireless SDIO/PCIE devices
>  
>  maintainers:
> -  - Arend van Spriel <arend@broadcom.com>
> +  - Arend van Spriel <arend.vanspriel@broadcom.com>
>  
>  description:
>    The Broadcom Single chip MAC part for the BCM4329 family and
> @@ -27,7 +27,6 @@ properties:
>                - brcm,bcm4341b0-fmac
>                - brcm,bcm4341b4-fmac
>                - brcm,bcm4341b5-fmac
> -              - brcm,bcm4329-fmac
>                - brcm,bcm4330-fmac
>                - brcm,bcm4334-fmac
>                - brcm,bcm43340-fmac
> @@ -46,13 +45,15 @@ properties:
>                - cypress,cyw43012-fmac
>                - infineon,cyw43439-fmac
>            - const: brcm,bcm4329-fmac
> -      - enum:
> -          - brcm,bcm4329-fmac
> -          - pci14e4,43dc  # BCM4355
> -          - pci14e4,4464  # BCM4364
> -          - pci14e4,4488  # BCM4377
> -          - pci14e4,4425  # BCM4378
> -          - pci14e4,4433  # BCM4387
> +    - items:
> +          - enum:
> +              - pci14e4,43dc  # BCM4355
> +              - pci14e4,4464  # BCM4364
> +              - pci14e4,4488  # BCM4377
> +              - pci14e4,4425  # BCM4378
> +              - pci14e4,4433  # BCM4387
> +          - const: brcm,bcm4329-fmac
> +    - const: brcm,bcm4329-fmac

And this does not make sense... You claim that some constrained was
droppped and you re-add it, but in fact you still add the same code as
it was before.

NAK.

Best regards,
Krzysztof


