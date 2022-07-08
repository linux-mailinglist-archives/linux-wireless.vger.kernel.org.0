Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09C56BF46
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiGHQmm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 12:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiGHQmm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 12:42:42 -0400
X-Greylist: delayed 94183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Jul 2022 09:42:39 PDT
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FF3F71BC6
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 09:42:39 -0700 (PDT)
Message-ID: <ba8e3ae1-70a9-e016-6c44-ae0c52f97e8e@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1657298555;
        bh=IByOfmBF1TQgJlwVpl2pS7M28VEsjYCsdWbP9aoeGwI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LaIYQ2OkZALjvyVxNvi5UlaDjnURNqW1ebUdSPfkx2rn85y/Tv92bG8uamjk2lWKW
         8PbGJjH4+OaF2iKDhwrXpEJwJnMmbTatysLcb2KAdUyH2IjA8qCv2jEN5FvOL5mVRl
         qCP9Wcya3vChzmwuimVQM5egTykiCdx2qjDAV1Hc=
Date:   Fri, 8 Jul 2022 18:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] mac80211: Switch all drivers over to iTXQs
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20220707143230.21686-1-alexander@wetzel-home.de>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <20220707143230.21686-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> This patch is working for at least iwldvm. It exposes what seems to
> be an existing iwldvm driver bug, though. Driver and card continues
> to work, making that a minor side show for now. (I started to look into
> that a bit, maybe more about that in another mail later.)
> Initial tests are indicating comparable speeds in my setup for iwldvm,
> maybe trending to be a bit slower.
> 
> For now I'm interested what I may have missed or what should be done
> differently, so we dare to merge it. I'll planning to run some more
> tests and use iwldvm with this patch on my main workstation for some
> days at least.

I followed up on the iwldvm driver issue.
The problem is, that the push API drivers are expecting that tx 
immediately stops after calling ieee80211_stop_queue(). And this patch 
breaks that.

For iwldvm this happens:
- the HW queues are getting full, iwldvm calls ieee80211_stop_queue()

- the (patched) mac80211 stops the queue but is not aborting the running
   wake_tx_queue() tasklet. Which goes on to hand over skbs to the driver

- The driver runs out of the "internal reserve" hw buffers and starts to
   add the new skbs to the overflow queue

- some hw buffers are reclaimed and the driver tries to process the skbs
   in the overflow q

- For that it releases the internal lock for tx, assuming mac80211
   stopped handing over skbs

- the still running wake_tx_queue() function from mac80211 hands over
   the next skb, grapping the slot(s) intended to be used for the skbs in
   the driver overflow queue.

- which breaks an iwlwifi internal rule how sequence numbers are mapped
   to hw queue slots, causing the warning I got.

I'll fix that and send a new patch.

Alexander
