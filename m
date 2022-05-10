Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB35220D7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbiEJQRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiEJQRf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:17:35 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB67158FA5
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:13:37 -0700 (PDT)
Message-ID: <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1652199216;
        bh=JXdap2hB3qtrYFxPjA/2QM+ozPB/qGyGuduhT92uvq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jBSN8ytzDLI92enxQ40/CKh11kK2jLOk9wrDQGQcA1cN3mc/0VnE/q4Hio8DVL0Jk
         VlPqcYP8Bv4sor62eqxceZs7SytIGkc9Z3xYVMXtZUDFjRO7EE/8/UzNPcBltTDFln
         gCl1Jl/D+MdacLFlqs9JxeJWyCNXyWbsgZFoKbEU=
Date:   Tue, 10 May 2022 18:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mac80211: Simplify queue selection
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgens?= =?UTF-8?Q?en?= 
        <toke@kernel.org>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
 <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.05.22 18:10, Felix Fietkau wrote:
> On 10.05.22 17:58, Alexander Wetzel wrote:
>> Let iTXQ drivers also register four queues in netdev and move queue
>> assignment to ndo_select_queue(), like it's done for other drivers.
>>
>> This gets rid of a special case in mac80211 and also increases the
>> chance that when we call skb_get_hash() the skb is still hot in the CPU
>> buffers.
>>
>> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> 
> This has the disadvantage of requiring a redundant sta lookup in the tx 
> path for iTXQ drivers. I think the CPU cost of that one is probably 
> higher than any potential gain from calling skb_get_hash a bit earlier.

Found that one, yes. But why do we then not drop ndo_select_queue() for 
all drivers?

Or maybe just call skb_get_hash() in ndo_select_queue()... But I guess 
then it would make more sense to move the ndo_select_queue() into 
netdev, so all drivers get the optimization.

Alexander
