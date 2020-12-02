Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0AC2CB3D5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 05:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgLBEQt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 23:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgLBEQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 23:16:49 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148FC0617A6
        for <linux-wireless@vger.kernel.org>; Tue,  1 Dec 2020 20:16:09 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so386480pls.10
        for <linux-wireless@vger.kernel.org>; Tue, 01 Dec 2020 20:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MmseSE+cXdLssv3A7XwhA62+JeVI67fYqg37Pw8CX+s=;
        b=CZMlOVhcE+DaJbhEL6v7DShX5B47FyRHV+0mvl4UoFyxQtO4y4pD9uSJPZ/wJWYTR7
         ECgglgWPnMOeMbJ8t6x56Ei2QFzkmvV4z5Lia+lXzPsbAU4/12JmHF0EcfmATHVXyRGs
         yz5q9v6c6fe5T0cRtzlexuG/9VEuwu/sXf4K7+TZw5IxMw4D7RG0hGMpLgmoi6On18DD
         QLNCkRp6rfONlg7muH2hZHiAXeRs6lP67yMjJVcmDvkAoiEKEIVrXqr8RowOHxCTjLbL
         kfw2uQGSaiB0oXbRvwYcgQBgCMQnLsATmZZX0aclggv9rASTYk4eDr4vgwKouQTkq4Nx
         VdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MmseSE+cXdLssv3A7XwhA62+JeVI67fYqg37Pw8CX+s=;
        b=WTe8lFlMyADZ/ldfqVwvwwDjX7byHpqpa5UVcI2HaCU0IF37jDkPa23MUNwvb6v9sm
         sJQIfX0iB0LXLJTl+J1RggMK7t7GjVZN+1ouDI/9d+NNtEILF05nJe8xJuTGNe/c9SnP
         hbUeqJfnDkwmPSZArRgtf5R2oGjAoU0tOm9QoZ7XU9NL4vyLbU19qSbhGl+Nk9KRmdxQ
         txm4unxWfrs9NhG1DkzLH1mn8ym6bt+5EjuFfhuuIiap3pg30imYYtesemvR27/YGnO9
         P99xU5EzM7oEzKEhZQMPirrdcmYm7NroIB+8BXv+uMuwQj0Oj078m1+nDhfh3zZ1rMXX
         6XjQ==
X-Gm-Message-State: AOAM531MYy+t5CDHvMeHg3D5jdHEOp1ctfmIQd1hgZXkQhXf0ykTOsdh
        Y5arEE7AWbxStcxa+ixbTT1e
X-Google-Smtp-Source: ABdhPJzRp1eWixG8zA2l2WufQZUMpGtcx2V9TvFvmBE2KJiPdOEDg7cZMVe/o9qpibJZ0jXvsI8WsA==
X-Received: by 2002:a17:90a:788e:: with SMTP id x14mr553911pjk.139.1606882568360;
        Tue, 01 Dec 2020 20:16:08 -0800 (PST)
Received: from thinkpad ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id q13sm296402pjq.15.2020.12.01.20.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 20:16:07 -0800 (PST)
Date:   Wed, 2 Dec 2020 09:45:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v13 0/4] userspace MHI client interface driver
Message-ID: <20201202041559.GA3241@thinkpad>
References: <1606533966-22821-1-git-send-email-hemantk@codeaurora.org>
 <20201201112901.7f13e26c@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <c6359962-a378-ed03-0fab-c2f6c8a1b8eb@codeaurora.org>
 <20201201120302.474d4c9b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201120302.474d4c9b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On Tue, Dec 01, 2020 at 12:03:02PM -0800, Jakub Kicinski wrote:
> On Tue, 1 Dec 2020 12:40:50 -0700 Jeffrey Hugo wrote:
> > On 12/1/2020 12:29 PM, Jakub Kicinski wrote:
> > > On Fri, 27 Nov 2020 19:26:02 -0800 Hemant Kumar wrote:  
> > >> This patch series adds support for UCI driver. UCI driver enables userspace
> > >> clients to communicate to external MHI devices like modem and WLAN. UCI driver
> > >> probe creates standard character device file nodes for userspace clients to
> > >> perform open, read, write, poll and release file operations. These file
> > >> operations call MHI core layer APIs to perform data transfer using MHI bus
> > >> to communicate with MHI device. Patch is tested using arm64 based platform.  
> > > 
> > > Wait, I thought this was for modems.
> > > 
> > > Why do WLAN devices need to communicate with user space?
> > >   
> > 
> > Why does it matter what type of device it is?  Are modems somehow unique 
> > in that they are the only type of device that userspace is allowed to 
> > interact with?
> 
> Yes modems are traditionally highly weird and require some serial
> device dance I don't even know about.
> 
> We have proper interfaces in Linux for configuring WiFi which work
> across vendors. Having char device access to WiFi would be a step 
> back.
> 

This is not for configuring the WiFi. This driver is mostly used for modems and
the AI accelerator Jeff is working on. But there might be a usecase for WLAN
devices as well to collect crash dumps and download fw (typical vendor ways) but
having those features are add-ons IMO.

So I think we should not be blocked by those usecases.

Thanks,
Mani
