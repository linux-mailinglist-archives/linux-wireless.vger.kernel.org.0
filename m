Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE43F85EF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbhHZK5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbhHZK5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 06:57:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8EC061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PNQZ+rHh7hl5a47PmWoTZeWeMpHJ9fRvLz9pLHak5JM=;
        t=1629975414; x=1631185014; b=TfyTjsSURsdq8cQtUnc1sylShhwNPMV1mignY0w71kjJym9
        gLQFlyhAPS1QJmiyqnqlfvRHPYowg0ht7CHsXQwipth8xp4lsNxze2DLn9qQIohhM93rYnYtBTLZw
        8Uxi2T4R1fU5w3OWn+AdQhsfOGz1qj/E/RX3p3UTJ/U8bwEf7VZL3Uh+SOIqXWhBT5sw28UWei8Nl
        nPZCZX3/kusOZDCMn7VwPR1FyQtMD3RWLpCeR5Q9uDtHFhP3KgDKfNMmrf1no8h2rZoVJyCUNb0Ve
        YWrq2HkPJamBzSzq5+1mU6yc0p8RLBNZpLUXvhhcDZlLlnKsgnDOuBAL1bXiirWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJD3w-00G7K9-El; Thu, 26 Aug 2021 12:56:48 +0200
Message-ID: <b3d00d00525bbc2a31653df6c0ce72cfb4d1c8d7.camel@sipsolutions.net>
Subject: Re: [PATCH v2 5/8] cfg80211: save power spectral density(psd) of
 regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 12:56:47 +0200
In-Reply-To: <4eca272868dae4f7a923656a12b03024@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-6-wgong@codeaurora.org>
         <101b523a6fe06fea3e1c9642a1bf5e85a9d0e680.camel@sipsolutions.net>
         <4eca272868dae4f7a923656a12b03024@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-08-26 at 18:43 +0800, Wen Gong wrote:
> On 2021-08-26 16:25, Johannes Berg wrote:
> > I was going to apply this and patch 4 squashed, saying:
> > 
> > 
> >     cfg80211: regulatory: handle 6 GHz power spectral density (PSD)
> > 
> >     6 GHz regulatory domains introduce power spectral density (PSD).
> >     Allow wiphy-specific regulatory rules to specify these values.
> > 
> > but ...
> > > 
> > > +		if (chan->flags & IEEE80211_CHAN_PSD)
> > > +			chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
> > > +
> > 
> > This is obviously wrong?
> Yes it should change like this:
> 
> 	if ((rrule1->flags & NL80211_RRF_PSD) && (rrule1->flags & 
> NL80211_RRF_PSD))
> 		chan->psd = min_t(s8, rrule1->psd, rrule1->psd);

One of those still should be rrule2 :)

johannes

