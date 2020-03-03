Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9F177850
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgCCOI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 09:08:57 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55824 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbgCCOI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 09:08:56 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j98E9-00CswX-W6; Tue, 03 Mar 2020 15:08:54 +0100
Message-ID: <da15dc015f2992a702cc585c510e009a83b8fdb1.camel@sipsolutions.net>
Subject: Re: Any reason AID is not in the NL80211_STA_INFO enumeration?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 03 Mar 2020 15:08:51 +0100
In-Reply-To: <29006a9e-4de2-1733-1a8a-a5aae686fd42@candelatech.com>
References: <5E4B39B2.8050905@candelatech.com>
         <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
         <29006a9e-4de2-1733-1a8a-a5aae686fd42@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-02-28 at 07:26 -0800, Ben Greear wrote:
> 
> On 02/28/2020 02:06 AM, Johannes Berg wrote:
> > On Mon, 2020-02-17 at 17:11 -0800, Ben Greear wrote:
> > > To sniff /AX stations, it is helpful to know their AID.  So, any problems
> > > with adding it to 'iw station dump' output?
> > 
> > No, no problem at all. I guess it was just never added because it
> > originally comes from userspace (hostapd), and so didn't really need to
> > be sent back. But yeah, we have trivial infrastructure to send it back,
> > so sure, why not.
> 
> Ok, thanks for the response.
> 
>  From looking at debugfs for a station device, there is the netdev AID:
> 
> cat /debug/ieee80211/wiphy0/netdev\:wlan0/aid
> 1
> 
> And there is a peer AID:
> 
> cat /debug/ieee80211/wiphy0/netdev\:wlan0/stations/04\:f0\:21\:c2\:fd\:b0/aid
> 0
> 
> For sniffing AX, I'd need to use '1' here as far as I can tell.  Maybe for station
> devices the peer is always zero?  And for AP devices, the peer IDs are what is useful
> and the netdev AID is not?

Yeah. The first is u.mgd.aid (i.e. the netdev data), and the latter is
the STA AID.

It makes sense the latter is not assigned in the client-side case.

Arguably, only the *latter* should be in nl80211 per STA, since in the
client-side case it's *our* AID, not the APs.

johannes

