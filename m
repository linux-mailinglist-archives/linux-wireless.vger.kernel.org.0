Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB348ABBA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiAKKyM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiAKKyL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:54:11 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993DC06173F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 02:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QfzM5wdLd0BHrMdguTSEuLuhAyxlju54ulDYhWkJ770=; b=uagkFkCBfkQq+2Cy5cPKD96xZj
        KWbtyJrAXDyfB5t9xmSoMDF28aKw6uoKsYzEic11qu780USFMhTlnEB2t6XT1+McoNkV6wUxKPehP
        0vM2fQjUXQCeOVZvtBfbNrrwTeXJXcAfqSkJ3g8TXgbSHa3OMbIzb4ivGUeBcyHqpLao=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n7Emy-0006Yr-6Z; Tue, 11 Jan 2022 11:54:04 +0100
Message-ID: <94eb0f94-6d86-45b8-54e3-424be3395fc9@nbd.name>
Date:   Tue, 11 Jan 2022 11:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 1/2] mt76: mt7921: fix a leftover race in runtime-pm
To:     Kalle Valo <kvalo@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
References: <cover.1640897147.git.lorenzo@kernel.org>
 <65e65daddbcec420392befa3b4f9a6aaaea21315.1640897147.git.lorenzo@kernel.org>
 <87zgo2k1b2.fsf@tynnyri.adurom.net>
Content-Language: en-US
In-Reply-To: <87zgo2k1b2.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2022-01-11 11:35, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>> Fix a possible race in mt7921_pm_power_save_work() if rx/tx napi
>> schedules ps_work and we are currently accessing device register
>> on a different cpu.
>>
>> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> index defef3496246..0744f6e42ba3 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>> @@ -1553,6 +1553,14 @@ void mt7921_pm_power_save_work(struct work_struct *work)
>>  	    dev->fw_assert)
>>  		goto out;
>>  
>> +	if (mutex_is_locked(&dev->mt76.mutex))
>> +		/* if mt76 mutex is held we should not put the device
>> +		 * to sleep since we are currently accessing device
>> +		 * register map. We need to wait for the next power_save
>> +		 * trigger.
>> +		 */
>> +		goto out;
> 
> This looks fishy to me. What protects the case when ps_work is run first
> and at the same time another cpu starts accessing the registers?
> 
> Do note that I didn't check the code, so I might be missing something.
For atomic context there is a locked counter pm->wake.count which is 
used to prevent the device from going to sleep. If the device is 
sleeping already on irq/tx, it is woken up and the function is 
rescheduled. The device is never put to sleep while the wake count is 
non-zero.

For non-atomic context, the mutex is always held. There is a wrapper for 
acquiring and releasing the mutex, which cancels the work after 
acquiring the mutex and reschedules the delayed work after updating the 
last activity timestamp (which gets checked here after checking the mutex).

The corner case that needs this mutex check here is when the work was 
scheduled again after processing some NAPI, tx or irq activity and the 
work gets run all while another cpu is in the middle of a long running 
non-atomic activity that holds the mutex.

For that we really do need the simple mutex_is_locked check, since 
actually holding the lock here would cause a deadlock with the 
mutex_acquire wrapper.

- Felix

