Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51AA40DDBF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhIPPRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 11:17:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53658 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhIPPRS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 11:17:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631805358; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DJLzVfi8VhO4JuesZSVhb2rfe1QgDSqTxydNPHq/dXk=; b=QoniYb9KhueAeXKRbUi/7WqrHv8yp4c7mE3YNxrg7tiFZanZ6KZWFsT+Ar2GzQy0yh0hHatn
 Oic07Bbuj5Gu0cj66xVklDE2DokT8KLkCO5nyOoN3VRxwlvvUzq4kqNDXl8LHxeOX3nO5ocN
 78obpaz4yo1cr526627UFtphTnM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61435fa8507800c880193488 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 15:15:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F952C43617; Thu, 16 Sep 2021 15:15:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D209FC4338F;
        Thu, 16 Sep 2021 15:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D209FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] ath11k: set correct NL80211_FEATURE_DYNAMIC_SMPS for WCN6855
References: <20210914163726.38604-1-jouni@codeaurora.org>
        <20210914163726.38604-3-jouni@codeaurora.org>
        <875yv0zvcn.fsf@codeaurora.org>
        <6ec81d2b9ec3a2665570baf90e624bf5@codeaurora.org>
Date:   Thu, 16 Sep 2021 18:15:46 +0300
In-Reply-To: <6ec81d2b9ec3a2665570baf90e624bf5@codeaurora.org> (Wen Gong's
        message of "Thu, 16 Sep 2021 22:09:00 +0800")
Message-ID: <87sfy4y2jh.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2021-09-16 18:08, Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> writes:
>>
>>> From: Wen Gong <wgong@codeaurora.org>
>>>
>>> Commit "ath11k: support SMPS configuration for 6 GHz" changed "if
>>> (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)" to "if (ht_cap &
>>> WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)" which means
>>> NL80211_FEATURE_DYNAMIC_SMPS is enabled for all chips which support 6
>>> GHz. However, WCN6855 supports 6 GHz but it does not support feature
>>> NL80211_FEATURE_DYNAMIC_SMPS, and this can lead to MU-MIMO test
>>> failures
>>> for WCN6855.
>>>
>>> Disable NL80211_FEATURE_DYNAMIC_SMPS for WCN6855 since its ht_cap does
>>> not support WMI_HT_CAP_DYNAMIC_SMPS.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI
>>> WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>>
>>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>>
>> [...]
>>
>>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>>> @@ -7570,7 +7570,8 @@ static int __ath11k_mac_register(struct
>>> ath11k *ar)
>>>  	 * for each band for a dual band capable radio. It will be tricky to
>>>  	 * handle it when the ht capability different for each band.
>>>  	 */
>>> -	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
>>> +	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS ||
>>> +	    (ar->supports_6ghz && !ab->hw_params.check_dynamic_smps))
>>>  		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
>>>
>>>  	ar->hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
>>
>> This hunk failed, in the pending branch as I don't have that
>> ar->supports_6ghz check. I'll drop this patch 3 for now, let's revisit
>> after my queue of ath11k patches is smaller.
>
> ar->supports_6ghz is introduced by this patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20210913175510.193005-3-jouni@codeaurora.org/

Ah, and that was in Awaiting Upstream state and not yet in my pending
branch. I'll take that patchset first to pending branch and then apply
this patch 3, so no need to resend anything (at least for the moment).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
