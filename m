Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C6502075
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Apr 2022 04:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiDOC3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDOC3o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 22:29:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E465E86E07
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 19:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649989637; x=1681525637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hjvUzvOPfS1ipmCCVvTPVZiBypu2XFWitmfc5NLLkSY=;
  b=XGH1V5o8DrI0mgAkPy11mbRzrrYhlb+OzG94i9mecpGX7nSGawkzqcfg
   MXuEh5S9dNy0Kcx9ej1XtaQiWp12e0dnihTNp1RLdQQGAMu2gRNLA9bbG
   Ym/NTRJr+lGKKzdEUWzmms7znCUvydvKNsF31wKTOXFPYmptudTgjvQa9
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2022 19:27:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:27:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 19:27:16 -0700
Received: from [10.253.8.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 19:27:13 -0700
Message-ID: <aee8fc50-3ffb-f985-f0ad-9752bb51890d@quicinc.com>
Date:   Fri, 15 Apr 2022 10:27:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
Content-Language: en-US
To:     Wen Gong <wgong@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        <johannes.berg@intel.com>
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
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <7761dc6f736b04cce1137b68a7132ac7@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

PSD is another type power value as well as the power_rule in 
ieee80211_reg_rule
and max_reg_power/max_power in ieee80211_channel. For 6G, it need the
both the 2 values (psd and tx-power) for power control.

To support LPI/SP/VLP mode + concurrency, it is not only to process the
TX power and psd, it need to process all fields in ieee80211_reg_rule.
for example, for the same country US, it has some ieee80211_reg_rule for
6G:
LPI mode for AP mode is:
(5945 - 7125 @ 160) (0, 30) (FLAGS 512) (psd 5 dB/MHz)

LPI mode for client mode is:
(5945 - 7125 @ 160) (0, 24) (FLAGS 512) (psd -1 dB/MHz)

SP mode is:
(5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd 17 dB/MHz)
(6525 - 6875 @ 160) (0, 30) (FLAGS 0) (psd 17 dB/MHz)

you can see the frequency range/flags/tx power/psd are not same between
the 3 mode. So the psd value is a same kind field as well as the frequency
range/flags/tx power in ieee80211_reg_rule and ieee80211_channel.
If it has only one interface in the same ieee80211_hw, the interface
must choose one the the above modes at any time, and the reg rules
will be updated when the interface changed its mode, then the info
of channels of ieee80211_supported_band for 6G also update, it has
no problem.

When it has 2 interface up simultaneously in the same ieee80211_hw,
then it will have problem. because the 2 interface share the same
ieee80211_reg_rule and the same channels and same ieee80211_supported_band
for 6G, if interface #1 is LPI-AP, and interface #2 is SP mode, then
even the channels count is not same for the 2 interface, channels count
of SP mode is smaller than LPI-AP, also the info of channel is not same.

So adding/not adding psd value into ieee80211_reg_rule/ieee80211_channel
will not effect the problem of muti-interface concurrency issue of 6G.
When muti-interface concurrency run, all the fields of ieee80211_reg_rule/
ieee80211_channel should be split.

I think the easy way is to save the channels of ieee80211_supported_band
of 6G in each interface instead of ieee80211_hw, then interface #1/#2
have/use their own channels, they use their own frequency range/flags/
tx power/psd... This is a high level change, and adding psd into
ieee80211_reg_rule/ieee80211_channel is a low level change. So I think
they have no dependency with each other.

On 3/3/2022 10:13 AM, Wen Gong wrote:
> Hi Johannes,
>
> Do you have comments for this patch?
>
> Currently these patches of mac80211/cfg80211/ieee80211 for LPI/SP/VLP is
> the base patches, to enable the feature of LPI/SP/VLP, it still need 
> other
> patches of lower drivers such as ath11k to enable it. It will not have
> LPI/SP/VLP without patches of ath11k, it means all these patches of
> mac80211/cfg80211 will not take effect.
>
> When lower driver such as ath11k set max_interfaces of 
> ieee80211_iface_combination
> to 1, then it can not start more than 1 interface on the same 
> ieee80211_hw/wiphy.
> When STATION interface is up, then AP interface can not start up. AP 
> interface
> can start up after STATION interface down. Also when AP interface is up,
> STATION interface can not start up. STATION interface can start up after
> AP interface down.
>
> I have sent out my ath11k v2 
> patches(https://patchwork.kernel.org/project/linux-wireless/list/?series=601212),
> it will allow only one interface
> up simultaneously for the chip which enable LPI/SP/VLP feature in this
> patch: "ath11k: allow only one interface up simultaneously for WCN6855"
> https://patchwork.kernel.org/project/linux-wireless/patch/20211224085236.9064-5-quic_wgong@quicinc.com/ 
>
> It means it will not have both AP/STA together and these patches of 
> mac80211/
> cfg80211/ieee80211 not need changes and it will not have bugs.
>
> If there are some chip want to both enable LPI/SP/VLP feature and
> enable AP/STA simultaneously in same ieee80211_hw/wiphy in future,
> then he/she need to refine reg rules and channels of mac80211/cfg80211/
> ieee80211, but at that moment, this patch "cfg80211: save power
> spectral density(psd) of regulatory rule" still not need change.
> Because this patch is change in each reg rule/each channel in a
> low layer, the refine reg rules and channels is a high layer, they
> have no intersection.
>
> On 2021-12-06 16:48, Wen Gong wrote:
>> Hi Johannes,
>>
>> Are you waiting for the AP/STA concurrency patches, then apply this 
>> patch?
>>
>> On 2021-11-09 17:57, Wen Gong wrote:
>>> Hi Johannes,
>>>
>>> do you have comments about my description for PSD?
>>>
>>> On 2021-10-26 19:26, Wen Gong wrote:
>>>> On 2021-10-26 04:09, Johannes Berg wrote:
>>>>> On Mon, 2021-10-11 at 15:48 +0800, Wen Gong wrote:
>>>>>>
>>>>>> > IMO, Only power rules and PSD info might vary for AP and 
>>>>>> STATION. Rest
>>>>>> > of the rules will remains same right?
>>>>>> >
>>>>>> The freq_range may also be different for AP and STATION.
>>>>>> and reg_rules number also may also be different for AP and STATION.
>>>>>>
>>>>>> for example:
>>>>>> SUBORDINATE CLIENT of STANDARD POWER reg rules number 2
>>>>>> reg rule 1: (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd flag 1 
>>>>>> EIRP 17
>>>>>> dB/MHz)
>>>>>> reg rule 2: (6525 - 6885 @ 160) (0, 30) (FLAGS 0) (psd flag 1 
>>>>>> EIRP 17
>>>>>> dB/MHz)
>>>>>>
>>>>>> INDOOR AP reg rules number 1
>>>>>> reg rule 1: (5945 - 7125 @ 160) (0, 24) (FLAGS 0) (psd flag 0 EIRP 0
>>>>>> dB/MHz)
>>>>>
>>>>> That seems right, but isn't that an orthogonal question?
>>>>>
>>>>> Here, on this patch, we're discussing what data we should have in the
>>>>> channel information, and it would seem that if it's different for
>>>>> AP/client, then we do need both information stored, so that we can 
>>>>> cope
>>>>> with concurrency between AP and client?
>>>>>
>>>>> If we additionally need to have different data for the regulatory 
>>>>> rules
>>>>> for AP and client, that might mean we need to go back and actually
>>>>> change the code there *as well*, and then fill in the right fields in
>>>>> this patch?
>>>>>
>>>>> Unless somehow we're convinced that for this feature we don't need to
>>>>> worry about concurrently using AP and client modes?
>>>>>
>>>>> johannes
>>>>
>>>> Currently these patches of mac80211/cfg80211/ieee80211 for 
>>>> LPI/SP/VLP is
>>>> the base patches, to enable the feature of LPI/SP/VLP, it still 
>>>> need other
>>>> patches of lower drivers such as ath11k to enable it. It will not have
>>>> LPI/SP/VLP without patches of ath11k, it means all these patches will
>>>> not take effect.
>>>>
>>>> When lower driver such as ath11k set max_interfaces of
>>>> ieee80211_iface_combination
>>>> to 1, then it can not start more than 1 interface on the same
>>>> ieee80211_hw/wiphy.
>>>> When STATION interface is up, then AP interface can not start up. 
>>>> AP interface
>>>> can start up after STATION interfacedown. Also when AP interface is 
>>>> up,
>>>> STATION interface can not start up. STATION interface can start up 
>>>> after
>>>> AP interface down.
>>>>
>>>> I have sent out my ath11k
>>>> patches(https://lore.kernel.org/linux-wireless/20211026111913.7346-1-quic_wgong@quicinc.com/), 
>>>>
>>>> it will allow only one interface
>>>> up simultaneously for the chip which enable LPI/SP/VLP feature in this
>>>> patch: "ath11k: allow only one interface up simultaneously for 
>>>> WCN6855"
>>>> https://lore.kernel.org/linux-wireless/20211026111913.7346-5-quic_wgong@quicinc.com/ 
>>>>
>>>> It means it will not have both AP/STA together and these patches of 
>>>> mac80211/
>>>> cfg80211/ieee80211 not need changes and it will not have bugs.
>>>>
>>>> If there are some chip want to both enable LPI/SP/VLP feature and
>>>> enable AP/STA simultaneously in same ieee80211_hw/wiphy in future,
>>>> then he/she need to refine reg rules and channels of 
>>>> mac80211/cfg80211/
>>>> ieee80211, but at that moment, this patch "cfg80211: save power
>>>> spectral density(psd) of regulatory rule" still not need change.
>>>> Because this patch is change in each reg rule/each channel in a
>>>> low layer, the refine reg rules and channels is a high layer, they
>>>> have no intersection.
>
