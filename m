Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD08302CE1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jan 2021 21:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbhAYUrk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 15:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbhAYUrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 15:47:25 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C79C061573
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 12:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5LISp++Dkbv08dI08PcO40ucJk7Cs+Ccm41CzH0YZAo=; b=UieJ+fIZhgoMbFggC67xRhZifI
        oQNOLADu6WcBOPbNAUKfTOKhun4OEt7CyVtnHskKCl/tT3E03UPKXgxwak45lgS7+4mnCi+04z6hD
        X1huTtYLLg+beoJYNSO5YMd3NEUSHmif60TLuM6mc1wcooA3H07NZWc2/9J2LrzeRtyA=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l48kz-00050U-Fh; Mon, 25 Jan 2021 21:46:41 +0100
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20210124122812.49929-1-nbd@nbd.name>
 <20210124122812.49929-4-nbd@nbd.name> <87o8hdmdqs.fsf@toke.dk>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 4/6] mac80211: minstrel_ht: significantly redesign the
 rate probing strategy
Message-ID: <3ac94bcf-4c76-9c1e-c903-0810d2067b3a@nbd.name>
Date:   Mon, 25 Jan 2021 21:46:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <87o8hdmdqs.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-01-25 12:56, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> The biggest flaw in current minstrel_ht is the fact that it needs way too
>> many probing packets to be able to quickly find the best rate.
>> Depending on the wifi hardware and operating mode, this can significantly
>> reduce throughput when not operating at the highest available data rate.
>>
>> In order to be able to significantly reduce the amount of rate sampling,
>> we need a much smarter selection of probing rates.
>>
>> The new approach introduced by this patch maintains a limited set of
>> available rates to be tested during a statistics window.
>>
>> They are split into distinct categories:
>> - MINSTREL_SAMPLE_TYPE_INC - incremental rate upgrade:
>>   Pick the next rate group and find the first rate that is faster than
>>   the current max. throughput rate
>> - MINSTREL_SAMPLE_TYPE_JUMP - random testing of higher rates:
>>   Pick a random rate from the next group that is faster than the current
>>   max throughput rate. This allows faster adaptation when the link changes
>>   significantly
>> - MINSTREL_SAMPLE_TYPE_SLOW - test a rate between max_prob, max_tp2 and
>>   max_tp in order to reduce the gap between them
>>
>> In order to prioritize sampling, every 6 attempts are split into 3x INC,
>> 2x JUMP, 1x SLOW.
>>
>> Available rates are checked and refilled on every stats window update.
> 
> Very cool!
> 
>> With this approach, we finally get a very small delta in throughput when
>> comparing setting the optimal data rate as a fixed rate vs normal rate
>> control operation.
> 
> Can you quantify this "very small delta"? Would love to see some
> benchmark data :)
Based on a quick test it seems to be around 5% (sometimes less) at VHT80
MCS6 nss=4 with ~350 mbit/s TCP throughput. I guess I might be able to
bring that down even further, once I optimize it some more.

- Felix
