Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913FB1E51C3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 01:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgE0XZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 19:25:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:41945 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgE0XZC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 19:25:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590621902; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IO5NWo0C9B5g1gCC6iQDUqGcstgG33qK8tScAeLTVtc=;
 b=pO9MD9XIRkbqt+ebKkwArz4WX7qjFZqSSMP74/Ozu4kzKkuNq6C7YVCAyBwqC9Z4XMv/4QhG
 fkmS7cnmjK0+n4EurHHqKUyoEAHlDvVb0axNDCX+lFx2kTtGC+/EfEvF/GFdGe/bI2hFwHd8
 FnvbxB5M7mi1mQH56PBprwe4akk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ecef6cdea0dfa490e5b0182 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 23:25:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72A97C4339C; Wed, 27 May 2020 23:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1BFBC433CB;
        Wed, 27 May 2020 23:24:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 16:24:59 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 02/11] cfg80211: handle 6 GHz capability of new station
In-Reply-To: <bf0f6c17c188901477c1d6aa61aab6143c4ac635.camel@sipsolutions.net>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
 <1589399105-25472-2-git-send-email-rmanohar@codeaurora.org>
 <bf0f6c17c188901477c1d6aa61aab6143c4ac635.camel@sipsolutions.net>
Message-ID: <17385b3a2fca16521858bf0956904698@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-27 07:00, Johannes Berg wrote:
> On Wed, 2020-05-13 at 12:44 -0700, Rajkumar Manoharan wrote:
>> Handle 6 GHz HE capability while adding new station. It will be used
>> later in mac80211 station processing.
> 
> This doesn't compile without the next patch.
> 
My bad.. I must have overlooked while splitting the patch. :(

>> +       const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;
> 
> This we made just an __le16, any particular reason to have the struct?
> It does need to be a pointer for the "no changes" case, but the struct
> seems a bit overkill?
> 
Initially I thought of splitting into two u8 for a_mpdu_params and info.
Later changed to __le16 but retained struct. Nothing else :)

>> + * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element 
>> (from
>> + *	association request when used with NL80211_CMD_NEW_STATION).
> 
> That we have pretty much identically.
> 
>> @@ -2998,6 +3003,7 @@ enum nl80211_attrs {
>>  #define NL80211_HE_MAX_CAPABILITY_LEN           54
>>  #define NL80211_MAX_NR_CIPHER_SUITES		5
>>  #define NL80211_MAX_NR_AKM_SUITES		2
>> +#define NL80211_HE_6GHZ_CAPABILITY_LEN		2
> 
> This not, we defined it just to be a U16.
> 
>> +	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
>> +		.type = NLA_EXACT_LEN,
>> +		.len = NL80211_HE_6GHZ_CAPABILITY_LEN,
>> +	},
> 
> This no longer exists, but I guess I'll just take our patch for the U16
> here.
> 
>> +	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
>> +	if (params.he_6ghz_capa && (params.ht_capa || params.vht_capa))
>> +		return -EINVAL;
> 
> Not sure this makes much sense? We can only check what's being set at
> the same time, so multiple calls here would still be possible ...
> doesn't hurt much though.
> 
> We didn't have this check, and have one additional check:
> 
> @@ -6170,7 +6200,7 @@ static int nl80211_new_station(struct sk_buff
> *skb, struct genl_info *info)
>                 params.vht_capa = NULL;
> 
>                 /* HE requires WME */
> -               if (params.he_capa_len)
> +               if (params.he_capa_len || params.he_6ghz_capa)
>                         return -EINVAL;
>         }
> 
Fine. One more thing. Pradeep found that 6 GHz capability is not filled 
in set_station.
Please handle that in your series. I'm fine with rest of the changes you 
mentioned.

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5893,6 +5893,10 @@ static int nl80211_set_station_tdls(struct
genl_info *info,
                         return -EINVAL;
         }

+       if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
+               params->he_6ghz_capa =
+                       
nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
+

-Rajkumar
