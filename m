Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712874653F6
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351879AbhLARd0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 12:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhLARdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 12:33:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6CCC061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3+enRW4wqvxQSzs2ckAuZdLgTzu8Rxf6BfXjB+5YXoI=;
        t=1638379804; x=1639589404; b=lu8ZoCajPlRMDIYuWR2wvSZRLsps1m7F63960AdI++i82H9
        mcKd1O5q1UdH80nyukBAaph37nSziMe45vVormOl6LsW/mDDYpNv+s4KofAr1ZZVNFLlVqIwb8L49
        2BqX0h0EGXQoYN5WNWszJhSwu+Hwz6qP4k1SQS7lWsPD/4tzO7OoIyAc+kcz/Nbs5LJamZ2GkZuRB
        BiI6Q1ekJE9mMyZOcoGn3NVXoCKnXTY25XZQgptR5qbHravIuGmGbXIWmjjk/KhcDnuriY0AoMeGs
        Y9rRiOjckDS9lXAOirKKW4VlNOES68oe5lyjyLxu2Jy0F6dXBmePAAWzFbx3QQRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1msTQU-005Vc0-PL;
        Wed, 01 Dec 2021 18:29:50 +0100
Message-ID: <17ccfc4f9f9e74e1d6b48366a87cbcf887521dab.camel@sipsolutions.net>
Subject: Re: [linux-next:master 3615/4301]
 include/linux/compiler_types.h:335:45: error: call to
 '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Date:   Wed, 01 Dec 2021 18:29:49 +0100
In-Reply-To: <202112010840.0AD4D41162@keescook>
References: <202111302102.apaePz2J-lkp@intel.com>
         <87pmqgsrcq.fsf@codeaurora.org> <202112010840.0AD4D41162@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-12-01 at 08:41 -0800, Kees Cook wrote:
> 
> > >    drivers/net/wireless/marvell/libertas/tx.c:116:9: note: in expansion of macro 'BUILD_BUG_ON'
> > >      116 |         BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
> > >          |         ^~~~~~~~~~~~
> > 
> > Kees, can you take a look at this build error? You added the
> > BUILD_BUG_ON(), right?
> 
> I will investigate! Given this doesn't happen on allmodconfig but
> a randconfig trips it, this might be finding a legit issue, but I'll
> report back more details.
> 

It's probably some alignment thing - note it happened on a specific ARM
with a specific compiler?

But there's not really a good reason to even have the struct_group here,
we only use it as if it was

	u8 tx_dest_addr[ETH_ALEN];

anyway?

johannes
