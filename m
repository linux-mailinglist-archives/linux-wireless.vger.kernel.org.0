Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D686F343
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfD3JpF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 05:45:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfD3JpE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 05:45:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3BD5460FED; Tue, 30 Apr 2019 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556617503;
        bh=9mrdmhCcV3kVI5UiSBT/pSyeccGh9Vq4DmmXYx4oRdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hMaRHXnwoU+JDls3mBmCxpds18W4BUo6kTScgitletvP1Qq8WP5mLt6C5h5PQlQUs
         dlZH3mjWAqklWoDiomK4HpDvM1YvdNUrIDWc8umehUAw8SzQdh7U8UQ4Y+K2UQW58x
         JhTtT3rtYBMvcvFql5/dnJ0aaBTAw30GcPrUD/4A=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 89E2060E41;
        Tue, 30 Apr 2019 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556617500;
        bh=9mrdmhCcV3kVI5UiSBT/pSyeccGh9Vq4DmmXYx4oRdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ThPbZKF5KMREHF7avscudEfHp2AnQeHIgtDSNr8aRqZGurQ38nXSInmjCkt89B/D+
         57U5V0rVewA/90aZ3/YsgonSzA0RbWplIO3KMK46MDSA3v3tP91TCEwmAbkFWB2wvk
         a8qTIUUMxiB0XlGip6ceFwoFQIOUqXWEbs/scbzw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 30 Apr 2019 17:45:00 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, linux-wireless-owner@vger.kernel.org
Subject: Re: [RFC/RFT] mac80211: Switch to a virtual time-based airtime
 scheduler
In-Reply-To: <87bm10ped0.fsf@toke.dk>
References: <20190215170512.31512-1-toke@redhat.com>
 <753b328855b85f960ceaf974194a7506@codeaurora.org> <87ftqy41ea.fsf@toke.dk>
 <acd33756e87ea64c608e306e5ee60aa2@codeaurora.org> <877ec2ykrh.fsf@toke.dk>
 <89d32174b282006c8d4e7614657171be@codeaurora.org> <87a7gyw3cu.fsf@toke.dk>
 <73077ba7cda566d5eeb2395978b3524c@codeaurora.org> <877ec0u6mu.fsf@toke.dk>
 <76591d2924d7b6fec06d0df07247166a@codeaurora.org> <87bm10ped0.fsf@toke.dk>
