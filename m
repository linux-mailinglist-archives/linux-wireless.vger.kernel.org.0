Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27A46F8405
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjEEN2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEEN2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 09:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526A6E72
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 06:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA30763E28
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 13:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A1AC433D2;
        Fri,  5 May 2023 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683293330;
        bh=/AfTIT7D3Pn1g5kTlzGw7Ho8tiDr7FeLjRkseBoo/3o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=blC5zkzYK5NGSaACLhOHGdLEwX6UA511BANCyxDWfi4RmF4+WDWmZqrdW6JlShjgX
         F5R2c6eO+oqqtcpXNq7TQ6/BnyIzR8N1w3PjdTvCUtGQq31fAUMsB7XtdkWMqo4+Ws
         4D1beRCCrxs2C+o2bxrzdMJF+94kZ3fJcApS6ug/vZpJPhv12rxbtyLq7u6VU+C44b
         c5+IzTs1RVkUPYnnQmpNUide/70B6eiYqGFBCeNHv1AOcPpeqyCbwBOfRU9izG3DpF
         t0R1OKqB1B7tWuK1qexxdQzsgEoXUExir2PPaHpQ6ivUVuVViacQPfo04/pa91X5wx
         p31niXaet+7KA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] wifi: ath11k: MBSSID parameter configuration in AP mode
References: <20230405221648.17950-1-quic_alokad@quicinc.com>
        <20230405221648.17950-5-quic_alokad@quicinc.com>
        <87leibqme3.fsf@kernel.org>
        <b9f98415-46f5-7b9e-ba61-9b11a4498a6c@quicinc.com>
Date:   Fri, 05 May 2023 16:28:47 +0300
In-Reply-To: <b9f98415-46f5-7b9e-ba61-9b11a4498a6c@quicinc.com> (Aloka Dixit's
        message of "Mon, 1 May 2023 10:41:01 -0700")
Message-ID: <87y1m2oqk0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> On 4/28/2023 10:37 PM, Kalle Valo wrote:
>
>> Aloka Dixit <quic_alokad@quicinc.com> writes:
>>
>>> Include MBSSID parameters in WMI vdev up operation.
>>>
>>> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
>>> Co-developed-by: John Crispin <john@phrozen.org>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>> ---
>>
>> [...]
>>
>>> @@ -7153,8 +7161,13 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>>>   			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
>>>   				    ret);
>>>   +		if (arvif->vif->mbssid_tx_vif)
>>> +			tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
>>
>> This had a warning:
>>
>> drivers/net/wireless/ath/ath11k/mac.c:7200: line length of 92 exceeds 90 columns
>>
>> In the pending branch I fixed it like this:
>>
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -7143,6 +7143,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>>   {
>>          struct ath11k_base *ab = ar->ab;
>>          struct ath11k_vif *arvif, *tx_arvif = NULL;
>> +       struct ieee80211_vif *mbssid_tx_vif;
>>          int ret;
>>          int i;
>>          bool monitor_vif = false;
>> @@ -7196,8 +7197,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>>                          ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
>>                                      ret);
>>   -               if (arvif->vif->mbssid_tx_vif)
>> -                       tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
>> +               mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
>> +               if (mbssid_tx_vif)
>> +                       tx_arvif = (struct ath11k_vif *)mbssid_tx_vif->drv_priv;
>> +
>>                  ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
>>                                           arvif->bssid,
>>                                           tx_arvif ? tx_arvif->bssid : NULL,
>>
>> Link to the commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c884238009e778a0c8202a5eb0a7f68b13200bde
>>
>
> Thank you.
>
> I saw the warning but couldn't decide between adding a new pointer
> variable and letting 2 extra characters for just one assignment.

My scripts will fail loudly if any of the ath*0k-check scripts have
warnings, so just like with compiler warnings I have a zero warnings
policy :) It would become a mess otherwise to know which warnings are
new and which are old.

> What are your thoughts on changing the scripts to allow up to 100?
> Although nl80211 and mac80211 scripts also don't allow that long currently.

Yeah, the checkpatch default is 100 right now and I have understood that
what Linus prefers. I'm just worried that increasing the max to 100
makes our code even more convoluted, it's a challenge as is.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
