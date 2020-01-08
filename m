Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B31347E4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 17:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgAHQZZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 11:25:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42359 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgAHQZY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 11:25:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so3105453oin.9
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2020 08:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yz35zFP2aSNw0+gIRfSaZMhcsEm+gudXf2tyLjffdvY=;
        b=PQK9KX5s7JOef8i5kPnKg+xx0pOlWJlVg1omYqnQCFHSKhOWphJgnRDPSxXMsGQ61U
         gUg7djgA+ZDe9OEmGnfEmUX7/TRgSD5YIEtzcseeSHcfgBpa0V/2bD2pC1/TLpqjyUD8
         KoygiRPvrV3Db9Zlc418c17/wk0EEuWLfq2vjkO19rXHmuNSzoTAoBB1Xcuz09XslMxH
         oxUNFfJIHkc6LUxJNLN9ARsBk39dAbkwqIgu9+i7HA3HWM7AD1DPA3ZdguuJetVgP0fx
         kXpd79S1io5pNUqkr6ZgqYNsWxD2npjm2if1+TZWqq4JJ6aEZTd3znZxLFN7b/CGTn15
         dLig==
X-Gm-Message-State: APjAAAXKRLevFg4taqvEAOLgLCWRFDPzSBHgrK1eLF2BTQx/qN1rhhLS
        sBmHvIj6HFZ/HqiKyddgLC1HJ0g=
X-Google-Smtp-Source: APXvYqxyM3rm1T6uoV5fIaMzlwsncL4aiyUY098pUPxy/D/rCP7vToxoXpZ2H0qViGcDg5YqaVQ7NQ==
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr3797554oic.107.1578500723502;
        Wed, 08 Jan 2020 08:25:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm1253315otf.13.2020.01.08.08.25.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:25:22 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:25:21 -0600
Date:   Wed, 8 Jan 2020 10:25:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 1/2] ath10k: Add optional qdss clk
Message-ID: <20200108162521.GA23484@bogus>
References: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
 <20191223054855.3020665-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223054855.3020665-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 22 Dec 2019 21:48:54 -0800, Bjorn Andersson wrote:
> The WiFi firmware found on sm8150 requires that the QDSS clock is
> ticking in order to operate, so add an optional clock to the binding to
> allow this to be specified in the sm8150 dts and add the clock to the
> list of clocks in the driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
