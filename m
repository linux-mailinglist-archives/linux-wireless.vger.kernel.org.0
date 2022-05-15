Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA852773B
	for <lists+linux-wireless@lfdr.de>; Sun, 15 May 2022 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiEOLKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 May 2022 07:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiEOLKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 May 2022 07:10:14 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C96D2B1A8
        for <linux-wireless@vger.kernel.org>; Sun, 15 May 2022 04:10:11 -0700 (PDT)
Message-ID: <c5d153e5-8b03-325d-d53c-27fb7a3f1010@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1652613008;
        bh=Uql2AAPwTXp10R9zgRA6hkTcR+0DDS1/7YdEGFdQrxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XcjzgfkzsVyMvQ1Pv9ynDAFzogR0ASzcwrsN166dEEQc/AOI5mB9jdCkVYUMm9T8o
         GfXruFLEOpSiF7YKEYgcJQj0DvOg/FTLgbWyKPQ0M0CtIU0vtT5nF8CaOQTKv2lm0g
         BCCFwwMOPvYvpXYH4UBp7EmBQ6Os61jWiOvSDwoU=
Date:   Sun, 15 May 2022 13:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mac80211: Simplify queue selection
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgens?= =?UTF-8?Q?en?= 
        <toke@kernel.org>
References: <20220510155828.9406-1-alexander@wetzel-home.de>
 <54589d98-882c-cee4-dd6d-140d50f400d0@nbd.name>
 <13154ef7-63ee-cfe7-3ebb-a7f1120985b6@wetzel-home.de>
 <7704c238-1d19-b423-881a-6bb3b8920946@nbd.name>
 <e941f28fe46341dac47c44afc848039ea2008577.camel@sipsolutions.net>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <e941f28fe46341dac47c44afc848039ea2008577.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.05.22 18:22, Johannes Berg wrote:
> On Tue, 2022-05-10 at 18:21 +0200, Felix Fietkau wrote:
>>
>> To fix this properly, we'd need to move to iTXQ for all drivers (by
>> having mac80211 push packets via drv_tx calls after pulling from iTXQ).
>> This can probably be done without having to modify the drivers.
>>
> 
> I looked at this, and I kind of really want to do that, but it's not
> _entirely_ trivial... If somebody's sufficiently motivated I'd
> definitely be happy :)

No promise I'll see that trough... But I'll start to look into that.
While I don't have much time for coding at the moment this sounds 
worthwhile and instructive at the same time.

Also thanks to all for the other feedback's. I'm starting to see the 
woods and not only the trees:-)


Alexander
