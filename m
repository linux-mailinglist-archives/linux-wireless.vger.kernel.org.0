Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4978435E86
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Oct 2021 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJUKDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Oct 2021 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhJUKDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Oct 2021 06:03:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F17C061749
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 03:01:16 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j190so18388717pgd.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Oct 2021 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hGQyf5rPoZMxlQ1aLuePLA0bIy/CXC3D2eGNLyDxIQ=;
        b=LgD+MFA0VgMp3D2jgO6wM+Zvee6Bsy+fpa54RY3R+QTDElX3sL3drNdQaakSXKc0g+
         vyuI4i7RveFDa2CMPCgq8ox9Ca5KQO2Puj/sVGvKvQGs+w9mEt5BYNE7pzTHFn/twwNq
         14QKhEyH0i4NPyRZynrQwhL7XmOppkIrob0lU90iPvqbJLtc8jD2Bm/NVMNOQgcNTP+V
         asxAKCTgpN+Qm7OikuEY7SOYzkDu9RKeLjGNfVTwpSvw0dYL9nbGlm91NTnFk+/096+C
         dEQZ6wcFnjqCS67TA/FTq/Pf8Tnnq2rbBCDJSr0rGh9hfqSKYGNNTVC/JanqrScK8jbv
         ierA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hGQyf5rPoZMxlQ1aLuePLA0bIy/CXC3D2eGNLyDxIQ=;
        b=ppjdWxuq1ZF/U4IHyWx3ZLR87B3RQKW5iuG/3WgnjtE58mQwSnRDvF7IaGZmUlU/ND
         klQ8h/1m1JMjVQlMGcAc+kYnO7YHcIPZy/SLzO2x7sQw1zIYkVuLyRfVR6G8Fcy1Kz94
         aF9SeFu+0jRJxIa2/wLLliMKoci4UVcdrMuBUwGSLw4Hr3n29b8I165ixv7lZZPsWPF6
         qJhTlqThyAFZuEW98UqopuM5Syc76045QWnnhnF+HfWCkwvnxckuCfqGN8Xo7c6KBhch
         L2D+z0eapf5AH/Yj/muxGHHdVFcz/sZMo6EceOkQiSh8x19OJjrdWNn2MLiMzmZ4zB/7
         AuHw==
X-Gm-Message-State: AOAM530bGQaLe5i+hLAOYez82Ki9vGi4FQr8M91h0lTofwi8eS6HBwkh
        kQzj7MJvD9nJMiT9EjKJA3O8
X-Google-Smtp-Source: ABdhPJwqwkiwpdpKBroxr8/GXh49GuysRlvA6YUSvh3qNewJDOS678tfSRj3DNxO+EWI4uKU91UUdg==
X-Received: by 2002:aa7:811a:0:b0:44c:b9ef:f618 with SMTP id b26-20020aa7811a000000b0044cb9eff618mr4446153pfi.9.1634810475933;
        Thu, 21 Oct 2021 03:01:15 -0700 (PDT)
Received: from workstation ([202.21.43.20])
        by smtp.gmail.com with ESMTPSA id t14sm4618518pga.62.2021.10.21.03.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Oct 2021 03:01:15 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:31:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
        mhi <mhi@lists.linux.dev>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
Message-ID: <20211021100111.GC7580@workstation>
References: <20210916111218.GA12918@thinkpad>
 <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
 <20210916163529.GA9027@thinkpad>
 <87k0jgxyjp.fsf@codeaurora.org>
 <20210916171927.GB9027@thinkpad>
 <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
 <20210923085926.GD6083@thinkpad>
 <8735putk82.fsf@codeaurora.org>
 <20210924095755.GB19050@workstation>
 <874k9t9n13.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k9t9n13.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 07, 2021 at 12:55:52PM +0300, Kalle Valo wrote:
> (adding also mhi list)
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > On Fri, Sep 24, 2021 at 12:07:41PM +0300, Kalle Valo wrote:
> >> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> >> 
> >> > For aid debugging, please see the state the device is in during mhi_pm_resume().
> >> > You can use below diff:
> >> >
> >> > diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> >> > index fb99e3727155..482d55dd209e 100644
> >> > --- a/drivers/bus/mhi/core/pm.c
> >> > +++ b/drivers/bus/mhi/core/pm.c
> >> > @@ -898,6 +898,9 @@ int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
> >> >         if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
> >> >                 return -EIO;
> >> >  
> >> > +       dev_info(dev, "Device state: %s\n",
> >> > +                TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
> >> > +
> >> >         if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3)
> >> >                 return -EINVAL;
> >> 
> >> This is what I get with my NUC testbox:
> >> 
> >> [  970.488202] ACPI: EC: event unblocked
> >> [  970.492484] hpet: Lost 1587 RTC interrupts
> >> [  970.492749] mhi mhi0: Device state: RESET
> >
> > Looks like the MHI device went into RESET state! It also looks to be a
> > firmware thing. But let's nail this down before adding any workaround in
> > the MHI stack.
> >
> > Can you also rebuild the kernel with MHI debug enabled and capture the
> > logs in faliure case?
> 
> So what I should exactly do to enable debug messages?
> 
> I have this in my Kconfig:
> 
> CONFIG_MHI_BUS=m
> # CONFIG_MHI_BUS_DEBUG is not set
> # CONFIG_MHI_BUS_PCI_GENERIC is not set
> 
> And AFAICS CONFIG_MHI_BUS_DEBUG only enables the debugfs interface, I
> doubt you meant that.
> 

No. You should enable the dev_dbg messages in MHI core by adding the -DDEBUG
flag to the Makefile or by CONFIG_DYNAMIC_DEBUG.

Thanks,
Mani

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
