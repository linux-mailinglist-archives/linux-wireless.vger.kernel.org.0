Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F5E4E315E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353070AbiCUUJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 16:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353007AbiCUUJm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C410876B
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1z7QvDxYKRxkE9hrxM7O6W3REzHeduSoZ8ywLXfF33o=;
        t=1647893282; x=1649102882; b=FOPk4RnrA0HAWi0++HNzqBtHoIpV3D19w1ZHsWDevq1fsb9
        FuO+vt29gZH2Eil9kOueWRKhq8BIMNZnQajdUBnooJGAdvvotsx2udf11b3zM+J3/LbUyrPhaz4mh
        liDNn6EMvqOnMbZTIhtjAlGShDTZapxOuEHsQaiNuqqPBMbo6ZP490/O7+4d57edMex5J6w/AtABk
        nkl85p8kSouCwFIo/LVvsP9o6fV8RZAgmDqCQoXt6FaPdKLvRSvkvsvwd/h2pWPze5yhkxoL6w2AJ
        PYbNN3l4i0ZvtGs1KkzZ9lN1vAqBCkv1Vcj7VPZ7PeUbbmMvCNQ1YeuIVGmPSecA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nWOJq-00GKv3-SA;
        Mon, 21 Mar 2022 21:07:58 +0100
Message-ID: <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     willmcvicker@google.com, linux-wireless@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 21 Mar 2022 21:07:57 +0100
In-Reply-To: <0000000000009e9b7105da6d1779@google.com>
References: <0000000000009e9b7105da6d1779@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
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

Hi,


> Basically, my wlan driver uses the wiphy_vendor_command ops to handle
> a number of vendor specific operations.
> 

I guess it's an out-of-tree driver, since I (hope I) fixed all the
issues in the code here ... :)

> One of them in particular deletes
> a cfg80211 interface.

There's quite normal API for that, why would you do that?!

> The deadlock happens when thread 1 tries to take the
> RTNL lock before calling cfg80211_unregister_device() while thread 2 is
> inside nl80211_pre_doit(), holding the RTNL lock, and waiting on
> wiphy_lock().
> 
> Here is the call flow:
> 
> Thread 1:                         Thread 2:
> 
> nl80211_pre_doit():
>   -> rtnl_lock()
>                                       nl80211_pre_doit():
>                                        -> rtnl_lock()
>                                        -> <blocked by Thread 1>
>   -> wiphy_lock()
>   -> rtnl_unlock()
>   -> <unblock Thread 1>
> exit nl80211_pre_doit()
>                                        <Thread 2 got the RTNL lock>
>                                        -> wiphy_lock()
>                                        -> <blocked by Thread 1>
> nl80211_doit()
>   -> nl80211_vendor_cmd()
>       -> rtnl_lock() <DEADLOCK>

Yeah, I guess the way we invoke vendor commands now w/o RTNL held means
you cannot safely acquire RTNL in them.

I mean, the whole above thing basically collapses down to

 Thread 1                           Thread 2
  wiphy_lock(); // nl80211
                                     rtnl_lock();
                                     wiphy_lock();
  rtnl_lock();  // your driver

The correct order to _acquire_ these is rtnl -> wiphy, and we do it that
way around everywhere (else).

> I'm not an networking expert. So my main question is if I'm allowed to take
> the RTNL lock inside the nl80211_vendor_cmd callbacks?

Evidently, you're not. It's interesting though, it used to be that we
called these with the RTNL held, now we don't, and the driver you're
using somehow "got fixed" to take it, but whoever fixed it didn't take
into account that this is not possible?

> I hope that helps explain the issue. Let me know if you need any more
> details.

It does, but I don't think there's any way to fix it. You just
fundamentally cannot acquire the RTNL in a vendor command operation
since that introduced the ABBA deadlock you observed.

Since it's an out-of-tree driver that's about as much as I can help.

johannes
