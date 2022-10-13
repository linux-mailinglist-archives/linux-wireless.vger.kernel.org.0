Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E935FDE5B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJMQjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 12:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJMQj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 12:39:29 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEF14D1E3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 09:39:28 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.135])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E92CE1C0081;
        Thu, 13 Oct 2022 16:39:26 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B85734C0087;
        Thu, 13 Oct 2022 16:39:26 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 438A013C2B0;
        Thu, 13 Oct 2022 09:39:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 438A013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1665679166;
        bh=C6t4lYH3bTInql3fMMOn6+e9VojT7UJrqqFO9yyTGWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VNkHJBhtJz5La5o1y80C31sO/toL4gf4rhyg+76duPtWVpS43KwNFTnUGpc5f1UUL
         w1IC4tIJDYaBcFcvkfoxVMXvlsbqw3wjuB/XLMtQdLffuJQyFrvRXwXx+rvoIpwGk8
         33lLH2T3iqO0ccY8oExrCFf7Zz9pxaEhaCsIBYzE=
Subject: Re: [PATCH] wifi: iwlwifi: fix double free on tx path.
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "amol.jawale@candelatech.com" <amol.jawale@candelatech.com>
References: <20220928193057.16132-1-greearb@candelatech.com>
 <5fc4f28a5fc079d0368f6047db0d2c5fa1ed3ad4.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <22d76af9-79e3-4d7c-12e0-71d57770fc49@candelatech.com>
Date:   Thu, 13 Oct 2022 09:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5fc4f28a5fc079d0368f6047db0d2c5fa1ed3ad4.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1665679167-Jv_HoC6LVmTa
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/12/22 7:17 AM, Greenman, Gregory wrote:

>>          if (WARN_ON_ONCE(!mvmsta))
>>                  return -1;
>> @@ -1238,8 +1239,17 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
>>   
>>                  ret = iwl_mvm_tx_mpdu(mvm, skb, &info, sta);
>>                  if (ret) {
> 
> Maybe while on it, add here "if (unlikely(ret)) {"?

I don't think it is worth respinning the patch for that, but could add a follow-on patch.

Thanks,
Ben

> 
>> +                       /* Free skbs created as part of TSO logic that have not yet been dequeued */
>>                          __skb_queue_purge(&mpdus_skbs);
>> -                       return ret;
>> +                       /* skb here is not necessarily same as skb that entered this method,
>> +                        * so free it explicitly.
>> +                        */
>> +                       if (skb == orig_skb)
>> +                               ieee80211_free_txskb(mvm->hw, skb);
>> +                       else
>> +                               kfree_skb(skb);
>> +                       /* there was error, but we consumed skb one way or another, so return 0 */
>> +                       return 0;
>>                  }
>>          }
>>   
> 
> Thanks for the fix!
> Gregory
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

