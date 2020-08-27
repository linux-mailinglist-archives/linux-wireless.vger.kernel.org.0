Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB48253F68
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 09:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgH0HlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgH0HlE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 03:41:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED016C06121A
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 00:41:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r15so4322320wrp.13
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iZ3Xl7BYLjLs7ClzWjHhXBysbg3+KM5XES/W6qGeOlU=;
        b=fXAfbnkU7hWxTWL1arDZglrQyCkCMThyb5yQIGMdqGrObKQZ9OFoFcmgskk/A76rIG
         /mSSn0z51k1F3vrsZPUquS0t8ubW11JtzUOnsIAQ3vEOw9BrR1MKXNXz4ngRe5wYGw5G
         TTXG5YpEFug10hLLqWECAf67GEGmL76T3jo5q23VaFvOFIdhqAvGYDgLQjS8xIaR6PWS
         huRtdCFAdrXzkya/U5/gGMVHG62mG5qEbVYAFhgyfQNtpEp7FisAmly/b3DAxVEMEDxs
         D3nL4X6lNl78nJlIVxGdy6cJpPclwTFbT5MDIP+fxM64X4Yyw4Pyf49AX6mWR3BpJ8lH
         lCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iZ3Xl7BYLjLs7ClzWjHhXBysbg3+KM5XES/W6qGeOlU=;
        b=C1+fscqIUiHbVyElUHbuNDM/hvbzeaD1elPXrZser17qB5Ynz+3OCexabNhoKC5G0c
         SoHqdIsGvcWsamjk04N3l59b9TTJQRL+hXkT5O6mZKsuKpYS9XvIo2cEv31hTmH+/wKf
         xHf/tMY43nTclV4fqdA1vz5N1ehJE/X9zPlz7HOWFg0+VjVasBUrieeOBoz8l4mpdhse
         PW3xB+FSussfGc9WTpCzm5KSqAVT/cw0tnPdd/GmvhXNOD4J8U+PqSSxX94X7o1x9+Bt
         RxrGTNBo6kqJURkQn4xrtyW+3xhdzYdsZa+cgde30HepefDmpqRORHbf7tgu0vr8WXVB
         /aqg==
X-Gm-Message-State: AOAM530rrhIgsRIB78WuAIK9AtyiMraaMsIJp5t5HEWg58VQAafMSA19
        qwTd4lHSv/z/0j++ILspx5rsHg==
X-Google-Smtp-Source: ABdhPJzdpW5s9HizrDpZ1gIke1unY9VvCVa2lpgXTqPyHyWjDMi/K5gTbBQOQynvRze6lu8aZAf8PA==
X-Received: by 2002:adf:ba52:: with SMTP id t18mr18703560wrg.26.1598514062501;
        Thu, 27 Aug 2020 00:41:02 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id m1sm2983702wmc.28.2020.08.27.00.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:41:01 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:41:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 12/30] wireless: ath: wil6210: wmi: Correct misnamed
 function parameter 'ptr_'
Message-ID: <20200827074100.GX3248864@dell>
References: <20200826093401.1458456-13-lee.jones@linaro.org>
 <20200826155625.A5A88C433A1@smtp.codeaurora.org>
 <20200827063559.GP3248864@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200827063559.GP3248864@dell>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 27 Aug 2020, Lee Jones wrote:

> On Wed, 26 Aug 2020, Kalle Valo wrote:
> 
> > Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
> > >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'
> > > 
> > > Cc: Maya Erez <merez@codeaurora.org>
> > > Cc: Kalle Valo <kvalo@codeaurora.org>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: linux-wireless@vger.kernel.org
> > > Cc: wil6210@qti.qualcomm.com
> > > Cc: netdev@vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Failed to apply:
> > 
> > error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:266
> > error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
> > stg import: Diff does not apply cleanly
> > 
> > Patch set to Changes Requested.
> 
> Are you applying them in order?
> 
> It may be affected by:
> 
>  wireless: ath: wil6210: wmi: Fix formatting and demote non-conforming function headers
> 
> I'll also rebase onto the latest -next and resubmit.

I just rebased all 3 sets onto the latest -next (next-20200827)
without issue.  Not sure what problem you're seeing.  Did you apply
the first set before attempting the second?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