Message-ID: <a9bfcb131944fafb838ab5cd448e7da2@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-04-21 05:15, Toke Høiland-Jørgensen wrote:
> Yibo Zhao <yiboz@codeaurora.org> writes:
> 
>> On 2019-04-11 19:24, Toke Høiland-Jørgensen wrote:
>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>> 
>>>> On 2019-04-10 18:40, Toke Høiland-Jørgensen wrote:
>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>> 
>>>>>> On 2019-04-10 04:41, Toke Høiland-Jørgensen wrote:
>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>> 
>>>>>>>> On 2019-04-04 16:31, Toke Høiland-Jørgensen wrote:
>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>> 
>>>>>>>>>> On 2019-02-16 01:05, Toke Høiland-Jørgensen wrote:
>>>>>>>>>>> This switches the airtime scheduler in mac80211 to use a
>>>>>>>>>>> virtual
>>>>>>>>>>> time-based
>>>>>>>>>>> scheduler instead of the round-robin scheduler used before.
>>>>>>>>>>> This
>>>>>>>>>>> has
>>>>>>>>>>> a
>>>>>>>>>>> couple of advantages:
>>>>>>>>>>> 
>>>>>>>>>>> - No need to sync up the round-robin scheduler in
>>>>>>>>>>> firmware/hardware
>>>>>>>>>>> with
>>>>>>>>>>>   the round-robin airtime scheduler.
>>>>>>>>>>> 
>>>>>>>>>>> - If several stations are eligible for transmission we can
>>>>>>>>>>> schedule
>>>>>>>>>>> both of
>>>>>>>>>>>   them; no need to hard-block the scheduling rotation until 
>>>>>>>>>>> the
>>>>>>>>>>> head
>>>>>>>>>>> of
>>>>>>>>>>> the
>>>>>>>>>>>   queue has used up its quantum.
>>>>>>>>>>> 
>>>>>>>>>>> - The check of whether a station is eligible for transmission
>>>>>>>>>>> becomes
>>>>>>>>>>>   simpler (in ieee80211_txq_may_transmit()).
>>>>>>>>>>> 
>>>>>>>>>>> The drawback is that scheduling becomes slightly more
>>>>>>>>>>> expensive,
>>>>>>>>>>> as
>>>>>>>>>>> we
>>>>>>>>>>> need
>>>>>>>>>>> to maintain an rbtree of TXQs sorted by virtual time. This
>>>>>>>>>>> means
>>>>>>>>>>> that
>>>>>>>>>>> ieee80211_register_airtime() becomes O(logN) in the number of
>>>>>>>>>>> currently
>>>>>>>>>>> scheduled TXQs. However, hopefully this number rarely grows 
>>>>>>>>>>> too
>>>>>>>>>>> big
>>>>>>>>>>> (it's
>>>>>>>>>>> only TXQs currently backlogged, not all associated stations),
>>>>>>>>>>> so
>>>>>>>>>>> it
>>>>>>>>>>> shouldn't be too big of an issue.
>>>>>>>>>>> 
>>>>>>>>>>> @@ -1831,18 +1830,32 @@ void
>>>>>>>>>>> ieee80211_sta_register_airtime(struct
>>>>>>>>>>> ieee80211_sta *pubsta, u8 tid,
>>>>>>>>>>>  {
>>>>>>>>>>>  	struct sta_info *sta = container_of(pubsta, struct 
>>>>>>>>>>> sta_info,
>>>>>>>>>>> sta);
>>>>>>>>>>>  	struct ieee80211_local *local = sta->sdata->local;
>>>>>>>>>>> +	struct ieee80211_txq *txq = sta->sta.txq[tid];
>>>>>>>>>>>  	u8 ac = ieee80211_ac_from_tid(tid);
>>>>>>>>>>> -	u32 airtime = 0;
>>>>>>>>>>> +	u64 airtime = 0, weight_sum;
>>>>>>>>>>> +
>>>>>>>>>>> +	if (!txq)
>>>>>>>>>>> +		return;
>>>>>>>>>>> 
>>>>>>>>>>>  	if (sta->local->airtime_flags & AIRTIME_USE_TX)
>>>>>>>>>>>  		airtime += tx_airtime;
>>>>>>>>>>>  	if (sta->local->airtime_flags & AIRTIME_USE_RX)
>>>>>>>>>>>  		airtime += rx_airtime;
>>>>>>>>>>> 
>>>>>>>>>>> +	/* Weights scale so the unit weight is 256 */
>>>>>>>>>>> +	airtime <<= 8;
>>>>>>>>>>> +
>>>>>>>>>>>  	spin_lock_bh(&local->active_txq_lock[ac]);
>>>>>>>>>>> +
>>>>>>>>>>>  	sta->airtime[ac].tx_airtime += tx_airtime;
>>>>>>>>>>>  	sta->airtime[ac].rx_airtime += rx_airtime;
>>>>>>>>>>> -	sta->airtime[ac].deficit -= airtime;
>>>>>>>>>>> +
>>>>>>>>>>> +	weight_sum = local->airtime_weight_sum[ac] ?:
>>>>>>>>>>> sta->airtime_weight;
>>>>>>>>>>> +
>>>>>>>>>>> +	local->airtime_v_t[ac] += airtime / weight_sum;
>> Hi Toke,
>> 
>> I was porting this version of ATF design to my ath10k platform and 
>> found
>> my old kernel version not supporting 64bit division. I'm wondering if 
>> it
>> is necessary to use u64 for airtime and weight_sum here though I can
>> find a solution for it. I think u32 might be enough. For airtime,
>> u32_max / 256 = 7182219 us(718 ms). As for weight_sum, u32_max / 8092 
>> us
>> = 130490, meaning we can support more than 130000 nodes with airtime
>> weight 8092 us.
> 
> As Felix said, we don't really want divides in the fast path at all. 
> And
> since the divisors are constant, we should be able to just pre-compute
> reciprocals and turn the whole thing into multiplications...
> 
>> Another finding was when I configured two 11ac STAs with different
>> airtime weight, such as 256 and 1024 meaning ratio is 1:4, the
>> throughput ratio was not roughly matching the ratio. Could you please
>> share your results? I am not sure if it is due to platform difference.
> 
> Hmm, I tested them with ath9k where things seemed to work equivalently
> to the DRR. Are you testing the same hardware with that? Would be a 
> good
> baseline.
> 
> I am on vacation until the end of the month, but can share my actual
> test results once I get back...
Hi Toke,
I saw your commit in hostapd in
http://patchwork.ozlabs.org/patch/1059334/

For dynamic and limit mode described in above hostapd patch, do I need 
to change any code in this kernel patch or any other patches am I 
missing?

After a quick look at the hostapd patch, I guess all the efforts for 
both modes are done in hostapd. Correct me if I am wrong. :)
> 
> -Toke

-- 
Yibo
