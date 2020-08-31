Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011F7257EF5
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHaQm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 12:42:28 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:48406 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726204AbgHaQm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 12:42:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 0F5204F8BF1;
        Mon, 31 Aug 2020 16:42:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VWoO1RYiAiro; Mon, 31 Aug 2020 16:42:24 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 32C584F78CC;
        Mon, 31 Aug 2020 16:42:24 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 31 Aug 2020 09:42:23 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 21/22] mac80211_hwsim: indicate support for S1G
In-Reply-To: <87d03b6wcw.fsf@tynnyri.adurom.net>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
 <20200827223304.16155-22-thomas@adapt-ip.com>
 <87d03b6wcw.fsf@tynnyri.adurom.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <1d240f308559342dbd96023a2bc86970@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-28 00:52, Kalle Valo wrote:
> Thomas Pedersen <thomas@adapt-ip.com> writes:
> 
>> Advertise S1G Capabilities and channels to mac80211.
>> 
>> Requires a few fixups to account for missing
>> sband->bitrates, and a custom regulatory db to actually
>> enable the S1G channels.
>> 
>> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
>> ---
>>  drivers/net/wireless/mac80211_hwsim.c | 80 
>> ++++++++++++++++++++++++---
>>  include/linux/ieee80211.h             | 12 +++-
> 
> IMHO a mac80211_hwsim patch should not touch ieee80211.h.

Fair enough, I'll split it out.

>> --- a/include/linux/ieee80211.h
>> +++ b/include/linux/ieee80211.h
>> @@ -2385,6 +2385,9 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
>>  	return spr_len;
>>  }
>> 
>> +#define SM(f, v)	(((v) << f##_SHIFT) & f)
>> +#define MS(f, v)	(((v) & f) >> f##_SHIFT)
>> +
>>  /* S1G Capabilities Information field */
>>  #define S1G_CAPAB_B0_S1G_LONG BIT(0)
>>  #define S1G_CAPAB_B0_SGI_1MHZ BIT(1)
>> @@ -2392,9 +2395,16 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
>>  #define S1G_CAPAB_B0_SGI_4MHZ BIT(3)
>>  #define S1G_CAPAB_B0_SGI_8MHZ BIT(4)
>>  #define S1G_CAPAB_B0_SGI_16MHZ BIT(5)
>> -#define S1G_CAPAB_B0_SUPP_CH_WIDTH_MASK (BIT(6) | BIT(7))
>> +#define S1G_CAPAB_B0_SUPP_CH_WIDTH	(BIT(6) | BIT(7))
>>  #define S1G_CAPAB_B0_SUPP_CH_WIDTH_SHIFT 6
>> 
>> +#define S1G_SUPP_CH_WIDTH_2	0
>> +#define S1G_SUPP_CH_WIDTH_4	1
>> +#define S1G_SUPP_CH_WIDTH_8	2
>> +#define S1G_SUPP_CH_WIDTH_16	3
>> +#define S1G_SUPP_CH_WIDTH_MAX(cap) ((1 << 
>> MS(S1G_CAPAB_B0_SUPP_CH_WIDTH, \
>> +					     cap[0])) << 1)
> 
> We have GENMASK(), FIELD_GET() & co nowadays so no need for custom
> macros.

Nice. Thanks for the heads up.

-- 
thomas
