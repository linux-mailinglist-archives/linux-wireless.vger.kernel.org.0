Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCC271A7C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 07:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIUFqE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 01:46:04 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46190 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbgIUFqD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 01:46:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 36F1A4F9B64;
        Mon, 21 Sep 2020 05:46:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zkTKr7HnHyKO; Mon, 21 Sep 2020 05:46:00 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 697F54F9809;
        Mon, 21 Sep 2020 05:46:00 +0000 (UTC)
MIME-Version: 1.0
Date:   Sun, 20 Sep 2020 22:45:59 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 12/22] mac80211: convert S1G beacon to scan results
In-Reply-To: <07751701c06d14e39c956369e5b1dd2a066fd69e.camel@sipsolutions.net>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
 <20200831205600.21058-13-thomas@adapt-ip.com>
 <07751701c06d14e39c956369e5b1dd2a066fd69e.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <1727e7d1973012eb82159427551e3412@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-18 03:48, Johannes Berg wrote:
> On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> 
>> 
>> +	if (!elems->parse_error && elems->s1g_capab)
>> +		bss->s1g = true;
> 
> It seems odd to set this only if it's in error - why not always set it
> if the band is right?

True.

> In fact, why set it at all, since you always know the band?

It seemed like a convenient shorthand, but looking at 
net/mac80211/mlme.c the
band/channel is available (sband->band or cbss->channel->band) wherever 
we
check s1g->bss so maybe it's not needed. I'll remove it to keep things
simple.

>> +		case WLAN_EID_S1G_CAPABILITIES:
>> +			if (elen == 15)
>> +				elems->s1g_capab = (void *)pos;
>> +			else
>> +				elem_parse_failed = true;
>> +			break;
>> +		case WLAN_EID_S1G_OPERATION:
>> +			if (elen == 6)
>> +				elems->s1g_oper = (void *)pos;
>> +			else
>> +				elem_parse_failed = true;
>> +			break;
>> +		case WLAN_EID_S1G_SHORT_BCN_INTERVAL:
>> +			if (elen == 2)
>> +				elems->s1g_tsbtt = (void *)pos;
>> +			else
>> +				elem_parse_failed = true;
>> +			break;
> 
> Seems like you ought to have some structs/sizeof or defines for the
> sizes?

Yes I'll find something. Thanks.

-- 
thomas
