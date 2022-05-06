Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501B751D5FA
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiEFKyr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiEFKyq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 06:54:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584C5C362
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651834262; x=1683370262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WgSyiBQAbsQ2PCfxPxuXcE0WM29hgT4nb8uxXCGY6Yg=;
  b=KgL++PIbswUNLJ284zb18VXdFX12EvkbTk3pZrXjCoXwrZ3dZZLHI4Kg
   qaMtV8gNVSd4cVbtoD/+qFKFLMrKKs1QghAjodGW0HFPRbP4kvWncSyNK
   613NY7OhFgmqNKv8XNegLIdz6rdPeicZVAun/b8FB+64GwAIVwjegdDaj
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 May 2022 03:51:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 03:51:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 03:51:01 -0700
Received: from [10.253.37.208] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 03:50:59 -0700
Message-ID: <f73a7861-fc1d-0cdf-6506-41fb58d8b76b@quicinc.com>
Date:   Fri, 6 May 2022 18:50:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wen Gong <wgong@codeaurora.org>
CC:     Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>,
        "Venkateswara Naralasetty" <vnaralas@codeaurora.org>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <wgong=codeaurora.org@codeaurora.org>, <quic_adisi@quicinc.com>,
        <quic_vnaralas@quicinc.com>
References: <20210928085211.26186-1-wgong@codeaurora.org>
 <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
 <cb20427eae96c4551084e4c899618b94@codeaurora.org>
 <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
 <2ed76cff292dcca18326de0407a93821@codeaurora.org>
 <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
 <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
 <DM8PR02MB8154258563A4F7C805C84B4BE6B59@DM8PR02MB8154.namprd02.prod.outlook.com>
 <0b05f6e555bcb89c49f56279c077ce63@codeaurora.org>
 <18363bc18538ea9b7e8fe28f4c5595c54f3b93d3.camel@sipsolutions.net>
 <67936afa5545b9a5d6eb5ad6931026d7@codeaurora.org>
 <6053b0963612057267f00b89e14b9e15@codeaurora.org>
 <68b700b371399db0ed4174d20ddd0b8b@codeaurora.org>
 <7761dc6f736b04cce1137b68a7132ac7@codeaurora.org>
 <aee8fc50-3ffb-f985-f0ad-9752bb51890d@quicinc.com>
 <a0a40e7f40dd173cc4a3688bd77c90cc8c479ab7.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <a0a40e7f40dd173cc4a3688bd77c90cc8c479ab7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/2022 8:00 PM, Johannes Berg wrote:
> Hi,
>
> Sorry. I've been shying away from this, it's completely confusing me,
> and the code isn't really helping that much, so far.
>
>> PSD is another type power value as well as the power_rule in
>> ieee80211_reg_rule
>> and max_reg_power/max_power in ieee80211_channel. For 6G, it need the
>> both the 2 values (psd and tx-power) for power control.
> Sure, that makes sense. You have PSD limits as well as TX power limits.
>
>> To support LPI/SP/VLP mode + concurrency, it is not only to process the
>> TX power and psd, it need to process all fields in ieee80211_reg_rule.
>> for example, for the same country US, it has some ieee80211_reg_rule for
>> 6G:
>> LPI mode for AP mode is:
>> (5945 - 7125 @ 160) (0, 30) (FLAGS 512) (psd 5 dB/MHz)
>>
>> LPI mode for client mode is:
>> (5945 - 7125 @ 160) (0, 24) (FLAGS 512) (psd -1 dB/MHz)
>>
>> SP mode is:
>> (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd 17 dB/MHz)
>> (6525 - 6875 @ 160) (0, 30) (FLAGS 0) (psd 17 dB/MHz)
>>
>> you can see the frequency range/flags/tx power/psd are not same between
>> the 3 mode.
> Right. But here I already don't understand - does that mean your
> hardware can only be in one mode today overall?
>
> It seems you'd need to have separate regulatory rules per mode, and
> possibly per interface type, no?
>
> Or do you try to adjust the regulatory rules when the mode is switched?
> But we try to have regulatory rules capture the overall status, not a
> temporary status, and then apply the rules that make sense at any given
> time.
Yes, we adjust the regulatory rules when the mode is switched.
>
>> So the psd value is a same kind field as well as the frequency
>> range/flags/tx power in ieee80211_reg_rule and ieee80211_channel.
>> If it has only one interface in the same ieee80211_hw, the interface
>> must choose one the the above modes at any time, and the reg rules
>> will be updated when the interface changed its mode, then the info
>> of channels of ieee80211_supported_band for 6G also update, it has
>> no problem.
> Ah OK, so you answer that question - you're actually changing the
> regulatory rules, which is totally unexpected to me, since I'd expect
> those to only change when the regulatory changes, not when you mode
> switch ...
So I think you want to show all regulatory rules for all 
LPI/VLP/SP+AP/STA as below,
and it does not changed again untill regulatory/country code change, such
as "US" to "CN"/"KR", right?

