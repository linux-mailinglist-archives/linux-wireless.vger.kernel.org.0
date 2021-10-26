Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7288143B138
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhJZL3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:29:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28451 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJZL3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:29:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635247613; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=30+RmjFnFI6ZtGnhWLWGPzC4W+B7uUdh7t8TfJ2XqVM=;
 b=YkGte5RqMJbTxKRnIMqr9iGMaau0o2EtHAMMiUp53tjPVXqZLFdQ3nS83xXKD00HScIcyiZ8
 wXefq/lW1evu4BnCaxtj83v89R3D3D6R/gCdLV5qcVVRSloT5kTUxBMt/QketanQQvNmoWu0
 /IRV7CwMe8x4rzUmhkSwzqS+/PM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6177e5f7fd91319f0ffb1058 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 11:26:47
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F73BC4360C; Tue, 26 Oct 2021 11:26:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 886A4C4338F;
        Tue, 26 Oct 2021 11:26:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Oct 2021 19:26:46 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
In-Reply-To: <18363bc18538ea9b7e8fe28f4c5595c54f3b93d3.camel@sipsolutions.net>
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
Message-ID: <67936afa5545b9a5d6eb5ad6931026d7@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-26 04:09, Johannes Berg wrote:
> On Mon, 2021-10-11 at 15:48 +0800, Wen Gong wrote:
>> 
>> > IMO, Only power rules and PSD info might vary for AP and STATION. Rest
>> > of the rules will remains same right?
>> >
>> The freq_range may also be different for AP and STATION.
>> and reg_rules number also may also be different for AP and STATION.
>> 
>> for example:
>> SUBORDINATE CLIENT of STANDARD POWER reg rules number 2
>> reg rule 1: (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 17
>> dB/MHz)
>> reg rule 2: (6525 - 6885 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 17
>> dB/MHz)
>> 
>> INDOOR AP reg rules number 1
>> reg rule 1: (5945 - 7125 @ 160) (0, 24) (FLAGS 0) (psd flag 0 EIRP 0
>> dB/MHz)
> 
> That seems right, but isn't that an orthogonal question?
> 
> Here, on this patch, we're discussing what data we should have in the
> channel information, and it would seem that if it's different for
> AP/client, then we do need both information stored, so that we can cope
> with concurrency between AP and client?
> 
> If we additionally need to have different data for the regulatory rules
> for AP and client, that might mean we need to go back and actually
> change the code there *as well*, and then fill in the right fields in
> this patch?
> 
> Unless somehow we're convinced that for this feature we don't need to
> worry about concurrently using AP and client modes?
> 
> johannes

Currently these patches of mac80211/cfg80211/ieee80211 for LPI/SP/VLP is
the base patches, to enable the feature of LPI/SP/VLP, it still need 
other
patches of lower drivers such as ath11k to enable it. It will not have
LPI/SP/VLP without patches of ath11k, it means all these patches will
not take effect.

When lower driver such as ath11k set max_interfaces of 
ieee80211_iface_combination
to 1, then it can not start more than 1 interface on the same 
ieee80211_hw/wiphy.
When STATION interface is up, then AP interface can not start up. AP 
interface
can start up after STATION interfacedown. Also when AP interface is up,
STATION interface can not start up. STATION interface can start up after
AP interface down.

I have sent out my ath11k 
patches(https://lore.kernel.org/linux-wireless/20211026111913.7346-1-quic_wgong@quicinc.com/),
it will allow only one interface
up simultaneously for the chip which enable LPI/SP/VLP feature in this
patch: "ath11k: allow only one interface up simultaneously for WCN6855"
https://lore.kernel.org/linux-wireless/20211026111913.7346-5-quic_wgong@quicinc.com/
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

