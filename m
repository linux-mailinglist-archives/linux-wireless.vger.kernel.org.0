Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90C38ADA0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 14:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhETMJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhETMJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 08:09:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D35C01CE89
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 03:43:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so5055460pjb.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 May 2021 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IW04GkrcNnLMAgZe3Aeh8iweN6/3sTprJybql0T99eU=;
        b=oPEiuLTy7B21if9MS/Aqe/xhEXvdul2VHQZ2dLfRfAWSFIM/bH0erRY3bvkraCo5Qe
         xFwCGhZIorGqeMga+TcD4N0vDd8s19Mq/WS9TSnb/SC6E9VbtGx7T2DO0Q2uHtp+BlBw
         Mdgn1DuPUHcdJ93Fp3fCYD7eAGBAVr8OpGHJZqwUl29g40s8oL/mj8NLk97bcewn8DMQ
         PEgycLPlx+Yif+9LzRpMunv9EyLAtc491VkCdFn7xDa/4qM0uCbVY8f8Bd+vfh2RFSxa
         HrOg5r5+s/w8jTzF56/Hd6IlWei/Wga2VsiskbrARruT5VsCPP0l1OEgn/PMan0ER5Le
         IWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IW04GkrcNnLMAgZe3Aeh8iweN6/3sTprJybql0T99eU=;
        b=cx0DRY2f4LZ1hhIaE/nPPuBbMa8p6oGBgWUvZrfU5u1M9TuoXUi7taGZHleg419dbA
         GPTqiDF89xEL5hIf+1In97z+D4RJJ6LySMtlZZgZ7ITKIWVjryuYKs9sp66ppARat/hj
         ohBWCWkNjA+i/4z86DEHlcxdf3vMtDXJb6la2fezA4jgjqV2yFlsUSqkN5qwC1NP69Xy
         j27W2G2LJyjwUuh0BP9c65UeRJ8NNsEWvTCyUC7/t0Y4BxEH7XZFz+alc/VBS/EZjAxs
         kHg+rxdYJvkcnJIF9EEPcTW9DYczaBSwMP7jeldgRykBQeEMPBZGbdcFxpT3LPbypN+V
         pGhw==
X-Gm-Message-State: AOAM530Pdbpgbfdu06t9BLC0/D9v6kvF1w4H9HLD3p7sjYB3JQtNdlmV
        b9KU8vcgIlvgcCT5GbrCMuhVVoAze7XF
X-Google-Smtp-Source: ABdhPJz64/pJD46QBHy45o4IwFLczk2gwoYOT2rXejR2w6Qbb29ZLdjhx5buftHryFa22aCeRIfe3Q==
X-Received: by 2002:a17:902:cec3:b029:f6:276b:a2b1 with SMTP id d3-20020a170902cec3b02900f6276ba2b1mr1650782plg.71.1621507400944;
        Thu, 20 May 2021 03:43:20 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d8e:dcde:240f:c67:6200:7740])
        by smtp.gmail.com with ESMTPSA id t133sm1928425pgb.0.2021.05.20.03.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:43:20 -0700 (PDT)
Date:   Thu, 20 May 2021 16:13:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [regressions] ath11k: v5.12.3 mhi regression
Message-ID: <20210520104313.GA128703@thinkpad>
References: <87v97dhh2u.fsf@codeaurora.org>
 <YKYzwBJNTy4Czd1A@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYzwBJNTy4Czd1A@kroah.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 20, 2021 at 12:02:40PM +0200, Greg KH wrote:
> On Thu, May 20, 2021 at 12:47:53PM +0300, Kalle Valo wrote:
> > Hi,
> > 
> > I got several reports that this mhi commit broke ath11k in v5.12.3:
> > 
> > commit 29b9829718c5e9bd68fc1c652f5e0ba9b9a64fed
> > Author: Bhaumik Bhatt <bbhatt@codeaurora.org>
> > Date:   Wed Feb 24 15:23:04 2021 -0800
> > 
> >     bus: mhi: core: Process execution environment changes serially
> >     
> >     [ Upstream commit ef2126c4e2ea2b92f543fae00a2a0332e4573c48 ]
> > 
> > Here are the reports:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=213055
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=212187
> > 
> > https://bugs.archlinux.org/task/70849?project=1&string=linux
> > 
> > Interestingly v5.13-rc1 seems to work fine, at least for me, though I
> > have not tested v5.12.3 myself. Can someone revert this commit in the
> > stable release so that people get their wifi working again, please?
> 
> How does the mhi bus code relate to a ath11k driver?  What bus is that
> on?
> 

MHI is the transport used by the ath11k driver to work with the WLAN devices
over PCIe.

Regarding the bug, I'd suggest to wait for Bhaumik (the author of 29b9829718c5)
to comment on the possible commit which needs backporting from mainline.

Thanks,
Mani

> This seems odd...
> 
> greg k-h
