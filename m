Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159F2319BEB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhBLJea (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 04:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhBLJeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 04:34:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D9C061756
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 01:33:32 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAUpO-001n3C-Ag; Fri, 12 Feb 2021 10:33:30 +0100
Message-ID: <9d9cc5bc50629090375b185a3af2546e506c22d9.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: Commands for FILS discovery and
 unsolicited broadcast probe response
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 12 Feb 2021 10:33:29 +0100
In-Reply-To: <430f10a576b8490f73827f800c87f58c@codeaurora.org> (sfid-20210125_225531_667698_384A7632)
References: <20210120005229.32582-1-alokad@codeaurora.org>
         <20210120005229.32582-2-alokad@codeaurora.org>
         <ca7281ce-70bb-d1e2-3ec2-f07d91145c04@broadcom.com>
         <430f10a576b8490f73827f800c87f58c@codeaurora.org>
         (sfid-20210125_225531_667698_384A7632)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-01-25 at 13:52 -0800, Aloka Dixit wrote:
> 
> FILS discovery and especially unsolicited probe response templates are 
> big. Sometimes send_and_recv() returns error due to memory 
> unavailability during wpa_driver_nl80211_set_ap() depending on how many 
> interfaces, which elements are added. 

What? Where do you get errors from? Netlink even supports vmalloc now, I
believe, so the kernel really shouldn't care?

> Moving these to separate commands 
> resolves this issue along with more control over the time interval 
> during run-time.

I tend to agree with Arend though, we have NL80211_CMD_SET_BEACON and
since NL80211_CMD_NEW_BEACON was renamed to NL80211_CMD_START_AP to more
accurately say what it does, I think generalizing "AP modifications" by
renaming NL80211_CMD_SET_BEACON to NL80211_CMD_UPDATE_AP (or such) would
make a lot of sense.

Let's not conflate the two issues here.

1) memory issues - need to understand better

2) update is needed - I'd say SET_BEACON/UPDATE_AP would be a better way
   than pulling everything into separate commands. Updates can be
   partial too, after all, if you include only the changed attributes,
   and that might even address case 1? I.e. why wouldn't userspace be
   able to do UPDATE_AP multiple times, just like with your patch it
   would do NL80211_CMD_SET_FILS_DISCOVERY
   and NL80211_CMD_SET_UNSOL_BCAST_PROBE_RESP?


Also, technically this constitutes an API break. One that perhaps nobody
cares about yet, but surely somebody already has hostapd versions that
use NL80211_ATTR_FILS_DISCOVERY or NL80211_ATTR_UNSOL_BCAST_PROBE_RESP?
After all, you don't want to tell me you never tested this code ;-)

johannes

