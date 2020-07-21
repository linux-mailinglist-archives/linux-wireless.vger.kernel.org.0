Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E575022765F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 05:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGUDEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 23:04:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35621 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUDEU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 23:04:20 -0400
Received: by mail-io1-f65.google.com with SMTP id v8so19864204iox.2;
        Mon, 20 Jul 2020 20:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2GnZO+Ycdsio9KAP5RhSVTIeQOjBv69bMXcFq/3rg2w=;
        b=FosDq5u1IikOglcsp43QX+KAmiotbfM0Kk26C0G7vsxwVBL41QZMUMLGQbCmEawlRF
         /DSd6Fc4yCWHtxaH5g2dpBooGwl3rzzjB0D/0aggjpjQsFjFT3jRDRkFwnXHlq+odF98
         sZ3rS0d2XP3dNBGxfTQhgkJEl1WCYfGDQEO9fTYN2HShBVzVNnJtgoTr4x63NtqsqwNr
         nfpYyrC1ClBOHLE6P0SYQp4XlXPmVDu86n72dW15s0Rug6UXPtNvlST4x3hCMMqjWdoG
         Ih0VB31JB+prmkXnHqOMK1MXZtoavsjbJmBBgZlkJg+U095S/krIW134hzWrHGyP531v
         +mhg==
X-Gm-Message-State: AOAM532N9OEGe5slyLWh0nsJP5Jk/gBsRXNIuptuD0jnfxL9hKKruF0V
        egpNNmrFb8/F4DPhlus/TSWo4l6C+g==
X-Google-Smtp-Source: ABdhPJxYHQOHmwni8IbzLsQFjDjhMW1QMJ0xz7+vMqBmHkJWmfFNmRSzPPYwV8tIvvK+ZPiqNIZRaA==
X-Received: by 2002:a05:6638:601:: with SMTP id g1mr29790037jar.137.1595300659197;
        Mon, 20 Jul 2020 20:04:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b24sm9821963ioh.6.2020.07.20.20.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 20:04:18 -0700 (PDT)
Received: (nullmailer pid 3463148 invoked by uid 1000);
        Tue, 21 Jul 2020 03:04:16 -0000
Date:   Mon, 20 Jul 2020 21:04:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        evelyn.tsai@mediatek.com, Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: net: wireless: mt76: add
 power-limits node
Message-ID: <20200721030416.GA3448943@bogus>
References: <20200715130134.34988-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715130134.34988-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 15, 2020 at 03:01:34PM +0200, Felix Fietkau wrote:
> This subnode can be used to set per-rate tx power limits either per
> country code / regdomain or globally.
> These limits are typically provided by the device manufacturers and are
> used to limit sideband emissions and stay within regulatory limits
> 
> Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> v3:
>  - fix S-o-b order
> v2:
>  - merge 802.11ax rate changes from Shayne's patch
>  - document txs-delta property

This is an extensive enough change that I think it needs to be in schema 
format.

>  .../bindings/net/wireless/mediatek,mt76.txt   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
> index ab7e7a00e534..e4859c974ef4 100644
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
> @@ -76,3 +77,61 @@ wmac: wmac@18000000 {
>  
>  	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
>  };
> +
> +
> +Subnodes of power-limits:
> +
> +Properties:
> +- country: One or more country codes, as used by the cfg80211 regdomain code

What are the values? cfg80211 is a Linux thing and doesn't belong in 
bindings.

> +- regdomain: "FCC", "ETSI" or "JP"

These aren't implied by the country code?

> +
> +If neither country, nor regdomain is specified, the power limits node is used
> +as a fallback when no other subnode matches.
> +
> +Subnodes txpower-2g, txpower-5g:
> +
> +Properties:
> +- channels: pairs of first and last channel number

What's the range in terms of channel numbers and pairs?

> +- cck: 4 half-dBm per-rate power limit values
> +- ofdm: 8 half-dBm per-rate power limit values
> +- mcs:
> +	sets of per-rate power limit values for 802.11n/802.11ac rates for
> +	multiple channel bandwidth settings.
> +	Each set starts with the number of channel bandwidth settings for
> +	which the rate set applies, followed by either 8 (MT7603/MT7628) or
> +	10 (all other chips) power limit values.
> +	The order of the channel bandwidth settings is: 20, 40, 80, 160 MHz.

The example only has 2 sets, so which channels are they?

> +- ru:
> +	sets of per-rate power limit values for 802.11ax rates for multiple
> +	channel bandwidth or resource unit settings.
> +	Each set starts with the number of channel bandwidth or resource unit
> +	settings for which the rate set applies, followed by 12 power limit
> +	values. The order of the channel resource unit settings is:
> +	RU26, RU52, RU106, RU242/SU20, RU484/SU40, RU996/SU80, RU2x996/SU160.

Could be 8-bit? Doesn't really matter much for the example, but what's 
the worst/typical case?

> +- txs-delta: half-dBm power delta for different numbers of antennas (1, 2, ...)
> +
> +
> +power-limit example:
> +
> +power-limits {
> +	r0 {

What's 'r0'? Not documented.

> +		regdomain = "FCC";
> +		txpower-5g {
> +			r1 {

What's 'r1' and 'r2'? Not documented.

> +				channels = <36 48>;
> +				ofdm = <23 23 23 23 23 23 23 23>;
> +				mcs = <1 23 23 23 23 23 23 23 23 23 23>,
> +					  <3 22 22 22 22 22 22 22 22 22 22>;
> +				ru = <3 22 22 22 22 22 22 22 22 22 22 22 22>,
> +				     <4 20 20 20 20 20 20 20 20 20 20 20 20>;
> +			};
> +			r2 {
> +				channels = <100 181>;
> +				ofdm = <14 14 14 14 14 14 14 14>;
> +				mcs = <4 14 14 14 14 14 14 14 14 14 14>;
> +				txs-delta = <12 9 6>;
> +				ru = <7 14 14 14 14 14 14 14 14 14 14 14 14>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.24.0
> 
