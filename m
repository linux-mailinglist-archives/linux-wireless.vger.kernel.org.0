Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032E05858CC
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jul 2022 07:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiG3Frr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jul 2022 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiG3Frq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jul 2022 01:47:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF36611B
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 22:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659160066; x=1690696066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CleC7Jn8klxB7k3auNaCz8+eQYmy43SPP/3+LeSNIzA=;
  b=ga4fCxvWNPyu2BB6yMZ9ZrZD69PM6JXMOUXd9/CKgI7ya6Hqs2PRB0sK
   oYns5vSqJTvlWz1SYc2PrYSShqnB+hZaT6mgnE1+bLGMpAHgnMi06tXp/
   q6Kg8+Op708UmiAKszjeNVyxCyzIbE+tM+CUQFpYwVNecogeCziBhCzTI
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Jul 2022 22:47:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:47:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:47:45 -0700
Received: from [10.216.44.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Jul
 2022 22:47:43 -0700
Message-ID: <7b0d857f-90f4-6ee6-2186-01cadeda998d@quicinc.com>
Date:   Sat, 30 Jul 2022 11:17:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] cfg80211: Add link_id to various key operations for MLO
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1657518327-17390-1-git-send-email-quic_vjakkam@quicinc.com>
 <2d90dfefd79fb2d4c942026856ef11ae6b4279cb.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <2d90dfefd79fb2d4c942026856ef11ae6b4279cb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 7/14/2022 1:52 AM, Johannes Berg wrote:
>
>> + *	%NL80211_ATTR_MLO_LINK_ID, If %NL80211_ATTR_MLO_LINK_ID is not present
>> + *	the specified key index data should be deleted for all the links.
> really? for all the links seems... complicated?


Thought delete key operation can be optimized in some cases with single 
request to delete group keys

on all MLO links.  I agree that it is not inline with other key 
operations and makes it complicated, dropped this comment in v2 patch.

>
>> --- a/net/wireless/util.c
>> +++ b/net/wireless/util.c
>> @@ -935,13 +935,13 @@ void cfg80211_upload_connect_keys(struct wireless_dev *wdev)
>>   	for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++) {
>>   		if (!wdev->connect_keys->params[i].cipher)
>>   			continue;
>> -		if (rdev_add_key(rdev, dev, i, false, NULL,
>> +		if (rdev_add_key(rdev, dev, -1, i, false, NULL,
>>   				 &wdev->connect_keys->params[i])) {
>>   			netdev_err(dev, "failed to set key %d\n", i);
>>   			continue;
>>   		}
>>   		if (wdev->connect_keys->def == i &&
>> -		    rdev_set_default_key(rdev, dev, i, true, true)) {
>> +		    rdev_set_default_key(rdev, dev, -1, i, true, true)) {
>>   			netdev_err(dev, "failed to set defkey %d\n", i);
>>   			continue;
>>   		}
> Now in this case we probably couldn't have made an MLO connection, can
> we? Or maybe we can with full offload firmware? And then should this
> really be -1 towards the driver?
>
> Actually - these are WEP keys, so no MLO?


yes, MLO connection shouldn't happen in this case since these are WEP keys.

>
>> diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
>> index a9767bf..3dd0946 100644
>> --- a/net/wireless/wext-compat.c
>> +++ b/net/wireless/wext-compat.c
>> @@ -470,7 +470,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
>>   			    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
>>   				err = -ENOENT;
>>   			else
>> -				err = rdev_del_key(rdev, dev, idx, pairwise,
>> +				err = rdev_del_key(rdev, dev, -1, idx, pairwise,
>>   						   addr);
>>   		}
>>   		wdev->wext.connect.privacy = false;
>
> All of this stuff has me thinking though - now you still need driver
> validation, because on an MLO connection the WEXT handlers could be
> called?! YUCK!
>
> Maybe we should just prevent all of these handlers on interfaces that
> are MLDs, i.e. have valid_links != 0?
>
> I guess that's not really specific to your patch though.
>
> johannes

Yeah, already in most of the cases WEXT specific code is 
skipped/rejected for MLO.

addressed other comments from you and added few checks for WEP and WEXT 
in v2 patch series. Please review.

- veeru

