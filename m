Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6564165EA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 21:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbhIWTVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 15:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242837AbhIWTVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 15:21:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB791C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=u02k0wx5/QZ3xMXkVuS41KTxRu1YfQsY1h8tFx9+Ahw=;
        t=1632424774; x=1633634374; b=LKlNluaLyWR0TMtoAzpG1qnyvGaA7Krvva3y8x2QTPUmvr5
        1BkUOqt5w6jVFHAqkikz4eyCcct5Z4QNWaOiccl/fF/AjZXGVqfL1GQuwrD1+9f5PFZxdzznrVG80
        dxnibWt1vn6/v187v3nC+uof4EPWmhSHsW9FbmcnskNbyDQ9S9qC/wc5QPHiBDEEgkTXuJzhqSUJ0
        5piP7GCSHlbwbqL1MRZmZ41+SePVeSN5hEkJc3pi8rEf4raYjjKB9fNod89pTRxY85jeCPCoy/mZQ
        //cJCSqkM8A35wZ/CgEFxvHQAba3Rz1OlemdF89Kikh8dW1/YRTkSkfzTbqbmSbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTUFn-00AsUC-Fp;
        Thu, 23 Sep 2021 21:19:31 +0200
Message-ID: <93c0cb1f0870e7295c0beaf3658febd16882173e.camel@sipsolutions.net>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 1/1] Add control path virtualization
 in virt_wifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Guillaume Hetier <Guillaume.Hetier@microsoft.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "schuffelen@google.com" <schuffelen@google.com>,
        Shwetha Bhat <shwbhat@microsoft.com>,
        Andrew Beltrano <anbeltra@microsoft.com>,
        Brian Perkins <Brian.Perkins@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Matteo Croce <mcroce@microsoft.com>
Date:   Thu, 23 Sep 2021 21:19:30 +0200
In-Reply-To: <CY4PR21MB15401F95BAED44381746C11F8FA39@CY4PR21MB1540.namprd21.prod.outlook.com>
References: <CY4PR21MB15407FF4663D42C8CA3E1D678FD99@CY4PR21MB1540.namprd21.prod.outlook.com>
         <254b35a0eb1e0c68cdc87fa54470c7c079d5dd6e.camel@sipsolutions.net>
         <CY4PR21MB15401F95BAED44381746C11F8FA39@CY4PR21MB1540.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Guillaume,

> Our target is to give the guest VM a similar level of control over WiFi as
> other applications on the host.  The host OS keeps control of the NIC. Requests
> from the guest are executed through calls to public host wlan APIs and the
> result is returned to the guest driver.

That makes some sense. I say some intentionally though, because consider
the differences - a typical application on the host will definitely not
care (even the browser, skype, etc. will not), unless they specifically
want to do something with wifi such as for IOT onboarding or whatnot.

A typical guest VM on the other hand will run a pretty typical operating
system, and that *will* "care", in the sense that it always wants to use
and control a wifi device (if present).

This might just mean that it's continuously scanning for networks it
knows about and can connect to, or it might mean that it's actually
connecting to the networks that it knows about. The host, on the other
hand, might have its own ideas about which networks you should be
connected to? I fear that having both of this might conflict, so I was
curious how you'd be solving that.

> Since the host keeps control of the NIC, it handles multiple things trying to
> use WiFi the same way it handles different host applications trying to use Wi-Fi.
> This means the host OS can reject a command from the guest, or that the guest
> VM could get disconnected if another program on the host initiates a connection
> to a different Wi-Fi network.

Right.

I *think* that to some extent I'm actually thinking of "OS" vs.
"applications" in too strict a separation, and on Windows it might
actually be that the part of the OS that implements the wifi network
selection is "just" an application? A la Intel ProSet (not that I know
anything about it)?


> Agreed, only one half doesn’t make a lot of sense.  We are in the process of
> making our Windows host proxy implementation open source. It should be a matter
> of days now.  I will send an update with a link when it is available.

Oh, that's nice. I wasn't really even expecting that :)

> Using netlink seems a great idea, thanks for the suggestion! :)
> 
> We also considered forwarding nl80211 messages directly, since it could avoid
> the need for a specialized guest driver.  However, we wondered about
> compatibility issues (what if the host and guest versions of nl80211 don’t
> match?), and it seemed much more complex to implement, with significant changes
> to cfg80211 and likely other parts of the wireless subsystem.  Overall, the
> nl80211 forwarding option appears architecturally sound, but given the much
> larger scope and impact, we focused on a more targeted solution in which the
> guest driver doesn’t own the host NIC.  We feel this solution provides a middle
> ground where the host can decide which parts of its wireless stack to proxy to
> the guest.

Ah, that's interesting. I had only considered this for the *guest*, and
assumed that the host would handle the (nl80211) messages in a special
device implementation software, not forward those directly to the host
(Linux) kernel.

It sounds like you considered the case of basically letting the guest
applications direction talk nl80211 to the host kernel, which is far
beyond what I considered!

I completely agree here though - you definitely want some proxy on the
host side.

But like I said, I was just considering that as the guest side
implementation. We don't have machinery for this right now in netlink,
but I could see perhaps some way of allowing "pre_doit" to return say
"1" to say "we abort here but please don't send a response to
userspace". Then, the pre_doit() could call a driver method passing the
nl80211 message down instead of calling the real operation, and the
application using nl80211 would end up directly talking to the nl80211
implementation of the device.

I don't think the device _could_ even implement it by talking to the
host kernel (even if it is Linux) because the netdev IDs and whatnot
would be different, but it might be feasible for the guest
implementation.

The only place where this might run into trouble is with things that
nl80211 supports (enum nl80211_protocol_features), which we handle
directly, and so an updated guest kernel might support more than would
actually end up working. But the truth is that we added _exactly_ one
such feature (NL80211_PROTOCOL_FEATURE_SPLIT_WIPHY_DUMP), and wiphy
discovery is of course something that would anyway have to be handled by
the guest. So not sure this is such a big deal.

Anyway, not saying it should be done one way or the other, was just
considering this as one possible way of simply pushing _all_ the APIs
though to the device, and then the nl80211 implementation in the device
can decide what it supports and whatnot, just like on older kernels we
don't support certain things. The *driver* would then be fairly simple
and basically would never have to be extended, but the device
implementation (in the hypervisor or wherever) might be more difficult.

johannes

