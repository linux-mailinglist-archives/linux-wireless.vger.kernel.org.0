Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B69428811
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbhJKHun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 03:50:43 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33211 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234484AbhJKHun (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 03:50:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633938523; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tMyXsMZLwa7jTjlGY2NMeuqHuparS00rv8dqbo4MwmQ=;
 b=mT06pbDCR+t7KRNT/kByDl8lqBreSGaKC1pXEH8oboNDl2Zso0y/NrYtkfYt21zCSpTHppLK
 jZGT7QloRbK4WAz4hkWFVP4ld2cavT9GqFv5DqN+RKA6IzVGmrRnA0Z+2ObOd4GRsey74TVQ
 IIOC/iZeH9D557bxyG/PiL4DlXU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6163ec4c8ea00a941ffddee5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 07:48:28
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67E05C43460; Mon, 11 Oct 2021 07:48:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30FB1C43460;
        Mon, 11 Oct 2021 07:48:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Oct 2021 15:48:27 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <DM8PR02MB8154258563A4F7C805C84B4BE6B59@DM8PR02MB8154.namprd02.prod.outlook.com>
References: <20210928085211.26186-1-wgong@codeaurora.org>
 <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
 <cb20427eae96c4551084e4c899618b94@codeaurora.org>
 <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
 <2ed76cff292dcca18326de0407a93821@codeaurora.org>
 <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
 <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
 <DM8PR02MB8154258563A4F7C805C84B4BE6B59@DM8PR02MB8154.namprd02.prod.outlook.com>
Message-ID: <0b05f6e555bcb89c49f56279c077ce63@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-11 14:43, Venkateswara Naralasetty wrote:
>> -----Original Message-----
>> From: ath11k <ath11k-bounces@lists.infradead.org> On Behalf Of Wen 
>> Gong
>> Sent: Monday, October 11, 2021 9:36 AM
>> To: Johannes Berg <johannes@sipsolutions.net>
>> Cc: Venkateswara Naralasetty <vnaralas@codeaurora.org>;
>> ath11k@lists.infradead.org; linux-wireless@vger.kernel.org;
>> wgong=codeaurora.org@codeaurora.org
>> Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
>> regulatory rule
>> 
>> WARNING: This email originated from outside of Qualcomm. Please be 
>> wary
>> of any links or attachments, and do not enable macros.
>> 
>> On 2021-09-30 20:50, Johannes Berg wrote:
>> > On Thu, 2021-09-30 at 10:53 +0800, Wen Gong wrote:
>> >> > >
>> >> > >          chan->max_reg_power =
>> >> > >                  min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
>> >> > >                        MBM_TO_DBM(power_rule2->max_eirp));
>> >> > >
>> >> > > For AP + STA concurrency, it should to maintain 2 group of reg
>> >> > > rules, one is for AP, another is for STA.
>> >> >
>> >> > Can we maintain two power rules in the same channel one for AP and
>> >> > one for STA. In this way, we can update the power rules in the same
>> >> > channel for both AP and STA from the reg rules.
>> >> >
>> >> > Otherwise, we need to maintain multiple channel lists in sband for
>> >> > all supported power mode combinations to apply the respective power
>> >> > rules and build channel flags from the multiple reg rules.
>> >> > right?
>> >>
>> >> If AP+STA is up in the same wiphy/ieee80211_hw, and AP's reg rules is
>> >> different with STA, then it should maintain muti channel list for
>> >> each band of the wiphy/ieee80211_hw by my understand.
>> >
>> > I don't think that's how it works. You can today have AP/STA
>> > concurrency on a single wiphy with different netdevs, even with mesh
>> > or whatever.
>> >
>> >> Currently there is only one "struct ieee80211_supported_band
>> >> *bands[NUM_NL80211_BANDS]"
>> >> in "struct wiphy".
>> >>
>> >> I advise to discuss the AP + STA concurrency in another mail thread
>> >> since it is not relative with this patch.
>> >
>> > I actually explicitly pointed to this thread, but I'm not sure it's so
>> > clear cut?
>> >
>> > If we have completely separate rules here for AP and STA, we probably
>> > should have different "max_reg_power" values for AP and STA? Maybe
>> > mesh is treated like AP, maybe not?
>> >
>> > But I don't know - does PSD really differ between AP and STA?
>> >
>> > Maybe this discussion belongs rather to the power type patch? But that
>> > didn't add any state!
>> >
>> >
>> > So - does this PSD depend on mode? It kind of seems like it shouldn't
>> > and then this *isn't* the right place to be discussing this, but if
>> > PSD does in fact depend on the mode then we should be discussing it
>> here?
>> >
>> > Venkatesh seemed to be worried more about LPI/client power etc. as in
>> > commit 405fca8a9461 ("ieee80211: add power type definition for 6
>> > GHz"), but that doesn't add state?
>> >
>> > So what gives? From a regulatory POV it seems PSD should be
>> > independent, but some other things might be dependent on mode?
>> >
>> 
>> As I know, below values maybe all different for the AP and
>> STATION in the same wiphy/ieee80211_hw, not only PSD.
>> 
>> struct ieee80211_reg_rule {
>>         struct ieee80211_freq_range freq_range;
>>         struct ieee80211_power_rule power_rule;
>>         struct ieee80211_wmm_rule wmm_rule;
>>         u32 flags;
>>         u32 dfs_cac_ms;
>>         bool has_wmm;
>>         s8 psd;
>> };
> IMO, Only power rules and PSD info might vary for AP and STATION. Rest
> of the rules will remains same right?
> 
The freq_range may also be different for AP and STATION.
and reg_rules number also may also be different for AP and STATION.

for example:
SUBORDINATE CLIENT of STANDARD POWER reg rules number 2
reg rule 1: (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 17 
dB/MHz)
reg rule 2: (6525 - 6885 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 17 
dB/MHz)

INDOOR AP reg rules number 1
reg rule 1: (5945 - 7125 @ 160) (0, 24) (FLAGS 0) (psd flag 0 EIRP 0 
dB/MHz)

>> 
>> @Venkateswara, please feel free to give more info to Johannes:)
>> 
>> > johannes
>> 
>> --
>> ath11k mailing list
>> ath11k@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/ath11k
