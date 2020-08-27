Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B059254800
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgH0O5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgH0M0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:26:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DFC06121B
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:16:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r15so5135955wrp.13
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vG3GFaecRjYGM2orq3QNH3b5bYkLOVwGTg6XiPpRXIc=;
        b=yMZhFN+veq01+ehZQeqqK0HhK+dnG66FHF62HBnjdjO+Hxk1KWY1W2dTxqnSlNWsZb
         7NrCYLjtmqs8ZZRBa1rC7WJ+Fjl6xAalt7mPJS+1ciGUOenIil2PbkxIpAV8m+xON24p
         HlWXtWju0lBA7bVapsr3Q4oD5pC6WldpEU2YOmxfKxAcyd8K2oUU9qweG4mXKEsTB//l
         vsz1L7puUsSszPyf/ABcYrck5b6BVOl27XPFXKmjgwOEjrDx60iguNCzKJY7rn6dfh/l
         RTN/txEfeuFNtKyzHnl9bkOrB6H71cOMb8l4Kh0J7GQC2JCosNHe8GyzjufyIM5WRK2o
         eZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vG3GFaecRjYGM2orq3QNH3b5bYkLOVwGTg6XiPpRXIc=;
        b=XrzDsNHtyZPcjbzv3uKoMS4rnKBZvpqMdwWRuMo75TqyXhEns6hmEgan9UIJtso0wa
         GM63IM0SQvN5c0UQPf/aXT+ZnPOSMTmLJ5jxUHDTRd/mX4jQBsRTNjgejS2MUSklH38x
         c7WS4PKmHuejiwAe/afpKpksMiB2LqPvh/C1J1uwYHZAaBAtxTV19ubVg+V3cqAQyRS9
         YBv6nS5x66eu4z1crzsCFNsbkYbWW7hYCwUHrPickouzCSsW1D2Zkzd9ar4BJU/HaLOj
         EegChnN5cAYG9QdHn8hgVH7mVbQIznbVV8fNKH/O5Jk/RYdZdd5uUiPibdAkKxQK+Jvu
         n7wA==
X-Gm-Message-State: AOAM532OJbKKZCrnvORRwnHtlDa7wp9MGRepLXjEhPBV2OpblSHrNxDd
        ne0FDoGpyhFTkDfhNk20hNbHgF9E1rhgfA==
X-Google-Smtp-Source: ABdhPJxbyF8d5EcngGv3DhfuYhCjndliOt2vwoniXJmdB+7PavRwuar4fgzUKdUkIYi3702fUNwjyw==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr1722186wru.173.1598530570226;
        Thu, 27 Aug 2020 05:16:10 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id m10sm4756714wmi.9.2020.08.27.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:16:09 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:16:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 12/30] wireless: ath: wil6210: wmi: Correct misnamed
 function parameter 'ptr_'
Message-ID: <20200827121607.GF1627017@dell>
References: <20200826093401.1458456-13-lee.jones@linaro.org>
 <20200826155625.A5A88C433A1@smtp.codeaurora.org>
 <20200827063559.GP3248864@dell>
 <20200827074100.GX3248864@dell>
 <877dtkb9lm.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dtkb9lm.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 27 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Thu, 27 Aug 2020, Lee Jones wrote:
> >
> >> On Wed, 26 Aug 2020, Kalle Valo wrote:
> >> 
> >> > Lee Jones <lee.jones@linaro.org> wrote:
> >> > 
> >> > > Fixes the following W=1 kernel build warning(s):
> >> > > 
> >> > >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function
> >> > > parameter or member 'ptr_' not described in 'wmi_buffer_block'
> >> > >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess
> >> > > function parameter 'ptr' description in 'wmi_buffer_block'
> >> > > 
> >> > > Cc: Maya Erez <merez@codeaurora.org>
> >> > > Cc: Kalle Valo <kvalo@codeaurora.org>
> >> > > Cc: "David S. Miller" <davem@davemloft.net>
> >> > > Cc: Jakub Kicinski <kuba@kernel.org>
> >> > > Cc: linux-wireless@vger.kernel.org
> >> > > Cc: wil6210@qti.qualcomm.com
> >> > > Cc: netdev@vger.kernel.org
> >> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> > 
> >> > Failed to apply:
> >> > 
> >> > error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:266
> >> > error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
> >> > stg import: Diff does not apply cleanly
> >> > 
> >> > Patch set to Changes Requested.
> >> 
> >> Are you applying them in order?
> >> 
> >> It may be affected by:
> >> 
> >>  wireless: ath: wil6210: wmi: Fix formatting and demote
> >> non-conforming function headers
> >> 
> >> I'll also rebase onto the latest -next and resubmit.
> >
> > I just rebased all 3 sets onto the latest -next (next-20200827)
> > without issue.  Not sure what problem you're seeing.  Did you apply
> > the first set before attempting the second?
> 
> I can't remember the order, patchwork sorts them based on the order they
> have been submitted and that's what I usually use.
> 
> Do note that there's a separate tree for drivers in
> drivers/net/wireless/ath:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
> 
> And it takes a week or two before patches go to linux-next.

Understood.  Thank you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
