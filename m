Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1D233B1B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgG3WIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 18:08:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57109 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgG3WIP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 18:08:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596146893; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RLFa97HrPAGsDxlsGYIm8EEBhnaTyNzG7IeSIgaZrHQ=;
 b=n4gs871DpF9B1T29S5068CN9VLNTPF7qLvfU6H4kl0UDVJP3vPMWb+DnnBH1mmz7I4t01Y4K
 3zX1+laHFAW/oju9C7XxIMRT5Jv6h8AY07KE+cWVKV19JVEX2I3GQOAyo7wM1WV9e6FXOaTW
 6JOGCxxU4Nmu//WvTk8goY6kaVc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f2344cd9403087e10e27564 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 22:08:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CA28C43391; Thu, 30 Jul 2020 22:08:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC087C433CA;
        Thu, 30 Jul 2020 22:08:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jul 2020 15:08:11 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mac80211: Add FILS discovery support
In-Reply-To: <d1b5dd7d9f93d3fc87c58dcfc28c9a3c6b4c923e.camel@sipsolutions.net>
References: <20200618050427.5891-1-alokad@codeaurora.org>
 <20200618050427.5891-3-alokad@codeaurora.org>
 <bb2be4ac581487aa9e89d3c75180a1766b112370.camel@sipsolutions.net>
 <c86a98180879365bab34d8d9eb2f5c3c@codeaurora.org>
 <d1b5dd7d9f93d3fc87c58dcfc28c9a3c6b4c923e.camel@sipsolutions.net>
Message-ID: <78c89ff151efbdff2e579733d6b1d98c@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-30 14:26, Johannes Berg wrote:
> On Thu, 2020-07-30 at 14:00 -0700, Aloka Dixit wrote:
> 
>> > > +	fd = &sdata->vif.bss_conf.fils_discovery;
>> > > +	fd->min_interval = params->min_interval;
>> > > +	fd->max_interval = params->max_interval;
>> > > +
>> > > +	if (!params->tmpl || !params->tmpl_len) /* Optional template */
>> > > +		return 0;
>> >
>> > Now I'm even more confused. If the template is optional, then if it's
>> > not given it doesn't mean *everything* should be ignored, does it?
>> >
>> > What would be the point of that? OTOH, if the template isn't there,
>> > what
>> > would you do?
>> >
>> > But it still doesn't make sense - if no template means you shouldn't do
>> > anything then that doesn't mean the template should be optional, that
>> > just means userspace shouldn't even put the NL80211_ATTR_FILS_DISCOVERY
>> > attribute when it doesn't want anything to be done?
>> >
>> > So it seems to me that something doesn't match. Either the template is
>> > truly optional and then this shouldn't just return success, or the
>> > template isn't actually optional?
>> >
>> 
>> Everything is not ignored, I set the minimum and maximum interval 
>> values
>> before checking for the template so that those are accepted even if
>> template isn't present.
> 
> Right, oops, missed that.
> 
>> For 6GHz, template is required, at least for ath11k driver.
>> But for 2.4GHz and 5GHz FILS discovery transmission is not offloaded 
>> to
>> FW.
> 
> But ... now I'm still confused.
> 
> If you *don't* offload it, how will it work? Will it all bubble up to
> hostapd and that will send the response? Does that work without any
> other changes?
> 
> But then what would you need the min/max for? I guess I still don't
> understand it... I thought this was a periodic frame anyway like 
> beacon,
> so how could you _not_ offload it?
> 

Min and max intervals are used to decide if a FILS discovery frame 
should be sent at all when respective timers expires.
Depending on how close that time is to the next beacons, the device may 
just send the beacon instead.

In lower bands, for non-offloaded case, FW will send events asking for 
the frame until it gets one.
Whether that should go all the way to hostapd or should the driver 
itself handle it remains to be seen.
My current focus is only 6GHz, but didn't want to restrict kernel 
implementation so moved 6GHz related checks to the driver instead.

All in all, making the template mandatory will be safer so that the 
driver will always have one if required.

>> We can make the template mandatory instead and then the respective
>> drivers will choose the handling.
>> Please suggest.
> 
> I have no idea ... still trying to understand it.
> 
>> > > +	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery);
>> > > +	if (err < 0) {
>> > > +		ieee80211_vif_release_channel(sdata);
>> > > +		return err;
>> >
>> > Is there no goto label for this error case?
>> >
>> 
>> Existing function doesn't use goto labels for error cases, only 
>> return.
> 
> Maybe add one? Surely the release_channel() must alraedy exist there
> somewhere.
> 

Okay.

>> > > +	skb = dev_alloc_skb(tmpl->len);
>> > > +	if (skb)
>> > > +		skb_put_data(skb, tmpl->data, tmpl->len);
>> >
>> > You should consider the headroom that the driver may have requested.
>> >
>> 
>> I didn't understand this point, what would the driver request headroom
>> for?
> 
> Whatever it wants for ... drivers are allowed request extra headroom
> (hw->extra_tx_headroom) and we generally honour that for every skb we
> build for the driver.
> 

I will look into other instances to understand this requirement.

> johannes
