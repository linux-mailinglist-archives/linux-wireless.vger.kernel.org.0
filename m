Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C48419D23
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhI0RoM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhI0RoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 13:44:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6697C00874B
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DmzYsdNrHG1Gdx+gRxN4LjgRXb+ZEQJQnKzHYnq2yac=;
        t=1632763027; x=1633972627; b=SYb0j9HK3w5V2x4jMpP3y3JNr637CDL+/qfdXi5B5Nd3xEZ
        Ts6iem3o+/5HRJ3wuWjRdqwAVQEtduwtbFK/rbD/wgrPohFbGjFV+9O2PErymhuhkGMm4rlKCrTfH
        AyxeRVd1Tz4WSukrXMndsyXsEqr39ejBqrED1vOnsUi/eO5Ukv+sa4z3PF8pF3tEDWxwDSVtiwIY7
        YbSZYsZNx0L+lNoTHH+pjSwijx6BnPiLHm5o3s0zxoNjgd6ia+ZCV/zeOwirDWwZFQJ8H6sXPn4Lg
        RtzcjcxAHMmqHSngPn3aODhGL6JRGjgHqrgvc6KNmxVJdhLFUKNan/OsRlYzIPkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUuFU-00CWEI-Pn;
        Mon, 27 Sep 2021 19:17:04 +0200
Message-ID: <2a2432235cbe51981bfd3d6201c2e803ff6aea7f.camel@sipsolutions.net>
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
Date:   Mon, 27 Sep 2021 19:17:03 +0200
In-Reply-To: <CY4PR21MB1540141B2CF45E93DC5707D18FA79@CY4PR21MB1540.namprd21.prod.outlook.com>
References: <CY4PR21MB15407FF4663D42C8CA3E1D678FD99@CY4PR21MB1540.namprd21.prod.outlook.com>
         <254b35a0eb1e0c68cdc87fa54470c7c079d5dd6e.camel@sipsolutions.net>
         <CY4PR21MB15401F95BAED44381746C11F8FA39@CY4PR21MB1540.namprd21.prod.outlook.com>
         <93c0cb1f0870e7295c0beaf3658febd16882173e.camel@sipsolutions.net>
         <CY4PR21MB1540141B2CF45E93DC5707D18FA79@CY4PR21MB1540.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> You are right, if network managers run both on the host and the guest, they may
> conflict. In our scenario, since we focus on highly integrated VM (such as Windows
> Subsystem for Linux), we avoid the issue by disabling network management in the
> guest. This leave us with only connection requests from programs targeting
> specific networks coming from the guest.

Right, I guess that makes sense. Though I don't know if there even are
any common APIs in Linux, you'd probably have APIs for NetworkManager
and other connection managers, but I'm not aware of a common API that
applications would use.

In fact, I know of very few *applications* that try to do WiFi related
things, mostly those are network managers of sorts. Maybe some would
show scan results, wireshark can set monitor mode and switch channels,
etc. but still...

Are there any specific applications you're thinking of?

> I guess other policies could also be implemented by the host component,
> depending on the degree of control one want the guest to have: either disabling
> the host network manager, or defining some priority and dropping unwanted
> requests...

Right.

> Your initial understanding was correct, network selection in Windows is mostly
> implemented in a OS service (wlansvc), not an application. However, the proxy
> host component is just an application that calls this service public API. So,
> from the point of view of wlansvc and the host OS, the guest is "just" another
> application as far as the Wi-Fi control path is concerned.

Right, makes sense.

> Thanks for explaining for in details, I think I understand better your idea.
> All nl80211 messages being forwarded to the host would indeed add a lot of
> complexity to the host device implementation, a lot of the processing done by
> cfg80211 would likely have to be re-implemented.

The good thing is there *isn't* a lot of processing in cfg80211 to start
with :) OK, there's more now with the 6E scan processing, but still.

> I imagine it would give more freedom to the host device implementation, too.

Agree.

> This could be an interesting alternative if a full-mac based implementation
> ends up being too restrictive.

Well it's kind of "full-MAC" either way - I was just thinking we could
save some code on the guest side :)

But, TBH, it's probably better integrated if we do have a proper driver
there and actually see what's going on and how it interfaces with
nl80211, rather than hiding all those bits in the host (device)
implementation.

> Based on the discussion, your recommendations concerning our initial questions seem to be:
> - we should create a new driver, rather than modifying virt_wifi

Yes, for sure, I don't think virt_wifi makes sense.

> - netlink could be used as a protocol to communicate with the host

That was just a thought really. I've done it before for hwsim's wmediumd
virtio abstraction, and it's not all that bad, but you could just as
well declare structs for communication and go that simple way. Might
over time end up with more compatibility code on the device side though
(assuming you want to keep old Linux kernels running) Ultimately, it
doesn't really matter to us - I'd think of it as a device, and people
come up with all kinds of strange hardware all the time ;-)

(I even once briefly considered ASN.1 for communication with the Intel
NICs :-) )

johannes

