Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028374CB4C3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 03:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiCCCOK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 21:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiCCCOH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 21:14:07 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 2845C46640
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 18:13:23 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646273603; h=Message-ID: References: In-Reply-To: Subject:
 Subject: Cc: To: To: From: From: Date: Content-Transfer-Encoding:
 Content-Type: MIME-Version: Sender: Sender;
 bh=d0CRU1DHzcvr19xaz+D8Zc0p7ulYliZaXMQKJIq75Ts=; b=U8nabLXGITravzcnZPV/tdpINyJU0k8U6nDAHN+uEvsUVsY7p3XKYWs8qX+9uMovURBunDKP
 rzeESe2fjb4aenkawatSeh6MUWuocYqKTVHip1FaS+H0HvEvr8o6lY141FvCfai/jm7HkMXR
 RJI0BQnha+x8WD19HJW/UdwPwio=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 62202441ea5f8dddb561c2e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Mar 2022 02:13:21
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C7F3C43617; Thu,  3 Mar 2022 02:13:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9085C4338F;
        Thu,  3 Mar 2022 02:13:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Mar 2022 10:13:19 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>, johannes.berg@intel.com
Cc:     Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org, quic_adisi@quicinc.com,
        quic_vnaralas@quicinc.com
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <68b700b371399db0ed4174d20ddd0b8b@codeaurora.org>
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
Message-ID: <7761dc6f736b04cce1137b68a7132ac7@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

Do you have comments for this patch?

Currently these patches of mac80211/cfg80211/ieee80211 for LPI/SP/VLP is
the base patches, to enable the feature of LPI/SP/VLP, it still need 
other
patches of lower drivers such as ath11k to enable it. It will not have
LPI/SP/VLP without patches of ath11k, it means all these patches of
mac80211/cfg80211 will not take effect.

When lower driver such as ath11k set max_interfaces of 
ieee80211_iface_combination
to 1, then it can not start more than 1 interface on the same 
ieee80211_hw/wiphy.
When STATION interface is up, then AP interface can not start up. AP 
interface
can start up after STATION interface down. Also when AP interface is up,
STATION interface can not start up. STATION interface can start up after
AP interface down.

I have sent out my ath11k v2 
patches(https://patchwork.kernel.org/project/linux-wireless/list/?series=601212),
it will allow only one interface
up simultaneously for the chip which enable LPI/SP/VLP feature in this
patch: "ath11k: allow only one interface up simultaneously for WCN6855"
https://patchwork.kernel.org/project/linux-wireless/patch/20211224085236.9064-5-quic_wgong@quicinc.com/
It means it will not have both AP/STA together and these patches of 
mac80211/
cfg80211/ieee80211 not need changes and it will not have bugs.

If there are some chip want to both enable LPI/SP/VLP feature and
enable AP/STA simultaneously in same ieee80211_hw/wiphy in future,
then he/she need to refine reg rules and channels of mac80211/cfg80211/
ieee80211, but at that moment, this patch "cfg80211: save power
spectral density(psd) of regulatory rule" still not need change.
Because this patch is change in each reg rule/each channel in a
low layer, the refine reg rules and channels is a high layer, they
have no intersection.

On 2021-12-06 16:48, Wen Gong wrote:
> Hi Johannes,
> 
> Are you waiting for the AP/STA concurrency patches, then apply this 
> patch?
> 
> On 2021-11-09 17:57, Wen Gong wrote:
>> Hi Johannes,
>> 
>> do you have comments about my description for PSD?
>> 
>> On 2021-10-26 19:26, Wen Gong wrote:
>>> On 2021-10-26 04:09, Johannes Berg wrote:
>>>> On Mon, 2021-10-11 at 15:48 +0800, Wen Gong wrote:
>>>>> 
>>>>> > IMO, Only power rules and PSD info might vary for AP and STATION. Rest
>>>>> > of the rules will remains same right?
>>>>> >
>>>>> The freq_range may also be different for AP and STATION.
>>>>> and reg_rules number also may also be different for AP and STATION.
>>>>> 
>>>>> for example:
>>>>> SUBORDINATE CLIENT of STANDARD POWER reg rules number 2
>>>>> reg rule 1: (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 
>>>>> 17
>>>>> dB/MHz)
>>>>> reg rule 2: (6525 - 6885 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 
>>>>> 17
>>>>> dB/MHz)
>>>>> 
>>>>> INDOOR AP reg rules number 1
>>>>> reg rule 1: (5945 - 7125 @ 160) (0, 24) (FLAGS 0) (psd flag 0 EIRP 
>>>>> 0
>>>>> dB/MHz)
>>>> 
>>>> That seems right, but isn't that an orthogonal question?
>>>> 
>>>> Here, on this patch, we're discussing what data we should have in 
>>>> the
>>>> channel information, and it would seem that if it's different for
>>>> AP/client, then we do need both information stored, so that we can 
>>>> cope
>>>> with concurrency between AP and client?
>>>> 
>>>> If we additionally need to have different data for the regulatory 
>>>> rules
>>>> for AP and client, that might mean we need to go back and actually
>>>> change the code there *as well*, and then fill in the right fields 
>>>> in
>>>> this patch?
>>>> 
>>>> Unless somehow we're convinced that for this feature we don't need 
>>>> to
>>>> worry about concurrently using AP and client modes?
>>>> 
>>>> johannes
>>> 
>>> Currently these patches of mac80211/cfg80211/ieee80211 for LPI/SP/VLP 
>>> is
>>> the base patches, to enable the feature of LPI/SP/VLP, it still need 
>>> other
>>> patches of lower drivers such as ath11k to enable it. It will not 
>>> have
>>> LPI/SP/VLP without patches of ath11k, it means all these patches will
>>> not take effect.
>>> 
>>> When lower driver such as ath11k set max_interfaces of
>>> ieee80211_iface_combination
>>> to 1, then it can not start more than 1 interface on the same
>>> ieee80211_hw/wiphy.
>>> When STATION interface is up, then AP interface can not start up. AP 
>>> interface
>>> can start up after STATION interfacedown. Also when AP interface is 
>>> up,
>>> STATION interface can not start up. STATION interface can start up 
>>> after
>>> AP interface down.
>>> 
>>> I have sent out my ath11k
>>> patches(https://lore.kernel.org/linux-wireless/20211026111913.7346-1-quic_wgong@quicinc.com/),
>>> it will allow only one interface
>>> up simultaneously for the chip which enable LPI/SP/VLP feature in 
>>> this
>>> patch: "ath11k: allow only one interface up simultaneously for 
>>> WCN6855"
>>> https://lore.kernel.org/linux-wireless/20211026111913.7346-5-quic_wgong@quicinc.com/
>>> It means it will not have both AP/STA together and these patches of 
>>> mac80211/
>>> cfg80211/ieee80211 not need changes and it will not have bugs.
>>> 
>>> If there are some chip want to both enable LPI/SP/VLP feature and
>>> enable AP/STA simultaneously in same ieee80211_hw/wiphy in future,
>>> then he/she need to refine reg rules and channels of 
>>> mac80211/cfg80211/
>>> ieee80211, but at that moment, this patch "cfg80211: save power
>>> spectral density(psd) of regulatory rule" still not need change.
>>> Because this patch is change in each reg rule/each channel in a
>>> low layer, the refine reg rules and channels is a high layer, they
>>> have no intersection.
