Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A812C48B021
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbiAKPBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbiAKPA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 10:00:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DEDC06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 07:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32545B81B35
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 15:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3DAC36AEB;
        Tue, 11 Jan 2022 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641913254;
        bh=P5vG9fHxqRv8zbrgTAGykm+5NFhHtGWyBu1F9lyR5fE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RAKYbcpjqWOipnZQJCWSGyc5QYtMfIHh1J0KaA1yISsRZCQSPDLLbBA/Rvd2GcYfH
         CojlNa8RDYbgBBnOwrEiUuZW/4wYQYB8s8R0+lgZAwglWVTM+xmxUPjS7DZO8L2g97
         Ewlo6Sf5JTEElCv42VZdafYtBMijF2LfD9eEPIydhSCD7Qw5qTB/r1sUZh5SasThBZ
         cmh86Dn5tpPUBCyRnZMqhcCkHnf50+LHrT66jTzD2iL8G9Z+UmLjAvpPcscUEoDJ2P
         rafO8kEPgTRHO87VrgBWpJemBMsHOVnDqIe4Bs6g9nX1ZN5JqsTuxQmg2ua487uJSK
         Wlx4QSDyzk36A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com,
        deren.wu@mediatek.com
Subject: Re: [PATCH 1/2] mt76: mt7921: fix a leftover race in runtime-pm
References: <cover.1640897147.git.lorenzo@kernel.org>
        <65e65daddbcec420392befa3b4f9a6aaaea21315.1640897147.git.lorenzo@kernel.org>
        <87zgo2k1b2.fsf@tynnyri.adurom.net>
        <94eb0f94-6d86-45b8-54e3-424be3395fc9@nbd.name>
Date:   Tue, 11 Jan 2022 17:00:50 +0200
In-Reply-To: <94eb0f94-6d86-45b8-54e3-424be3395fc9@nbd.name> (Felix Fietkau's
        message of "Tue, 11 Jan 2022 11:54:03 +0100")
Message-ID: <87wnj6tizh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2022-01-11 11:35, Kalle Valo wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>
>>> Fix a possible race in mt7921_pm_power_save_work() if rx/tx napi
>>> schedules ps_work and we are currently accessing device register
>>> on a different cpu.
>>>
>>> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>>> index defef3496246..0744f6e42ba3 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>>> @@ -1553,6 +1553,14 @@ void mt7921_pm_power_save_work(struct work_struct *work)
>>>  	    dev->fw_assert)
>>>  		goto out;
>>>  +	if (mutex_is_locked(&dev->mt76.mutex))
>>> +		/* if mt76 mutex is held we should not put the device
>>> +		 * to sleep since we are currently accessing device
>>> +		 * register map. We need to wait for the next power_save
>>> +		 * trigger.
>>> +		 */
>>> +		goto out;
>>
>> This looks fishy to me. What protects the case when ps_work is run first
>> and at the same time another cpu starts accessing the registers?
>>
>> Do note that I didn't check the code, so I might be missing something.
> For atomic context there is a locked counter pm->wake.count which is
> used to prevent the device from going to sleep. If the device is
> sleeping already on irq/tx, it is woken up and the function is
> rescheduled. The device is never put to sleep while the wake count is
> non-zero.
>
> For non-atomic context, the mutex is always held. There is a wrapper
> for acquiring and releasing the mutex, which cancels the work after
> acquiring the mutex and reschedules the delayed work after updating
> the last activity timestamp (which gets checked here after checking
> the mutex).
>
> The corner case that needs this mutex check here is when the work was
> scheduled again after processing some NAPI, tx or irq activity and the
> work gets run all while another cpu is in the middle of a long running
> non-atomic activity that holds the mutex.
>
> For that we really do need the simple mutex_is_locked check, since
> actually holding the lock here would cause a deadlock with the
> mutex_acquire wrapper.

Very good, thanks Felix and Lorenzo for explaining all this. I just
always get wary when I see mutex_is_locked() being used.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
