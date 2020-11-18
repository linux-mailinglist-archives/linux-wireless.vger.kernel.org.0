Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07FF2B7A68
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKRJbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 04:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgKRJbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 04:31:15 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9DC061A4F
        for <linux-wireless@vger.kernel.org>; Wed, 18 Nov 2020 01:31:14 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q34so780868pgb.11
        for <linux-wireless@vger.kernel.org>; Wed, 18 Nov 2020 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sJzfKF/R19+n7PGEC3QRVimnx1Uc5u5uS3V7+K9BfQ=;
        b=bZgdEXR/ZaFKvebScHH5Q+qFcMi57gsN5z7s7219zIyuxSGzasUsRk2r7B7hRaglln
         YiohFI/K1wOpgG31niCZsznljJxwYO+DBV2Ayxq+w/C84M1hhGNRlzKOwsrPsfMiKUNC
         1MCKmduruXMCVzfgREmGV3W4KYsbCddAYbJ4xC19oIC1kzgBtwSuqo9pcJPqicBTS0kV
         cnBmJqU0BD1oNWGleKPkAVXYKldCyL6XaNMmrSfXZxYXp4O1RhIBigf0oBJAbQcQCGur
         jggCRzuWcIWDI+GGKsZiST0t8WSQEd1eXIAodlAR5e1Flbpyy/rfrusG9VlZXe7OtMyB
         oDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sJzfKF/R19+n7PGEC3QRVimnx1Uc5u5uS3V7+K9BfQ=;
        b=P4WfI7tzW4IPow9FOKFJDkIZCwtMdeuFQzRRs//3dHAtIQvGWbZQKMmabi/pSavm82
         taeh29NFtUS2ue6Dgo/5riOtEpdFZFIeuCbp0r7IMkpGJbsW1pnt/eBF493JLBkdHioN
         f0WmsdPoJG09lHGxRmuls6jUuKuwSsBS9lHomGVdgmd5P2nLmqYw+TeIND25Lt+6yVTW
         u7g0lu7Xadr8koyItcZ7CeHJ1GbAscPr697D6GQYC1xEmQhsAmSB4BmHrGtBB+HhtfEK
         nuxfnB7sO8RmdHu/3+DuqyA2AxGfQTsErCD4uixCzXL5xqMEvNwIgCZ/w+kSo8L2SDn0
         WMlw==
X-Gm-Message-State: AOAM531Qer9i4nF6nAfub7KAkFdRlvX5BP2B+PvU8MZTfA9mNIFJPwT0
        aiU7veoRbD0ppC4Fgx9Mxinq
X-Google-Smtp-Source: ABdhPJxAF8PiFAPcEZMU3zhIYbaiwpiUccynZBojEL8AfE7wj3u2OpnHQb8iaXndOTzPDiqyA//knQ==
X-Received: by 2002:aa7:8154:0:b029:156:4b89:8072 with SMTP id d20-20020aa781540000b02901564b898072mr3879432pfn.51.1605691873922;
        Wed, 18 Nov 2020 01:31:13 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id h8sm2219525pjc.54.2020.11.18.01.31.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 01:31:13 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:01:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, bbhatt@codeaurora.org,
        hemantk@codeaurora.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] bus: mhi: Remove auto-start option
Message-ID: <20201118093107.GC3286@work>
References: <20201118053102.13119-1-manivannan.sadhasivam@linaro.org>
 <877dqjz0bv.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dqjz0bv.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 18, 2020 at 07:43:48AM +0200, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > From: Loic Poulain <loic.poulain@linaro.org>
> >
> > There is really no point having an auto-start for channels.
> > This is confusing for the device drivers, some have to enable the
> > channels, others don't have... and waste resources (e.g. pre allocated
> > buffers) that may never be used.
> >
> > This is really up to the MHI device(channel) driver to manage the state
> > of its channels.
> >
> > While at it, let's also remove the auto-start option from ath11k mhi
> > controller.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > [mani: clubbed ath11k change]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks and feel free to take this to the immutable branch:
> 
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to mhi-ath11k-immutable branch and merged into mhi-next.

Thanks,
Mani

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
