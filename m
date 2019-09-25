Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA4CBDD73
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbfIYLyk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 07:54:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfIYLyj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 07:54:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7BC3960274; Wed, 25 Sep 2019 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569412478;
        bh=iQBuWf9rywNr0YTDB9/YX72wg4TP+napHo/lG9qLGr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/8UTdwoM6sQeXhqaV4zepSR7XEA7gNTn/3QU4NfudoEKFAf5qNx8j9sS5q24eRDJ
         dGsRBX0pUmQ2aost2N0xiNQcAhW47YqbUyJPrejjIi3gxqB5AWPdtQpkozKBkgQGC9
         eFqY0dI3laLuBZV7uwmTJR84WLWBSpNj/uy/zPRs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7977560274;
        Wed, 25 Sep 2019 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569412477;
        bh=iQBuWf9rywNr0YTDB9/YX72wg4TP+napHo/lG9qLGr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RcRAtDys+SNpNU6qqoYQyI30IMehShr+JY7dE4/Y2qCzS+VFXsWv1BmWU4xsn+om7
         gEmQBLZX5dBNJEPbEG40OxybpTEBz0TaBSRKpjlyhE6gV4EQ+vNmIF6M8eDbkOc+kj
         4NrUejGDn7ojIFYYwU1KKdk6YVTz1xXY9JG+hHDE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 25 Sep 2019 19:54:37 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
In-Reply-To: <87y2yc3ieb.fsf@toke.dk>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
 <2f6b649dcb788222e070ebb5593918c7@codeaurora.org> <87y2yc3ieb.fsf@toke.dk>
Message-ID: <8c5a3a011f03d4dd4165b838a2b8bc72@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-25 16:11, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> So if it is going to work together with virtual time based mechanism 
>> in
>> the future, the Tx criteria will be met both of below conditions,
>>         1. Lower than g_vt
>>         2. Lower than IEEE80211_AIRTIME_QUEUE_LIMIT
> 
>> Are we going to maintain two kinds of airtime that one is from
>> estimation and the other is basically from FW reporting?
> 
> Yes, that was my plan. For devices that don't have FW reporting of
> airtime, we can fall back to the estimation; but if we do have FW
> reporting that is most likely going to be more accurate, so better to
> use that for fairness...

Do you mean we will use airtime reported by FW to calculate 
local->airtime_queued in case we have FW reporting airtime?

> 
>> Meanwhile, airtime_queued will also limit the situation that we only
>> have a station for transmission. Not sure if the peak throughput will
>> be impacted. I believe it may work fine with 11ac in chromiumos, how
>> about 11n and 11a?
> 
> Well, we will need to test that, of course. But ath9k shows that it's
> quite possible to run with quite shallow buffers, so with a bit of
> tuning I think we should be fine. If anything, slower networks need
> *fewer* packets queued in the firmware, and it's *easier* for the host
> to keep up with transmission.
> 
>> Anyway, I think this approach will help to improve performance of the
>> virtual time based mechanism since it makes packets buffered in host
>> instead of FW's deep queue. We have observed 2-clients case with
>> different ratio in TCP fails to maintain the ratio because the packets
>> arriving at host get pushed to FW immediately and thus the airtime
>> weight sum is 0 in most of time meaning no TXQ in the rbtree. For UDP,
>> if we pump load more than the PHY rate, the ratio can be maintained
>> beacuse the FW queue is full and packtes begin to be buffered in host
>> making TXQs staying on the rbtree for most of time. However, TCP has 
>> its
>> own flow control that we can not push enough load like UDP.
> 
> Yes, fixing that is exactly the point of this series :)
> 
> -Toke

-- 
Yibo
