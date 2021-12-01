Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91AD465698
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352692AbhLATlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 14:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbhLATlN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1301C061757
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IcOhZQ70CoYW6JIlj+gzuBZuD6zEZA8xPOcenJenpxw=;
        t=1638387471; x=1639597071; b=wViRTzA/AlsbzaPTgX569kOQMQAgxHLfmk7Bvd2URBPWSnv
        K8JKRw4WbHqzAlrzWc4JxQFrj5OeK6jHD8ZsiMs4So0UNEAILdYWrfED5W9hMP5ZLp+QGP6vNnhG4
        JKmX68ZI5ydNrTmEVa4UyZJ5iT6FgS25N3iuURGmZLEwL1lLkXhAg6ch587WFFU9D/y0CAeM5N4r6
        SEVyQ6Au4mQP4HFLsSPxiqI2buyEARVghF8nJeTBaQHSGYzzSLufcRuB66dxpKioXyUE54csMuttx
        lNTfi1PvchUZeb6+km8yQA9ruotwINZ4380Evg00AIcXCRIU60vz/lAeR/zVYJyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1msVQD-005Yhj-5V;
        Wed, 01 Dec 2021 20:37:41 +0100
Message-ID: <86e341519e1e7424a1f46fef23ec88a4d48f87c9.camel@sipsolutions.net>
Subject: Re: [linux-next:master 3615/4301]
 include/linux/compiler_types.h:335:45: error: call to
 '__compiletime_assert_314' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(txpd->tx_dest_addr) != ETH_ALEN
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-wireless@vger.kernel.org
Date:   Wed, 01 Dec 2021 20:37:40 +0100
In-Reply-To: <202112011059.1F60C79D@keescook>
References: <202111302102.apaePz2J-lkp@intel.com>
         <87pmqgsrcq.fsf@codeaurora.org> <202112010840.0AD4D41162@keescook>
         <17ccfc4f9f9e74e1d6b48366a87cbcf887521dab.camel@sipsolutions.net>
         <202112011059.1F60C79D@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-12-01 at 11:04 -0800, Kees Cook wrote:
> On Wed, Dec 01, 2021 at 06:29:49PM +0100, Johannes Berg wrote:
> > On Wed, 2021-12-01 at 08:41 -0800, Kees Cook wrote:
> > > 
> > > > >    drivers/net/wireless/marvell/libertas/tx.c:116:9: note: in expansion of macro 'BUILD_BUG_ON'
> > > > >      116 |         BUILD_BUG_ON(sizeof(txpd->tx_dest_addr) != ETH_ALEN);
> > > > >          |         ^~~~~~~~~~~~
> > > > 
> > > > Kees, can you take a look at this build error? You added the
> > > > BUILD_BUG_ON(), right?
> > > 
> > > I will investigate! Given this doesn't happen on allmodconfig but
> > > a randconfig trips it, this might be finding a legit issue, but I'll
> > > report back more details.
> > > 
> > 
> > It's probably some alignment thing - note it happened on a specific ARM
> > with a specific compiler?
> 
> Yup, that was it. It's an interesting bit of "accidentally correct"
> problems that I think I've now fixed with this series:
> https://lore.kernel.org/all/20211201173234.578124-1-keescook@chromium.org/

Yeah, I saw that like the minute after I sent this response :)


> > But there's not really a good reason to even have the struct_group here,
> > we only use it as if it was
> > 
> > 	u8 tx_dest_addr[ETH_ALEN];
> > 
> > anyway?
> 
> Ah yeah, nothing uses tx_dest_addr_high nor tx_dest_addr_low. Should I
> send another patch to just rip out the struct_group entirely?

I have no strong feelings either way, it's a pretty old driver by now,
likely nobody will touch it :)

johannes
