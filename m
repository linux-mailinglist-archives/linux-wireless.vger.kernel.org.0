Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7566A45EE2F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 13:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhKZMoY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 07:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhKZMmW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 07:42:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B25CC0613B5
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MoNZA/OvQy6PV0GrcW+CitgAX7nQNAWqJvwZxW0n7XM=;
        t=1637928290; x=1639137890; b=kED4KXfrQNDwKE6x7J6hNDvUBf1rC2U8rMYWQQaRcQR78M+
        G4NHf2XfmooqbODWm+km0qJo4IeDRcK7xWykTC4n1OZogMhgFcL/8WMeEhYupxgHgtOSUYJ5UnhF2
        hYY6BAXsNvyvINJnlcG9qofkBtaXVqnxah+Y1Uvbdszhki6wuiYVOgs5yKhT6CLYwUuAZdyW7BAsP
        dunN2ULj0Ql1tkYXfhhepnk8pNJ+qlp2rxfxccCvOn9T+8Juml3Pbuk48bhX+B/M/PL6inT44h5HL
        R0EbGDm5fNpnr9qX64Bh7ykBa69eZvSSGhsjB3llPNlHewE1z9+jUSsyibo6mGDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqZyC-003AWt-I6;
        Fri, 26 Nov 2021 13:04:48 +0100
Message-ID: <a5ac66c2bee2f5de7cda68ad13d7008a05975c0b.camel@sipsolutions.net>
Subject: Re: [RFC v4] mac80211: fix rx blockack session race condition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jean-Pierre TOSONI <jp.tosoni@acksys.fr>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
Date:   Fri, 26 Nov 2021 13:04:47 +0100
In-Reply-To: <DB9PR01MB73541FED9E91AC3005D27DAEE4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
References: <DB9PR01MB73541FED9E91AC3005D27DAEE4869@DB9PR01MB7354.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-10-28 at 10:25 +0000, Jean-Pierre TOSONI wrote:
 
> +		spin_lock_bh(&rx->sta->ampdu_mlme.rx_offl_lock);
>  		if (!test_bit(tid, rx->sta->ampdu_mlme.agg_session_valid) &&
> -		    !test_and_set_bit(tid, rx->sta->ampdu_mlme.unexpected_agg))
> +		    /* back_req is allowed if the fw just received addba */
> 

If we're going to add an unconditional lock here, I see little reason to
have all the test_bit()/test_and_set_bit() etc.

I really don't think it's _right_ to add an unconditional lock here
though, if it can at all be avoided.

johannes
