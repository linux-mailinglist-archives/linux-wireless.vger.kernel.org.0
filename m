Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396A61C0702
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD3Twg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgD3Twf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 15:52:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF4C035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 12:52:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jUFEX-002qIl-3U; Thu, 30 Apr 2020 21:52:33 +0200
Message-ID: <4632fdf9a0587c5e88a58730f970a7e39d5fd0ab.camel@sipsolutions.net>
Subject: Re: [PATCH 06/10] mac80211: add HE 6 GHz Band Capability IE in
 assoc. request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Apr 2020 21:52:31 +0200
In-Reply-To: <cbe6e16fcaebe13053955ff50b351c7f@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
         <1587768108-25248-7-git-send-email-rmanohar@codeaurora.org>
         <faba71a22ecf46d3b2caf0166943ec4e2dc1c6c5.camel@sipsolutions.net>
         <cbe6e16fcaebe13053955ff50b351c7f@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-29 at 17:14 -0700, Rajkumar Manoharan wrote:
> On 2020-04-29 07:33, Johannes Berg wrote:
> > On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
> > > Construct HE 6 GHz band capability element (IEEE 802.11ax/D6.0, 
> > > 9.4.2.261)
> > > for association request and mesh beacon. The 6 GHz capability 
> > > information
> > > is passed from driver through iftypes caps.
> > 
> > Oh. I had some patches for this too but Luca never sent them out...
> > 
> > I'll have to check the differences to see if either of us missed
> > something :)
> > 
> Great.. Would like to see yours changes.

Sure. I'll get to this next week I hope.

>  I also posted similar changes 
> in hostapd for AP mode. Please check them as well.

I saw, but didn't really consider AP mode much yet.

johannes

