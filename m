Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95770467D3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFNSq7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 14:46:59 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48038 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNSq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 14:46:59 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbrDm-0000jX-4d; Fri, 14 Jun 2019 20:46:42 +0200
Message-ID: <231c9afd2aaca99c89bc73954307a28a60e86d18.camel@sipsolutions.net>
Subject: Re: [PATCH-v3 1/2] wireless: Support assoc-at-ms timer in sta-info
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 14 Jun 2019 20:46:40 +0200
In-Reply-To: <7d606df7-bb8e-c454-1eaf-24fd454eab8e@candelatech.com>
References: <20190415172123.6532-1-greearb@candelatech.com>
         <21fa668485f4eb0a8056aac1797854f267d5f1e0.camel@sipsolutions.net>
         <3ad69c55-2b88-a96b-d21e-99f4418466ee@candelatech.com>
         <e8343919c6851e6b5a7905b708661870c4c88481.camel@sipsolutions.net>
         <7d606df7-bb8e-c454-1eaf-24fd454eab8e@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 08:14 -0700, Ben Greear wrote:
> 
> 
> So, maybe I return instead the elapsed time in the netlink API instead of a
> timestamp.  I think that will give me the value that I am looking for,
> and I can still print out the 'real' time in iw so any tools reading that
> output and do some simple math and figure out the 'real' associated-at time.

I don't think that's good. There's a delay between filling the message
and then processing it in userspace. We had this in the scan code and
learned that was full of races.

The better thing is to use CLOCK_BOOTTIME nanoseconds, and then
userspace can use clock_gettime() to get the current time etc. and then
do whatever calculations it needs. If it wants to print the realtime
timestamp, it could even calculate that (with some jitter) by doing
clock_gettime() on both realtime and boottime clocks...

johannes

