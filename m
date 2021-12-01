Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC10465601
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 20:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbhLATHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbhLATHs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 14:07:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D736C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 11:04:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so468340pjc.4
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Tf41EDVklcHjoVJH2bJZx09qWT8e2ZOrmXZk1vPBcw=;
        b=Lz3r8wmwEYFcNsJ3s8aUqTVYKCeup8K784xFhF8aj4SSJWkxl82PhkX+fvAhi5ZC35
         ZcrXFzzvtkqLii06p+oU2KL4dEXy3lz/tymYFXaEWfKmHCYP1+WxA4uUZQ0N7XOCbYkf
         ETq6DxuMPeg0Yn9AGcOED/Ri37H/t2GOlaKsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Tf41EDVklcHjoVJH2bJZx09qWT8e2ZOrmXZk1vPBcw=;
        b=sookkvJqw5Ca8VLdnGebLEGkP6n1JICNnDTH9HuZmBcM2jk0tiI1e60Ef6wuyrV+Fb
         aFzkyi3BjNDCJuNNp7d5DtrqYTSe3FSuVWBZfnDfy++bW3lwZrW/cGl/E8hNDuT74nrZ
         4mmSFbNlIRdx+4WglW4D9YmMGMEf0ZoYhDBIKlp3ZY1eMUHPEt0KbiXAy8frt2uMETZk
         wUji3DGeZCs2A5ZCyHwPb8UXkihAw31eBSBXHDitzmSnkdEh2FDgFv3wCFCHo15eSaVF
         P9FbW2hJpuQwzGgmSoipbw02Fx1qcOzKsjaYNHDSqiRFJfOH2Yas/wnvbeeKdMebECIj
         WByg==
X-Gm-Message-State: AOAM530L2pBsIhh2bH6rX3PfRyJqkha85WJFZUcrDnvro7A48XgbvIYk
        9B82NxopswNp6wgWhApfPLnpYw==
X-Google-Smtp-Source: ABdhPJzyQALX0ue/ROXvyT8pRDYJXc8SnppHpn3XNEbsEVMux8u7MHN276hIxPFTo/+TE3CAGd7ATg==
X-Received: by 2002:a17:902:c20d:b0:142:21e:b1e8 with SMTP id 13-20020a170902c20d00b00142021eb1e8mr9628260pll.27.1638385466670;
        Wed, 01 Dec 2021 11:04:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oa17sm69545pjb.37.2021.12.01.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:04:26 -0800 (PST)
Date:   Wed, 1 Dec 2021 11:04:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 3615/4301]
 include/linux/compiler_types.h:335:45: error: call to
 '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
Message-ID: <202112011059.1F60C79D@keescook>
References: <202111302102.apaePz2J-lkp@intel.com>
 <87pmqgsrcq.fsf@codeaurora.org>
 <202112010840.0AD4D41162@keescook>
 <17ccfc4f9f9e74e1d6b48366a87cbcf887521dab.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ccfc4f9f9e74e1d6b48366a87cbcf887521dab.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 01, 2021 at 06:29:49PM +0100, Johannes Berg wrote:
> On Wed, 2021-12-01 at 08:41 -0800, Kees Cook wrote:
> > 
> > > >    drivers/net/wireless/marvell/libertas/tx.c:116:9: note: in expansion of macro 'BUILD_BUG_ON'
> > > >      116 |         BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
> > > >          |         ^~~~~~~~~~~~
> > > 
> > > Kees, can you take a look at this build error? You added the
> > > BUILD_BUG_ON(), right?
> > 
> > I will investigate! Given this doesn't happen on allmodconfig but
> > a randconfig trips it, this might be finding a legit issue, but I'll
> > report back more details.
> > 
> 
> It's probably some alignment thing - note it happened on a specific ARM
> with a specific compiler?

Yup, that was it. It's an interesting bit of "accidentally correct"
problems that I think I've now fixed with this series:
https://lore.kernel.org/all/20211201173234.578124-1-keescook@chromium.org/

My pahole before/after testing appears to have been too limited and
missed this case. :( I'm currently reviewing all the others I've sent as
well.

> But there's not really a good reason to even have the struct_group here,
> we only use it as if it was
> 
> 	u8 tx_dest_addr[ETH_ALEN];
> 
> anyway?

Ah yeah, nothing uses tx_dest_addr_high nor tx_dest_addr_low. Should I
send another patch to just rip out the struct_group entirely?

-- 
Kees Cook
