Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1DAC0224
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI0JUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Sep 2019 05:20:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfI0JUY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Sep 2019 05:20:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C1CDB61213; Fri, 27 Sep 2019 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569576023;
        bh=HxHNw3EkNx8rTi9xzBH9OQprBb2gfO3yoxjfzyezhiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nCFyShLznamizdnoAY75Fcpd7DISPeDH/nhYAOULxAdeS1bcAVoVcxkJ5PjSIGRMB
         VE/NyPqCy5XGfG3yqP/DTAWXfkw2wTYA/rKtOK+74egQ6hejINLTPF2O/j6VYSWhsN
         +wPhmZplR02Qe14QijMUk3MpauTUhiW8i6JsR3ew=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5B24F60C72;
        Fri, 27 Sep 2019 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569576018;
        bh=HxHNw3EkNx8rTi9xzBH9OQprBb2gfO3yoxjfzyezhiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NfrdUBMp8wGnyb6MkEsfjWrV70VUT+7rh0GeEDH1QN+47giD0W0+df5SUkTyKcphV
         E2X8M+z1JRIYROLfmyRt53QoR5rUBWKzEh4VZnyObgP2z2fxcqKARsY/Df/BMlbJ/V
         121Ah9xBCrNbW2hIlMjv2SMM5TAi3yKsEXm2iLJQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Sep 2019 17:20:08 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Kan Yan <kyan@google.com>, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
In-Reply-To: <87r2421d4f.fsf@toke.dk>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
 <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name> <87wodv19jl.fsf@toke.dk>
 <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name> <87tv8z13wv.fsf@toke.dk>
 <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com>
 <87r2421d4f.fsf@toke.dk>
Message-ID: <ed46699c32cd3d8d8bcc9bce1375ba04@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-27 14:12, Toke Høiland-Jørgensen wrote:
> Kan Yan <kyan@google.com> writes:
> 
>>> No, but on tx_completion we could do something like this:
>>> airtime = CB(skb)->tx_time ?: CB(skb)->tx_time_est;
>>> ieee80211_report_airtime(sta, airtime);
>>> That way, if the driver sets the tx_time field to something the 
>>> firmware
>>> reports, we'll use that, and otherwise we'd fall back to the 
>>> estimate.
>>> Of course, there would need to be a way for the driver to opt out of
>>> this, for drivers that report out of band airtime like ath10k does :)
>> 
>> I doubt that will work, unless firmware can do per frame airtime
>> update in the skb. It is more likely that firmware provides out of
>> band airtime update for a period of time, like an aggregation. That's
>> the case for ath10k: https://patchwork.kernel.org/patch/10684689
> 
> No, ath10k would continue to do what it was always doing. Drivers that
> can report after-the-fact airtime usage per-frame (like ath9k) will
> continue to do that. In both of those cases, the airtime estimate is
> only used to throttle the queue, not to schedule for fairness.
> 
> My point is just that for drivers that have *no* mechanism to report
> airtime usage after-the-fact, we can add a flag that will allow the
> values estimated by mac80211 to also be used for the fairness
> scheduler...
> 
>> Regarding handling frame for station enters power saving mode:
>>> 
>>> >> Oh, right. Didn't know that could happen (I assumed those would be
>>> >> flushed out or something). But if we're going to go with Kan's
>>> >> suggestion of having per-station accounting as well as a global
>>> >> accounting for the device, we could just subtract the station's
>>> >> outstanding balance from the device total when it goes into powersave
>>> >> mode, and add it back once it wakes up again. At least I think that
>>> >> would work, no?
>>> >Yes, I think that would work.
>>> Great! Will incorporate that, then.
>> 
>> I think that could work but things could be a bit more complicated.
>> Not sure I fully understand the usage of airtime_weight_sum in  [PATCH
>> V3 1/4] mac80211: Switch to a virtual time-based airtime scheduler:
>> 
>> in ieee80211_schedule_txq():
>>    local->airtime_weight_sum[ac] += sta->airtime_weight;
>> 
>> in ieee80211_sta_register_airtime():
>>    weight_sum = local->airtime_weight_sum[ac] ?: sta->airtime_weight;
>>    local->airtime_v_t[ac] += airtime / weight_sum;
>>    sta->airtime[ac].v_t += airtime / sta->airtime_weight;
>> 
>> in  __ieee80211_unschedule_txq
>>  local->airtime_weight_sum[ac] -= sta->airtime_weight;
>> 
>> I assume the purpose of airtime_weight_sum is to count station's
>> virtual airtime proportional to the number of active stations for
>> fairness.
> 
> Yup, the proportion between the station's airtime weight and the total
> scheduled airtime weight indicates the station's fair share.
> 
>> My concern is the per interface local->airtime_weight_sum[ac] get
>> updated when packets are released from a txq to lower layer, but it
>> doesn't mean the airtime will be consumed (packets get transmitted)
>> shortly, due to events like station enter power save mode, so the
>> weight_sum used in ieee80211_sta_register_airtime() maybe inaccurate.
>> For architects using firmware/hardware offloading, firmware ultimately
>> controls packet scheduling and has quite a lot of autonomy. The host
>> driver's airtime_weight_sum may get out of sync with the number of
>> active stations actually scheduled by firmware even without power
>> saving events.
>> 
>> Is this a correct understanding? I kind of think the original method
>> of airtime accounting using deficit maybe more robust in this regard.
> 
> You are right that this could happen, yes. However, the station is only
> unscheduled when its mac80211 queue runs completely empty. So the
> assumption is that stations that transmit continuously (which are 
> really
> the ones we care about for fairness purposes), would keep being
> scheduled most of the time.
> 
> Now, you're quite right that this assumption might be wrong, which 
> would
> lead to bad results. I think the other (queue throttling) patch set
> would help, though; that should push the queues up into mac80211 and
> give the stations a higher probability of being scheduled when they are
> in fact backlogged. I've only tested the virtual time scheduler on
> ath9k, which inherently has shallow buffers in the hardware.
> 
> So yeah, it may be that the virtual time-thing turns out to not work
> well. But the results looked encouraging on ath9k, and since it will

I am not familiar with ath9k but SFAIK, ath9k is fine with virtual 
time-thing because it does not have firmware/hardware offloading. Thus 
host can see the packets backlogged in host queue and TXQs stay on 
rbtree for the most of time if there is continuous transmission. As a 
result, the algo fully works. While for ath10k like Kan said, it has 
firmware/hardware offloading and host cannot see the packets backlogged 
in host queue because they are already sent to FW queue as long as the 
ingress load less than PHY rate. Then TXQs are removed from the rbtree 
which leads to the algo not working so well. For driver that has 
firmware/hardware offloading, I think the key is to keep some of the 
packets buffered in the host even if FW queue is not full at that time. 
Also I believe DRR may have the same issue since only TXQs in the list 
contend for Tx chance.

> make it easier to schedule multiple stations, I think it has some merit
> that makes it worth trying out. We should probably get the AQL stuff
> done first, though, and try the virtual time scheduler on top of that.

Agree that we should get the AQL stuff done first since I believe it 
will help to fix the issue mentioned above.

> 
> BTW, I think Felix' concern about powersave was in relation to AQL: If
> we don't handle power save in that, we can end up in a situation where
> the budget for packets allowed to be queued in the firmware is taken up
> entirely by stations that are currently in powersave mode; which would
> throttle the device completely. So we should take that into account for
> AQL; for the fairness scheduler, stations in powersave are already
> unscheduled, so that should be fine.
> 
> -Toke

-- 
Yibo
