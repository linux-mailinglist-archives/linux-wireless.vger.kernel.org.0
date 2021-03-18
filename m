Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB2340825
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 15:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCROvE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 10:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhCROuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 10:50:55 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E5C061763
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 07:50:55 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x135so1712683oia.9
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=og89K6jV3HFX8PE96KX/c5Zy0nyRjtFamlhCSJhcZac=;
        b=BbZoR5bKJdUlBsWePVP9pZFO52LSwx83bqvlA+iFEHEJbXRLCIjazsIWJ7Viy6/Dqg
         ms11HMn9qzvtUSKYV7kiYroJ8GoudjnuRaAotpDXCJkiH2454Zsrw0r8xOeT1eDT6YxS
         q+3+MBnu38qnO454OYLGBpBP8Gq2YHx7vcVu1igvYYB7TkhTKWyAqpE95EEQZcA7yNgB
         R/S0blHSK+wctWLHT5XamyOYHV+RON+tPa7QPNHdEwmYkO7LDY4BJHU3BGXMaxeArqVY
         EZJyG7pBZFDAX8JWQxpbOFMez+cg1l1eLriE/6/arkjyVorRKAMnxrrUHlTsEIB5mVvO
         PCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=og89K6jV3HFX8PE96KX/c5Zy0nyRjtFamlhCSJhcZac=;
        b=Ip+rMjW3Vd3JMdQdwDtb0uTho7S3zo8hdOqYcmzYdESu05+eMWanDJktSBxThB1hni
         lzA8oMX4sTCpn8NWPcXamAmRuzBr1jZjCqnAN8q1RmPY82/kY0nfi/6Bl1q8Chke7Xfs
         WZmj509BW8w+CGwqZUXSTrD9MJriVAUaunggRWKbdw85AIGiMog056Oq3tEaYr0WN+A5
         byEVy0gkbf/wxJK79JwOKeRIaeCnNLd9yo0vtg1qg+Qu/UMofZCv1AR/ezF0R108TQn5
         HcCSTEkgq4EnGtg0/LN7pHFkmUfQPpBRluAP8j4/eYRCMSuyrUoyJAsJZtoR4kkYnsvn
         C+/Q==
X-Gm-Message-State: AOAM530rrt8TUo4ofGNiaAsjmgRqRk+koHUQTHDLoa7CbSjqLQlOFmnU
        Zv548x/MwqkTFWT/0gHWQBEQ0g==
X-Google-Smtp-Source: ABdhPJw88D0okVHzO8aCSbNOnCSK+c61zfhIoBhm9ubX4GrgcqtKVy0DZAl00IvFZIUH6e7eT8sHOA==
X-Received: by 2002:a05:6808:987:: with SMTP id a7mr3198012oic.162.1616079054839;
        Thu, 18 Mar 2021 07:50:54 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13sm594897oot.41.2021.03.18.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 07:50:54 -0700 (PDT)
Date:   Thu, 18 Mar 2021 09:50:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: msm8916: Enable modem and WiFi
Message-ID: <YFNozCCa4fdR5kSb@builder.lan>
References: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
 <20210312003318.3273536-6-bjorn.andersson@linaro.org>
 <f03b639f-f95a-a31a-6615-23cd6154182d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f03b639f-f95a-a31a-6615-23cd6154182d@linaro.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon 15 Mar 07:01 CDT 2021, Bryan O'Donoghue wrote:

> On 12/03/2021 00:33, Bjorn Andersson wrote:
> > Enable the modem and WiFi subsystems and specify msm8916 specific
> > firmware path for these and the WCNSS control service.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++++++++
> >   arch/arm64/boot/dts/qcom/msm8916.dtsi     |  2 +-
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index 6aef0c2e4f0a..448e3561ef63 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -305,6 +305,12 @@ &mdss {
> >   	status = "okay";
> >   };
> > +&mpss {
> > +	status = "okay";
> > +
> > +	firmware-name = "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mbn";
> > +};
> > +
> >   &pm8916_resin {
> >   	status = "okay";
> >   	linux,code = <KEY_VOLUMEDOWN>;
> > @@ -312,6 +318,8 @@ &pm8916_resin {
> >   &pronto {
> >   	status = "okay";
> > +
> > +	firmware-name = "qcom/msm8916/wcnss.mbn";
> >   };
> 
> On Debian I have to do this
> 
> 
> index 2a6a23cb14ca..597cdc8f51cc 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -33,7 +33,7 @@
>  #include "qcom_wcnss.h"
> 
>  #define WCNSS_CRASH_REASON_SMEM                422
> -#define WCNSS_FIRMWARE_NAME            "wcnss.mdt"
> +#define WCNSS_FIRMWARE_NAME            "qcom/msm8916/wcnss.mdt"
> 
> so I guess wcnss_probe() -> rproc_alloc() wants this fix too.
> 

Can you confirm that you're saying that you want below patch, which I
just merged?

https://lore.kernel.org/linux-remoteproc/20210312002441.3273183-1-bjorn.andersson@linaro.org/

(Which makes it possible to specify firmware name per platform/board)

Regards,
Bjorn
