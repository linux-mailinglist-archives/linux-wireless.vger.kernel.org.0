Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FEF19B536
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgDASPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 14:15:25 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:42750 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727723AbgDASPZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 14:15:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 74DC14F7A8F;
        Wed,  1 Apr 2020 18:15:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BDICZ3cAFD73; Wed,  1 Apr 2020 18:15:22 +0000 (UTC)
Received: from [10.1.15.6] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id CA4FA4F7A8B;
        Wed,  1 Apr 2020 18:15:21 +0000 (UTC)
Subject: Re: [RFC 6/7] nl80211: add KHz frequency offset for most wifi
 commands
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
 <20200401062150.3324-7-thomas@adapt-ip.com>
 <a2fe2cad3c93ae8516568b6a8f5395dae6d9ba30.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <f7140580-d6fa-95f2-abeb-6b5523725383@adapt-ip.com>
Date:   Wed, 1 Apr 2020 11:15:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a2fe2cad3c93ae8516568b6a8f5395dae6d9ba30.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/1/20 12:10 AM, Johannes Berg wrote:
> On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
>>
>> TODO: several of these commands will eventually just
>> ignore the _OFFSET component, like _JOIN_MESH,
>> _CMD_RADAR_DETECT, etc. Should return an error to give
>> user a hint things won't work as expected?
> 
> Wouldn't most of them already require that a channel with the given
> frequency exists, and thus fail anyway?

Well I was thinking of the case where you have:

ch 2: 903MHz
ch 3: 903.5Mhz

userspace tries to eg. join a mesh on channel 3 by sending 903MHz +
500KHz, the (old) kernel interprets this as channel 2 and happily joins
on the wrong channel. However this only applies on a new band which
doesn't even exist yet, and if we return an error for commands which
have not yet been tested with frequency offset nothing unexpected will
happen.

-- 
thomas
