Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901B41AB2AD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 22:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636973AbgDOUcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 16:32:36 -0400
Received: from mail.w1.fi ([212.71.239.96]:55072 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2636955AbgDOUcT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 16:32:19 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 16:32:17 EDT
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 5FCA111D5F;
        Wed, 15 Apr 2020 20:23:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GdxQDhMDuwkT; Wed, 15 Apr 2020 20:23:45 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 15 Apr 2020 23:22:42 +0300
Date:   Wed, 15 Apr 2020 23:22:42 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: ath9k/mac80211 wrong hw RX filter? - tests, dpp_pkex* failed
Message-ID: <20200415202242.GA12825@w1.fi>
References: <CAFED-j=LrpURGKYwHd8Pmdo633nNb9mR4XmmPGNv-dhvBZQR+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFED-j=LrpURGKYwHd8Pmdo633nNb9mR4XmmPGNv-dhvBZQR+w@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 21, 2020 at 03:04:27PM +0100, Janusz Dziedzic wrote:
> Just check dpp_pkex* test cases in my remote test environment (ath9k
> devices) and seems by default fail:
>  - supplicant using remain_on_channel here
>  - we don't receive broadcast action frame(s) (PKEX exchange request)
>  - I suspect HW rx filter configuration don't work correctly here

Yes, that's correct and thanks for the reminder. I had this in my queue
somewhere, but never got as far as figuring out what exactly should be
done to resolve this.

> In case will add monitor interface to the iface that ath9k station
> using, test case always pass (we receive this action frame(s) when
> remain-on-channel).

It does not actually need to be a monitor interface, i.e., any
additional vif that is up should be sufficient.. The key point here is
in getting ath9k to include ATH9K_RX_FILTER_MCAST_BCAST_ALL in the RX
filter configuration. That happens if nvifs > 1 or FIF_OTHER_BSS is
included (the former is based on multiple vifs and the latter is based
on mesh being used).

> Seems we pass this for hwsim, but I suspect we don't use hwsim filters?

mac80211_hwsim does not filter out frames in the same manner as most
hardware designs do on the RX path.

> I see that wpa_supplicant register different action frames and finally
> we configure this in mgmt_frame_register() next
> ieee80211_mgmt_frame_register().
> Do we miss some functionality here (in mac80211) or this is pure ath9k bug?

It's more of an undefined behavior.. DPP happens to be the first (and
currently only) used of broadcast Public Action frames and it looks like
number of WLAN designs filter such frames at one (or even multiple)
points in the stack since there was no need to waste power in processing
them.

We don't currently have any means for user space to indicate that it
would be nice to be able to receive broadcast Public Action frames
(i.e., Management frames that are sent outside the context of an
association with A1=A3=ff:ff:ff:ff:ff:ff). Since delivery of such frames
to upper layers may require some designs to enable promiscuous RX
behavior, this can result in undesired use of power in some devices and
as such, it would be nice to be able to do this only when there is a
known user for such frames (e.g., DPP listen mode enabled). That ath9k
case of ATH9K_RX_FILTER_MCAST_BCAST_ALL may not be that expensive, but
other drivers might need to enable full promiscuous receive and drop
significantly larger number of undesired frames in mac80211 to have a
noticeable impact.

If we were to add that user space registration for broadcast Public
Action frames, we could then handle that in mac80211 by adding a new
enum ieee80211_filter_flags value (e.g., FIF_BROADCAST_PUBLIC_ACTION)
and have ath9k map that to ATH9K_RX_FILTER_MCAST_BCAST_ALL.
wpa_supplicant would then use this new registration mechanism based on
when it expects to be able to receive DPP frames (i.e., when DPP_LISTEN
is in progress).

> Interesting, that 'monitor trick' doesn't work for intel-ax200.

It should be noted that the frames can be dropped at other layers as
well. There are WLAN firmware designs that drop these frames and make
those cases work with DPP PKEX is likely going to require a firmware
change.. Furthermore, the exact trick depends on the driver (that nvifs
being larger then one in case of ath9k), so it is not surprising to see
different behavior.. As another example, AR9170/carl9170 seems to work
without any such tricks and same is the case for ath10k with firmware
builds that enable this case explicitly for DPP.

Anyway, it would be good to add this registration mechanism for
broadcast Public Action frame RX to fix the known cases (at least ath9k
and ath9k_htc) and to make this details about DPP more explicitly
documented and known for others to find and address in driver or
firmware design for RX filtering.

-- 
Jouni Malinen                                            PGP id EFC895FA
