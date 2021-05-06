Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F1375069
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhEFH4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhEFH4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 03:56:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F262C061761
        for <linux-wireless@vger.kernel.org>; Thu,  6 May 2021 00:55:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z16so4199213pga.1
        for <linux-wireless@vger.kernel.org>; Thu, 06 May 2021 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESVV/fMaAxNkE4WvbW0fxbJidb4bTYMGXoio537XTy8=;
        b=CBl6iUCMWBc1+XteGpbJ9leQZsxPoMSOwx/iAOt5hsVC8kF9j8ypdYuGO1NLGxRqgf
         3Ykk1ylqzolhm9eRIbT68h92NVteUANOM1QfT0FYefqAV18aaXzlczPZ45hztQHrFb+a
         gBbpnbW6Y49Lpts8ib15JwNOaHgWZoc9wZTZ9cdz0IFMH5Nu5zrJTlQBNsZCjHmTVZyn
         tl2Y4l3ES+7g3boCezH0i/M934Qc7jBnF/aHXKTo/18PFCu+BbVtiuo076Nt9W6eNOXA
         sg9YqOHJ7wRmVywkTdw4YdnzYb/EOOmYxhTQKtUnx61935Ac57esFpzZeAspbfmKjgeR
         HIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESVV/fMaAxNkE4WvbW0fxbJidb4bTYMGXoio537XTy8=;
        b=IPazGe14Y1XJthRgAArRaGzR1pwgCv15jePWN+bRBM5aeCbLkgXpuA06qtiA7u1uM8
         JVygY+Dk3EDXjrTLm20M61zZOeB2gkJTypOBoNhNBHYkOzryDCifrjtFte2JqlgCFJ+D
         /D2cBaGCSqqqHLcRdlAauQJppklzOB0J8UyAvUx59igCBpyG6hoLR2+a3Tov5rL32bq6
         Gv+tnO3xiBO3Ph5ZPXb1UjG72fggLDoL9sCtg17UutMLy9zmr9VEldjFkS0K2Bh+GDoH
         /6ZFPMBiGWY2Tm1bHNeF0IXNbW8YdzUxINY7JrYuniZ4EwRySjqCK2yMtrP+bMAv542C
         Ztiw==
X-Gm-Message-State: AOAM531hD95ELl4A0JeGNWFWsq9e0IFsxpM2zPuQIYxSDDHNyDo7vdqm
        j9zj5YJ3+4Uc8H0yozikWp1ysBvPI33pa6ZYYcIioQOraRsUtw==
X-Google-Smtp-Source: ABdhPJz9+BbLcod0C8x9IKaB+7PNgAIm6oZ/AvRXYy2PJxruNemP5ifp+mZctZppylusL3o8E5DacbRjvD7abeeEMnE=
X-Received: by 2002:a63:9d4e:: with SMTP id i75mr2924857pgd.443.1620287720183;
 Thu, 06 May 2021 00:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <1620234501-30461-1-git-send-email-bbhatt@codeaurora.org> <1620234501-30461-6-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1620234501-30461-6-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 6 May 2021 10:03:53 +0200
Message-ID: <CAMZdPi8_MKyF8imaOc+9MGz4ifOKX=UMA1CzHe3aPuXC2BEoOg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] bus: mhi: pci_generic: Set register access length
 for MHI driver
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 5 May 2021 at 19:08, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> MHI driver requires register space length to add range checks and
> prevent memory region accesses outside of that for MMIO space.
> Set it from the PCI generic controller driver before registering
> the MHI controller.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
