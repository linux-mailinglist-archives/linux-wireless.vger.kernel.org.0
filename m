Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6345450E1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jun 2022 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiFIPdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jun 2022 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiFIPdG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jun 2022 11:33:06 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775764F1D3
        for <linux-wireless@vger.kernel.org>; Thu,  9 Jun 2022 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ualphzSRMcpR/j7yZ7iHbJPU8LTywlVVlmZmkrMSbfo=; b=MipUN/50ltFUqY8mp+LPlhoHHj
        vNfXsbPRdMen90wHEMz1Shy1R+On9RtaggN6HpYw7z8JtuYP6nr6MH9W/Wy5JIJeRA1NnpTHvzKfC
        IzLioZzEE3H4KjOrOS2lFKJMPJdAEMwoxOmRhUo6901h8bDCeHVygb5OEebut5ebktzw=;
Received: from p57a6f999.dip0.t-ipconnect.de ([87.166.249.153] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nzK9d-0002L1-U1; Thu, 09 Jun 2022 17:33:02 +0200
Message-ID: <1d7870e7-6b41-3eb6-910f-8df335b222bc@nbd.name>
Date:   Thu, 9 Jun 2022 17:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] mac80211: fix overflow issues in airtime fairness
 code
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20220603164307.92189-1-nbd@nbd.name> <87bkv7owq1.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <87bkv7owq1.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.06.22 19:18, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> The airtime weight calculation overflows with a default weight value of 256
>> whenever more than 8ms worth of airtime is reported.
>> Bigger weight values impose even smaller limits on maximum airtime values.
>> This can mess up airtime based calculations for drivers that don't report
>> per-PPDU airtime values, but batch up values instead.
>>
>> Fix this by reordering multiplications/shifts and by reducing unnecessary
>> intermediate precision (which was lost in a later stage anyway).
>>
>> The new shift value limits the maximum weight to 4096, which should be more
>> than enough. Any values bigger than that will be clamped to the upper limit.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> The weights are UAPI, so I guess we could run into applications that
> expect to be able to set a weight higher than 4096? I don't think this
> is too likely, but maybe it is better to reject such attempts instead of
> silently clamping the value, to flush out any breakage if it does occur?
Will do this in v2.

Thanks,

- Felix
