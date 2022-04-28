Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ABD512AE7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242979AbiD1Fdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Apr 2022 01:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1Fdg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Apr 2022 01:33:36 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834542F391
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651123823; x=1682659823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UQpNpqIrjSeVdZUcM21FLZDR5si0G5vqvbA+lHXgzlw=;
  b=ad34HfV4TfjRkUWrxt7ucjKxU0lAl8wM+jG4MssI0rTBfxaUlu8zK0e1
   +3fr4WZQWYtfBHA7hzDvZz1ipyoLsPVswDlm6O5fT0e5UuG7vLf5456Lm
   mFEH2RGboRLftXjUnLfHEtTPDmjPWqPAVUsYkBrXJvYJSdRLFxj0CwyAW
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 22:30:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 22:30:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 22:30:21 -0700
Received: from [10.50.63.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 22:30:20 -0700
Message-ID: <fec83652-b8ed-8ad5-ff9a-db17655634ee@quicinc.com>
Date:   Thu, 28 Apr 2022 11:00:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] mac80211: Reset MBSSID parameters upon connection
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220427182305.11703-1-quic_mpubbise@quicinc.com>
 <ca53bf4ce43f967723125313d5285cc40eb7d3f4.camel@sipsolutions.net>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <ca53bf4ce43f967723125313d5285cc40eb7d3f4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/28/2022 12:41 AM, Johannes Berg wrote:
> On Wed, 2022-04-27 at 23:53 +0530, Manikanta Pubbisetty wrote:
>> Currently MBSSID parameters in struct ieee80211_bss_conf
>> are not reset upon connection. This could be problematic
>> with some drivers in a scenario where the device first
>> connects to a non-transmit BSS and then connects to a
>> transmit BSS of a Multi BSS AP. The MBSSID parameters
>> which are set after connecting to a non-transmit BSS will
>> not be reset and the same parameters will be passed on to
>> the driver during the subsequent connection to a transmit
>> BSS of a Multi BSS AP.
>>
>> For example, firmware running on the ath11k device uses the
>> Multi BSS data for tracking the beacon of a non-transmit BSS
>> and reports the driver when there is a beacon miss. If we do
>> not reset the MBSSID parameters during the subsequent
>> connection to a transmit BSS, then the driver would have
>> wrong MBSSID data and FW would be looking for an incorrect
>> BSSID in the MBSSID beacon of a Multi BSS AP and reports
>> beacon loss leading to an unstable connection.
>>
>> Reset the MBSSID parameters upon every connection to solve this
>> problem.
> 
> Oops. Please add (or at least provide) a Fixes line though.
> 

Sure Johannes, just sent V2 patch with the Fixes line added.

Thanks,
Manikanta
