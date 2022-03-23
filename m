Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5B4E55F5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 17:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiCWQII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245445AbiCWQIB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 12:08:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89B7C17E
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648051592; x=1679587592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qF5/zXwuEnWpLIRsAVxVh/Job5uOkCMuFaxCIQWpM7g=;
  b=vnYlJ7LW7OY4OGzSDNJa/6KpTUUNqBNxfOMshlfE7AU0Krz5m/RapqEe
   dqy3L1+o6ZwA/wYukh+yg4hm7Ttj0O5Y1zZIyd2tZPh074h6OAnEpH9VS
   dQ5i3hfepn+5XMf3iSXHUNg+vywCEHLkZjmufvvl/19jxBKvVda4QbwM6
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 09:06:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 09:06:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 09:06:31 -0700
Received: from [10.110.23.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 09:06:31 -0700
Message-ID: <dc556455-51a2-06e8-8ec5-b807c2901b7e@quicinc.com>
Date:   Wed, 23 Mar 2022 09:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
Content-Language: en-US
To:     William McVicker <willmcvicker@google.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <0000000000009e9b7105da6d1779@google.com>
 <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
 <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
 <YjpGlRvcg72zNo8s@google.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <YjpGlRvcg72zNo8s@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On 3/22/2022 2:58 PM, William McVicker wrote:
> On 03/22/2022, Jeff Johnson wrote:
>> On 3/21/2022 1:07 PM, Johannes Berg wrote:
>> [..snip..]
>>
>>>> I'm not an networking expert. So my main question is if I'm allowed to take
>>>> the RTNL lock inside the nl80211_vendor_cmd callbacks?
>>>
>>> Evidently, you're not. It's interesting though, it used to be that we
>>> called these with the RTNL held, now we don't, and the driver you're
>>> using somehow "got fixed" to take it, but whoever fixed it didn't take
>>> into account that this is not possible?
>>
>> On this point I just want to remind that prior to the locking change that a
>> driver would specify on a per-vendor command basis whether or not it wanted
>> the rtnl_lock to be held via NL80211_FLAG_NEED_RTNL. I'm guessing for the
>> command in question the driver did not set this flag since the driver wanted
>> to explicitly take the lock itself, otherwise it would have deadlocked on
>> itself with the 5.10 kernel.
>>
>> /jeff
> 
> On the 5.10 kernel, the core kernel sets NL80211_FLAG_NEED_RTNL as part of
> the internal_flags for NL80211_CMD_VENDOR:
> 
> net/wireless/nl80211.c:
>     {
>        .cmd = NL80211_CMD_VENDOR,
>        .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>        .doit = nl80211_vendor_cmd,
>        .dumpit = nl80211_vendor_cmd_dump,
>        .flags = GENL_UNS_ADMIN_PERM,
>        .internal_flags = NL80211_FLAG_NEED_WIPHY |
>                NL80211_FLAG_NEED_RTNL |
>                NL80211_FLAG_CLEAR_SKB,
>     },
> 
> So the 5.10 version of this driver doesn't need to directly call rtnl_lock()
> within the vendor command doit() functions since pre_doit() handles the RTNL
> locking.
> 
> It would be nice if nl80211_vendor_cmd() could support taking the RTNL lock if
> requested via the vendor flags. That would require moving the wiphy lock to
> nl80211_vendor_cmds() so that it could take the RTNL and wiphy lock in the
> correct order. Is that something you'd be open to Johannes?
> 
> --Will

Thanks for correcting my understanding. I concur that it would be useful 
for vendor commands to be able to specify that a given command needs the 
RTNL lock to be held.


