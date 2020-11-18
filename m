Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2310B2B7D20
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 12:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKRL6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 06:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgKRL6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 06:58:11 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6691BC0613D4
        for <linux-wireless@vger.kernel.org>; Wed, 18 Nov 2020 03:58:11 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y22so863611plr.6
        for <linux-wireless@vger.kernel.org>; Wed, 18 Nov 2020 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e06oOc4RuN9P/VUU47/az/twPX9Nm/1HhyjblwKfkfc=;
        b=rJ4WRtKjq35dZeXZ/KnjA5BgQRm9ykoN8E9JxwoLFc1PPL6QTX2bGTMnj2B18gDS9s
         X08ShvHS6cm0MdphMq4GiPidBOkeripf4zvRohtAE0TwAPAwXL9cxhp27ZglYNtcwma1
         erzKG8P7y3FnE60LdVZDQfT7Titled2vLawqr0Nb/fHKHJq8PMgcaYm/Xu7HvT+G6qZ9
         CwdDPy4fn1wGdRQgEhuknnaiLT4fDTpEK5eaLmcBAL42jbVPt9TfrsLd+jKfpETs4Hat
         S0Cd9ftNEC5FmwoaDojbNqRwdJXvfF+xSTu5H4omygtP/vOyVANprxUVKQG4S9+JIArW
         dzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e06oOc4RuN9P/VUU47/az/twPX9Nm/1HhyjblwKfkfc=;
        b=HSh/BducLA+kP7twXEQIjHacnmEdMHkxhsJKVp2IJtuhIP0DAvVND2Hb7CZ6IlfzKc
         c3+HZoahh3mGCI2JI3yy+ySqLVe7t/bf9qFAm4t4WgklEz1QxMnbJ7uwR6sOBvEYkrro
         /qkn/O0ceP1GEeDud8aQ91gJ4woJ93OKIB2Z8WQKKS2rhwKBUo0m41cp7zVponkGnwCo
         cnOfTd4ECeL74McKR4HhvhL8xtH11dfbKvxop/jE7P6LH1+trKXEfFgAGOyGGpm0y8wf
         qGZAzzM1XiDJebCaXnibTTimy2K2D+pPZMxnRKFxG15Fq11gjFlboiicnCdOvtm/s1Jd
         DKFg==
X-Gm-Message-State: AOAM533HEnnLLwB4UatwC5PL4Jm53/ft8nhLTQTa2IzJF4b8hWmX/uAp
        IgTapG9HpmBx2SRcpGFtNabH/xeXHmpq
X-Google-Smtp-Source: ABdhPJzPbm+WpLJrhor1bhcpiLpWMeJs6GI8+XTAXmGwyaJPfgNUpD3nptdMl8hGGNk/ULnzpQ9ovA==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr3572429pjl.187.1605700690813;
        Wed, 18 Nov 2020 03:58:10 -0800 (PST)
Received: from thinkpad ([2409:4072:6e00:1c8c:4ce:9ec5:283d:8090])
        by smtp.gmail.com with ESMTPSA id x18sm24230235pfi.206.2020.11.18.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 03:58:10 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:27:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        bbhatt@codeaurora.org, netdev@vger.kernel.org,
        hemantk@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] bus: mhi: Remove auto-start option
Message-ID: <20201118115757.GA5680@thinkpad>
References: <20201118053102.13119-1-manivannan.sadhasivam@linaro.org>
 <877dqjz0bv.fsf@codeaurora.org>
 <20201118093107.GC3286@work>
 <16c430bbd5117a35496f85f4454095b9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c430bbd5117a35496f85f4454095b9@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 18, 2020 at 07:55:19PM +0800, Carl Huang wrote:
> On 2020-11-18 17:31, Manivannan Sadhasivam wrote:
> > On Wed, Nov 18, 2020 at 07:43:48AM +0200, Kalle Valo wrote:
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> > > 
> > > > From: Loic Poulain <loic.poulain@linaro.org>
> > > >
> > > > There is really no point having an auto-start for channels.
> > > > This is confusing for the device drivers, some have to enable the
> > > > channels, others don't have... and waste resources (e.g. pre allocated
> > > > buffers) that may never be used.
> > > >
> > > > This is really up to the MHI device(channel) driver to manage the state
> > > > of its channels.
> > > >
> > > > While at it, let's also remove the auto-start option from ath11k mhi
> > > > controller.
> > > >
> > > > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > [mani: clubbed ath11k change]
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Thanks and feel free to take this to the immutable branch:
> > > 
> > > Acked-by: Kalle Valo <kvalo@codeaurora.org>
> > 
> > Patch applied to mhi-ath11k-immutable branch and merged into mhi-next.
> > 
> > Thanks,
> > Mani
> > 
> Does net/qrtr/mhi.c need changes? I guess now net/qrtr/mhi.c needs to call
> mhi_prepare_for_transfer() before transfer.
> 

Yes and the patch is also applied:
https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?h=mhi-ath11k-immutable&id=a2e2cc0dbb1121dfa875da1c04f3dff966fec162

Thanks,
Mani

> > > 
> > > --
> > > https://patchwork.kernel.org/project/linux-wireless/list/
> > > 
> > > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
