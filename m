Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D730743F4FB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhJ2CdX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 22:33:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37544 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhJ2CdW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 22:33:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635474655; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=wcrDjJzQSDlZlOocrUwmswx3ElWAGGaa4tJSF8O252E=;
 b=ObwCT6EUunJU6dFt11gUNeP1uJrje60NpcM3X3tZqMcnaLFyQoj5ZG0g7OcwJDv1eCi8nhlB
 cxv1PKqMgDWt2QoESo77CMJBG8xQYjQwEoNPoyyU43Qetf+RLlYiFnK4a0U2wtDsKP3Z6bbG
 W0OayiB6RybFTZxXrwaBZwGtKdk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 617b5ccb900d71ea1e75643b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Oct 2021 02:30:35
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6B1FC43460; Fri, 29 Oct 2021 02:30:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28E3FC4338F;
        Fri, 29 Oct 2021 02:30:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Oct 2021 10:30:34 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] ath11k: set correct NL80211_FEATURE_DYNAMIC_SMPS for
 WCN6855
In-Reply-To: <87a6it5upc.fsf@codeaurora.org>
References: <20210914163726.38604-1-jouni@codeaurora.org>
 <20210914163726.38604-3-jouni@codeaurora.org>
 <87a6it5upc.fsf@codeaurora.org>
Message-ID: <50c21cd4f727e61c7602a61fe37258df@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-28 18:07, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Wen Gong <wgong@codeaurora.org>
>> 
...
>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c 
>> b/drivers/net/wireless/ath/ath11k/mac.c
>> index 1f4765e43546..97a2c92b7b9b 100644
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -7570,7 +7570,8 @@ static int __ath11k_mac_register(struct ath11k 
>> *ar)
>>  	 * for each band for a dual band capable radio. It will be tricky to
>>  	 * handle it when the ht capability different for each band.
>>  	 */
>> -	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
>> +	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS ||
>> +	    (ar->supports_6ghz && !ab->hw_params.check_dynamic_smps))
>>  		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
> 
> Instead of a "negative" flag I reverted the test and renamed the flag 
> to
> supports_dynamic_smps_6ghz. AFAIK QCN9074 is the only device supporting
> 6 GHz band so I enabled the flag only for it.
> 
> Please review my changes in the pending branch:
Thanks.
the change is OK for WCN6855/QCA6390.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cc692cfb9f2981691b39b601b37e4544ecf01136
