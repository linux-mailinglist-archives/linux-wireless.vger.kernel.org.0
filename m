Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA845B603
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 08:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhKXH71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 02:59:27 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:41336 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhKXH71 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 02:59:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637740577; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5t9tIvY11Eq0fURiPaPrJCYPJKTVN17WJRu+6+PU/Aw=; b=jWHfLiQzi6BgiILsznHRj8jakphGDHbJsRW99T8DPu+GaUU+b0tOTTgD1mKDb6iPKm/cAvSk
 csFrFMCGGhwGI4EbzlYY1nizGkI7WVdF0eg4i/PZxQl7jYkp3WuVZcxteoL2naGl2SHkAjT2
 HoAmbBL1KxpzvnzAkrWYAwTCh1I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 619df02186d0e4d888642680 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 07:56:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB5A1C43616; Wed, 24 Nov 2021 07:56:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56540C4338F;
        Wed, 24 Nov 2021 07:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 56540C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     P Praneesh <ppranees@codeaurora.org>, <ath11k@lists.infradead.org>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        "Karthikeyan Periyasamy" <periyasa@codeaurora.org>
Subject: Re: [PATCH v3 2/3] ath11k: Refactor update channel list function
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
        <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
        <0fb4fec3-4fd0-6e92-b1d9-5bffc0958e97@quicinc.com>
        <87pmqq6lyx.fsf@codeaurora.org>
        <5929130a-7824-acd1-0182-da8fa304c576@quicinc.com>
Date:   Wed, 24 Nov 2021 09:56:08 +0200
In-Reply-To: <5929130a-7824-acd1-0182-da8fa304c576@quicinc.com> (Wen Gong's
        message of "Wed, 24 Nov 2021 15:48:03 +0800")
Message-ID: <87ee766l7r.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 11/24/2021 3:39 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
>>
>>> On 10/22/2021 8:37 PM, P Praneesh wrote:
>>>
>>> ...
>>>
>>>> ---
>>>> ...
>>>> -			ch->maxpower = channel->max_power * 2;
>>>> -			ch->maxregpower = channel->max_reg_power * 2;
>>>> -			ch->antennamax = channel->max_antenna_gain * 2;
>>>> ...
>>>>    +int ath11k_wmi_update_scan_chan_list(struct ath11k *ar,
>>>> +				     struct scan_req_params *arg)
>>>> ...
>>>> +			ch->maxpower = channel->max_power;
>>>> +			ch->maxregpower = channel->max_reg_power;
>>>> +			ch->antennamax = channel->max_antenna_gain;
>>>> +
>>>> ...
>>> I see it also have another patch to remove the "*2" for power.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=9212c1b9e80a869e732769a4fe7f82d392b219be
>>>
>>> ath11k: send proper txpower and maxregpower values to firmware.
>>>
>>> so are you the same reason to remove "*2" ?
>> I'm not quite getting what you are saying, can you elaborate more? Did
>> this patch break something?
>
> Oh. Not see break anything.
>
> I just want to know why remove the "*2". Did you see any issue if NOT
> remove "*2"?

All I know is that commit 9212c1b9e80a ("ath11k: send proper txpower and
maxregpower values to firmware") mentions about cca getting stuck:

ath11k: send proper txpower and maxregpower values to firmware

Set proper values for max_regpower, max_power, max_antenna_gain as it
is because firmware will convert power values to 0.5dbm steps by
multiplying it with 2.

If txpower is not set, it will lead to cca stuck resulting in latency
issues for QCN9074.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
