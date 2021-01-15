Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC52F7654
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbhAOKLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 05:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAOKLa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 05:11:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56FC061757
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 02:10:50 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l0M45-006bJg-Ax; Fri, 15 Jan 2021 11:10:45 +0100
Message-ID: <faca6aa3128471b3ed8c82a2116c25ad8bc149b6.camel@sipsolutions.net>
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap
 power save
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>, vnaralas@codeaurora.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Fri, 15 Jan 2021 11:10:44 +0100
In-Reply-To: <20201223124622.GA12620@w1.fi>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
         <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
         <871rilf2th.fsf@codeaurora.org>
         <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
         <87eelr1oq9.fsf@codeaurora.org>
         <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
         <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
         <87sg9rtugu.fsf@codeaurora.org>
         <60c779b7c17b8ea40c2bba08d8fca98e83581580.camel@sipsolutions.net>
         <20201223124622.GA12620@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-23 at 14:46 +0200, Jouni Malinen wrote:
> On Fri, Nov 06, 2020 at 11:41:06AM +0100, Johannes Berg wrote:
> > I suspect that SET_POWERSAVE might be confusing.
> 
> Why? Isn't the use case here very similar to the existing station mode
> use of power save even if the power saving mechanism is more of a vendor
> specific extension that applies while there are no associated stations?

Yeah, true, fair point.

However, set-powersave is a bit of a legacy API with state in the
kernel, and sometimes restrictions on how/when you can set it etc. I'm
not sure it's a good idea for those reasons alone?

> > Perhaps just with an attribute used in START_AP (and CHANGE_BEACON if
> > needed) would be sufficient?
> 
> NL80211_CMD_START_AP with a new attribute (or even re-use of
> NL80211_ATTR_PS_STATE) might work for a case where this does not need to
> be changed dynamically during the lifetime of the BSS.
> NL80211_CMD_SET_BEACON (which maps to the change_beacon() callback)
> feels like something that is currently limited to Beacon data updates
> with its use of struct cfg80211_beacon_data instead of struct
> cfg80211_ap_settings..
> 
> That SET_BEACON name is still from the old NEW/SET/DEL_BEACON time.
> Should that be renamed to NL80211_CMD_UPDATE_AP if we extend this to
> changes that are not really targeting the Beacon frame payload itself?

I'd be surprised if we don't already have non-beacon state there ... but
it looks like only very little non-beacon state, namely the FTM
responder state.

Renaming seems reasonable, we've done it before with START_AP.

> And should the cfg80211_beacon_data argument be replaced with
> cfg80211_ap_settings? It looks like we already have some struct
> cfg80211_ap_settings values like inactivity_timeout and beacon_rate (and
> maybe some HE parameters?) that one might want to update during the
> lifetime of the BSS..

That also seems reasonable.

johannes

