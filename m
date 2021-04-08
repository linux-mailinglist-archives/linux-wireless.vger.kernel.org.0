Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67890358161
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHLLu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 07:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhDHLLu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 07:11:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664F4C061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 04:11:39 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUSZU-008yRl-3z; Thu, 08 Apr 2021 13:11:36 +0200
Message-ID: <cb0a3bac83f4e56c7b1c0b049080d4f4186bed72.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] nl80211: Add support for beacon tx mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Date:   Thu, 08 Apr 2021 13:11:34 +0200
In-Reply-To: <2718995.X0rUDs3ZmB@ripper> (sfid-20210222_113458_463202_DAC50CAC)
References: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org>
         <1613988573-10839-2-git-send-email-mkenna@codeaurora.org>
         <2718995.X0rUDs3ZmB@ripper> (sfid-20210222_113458_463202_DAC50CAC)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-02-22 at 11:32 +0100, Sven Eckelmann wrote:
> On Monday, 22 February 2021 11:09:31 CET Maharaja Kennadyrajan wrote:
> > User can configure the beacon tx mode while bring-up the AP
> > or MESH. Hence, added the support in the nl80211/cfg80211
> > layer to honour the beacon tx mode configuration and pass
> > this value to the driver.
> 
> There is not a definition what this actually means. But I am guessing that you 
> are mean the way the HW sends our the beacons for a multivif (beaconing) 
> setup. And in this case, it is a per "phy" setting and not a per AP/meshpoint 
> setting, right?

In addition, the commit logs are not explaining anything, why you'd use
it, why it's necessary, etc.

I'll say it again: @codeaurora folks, consider the community, not just
your own driver. I'm really getting tired of having to extract
information from you.

johannes

