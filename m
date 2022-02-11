Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A644B2367
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 11:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiBKKib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 05:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBKKib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 05:38:31 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D12CFC
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 02:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Fl0eNnmXT8M5cyHanWWZyfrNBNskU2kGw6mvZpff3QY=;
        t=1644575909; x=1645785509; b=jdEjMB0+KDofMM4SXpzZCkRYS6WbJFurmxpIH9rNWM1WiSx
        aiogZmko0ml0LHxLBJQwa5910qXeqXZNutdAwiVCEPAFAZHbxu0we6V9SfoX7InRie1AjPpPS2TJw
        t6Ho+oplTNIR7sBSrWn1GmypObcOLwt/RvJbYOa3R7ygtNlpK+fb12xbH1i4LA0YgXMNVBXmQ8zli
        RAMTRC3keNKZJu6ThEXYTGGxz10tF4r4FDXs0s+xgB65MKWTvtpb/tsqDQ5a8fYRLVzKtVfKb250G
        TuH1JPSAFZiM2RMCyk+Ed24vHyWQELGSpc+Vdm8Puhu0BXBZfCLpR0OIgvUV5X7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nITJr-00HSdb-2H;
        Fri, 11 Feb 2022 11:38:27 +0100
Message-ID: <a3d73398fa51b66e77d98cf1e883c72b66d6a3f4.camel@sipsolutions.net>
Subject: Re: locking in wiphy_apply_custom_regulatory()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 11 Feb 2022 11:38:26 +0100
In-Reply-To: <6562d8c3-27f6-490a-7732-6c300eb3aa64@broadcom.com>
References: <6562d8c3-27f6-490a-7732-6c300eb3aa64@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

> I stumbled upon locking in wiphy_apply_custom_regulatory() and the 
> history of commits make it a bit unclear to me if these locks are all 
> really needed.

Oh how I like the regulatory code ... ;)

> beee246951571 added the rcu assignments without any locking.

Well that was just plain wrong, right?

You have to have some kind of writer-side locking with RCU.

I think this probably was assuming we'd be under some locks already?

In regulatory_set_wiphy_regd() vs. regulatory_set_wiphy_regd_sync() we
later formalized this.

> 51d62f2f2c501 added the rtnl locking.

That was the bugfix.

> a05829a7222e9 added the wiphy lock.

Yes that's because now get_wiphy_regdom() can be called as documented:

/*
 * Returns the regulatory domain associated with the wiphy.
 *
 * Requires any of RTNL, wiphy mutex or RCU protection.
 */


> My understanding of RCU operations was that locking is only needed for 
> readers,
> 

No, readers are lockless (just "rcu_read_lock()" which enters a critical
section, but no locking).

>  but here we use not one but two mutex locks which makes me 
> wonder. Especially, as this function is called before registering the wiphy.
> 
> Could you clarify?
> 

Like I said above, that's because we want to dereference the pointer in
three different contexts:
 * RCU
 * RTNL
 * wiphy mutex

Maybe we can get rid of some of those readers, but e.g. iwlwifi is using

	wiphy_dereference(mvm->hw->wiphy, mvm->hw->wiphy->regd);

which really should use get_wiphy_regdom(), but I'm not sure is holding
the RTNL in all paths? Looking at them, it seems like it is, so perhaps
we can get rid of the wiphy mutex locking.


Why are you asking? :)

johannes
