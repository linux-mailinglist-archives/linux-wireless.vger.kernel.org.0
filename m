Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62FD52C579
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiERVT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbiERVT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 17:19:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C3175690
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652908767; x=1684444767;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5TAXv85sybfkVh2uXaxyRsEjnfyIHguGLkaoHwsn03U=;
  b=FXNn09X/7mw3gfdLKvu2EDK3CtWufaZpBjHOnBtGqlzdLhWYnvv6MXSG
   cqT2HsnQTSpMKooNFftWNDKbbN7DmucBjFHHQ/qNxIjOa5hsl6TLB5OX0
   4groVfYqxtXtKupHw8EyvLPfPfwMeD9OpJHJY+ai6cw3X26OPoUkhLhcl
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 14:19:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 14:19:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 14:19:27 -0700
Received: from [10.110.66.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 14:19:26 -0700
Message-ID: <7c05bbc5-c51f-2eb6-84a2-3a20c45b8b22@quicinc.com>
Date:   Wed, 18 May 2022 14:19:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/9] ath9k: basic support for QCN550x
Content-Language: en-US
To:     Wenli Looi <wlooi@ucalgary.ca>
CC:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
References: <20220512195319.14635-1-wlooi@ucalgary.ca>
 <20220512195319.14635-3-wlooi@ucalgary.ca>
 <69feb893-d73a-46e5-fbe6-2f49e091c625@quicinc.com>
 <CAKe_nd3u+iiCGC7M_i+ovF+_bgDMkFUh0OpJ7HFWMhmgZQa7bw@mail.gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAKe_nd3u+iiCGC7M_i+ovF+_bgDMkFUh0OpJ7HFWMhmgZQa7bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/17/2022 11:08 PM, Wenli Looi wrote:
> On Thu, May 12, 2022 at 2:45 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>> On 5/12/2022 12:53 PM, Wenli Looi wrote:
>>> QCN550x is very similar to QCA956x. Note that AR_CH0_XTAL is
>>> intentionally unchanged. Certain arrays are no longer static because
>>> they are no longer constant.
>>
>> I don't understand the last sentence. You removed the 'static' keyword
>> but left the 'const' keyword, hence they are still constant.
>>
>> And I didn't actually see any instances where the arrays are being modified.
>>
>> Can you highlight which are being modified?
> 
> I changed several arrays from "static const" to "const" because their
> values now depend on ah, so it won't compile if they are static. For
> example, offset_array contains AR_PHY_RX_IQCAL_CORR_B0 which depends
> on AR_CHAN_BASE (which now depends on ah but did not before).

So the values are no longer constant, hence IMO the 'const' qualifier 
should also be removed

> 
>>> -#define AR_CHAN_BASE 0x9800
>>> +#define AR_CHAN_BASE (AR_SREV_5502(ah) ? 0x29800 : 0x9800)
>>
>> this violates the coding style:
>> <https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl>
>>
>> Things to avoid when using macros:
>> macros that depend on having a local variable with a magic name
>>
>> So you should add ah as a parameter to the macro
>>
>> Repeat for all instances below where ah is being used
>>
> 
> The macros like AR_CHAN_BASE and AR_SM_BASE are referenced by a lot of
> other macros, some of which already have a "magic name" dependency on
> ah like these ones:
> 
> https://github.com/torvalds/linux/blob/210e04ff768142b96452030c4c2627512b30ad95/drivers/net/wireless/ath/ath9k/ar9003_phy.h#L527
> 
> However I think it's probably good to avoid introducing new macros
> with the magic name dependency. If desired, for every macro that I
> have modified, I could try to add the ah parameter to all dependent
> macros. This would probably be a rather large change so it might make
> sense to be a separate commit.

Your current change illustrates one of the many pitfalls of using magic 
names. IMO you should have a precursor patch that changes all of the 
"bad" macros to take ah as a parameter rather than be a magic name.

At a minimum you should add ah as a parameter to the ones you are 
modifying so that it is clear why you need to change the attributes of 
those arrays.

/jeff
