Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185EF234121
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgGaIVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 04:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbgGaIVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 04:21:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D5C061574;
        Fri, 31 Jul 2020 01:21:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k1QIL-00E0Sn-O6; Fri, 31 Jul 2020 10:21:37 +0200
Message-ID: <1005f6fa9d017241b47ec925ce0aa5432926b51c.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/2] mac80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Date:   Fri, 31 Jul 2020 10:21:36 +0200
In-Reply-To: <78c89ff151efbdff2e579733d6b1d98c@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
         <20200618050427.5891-3-alokad@codeaurora.org>
         <bb2be4ac581487aa9e89d3c75180a1766b112370.camel@sipsolutions.net>
         <c86a98180879365bab34d8d9eb2f5c3c@codeaurora.org>
         <d1b5dd7d9f93d3fc87c58dcfc28c9a3c6b4c923e.camel@sipsolutions.net>
         <78c89ff151efbdff2e579733d6b1d98c@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 15:08 -0700, Aloka Dixit wrote:

> Min and max intervals are used to decide if a FILS discovery frame 
> should be sent at all when respective timers expires.
> Depending on how close that time is to the next beacons, the device may 
> just send the beacon instead.

Right, OK.

> In lower bands, for non-offloaded case, FW will send events asking for 
> the frame until it gets one.

Aha.

> Whether that should go all the way to hostapd or should the driver 
> itself handle it remains to be seen.

I don't see why it should go up - the driver can have the template and
answer that? I mean, we already push the template down.

> My current focus is only 6GHz, but didn't want to restrict kernel 
> implementation so moved 6GHz related checks to the driver instead.

It might still make sense to have a bitmap of where FILS discovery is
supported, if it's different for different bands?

Unless of course you think that a given device will always support FILS
discovery on all bands, you just haven't implemented it yet for all
bands - but will complete it before really enabling it in the driver?

> All in all, making the template mandatory will be safer so that the 
> driver will always have one if required.

Agree.

Thanks!

johannes

