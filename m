Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31B03F949D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbhH0G4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 02:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhH0G4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 02:56:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC47C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=X8GH0wKg4VdBo0Rmn8JgKYN05qcOXgnb3Jh8iZDPov8=;
        t=1630047312; x=1631256912; b=iLZ6Bp5mE1FuCarVrCds5JtNM82leES+V+pkCj/TI434VZQ
        kwP/iz5aDdLmQ/+np+vCGnC9vhmmvuZhb1fm9Ik+fZcyUl9+R032RU0LBNunlxj3XKHrRoPB7WSnu
        8jNkq7vepkFQH5KA5ohhFEzMPtjWJ1QaPwViRoH8NO3UoDXmOj7Sp92apsxno7Xv9mxi1CluQvPYP
        96b/aCOPn37fPVqucTkR7FGrwgNMQleiLw6YinrdLNgpX2fOxDGGbqDt4bkfPIXpOYNHRt9LFf8OV
        7cLi66I5To4Mk93fYTA1Ws+SxV52++EO7mXEgoz8M+apK2TgyI89xcgO9wPmTZVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJVlb-00GVdn-F9; Fri, 27 Aug 2021 08:55:07 +0200
Message-ID: <0680b508a7864e02f55d763851f7460baa73b53f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 27 Aug 2021 08:55:06 +0200
In-Reply-To: <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
         <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
         <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-27 at 14:53 +0800, Wen Gong wrote:
> > 
> > Well, there's an existing place in this function that uses
> > cfg80211_find_ext_ie(), and various uses of ieee80211_bss_get_ie(), so
> > it feels like if we're going to do the full parsing, we should switch
> > all the existing "look up an element" to also use the parsed data
> > instead.

> ok.
> so it ha 2 way to change, right?
> 1.
> change ieee802_11_parse_elems() to ieee80211_bss_get_ie()

No why?

I think we should make a first patch (that doesn't add TPE yet) that
changes the function to ieee80211_parse_elems() and removes all the
ieee80211_bss_get_ie() / cfg80211_find_ext_ie() calls in favour of just
parsing once, and then looking at the elements there.

Then your TPE patch becomes trivial since the elems are already there?

> 
> 2.
> still use ieee802_11_parse_elems(), and change others 
> ieee80211_bss_get_ie()/cfg80211_find_ext_ie()
> to use the result of ieee802_11_parse_elems()
> 

Right!

johannes

