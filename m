Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4053F85F7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhHZK7L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 06:59:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31378 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241906AbhHZK7K (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 06:59:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629975503; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=xZ9f5YweIHW3EJbHkWywB5FAVNNQmgT1gvPPdXZDi6M=;
 b=eakUkB5iQXTXhPlik8npZCDpPb22nEfyCguRbzIPWQODdTQwXq5DPsGmxGU/a0RCTci3TB2B
 l9Dhh7SK6foIhn1wZX9HUgRABxXozbf3QjxcaEo7RoGae+daLx3U4KKCIXde9vWFOZ6+1wtV
 7rGzPdiqK3xL1/WMCgvj/hyEzlY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 612773cfd15f4d68a2efe1da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 10:58:23
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F5F6C43460; Thu, 26 Aug 2021 10:58:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAA95C4338F;
        Thu, 26 Aug 2021 10:58:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Aug 2021 18:58:21 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 5/8] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <b3d00d00525bbc2a31653df6c0ce72cfb4d1c8d7.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-6-wgong@codeaurora.org>
 <101b523a6fe06fea3e1c9642a1bf5e85a9d0e680.camel@sipsolutions.net>
 <4eca272868dae4f7a923656a12b03024@codeaurora.org>
 <b3d00d00525bbc2a31653df6c0ce72cfb4d1c8d7.camel@sipsolutions.net>
Message-ID: <ed8cc5660a16e2249f3043401de2ad98@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 18:56, Johannes Berg wrote:
> On Thu, 2021-08-26 at 18:43 +0800, Wen Gong wrote:
>> On 2021-08-26 16:25, Johannes Berg wrote:
>> > I was going to apply this and patch 4 squashed, saying:
>> >
>> >
>> >     cfg80211: regulatory: handle 6 GHz power spectral density (PSD)
>> >
>> >     6 GHz regulatory domains introduce power spectral density (PSD).
>> >     Allow wiphy-specific regulatory rules to specify these values.
>> >
>> > but ...
>> > >
>> > > +		if (chan->flags & IEEE80211_CHAN_PSD)
>> > > +			chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
>> > > +
>> >
>> > This is obviously wrong?
>> Yes it should change like this:
>> 
>> 	if ((rrule1->flags & NL80211_RRF_PSD) && (rrule1->flags &
>> NL80211_RRF_PSD))
>> 		chan->psd = min_t(s8, rrule1->psd, rrule1->psd);
> 
> One of those still should be rrule2 :)
> 
yes
     if ((rrule1->flags & NL80211_RRF_PSD) && (rrule2->flags & 
NL80211_RRF_PSD))
         chan->psd = min_t(s8, rrule1->psd, rrule2->psd);
     else
         chan->flags &= ~NL80211_RRF_PSD;
> johannes
