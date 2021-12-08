Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1646D040
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 10:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhLHJoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 04:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLHJoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 04:44:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75318C0617A1
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 01:40:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k4so1161533plx.8
        for <linux-wireless@vger.kernel.org>; Wed, 08 Dec 2021 01:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uWzgpmLO9VHXp6lkhDz4fGQuJhk+6AV1KCdyKpRVolA=;
        b=eklJrKPspZKgFntWvR8NP54NwQ8qG9W7uiXo01EKKwoa95j2iAUFx3U7hp1/NRj0Hk
         pMzMbCnYAeN6rcmH8z0OoZ9IrY3Vn8oXyN2v560dOkdSDmjglk83e3k8FXyfqczZ5CIw
         t9hQ0m3WCP3YpUyUBzvUpDZ8Z3tZvQ6z6Gh3183oI0URu+IM+mgkpJ4i94RqgMxp5Pok
         8bLc1kzZ64MmWeZr6PhCHsJ8jsnAmvYw/SMN8KPYzC8093jmt/ojLQ40sYoUjFgDSPgC
         dDSIpyYAuHq1KnX5E3AotD2yr20k/VX2GVMaHm8q6AdAsI5Ip+PBbEpi1BfNb0o2GZJB
         kEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWzgpmLO9VHXp6lkhDz4fGQuJhk+6AV1KCdyKpRVolA=;
        b=hiSmAEwSZkhQ0eaiVtNO7/N/Dhc8tp7o+0kKXsDnP3WCBRjjHJFCJMJexoLqUjgq98
         Flk5Y3genGXj5hqwbcLkgBBA4SmAvYU508Bco/uNALQwvM52RMOAU/WYCaBHE3xxPLMC
         Y6MGOwjIikWaskckgGh23IjA0rwXVhtyOGMCYLN0wxv0IvbEEBMokVb7n0iQW546luCp
         WV25DcsYZ5exaiN/B6FXCd+PhvaKuLoe2Vcv88rwYFRBaBVQBPhw1IIpg+Va+O2kAZCA
         iOV5xgD99vXsVX2ju8iQVd6tMk4zQcBnF97RDQlz04jhCLsXYHEQObWtumujK9Zl8Ygv
         PNvg==
X-Gm-Message-State: AOAM532K9ZarTFrK//QuVFbUHrnGQP4SAbjaPx4smNcaYdcvmpgFuhrP
        MHPxLIUFBFt8JM6TLOQhN9r5
X-Google-Smtp-Source: ABdhPJwY9fZqXfhGo0Ye9iDFCgcftn45DiXQoZqA9ZqPx12EMWK3W9uiY/cX0pUiVc1nQAu2Bgj8Mg==
X-Received: by 2002:a17:90b:1d90:: with SMTP id pf16mr5910775pjb.93.1638956441917;
        Wed, 08 Dec 2021 01:40:41 -0800 (PST)
Received: from thinkpad ([117.202.189.59])
        by smtp.gmail.com with ESMTPSA id 13sm2600661pfp.216.2021.12.08.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 01:40:41 -0800 (PST)
Date:   Wed, 8 Dec 2021 15:10:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        stable@vger.kernel.org, Pengyu Ma <mapengyu@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 1/1] bus: mhi: core: Add support for forced PM resume
Message-ID: <20211208094035.GF70121@thinkpad>
References: <20211208085735.196394-1-manivannan.sadhasivam@linaro.org>
 <20211208085735.196394-2-manivannan.sadhasivam@linaro.org>
 <YbB11M0FZ+AdELPa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbB11M0FZ+AdELPa@kroah.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 08, 2021 at 10:07:32AM +0100, Greg KH wrote:

[...]

> > diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> > index 723985879035..102303288cee 100644
> > --- a/include/linux/mhi.h
> > +++ b/include/linux/mhi.h
> > @@ -660,8 +660,9 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl);
> >  /**
> >   * mhi_pm_resume - Resume MHI from suspended state
> >   * @mhi_cntrl: MHI controller
> > + * @force: Force resuming to M0 irrespective of the device MHI state
> >   */
> > -int mhi_pm_resume(struct mhi_controller *mhi_cntrl);
> > +int mhi_pm_resume(struct mhi_controller *mhi_cntrl, bool force);
> 
> apis like this are horrid to work with over time.
> 
> Why not just have:
> 	mhi_pm_resume_force()
> which then internally can set a flag that does this?  That way the
> driver author does not have to stop every time they see this call and
> look up exactly what the true/false field means in the function call in
> their driver.
> 

Okay.

> It also lets you leave alone the existing calls to mhi_pm_suspend() that
> do not want to "force" anything.
> 
> self-documenting code is good, this is not self-documenting at all.
> 
> Also, is "force" really what you are doing here?  This is a "normal"
> resume call, which should always work.

The normal resume here is resuming with M3 state only.

> The "force" option here really
> is just "ignore the current state of suspend for the device".  So
> perhaps mhi_pm_resume_ignore_current_state() might be better?  Or
> something shorter?
> 

And we are actually forcing here. As per the MHI spec, the devices has to be in
M3 state during resume. So if we allow any device to go through resume without
being in M3, that implies we are doing a force resume.

I'll use the mhi_pm_resume_force() API as you suggested.

Thanks,
Mani

> Naming is hard, sorry.
> 
> thanks,
> 
> greg k-h
