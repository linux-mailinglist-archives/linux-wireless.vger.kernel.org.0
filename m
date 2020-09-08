Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21B261B0F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIHSxs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:53:48 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52494 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgIHSxh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:53:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id D0A974F9ABB;
        Tue,  8 Sep 2020 18:53:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YepopS5Bg0NE; Tue,  8 Sep 2020 18:53:33 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 9C8FA4F9A56;
        Tue,  8 Sep 2020 18:53:29 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 08 Sep 2020 11:53:26 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Subject: Re: [mac80211_hwsim] 8cafe19852: hwsim.fst_ap_config_default.fail
In-Reply-To: <12f9c1c504053f9119a0965ce468aa1da195421b.camel@sipsolutions.net>
References: <20200906084935.GD31308@shao2-debian>
 <4b20df478e8e9a1e36dfa92b3c510022@adapt-ip.com>
 <12f9c1c504053f9119a0965ce468aa1da195421b.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <e09a3f44de086decc9914a53d2a0a9c5@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-08 11:41, Johannes Berg wrote:
> On Tue, 2020-09-08 at 11:00 -0700, Thomas Pedersen wrote:
>> - LKML
>> 
>> On 2020-09-06 01:49, kernel test robot wrote:
>> > Greeting,
>> >
>> > FYI, we noticed the following commit (built with gcc-9):
>> >
>> > commit: 8cafe19852d95d6494cbd8c1ae24dbd621588a91 ("[PATCH v2 21/22]
>> > mac80211_hwsim: indicate support for S1G")
>> > url:
>> > https://github.com/0day-ci/linux/commits/Thomas-Pedersen/add-support-for-S1G-association/20200901-045826
>> > base:
>> > https://git.kernel.org/cgit/linux/kernel/git/jberg/mac80211-next.git
>> > master
>> 
>> This is really cool. Thanks Rong (?).
>> 
>> I'll move the "fix TSF timestamp write to S1G beacon" patch before the
>> one which actually exposes S1G to hwsim.
> 
> Yeah, I was thinking we should do that anyway.
> 
> If those two small things (ARRAY_SIZE & patch reordering) are the only
> changes, I guess I can do that.

I'll send a v3, the patch reorder doesn't apply cleanly.

> Unless you want to look at the reordering of the nl80211 bands, but you
> seemed to say it won't really matter.

Nah :)

-- 
thomas
