Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795D522114
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiEJQZZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbiEJQZX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:25:23 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2294F2721
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SdWZN43I8+jnvvLzzhiZiHbCxULShKwv8x4vyZg1TMo=; b=tFquECPDbpOP0VCz7noJO7v8nu
        1lO5rFPufwt7ZK3yKyPS5W2DjLF8tYoVM5Hfam3pX2qQ3xkLp/PyokXmiiCd8H7sSivy07nRklM6e
        wrbd7BnTl29kJBBqXaBDtbvyiLZ2ot00iWQ7gDWEc0uVfz9ovNArrwce63IV1TP1vt6s=;
Received: from p200300daa70ef200fccd1f935f1cf3cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:fccd:1f93:5f1c:f3cd] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1noSby-0004iJ-SU; Tue, 10 May 2022 18:21:22 +0200
Message-ID: <7704c238-1d19-b423-881a-6bb3b8920946@nbd.name>
Date:   Tue, 10 May 2022 18:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH] mac80211: Simplify queue selection
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgens?= =?UTF-8?Q?en?= 
        <toke@kernel.org>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
 <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
 <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
Content-Language: en-US
In-Reply-To: <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 10.05.22 18:13, Alexander Wetzel wrote:
> On 10.05.22 18:10, Felix Fietkau wrote:
>> On 10.05.22 17:58, Alexander Wetzel wrote:
>>> Let iTXQ drivers also register four queues in netdev and move queue
>>> assignment to ndo_select_queue(), like it's done for other drivers.
>>>
>>> This gets rid of a special case in mac80211 and also increases the
>>> chance that when we call skb_get_hash() the skb is still hot in the CPU
>>> buffers.
>>>
>>> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
>> 
>> This has the disadvantage of requiring a redundant sta lookup in the tx 
>> path for iTXQ drivers. I think the CPU cost of that one is probably 
>> higher than any potential gain from calling skb_get_hash a bit earlier.
> 
> Found that one, yes. But why do we then not drop ndo_select_queue() for
> all drivers?
> 
> Or maybe just call skb_get_hash() in ndo_select_queue()... But I guess
> then it would make more sense to move the ndo_select_queue() into
> netdev, so all drivers get the optimization.

When not using iTXQ, packets are buffered in netdev qdisc. In order for 
that to work, ndo_select_queue needs to be called *before* packets are 
put into qdisc (so long before the actual mac80211 xmit handler).
To fix this properly, we'd need to move to iTXQ for all drivers (by 
having mac80211 push packets via drv_tx calls after pulling from iTXQ).
This can probably be done without having to modify the drivers.

- Felix


