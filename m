Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6311B162A6
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEGLO4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 07:14:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfEGLO4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 07:14:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 892AE60DB6; Tue,  7 May 2019 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557227695;
        bh=W6Da4lmzrAN7ThT1PUW5EF/gexzED6xbatYp6r99iok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oi9hbzQZgg/YJTRqGDA1g2IhOc2wxYU+hFVrJ773LRGa7YP/ge1HVZlynwAYq667K
         R53qgptn1Wz4KWKbLLvaQRqsYxWygRZ991zhx4MiuGOTN23wNJrHltEb2DR369VwKl
         5Rv4/oYyY/1ZkNtl+oe9PUV7KmEHuEaeqH8b8+Ms=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CD1FC6115D;
        Tue,  7 May 2019 11:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557227693;
        bh=W6Da4lmzrAN7ThT1PUW5EF/gexzED6xbatYp6r99iok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdK/1b9TAJsevZUSVozhZQUdX+srOeJmyeMdjoMlwzZLaYanWEVq46yZiHqaJ852x
         nIMLW56Gavo/FrKV3gcHFu7BpPuQSkUOScwzRLzEtRqrauK/P8LVsD+uqbi2hupCz+
         WO2+kvXA3ZeXAW3KkqMM7txus+mcD427XPSgsbjw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 07 May 2019 19:14:53 +0800
From:   leiwa@codeaurora.org
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: fix different tx duration output
In-Reply-To: <875zrbrb1q.fsf@toke.dk>
References: <1555489045-18070-1-git-send-email-leiwa@codeaurora.org>
 <87mukprnie.fsf@toke.dk> <298a645b17aac0f5c466f011225533b0@codeaurora.org>
 <875zrbrb1q.fsf@toke.dk>
Message-ID: <ef8c4fec57a8117b98e30c904fc1a3f5@codeaurora.org>
X-Sender: leiwa@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-04-18 16:07, Toke Høiland-Jørgensen wrote:
> leiwa@codeaurora.org writes:
> 
>> On 2019-04-17 17:26, Toke Høiland-Jørgensen wrote:
>>> Lei Wang <leiwa@codeaurora.org> writes:
>>> 
>>>> TX duration output of tx_stats in debugfs and station dump had big
>>>> difference because they got tx duration value from different 
>>>> statistic
>>>> data. We should use the same statistic data.
>>> 
>>> So are you sure you picked the most accurate one of the two? :)
>>> 
>>> -Toke
>> 
>> Hi Toke,
>> 
>> Yes.
>> Now for ath10k, there are two ways to get tx duration output.
>> One is got from tx_stats in debugfs reported by firmware. It is a 
>> total
>> value including all the frames which created by host and firmware sent
>> to the peer.
>> And the second is calculated from
>> ath10k_htt_rx_tx_compl_ind()-->ieee80211_sta_register_airtime(), here
>> the tx duration just includes the data frames sent from host to the
>> peer.
> 
> So the difference is that the former includes control frames as well? 
> Is
> that the only difference? And what exactly is a "big difference" (from
> the commit message)?
> 
Yes,it adds the duration time of receiving ACK frames.
 From my test,TX from AP to station with iperf UDP test in 
10s,tx_stats->tx_duration:5496623us,
and another value is 3934327us.
>> So the first value is preferable for station dump.
> 
> Hmm, I'm not sure if I agree with this. I specifically added the
> tx_duration to the station dump to be able to get the values used by 
> the
> airtime scheduler. This breaks with this patch.
> 
> -Toke
 From our internal discussing, we will revert this change.
Thanks.

Lei
