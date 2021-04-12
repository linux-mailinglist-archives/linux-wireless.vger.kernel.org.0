Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83C35B810
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 03:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhDLBZx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhDLBZx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 21:25:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E7DC06138C
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 18:25:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b17so8143521pgh.7
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 18:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UWOIGtqeOeXuUvHOjCb1jTlJLlUgyBDQUb3NqK9hjs=;
        b=SzSdZEYQrxdEvWA2xFeyuX4kQNz4i53+4NSl/wYOSiZbjIXKqWbUS8Xa1zenkUCxsf
         h5tNXMbgXWvIvWD5/jGXoRJCDJqqBoKlsNftMJdWNeL8inpJIKBBKuIeTJOXzdfOHsRW
         a8LxX1o3yiNFyV0r7++xO3pSrtcQd9GBOA7iThaiPngO5gDi94SGiVnj5Cfu72xEdonk
         t+BL5+EwUt3MFZtFbpNPD5Bw44ThjDg4gKNMBznERTvYX0tqyX76rBv7suQ9Ai3Gaw7D
         uqeFM/WjhHUZAZ0esBNsNwuJgoRjzZCUhEmjCFEi0XACSEaVrxq1dyC6m1Z0u2SgKVB4
         /3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UWOIGtqeOeXuUvHOjCb1jTlJLlUgyBDQUb3NqK9hjs=;
        b=frfvT7t++NImsEibueJuAu0YWGy/3X3CPUWScNr/bensw54vlYzkrxnepo11oNNPGV
         6q2xkMFQ935b6pbKZkS0llI9paAZ2bxD2wZGD6p67U1egr+cMFt4Ax6jLufs/YOXMi3y
         OUMZ/NCElrUfEkPIw1NLBu8bmqFr6Ok2RddN7uQOX6yyjPK1M0r/obaojHnOw8BiWHCK
         QOvCEaFKzQwsGxVt4ePjk5sBo6KhO2hRpSA39963UNAky8lQwpjitp09IsoRSlw9XcLZ
         /ScCZEWuBr/dCiGTjDlKAiHaY3ZLPDr4Sz4wMwYPqiMXN6SpaCWXI+6PRwfkVdsDXgKE
         Mr8g==
X-Gm-Message-State: AOAM532C+WltsR4qXZ+q0fveiqD2x1nPZaRgNxorf39hgIzBL060elfv
        lUlJGqY5T/5xV5aPbN1nkHcpS37O+1yyGJ50
X-Google-Smtp-Source: ABdhPJwVFHx91KywmuwrpjzYzCKCdiKF1p0NVsF6qcvxMQKRlCa6GXmZyyt9m1W2cMVjEagDhzweVA==
X-Received: by 2002:a05:6a00:1c67:b029:215:6f93:d220 with SMTP id s39-20020a056a001c67b02902156f93d220mr21655362pfw.36.1618190736003;
        Sun, 11 Apr 2021 18:25:36 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id g21sm9050908pjl.28.2021.04.11.18.25.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Apr 2021 18:25:35 -0700 (PDT)
Date:   Mon, 12 Apr 2021 09:25:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20210412012528.GB15093@dragon>
References: <20210408113022.18180-1-shawn.guo@linaro.org>
 <20210408113022.18180-2-shawn.guo@linaro.org>
 <87k0p9mewt.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0p9mewt.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Apr 11, 2021 at 10:57:54AM +0300, Kalle Valo wrote:
> Shawn Guo <shawn.guo@linaro.org> writes:
> 
> > Add optional brcm,ccode-map property to support translation from ISO3166
> > country code to brcmfmac firmware country code and revision.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
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
> >  
> >  Example:
> >  
> > @@ -34,5 +40,6 @@ mmc3: mmc@1c12000 {
> >  		interrupt-parent = <&pio>;
> >  		interrupts = <10 8>; /* PH10 / EINT10 */
> >  		interrupt-names = "host-wake";
> > +		brcm,ccode-map = "JP-JP-78", "US-Q2-86";
> 
> The commit log does not answer "Why?". Why this needs to be in device
> tree and, for example, not hard coded in the driver?

Thanks for the comment, Kalle.  Actually, this is something I need some
input from driver maintainers.  I can see this country code mapping
table is chipset specific, and can be hard coded in driver per chip id
and revision.  But on the other hand, it makes some sense to have this
table in device tree, as the country code that need to be supported
could be a device specific configuration.

Shawn
