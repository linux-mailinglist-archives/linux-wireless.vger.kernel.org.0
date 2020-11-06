Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D622A9495
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKFKlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFKlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:41:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6ADC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 02:41:11 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kazB5-002Eaw-LN; Fri, 06 Nov 2020 11:41:07 +0100
Message-ID: <60c779b7c17b8ea40c2bba08d8fca98e83581580.camel@sipsolutions.net>
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap
 power save
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, vnaralas@codeaurora.org
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Fri, 06 Nov 2020 11:41:06 +0100
In-Reply-To: <87sg9rtugu.fsf@codeaurora.org>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
         <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
         <871rilf2th.fsf@codeaurora.org>
         <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
         <87eelr1oq9.fsf@codeaurora.org>
         <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
         <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
         <87sg9rtugu.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-11-02 at 21:44 +0200, Kalle Valo wrote:
> vnaralas@codeaurora.org writes:
> 
> > On 2020-10-22 13:30, Arend Van Spriel wrote:
> > > On 10/21/2020 7:19 PM, Kalle Valo wrote:
> > > > vnaralas@codeaurora.org writes:
> > > > 
> > > > > On 2020-09-29 13:10, Kalle Valo wrote:
> > > > > > Johannes Berg <johannes@sipsolutions.net> writes:
> > > > > > 
> > > > > > > On Mon, 2020-08-24 at 13:56 +0530, Venkateswara Naralasetty wrote:
> > > > > > > > AP power save feature is to save power in AP mode, where AP goes
> > > > > > > > to power save mode when no stations associate to it and comes out
> > > > > > > > of power save when any station associate to AP.
> > > > > > > 
> > > > > > > Why do you think this requires a vendor command? I mean, that seems
> > > > > > > like
> > > > > > > fairly reasonable - even by default - behaviour?
> > > > > > 
> > > > > > I have not studied the details, but doesn't AP power save break
> > > > > > normal
> > > > > > functionality? For example, I would guess probe requests from
> > > > > > clients
> > > > > > would be lost. So there's a major drawback when enabling this,
> > > > > > right?
> > > > > 
> > > > > This AP power save feature will not break any functionality, Since
> > > > > one
> > > > > chain is always active and all other chains will be disabled when
> > > > > this
> > > > > feature is enabled. AP can still be able to beacon and receive probe
> > > > > request from the clients. The only drawback is reduced network range
> > > > > when this feature is enabled. Hence, we don't want to enable it by
> > > > > default.
> > > > 
> > > > Yeah, we really would not want to enable that by default. But what
> > > > should be the path forward, a vendor command or a proper nl80211
> > > > command? Any opinions?
> > > 
> > > I would go for a proper nl80211 command or just add an attribute for
> > > use in NL80211_CMD_START_AP or deal with NL80211_CMD_SET_POWERSAVE
> > > when operating in AP mode.
> > > 
> > Sure, I will go with the existing NL80211_CMD_SET_POWERSAVE and I will
> > send next version.
> 
> Better to wait first so that we have concensus on this. And need to
> check if NL80211_CMD_SET_POWERSAVE is even suitable for AP mode.

I suspect that SET_POWERSAVE might be confusing.

Perhaps just with an attribute used in START_AP (and CHANGE_BEACON if
needed) would be sufficient?

johannes

