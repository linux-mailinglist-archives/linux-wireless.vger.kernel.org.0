Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEB35B807
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 03:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhDLBT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 21:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhDLBT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 21:19:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05CC061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 18:19:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p12so8121294pgj.10
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 18:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOVEUZxKUzw5yKV3UzpP1C8KkT2dA4aQzXOrSWS1c5s=;
        b=H2wD8qXLEIbcWHbeeSK56pfYG+r0PaLtaDxA+T5ueDArj3OfFJbkk9HBIf7sx9KPhO
         qrV3RLfszPLe9E5Ycxp1uzvaoGTFrMU0oiRrq5pp+xAtgSO9kC0BFAHLrAk152jY/rIc
         5/fUGWZDALdmFv/Bc2LwFy4WVGxUBG2qId4We4719D7RF3BOYJeTZBkacpkQHtEydXV/
         KvVEyZH0dr8EYn4HNPHUjvQBnxiMdITkcfj72xGVqeepYTKYKLS1gSZAqfWaLa+ZUld9
         RLaxLnMzz2ldt+0sKhqyNHScZ0LNN/WAHfBugBB5v6mWMEYsggwUPojtpBcZ47CZBZDK
         rcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOVEUZxKUzw5yKV3UzpP1C8KkT2dA4aQzXOrSWS1c5s=;
        b=CB8D1hDVUWjXxyCEO1JwHlHMw6/tbqJnxJtKU5nkEX67W3R5mDgah+/xyMnJfE/C1f
         +d07FTtyw+YWc+sxddL1MmsJdCBtQXGU9V7ptWB/rcChAazY6MrpbgqMhrMh47TGwmD+
         75OZnKNQnCIJMWKXjQ4fAy71cGuZBgBZwQtZpvPEgAaio9CR0eydz8GJtQz2Iuigo8LZ
         fezN1bpswA+nLbJl+xNW6/ZR0mxIh6AdOEGcVNRTIM59SzBs3Ae97oriBpx/9cKSOPyP
         CK7+uQHbAG5jZQ4htzvRIx7t+RhQd0QTlcHpzzoQzZHLlGJ7ppzwT5KLydt4pIHZZjwX
         hrqw==
X-Gm-Message-State: AOAM533ck3AczGTI9XG0iVuDB38WXWs2Xssf0DKmKf8KMEtAUzlVgB5q
        NvQevw4xvko9/Gk8cEqNXEAMSQ==
X-Google-Smtp-Source: ABdhPJyYY8bXAkVUCN6156iGSWFTJ3daOgQEdJrFUj6OF2GV0aKJW9nsdxYVbYgshCW5j+gxQKJsMg==
X-Received: by 2002:a63:77cf:: with SMTP id s198mr24458053pgc.252.1618190351123;
        Sun, 11 Apr 2021 18:19:11 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q22sm7755303pfk.2.2021.04.11.18.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Apr 2021 18:19:10 -0700 (PDT)
Date:   Mon, 12 Apr 2021 09:19:03 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH 1/2] dt-binding: bcm43xx-fmac: add optional brcm,ccode-map
Message-ID: <20210412011902.GA15093@dragon>
References: <20210408113022.18180-1-shawn.guo@linaro.org>
 <20210408113022.18180-2-shawn.guo@linaro.org>
 <20210409184606.GA3937918@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409184606.GA3937918@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 09, 2021 at 01:46:06PM -0500, Rob Herring wrote:
> On Thu, Apr 08, 2021 at 07:30:21PM +0800, Shawn Guo wrote:
> > Add optional brcm,ccode-map property to support translation from ISO3166
> > country code to brcmfmac firmware country code and revision.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> Can you convert this to schema first.

Yes.  Will do, after driver maintainers agree with the direction.
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> > index cffb2d6876e3..a65ac4384c04 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> > +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
> > @@ -15,6 +15,12 @@ Optional properties:
> >  	When not specified the device will use in-band SDIO interrupts.
> >   - interrupt-names : name of the out-of-band interrupt, which must be set
> >  	to "host-wake".
> > + - brcm,ccode-map : multiple strings for translating ISO3166 country code to
> > +	brcmfmac firmware country code and revision.  Each string must be in
> > +	format "AA-BB-num" where:
> > +	  AA is the ISO3166 country code which must be 2 characters.
> > +	  BB is the firmware country code which must be 2 characters.
> > +	  num is the revision number which must fit into signed integer.
> 
> Signed? So "AA-BB--num"?

Hmm, for some reason, kernel driver uses signed integer to hold the
revision.  It's just a reflecting of that.

> 
> You should be able to do something like:
> 
> items:
>   pattern: '^[A-Z][A-Z]-[A-Z][A-Z]-[0-9]+$'

Ah, yes, that's much better and distinct.  Thanks for the suggestion.

Shawn

> 
> >  
> >  Example:
> >  
> > @@ -34,5 +40,6 @@ mmc3: mmc@1c12000 {
> >  		interrupt-parent = <&pio>;
> >  		interrupts = <10 8>; /* PH10 / EINT10 */
> >  		interrupt-names = "host-wake";
> > +		brcm,ccode-map = "JP-JP-78", "US-Q2-86";
> >  	};
> >  };
> > -- 
> > 2.17.1
> > 