for example self-managed of ath11k, it list all regulatory rules,
it has many regulatory rules for (5945 - 7125):

iw reg get
global
country US: DFS-FCC
         (2400 - 2472 @ 40), (N/A, 30), (N/A)
         (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
         (5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
         (5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
         (5730 - 5850 @ 80), (N/A, 30), (N/A)
         (57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country US: DFS-FCC
         (2402 - 2472 @ 40), (6, 30), (N/A)
         (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
         (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
         (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
         (5735 - 5895 @ 160), (N/A, 30), (N/A), AUTO-BW
         (5945 - 7125 @ 160), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW
         (5945 - 7125 @ 160), (N/A, 21), (N/A), NO-OUTDOOR, AUTO-BW
         (5945 - 6425 @ 160), (N/A, 27), (N/A), AUTO-BW
         (6525 - 6865 @ 160), (N/A, 27), (N/A), AUTO-BW
         (5945 - 7125 @ 160), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW
         (5945 - 6425 @ 160), (N/A, 27), (N/A), AUTO-BW
         (6525 - 6865 @ 160), (N/A, 27), (N/A), AUTO-BW

And currently my patch only show the regulatory rules of the power mode
it used now, and regulatory rules will changed when the power mode which
used change.

for example self-managed of ath11k:

global
country US: DFS-FCC
         (2400 - 2472 @ 40), (N/A, 30), (N/A)
         (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
         (5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
         (5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
         (5730 - 5850 @ 80), (N/A, 30), (N/A)
         (57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country US: DFS-FCC
         (2402 - 2472 @ 40), (N/A, 20), (N/A)
         (2457 - 2472 @ 15), (N/A, 20), (N/A), PASSIVE-SCAN
         (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
         (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
         (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
         (5735 - 5835 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
         (2402 - 2472 @ 40), (N/A, 20), (N/A), AUTO-BW

>> When it has 2 interface up simultaneously in the same ieee80211_hw,
>> then it will have problem. because the 2 interface share the same
>> ieee80211_reg_rule and the same channels and same ieee80211_supported_band
>> for 6G, if interface #1 is LPI-AP, and interface #2 is SP mode, then
>> even the channels count is not same for the 2 interface, channels count
>> of SP mode is smaller than LPI-AP, also the info of channel is not same.
>>
>> So adding/not adding psd value into ieee80211_reg_rule/ieee80211_channel
>> will not effect the problem of muti-interface concurrency issue of 6G.
> Oh but I disagree - adding it will mean that this is how we interpret
> the reg_rule, that it only carries the current status according to "the"
> current mode (which isn't even well-defined), rather than the entirety
> of the regulatory information.
>
>> When muti-interface concurrency run, all the fields of ieee80211_reg_rule/
>> ieee80211_channel should be split.
> Right.
>
>> I think the easy way is to save the channels of ieee80211_supported_band
>> of 6G in each interface instead of ieee80211_hw, then interface #1/#2
>> have/use their own channels, they use their own frequency range/flags/
>> tx power/psd...
>>
> I'm not sure that will work, because we often compare chan pointers with
> ==, and if you're doing something like remain-on-channel that's still
> relevant. So having the same channel struct on the same hardware with
> the same frequency is bound to be problematic.
>
>> This is a high level change, and adding psd into
>> ieee80211_reg_rule/ieee80211_channel is a low level change. So I think
>> they have no dependency with each other.
> I think I disagree, per the above disagreement.
>
> johannes
