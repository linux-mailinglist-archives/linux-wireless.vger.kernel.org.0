Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3DCFEDE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfJHQYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 12:24:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42582 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfJHQYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 12:24:35 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHsHp-0003yI-DP; Tue, 08 Oct 2019 18:24:33 +0200
Message-ID: <f02b81f6dac29da911f8793b952a9efb6a1fdb62.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Oct 2019 18:24:32 +0200
In-Reply-To: <864267ec-9158-940d-6e0e-db84a395888e@gmail.com> (sfid-20191008_180339_379266_C92398E9)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
         <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
         <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com>
         <6530a6b06176790c5a6949d6ffccf37b506975bd.camel@sipsolutions.net>
         <864267ec-9158-940d-6e0e-db84a395888e@gmail.com>
         (sfid-20191008_180339_379266_C92398E9)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > The scan_req struct contains a reference to which interface is scanning,
> > so it should very well be possible to have
> > 
> > phy0:
> >   wlan0: IFF_UP & scanning
> >   wlan1: IFF_UP & change MAC address all the time
> > 
> > just like it's possible to change the MAC address when wlan1 *isn't*
> > IFF_UP even if wlan0 is scanning, right?
> > 
> 
> Indeed.  But that is not what you were suggesting earlier with just 
> checking local->scanning.  So if scan_req contains a wdev, then yes it 
> should be possible to compare the scan_req->wdev to the interface being 
> changed.

Well, yes, but only because I was incrementally going from James's
patch, which was checking that only.

Similar with the other local-> things being checked here, btw, though in
some cases it might be harder to actually determine which wdev is doing
something and which isn't.

> > No, this typically cannot be fixed, and it doesn't really make sense.
> > The NIC cannot possibly do two scans at a time since it has only a
> > single radio resource :-)
> 
> So why is the scan request not per phy then?  And should mac address 
> even affect the ongoing scan?  Can we simply change it with the scan 
> ongoing?

There are things that affect the scan from the interface, e.g.
capability overrides, (extended) capabilities, the MAC address is used
unless randomization is requested, etc.

johannes

