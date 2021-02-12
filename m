Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF80319BB6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBLJSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 04:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhBLJSL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 04:18:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C32C061574
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 01:17:29 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAUZr-001mkb-8o; Fri, 12 Feb 2021 10:17:27 +0100
Message-ID: <c7a976ecb4269a877e20d62319846625c2b1b15c.camel@sipsolutions.net>
Subject: Re: [RFC] Introduce NL80211_IFTYPE_MLO_LINK_DEVICE for MLO link
 (IEEE 802.11be)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     usdutt@codeaurora.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 12 Feb 2021 10:17:26 +0100
In-Reply-To: <058991d5879bd499d4410a851ebd268e@codeaurora.org>
References: <1607526302-8063-1-git-send-email-usdutt@codeaurora.org>
         <9320c4f30cd3ba67ababf8e245963b656e2bf1ad.camel@sipsolutions.net>
         <73cb65ef-8635-5aad-d22d-3764e919f55d@broadcom.com>
         <3ca768c27ba95438b3867c03d17e2cef@codeaurora.org>
         <dab75b5e16e0c1a4b97632e5f4cc3310@codeaurora.org>
         <5e229fce-2468-425f-404b-3a059cac7a94@broadcom.com>
         <058991d5879bd499d4410a851ebd268e@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry for being so late on the thread. Took me far longer than I wanted
to get into looking at MLO at all.

> The switch / change interface among the STA or MLO Link shall happen 
> only in the disconnected state.
> At this point, (in the disconnected state) these MLO Link wdev’s are not 
> linked to the STA interface ( either on the same / different wiphy ).
> These shall be linked after the Association to an MLO AP.
> The intention here is to have the wdev in the right mode ( STA or MLO 
> Link ) before the connect / Association is triggered.
> This wdev is put in to a MLO_LINK_DEVICE, before the connect / 
> association is triggered on the respective MLD (IFTYPE_STA) interface 
> for an MLO connection.
> This wdev is put in the IFTYPE_STA mode, before triggering a connect / 
> association on this interface.
> 
> This should be applicable for different drivers too.
> 
> Please let us know if there are any caveats in this design


Just to summarize, to see if I'm understanding it correctly.

You're basically saying that on the client side

 1) the NL80211_IFTYPE_STATION interfaces becomes the MLD with whatever
    MAC address it may have, and does not maintain its "own" association
    to an AP;
 2) instead, a number of NL80211_IFTYPE_MLO_LINK (let's drop the DEVICE
    it's long enough) are added to it, with appropriate link addresses
    selected for them;
 3) this configuration can only happen while none of them are connected.

Right?

Wrt. MAC addresses, I suppose from our pure software POV the _MLO_LINK
could share a MAC address with the MLD (_STATION), although I hear that
there's still a discussion right now on MLD-addressed and link-addressed 
management frames, so I think we need to wait until we know that for
sure.

A couple of questions:

 1) How do we present this to userspace, is that it? Wouldn't the
    _STATION (MLD) interface ideally still have *some* visible wireless
    state, and show which network it's connected to? It might be very
    awkward to require all userspace tools to be updated to know about
    and query for _MLO_LINKs.

    Obviously, wpa_supplicant needs to be aware of these and can handle
    it just fine, so I'm more concerned about other userspace. After
    all, people still use tools built on wireless extensions

 2) In some ways related to 1), but in other ways also not - perhaps we
    need to anticipate that some devices will want to handle MLO link
    decisions in firmware? I haven't thought about this much at all, but
    if we require separate MLO_LINK type wdevs for each link that might
    be tricky?

 3) I keep thinking about moving much "associated" state into the STA
    struct we maintain in the kernel, and actually maintaining the
    *links* only as "multiple associations". This also gets tricky with
    the link MAC addresses in a way, though that could be handled. It
    might also be an easier way to manage some of that state problem
    from my question 1)?

    Any thoughts on this? I'm definitely not saying this would be easy,
    but would it simplify things regarding the userspace APIs and the
    offload question in 2)?

    Any other designs than the MLO_LINK wdev that you have considered
    and discarded, and if so for which reasons?


> The wdev - NL80211_IFTYPE_MLO_LINK_DEVICE only represents a “MLO Link”
> on the non-AP MLD.This would not be required for an AP MLO.

FWIW, I don't buy the part about this not being required for an AP MLD.

> The following explains our design for AP.
> For AP , NL80211_IFTYPE_AP wdev shall represent both –  AP instance for 
> non-MLO / legacy client and an MLO link for AP-MLD.
> To be specific, For a 2 link AP MLD , there will be 2  NL80211_IFTYPE_AP 
> wdev's created.

This will not work if there's a need (and possibly spec requirement) to
have an MLD address that's different from *all* the link addresses. It
will also be difficult to manage that one of the AP interfaces would
have to be defacto the MLD, but (at least in theory) any one of the AP
interfaces could be removed for 'degraded' operation.

I suspect will also not work right if you want to have AP_VLAN on the AP
MLD.

IMHO it'd be better for things to be symmetric like you suggest for the
client side.

Now, I can see the need for legacy interoperability, but then it seems
it would probably be better to do this the other way around and declare
a new AP_MLD interface type (with a netdev) that doesn't maintain its
own beacons etc. but just has its own MAC address (the AP MLD address)
and bubbles up the data frames exchanged on the MLD.

> Both these wdev’s shall represent the MLO Link for an AP-MLD and each 
> also represent an AP instance for the non-MLO / legacy client’s to 
> connect.

Yeah, don't think that works, see above.

> MLO Link MAC address will be the MAC address of respective AP’s 
> (netdev/wdev).

Same here. Note that there may be a requirement, or at least a very
strong incentive, to have an MLD address different from all the links,
and we cannot preclude that in the design even if it doesn't become a
requirement.

> With this proposal, We plan to extend this for MLO too, by reusing this 
> NL80211_IFTYPE_STATION wdev to represent the “association link” for an 
> MLD connection
> and new wdev type - NL80211_IFTYPE_MLO_LINK_DEVICE to represent the 
> additional links of the same MLD connection.

Wait, ok, this is *not* how I understood the proposal above.

Again, I don't think this works for the same reasons I outlined on the
AP case - symmetry, links coming and going, and MAC addressing.

johannes

