Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2153388BF3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhESKte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbhESKte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 06:49:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C8C06175F
        for <linux-wireless@vger.kernel.org>; Wed, 19 May 2021 03:48:14 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ljJkG-00BEFF-9r; Wed, 19 May 2021 12:48:08 +0200
Message-ID: <7e00e8dbf43f5bf19ddcaf037653e8a41c9d4fc3.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: do not use low data rates for data frames
 with no ack flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Philipp Borgers <borgers@mi.fu-berlin.de>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Wed, 19 May 2021 12:48:07 +0200
In-Reply-To: <YKTsxD+E6MnFzQ5C@mi.fu-berlin.de>
References: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
         <f80ba91c-88d4-3064-6861-5f9510b4fb69@nbd.name>
         <b42014d8bfbb6b58fc25656effada37aac066a85.camel@sipsolutions.net>
         <YKTsxD+E6MnFzQ5C@mi.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-05-19 at 12:47 +0200, Philipp Borgers wrote:
> On Tue, May 18, 2021 at 01:19:46PM +0200, Johannes Berg wrote:
> > On Tue, 2021-05-18 at 13:17 +0200, Felix Fietkau wrote:
> > > 
> > > Frames with IEEE80211_TX_CTL_HW_80211_ENCAP set have no 802.11 header,
> > > so please change the check something like this:
> > > 
> > > 	if ((info->flags & IEEE80211_TX_CTL_NO_ACK) &&
> > > 	    ((info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
> > > 	     ieee80211_is_data(hdr->frame_control)))
> > 
> > Maybe we should consider some kind of inline helper?
> > 
> > static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
> > {
> > 	... *info = ...
> > 	... *hdr = (void *)skb->data;
> > 
> > 	return (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
> >                ieee80211_is_data(hdr->frame_control);
> > }
> 
> A frame with IEEE80211_TX_CTL_HW_80211_ENCAP set is always a data frame?

Yes, other frames can't be HW-encap'ed, nor would it make sense to
offload that.

> Should I put the definition of the function into include/net/mac80211.h?
> 
Seems reasonable, yeah.

johannes


