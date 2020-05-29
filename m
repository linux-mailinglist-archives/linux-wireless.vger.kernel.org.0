Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5E1E8A02
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgE2V0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 17:26:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35846 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgE2V0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 17:26:40 -0400
Received: by mail-il1-f196.google.com with SMTP id 17so3942588ilj.3;
        Fri, 29 May 2020 14:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+2I2uh+lCRQ53KIyx03FmW/+jeIMFqOBrGTcbc9lM4s=;
        b=Pikg9MLLTqzQ2jwqEe6IFmOXh4LISsKfaPmROxgGYDuQJutrBVTO1HxCvEdzFITZwj
         Ltn14m37MHv6e5VpR6KBH58k4f2UqWaW57jpw7Tn6c2VxucQoRKkGYkMbRGSh+GvcOe6
         +iSHFUloRI9U8NOmyw81mQSJiVTBnvsJQfqoCpEyeMjC9yHhVlMWB5MLr9SxFULCB8JZ
         VgxSiRY/eY+eWUt0qgp/+z36Zdk+nt5yJAw65TEXozYwafSeT+qbFpRF0VJC0/Vz7kfL
         HUv8ebxvm0nglmxeLL94l8/722pdSt2oCymRNEIs07FarCPIePNFO8eR0zOAWau7e0fq
         x1cA==
X-Gm-Message-State: AOAM531Ud/gU7ndHtfVtDsFI0GoGiCvsdVgTPEVNjKrB7ATe0D2FNBBc
        dkcwRLpE2nsDnevokxYFoVxgKubrhg==
X-Google-Smtp-Source: ABdhPJzR/qUOw/XdsiMltbuXXMqaCmOfvW7wTfv0VjXShbJx2eIblPx7c2mxeaGCHZ4eWqhGUoRnAQ==
X-Received: by 2002:a92:8488:: with SMTP id y8mr2707079ilk.262.1590787599226;
        Fri, 29 May 2020 14:26:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t65sm1498148ilk.38.2020.05.29.14.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:26:38 -0700 (PDT)
Received: (nullmailer pid 2998245 invoked by uid 1000);
        Fri, 29 May 2020 21:26:37 -0000
Date:   Fri, 29 May 2020 15:26:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: mt76: add power-limits
 node
Message-ID: <20200529212637.GA2994957@bogus>
References: <20200529161929.24751-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529161929.24751-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 29, 2020 at 06:19:27PM +0200, Felix Fietkau wrote:
> This subnode can be used to set per-rate tx power limits either per
> country code / regdomain or globally.
> These limits are typically provided by the device manufacturers and are
> used to limit sideband emissions and stay within regulatory limits

How do other WiFi chips handle this? If this is added to DT, then it 
should be common for all WiFi h/w.
 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../bindings/net/wireless/mediatek,mt76.txt   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
> index ab7e7a00e534..9d9ace0cfbf9 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
> @@ -36,6 +36,7 @@ Optional nodes:
>  - led: Properties for a connected LED
>    Optional properties:
>      - led-sources: See Documentation/devicetree/bindings/leds/common.txt
> +- power-limits: contains per-regdomain/channel rate power limit subnodes
>  
>  &pcie {
>  	pcie0 {
> @@ -76,3 +77,49 @@ wmac: wmac@18000000 {
>  
>  	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
>  };
> +
> +
> +Subnodes of power-limits:
> +
> +Properties:
> +- country: One or more country codes, as used by the cfg80211 regdomain code
> +- regdomain: "FCC", "ETSI" or "JP"
> +
> +If neither country, nor regdomain is specified, the power limits node is used
> +as a fallback when no other subnode matches.
> +
> +Subnodes txpower-2g, txpower-5g:
> +
> +Properties:
> +- channels: pairs of first and last channel number
> +- cck: 4 half-dBm per-rate power limit values
> +- ofdm: 8 half-dBm per-rate power limit values
> +- mcs:
> +	sets of per-rate power limit values for 802.11n/802.11ac rates for
> +	multiple channel bandwidth settings.
> +	Each set starts with the number of channel bandwidth settings for
> +	which the rate set applies, followed by either 8 (MT7603/MT7628) or
> +	10 (all other chips) power limit values.
> +	The order of the channel bandwidth settings is: 20, 40, 80, 160 MHz.
> +
> +
> +power-limit example:
> +
> +power-limits {
> +	r0 {
> +		regdomain = "FCC";
> +		txpower-5g {
> +			r1 {
> +				channels = <36 48>;
> +				ofdm = <23 23 23 23 23 23 23 23>;
> +				mcs = <1 23 23 23 23 23 23 23 23 23 23>,
> +					  <3 22 22 22 22 22 22 22 22 22 22>;
> +			};
> +			r2 {
> +				channels = <100 181>;
> +				ofdm = <14 14 14 14 14 14 14 14>;
> +				mcs = <4 14 14 14 14 14 14 14 14 14 14>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.24.0
> 
