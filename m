Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323C7105D2A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 00:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUXcd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 18:32:33 -0500
Received: from nbd.name ([46.4.11.11]:32850 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKUXcd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 18:32:33 -0500
Received: from p5dcfba68.dip0.t-ipconnect.de ([93.207.186.104] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iXvw7-0002nq-Ci; Fri, 22 Nov 2019 00:32:31 +0100
Subject: Re: [PATCH] iw: scan: fix double-free in error paths
To:     Brian Norris <briannorris@chromium.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20191121224139.58281-1-briannorris@chromium.org>
 <e86eb7a3-95e1-f9e1-4ab9-aa38a4f4481e@phrozen.org>
 <CA+ASDXPZA5ObVJmhm11OQFP2ngeDZhsr_FAgxSz8P8QX+e7WEA@mail.gmail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <2320ec82-d45b-889f-9f6f-0f26700a92b1@phrozen.org>
Date:   Fri, 22 Nov 2019 00:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+ASDXPZA5ObVJmhm11OQFP2ngeDZhsr_FAgxSz8P8QX+e7WEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/11/2019 00:30, Brian Norris wrote:
> On Thu, Nov 21, 2019 at 3:24 PM John Crispin <john@phrozen.org> wrote:
>>
>> On 21/11/2019 23:41, Brian Norris wrote:
>>> Hit when, for instance, I'm stupid enough to type an invalid scan
>>> command:
>>>
>>>     # iw wlan0 scan -h
>>>     BUG at file position lib/msg.c:572:void nlmsg_free(struct nl_msg *)
>>>     iw: lib/msg.c:572: void nlmsg_free(struct nl_msg *): Assertion `0' failed.
>>>     Aborted (core dumped)
>>>
>>> Fixes: 2f74c59cf11e ("iw: fix memory leaks inside handle_scan")
>>> Cc: John Crispin <john@phrozen.org>
>> wasn't me, nobody saw do anything
>> try
>> 367e7dd3 (Amit Khatri            2015-06-26 09:02:36 +0000  451)
>>                  nlmsg_free(ssids);
>> 367e7dd3 (Amit Khatri            2015-06-26 09:02:36 +0000  452)
>>                  nlmsg_free(freqs);
>> ???
> 
> I don't really care about "who", but it's nice to correctly note "what":
> 
> Your patch added 'goto nla_put_failure' in the DONE case (or
> fallthrough from NONE), which introduced the double-free. Previously,
> it was just a 'return', which meant we needed to do the cleanup in
> 'case DONE'.
> 
> For Amit's patch: note how there's a 'return', which makes his code
> the only possible call to nlmsg_free() (i.e., no double-free).
> 
> Brian
> 

point taken, I see it now :(
	John
