Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A282B17C1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 10:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMJEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMJEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 04:04:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0FAC0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 01:04:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kdV0H-006qrr-MS; Fri, 13 Nov 2020 10:04:21 +0100
Message-ID: <84e63d2b334b8dbfb2de23f604030c7ea355444d.camel@sipsolutions.net>
Subject: Re: [PATCH v3 v3] mac80211: 160MHz support per IEEE802.11ax standard
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Date:   Fri, 13 Nov 2020 10:04:20 +0100
In-Reply-To: <4f38e1cf-fc8c-c9fd-e064-e433a8b82186@celeno.com>
References: <20201019063921.4335-1-shay.bar@celeno.com>
         <20201019132616.32286-1-shay.bar@celeno.com>
         <9a043fdcf1c6324688f4c92b18f31c267969f5fc.camel@sipsolutions.net>
         <4f38e1cf-fc8c-c9fd-e064-e433a8b82186@celeno.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-11-08 at 10:11 +0200, Shay Bar wrote:
> On 06/11/2020 12:35, Johannes Berg wrote:
> > External Email
> > 
> > 
> > On Mon, 2020-10-19 at 16:26 +0300, Shay Bar wrote:
> > > According to the new IEEE802.11ax standard center frequency of the 160MHz
> > > should be published in segment2 field of HT operation IE when using EXT NSS
> > > (when supporting smaller number of NSS in VHT in 160MHz BW).

> No, it is referring to IEEE P802.11-REVmd™/D5.0, September 2020 Table 
> 9-81- "Setting of the Channel Width subfield and 160/80+80 BW subfield 
> at a VHT STA transmitting the Operating Mode field" (where it doesn't 
> refer to OM)

But you said above "according to the new IEEE802.11ax"? I guess that
confuses me.

Or did D5.0 incorporate 802.11ax? But that seems unlikely, 802.11ax D8.0
was still in circulation until yesterday, i.e. after you sent the patch?

> The nl80211.c change is also described in the first 3 rows of Table 
> 9-274 "VHT Operation Information subfields".

OK, thanks, I'll have to check that out.

johannes

