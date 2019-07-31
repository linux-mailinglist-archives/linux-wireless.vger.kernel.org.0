Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E194B7BDBE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfGaJvR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 05:51:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55858 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaJvR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 05:51:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hslGN-00057W-Sa; Wed, 31 Jul 2019 11:51:15 +0200
Message-ID: <bcb31ffae5b916d319bd25a34432026df61fc6f0.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] nl80211: Limit certain commands to interface
 owner
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:51:13 +0200
In-Reply-To: <20190701153317.27170-2-denkenz@gmail.com> (sfid-20190701_173327_508693_6824CD6B)
References: <20190701153317.27170-1-denkenz@gmail.com>
         <20190701153317.27170-2-denkenz@gmail.com>
         (sfid-20190701_173327_508693_6824CD6B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-07-01 at 10:33 -0500, Denis Kenzior wrote:
> If the wdev object has been created (via NEW_INTERFACE) with
> SOCKET_OWNER attribute set, then limit certain commands only to the
> process that created that wdev.
> 
> This can be used to make sure no other process on the system interferes
> by sending unwanted scans, action frames or any other funny business.
> 
> This patch introduces a new internal flag, and checks that flag in the
> pre_doit hook.

So, looking at this ...

I can't say I'm convinced. You're tagging 35 out of about 106 commands,
and even if a handful of those are new and were added after your patch,
this doesn't really make sense.

NL80211_CMD_LEAVE_IBSS is tagged, but not NL80211_CMD_LEAVE_MESH?
NL80211_CMD_NEW_STATION is tagged, but not NL80211_CMD_NEW_MPATH?
NL80211_CMD_SET_KEY is tagged, but not NL80211_CMD_SET_PMK or
NL80211_CMD_SET_PMKSA?
NL80211_CMD_UPDATE_CONNECT_PARAMS is tagged, but not
NL80211_CMD_UPDATE_OWE_INFO (though this could be patch crossing?)

NL80211_CMD_CONTROL_PORT_FRAME isn't tagged?

NL80211_CMD_SET_QOS_MAP isn't tagged?

It almost feels like you just did a "git grep NL80211_CMD_" on your
code, and then dropped the flag on everything you were using.

And honestly, I think you need a better justification than just
"unwanted scans, action frames or any other funny business".

Also, how's this not just a workaround for some very specific setup
issue you were seeing, where people trying out iwd didn't remove wpa_s
properly (*)? I'm really not convinced that this buys us anything except
in very limited development scenarios - and those are typically the
exact scenarios where you _want_ to be able to do things like that (and
honestly, I'd be pretty pissed off if I couldn't do an "iw wlan0 scan"
just because some tool decided it wanted to have control over things).

(*) also, that would just happen to work for you now with iwd winning
because you claim ownership and wpa_s doesn't, you'd still get the same
complaints "iwd doesn't work" if/when wpa_s *does* start to claim
ownership and you get locked out with a patch like this, so I don't feel
you'd actually win much even in this case.


I'm trying to come up with places where we do something similar, defend
one application running as root against another ... but can't really?
Think about VPN - we don't stop anying from removing or adding IP
addresses that the VPN application didn't intend to use, yet that can
obviously break your connection. You could even run dhcp on it, even if
for (most) VPN protocols that's rather useless.

Overall, I'm not really convinced. The design is rather unclear
(randomly sprinkling magic dust on ~35% of commands), and it's also not
really clear to me what this is intended to actually achieve.

johannes

