Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C713F862B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbhHZLMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhHZLMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:12:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B7C061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AFPbCt38NXGTil1OJr1SDJKcyo5E5Oeu941r64ejGRQ=;
        t=1629976293; x=1631185893; b=b9/MzwDjzg84FPRgCJQMRWR1tYNlk7/1pMWsxYatuWFFKRl
        xUVFWTvpKSk4HuULdOW071+14v731Sf+0iTYRtQTJTnGvwpQxPD3/P+vllicw23WqYKS6/8ZghGxA
        5jOPwKudxf4MHRxcQAKVUucqqDz6u3bzDqDGvOevknbE7/qa2xpCdXTZ7KxL9XzZFaldpkSoBqB/I
        Y8F8czQ5GymO1n4WPk7vz5pO4luK4UrWSHjup7tLiV9Z1suGQjCTT2mrPOlukMvtsp55iPAiTTfCW
        wZ/SeJ6BQU2YMcuAlLvXQf4TxkzYtnWXWSncpr4AgBFOX+64ip1NKYZ81r/yBR1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJDI8-00G7hg-SN; Thu, 26 Aug 2021 13:11:28 +0200
Message-ID: <be51d30eae34c20e3992e1a3b1f5212cefe288fb.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 13:11:28 +0200
In-Reply-To: <3fea8f33ea9c341fbe0e4c1443a2c378@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-2-wgong@codeaurora.org>
         <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
         <4ab79bd421d021a2199c71471f60fefb97f317ad.camel@sipsolutions.net>
         <3fea8f33ea9c341fbe0e4c1443a2c378@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-08-26 at 19:02 +0800, Wen Gong wrote:
> On 2021-08-26 16:22, Johannes Berg wrote:
> > On Thu, 2021-08-26 at 10:20 +0200, Johannes Berg wrote:
> > > >  struct cfg80211_chan_def {
> > > >  	struct ieee80211_channel *chan;
> > > > @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
> > > >  	u32 center_freq2;
> > > >  	struct ieee80211_edmg edmg;
> > > >  	u16 freq1_offset;
> > > > +	enum nl80211_ap_reg_power power_type;
> > > 
> > > I'm not sure why this should be in the chandef, there's no way that
> > > anything in cfg80211 is ever using it there, at least in your patches.
> > 
> > Does it even *apply* to a channel? What if I'm connecting to two APs on
> > the same channel (two client interfaces)?
> > 
> this is one copy for each connection, each client has its own 
> cfg80211_chan_def.

That depends on where you check it - but you're basically saying "use
this only from vif->bss_conf.chandef (or something, didn't check now),
but chandef shows up in many other places and you don't maintain it
anywhere else.

johannes

