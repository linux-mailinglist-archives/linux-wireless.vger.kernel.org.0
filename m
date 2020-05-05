Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE01C5010
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgEEIRb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEEIRb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 04:17:31 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C929AC061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 01:17:29 -0700 (PDT)
Received: from [2a04:4540:1402:8a00:2d8:61ff:feed:60f5]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jVslb-0006Zo-8r; Tue, 05 May 2020 10:17:27 +0200
Subject: Re: [PATCH V2] ath11k: add tx hw 802.11 encapusaltion offloading
 support
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Shashidhar Lakkavalli <slakkavalli@datto.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20200430152814.18481-1-john@phrozen.org>
 <87ftcedcwi.fsf@kamboji.qca.qualcomm.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <7b8be57c-2bed-32dc-53d4-82ff1bc3b70b@phrozen.org>
Date:   Tue, 5 May 2020 10:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ftcedcwi.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.05.20 10:06, Kalle Valo wrote:
> John Crispin <john@phrozen.org> writes:
> 
>> This patch adds support for ethernet rxtx mode to the driver. The feature
>> is enabled via a new module parameter. If enabled to driver will enable
>> the feature on a per vif basis if all other requirements were met.
>>
>> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
>> Signed-off-by: John Crispin <john@phrozen.org>
> 
> [...]
> 
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -33,6 +33,11 @@
>>   	.max_power              = 30, \
>>   }
>>   
>> +/* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
>> +static unsigned int ath11k_ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
>> +module_param_named(ath11k_frame_mode, ath11k_ath11k_frame_mode, uint, 0644);
>> +MODULE_PARM_DESC(ath11k_frame_mode, "Datapath frame mode");
> 
> I don't think we should add ath11k_ prefix to module names, right? So I
> changed that and documented the values:
> 
> /* frame mode values are mapped as per enum ath11k_hw_txrx_mode */
> static unsigned int ath11k_frame_mode = ATH11K_HW_TXRX_NATIVE_WIFI;
> module_param_named(frame_mode, ath11k_frame_mode, uint, 0644);
> MODULE_PARM_DESC(frame_mode,
> 		 "Datapath frame mode (0: raw, 1: native wifi (default), 2: ethernet)");
> 
> Also I added a comment to enum ath11k_hw_txrx_mode so that we don't
> accidentally change the values. This is now in pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=f0717ed39d06a9f2fd32edbdf88f29939dc25516
> 
> Please check my changes.
> 

Thanks, looks good.
	John
