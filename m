Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8ECC0A2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfJDQ25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 12:28:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41665 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730959AbfJDQ14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 12:27:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so4191367pfh.8
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WdHWxCro7/+gzJqAmJkc2OtyG5OYU9BVwAYtQQouyrU=;
        b=g+kawH0w9Ahf0eohGz7mrCuIijmksCPTcFiIvvgKvJ4xftuZVqCOgjhnn+0ZSfp55y
         YBDeFokZxeuBiQXiROF48jHqMgzrbqSUO8yuNL0q9RxOLnVDKZEhkf9QKi7abXNs8DIp
         ObrqMqb2/hliaS0rDQPm1jr8bDTiYGndfizOZtoSLWJPux0Tt/enuwx4dGveRQfHJuHq
         TDgl6IxGFmI9vyaqwX95bQXwYUoLizSPd8v5HW3pMpbV4ChNW6xzx9Jkkwen34HpvSEB
         8kr2GO5vmz7DIajBDzlm9YybH/1LXtGMk/IGs7KZrYSz5AcofSJEbDQw587aRGZxa/67
         J95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdHWxCro7/+gzJqAmJkc2OtyG5OYU9BVwAYtQQouyrU=;
        b=eBqLcVSaePsbWM1dao//lJlCbhuh90HzdUuePQrbUCqC++db5Xb4i7czHJJYLQu61w
         fblIip5v9lXVcVfU/ICoH9ZmK734N/gsOC8pj8sfWavI6IaCyGtVwSu/N+vbhPmCFbxG
         KgzN6gZdJBTFjUQWm5P/msvLvKY8ePeanhgw5a4TWd8uD08vBQ672V3aCz0oq27tC6OM
         e6lvk5psGzyGibZtztWepdHc3tTORmJR1WJV2C8+DNTfG94W06LAGUdyG5wxInwRNHxr
         M32UKMEXVvxYIZcu8AT5NaIYFzKKClye7f7f72O6e6BVvSIWu4ZLvJWbfs+PGB+BW0/h
         VZ9A==
X-Gm-Message-State: APjAAAV4v168ttRjGbkcSwnv4HgVzZLan+zIA5U7ZF750deglTEOi3i2
        MqsdIb5K7OhvDhi/Lq5E/H2uHld5
X-Google-Smtp-Source: APXvYqwMg7E3oX+WiX9yU//MWrv2cacPSDJCj2LwAtkdhIRtBg7LNyKdVIfcYH1D5YleLF51f+tvOA==
X-Received: by 2002:a63:205:: with SMTP id 5mr2428350pgc.77.1570206473983;
        Fri, 04 Oct 2019 09:27:53 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id s10sm4751956pgn.9.2019.10.04.09.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 09:27:53 -0700 (PDT)
Message-ID: <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:25:37 -0700
In-Reply-To: <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         (sfid-20190913_220113_985031_7C3A66BD) <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-04 at 13:56 +0200, Johannes Berg wrote:
> Hi,
> 
> I was tempted to apply this (sans the feature advertisement part that
> I
> don't think should be in nl80211), but:
> 
> > 
> > Signed-off-by: James Prestwood <prestwoj@gmail.com>
> 
> Please add a commit log.
> 
> > +static int ieee80211_can_live_addr_change(struct
> > ieee80211_sub_if_data *sdata)
> > +{
> > +	if (netif_carrier_ok(sdata->dev))
> > +		return -EBUSY;
> > +
> > +	switch (sdata->vif.type) {
> > +	case NL80211_IFTYPE_AP:
> > +	case NL80211_IFTYPE_P2P_GO:
> > +	case NL80211_IFTYPE_AP_VLAN:
> > +	case NL80211_IFTYPE_WDS:
> > +	case NL80211_IFTYPE_MESH_POINT:
> > +	case NL80211_IFTYPE_MONITOR:
> > +	case NL80211_IFTYPE_OCB:
> > +		/* No further checking required, when started or UP
> > these
> > +		 * interface types set carrier
> > +		 */
> > +		break;
> > +	case NL80211_IFTYPE_ADHOC:
> > +		if (sdata->u.ibss.ssid_len != 0)
> > +			return -EBUSY;
> 
> Can you please document why this is there? Maybe all of the
> conditions,
> for that matter.
> 
> I'm not even entirely sure it _is_ needed - if we've still not
> created
> the IBSS but are scanning for it or trying to merge the MAC address
> won't really matter yet? Probably?

I guess its just paranoia, rather be safe than sorry. I can take this
out, but is "Probably?" a good reason? ;)

> 
> > +		break;
> > +	case NL80211_IFTYPE_STATION:
> > +	case NL80211_IFTYPE_P2P_CLIENT:
> > +		if (!list_empty(&sdata->local->roc_list) ||
> > +					!sdata->local->scanning)
> > +			return -EBUSY;
> 
> AP, mesh and other interfaces *can* scan, so that test should be
> pulled
> out to be generic - but then in fact all of them should probably be
> generic - ROC maybe can't be done on other interfaces yet, but unless
> you're going to check *which* interface is actually doing the ROC,
> you
> should just make that a generic check that applies to all interfaces.

Ok so no switch statement, simply just check that we aren't offchannel
or scanning. I guess this would then cover the IBSS case too.

> 
> If you do care about this being more granular then you should check
> *which* interface is scanning, and then you can still switch the MAC
> address for *other* interfaces - but I'd still argue it should be
> independent of interface type.

I think maybe in the future we might want this, but for now lets not
worry about it. But just to make sure we are on the same page, your
talking about e.g. hardware with multiple radios so you could be doing
offchannel work/scanning/connecting simultaneously without having to
wait for the current operation to complete?

> 
> And, I'm confused, but isn't the polarity of the scanning check
> wrong?

Ah yeah, after you pointed that out I realized 'scanning' is a bit
field. I should be doing:

test_bit(SCAN_HW_SCANNING, &sdata->local->scanning)

Feel free the merge this, but I haven t had a chance yet to look into
adding a flag to RTNL (based on what you said in your previous email).
Without some way of telling userspace this is supported, its kinda
useless IMO.

Either way I'll send another patch with these things addressed.

Thanks,
James

> 
> johannes
> 

