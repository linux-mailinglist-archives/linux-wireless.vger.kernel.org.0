Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D0387757
	for <lists+linux-wireless@lfdr.de>; Tue, 18 May 2021 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348794AbhERLVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 May 2021 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348785AbhERLVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 May 2021 07:21:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7722C061573
        for <linux-wireless@vger.kernel.org>; Tue, 18 May 2021 04:19:50 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lixlL-00AmfT-Ge; Tue, 18 May 2021 13:19:47 +0200
Message-ID: <b42014d8bfbb6b58fc25656effada37aac066a85.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: do not use low data rates for data frames
 with no ack flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 18 May 2021 13:19:46 +0200
In-Reply-To: <f80ba91c-88d4-3064-6861-5f9510b4fb69@nbd.name>
References: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
         <f80ba91c-88d4-3064-6861-5f9510b4fb69@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-05-18 at 13:17 +0200, Felix Fietkau wrote:
> 
> Frames with IEEE80211_TX_CTL_HW_80211_ENCAP set have no 802.11 header,
> so please change the check something like this:
> 
> 	if ((info->flags & IEEE80211_TX_CTL_NO_ACK) &&
> 	    ((info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
> 	     ieee80211_is_data(hdr->frame_control)))

Maybe we should consider some kind of inline helper?

static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
{
	... *info = ...
	... *hdr = (void *)skb->data;

	return (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
               ieee80211_is_data(hdr->frame_control);
}


or so?

johannes

