Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C555F3F83B2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhHZIXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbhHZIXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 04:23:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6339C061796
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Qz1AgzJuBgAQZ9DGE2QiZ6gpesJH6ixLBBGr9oJj3sQ=;
        t=1629966154; x=1631175754; b=Z2ubl2xpPLvQpeFzAAsJ3gLi54fohl3T9gCQo8/qEKJbkkr
        CAdFUR3u96v3oeVyZp2Y3aKKwnvG2KVn1ZAEHROweJjN6yCqOYSqvHzILidv+T4mQ4rYmt8oHz1rh
        zHjk6272c/Q/Tn0ShL2/GLGniIwfAvL4/givWTI9v5V3hbSCpv1a64Y6to04LSn+f5jYXW3jQwqjo
        rkU9TMUILauxMELmuL+kgYEB+evaCO1QOspoF4q0og87C77M31Upml2NGvdlFGwWgbdZQ7MMwHbl4
        rxlZTbGpMKZAOPl3voD/aoiMAMSUnIMOsFPDfwLw/GpZW1xhGuiSyqKiMrgdfWuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJAec-00G4j1-1T; Thu, 26 Aug 2021 10:22:30 +0200
Message-ID: <4ab79bd421d021a2199c71471f60fefb97f317ad.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 10:22:29 +0200
In-Reply-To: <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-2-wgong@codeaurora.org>
         <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-08-26 at 10:20 +0200, Johannes Berg wrote:
> >  struct cfg80211_chan_def {
> >  	struct ieee80211_channel *chan;
> > @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
> >  	u32 center_freq2;
> >  	struct ieee80211_edmg edmg;
> >  	u16 freq1_offset;
> > +	enum nl80211_ap_reg_power power_type;
> 
> I'm not sure why this should be in the chandef, there's no way that
> anything in cfg80211 is ever using it there, at least in your patches.

Does it even *apply* to a channel? What if I'm connecting to two APs on
the same channel (two client interfaces)?

johannes

