Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3750620DAC1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgF2UAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 16:00:19 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51012 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbgF2UAI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 16:00:08 -0400
Received: from [192.168.178.24] (unknown [91.53.47.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id AAFFB580076;
        Mon, 29 Jun 2020 22:00:06 +0200 (CEST)
Subject: Re: RFC: Remote Off-Channel CAC for DFS
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <c49513d5-9da7-5545-02e1-ff368f9f6961@tu-ilmenau.de>
 <99ae192566a7c5ae91c6ee92b8c4ddb41a29e34e.camel@sipsolutions.net>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <9f36bb56-8aa6-e759-5024-cfe5e58e41cf@tu-ilmenau.de>
Date:   Mon, 29 Jun 2020 22:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <99ae192566a7c5ae91c6ee92b8c4ddb41a29e34e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/29/20 9:35 PM, Johannes Berg wrote:
> Hi,
>
> On Mon, 2020-06-29 at 19:40 +0200, Markus Theil wrote:
>> When using DFS channels, it would be nice, if I could dedicate a small
>> amount of interfaces only to CAC checking channels and set them
>> available or unavailable on multiple other remote APs/Mesh Points in
>> order to use them, when switching to lower utilized channels without
>> going through a full CAC.
>>
>> Whats the opinion on the mailing list about adding a new command to
>> nl80211 in order to set the DFS state of a currently not used channel
>> after a Off-Channel CAC on another device nearby, but not on the same
>> host? The parameters would roughly be the same as for a channel switch
>> and an additional DFS channel state. Internally, I would trigger the DFS
>> state sync code between multiple interfaces.
> But wait, don't we already sync this within the kernel?
Yes, the kernel already syncs this between interfaces on the same host.
I'd just like to sync between multiple hosts, in order to make use of
fast switches to other DFS channels in a mesh network (in my case), if
some other node nearby already had performed a DFS CAC of a particular
channel and sync this state between hosts.
> johannes
>
