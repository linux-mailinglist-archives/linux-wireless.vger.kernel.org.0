Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE91023F7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 13:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKSMMG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 07:12:06 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:42508 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSMMG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 07:12:06 -0500
Received: from [192.168.2.97] (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 28B1558007B;
        Tue, 19 Nov 2019 13:12:03 +0100 (CET)
Subject: Re: [PATCH v4 4/4] mt76: mt76x02: add channel switch support for usb
 interfaces
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
References: <20191118221540.14886-1-markus.theil@tu-ilmenau.de>
 <20191118221540.14886-5-markus.theil@tu-ilmenau.de>
 <20191119111927.GB22415@redhat.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <886910ec-7ffa-1d1c-b422-bc942c8acd46@tu-ilmenau.de>
Date:   Tue, 19 Nov 2019 13:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119111927.GB22415@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/19/19 12:19 PM, Stanislaw Gruszka wrote:
> On Mon, Nov 18, 2019 at 11:15:40PM +0100, Markus Theil wrote:
>> +static void mt76x2u_channel_switch_beacon(struct ieee80211_hw *hw,
>> +					  struct ieee80211_vif *vif,
>> +					  struct cfg80211_chan_def *chandef)
>> +{
>> +}
>> +
>>  const struct ieee80211_ops mt76x2u_ops = {
>>  	.tx = mt76x02_tx,
>>  	.start = mt76x2u_start,
>> @@ -121,4 +127,5 @@ const struct ieee80211_ops mt76x2u_ops = {
>>  	.get_survey = mt76_get_survey,
>>  	.set_tim = mt76_set_tim,
>>  	.release_buffered_frames = mt76_release_buffered_frames,
>> +	.channel_switch_beacon = mt76x2u_channel_switch_beacon,
> Is this needed ? Seems mac80211 check against this op being NULL
> in drv_channel_switch_beacon() and it is not used otherwise.
>  
> Stanislaw
I checked if this call is really needed and you're right, it is not
needed. I'll send v5 with this fix.
