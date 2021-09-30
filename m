Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00BC41DA3F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351116AbhI3Mwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 08:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351052AbhI3Mwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 08:52:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B919C06176A
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4TlleyCiMGp2HgcNJjQRpYOtvGgDuirMN1avNFQtPaw=;
        t=1633006250; x=1634215850; b=Dzj+A7D5Udd2Xf47l5dHt3XE0lpWvhj8wftjdRkd+5LQn0N
        fPUJSX7UOeTVrmL6jqWKhxnsBwfmflM1e8krbHvk8xMNw/YrOq6LHWKWb5HwuvsUWG9axgUJ0UJV9
        TEDwJFA7HHqkNFh4LaAJhvyVFGQHyU5P+JBV40yNApRpGKoQua79FFHItlzpn0nwQOmKknuHujsIw
        Cp0kaDHGMiaXHOF5H+qvcWDx98jrym5mWQHS6GJHDx/+10C+9NNGsFenbjfkWb0uUDJZ/4Kgl2sb+
        EHEMfu4XjY2RVmUhKFSNmuBTXWttvs7qoI5afud1MKfaYqgxqJ1/Mubck9fSo8Yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mVvWR-00DnvS-Ej;
        Thu, 30 Sep 2021 14:50:47 +0200
Message-ID: <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org
Date:   Thu, 30 Sep 2021 14:50:46 +0200
In-Reply-To: <2ed76cff292dcca18326de0407a93821@codeaurora.org>
References: <20210928085211.26186-1-wgong@codeaurora.org>
         <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
         <cb20427eae96c4551084e4c899618b94@codeaurora.org>
         <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
         <2ed76cff292dcca18326de0407a93821@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-09-30 at 10:53 +0800, Wen Gong wrote:
> > > 
> > > 		chan->max_reg_power =
> > > 			min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
> > > 			      MBM_TO_DBM(power_rule2->max_eirp));
> > > 
> > > For AP + STA concurrency, it should to maintain 2 group of reg rules,
> > > one is for AP, another is for STA.
> > 
> > Can we maintain two power rules in the same channel one for AP and one
> > for STA. In this way, we can update the power rules in the same
> > channel for both AP and STA from the reg rules.
> > 
> > Otherwise, we need to maintain multiple channel lists in sband for all
> > supported power mode combinations to apply the respective power rules
> > and build channel flags from the multiple reg rules.
> > right?
> 
> If AP+STA is up in the same wiphy/ieee80211_hw, and AP's reg rules is 
> different
> with STA, then it should maintain muti channel list for each band of the 
> wiphy/ieee80211_hw by my understand.

I don't think that's how it works. You can today have AP/STA concurrency
on a single wiphy with different netdevs, even with mesh or whatever.

> Currently there is only one "struct ieee80211_supported_band 
> *bands[NUM_NL80211_BANDS]"
> in "struct wiphy".
> 
> I advise to discuss the AP + STA concurrency in another mail thread 
> since it is not relative with this patch.

I actually explicitly pointed to this thread, but I'm not sure it's so
clear cut?

If we have completely separate rules here for AP and STA, we probably
should have different "max_reg_power" values for AP and STA? Maybe mesh
is treated like AP, maybe not?

But I don't know - does PSD really differ between AP and STA?

Maybe this discussion belongs rather to the power type patch? But that
didn't add any state!


So - does this PSD depend on mode? It kind of seems like it shouldn't
and then this *isn't* the right place to be discussing this, but if PSD
does in fact depend on the mode then we should be discussing it here?

Venkatesh seemed to be worried more about LPI/client power etc. as in
commit 405fca8a9461 ("ieee80211: add power type definition for 6 GHz"),
but that doesn't add state?

So what gives? From a regulatory POV it seems PSD should be independent,
but some other things might be dependent on mode?

johannes

