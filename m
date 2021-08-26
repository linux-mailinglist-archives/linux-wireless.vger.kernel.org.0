Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6E3F8600
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 13:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241692AbhHZLCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:02:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11220 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241491AbhHZLCl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:02:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629975714; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uMWtL2dwizJJtFTSEw5cH9UyiSvAd8WzrKtTJiAun4Q=;
 b=jKdZLdteikgc8POTMzbwr1ym0Eh1GFX5GfEPTSHQ4gHZHRoHsKTU6TnSAfkyp8KFTIU4jtDO
 eONi77kJCacBwWM1EBu9ulXI8X5LWHKN8jk1h26kGHz+/IfMaO5WPNCFOkdiSoRqGYXBHHkw
 SF/zFhZSeP7+SR96XEiRdk1lUhE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6127748ad6653df767e0018a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 11:01:30
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F33AEC43460; Thu, 26 Aug 2021 11:01:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E8754C4338F;
        Thu, 26 Aug 2021 11:01:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Aug 2021 19:01:28 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
In-Reply-To: <7e07a64f33bc1a1ca09e36d6152628478a622b69.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-2-wgong@codeaurora.org>
 <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
 <e6006814059d085a1f57af24b9561dde@codeaurora.org>
 <7e07a64f33bc1a1ca09e36d6152628478a622b69.camel@sipsolutions.net>
Message-ID: <77226d0fba70d65f63b40c1b90ade3dd@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 18:59, Johannes Berg wrote:
> On Thu, 2021-08-26 at 18:57 +0800, Wen Gong wrote:
>> On 2021-08-26 16:20, Johannes Berg wrote:
>> > >  struct cfg80211_chan_def {
>> > >  	struct ieee80211_channel *chan;
>> > > @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
>> > >  	u32 center_freq2;
>> > >  	struct ieee80211_edmg edmg;
>> > >  	u16 freq1_offset;
>> > > +	enum nl80211_ap_reg_power power_type;
>> >
>> > I'm not sure why this should be in the chandef, there's no way that
>> > anything in cfg80211 is ever using it there, at least in your patches.
>> >
>> It is used in mac80211 of [PATCH v2 3/8] mac80211: add parse 
>> regulatory
>> info in 6 GHz operation information.
>> should i move it to mac80211's .h file?
>> > > +/**
>> > > + * enum nl80211_ap_reg_power - regulatory power for a Access Point
> [...]
>> >
>> It is used in mac80211 of [PATCH v2 3/8] mac80211: add parse 
>> regulatory
>> info in 6 GHz operation information.
>> should i move it to mac80211's .h file?
> 
> Yeah I saw both of them are used, but why are they defined as nl80211
> API? Do you have any intention to set them through nl80211?
> 
> And like I said, I'm not really convinced this belongs into struct
> cfg80211_chan_def either. Maybe it should be in bss_conf too?
yes, I also want to move it to struct ieee80211_bss_conf.
> 
> johannes
>> 
