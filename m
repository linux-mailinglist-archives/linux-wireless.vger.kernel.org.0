Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3078C3F953D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbhH0HjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhH0HjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 03:39:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A6C061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GcJN2gXeESFjQDI1jkzgRhsBaiskCjhNlWKpqIMRnVQ=;
        t=1630049904; x=1631259504; b=Zdop1u4rAZ/caTJJOPFpCvJ2bCdFw3Eu0NtNjJIghHeq4wP
        48fAvc3jwzys8vnzCTeMAF/vJijAkHfG75Kdyuc1qXKXBg/wJd/iDKYmG7P3/78Fwi+WIrVU2fF/J
        tIlxN3BVhujNjV1f4UDEonauc9BsQJVyNBp40A+B8SwEmiUjMvLc/d2Gk0N+Ax7Hpyu9OEacNlTn9
        Aa8eQByn4CLNjvw3cps2LY2MqbPxZOUYvK+XU7EpoZw9q3+cgnOckIrFivfnFzXc1yjPbcFGysSio
        Il5fEUANiif/yM0ea0aH8wMILcAzXdx+3Fnuq/zFVxTD074O0nA/fsQzGBd7GlGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJWRO-00GWNY-Rh; Fri, 27 Aug 2021 09:38:18 +0200
Message-ID: <27680423e824dd67217cc6f1e62f9ac0a1af78f2.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 27 Aug 2021 09:38:18 +0200
In-Reply-To: <110489059796b17849d0f32fb5189828@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
         <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
         <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
         <0680b508a7864e02f55d763851f7460baa73b53f.camel@sipsolutions.net>
         <110489059796b17849d0f32fb5189828@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-08-27 at 15:12 +0800, Wen Gong wrote:
> On 2021-08-27 14:55, Johannes Berg wrote:
> > On Fri, 2021-08-27 at 14:53 +0800, Wen Gong wrote:
> > > > 
> > > > Well, there's an existing place in this function that uses
> > > > cfg80211_find_ext_ie(), and various uses of ieee80211_bss_get_ie(), so
> > > > it feels like if we're going to do the full parsing, we should switch
> > > > all the existing "look up an element" to also use the parsed data
> > > > instead.
> > 
> > > ok.
> > > so it ha 2 way to change, right?
> > > 1.
> > > change ieee802_11_parse_elems() to ieee80211_bss_get_ie()
> > 
> > No why?
> > 
> > I think we should make a first patch (that doesn't add TPE yet) that
> > changes the function to ieee80211_parse_elems() and removes all the
> > ieee80211_bss_get_ie() / cfg80211_find_ext_ie() calls in favour of just
> > parsing once, and then looking at the elements there.
> > 
> > Then your TPE patch becomes trivial since the elems are already there?
> this patch still needed, because the lower driver need the info.
> and this patch is save the info to "struct ieee80211_bss_conf *bss_conf" 
> and
> pass it to lower driver.

Of course, but you don't have to deal with parsing etc. in that patch
then.

johannes

