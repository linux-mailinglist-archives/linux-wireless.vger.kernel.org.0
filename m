Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891C5BF894
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIUIF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIUIF0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 04:05:26 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8D543E6
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2A1xnRYbbdPEIiDyZ2vo1w9WQFQRkUmEv9A64dYYr7I=; b=OGLismyjw9AaYJPx79iarTISug
        9Zg+KpVcm/N5qWZJAJqFda65cBoSFlnd3os+yv6IW0QkBL+9a3ogDqHiKi8WpbnarQ9ZLdY9CyXfl
        JuscdM8exHBgy9QSPHQ9TctdSdtWNMnbJEXuPvPlbyYQrP9Yd/8IyEZbR50kTg5blm4k=;
Received: from p200300daa7301d00a986799c2cf5dafb.dip0.t-ipconnect.de ([2003:da:a730:1d00:a986:799c:2cf5:dafb] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oaujS-006UCc-U9; Wed, 21 Sep 2022 10:05:23 +0200
Message-ID: <4040f674-8430-69ba-1b6f-f9fd92da413d@nbd.name>
Date:   Wed, 21 Sep 2022 10:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Content-Language: en-US
To:     Venkat Ch <venkatch@gmail.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Venkat Chimata <venkata@shasta.cloud>
References: <20220915043527.737133-1-venkatch@gmail.com>
 <238a21a8-c97b-5a38-6c08-9057055bf73f@nbd.name>
 <CABHL29H75U-0dBP14d-6ds-xMPt1eqrvQPuMp3oY8qQS8Y3Dbw@mail.gmail.com>
 <9acc4159-8223-bbca-a83f-d075660ac6db@nbd.name>
 <CABHL29GB6DCrdu4FzRfBDSj9A7pwqnWE+wgH2xfkBMLjT3bAxA@mail.gmail.com>
 <f75ad975-8b76-f3e6-151b-6eda552c0431@nbd.name>
 <CABHL29GUgta4Ke3sxbongMSK__cruTaDYCXe1-yEDL3WA3mO9Q@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v2] wifi: mac80211: Fix performance issue with mutex_lock
In-Reply-To: <CABHL29GUgta4Ke3sxbongMSK__cruTaDYCXe1-yEDL3WA3mO9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20.09.22 21:23, Venkat Ch wrote:
> Hi Felix,
> 
>   Following is the background of the problem, how I traced to
> mutex_lock and why I propose rcu locks.
> 
> Issue:
>   On a 10Mbps upload / 50 Mbps download connection, the following issue reported.
> 
> Video periodically freezes and/or appears delayed when on Zoom or Teams.
> 1. Video will freeze for 10 or 15 seconds periodically when on a call,
> but audio continues and the session doesn't drop.
> 2. The video  still works but it appears delay (I move, but the video
> of my movement is noticeably delay by a second or so)
> 
> Tracing to mutex_lock(sta_mutex):
> 
>   When I investigated, I found that the ucentral agent in openwifi
> fetches the station list periodically.  Without the station list
> fetch, the video quality is just fine. I investigated the station list
> path and found this mutex_lock. I also see that earlier it was
> rcu_lock which protected the station list in this path. In this
> commit, https://github.com/torvalds/linux/commit/66572cfc30a4b764150c83ee5d842a3ce17991c9,
> rcu lock was changed to mutex lock without providing any reason.
The reason seems clear to me, even though it was not explicitly stated 
in the commit message: in sta_set_sinfo it introduces a call to a driver 
op that is allowed to sleep.

> I also saw this comment just above the sta_mutex declaration.
>          /* Station data */
>          /*
>           * The mutex only protects the list, hash table and
>           * counter, reads are done with RCU.
>           */
>          struct mutex sta_mtx;
> 
> So I reverted back the mutex_lock with rcu_lock and it just worked
> fine. We tested for more than 2 weeks before concluding this analysis.
> 
> I think the usage of mutex_lock is impacting the tx / rx path
> somewhere and hence the issue. It is a challenge to trace the exact
> function though.

I don't see any critical part in the tx/rx path which depends on the 
sta_mtx lock. My guess is that for some reason your change is simply 
accidentally papering over the real bug, which may be somewhere else 
entirely, maybe even in the driver. A freeze for 10-15 seconds 
definitely does not sound like simple lock contention on the mutex, 
since a single station dump will be much faster than that.

- Felix
