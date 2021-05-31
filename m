Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66F4396724
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhEaRe1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 13:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhEaRd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 13:33:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155EC061237
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 09:33:09 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j1so5010565oie.6
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QP5LNb4El4/rZNDG00JTVtCCr+8eN4gHZWK+691nZ+w=;
        b=h2+JvBupdynnHCn8y5qmotQX4/b3+Ql9ZQ/Oakn5SozAt1G1xSOI/c1r0Pj0fak2o6
         iLx1hzzCQYFKn8QU8Ae3Si/bl9PzCYdJLIY5DFkBRX/WCmglFH/YtEKCw3TSF9FFxweN
         fA3uK2VyOhJZVCDBbwTSI4RspR6aWmMtNdoubyMfjC5YSU0p7iHb9ZKq3M2DGaQmZ4a6
         6xvIIxZ0AjG3ByMZWGGVKpFeCuhIkrCsGgw+Nfl//BrDHlkw3BMIQR9dopVnZhJNA9fw
         GFne4gHoOLtj+26H19MzCmqkbhMCLSnjnoSDYFZkVo39KmVowEcbd1dZKxXIRlX3CGDF
         LDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QP5LNb4El4/rZNDG00JTVtCCr+8eN4gHZWK+691nZ+w=;
        b=ZUz1sC+LQ9mq9X1niuotYFdZttE6N6EgliHiCIqYTWNP9ChDMOQMVyMkfVmH5OpACs
         o7BtrXmlt6cOyaPvm0eyPngwN3ESZkwvgOiOutPOOcykVkQ0XCS/s/Y1/hoPL7XEbchC
         7AoNeNaUuu9mMQmIc8wfezE+ndbfaQHbvODbTRY0aAsL+9LhRKthzL42/vQme03LsdOL
         ZMGExWSbyCv8WD5LbPmKnzSArrZH10cYxyISkSVpJvDIdSSDt5duV4ZaAEYhmuSqpney
         afDWRmWD5MwqcHXRD9d5GAvCKDz0Ja7UEZitwwV79q1MfYK41r5vB+NbMzkh0V8tAiB8
         +2MQ==
X-Gm-Message-State: AOAM530PK7fsjDCbTE3izgOIRN9rOK8FTNkSUoVKALAVukxTsBzOUK2V
        3KBgK/imT7Z8Z3V3mJRn5OeHbg==
X-Google-Smtp-Source: ABdhPJyvRGt8EqMiQvwDJo86HHk+JR6+rac0yGqlbu7+RuWwwoBNe3sU4G/6NUlarR0g5Ph9a5lFtA==
X-Received: by 2002:aca:dc84:: with SMTP id t126mr14476306oig.32.1622478789149;
        Mon, 31 May 2021 09:33:09 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z25sm2861589oic.30.2021.05.31.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:33:08 -0700 (PDT)
Date:   Mon, 31 May 2021 11:33:06 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: msm8916: Enable modem and WiFi
Message-ID: <YLUPwuD9+z8G1FXN@builder.lan>
References: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
 <20210312003318.3273536-6-bjorn.andersson@linaro.org>
 <YFTA8gEPp1x6o/9f@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFTA8gEPp1x6o/9f@gerhold.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri 19 Mar 10:19 CDT 2021, Stephan Gerhold wrote:

> Hi Bjorn,
> 

Hi Stephan,

I thought I wrote you a reply, but I don't see it on lore or in my
mailbox...

> On Thu, Mar 11, 2021 at 04:33:18PM -0800, Bjorn Andersson wrote:
> > Enable the modem and WiFi subsystems and specify msm8916 specific
> > firmware path for these and the WCNSS control service.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The changes itself look good to me, but the commit message is really
> misleading. It does not mention anywhere that the change actually just
> enables "modem" on apq8016-sbc instead of "msm8916". :)
> 
> Also, WCNSS was actually enabled before already (with the default
> firmware path). In my opinion, it would be clearer to change the
> firmware-name for it in an extra patch.
> 

You're right, I will rewrite the commit message.

> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++++++++
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi     |  2 +-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index 6aef0c2e4f0a..448e3561ef63 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -305,6 +305,12 @@ &mdss {
> >  	status = "okay";
> >  };
> >  
> > +&mpss {
> > +	status = "okay";
> > +
> > +	firmware-name = "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mbn";
> > +};
> > +
> >  &pm8916_resin {
> >  	status = "okay";
> >  	linux,code = <KEY_VOLUMEDOWN>;
> > @@ -312,6 +318,8 @@ &pm8916_resin {
> >  
> >  &pronto {
> >  	status = "okay";
> > +
> > +	firmware-name = "qcom/msm8916/wcnss.mbn";
> >  };
> >  
> 
> How do I get a .mbn from the wcnss.{mdt,.b??} files provided in the
> DB410c firmware package? I guess I should just run them through
> https://github.com/andersson/pil-squasher?
> 

Yes, .mdt + .bNN files can be put back together as a .mbn by running
them through the pil-squasher.

It's worth mentioning that the suffix doesn't matter for the loader, so
symlinking the .mdt to .mbn (in either way) will keep the kernel
happy - if that simplifies transitions in either way.

> Also, is the single file format (mbn) preferred now? Not sure if there
> is any significant difference except having less files laying around.
> 

We've had numerous cases where people has managed to mix the parts from
different versions of the firmware, sometimes with the nice result of
the loader complaining that some particular .bNN file is missing
other times just with the signature check (mysteriously) failing.

Lumping the parts into a single .mbn resolves all these issues and
hence I prefer this. It is however not a requirement.

Regards,
Bjorn
