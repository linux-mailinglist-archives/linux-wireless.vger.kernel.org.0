Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619BA98653
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfHUVM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 17:12:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfHUVM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 17:12:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88D8260DB6; Wed, 21 Aug 2019 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566421947;
        bh=PBUYbv9JTZoU/c7AFVuRWv956Nc4PY4ZLwMmETMSG0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NI3PBqBjEFtdzB19Cycx3NdfY1aQB1XKsiXO+xfeXoepW9xbFSeRXECCUUOe3FO1P
         2vfr0inMvsJQlWeI9P2vfaoXj1Kf7sgX2Lw/NKVZqJGYxPmkWCXtXPrJ9qessW4hhH
         ZHgUg4wNyxQcOOwxmf1gEebkrwkO9Vs5thzojX7w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 269546030D;
        Wed, 21 Aug 2019 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566421947;
        bh=PBUYbv9JTZoU/c7AFVuRWv956Nc4PY4ZLwMmETMSG0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NI3PBqBjEFtdzB19Cycx3NdfY1aQB1XKsiXO+xfeXoepW9xbFSeRXECCUUOe3FO1P
         2vfr0inMvsJQlWeI9P2vfaoXj1Kf7sgX2Lw/NKVZqJGYxPmkWCXtXPrJ9qessW4hhH
         ZHgUg4wNyxQcOOwxmf1gEebkrwkO9Vs5thzojX7w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Aug 2019 14:12:27 -0700
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: Regression with commit "ath10k: fill the channel survey results
 for WCN3990 correctly"
In-Reply-To: <5D5DB246.7040402@candelatech.com>
References: <5D5DAFE4.6080706@candelatech.com>
 <5D5DB246.7040402@candelatech.com>
Message-ID: <c77c271a3d77d990b8de67cdbd8ea8c7@codeaurora.org>
X-Sender: pillair@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ben,
Can you please check https://patchwork.kernel.org/patch/10844513/ ?
This change fixes the below mentioned regression. A different structure 
is made for tlv specific event handling.

Thanks,
Rakesh Pillai.


On 2019-08-21 14:06, Ben Greear wrote:
> On 08/21/2019 01:56 PM, Ben Greear wrote:
>> Hello,
>> 
>> I just noticed in 5.2.7+ kernel than this commit below appears to 
>> break WMI
>> message for my 10.1 firmware, and based on code inspection, 10.2 will 
>> be broken
>> as well.
>> 
>> 10.1 struct ends with cycle_count, and 10.2 ends with one 32-bit 
>> number
>> after that, but which is not chan_tx_pwr_range.
>> 
>> I guess you need to create your own wmi msg for the WCN3990.
>> 
>> The change to 10.4 chan_info event is also wrong for my relatively
>> new version of 10.4 code, so likely breaks firmware in use.  last 
>> member
>> in that struct in my 10.4 fw src is 'A_UINT32 
>> rx_11b_mode_data_duration;'
> 
> Sorry, I mis-read this 10.4 part of the patch, it was not changing the 
> wmi event
> itself, so probably that part is fine.
> 
> Thanks,
> Ben
> 
>> 
>> 
>> commit 13104929d2ec32aec0552007d55b9e15bc07176b
>> Author: Rakesh Pillai <pillair@codeaurora.org>
>> Date:   Wed Oct 17 16:50:03 2018 +0530
>> 
>>      ath10k: fill the channel survey results for WCN3990 correctly
>> 
>> 
>> 
>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h 
>> b/drivers/net/wireless/ath/ath10k/wmi.h
>> index 4971d61..58e33ab 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi.h
>> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
>> @@ -6442,6 +6442,14 @@ struct wmi_chan_info_event {
>>          __le32 noise_floor;
>>          __le32 rx_clear_count;
>>          __le32 cycle_count;
>> +       __le32 chan_tx_pwr_range;
>> +       __le32 chan_tx_pwr_tp;
>> +       __le32 rx_frame_count;
>> +       __le32 my_bss_rx_cycle_count;
>> +       __le32 rx_11b_mode_data_duration;
>> +       __le32 tx_frame_cnt;
>> +       __le32 mac_clk_mhz;
>> +
>>   } __packed;
>> 
>> 
>> 
>> Thanks,
>> Ben
>> 
