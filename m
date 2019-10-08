Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463F5D0200
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfJHUQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 16:16:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47940 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfJHUQl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 16:16:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHvuR-00017J-Bf; Tue, 08 Oct 2019 22:16:39 +0200
Message-ID: <9c49ec27489333d7f27831de19e9d1c9cd65eeee.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Oct 2019 22:16:38 +0200
In-Reply-To: <193168d4-6466-60a4-bc89-c4a44e84ac46@gmail.com> (sfid-20191008_205058_831848_E2C7643E)
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
         <fbb287a82656dd3f89817590e86b23d6968a2822.camel@sipsolutions.net>
         <193168d4-6466-60a4-bc89-c4a44e84ac46@gmail.com>
         (sfid-20191008_205058_831848_E2C7643E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-08 at 13:50 -0500, Denis Kenzior wrote:
> Hi Johannes,
> 
> > > But they shouldn't change due a mac address change?  I wonder if we can
> > > further relax the requirements to allow mac change if
> > > NL80211_SCAN_FLAG_RANDOM_ADDR was used?
> > 
> > No, at least with HW scan that would completely confuse the driver -
> > since from the driver's POV we'd remove the interface it's currently
> > managing the scan for.
> 
> So help me understand this better.

include/net/mac80211.h:

       int (*hw_scan)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
                      struct ieee80211_scan_request *req);

How is it difficult to understand that with an API like that, it might
not be a good idea to remove the vif from the driver while it's
scanning?


>   Just by virtue of copying the new 
> mac into sdata->vif.addr 

That's not what happens?

johannes

