Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16A7DFEF4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Nov 2023 06:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjKCFz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Nov 2023 01:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCFz6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Nov 2023 01:55:58 -0400
Received: from mx4.wp.pl (mx1.wp.pl [212.77.101.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C7CA
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 22:55:51 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 11091 invoked from network); 3 Nov 2023 06:55:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1698990948; bh=SS+0CxFlTXhHHVezauyHh5OCKnB6A8gc2DZwzA4C8+A=;
          h=From:To:Cc:Subject;
          b=saV4Pz94WRTVNFxhWlf+ZiqQ3ZomKX4+JJrcDSXVkuHRg9i4Zgh0Xfsjb6V3dFXtA
           7bNHLm4nwpHzBlSObLQS+K8Sh4Tukiy/Xl4/JXgh5dBvE86KMsMZK4/7H8FLY8kAnE
           kGs4GQLBRjwcFmvu5SAxX+RWu1nWlAlKctPoczOA=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 3 Nov 2023 06:55:47 +0100
Date:   Fri, 3 Nov 2023 06:55:47 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: rt2x00: restart beacon queue when hardware
 reset
Message-ID: <20231103055547.GA27419@wp.pl>
References: <20231101090710.GB552433@wp.pl>
 <TYAP286MB031594295F216D06BD076F4FBCA6A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB031594295F216D06BD076F4FBCA6A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: f9b46c954e2705caab55806a4ac53dad
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ESMU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 02, 2023 at 08:36:04PM +0800, Shiji Yang wrote:
> On Wed, 1 Nov 2023 10:07:10 +0100, Stanislaw Gruszka wrote:
> 
> >On Sat, Oct 28, 2023 at 08:15:32PM +0800, Shiji Yang wrote:
> >> When a hardware reset is triggered, all registers are reset, so all
> >> queues are forced to stop in hardware interface. However, mac80211
> >> will not automatically stop the queue. If we don't manually stop the
> >> beacon queue, the queue will be deadlocked and unable to start again.
> >> This patch fixes the issue where Apple devices cannot connect to the
> >> AP after calling ieee80211_restart_hw().
> >
> >Should not this be solved in mac80211 then? ieee80211_restart_work
> >does a lot o diffrent things, why beconing is not also
> >stoped/started there ? 
> >
> >Regards
> >Stanislaw
> >
> 
> Hi! Thanks for your review.
> 
> I think this issue is a bug of the rt2x00. When restart is called,
Yes, I think you have right, this is rt2x00 issue. 

> mac80211 didn't call rt2x00mac_bss_info_changed() to update the
> flag (This may be expected? I'm not sure. But all other Tx/Rx queues
> are also manually disabled). And after resetting,
> 'bss_conf->enable_beacon' and 'intf->enable_beacon' are still true.
> Though mac80211 will call this function and try to enable the beacon
> queue again. However, both 'if' and 'else if' blocks will never be
> entered anymore because all conditions are false. This patch just
> fixes this dead lock.
Ok, I see. 

I don't remember how this supposed to work. I see we do 

        for (i = 0; i < queue->limit; i++) {
                entry = &queue->entries[i];
                clear_bit(ENTRY_BCN_ASSIGNED, &entry->flags);
        }

in rt2800_pre_reset_hw() But I think what should be done there is
clear intf->enable_beacon for each interface. 

Now I don't remember how I tested this, probably only in STA mode.

> Maybe Kalle Valo knows if it's a mac80211 bug. This issue has been
> here for several years.
> 
> Looking forward to your reply.

:-)  

> By the way, it seems that 'intf_beaconing' variable is useless. Does
> it really can be increased to '2'? Maybe in multi ssid mode?

Yes. When you can have multiple vif interfaces this variable 
can be bigger than 1. We advertise support for that for AP
and mesh interfaces in rt2x00lib_set_if_combinations().

> 		} else if (bss_conf->enable_beacon && !intf->enable_beacon) {
> 			rt2x00dev->intf_beaconing++;
> 			intf->enable_beacon = true;
> 			/*
> 			 * Upload beacon to the H/W. This is only required on
> 			 * USB devices. PCI devices fetch beacons periodically.
> 			 */
> 			if (rt2x00_is_usb(rt2x00dev))
> 				rt2x00queue_update_beacon(rt2x00dev, vif);
Hmm, maybe I also tested on AP USB, but don't remember.

Thanks for explanations! Patch is ok for me.

Regards
Stanislaw

