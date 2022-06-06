Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019B53ED25
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiFFRoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiFFRo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 13:44:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DFE3207DE
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654537467; x=1686073467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YGCEWByr0RM/Jt3IOLrXNAWT9eGJc6wa/BxW1Oupg1U=;
  b=oRXQZS96MnJmHHddw+ZXtFidF5BhnLi5toiuHs7VMbLcYQ5lprfi2rbR
   qzmGD+DTTRv5XYYBPks8y97bCFR5mujsS9ej4JqAYy/WX+bTb6Kkkmx6k
   IXmW7uaoHelKGaJXAuQkQ8ZUP4TSvE1Je2SEEYY45rU+fCIxaN4yiCXqm
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Jun 2022 10:44:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:44:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 10:44:24 -0700
Received: from [10.242.6.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 10:44:23 -0700
Message-ID: <3db08cbd-53b5-1a55-76c0-9b353efe52d5@quicinc.com>
Date:   Mon, 6 Jun 2022 23:14:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] cfg80211: Indicate MLO connection info in connect and roam
 callbacks
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1653528391-21718-1-git-send-email-quic_vjakkam@quicinc.com>
 <9270689aeb7de1c2f9764d8e79f28c2b9aafcedc.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <9270689aeb7de1c2f9764d8e79f28c2b9aafcedc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for reviewing the patch.

On 5/27/2022 1:26 PM, Johannes Berg wrote:

>
>> +			for_each_valid_link(cr, link)
>> +				cfg80211_put_bss(wdev->wiphy, cr->links[link].bss);


reduced the repeated code by using "out" label.  Can't make common 
utility function

for both roam and connect callbacks since variables in links struct 
differs for connect result and roam info.

Also, addressed several other comments about code cleanup and nits in v2.


>
>> -	if (WARN_ON(!info->bss))
>> +	if (WARN_ON(!bss_found))
>>   		return;
> This goes with my question earlier - here you're basically assuming
> finding a single BSS is fine. Do we really think so? It used to be we
> wanted all of them, and I kind of tend to think drivers should just make
> sure they have all of them - once we have the entry it can be updated,
> but if we don't have one, we'll never again get the information on the
> BSS, for purposes such as "iw link" output.
>
> I tend to think we should always require all BSS entries to exist, even
> if the driver initially has to make up a fake entry with pretty much no
> information.
>
> Or maybe we have enough information here already (BSSID/frequency) to
> make up a fake entry in cfg80211?
>

Agree, Drivers should have enough formation to create a BSS entry for 
all the links.

As suggested added checks for all bss entries availability in v2 patch.

>> +	if (info->ap_mld_addr) {
>> +		ev->rm.ap_mld_addr = next;
>> +		memcpy((void *)ev->rm.ap_mld_addr, info->ap_mld_addr,
>> +		       ETH_ALEN);
> Why the cast?

Without casting it gives below error.

note: expected 'void *' but argument is of type 'const u8 *' {aka 'const unsigned char *'}

--
veeru


