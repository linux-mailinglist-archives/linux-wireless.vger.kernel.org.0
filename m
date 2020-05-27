Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60E31E3BE5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 10:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgE0I0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgE0I0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 04:26:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A0C061A0F
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 01:26:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdrOX-003yiX-W5; Wed, 27 May 2020 10:26:38 +0200
Message-ID: <116cca43dc99edbf220707c453d5aae63b942b77.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] nl80211: FILS discovery/bcast probe resp support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, kbuild test robot <lkp@intel.com>
Date:   Wed, 27 May 2020 10:26:36 +0200
In-Reply-To: <0c89ad68-67bf-7ade-7702-1695bb7274cb@broadcom.com> (sfid-20200526_101837_707500_A1CB77F3)
References: <20200526000913.30434-1-alokad@codeaurora.org>
         <20200526000913.30434-2-alokad@codeaurora.org>
         <0c89ad68-67bf-7ade-7702-1695bb7274cb@broadcom.com>
         (sfid-20200526_101837_707500_A1CB77F3)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-05-26 at 10:18 +0200, Arend Van Spriel wrote:
> On 5/26/2020 2:09 AM, Aloka Dixit wrote:
> > This patch adds new attribute, NL80211_ATTR_FD_BCASTPRESP_CFG
> > to configure FILS discovery and broadcast probe response in 6GHz
> > for in-band discovery.
> > 
> > Only one of the two is active at a time to reduce broadcast
> > packets over the air.
> > 
> > Maximum packet interval can be 20 TUs.
> > Packet interval set to 0 disables FILS discovery and broadcast
> > probe response transmission.
> > 
> > Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> 
> huh? what is reported. Oh, guess it is the reason for having v2. Don't 
> think this tag is useful for that. Only useful if v1 would have been 
> applied and this patch would fix that.

Yeah, that's a bit confusing. OTOH, they do like to be credited for the
fixes too ... Maybe that should then be "Co-developed-by" ;-)

I really don't know a good solution to this, but would probably drop the
tag(s).

> > @@ -974,6 +978,8 @@ struct cfg80211_beacon_data {
> >   	const u8 *probe_resp;
> >   	const u8 *lci;
> >   	const u8 *civicloc;
> > +	const u8 *bcast_presp;
> > +	const u8 *fils_disc;
> 
> This is not really beacon data, now is it?

Well, neither is the probe_resp template :)

I guess we should rename this to ... cfg80211_beaconing_data? I dunno. I
mean, this thing is for beaconing and related things, and can be swapped
during runtime for a new beacon/config.

So that seems OK. However, Dan found an issue, so please respin.

johannes

