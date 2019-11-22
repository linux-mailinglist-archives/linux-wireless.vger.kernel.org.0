Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB72107271
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVMuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:50:04 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45008 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVMuE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:50:04 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY8Ns-0003Xv-6J; Fri, 22 Nov 2019 13:50:00 +0100
Message-ID: <bc0849dd83ae748acde1cebd025e5677ba6eced1.camel@sipsolutions.net>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 13:49:59 +0100
In-Reply-To: <b70dd0ab69f968366d7cb836d2b880bc@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <20191108093207.uv4j44xpm2qvtsv5@bars>
         <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
         <20191108120504.ptl25hacxcftb7tw@bars>
         <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
         <20191108160121.tbatmqwx64aoqqai@bars>
         <c95e9e9f5539150459f97f811b784a6e9af163cf.camel@sipsolutions.net>
         <b70dd0ab69f968366d7cb836d2b880bc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-11-14 at 13:02 +0530, Tamizh chelvam wrote:
> On 2019-11-08 22:37, Johannes Berg wrote:
> > On Fri, 2019-11-08 at 16:01 +0000, Sergey Matyukevich wrote:
> > 
> > > > I think we still need NL80211_TID_CONFIG_ATTR_OVERRIDE in some way
> > > > (maybe only as a flag attribute), since you could have
> > > > 
> > > >  * change all stations (some subset of TIDs) *including* already
> > > >    configured stations
> > > >  * or *excluding* already configured stations
> > > 
> > > Hmmm... Logic is straightforwad without this flag:
> > > - settings are applied to bitmasked TIDs of a single peer if address 
> > > is specifed
> > > - settings are applied to bitmasked TIDs of all the peers if no 
> > > address is specified
> > 
> > Sure, this is obvious, but what exactly does "all the peers" mean?
> > 
> > Say I do
> > 
> > set_tid_config(tids=0x1, peer=02:11:22:33:44:55, noack=yes)
> > set_tid_config(tids=0x1, peer=NULL, noack=no)
> > 
> > Does that reset peer 02:11:22:33:44:55, or not? This is not documented
> > right now, and one could argue both ways - the override for that
> > particular peer should stick, or should be removed. Which one is it?
> > 
> Here, the second command won't reset the peer 02:11:22:33:44:55. Here we 
> are giving more
> preference to the peer specific configuration. We have to reset the peer 
> 02:11:22:33:44:55 using the set_tid_config(tids=0x1, 
> peer=02:11:22:33:44:55, DEFAULT). I will add these in the DOC section 
> and send it in next patchset.

OK, but maybe in some cases it _is_ desired to actually clear all peer-
specific overrides (somehow)?

johannes

