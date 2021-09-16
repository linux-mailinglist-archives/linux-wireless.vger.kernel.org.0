Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE240DC71
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbhIPOKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 10:10:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39286 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236328AbhIPOKs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 10:10:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631801367; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kfWwSfeJ4uB1YBXQt2Si8k+yxFnF4PGMz82PeiLD3rU=;
 b=MrTWY5xnQM7BbokCcZckdrY+M3+7+RGEOhF9tnXft7kB1XJSKU37BSJdiYHZ18S7UBYRuSRX
 JmxpWBF6R7v187NhssrYxa7HXOyyAiFvbzU/7FFUEDhk1aods+P1WStaLu8PBL2TOPCQfxMW
 IZEo4KfvHELGVtv4saZVJmNi24A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61434ffdc1b30e2f02c30082 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 14:09:01
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DDA84C4360C; Thu, 16 Sep 2021 14:09:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AC92C4338F;
        Thu, 16 Sep 2021 14:09:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Sep 2021 22:09:00 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] ath11k: set correct NL80211_FEATURE_DYNAMIC_SMPS for
 WCN6855
In-Reply-To: <875yv0zvcn.fsf@codeaurora.org>
References: <20210914163726.38604-1-jouni@codeaurora.org>
 <20210914163726.38604-3-jouni@codeaurora.org>
 <875yv0zvcn.fsf@codeaurora.org>
Message-ID: <6ec81d2b9ec3a2665570baf90e624bf5@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-16 18:08, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Wen Gong <wgong@codeaurora.org>
>> 
>> Commit "ath11k: support SMPS configuration for 6 GHz" changed "if
>> (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)" to "if (ht_cap &
>> WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)" which means
>> NL80211_FEATURE_DYNAMIC_SMPS is enabled for all chips which support 6
>> GHz. However, WCN6855 supports 6 GHz but it does not support feature
>> NL80211_FEATURE_DYNAMIC_SMPS, and this can lead to MU-MIMO test 
>> failures
>> for WCN6855.
>> 
>> Disable NL80211_FEATURE_DYNAMIC_SMPS for WCN6855 since its ht_cap does
>> not support WMI_HT_CAP_DYNAMIC_SMPS.
>> 
>> Tested-on: WCN6855 hw2.0 PCI 
>> WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> 
> [...]
> 
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
>> 
>>  	ar->hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
> 
> This hunk failed, in the pending branch as I don't have that
> ar->supports_6ghz check. I'll drop this patch 3 for now, let's revisit
> after my queue of ath11k patches is smaller.
Hi Kalle,

ar->supports_6ghz is introduced by this patch:
https://patchwork.kernel.org/project/linux-wireless/patch/20210913175510.193005-3-jouni@codeaurora.org/

@@ -7559,7 +7570,7 @@  static int __ath11k_mac_register(struct ath11k 
*ar)
  	 * for each band for a dual band capable radio. It will be tricky to
  	 * handle it when the ht capability different for each band.
  	 */
-	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
+	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
  		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;

  	ar->hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
