Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4486CC104
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfJDQpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 12:45:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39149 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDQpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 12:45:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so4229747pff.6
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dy9c5jy1WO8iG2RAovohNXkEBTm3UmsW8V3bX9kYX5w=;
        b=gvpVQd2Qd8sy34tWCiUNVl1kS319qHFq5yPN5CLYUVfsvGSHpni3sF9CttLNzGcvNp
         RFEnBcN9w/JUV1ShUGgx4dKVAq0MSJG3Ril2sd9h7WmI1WV5AfKEIcvPAK9bNC79e00n
         H06QMsdPTEtcSdLpmzzXRTNQR3uNpn+VhrXXkryzKz8mBaZnifHHGZsxPm40lmwFA0vT
         /D3RUaodp5RPyGwbes98e/XMrg1ydXlF+XeuGpoLsTsoGulEEqMCLLMaXbfZj8X5ilWc
         fMMak93fgTq1Bn2gwaIdePvK4WTVwByzynxnjC6i+FlLeQk3Kuiim9ANtflIYZBkze5y
         p0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dy9c5jy1WO8iG2RAovohNXkEBTm3UmsW8V3bX9kYX5w=;
        b=fJnWsTDI5vKWuG/MNSP85F7TGCnjN3reeiKXdOxnytCjH7pwthO/p9rpbwl5WgbcZ1
         OnsG0ck7G3Lg6dLum35uDJzlDoj3a/MF5ntCDbwosA0UeD2dXNPhZhkwux4pnxPAV1CN
         k3Vc6LNp1vXLxwXHfTrXzFMgv4xe7TRAvqCkyGXCjpjegyWIO+8hXyUKiKxp95RdQ9eQ
         BqJaGXEyDZ/YSNxCuYA/kzDlNUeG2w/Q6NgUekThnMrOKOoLUitFEaJIzcO2TYD533Cw
         gf811PT0NIjfzYN1HUReiNY8cz2RvStFGlvvOm659xwwepPfo0tweoYaIoNZRHD18wXQ
         gxDw==
X-Gm-Message-State: APjAAAUbKo3x3RKGOVRye1SkFzCQOiqzdi0iOkHAJJuwjV77dQPrwK9C
        mMWEjccXGfhoLY1z0UA/x5Y=
X-Google-Smtp-Source: APXvYqzouyeEun/x5HwFOtRfGF80A7bDPzKDEjt4UKiwBmzA42RYzuHGC+ECEA1O76MOVRv1lXRn3Q==
X-Received: by 2002:a17:90a:332c:: with SMTP id m41mr17498886pjb.22.1570207514357;
        Fri, 04 Oct 2019 09:45:14 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id h14sm7690082pfo.15.2019.10.04.09.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 09:45:13 -0700 (PDT)
Message-ID: <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:42:58 -0700
In-Reply-To: <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         (sfid-20190913_220113_985031_7C3A66BD) <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

After thinking about this more:

On Fri, 2019-10-04 at 09:25 -0700, James Prestwood wrote:
> On Fri, 2019-10-04 at 13:56 +0200, Johannes Berg wrote:
> > Hi,
> > 
> > I was tempted to apply this (sans the feature advertisement part
> > that
> > I
> > don't think should be in nl80211), but:
> > 
> > > 
> > > Signed-off-by: James Prestwood <prestwoj@gmail.com>
> > 
> > Please add a commit log.
> > 
> > > +static int ieee80211_can_live_addr_change(struct
> > > ieee80211_sub_if_data *sdata)
> > > +{
> > > +	if (netif_carrier_ok(sdata->dev))
> > > +		return -EBUSY;
> > > +
> > > +	switch (sdata->vif.type) {
> > > +	case NL80211_IFTYPE_AP:
> > > +	case NL80211_IFTYPE_P2P_GO:
> > > +	case NL80211_IFTYPE_AP_VLAN:
> > > +	case NL80211_IFTYPE_WDS:
> > > +	case NL80211_IFTYPE_MESH_POINT:
> > > +	case NL80211_IFTYPE_MONITOR:
> > > +	case NL80211_IFTYPE_OCB:
> > > +		/* No further checking required, when started or UP
> > > these
> > > +		 * interface types set carrier
> > > +		 */
> > > +		break;
> > > +	case NL80211_IFTYPE_ADHOC:
> > > +		if (sdata->u.ibss.ssid_len != 0)
> > > +			return -EBUSY;
> > 
> > Can you please document why this is there? Maybe all of the
> > conditions,
> > for that matter.
> > 
> > I'm not even entirely sure it _is_ needed - if we've still not
> > created
> > the IBSS but are scanning for it or trying to merge the MAC address
> > won't really matter yet? Probably?
> 
> I guess its just paranoia, rather be safe than sorry. I can take this
> out, but is "Probably?" a good reason? ;)
> 
> > 
> > > +		break;
> > > +	case NL80211_IFTYPE_STATION:
> > > +	case NL80211_IFTYPE_P2P_CLIENT:
> > > +		if (!list_empty(&sdata->local->roc_list) ||
> > > +					!sdata->local->scanning)
> > > +			return -EBUSY;
> > 
> > AP, mesh and other interfaces *can* scan, so that test should be
> > pulled
> > out to be generic - but then in fact all of them should probably be
> > generic - ROC maybe can't be done on other interfaces yet, but
> > unless
> > you're going to check *which* interface is actually doing the ROC,
> > you
> > should just make that a generic check that applies to all
> > interfaces.
> 
> Ok so no switch statement, simply just check that we aren't
> offchannel
> or scanning. I guess this would then cover the IBSS case too.
> 
> > 
> > If you do care about this being more granular then you should check
> > *which* interface is scanning, and then you can still switch the
> > MAC
> > address for *other* interfaces - but I'd still argue it should be
> > independent of interface type.

So yes these can scan, but this should be covered by the
netif_carrier_ok check which is done first. We can just remove the
switch entirely, but the roc_list/scanning check only matters for
station/p2p_client so checking for the other interface types is kinda
pointless and redundant.

Also I am not sure what you mean by *which* interface. This function is
called on a single interface, so checking what other interfaces are
doing seems strange...

> 
> > 
> > And, I'm confused, but isn't the polarity of the scanning check
> > wrong?
> 
> Ah yeah, after you pointed that out I realized 'scanning' is a bit
> field. I should be doing:
> 
> test_bit(SCAN_HW_SCANNING, &sdata->local->scanning)
> 
> Feel free the merge this, but I haven t had a chance yet to look into
> adding a flag to RTNL (based on what you said in your previous
> email).
> Without some way of telling userspace this is supported, its kinda
> useless IMO.
> 
> Either way I'll send another patch with these things addressed.
> 
> Thanks,
> James
> 
> > 
> > johannes
> > 
> 
> 

