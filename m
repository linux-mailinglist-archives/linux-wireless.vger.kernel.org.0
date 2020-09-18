Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2479E26F68D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIRHQV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 03:16:21 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52826 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgIRHQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 03:16:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600413381; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PlzqfZxuUg77IOFwqrWhILFjc8wx2MNJm5ZRKHj8pFs=; b=oQzhzoXaoQqRAPOpXplY0YBBKcb//8+XwryKWF6oD11WEKVbgXxXfjFxV33/+gfqA762zNsL
 8seMtDB6PchuE7KsG6t4skt0TRZezVMQ3BohvPEuK03YiCbxRQBJWGf6uuVcRw5yNz9lIF6X
 4mNJUw8J+vQSwZRjeIPGXoPOtZI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f645eb16b1937bb6501d5fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 07:16:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F1A3C433FF; Fri, 18 Sep 2020 07:16:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DDA9C433CA;
        Fri, 18 Sep 2020 07:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DDA9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     vnaralas@codeaurora.org
Cc:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2] ath11k: add raw mode and software crypto support
References: <010101746c6a54fa-91406158-3f0a-4f10-8328-a7f560dd3feb-000000@us-west-2.amazonses.com>
        <871rj0h1oh.fsf@codeaurora.org>
        <51bbe58e337427f5238a757d8c2c6ee1@codeaurora.org>
Date:   Fri, 18 Sep 2020 10:15:56 +0300
In-Reply-To: <51bbe58e337427f5238a757d8c2c6ee1@codeaurora.org>
        (vnaralas@codeaurora.org's message of "Fri, 18 Sep 2020 11:04:01
        +0530")
Message-ID: <87k0wrd07n.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

vnaralas@codeaurora.org writes:

> On 2020-09-17 20:48, Kalle Valo wrote:
>> Venkateswara Naralasetty <vnaralas@codeaurora.org> writes:
>>
>>> Adding raw mode tx/rx support. Also, adding support
>>> for software crypto which depends on raw mode.
>>>
>>> To enable raw mode tx/rx:
>>> insmod ath11k.ko frame_mode=0
>>>
>>> To enable software crypto:
>>> insmod ath11k.ko crypto_mode=1
>>>
>>> These modes could be helpful in debugging crypto related issues.
>>>
>>> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
>>> Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
>>
>> [...]
>>
>>> --- a/drivers/net/wireless/ath/ath11k/wmi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
>>> @@ -3366,6 +3366,10 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
>>>  	config.rx_timeout_pri[2] = TARGET_RX_TIMEOUT_LO_PRI;
>>>  	config.rx_timeout_pri[3] = TARGET_RX_TIMEOUT_HI_PRI;
>>>  	config.rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
>>> +
>>> +	if (test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags))
>>> +		config.rx_decap_mode = TARGET_DECAP_MODE_RAW;
>>
>> Did you test this at all? Because to me it looks like in
>> ath11k_init_wmi_config_ipq8074() this is overwritten with:
>>
>> 	config->rx_decap_mode = TARGET_DECAP_MODE_NATIVE_WIFI;
>>
>> So I can't see how this would even work. I noticed this while I was
>> cleaning up ath11k_wmi_cmd_init(). I'll send a patch soon, please test
>> that and let me know if it works.
>
> My bad it seems my tree is bit older, sorry for the confusion.
> Also I noticed, .wmi_init_config of ipq8074_ops is registered with "
> ath11k_init_wmi_config_qca6390()" Is that correct?
> If that is correct,  then I don't see ath11k_init_wmi_config_ipq8074()
> is called from any other place.
> I will send one patch to fix this issue. Please correct me if I am
> wrong.

Good catch! Indeed ipq8074_ops should be using
ath11k_init_wmi_config_ipq8074, just like ipq6018_ops does. Please do
send a patch to fix that.


-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
