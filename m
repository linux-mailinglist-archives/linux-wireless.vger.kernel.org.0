Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6520EE02
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgF3GFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 02:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgF3GFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 02:05:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A6C061755
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 23:05:12 -0700 (PDT)
Received: from [2a04:4540:1401:f200:538:2dce:6e38:ac54]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jq9OH-0000IW-SH; Tue, 30 Jun 2020 08:05:09 +0200
Subject: Re: RFC: Remote Off-Channel CAC for DFS
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <c49513d5-9da7-5545-02e1-ff368f9f6961@tu-ilmenau.de>
 <99ae192566a7c5ae91c6ee92b8c4ddb41a29e34e.camel@sipsolutions.net>
 <9f36bb56-8aa6-e759-5024-cfe5e58e41cf@tu-ilmenau.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <e29a77f8-ed6b-4304-fe99-f9e25ad2a078@phrozen.org>
Date:   Tue, 30 Jun 2020 08:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9f36bb56-8aa6-e759-5024-cfe5e58e41cf@tu-ilmenau.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 29.06.20 22:00, Markus Theil wrote:
> On 6/29/20 9:35 PM, Johannes Berg wrote:
>> Hi,
>>
>> On Mon, 2020-06-29 at 19:40 +0200, Markus Theil wrote:
>>> When using DFS channels, it would be nice, if I could dedicate a small
>>> amount of interfaces only to CAC checking channels and set them
>>> available or unavailable on multiple other remote APs/Mesh Points in
>>> order to use them, when switching to lower utilized channels without
>>> going through a full CAC.
>>>
>>> Whats the opinion on the mailing list about adding a new command to
>>> nl80211 in order to set the DFS state of a currently not used channel
>>> after a Off-Channel CAC on another device nearby, but not on the same
>>> host? The parameters would roughly be the same as for a channel switch
>>> and an additional DFS channel state. Internally, I would trigger the DFS
>>> state sync code between multiple interfaces.
>> But wait, don't we already sync this within the kernel?
> Yes, the kernel already syncs this between interfaces on the same host.
> I'd just like to sync between multiple hosts, in order to make use of
> fast switches to other DFS channels in a mesh network (in my case), if
> some other node nearby already had performed a DFS CAC of a particular
> channel and sync this state between hosts.

This might work on ETSI but certainly not on FCC. With the latest 
changes in regulation zero wait dfs is de-facto no longer possible in 
the FCC domain. the BSS is expected in FCC to do CAC and then has a 2s 
grace period to start transmitting on said channel. If it fails to do so 
the kernel will automatically switch the channel back to usable.

That being said, even in ETSI a distributed non-occupancy list is 
questionable as the BSSs might be quite far apart in your mesh and one 
APs CAC might not produce the same as another.

In the ETSI domain the best thing to do is trigger 4 wideband scans on 
boot. this will cost you 4 minutes but the channels will then be free 
forever, until you detect a radar pulse.

     John

