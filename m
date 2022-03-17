Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC44DD058
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 22:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiCQVoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCQVoQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 17:44:16 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8D02BD1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647553376; x=1679089376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/rZii18wA2voVc1N7quKjXAD7rAKgafDEn5607kcsOU=;
  b=hSUzHYIiJiuGaRMcGeF4qqNE78I/3IfbhA2YAxgTNOAAwbFAMRePzmtG
   L5aOkL2IbCs7ZRZcsfily0cSdV8j/u0OUuikHZBkXsytmJkrg7dHX5yhL
   nmv9Q4q2zPnrE+pb8tXQUc/mOJr29djM62aY7GU8eSVxl/KlI6OphcHOK
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Mar 2022 14:42:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 14:42:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 17 Mar 2022 14:42:56 -0700
Received: from [10.48.244.84] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 17 Mar
 2022 14:42:55 -0700
Message-ID: <aaf86305-3b6e-aa8d-fa9f-b4b4ba9cb3c1@quicinc.com>
Date:   Thu, 17 Mar 2022 14:42:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/3] cfg80211: Add NL80211_IFTYPE_MLO_LINK type for MLO
 links on MLD STA
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>, <quic_usdutt@quicinc.com>,
        Aaron Komisar <akomisar@maxlinear.com>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
 <1645613200-30221-2-git-send-email-quic_vjakkam@quicinc.com>
 <af96eba158c83a63cb9465b04373e909971d7676.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <af96eba158c83a63cb9465b04373e909971d7676.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/11/2022 4:17 AM, Johannes Berg wrote:
> On Wed, 2022-02-23 at 16:16 +0530, Veerendranath Jakkam wrote:
>>
>> Two link non-AP MLD representation:
>>
>>                   wlan0 (non-AP MLD)
>>                 IFTYPE_STATION (netdev + wdev)
>>                   /               \
>>                  /                 \
>>                link0             link1
>>        IFTYPE_MLO_LINK (wdev)  IFTYPE_MLO_LINK (wdev)
>>                |                   |
>>                |                   |
>>              radio(2G)           radio(5G)
>>
>> In contrast, NL80211_IFTYPE_MLO_LINK can't be used to represent AP MLO
>> link since an MLD AP must support pre-11be and 11be clients
>> simultaneously so each AP MLO link affiliated with AP MLD must also act
>> as independent AP for pre-11be clients so each AP MLO link must be
>> represented by NL80211_IFTYPE_AP associated with a separate netdev.
>>
>> Two link AP MLD representation:
>>
>>                   AP MLD
>>               (netdev + wdev)
>>                  /      \
>>                 /        \
>>            wlan0          wlan1
>>        IFTYPE_AP       IFTYPE_AP
>>     (netdev + wdev)  (netdev + wdev)
>>             |             |
>>             |             |
>>          radio(2G)      radio(5G)
> 
> So just for posterity's sake - we had more discussions on this out of
> band, and decided that the "netdev + wdev" on the wlan0/wlan1 will not
> actually happen - they both should be just "wdev" like in the non-AP
> MLD.
> 
> This solves the issue of broadcast (otherwise you'd need AP MLD + wlan0
> + wlan1 in a bridge and drop all multicast at wlan0 and wlan1), at the
> expense of a small amount of flexibility - you cannot consider legacy
> and MLD clients to be in different networks.
> 
> However, given the complexities around multicast, you probably cannot
> consider them to be in different networks _anyway_ because then you'd
> have to _not_ drop all the multicast on wlan0/wlan1, and then you send
> multicast twice to the MLD clients, which would be wrong too...
> 
> So the more reasonable thing to do is to treat this the same way as non-
> AP MLD with only a single netdev, and effectively behave as if there was
> an internal kind of bridge inside the AP MLD for the legacy clients.
> 
> As a consequence, of course this patch will change too.

Although this patch series is specific to non-AP MLD support I advocated 
during internal review to add this AP MLD description to initiate 
discussion about the differences between the two, and I'm glad to see 
that is happening.

Should we just omit the AP MLD representation in v2, and add that with 
the AP MLD support?

Did you have any other comments on the series other than your proposal 
to add a MLD wiphy flag, and as a result, not require driver to NULL 
check the wdev->netdev?

Thanks!
/jeff

