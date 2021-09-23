Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F319416325
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbhIWQ0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 12:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242112AbhIWQZy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 12:25:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C88C061768
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 09:24:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so6869712pgp.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zRdyYgwvajEjD4V9z15vSQCCVlA8Qu6P6/04oQjnGQM=;
        b=KXA7AoYi0vsPmiSqGO+nocntKlUj8gfKBgSC/K+HznBpnvR8UCMtkJvJNfkjimY3UK
         7Yl3xwq/JkY2p2FTiklpFoE3n5E3jbY6Ju/kNQRri0lmk5qpcts+rjnV/f+/l9I1t439
         gclCfDe+0a4X3pN6Wgji4EZO7duC8tsl5Dtb/dxhM5igNFO5qZQWzhUEHzjygt/Z+wrS
         dDa6RaYhv9bXMPz2ThvyS+aDq1yw2RFa62rCMVNL5X5j8S7RvMcPG72E3Ql6LrvRgSUn
         4F6VtznhR1Blia29L8g/X/IektR8b9y2Uanvoe2UKZHn5hyhR5CUynlLHCMVRmLxJNfF
         +I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRdyYgwvajEjD4V9z15vSQCCVlA8Qu6P6/04oQjnGQM=;
        b=huFZa+Ksrq1lXAbMrKHun5IM98m7rZrslzD2OVNuxDY5870X1FZwP03x1JNNQ5Z003
         qIDogNbPoqn4HSx0U9ZkctJG7j9fkXt7kOTMtWA/jA8HjwuBEXS+ds4+hImhWwfRx5K5
         PRAfXcH+X8DA8In6MHA3Cqw1c5IHkmAJxPorkQlD+1PpYZoEHI75/Qjj1fflc1G3QlAe
         j75ul8mlB16GX0iYd2rau2GLCKPSG+qC4y8GAgWyHM5Hs3Eu4nsxbJw/j5Kkx0etViGx
         92YT2EZVaAZv7I4BdDfL1ZngRdubxsotO0rlELNIYjZICV0pC/ebIXZc3DINrr9+ZxE9
         2sxw==
X-Gm-Message-State: AOAM531NJbP1fUNZUg7C4LpGP+Gkg0r/Wb8nqO6UnGiyHenqoNMx4Gkz
        vAMwkR8jR3CrMy/esFDww88=
X-Google-Smtp-Source: ABdhPJxlEuPY9oZZ3EJKXdW1r8V2xPFxyzyehilfOhzrTcFnGQCbJFgcdBhw9+JpRxPYsODRCfyHww==
X-Received: by 2002:a63:155d:: with SMTP id 29mr5102216pgv.118.1632414261762;
        Thu, 23 Sep 2021 09:24:21 -0700 (PDT)
Received: from lattitude ([49.206.112.105])
        by smtp.gmail.com with ESMTPSA id r2sm7136683pgn.8.2021.09.23.09.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:24:20 -0700 (PDT)
Date:   Thu, 23 Sep 2021 21:53:54 +0530
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH iw 1/4] iw: nl80211: add NLA_F_NESTED to nla_nest_start()
 with older libnl versions
Message-ID: <20210923162354.GB3812520@lattitude>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
 <10ea557f9dfdf92083b9816d7370926e4222f333.camel@sipsolutions.net>
 <20210923155308.GA3760174@lattitude>
 <64776c93e7f98c34821042b6864e81b7c3ab6443.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64776c93e7f98c34821042b6864e81b7c3ab6443.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 23, 2021 at 05:56:40PM +0200, Johannes Berg wrote:
> On Thu, 2021-09-23 at 21:23 +0530, Gokul Sivakumar wrote:
> > The symbol NL_CAPABILITY_VERSION_3_5_0 is part of the libnl library and
> > this will be defined when using the libnl library version >= 3.5.0.
> > From libnl 3.5.0, the library itself handles setting NLA_F_NESTED flag
> > when using nla_nest_start() lib function. Please refer the
> > commit 7de65a0 ("attr: mark nested attributes as NLA_F_NESTED") in libnl
> > gitub tree (https://github.com/thom311/libnl/commit/7de65a0).
> > 
> 
> Huh ok, I guess I missed the memo on the (official?) tree moving ...
> 
> johannes
> 

I beleive https://github.com/thom311/libnl/ is the official tree for libnl
and I see Pull Requests are getting accepted in Github. Others can confirm!

The git tree git://git.infradead.org/users/tgr/libnl.git mentioned in
https://www.infradead.org/~tgr/libnl/ doesn't seem to be accessible.

Gokul
