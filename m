Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD477B8E4A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbjJDUqD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbjJDUqC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 16:46:02 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59028B8
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 13:45:59 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7E583500085;
        Wed,  4 Oct 2023 20:45:56 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E45FA13C2B0;
        Wed,  4 Oct 2023 13:45:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E45FA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696452356;
        bh=6csj/bOAu3xQ3LyjSvljspZi7AoHRit5iYnamd2mQx8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=nAkhd+ePXGq/RQiZVA3ZPr7e7d3AAscGwSRDGxmvF9aWxfpm0XCxHnwlpHrq11Sld
         zliGRmJN/qr7ggufuUtaG25ht1XUjnm13r3LsFwgsw6hc8pK6SiMGiBxKsKKCO0BHY
         YDlJsO56rYIvXWKxRl4+Q9ogDhGnKeOEGv6JT6QQ=
Message-ID: <a393e535-622d-4d13-c27c-4491bf689e42@candelatech.com>
Date:   Wed, 4 Oct 2023 13:45:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mac80211: ethtool: check link sta if deflink sta not
 found.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20231003215839.981227-1-greearb@candelatech.com>
 <5b1aeb36dbc7316e5de0b0cfdf429b754c5cfd82.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <5b1aeb36dbc7316e5de0b0cfdf429b754c5cfd82.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1696452357-91BZNm98EyYe
X-MDID-O: us5;ut7;1696452357;91BZNm98EyYe;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/4/23 12:36, Johannes Berg wrote:
> On Tue, 2023-10-03 at 14:58 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> While testing with wifi-7 radio put into AX mode, link-0 is created.
>> sdata->deflink.u.mgd.bssid was 00 in this case, so sta was not
>> found.
>>
>> Use link-0 for sta if it is available to do a better job of reporting
>> ethtool stats.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   net/mac80211/ethtool.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
>> index 6bd7fba8a867..1b58304fc68a 100644
>> --- a/net/mac80211/ethtool.c
>> +++ b/net/mac80211/ethtool.c
>> @@ -96,6 +96,7 @@ static void ieee80211_get_stats2(struct net_device *dev,
>>   	struct ieee80211_local *local = sdata->local;
>>   	struct station_info sinfo;
>>   	struct survey_info survey;
>> +	struct ieee80211_link_data *link;
>>   	int i, q;
>>   	int z;
>>   #define STA_STATS_SURVEY_LEN 7
>> @@ -128,6 +129,12 @@ static void ieee80211_get_stats2(struct net_device *dev,
>>   	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
>>   		sta = sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
> 
> Just don't even try this, link[0] is always valid.

What is 'deflink' even used for then?  Is that only for non MLO connections?
Or you mean link[0] is valid even in non MLO connections?

Note I'm not changing that line above in my patch, though maybe it should
be changed...

> 
>> +		if (!sta) {
>> +			link = sdata_dereference(sdata->link[0], sdata);
> 
> but link[0] is a bad idea anyway ... what if the AP only assigned link 1
> and 2? Or you connected only there?
> 
> I'm not even sure this is really worth fixing, do you really want a
> random link's statistics?

I'd like it to at least have a chance of reporting something useful.

So maybe 'sta' can be the connected link with highest band.  And then I can add
new ethtool stats for link-0, link-1, link-2 (and one of those would be duplicated,
since the 'best' stats are already added).  Or I could have the default stats always
be link-0, and add new ethtool stats for link-1, link-2.  That would make it less
backwards compatible since link-0 may not be connected and would show no useful stats for the
old default ethtool strings.

I do not want to change existing ethtool stats strings since that would break
my user-space API and I'd rather not hack around that if possible.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


