Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72143B272D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhFXGLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhFXGLm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 02:11:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B04C061756
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 23:09:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m17so2391705plx.7
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jun 2021 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cdh5icP9dLkaJMWxCjq6qbLcVl8C1ZKeQk32n5oC1wo=;
        b=z6SQdKR+RQn8aHynhbgyRv9q7FC8CqOH8thaal7O3TNCa7l74z5Uq+O8ZFTZgQy6TH
         N2gRz/Q17SedgEoI6Z4XEL/3nTaSTfpmLF8aJsYEm0GbF1SLdgPMqalTlGUdvPn66Myk
         3Q3cRb2gONrYpgz9nqjJbvcw5lxekeat4SV3mHfsPgrU78dehklhUKBP6JEQMxYbTRjw
         KtV+kzBk4Yvy3VdKFSQcb7MfYKz2s8jPboNVM8+MknCuBXg+w+TOFtWyOxaejSkujHOX
         SijuHx/c91cIPd1l23ngc+xwcE9GAXlFQ0LcZh15Rp2tjtoJALoB0rcaSj+TgGun9dkU
         AORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cdh5icP9dLkaJMWxCjq6qbLcVl8C1ZKeQk32n5oC1wo=;
        b=pFcgleujakUlS/R6k0wQwXH7rgEhp+3AP6kK5WCcKJ2DwZpee9h09XY95t80zv36Ay
         FP6U6mg1+4K8NhJK1XCTWW764O5jbQVP4lzhtamg1e/qEq/EHuLphECOJcw/Q0oerIvn
         gKVTIZQdPzQPEjA8UUORrpeJo993VDBr7fPNaG0WlFAvzXQOfzBatXRLB2pXIcTCHcoa
         Yg7fbj+l1Y/6QYDVYuou3KVHfHNP1HBUzGfzMSTcbIW+TWCcxSaiL89cXs/Y5ut/0tWb
         NJaPv0lUIGiWEs/ZSfD0RebW4nin5rErrI3//DbKcD80IihSaWLyEaWXz2Vzkqefh9/L
         8tqA==
X-Gm-Message-State: AOAM531/0U3k6ywmxg/lnpxKSYsdEOZwekduee/HXqXADjX+LGUiGspb
        nZ/TcBpSlyXDO4NQm8LnIwMQ
X-Google-Smtp-Source: ABdhPJxcrzf4frIXVJQwRNVsQ4gofsCEqvAUjZu1/mxoz4rbhnkZM1RWWFsDpWNO2YUUi/tRSrwQMQ==
X-Received: by 2002:a17:90a:bc89:: with SMTP id x9mr3644831pjr.228.1624514962040;
        Wed, 23 Jun 2021 23:09:22 -0700 (PDT)
Received: from workstation ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id u7sm1325765pjd.55.2021.06.23.23.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 23:09:21 -0700 (PDT)
Date:   Thu, 24 Jun 2021 11:39:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, bbhatt=codeaurora.org@codeaurora.org,
        lilic@codeaurora.org, kangxu@codeaurora.org
Subject: Re: [PATCH v4 4/6] ath11k: set register access length for MHI driver
Message-ID: <20210624060916.GA21925@workstation>
References: <1620330705-40192-1-git-send-email-bbhatt@codeaurora.org>
 <1620330705-40192-5-git-send-email-bbhatt@codeaurora.org>
 <20210521135152.GL70095@thinkpad>
 <87h7i0juxt.fsf@codeaurora.org>
 <37184e28dcc952ba9ad5ed0dc2c1a6da@codeaurora.org>
 <6ed9fe90f40e5f8151d3a028abf0acd1@codeaurora.org>
 <20210618064514.GM3682@workstation>
 <87k0mkh4ll.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0mkh4ll.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 23, 2021 at 08:29:26PM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > On Wed, Jun 16, 2021 at 10:38:01AM -0700, Bhaumik Bhatt wrote:
> >> Hi Kalle/Mani,
> >> 
> >> On 2021-06-14 10:49 AM, Bhaumik Bhatt wrote:
> >> Just got confirmation that the whole patch series was tested for functional
> >> sanity on
> >> Dell E7590 + QCA6390 with Ubuntu18.04 and patch 4/6 is also good to go.
> >> 
> >> Can you please ACK and pick up this series?
> >> 
> >
> > I can pick the series but I need an Ack from Kalle since it contains
> > ath11k changes. Kalle, can you please Ack this patch?
> >
> > I'm planning to send the PR by this weekend.
> 
> Sorry for the late reply. Yes, as this now tested with ath11k driver
> please take this ath11k patch via the mhi tree:
> 
> Acked-by: Kalle Valo <kvalo@codeaurora.org>

Thanks for the Ack, Kalle. But I've sent the pull to Greg for 5.14. So
once the merge window closes, I'll apply this series for 5.15.

Thanks,
Mani

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
