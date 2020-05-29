Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5801E7794
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE2H7x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 03:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2H7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 03:59:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3FC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 00:59:52 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeZvg-005OMm-PV; Fri, 29 May 2020 09:59:48 +0200
Message-ID: <43eca9213489de7ad1323505a48f9dbbcfb04b37.camel@sipsolutions.net>
Subject: Re: [PATCH v2 20/24] cfg80211: Update 6 GHz starting frequency
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Ilan Peer <ilan.peer@intel.com>,
        Arend van Spriel <arend@broadcom.com>
Date:   Fri, 29 May 2020 09:59:47 +0200
In-Reply-To: <20200528211913.GA1135@w1.fi>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
         <20200528213443.a08c02e0f9bb.If474d2bc528aa07610fef429ff83e8312079e242@changeid>
         <20200528211913.GA1135@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-29 at 00:19 +0300, Jouni Malinen wrote:
> On Thu, May 28, 2020 at 09:34:43PM +0200, Johannes Berg wrote:
> > The starting frequency of the 6GHz band changed from
> > 5940 MHz to 5950 MHz. Update the code accordingly.
> > diff --git a/net/wireless/util.c b/net/wireless/util.c
> > @@ -94,7 +94,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
> >  	case NL80211_BAND_6GHZ:
> >  		/* see 802.11ax D4.1 27.3.22.2 */
> >  		if (chan <= 253)
> > -			return 5940 + chan * 5;
> > +			return 5950 + chan * 5;
> 
> It would be good to update that P802.11ax reference to point to a newer
> version that actually matches the changed implementation, i.e., IEEE
> P802.11ax/D6.1, 27.3.23.2.

Good point, thanks.

> > @@ -119,11 +119,11 @@ int ieee80211_freq_khz_to_channel(u32 freq)
> >  		return (freq - 2407) / 5;
> >  	else if (freq >= 4910 && freq <= 4980)
> >  		return (freq - 4000) / 5;
> > -	else if (freq < 5945)
> > +	else if (freq < 5955)
> >  		return (freq - 5000) / 5;
> 
> What about operating class 136 channel 2 with channel starting frequency
> of 5925 MHz? This would map 5935 MHz incorrectly.

Yeah. Actually, Arend had this handled:

      case NL80211_BAND_6GHZ:
-             /* see 802.11ax D4.1 27.3.22.2 */
+             /* see 802.11ax D7.0 27.3.23.2 */
+             if (chan == 2)
+                     return MHZ_TO_KHZ(5935);
              if (chan <= 253)
-                     return 5940 + chan * 5;
+                     return MHZ_TO_KHZ(5950 + chan * 5);


I've asked him to resend (somehow his patch never made it out, only his
own reply did), it was more complete anyway.

I didn't even see operating class 136 (in D6.0) though.

johannes

