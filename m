Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40B5264AA5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgIJRFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgIJQzE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:55:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4DC0617AB
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 09:47:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so7458963wrw.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r1RcJjuq+WDDkjUNNx0Km9/voIY1piTuPNUK42+ZJ10=;
        b=hhGh/+P+DIvxgxF4b56VE+cZu+xIiQTG23eijHpqAg1XY0vXdBbnkpxrCR/8YHYLKL
         FYaVLiMDnOMSkqRRGV1dkJe5NsmwrLO9JyvFn6jeDz2fwVIv5oRZyXOcJKxMiUSG3Pg3
         1pToGHQpt1QygecOnaQz2B5Ua6U8U+OFIwIaHJvrf5zRHXYg/o9o77WcCXMtdEIeMPET
         C4niO9cAe7m7JT9qaON0lLRNgI1EjfinvANaVFnhuisFOV7YMqYJ/uSuhhC98jy/aNv8
         gR9RWlizWTVx7ZDRiuTmpiuKdGYBsdX5ZHYJJC4UTcxYLRgzH/n9mwDuQ1wSgkDAgNNJ
         tuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r1RcJjuq+WDDkjUNNx0Km9/voIY1piTuPNUK42+ZJ10=;
        b=tynRxJqutmw0dnUECl4ORFn7hFuZzBlzgqwd0cC0uRuSqZYPxcD1162Mh2/W/Fud9Z
         HA/uuVBW0cqUUIwFbqIANGnyi5WQks1N5xQMmOXY1VTrayp4quzJhOxEyPfdanfbxcpC
         EQ0dHydPRdR1X9NYTbui1VDTZG7RDlh8c/ZvVXXW0/Bu5LBv6aBhhB5v8aluAyY3+wAj
         i2Jh9H3XSXvNIE8L7+z1lc+lugvhyDvEw1rb6JfpiZXXhNcMcTsWAMgSvQmoZtRLxy9q
         Ue9oUD8ESyFw6xWHmWKGurrCUHoubNq1063FmOsWxTyRnCuVCk4yW1SglPwa65noPY/7
         bT/g==
X-Gm-Message-State: AOAM532geSGem9fCNaYatfihE6xS9wZCowWqapQ+PSQ7q3K4guiesnM3
        CULe6Be3iUueV6yYvX42JGxTeQ==
X-Google-Smtp-Source: ABdhPJz2cYBlng2UuRHg5FdXgp1BGkBu4JdjKlSL95jLVVUPGP6aY3oQJGp0YgYlPLTAa65o+jk8cA==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr9865546wrn.411.1599756428201;
        Thu, 10 Sep 2020 09:47:08 -0700 (PDT)
Received: from dell ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id v7sm4283096wmj.28.2020.09.10.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:47:07 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:47:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: Re: [PATCH 27/29] ath9k: ar5008_initvals: Move ar5416Bank{0,1,2,3,7}
 to where they are used
Message-ID: <20200910164705.GE218742@dell>
References: <20200910065431.657636-28-lee.jones@linaro.org>
 <0101017478dee7a5-d1bf9eb4-8ec4-44d0-bc89-11497cdf681c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0101017478dee7a5-d1bf9eb4-8ec4-44d0-bc89-11497cdf681c-000000@us-west-2.amazonses.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 10 Sep 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:627:18: warning: ‘ar5416Bank7’ defined but not used [-Wunused-const-variable=]
> >  627 | static const u32 ar5416Bank7[][2] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:548:18: warning: ‘ar5416Bank3’ defined but not used [-Wunused-const-variable=]
> >  548 | static const u32 ar5416Bank3[][3] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:542:18: warning: ‘ar5416Bank2’ defined but not used [-Wunused-const-variable=]
> >  542 | static const u32 ar5416Bank2[][2] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:536:18: warning: ‘ar5416Bank1’ defined but not used [-Wunused-const-variable=]
> >  536 | static const u32 ar5416Bank1[][2] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:462:18: warning: ‘ar5416Bank0’ defined but not used [-Wunused-const-variable=]
> >  462 | static const u32 ar5416Bank0[][2] = {
> >  | ^~~~~~~~~~~
> > 
> > Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Already fixed in ath.git.

Ah, this is the repo that takes a while to filter into -next?

NP, thanks.

> error: patch failed: drivers/net/wireless/ath/ath9k/ar5008_initvals.h:459
> error: drivers/net/wireless/ath/ath9k/ar5008_initvals.h: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath9k/ar5008_phy.c:18
> error: drivers/net/wireless/ath/ath9k/ar5008_phy.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> Patch set to Rejected.
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
