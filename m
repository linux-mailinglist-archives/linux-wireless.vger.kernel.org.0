Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA227D41F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgI2RHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:07:41 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:55552 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgI2RHl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:07:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9E7014F9FEC;
        Tue, 29 Sep 2020 17:07:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wU9sQIhaMJ01; Tue, 29 Sep 2020 17:07:38 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 05DE84F9FE9;
        Tue, 29 Sep 2020 17:07:37 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 29 Sep 2020 10:07:37 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 14/17] mac80211: support S1G association
In-Reply-To: <1a2ed6b74cf7604c717791bd6cb9e65b49f4a654.camel@sipsolutions.net>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-15-thomas@adapt-ip.com>
 <1a2ed6b74cf7604c717791bd6cb9e65b49f4a654.camel@sipsolutions.net>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <cac2b6d591dc49286ab3f811cec61840@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-28 05:17, Johannes Berg wrote:
>> @@ -176,6 +177,15 @@ ieee80211_determine_chantype(struct 
>> ieee80211_sub_if_data *sdata,
>>  	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
>>  	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
>> 
>> +	if (s1g_oper && sband->band == NL80211_BAND_S1GHZ) {
>> +		ieee80211_chandef_s1g_oper(s1g_oper, chandef);
>> +		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_40MHZ |
>> +		      IEEE80211_STA_DISABLE_VHT |
>> +		      IEEE80211_STA_DISABLE_80P80MHZ |
>> +		      IEEE80211_STA_DISABLE_160MHZ;
>> +		goto out;
>> +	}
> 
> I've applied this now (and made some changes in a few patches, please
> check), but this particular thing seems a bit odd, in that it looks for
> HT/VHT elements even on an S1G channel if the s1g oper element isn't
> present? That seems like it shouldn't be the case, can you take a look?

Thanks for the (numerous) fixups.

I don't think applying a (NULL) HT cap is a big deal since the same code 
path
is already executed for eg. non HT, but it does look strange and I'll 
send a
fixup.

-- 
thomas
