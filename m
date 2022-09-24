Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594275E880B
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 05:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiIXDqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 23:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIXDqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 23:46:33 -0400
Received: from titan5.planetwebservers.net (titan5.planetwebservers.net [51.222.33.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8026C
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To
        :From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SWTT59Ybio+fPOc4eiuZakWo1hb7o1LcP/05vDvhCHE=; b=IERkYVQIijVZC+q1bdg/8h/qRJ
        SguZmtHAa8cfQbMyhhSFW592v2KtRyvlvrRfSJhEe8w0rX0dJtmmv8qUqL9GjWurx3kgvAQL4tve+
        t9U+yuraOzQM4PfyJrlwIrnsYxJfSiNkh6T6e2V/NC7v9nj9JDHE/T0kfDajnaM6ZRDNGgvTd+YBm
        1ohhnvcAZv+0SSJrlFi7k5iVXhGxkecfyQZoeqP+mbPc5f77VOn/Oxe99fn3jOuXYj4sE3i0fHWxt
        qeRaNRn6jeezyqJQMC3eDK/Jz70LUGfseIamQgT2pSoUL+Bbpgk71RRqI1tu8ng4/h01W/lXRqI8k
        xePbX1GA==;
Received: from [76.75.115.213] (port=52638 helo=[192.168.68.80])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bjlockie@lockie.ca>)
        id 1obw7W-0001dV-N4
        for linux-wireless@vger.kernel.org;
        Sat, 24 Sep 2022 13:46:31 +1000
Message-ID: <e5554577-f345-c6a5-cc27-53ef50be0d50@lockie.ca>
Date:   Fri, 23 Sep 2022 23:46:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: what MediaTek chipset do I have?
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
To:     linux-wireless <linux-wireless@vger.kernel.org>
References: <71575c7b-8487-3b12-fe33-3e5e8b2ff9a2@lockie.ca>
 <02402e49-653f-509b-a841-b360fd1a62b1@candelatech.com>
 <d196d238-3340-deb6-b1dd-b6ccf329a8af@lockie.ca>
In-Reply-To: <d196d238-3340-deb6-b1dd-b6ccf329a8af@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

That's promising. :-)
It doesn't support 160MHz wide channels?
Still way better driver support IMO.

# uname -a
Linux lubuntu 5.19.0-15-generic #15-Ubuntu SMP PREEMPT_DYNAMIC Tue Aug 2 
07:35:59 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux


# lspci
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz


On 2022-09-23 20:53, James wrote:
> A 0608 device is a 7921k?
>
> What device is a 7921e?
>
> On 2022-09-23 20:24, Ben Greear wrote:
>> On 9/23/22 4:18 PM, James wrote:
>>> I bought a MediaTek PCI card on Amazon that is supposed to be a 
>>> 7921k chip.
>>> I don't have a 6GHz router and the seller says if I did then it will 
>>> work in 6GHz.
>>> The Windows driver is for an AMD RZ608 Wi-Fi 6E 80MHz but the 
>>> properties there don't say 6GHz.
>>> The seller says I can't see 6GHz there unless I have a 6GHz router.
>>> I don't believe that  but you guys know better.
>>> I bought it for Linux. :-)
>>> The only reason I mention Windows is because that is the seller's 
>>> language.
>>>
>>> Here is Linux info:
>>> 5.15.0-48-generic #54-Ubuntu SMP x86_64
>>>
>>> # lspci -k
>>> 04:00.0 Network controller: MEDIATEK Corp. Device 0608
>>>          Subsystem: MEDIATEK Corp. Device 0608
>>>          Kernel driver in use: mt7921e
>>>          Kernel modules: mt7921e
>>>
>>> Would I say 7921k if it was?
>>>
>>
>> That looks like 7921k to me, and it will do 6E, though you might need 
>> newer kernel and/or regulatory domain
>> to get it working properly.  We've tested it successfully on 6E, on 
>> Linux of course.
>>
>> Thanks,
>> Ben
>>

