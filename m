Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABD5388BEF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhESKsz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 06:48:55 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:42449 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240370AbhESKsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 06:48:55 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <pborgers@zedat.fu-berlin.de>)
          id 1ljJjh-003bUM-MD; Wed, 19 May 2021 12:47:33 +0200
Received: from a36t-ffs1.berlin.freifunk.net ([77.87.51.11] helo=mi.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <borgers@mi.fu-berlin.de>)
          id 1ljJjg-000CI0-G8; Wed, 19 May 2021 12:47:33 +0200
Received: by mi.fu-berlin.de (sSMTP sendmail emulation); Wed, 19 May 2021 12:47:32 +0200
Date:   Wed, 19 May 2021 12:47:32 +0200
From:   Philipp Borgers <borgers@mi.fu-berlin.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: do not use low data rates for data frames
 with no ack flag
Message-ID: <YKTsxD+E6MnFzQ5C@mi.fu-berlin.de>
References: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
 <f80ba91c-88d4-3064-6861-5f9510b4fb69@nbd.name>
 <b42014d8bfbb6b58fc25656effada37aac066a85.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b42014d8bfbb6b58fc25656effada37aac066a85.camel@sipsolutions.net>
X-Original-Sender: borgers@mi.fu-berlin.de
X-Originating-IP: 77.87.51.11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 18, 2021 at 01:19:46PM +0200, Johannes Berg wrote:
> On Tue, 2021-05-18 at 13:17 +0200, Felix Fietkau wrote:
> > 
> > Frames with IEEE80211_TX_CTL_HW_80211_ENCAP set have no 802.11 header,
> > so please change the check something like this:
> > 
> > 	if ((info->flags & IEEE80211_TX_CTL_NO_ACK) &&
> > 	    ((info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
> > 	     ieee80211_is_data(hdr->frame_control)))
> 
> Maybe we should consider some kind of inline helper?
> 
> static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
> {
> 	... *info = ...
> 	... *hdr = (void *)skb->data;
> 
> 	return (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
>                ieee80211_is_data(hdr->frame_control);
> }

A frame with IEEE80211_TX_CTL_HW_80211_ENCAP set is always a data frame?

Should I put the definition of the function into include/net/mac80211.h?
