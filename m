Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED7836D790
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbhD1MnW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 08:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbhD1MnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 08:43:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C987C061574
        for <linux-wireless@vger.kernel.org>; Wed, 28 Apr 2021 05:42:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m11so475593pfc.11
        for <linux-wireless@vger.kernel.org>; Wed, 28 Apr 2021 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c5f2eBMZ43KNvRMjomBjmQQVOp4RSW5JRaMXDr26isk=;
        b=x8JPnDkO38kA7McnpFmuFU591+ZxFdcvf7b8LFPsUQdLHNSKbA5sbypctPlJXZODbP
         suK0P3YG0B2E3l+qvWSwsjEsq4sexpetsmLOmeX21OONq3tTjp/CMaHkMV4cxpO3Ksvi
         h5ysx1mtmKt9Soca4iShU74TbRHBD93fX2ouHYDx7TRscaj5bj+dHmRZaX2c6UPlqtul
         FCrU2FogaIBPU4r7/bN0rdn/wNDN2kneyIIGIx5YpJLVEt5IVsqGN0xq585JpQfKbcxS
         C+1VLYgj8IIUV0shSQsWePK1nqDjDxn/77YrfI8P3gnYLdckCsXAxgtA5t52Jh4jQeRu
         zjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c5f2eBMZ43KNvRMjomBjmQQVOp4RSW5JRaMXDr26isk=;
        b=ZBDiEsz6YDjYnn10150EmBV5K/6qjF5HEbLFxUuoeX85JlEDBLbJb08S+GWCJ+2eBM
         hRvIO2rPkSmuXKiO5esVm5gSq87JC7UpSaEMmt9R4bSURjCLfVWMuA8BTxUALAwM9df5
         7n/UitSDNv4kXp9HwUAjUBmANScytnvI0RmEoSgFILikYYQl4wK2dCwv3lty43EaDOlL
         /KoDxG/pwsSEIrQd/ejL3HLSG31H7S+c9EVY0bB1M9ixDgJjicjcGyipk1ho7EAn45kZ
         9ZINzxyRsHIY5qjRL7oLnvHVrzFNHXHVwtmzP2o+KcCKoecyUHMEb1Wgt/d793wDo+2L
         V8+w==
X-Gm-Message-State: AOAM533cP2zQE6XaEFDS/Idnl41zD0z1MKLjVzUZw1wKUeiIb4+ikJ36
        M0GrB0/O0evyHc+nmOs/pItzWQ==
X-Google-Smtp-Source: ABdhPJzP0I0s/7Io7VHacUtBKWAW181HMKuDl6im1neVViLNdg3MwOn5/6NeTRR+BtKseXsAirfGog==
X-Received: by 2002:a05:6a00:a86:b029:203:6bc9:3f14 with SMTP id b6-20020a056a000a86b02902036bc93f14mr28287473pfl.22.1619613756095;
        Wed, 28 Apr 2021 05:42:36 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id h3sm5219986pfo.155.2021.04.28.05.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 05:42:35 -0700 (PDT)
Date:   Wed, 28 Apr 2021 20:42:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH] brcmfmac: use ISO3166 country code and 0 rev as fallback
Message-ID: <20210428124228.GH15093@dragon>
References: <20210425110200.3050-1-shawn.guo@linaro.org>
 <b6c5713f-ebf0-9eaf-e871-d5690a6b7c10@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c5713f-ebf0-9eaf-e871-d5690a6b7c10@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 28, 2021 at 02:03:07PM +0200, Arend van Spriel wrote:
> On 4/25/2021 1:02 PM, Shawn Guo wrote:
> > Instead of aborting country code setup in firmware, use ISO3166 country
> > code and 0 rev as fallback, when country_codes mapping table is not
> > configured.  This fallback saves the country_codes table setup for recent
> > brcmfmac chipsets/firmwares, which just use ISO3166 code and require no
> > revision number.
> 
> I am somewhat surprised, but with the brcm-spinoffs (cypress/infineon and
> synaptics) my understanding may have been surpassed by reality. Would you
> happen to know which chipsets/firmwares require only ISO3166 code and no
> rev?

The "no rev" here actually means 'rev' field being zero.  The chipset
I'm running is a BCM43012 from Synaptics, I think.

Firmware: BCM43012/2 wl0: Apr 16 2021 15:25:36 version 18.35.389.63.t2 (wlan=r836194) FWID 01-a8c7bac

Shawn
