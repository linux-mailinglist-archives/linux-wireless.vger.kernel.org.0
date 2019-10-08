Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F08CFF8C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJHRIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 13:08:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43520 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfJHRIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 13:08:32 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHsyN-00054j-1u; Tue, 08 Oct 2019 19:08:31 +0200
Message-ID: <fbb287a82656dd3f89817590e86b23d6968a2822.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Oct 2019 19:08:28 +0200
In-Reply-To: <1bb5450b-bc4e-8c83-f99e-fc7e739b08f0@gmail.com> (sfid-20191008_183311_878473_B38C04A4)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
         <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
         <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com>
         <6530a6b06176790c5a6949d6ffccf37b506975bd.camel@sipsolutions.net>
         <864267ec-9158-940d-6e0e-db84a395888e@gmail.com>
         <f02b81f6dac29da911f8793b952a9efb6a1fdb62.camel@sipsolutions.net>
         <1bb5450b-bc4e-8c83-f99e-fc7e739b08f0@gmail.com>
         (sfid-20191008_183311_878473_B38C04A4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > > > No, this typically cannot be fixed, and it doesn't really make sense.
> > > > The NIC cannot possibly do two scans at a time since it has only a
> > > > single radio resource :-)
> > > 
> > > So why is the scan request not per phy then?  And should mac address
> > > even affect the ongoing scan?  Can we simply change it with the scan
> > > ongoing?
> > 
> > There are things that affect the scan from the interface, e.g.
> > capability overrides, (extended) capabilities, the MAC address is used
> > unless randomization is requested, etc.
> > 
> 
> But they shouldn't change due a mac address change?  I wonder if we can 
> further relax the requirements to allow mac change if 
> NL80211_SCAN_FLAG_RANDOM_ADDR was used?

No, at least with HW scan that would completely confuse the driver -
since from the driver's POV we'd remove the interface it's currently
managing the scan for.

johannes

