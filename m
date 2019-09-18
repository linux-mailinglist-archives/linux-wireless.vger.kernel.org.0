Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE8B63DE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 14:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfIRM6v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 08:58:51 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:43958 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfIRM6v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 08:58:51 -0400
Received: from [192.168.1.47] (unknown [50.34.216.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 06ED913C2BA;
        Wed, 18 Sep 2019 05:58:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 06ED913C2BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568811530;
        bh=swWESwF5RdUiGeJMFtJC0GLZlrgKFNyGYpmONj/yXXI=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=flAv1dzIuCNspzBo6gxOGFA3X9qj9ZjRH9WbyrdKsUmUR/f4DuDKv+FrAgoy2CKuV
         Qq/k5Dv6R6LmbbaN0ni3NknsmNZObKWeEtFlgguRfheDvARZ8DwAL8Swv6K1cT/a3Q
         sbEKja0Sv5Q6mtByGH8tvXPfztULE2MRZoEBJOt4=
Subject: Re: [PATCH] cfg80211: Add cumulative channel survey dump support.
To:     Sven Eckelmann <sven@narfation.org>, ath10k@lists.infradead.org,
        sw@simonwunderlich.de
References: <1526980556-26707-1-git-send-email-vnaralas@codeaurora.org>
 <ebf1c95acb34649b3d2a5435142dc06a@codeaurora.org>
 <2083094.mFhUXK7yzB@bentobox> <18458963.ukFM9YuvQx@bentobox>
Cc:     vnaralas@codeaurora.org, Johannes Berg <johannes@sipsolutions.net>,
        slakkavalli@datto.com, linux-wireless@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <b24ec622-8510-d8e4-bbc4-86a34c1dd32b@candelatech.com>
Date:   Wed, 18 Sep 2019 05:58:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <18458963.ukFM9YuvQx@bentobox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 09/18/2019 01:46 AM, Sven Eckelmann wrote:
> On Tuesday, 17 September 2019 19:27:50 CEST Sven Eckelmann wrote:
> [...]
>> So whatever the firmware does when it gets a
>> WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR -  it is not a CLEAR after read. And they
>> also don't simply wrap around but there all values have to get some kind of
>> "fix" like the active time one shown in ath10k_hw_fill_survey_time.
>> Just that the actual "fixes" for them are unknown. To me it looks like
>> firmware ATH10K_HW_CC_WRAP_SHIFTED_ALL have busy and rx interlinked with
>> the overflow of total. But the tx and rx_bss are actually cleared.
>>
>> Other than that, the counters are wrapping every ~14-30 seconds. So we
>> also need also some worker for ath10k which every couple of seconds
>> requests new values for all the channel from the firmware. Which already
>> sounds problematic because I get
>> "ath10k_pci 0000:00:00.0: bss channelsurvey timed out" all the time
>> when requesting surveys manually.
>
> I've just tested it on 10.4 (wave-2) cards and it seems like it is cleared as
> expected on them. So the change I posted earlier (with a minor fix for
> ath10k_hw_fill_survey_time) returns now useful (accumulated) values. This can
> be seen in
> https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86749f4d60&fullscreen&panelId=5&from=1568782046974&to=1568807068706
> (after the reboot at 10:15 UTC+2)
>
> So as Ben Greear said, the 10.4 firmware version is fixed and 10.2.* (for
> the wave-1 cards) is still broken and we need a QCA firmware engineer to
> fix it. Or to work around it by polling every couple of seconds and
> manually do the cleanup of the values from the firmware.

Have you tried probing very fast, like every 100ms, to see if returned values
look sane?  I seem to recall that there was some firmware issue with this, like
it only updates internal counters every second or so.

Polling slow would have the same off-by-a-second's-worth-of-data, but you would not
easily notice it at slower polling intervals.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
