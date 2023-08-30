Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B378D9B6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbjH3Sdx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242367AbjH3IQR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:16:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E7113
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7ZGIkWYtLAfN7ngsmiHjLJnMDejwN1pq/NeKM7qFqKk=;
        t=1693383374; x=1694592974; b=WvIn0RLoaqXUQTYMJHWxteTQpMmhag4WrRMWcimAs82Qcbf
        Q25ghYRHwgFzdebYMg6STJepyh0EAsmpdSmiQscjAB2j2V1wHPF9owqlHRxGZCpotVe0NbOfsQ1am
        hJkAu6iltS4Jy8TSWGHHfdC9KbQ1wvVsBHjLboEfWG9UxlAdI5ryofa4rnpVKy/F8n7mAjJfbMxNr
        Wy75uhP+0lh8KbEPXhL9/yUvCYCimFsATsN8ensQ0LfjmjJH4NUKblJzI7y365JkZZE4cftA3P3o9
        lc+audRLOq3E28g55/YVJYeWclvJ+i9oWr1ZVYzqnUgqvJPmCC/ZSmt8ym0wdvkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qbGN2-002q93-2Z;
        Wed, 30 Aug 2023 10:16:13 +0200
Message-ID: <c59ef59389630656fc5d2b6ac65cc1fab590b893.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix BA session teardown race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Koen Vandeputte <koen.vandeputte@citymesh.com>
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Date:   Wed, 30 Aug 2023 10:16:11 +0200
In-Reply-To: <CAPh3n808FmLxYzvp2=iNX5RAfdGKe57O2yGSXS9zKhSz_bPhhw@mail.gmail.com>
References: <20230829201610.cc648236f434.I205a557b06a27f58afe3880f4db43d554210c88d@changeid>
         <CAPh3n808FmLxYzvp2=iNX5RAfdGKe57O2yGSXS9zKhSz_bPhhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-30 at 09:06 +0200, Koen Vandeputte wrote:
> Hi Johannes,
>=20
> I'm running OpenWRT on an AP device and noticed following splat when a
> fair amount of clients was connected to it (roughly 20)
> Do you think this one is affiliated with this patch?

Did you pull this patch in? It's not applied _anywhere_ yet, unless you
did?

Or are you asking if this could be _fixed_ by this patch?

> [   45.032441] WARNING: CPU: 2 PID: 1654 at
> backports-6.1.24/net/mac80211/driver-ops.h:611
> __ieee80211_flush_queues+0x168/0x16c [mac80211]
> [   45.036137] wlan1.sta4: Failed check-sdata-in-driver check, flags: 0x1
[...]
>    45.141905] CPU: 2 PID: 1654 Comm: hostapd Not tainted 5.15.127 #0
> [   45.147557] Hardware name: Generic DT based system
> [   45.153753] [<c030d480>] (unwind_backtrace) from [<c0309848>] (show_st=
ack+0x10/0x14)
> [   45.158523] [<c0309848>] (show_stack) from [<c05dd924>] (dump_stack_lv=
l+0x40/0x4c)
> [   45.166414] [<c05dd924>] (dump_stack_lvl) from [<c0322540>] (__warn+0x=
8c/0x100)
> [   45.173792] [<c0322540>] (__warn) from [<c032261c>] (warn_slowpath_fmt=
+0x68/0x78)
> [   45.180996] [<c032261c>] (warn_slowpath_fmt) from [<bf25b63c>] (__ieee=
80211_flush_queues+0x168/0x16c [mac80211])
> [   45.188780] [<bf25b63c>] (__ieee80211_flush_queues [mac80211]) from [<=
bf228ec8>] (sta_set_sinfo+0xd44/0xe64 [mac80211])
> [   45.198951] [<bf228ec8>] (sta_set_sinfo [mac80211]) from [<bf229230>] =
(sta_info_destroy_addr_bss+0x44/0x5c [mac80211])
> [   45.209456] [<bf229230>] (sta_info_destroy_addr_bss [mac80211]) from [=
<bf1a5000>] (nl80211_del_station+0xe0/0x2b4 [cfg80211])
> [   45.220271] [<bf1a5000>] (nl80211_del_station [cfg80211]) from [<c080a=
818>] (genl_rcv_msg+0x154/0x340)
> [   45.231538] [<c080a818>] (genl_rcv_msg) from [<c08098e8>] (netlink_rcv=
_skb+0xb8/0x11c)
> [   45.240718] [<c08098e8>] (netlink_rcv_skb) from [<c0809f24>] (genl_rcv=
+0x28/0x34)
> [   45.248619] [<c0809f24>] (genl_rcv) from [<c0808fb0>] (netlink_unicast=
+0x174/0x26c)
> [   45.256170] [<c0808fb0>] (netlink_unicast) from [<c0809284>] (netlink_=
sendmsg+0x1dc/0x440)
> [   45.263641] [<c0809284>] (netlink_sendmsg) from [<c0782878>] (____sys_=
sendmsg+0x1d0/0x224)
> [   45.271974] [<c0782878>] (____sys_sendmsg) from [<c0784308>] (___sys_s=
endmsg+0xa4/0xdc)
> [   45.280220] [<c0784308>] (___sys_sendmsg) from [<c0784470>] (sys_sendm=
sg+0x44/0x74)
> [   45.288110] [<c0784470>] (sys_sendmsg) from [<c0300040>] (ret_fast_sys=
call+0x0/0x48)

That stack doesn't look quite right - __ieee80211_flush_queues() isn't
called from - or what looks like inlined into - sta_set_sinfo()?

So I think I don't believe the part about __ieee80211_flush_queues(), it
makes more sense for sta_set_sinfo() to call drv_sta_statistics() which
would also make more sense with the line number (611) which is at least
in my version close to the line there. Not sure what wifi code you're
using, so can't check the exact line, I guess.

But either way, I wouldn't think it could be fixed or broken by this
patch.

johannes
