Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D7413026
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhIUI3U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhIUI3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 04:29:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED577C061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Sep 2021 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+1u3slR8feQfzrYEXmtjSQGq4NBoB8RDUf/f6ZCpZBw=;
        t=1632212872; x=1633422472; b=ChgpB+6/gEZMVNpKFheiBmq3aZCe79MQ2yvtQmFFbGLyHi9
        II8pt1bXOgUYM5VGDofGePCuN5v3EQFf++uLxptRRbQnurAIgLM0HmSgbYc3robWm2A3Z1yLiBP9M
        U/cOCrHGVDhINnG3puo3GkGZQ9HJY9JIHGHw3hJIKKyfNhM3a1kh3GqKpNgzKflNyzE4L62URmWnp
        SrnFf+80bFW7ttvBSOMB6BjXER6ptjl1GeqxhxigB085J2/tEzNwilTUjq2iGCEniqMHngdxxusls
        b2rhZE2IVajk07+iG0vPYIMlXVzXEpvICxt+iZu6NUYqoD1xtcrTP5nOxNSUMIEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSb7V-009mjH-GO;
        Tue, 21 Sep 2021 10:27:17 +0200
Message-ID: <254b35a0eb1e0c68cdc87fa54470c7c079d5dd6e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/1] Add control path virtualization in virt_wifi
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
Date:   Tue, 21 Sep 2021 10:27:15 +0200
In-Reply-To: <CY4PR21MB15407FF4663D42C8CA3E1D678FD99@CY4PR21MB1540.namprd21.prod.outlook.com>
References: <CY4PR21MB15407FF4663D42C8CA3E1D678FD99@CY4PR21MB1540.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2021-09-13 at 21:03 +0000, Guillaume Hetier wrote:
> Today, there is no solution for Wi-Fi control path virtualization in a Linux
> virtual machine.  
> 

True :)

I guess I knew this was eventually inevitable, but it's also really
difficult, depending on what you're trying to do?

But then, how exactly are you trying (or going to try) to use this? In
lieu of assigning the entire NIC to the VM, replacing PCI passthrough?
Or perhaps somehow in addition to the host system (I guess in Hyper-V
lingo that'd be the root partition?) using the WiFi as well?

I suppose the guest doesn't really need to care, but on the host having
multiple things try to use WiFi would be difficult - e.g. if the host
supports only a single client interface, what should happen?

IOW, I think I'm more concerned about the *host* implementation than the
*guest* implementation.

From the guest side, we could basically treat it like any other
"fullMAC" device, not use mac80211, and poke the cfg80211 APIs more or
less directly out into the hypervisor.

Of course, you could argue that I don't need to care, but it feels odd
to be adding something here where we don't know how to implement the
other side.


[snip]

> For where the feature should live, we are considering two main options: 
> 
> - Integrating our changes with virt_wifi. 
> 
>   This is what we have done until now, since virt_wifi already handles the data
>   path and implements the set of cfg80211 operations we want to virtualize: we
>   directly reuse most of the driver rtnetlink setup. We also believe we
>   strictly extend the capability of virt_wifi, since the proxy can send
>   simulated data to achieve the current behavior.  However, our handling of the
>   operations has significantly diverged from the original version, and backward
>   compatibility must be preserved (which is not done in this patch).  If we go
>   this way, the driver will have to keep a balance between its simulation and
>   virtualization half, potentially leading to conflicts in the future.

To me, the bigger argument against this is that virt_wifi necessarily
piggy-backs on another (ethernet) netdev, and is completely virtual, in
the sense that you can create any number thereof, etc.

Whereas a driver for a para-virtualized ("enlightened", if I get the
Hyper-V lingo right) WiFi NIC would want to auto-probe, etc.

> 
> - Creating a new Wi-Fi virtualization driver.
> 
>   We could contribute a new Wi-Fi driver, focused entirely on Wi-Fi
>   virtualization. We believe it would be generic enough to be useful to the
>   virtualization community at large, and it would have a clear goal instead of
>   keeping a balance between simulation and virtualization. This would also
>   avoid any issue related to compatibility with the existing virt_wifi.
>   However, this means adding a driver relatively similar to virt_wifi to the
>   kernel.
> 
> We are currently leaning toward the second option. We think having
> virtualization as a clear, unique, goal and avoiding potential compatibility
> issue is worth a new driver, especially considering the code could diverge
> further.

I agree.

> For the message format, we have been using a custom binary format for
> prototyping. However, this format will break compatibility every time a message
> needs to be extended or modified. We are considering several options:
> 
> - adding versioning to messages. This is easy to do, but the complexity would
>   increase with the number of versions support is needed for.
> 
> - using a more extensible format such as TLV. This would add some overhead to
>   parse messages, but scale better with subsequent extensions, if we expect
>   them to be somewhat frequent.
> 
> Are there existing recommendations or a standard way to solve this in the
> kernel?

Netlink? Though I'm probably the only one to have ever transported
netlink over virtio (in hwsim).

I'm almost joking, but it's not really a bad format, and it has a lot of
helper code already to format and parse messages, both in the kernel and
in userspace, should one want to implement the device side (on the
host/hypervisor).

Might even be feasible to just pass nl80211 through somehow? Hmm.
Perhaps not? Haven't thought hard about it, but in a way it'd be nice,
then we wouldn't need any new code in the driver for new features, we'd
have all the bits in nl80211 already ...

johannes

