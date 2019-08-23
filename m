Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466C59A68D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 06:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbfHWEVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 00:21:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391131AbfHWEVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 00:21:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94DC960208; Fri, 23 Aug 2019 04:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566534108;
        bh=rTdch+UXnVR9x9MD7ij6x24H5d7wVKJndYUMPnV0Xp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mpH4dQkSxrzQiQ0P2rnpEDWqnAIiZXQm2AyZMqQM5Z1jeoKL35t7LPzqBRk623z2U
         XyY4ZcEuZEbdntl98NM4XqbIylkwnENIZecIQIYgsbGJ1CKVLAXQzCSlEZqCMjGEmW
         GO9P5rE5Qo5Gbsuzvqwskq1iI6NBF4uymqi2pU0s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E194760769;
        Fri, 23 Aug 2019 04:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566534107;
        bh=rTdch+UXnVR9x9MD7ij6x24H5d7wVKJndYUMPnV0Xp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YKFS16rGmMT6cz2tdST+51CtYcE3clxSZ37Cfd3VlwPQFqxopKM0iRtYEY6CAJuai
         HDHuzVYqcsbZgjcILpEK+HCrlvnBSQDvizZhO7pndZIV4ESv6e0Kz7wPB6U05fdBqD
         Qfvm2bbcYeDDbpVTi53+iZNtWTiyYn4XBrOVuxvo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 23 Aug 2019 09:51:47 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 46/49] ath11k: add wmi.h
In-Reply-To: <c60afe716cc9ce3b511d8be0b04958342dfea908.camel@sipsolutions.net>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-47-git-send-email-kvalo@codeaurora.org>
 (sfid-20190820_181541_270184_9285B240)
 <c60afe716cc9ce3b511d8be0b04958342dfea908.camel@sipsolutions.net>
Message-ID: <826dd60c50a2b821fe82c5c04730deb1@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-21 01:59, Johannes Berg wrote:
> On Tue, 2019-08-20 at 18:48 +0300, Kalle Valo wrote:
>> 
>> +enum wmi_cmd_group {
>> +	/* 0 to 2 are reserved */
>> +	WMI_GRP_START = 0x3,
>> +	WMI_GRP_SCAN = WMI_GRP_START, /* 0x3 */
>> +	WMI_GRP_PDEV,           /* 0x4 */
> 
> If you're going to spell out the numbers anyway, why not do it in C
> rather than a comment?
> 
> 	WMI_GRP_PDEV		= 0x4,
> 
> would tell you just as much, and be much less error-prone.

Sure, we'll do it that way.

> 
>> +struct wmi_pdev_set_hw_mode_cmd_param {
>> +	u32 tlv_header;
>> +	u32 pdev_id;
>> +	u32 hw_mode_index;
>> +	u32 num_band_to_mac;
>> +} __packed;
> 
> Does it really makes sense for something to be using "u32" (i.e. host
> endian) but then __packed (kinda tagging it as "I am using this with 
> the
> hardware, don't change the layout")?

Yes, this is mainly for tagging. Since Copy Engine does the 
byte-swapping when working with big-endian
system, these are declared in host endian. Removing __packed also fine, 
I guess.

> 
> That really applies to a lot of the things here.
> 
>> +struct channel_param {
>> +	u8 chan_id;
>> +	u8 pwr;
>> +	u32 mhz;
>> +	u32 half_rate:1,
>> +	    quarter_rate:1,
>> +	    dfs_set:1,
>> +	    dfs_set_cfreq2:1,
>> +	    is_chan_passive:1,
>> +	    allow_ht:1,
>> +	    allow_vht:1,
>> +	    set_agile:1;
>> +	u32 phy_mode;
>> +	u32 cfreq1;
>> +	u32 cfreq2;
>> +	char   maxpower;
>> +	char   minpower;
>> +	char   maxregpower;
>> +	u8  antennamax;
>> +	u8  reg_class_id;
>> +} __packed;
> 
> Bitfields in FW structs are even less likely to work right, I'd avoid
> that.
> 
> (and if you have this copy engine do endian conversion, then the u8
> fields won't work right since that ending seems to be working on u32s?)
> 
> That probably all applies elsewhere too, but the file is pretty long 
> ;-)

Sure, we'll clean this up.

> 
> Personally, I'd also consider splitting internal driver usage stuff and
> FW API into different files, but that's your decision. I just find it
> lets me understand it better even when I'm looking at it myself.
> 

Sure, this will look better.


Thanks,

Vasanth
