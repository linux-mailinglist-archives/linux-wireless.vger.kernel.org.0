Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8116E3F8627
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbhHZLLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbhHZLLa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:11:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA6C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=czeI+nFfn0fKCtI/TVIcOvMy5GtYOlDI6pZBIAoYgAE=;
        t=1629976243; x=1631185843; b=oEXGXKODPx9c8HxABUuXD8OoadETPQnAEtgEdgI4d/yyvnT
        0Shj8ogj7BrgZ+xC4XCXSCwIfBN2p0DStxeKaoY5OLqtPWrIMxdQZm5FPcCWR9lKO/qZcvi/I3DpR
        bNuDR6eQkP+3KEm+ANOqE7kTqrDaZvdM/Mr6rDO5RpdhNtpQZfKuOjXQoe3EhhwPlTQUULacp1r5P
        M3uGxT861rAdhiq7RvvA8Pr87DqeLj2ChRIcNVs6CdEUJOGdbW4a56ttBZXfi0Ehdu+wlK5DV3Pcr
        4rrTj9J8CIpYeEC2xhbhxYPP+aJwjGXhUbgXtzWR8usxpE7/9pruanDJO2HjNy3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJDHK-00G7g3-Rq; Thu, 26 Aug 2021 13:10:38 +0200
Message-ID: <e75ee4e160d6ec09d9c5f131f882d2e9d8eb49cd.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element
 and power constraint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 13:10:37 +0200
In-Reply-To: <f86091b72422d194a2e59b1f6d27a69b@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-9-wgong@codeaurora.org>
         <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
         <fe21853e8c9a73632e0ca860eef00296@codeaurora.org>
         <5c85b2bcfbffb617c5aa3f55e7ae94a1ab4df743.camel@sipsolutions.net>
         <f86091b72422d194a2e59b1f6d27a69b@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-08-26 at 19:00 +0800, Wen Gong wrote:
> On 2021-08-26 18:57, Johannes Berg wrote:
> > On Thu, 2021-08-26 at 18:50 +0800, Wen Gong wrote:
> > > > 
> > > it is memset here i this patch:
> > 
> > Oops, missed that.
> > 
> > But is that really a good place for it? Doesn't really seem to belong 
> > to
> > assigning a channel context - maybe put it into set_disassoc()?
> > 
> it is correct.
> you can see it is place together with "drv_unassign_vif_chanctx(local, 
> sdata, curr_ctx)"
> in ieee80211_assign_vif_chanctx(), it is for disconnect.

Yes, I know it's *correct*, but that doesn't mean it's *good*?

Look at that code - it does nothing with bss_conf. Nobody is ever going
to look there.

johannes
> 

