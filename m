Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F9543E5E6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJ1QR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhJ1QR0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 12:17:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FBC061767
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 09:14:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s136so6870524pgs.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RIRl/cX9bRAdZ2iE+RztTT8DUmuRWcio5MFjZ21K1SU=;
        b=nZQ+/sqMzlDgKS5zdUiX4/1c2J50t2MBLiIi87+ZBwv2fDdhvgpM5rjvZ58uYYr7xP
         6KB3YlG1RKTNIPUVynbJR5EASynlM6Bdk+d7mt5bp7JEgSEYFUlSUJ37ptcZvAkYDEy4
         rEymG9WyGFP/L+JQw8xnn9HVzrqXW8627L8Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RIRl/cX9bRAdZ2iE+RztTT8DUmuRWcio5MFjZ21K1SU=;
        b=TM1R0kLXQpSbSYxqq6QWjMDBeVmUpHP3HkTXEp8kaWGviDMGejX9BwGtylNg09imfq
         MdL7mocdO/UUoBUP7HSy5g9+mJ08RodibRrgR8IbapGhuDFL9Ovmb/9IOzTWNmpnWkkX
         qZ3lwc+C+wRg947AwDaDLTwTiiLTfLdKWdzFooiSUbTL9x3g+83rT8q6UwxfKu+D2hfb
         M3gKxVGCiIZyZL4m1QMtpJc8PobEn3rv9z6VnbB41e16bs0j4H6/AK6zi7hLGILpe+kQ
         nCzZM6/fBkH/1ALDHtDd1IWwMuiiAAwN0e8AIys9vG/4DBGPmheS1bird/8JrRB2IsaH
         hrxA==
X-Gm-Message-State: AOAM533g3GdiG6UHUnWFFmPBeRfRPiQsohyTJ5jcjM7m26VGBXzvPxAE
        E0Ffic8wfY88pqH6FF2zyxM7//Mrv/ThoQ==
X-Google-Smtp-Source: ABdhPJxE6O1c95Dnzr+CmiuzlG+RTD1Y7zdAwochLmVPTlvdhZQM1NIDVXTIExAraNX+vTUmR7ciOQ==
X-Received: by 2002:a63:6e8f:: with SMTP id j137mr3854160pgc.381.1635437699460;
        Thu, 28 Oct 2021 09:14:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj5sm8520291pjb.45.2021.10.28.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:14:58 -0700 (PDT)
Date:   Thu, 28 Oct 2021 09:14:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: linux-next: manual merge of the kspp tree with the
 wireless-drivers-next tree
Message-ID: <202110280913.B8D76EF@keescook>
References: <20211028192934.01520d7e@canb.auug.org.au>
 <87ilxh5yph.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilxh5yph.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 28, 2021 at 11:40:42AM +0300, Kalle Valo wrote:
> (adding Jakub and Dave so that they are aware of this)
> 
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > Hi all,
> >
> > Today's linux-next merge of the kspp tree got a conflict in:
> >
> >   drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> >
> > between commit:
> >
> >   dc52fac37c87 ("iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions")
> >
> > from the wireless-drivers-next tree and commit:
> >
> >   fa7845cfd53f ("treewide: Replace open-coded flex arrays in unions")
> >
> > from the kspp tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> I don't know what kspp tree is and either I don't know why they didn't
> submit the patch to wireless-drivers-next, so I assume they will handle
> the conflict as well. But I really prefer that they would submit patches
> to wireless-drivers-next instead to avoid unnecessary conflicts like
> this.

This was a treewide replacement with a dependent macro that was supposed
to be merged last cycle at rc1, but $shenanigans. Sorry for the conflict;
I'll make sure it is adjusted or called out for Linus when I send my
tree.

-- 
Kees Cook
