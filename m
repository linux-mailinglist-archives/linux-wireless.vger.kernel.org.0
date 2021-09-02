Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30DA3FEF3F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbhIBOQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhIBOQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 10:16:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1D3C061757
        for <linux-wireless@vger.kernel.org>; Thu,  2 Sep 2021 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JEPWQc7zL3cmsVDvdzwT7npmTvoumnrWLZyG0dCP5mY=;
        t=1630592134; x=1631801734; b=mWkZSg0wehNN1DaGwcYiygo3SvI7cGJgXtResA8BecLUG2l
        pZCLqP/fFrxr7+Clxb5vz9X0vYnhs+/E/QBrlK7vVLhvlrXHMO6M8GG5R0c+kL5TMtyRbhv5sIQcz
        W+ahOWo9aU8BjASuB6l7ZVue39MxIspqjVHwRYVJs8VWAamxGtdQ5+jarElhev7qbr2Jvp9HPWSnq
        Mf3SagYtCY3soIvSuPniyJ1kRb/6vKmWufo25QI37sJUojsNULksWSl76YsWTIqU1B0mFW2dA5yl5
        s3neo3MWQkU/0Ez2SA5RK3uyc7+3WFD78zdibvMeuNL20TmcILi3LzSG6ZK4WShQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mLnV5-001dSN-KI; Thu, 02 Sep 2021 16:15:31 +0200
Message-ID: <e8638002e21df72ccd697b6701a5f10079de4db3.camel@sipsolutions.net>
Subject: Re: Multi-client EAPOL key timeout when not having RTNL lock
 protection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Thu, 02 Sep 2021 16:15:30 +0200
In-Reply-To: <6cae54aee83a19dc13e458e4d20e4f28@codeaurora.org>
References: <6cae54aee83a19dc13e458e4d20e4f28@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sathishkumar,

> In the multi-client (64 or higher clients on single radio) test scenario 
> of AP mode using hostapd, we are facing EAPOL key timeout for random 
> clients.
> 
> wlan1: STA 00:41:c0:a8:03:10 WPA: received EAPOL-Key msg 4/4 in invalid 
> state (7) – dropped

I think you'll probably have to share a more complete hostapd log, and
likely also send to Jouni/hostap list.

> This is happening due to delay in transmission of association response 
> frames for retried association request frames from the client and one of 
> the association requests is received when EAPOL key exchange is in 
> process.
> 

You're talking about the AP, which is transmitting the association
response. How could the AP possibly have sent an EAPOL msg 1/4 before
getting an ACK on the association response? Why are there retries for
this anyway?

> NL80211_CMD_NEW_STATION is received on hostapd when already 
> EAPOL M3 is transmitted and waiting for EAPOL M4.

Are you sure this is with an in-kernel driver?

Hostapd should be creating the stations?

> But since hostapd 
> received NL80211_CMD_NEW_STATION, it resets the handshake process from 
> M1 again by the time client sends M4 to see the above error.

Yeah, but ... why isn't hostapd doing that?

> This delay is seen only after the commit, a05829a7222e ("cfg80211: avoid 
> holding the RTNL when calling the driver") and not seen before/without 
> this commit. We could see delay in processing of nl80211_get_key, 
> nl80211_set_key, nl80211_new_key, nl80211_del_key and nl80211_tx_mgmt 
> commands.
> 
> The delay and EAPOL key timeout is not seen when NL80211_FLAG_NEED_RTNL 
> is set back to internal_flags of nl80211_get_key, nl80211_set_key, 
> nl80211_new_key, nl80211_del_key and nl80211_tx_mgmt messages alone.
> 
> Please share your comments on this issue requiring RTNL lock for key and 
> mgmt nl80211 commands.

Not going to happen, you need to find the real cause of this.

johannes

