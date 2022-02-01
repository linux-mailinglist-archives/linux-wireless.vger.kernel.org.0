Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A544A5E65
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 15:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiBAOg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 09:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiBAOg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 09:36:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6CC061714
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2ttSIOBA7/32sme4OGqllL2MeACLQsmvaXK7j4VRU/Q=;
        t=1643726185; x=1644935785; b=BBao+XcH/XjCo2eujwNvFPjzeegsuy+cGJ0r9H3seDOJ6uy
        yspFWP70xxPyOcWekBK82X38j0zMWAlZZ9MtURvWHysSttd9Nf5MmqwVlpmsX4B1u/KkalCQZalzn
        zBrV4NI5SNpN/SS2NUBKF9Z4444zIGmwZPTncszRJU7g4ByO649FztR8bKqC0vvirQYJflMdysQ5v
        rzDjATU4S/HKgjrp5cIOOJbC660CgmgpwSkRy4b5tFNWDFhiYVXF5o9abwnhC66fS1ljyuKmBcQNM
        v+WVq24CQE8l9YHToOrhNs1ZNoXBZfE+itzlITHOZuDdDNalb2x4hzTIOqmtLq0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nEuGd-00DAB3-Fp;
        Tue, 01 Feb 2022 15:36:23 +0100
Message-ID: <6c865a0d04d28e9378acf75ae7646b9bb432b189.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: fix race in netlink owner interface
 destruction
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Date:   Tue, 01 Feb 2022 15:36:22 +0100
In-Reply-To: <871r0md58n.fsf@tynnyri.adurom.net>
References: <20220201130951.22093-1-johannes@sipsolutions.net>
         <871r0md58n.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-02-01 at 16:35 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > My previous fix here to fix the deadlock left a race where
> > the exact same deadlock (see the original commit referenced
> > below) can still happen if cfg80211_destroy_ifaces() already
> > runs while nl80211_netlink_notify() is still marking some
> > interfaces as nl_owner_dead.
> > 
> > The race happens because we have two loops here - first we
> > dev_close() all the netdevs, and then we destroy them. If we
> > also have two netdevs (first one need only be a wdev though)
> > then we can find one during the first iteration, close it,
> > and go to the second iteration -- but then find two, and try
> > to destroy also the one we didn't close yet.
> > 
> > Fix this by only iterating once.
> > 
> > Change-Id: Ie56cd0ef3f0d2108bb8a25c8bb5efced15e6a909
> 
> You forgot the Change-Id.
> 
Wtf, sorry, guess I sent it from a place with the wrong script. I'll
strip it when I apply it, I guess

johannes
