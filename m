Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0358F416FC5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbhIXJ7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbhIXJ7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 05:59:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F76C061574
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 02:58:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t20so6591503pju.5
        for <linux-wireless@vger.kernel.org>; Fri, 24 Sep 2021 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h86Kb3QUqJtR4zPZgpYvPPGAnhfhpRYV7jiCyDXyf+w=;
        b=RNQ/1B/C77Ni1RSFv3BgTnL4+00c/9TKGG/D+FdUqxVLiIrN2aNcvbEvFxq9raz5GN
         fnFn10H4hW6bGirWYycYG7RNzFkXk4ELl1rmzK5xeTAsKN9RRSG06jXK+cvhJf/4rXoH
         Glex5VhhGW8uN6LSISPTDvg80QMD6d10Z3a1vpUuRKRiiMCIHqw7Z1VuRKvce/RVIN0v
         sQ2eYJUC67NqJUg4Lg/AvtkX7zdou4f3wO0Di5noa2uMXSCrpPupIbPZ4jxFXtjRHCuh
         L87NC94X/OxmGZyr3E2lROVUMmjN/ggsLq/TG+3H9ibl/JvDBS63cWIX06/GGDr+vAhe
         GeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h86Kb3QUqJtR4zPZgpYvPPGAnhfhpRYV7jiCyDXyf+w=;
        b=4kKy6DoaeakVxVrHQvVDIva/PWzKnrb5DzuxlZGfVGiCGhC7jmeZBNV569cDiKFQO3
         qvroZhHAYRspgnArQQ3zU38UTqXN3wkDhi41OJoZ2AfOj6IfrgIvEL45CwiuneFHW/wU
         83kCFlnsaZ4507EQ/Ub0tFbitAWEnCVwGIdCgvq5bz4e2JTQwt8ZnVNdAPoc88Not8DS
         C2xSJhJF+4XRgIQXrhPJgTLLkPd12EIoeV8+X9vM892G+q2NkOR3wayGIjNQNnz1TOss
         +mt2qcUH4o3Vb+V2CpA1Ri+VeFK/4RHH9JACptajAM5YUVXMKUiKgVOLGhss8LLR7Hq2
         4x0A==
X-Gm-Message-State: AOAM5326bMJNmY1RfkRxAu2467KF4q2YOyYFLDf+WPjw580XCLHhxQ1K
        1/UHmEgZ+Y45VCJ8V5jyDyNL
X-Google-Smtp-Source: ABdhPJycSI8LsaymEj4U/4GD8DMihaZc7F+YNooQSWQsQTSRve9ScsJMdCLKTclMqKCMXc49g/VLkw==
X-Received: by 2002:a17:90a:c982:: with SMTP id w2mr1227473pjt.30.1632477480093;
        Fri, 24 Sep 2021 02:58:00 -0700 (PDT)
Received: from workstation ([120.138.12.62])
        by smtp.gmail.com with ESMTPSA id e3sm8261380pfi.189.2021.09.24.02.57.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Sep 2021 02:57:59 -0700 (PDT)
Date:   Fri, 24 Sep 2021 15:27:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] mhi: ath11k resume fails on some devices
Message-ID: <20210924095755.GB19050@workstation>
References: <871r5p0x2u.fsf@codeaurora.org>
 <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <20210916111218.GA12918@thinkpad>
 <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
 <20210916163529.GA9027@thinkpad>
 <87k0jgxyjp.fsf@codeaurora.org>
 <20210916171927.GB9027@thinkpad>
 <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
 <20210923085926.GD6083@thinkpad>
 <8735putk82.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735putk82.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 24, 2021 at 12:07:41PM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > For aid debugging, please see the state the device is in during mhi_pm_resume().
> > You can use below diff:
> >
> > diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> > index fb99e3727155..482d55dd209e 100644
> > --- a/drivers/bus/mhi/core/pm.c
> > +++ b/drivers/bus/mhi/core/pm.c
> > @@ -898,6 +898,9 @@ int mhi_pm_resume(struct mhi_controller *mhi_cntrl)
> >         if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
> >                 return -EIO;
> >  
> > +       dev_info(dev, "Device state: %s\n",
> > +                TO_MHI_STATE_STR(mhi_get_mhi_state(mhi_cntrl)));
> > +
> >         if (mhi_get_mhi_state(mhi_cntrl) != MHI_STATE_M3)
> >                 return -EINVAL;
> 
> This is what I get with my NUC testbox:
> 
> [  970.488202] ACPI: EC: event unblocked
> [  970.492484] hpet: Lost 1587 RTC interrupts
> [  970.492749] mhi mhi0: Device state: RESET

Looks like the MHI device went into RESET state! It also looks to be a
firmware thing. But let's nail this down before adding any workaround in
the MHI stack.

Can you also rebuild the kernel with MHI debug enabled and capture the
logs in faliure case? Sorry if it is too much of work for you!

Thanks,
Mani

> [  970.492805] ath11k_pci 0000:06:00.0: failed to set mhi state: RESUME(6)
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
