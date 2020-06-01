Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747251EA84F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 19:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFARQG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 13:16:06 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:36440 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726125AbgFARQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 13:16:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5F50A4F8A9C;
        Mon,  1 Jun 2020 17:16:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ahDYlkLV6PAY; Mon,  1 Jun 2020 17:16:03 +0000 (UTC)
Received: from [10.1.15.7] (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id E87744F8A8D;
        Mon,  1 Jun 2020 17:16:02 +0000 (UTC)
Subject: Re: [PATCH v4 5/5] nl80211: S1G band and channel definitions
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20200430172554.18383-1-thomas@adapt-ip.com>
 <20200430172554.18383-6-thomas@adapt-ip.com>
 <256d488507006cff8b0a9bc80ab51ef0cee9ff7e.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <3ef2eb73-22e3-3324-74be-514d2d9032e9@adapt-ip.com>
Date:   Mon, 1 Jun 2020 10:16:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <256d488507006cff8b0a9bc80ab51ef0cee9ff7e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/26/20 6:01 AM, Johannes Berg wrote:
> Hi Thomas,
> 
> This looks mostly good (and I've applied the other 4 patches with some
> fixups), but ...
> 
>> @@ -911,6 +931,15 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
>>  	control_freq = chandef->chan->center_freq;
>>  
>>  	switch (chandef->width) {
>> +	case NL80211_CHAN_WIDTH_1:
>> +		width = 1;
>> +		break;
>> +	case NL80211_CHAN_WIDTH_2:
>> +		width = 2;
>> +		break;
>> +	case NL80211_CHAN_WIDTH_4:
>> +		width = 4;
>> +		break;
>>  	case NL80211_CHAN_WIDTH_5:
> 
> aren't you missing some bandwidths here? You'd fall through to a
> WARN_ON(), which doesn't seem good?

Yep. Looks like hwsim tests needs a test for larger bandwidths.

-- 
thomas
