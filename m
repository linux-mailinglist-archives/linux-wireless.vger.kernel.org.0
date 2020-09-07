Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB02603EE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIGLUg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:60884
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728637AbgIGLTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 07:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599476512;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=AdrBOHvopvBC24w7JMdTjjLjR1rv8HjCN1EIJF8sPrU=;
        b=m+rhQ4/2f/fz86slxkgkrphkXtsq0VNO1hWFEON7QWx9YeeazhArB/vmzyUE4Upt
        U4CTCwZXIC6OcDO8YlbOtQ6f/DCBhEXnwDrkhTVuR7HUcaV/g3qz+EO8+8XNcmdHwRg
        YooZWquG25aFHJO2on5gGcDvfxEQEUfLUBTuDlpc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599476512;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=AdrBOHvopvBC24w7JMdTjjLjR1rv8HjCN1EIJF8sPrU=;
        b=QcEAKB5zBO86oo5jfgOg072w4fAFwL7H/xZ3XrZuNInHUdamn7dujMHe4FlDoNBn
        YN8WlWg228TUYl+rAHBn0A6r9gr0feI9ehU70l0sjcKJEa9qHSRFu6jxC7y6LS9JhdD
        pLHobeygz8MA044fzLRks/Ua2fkk52wijrfzr6bQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 7 Sep 2020 11:01:52 +0000
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath11k: add IPQ6018 support
In-Reply-To: <87y2ll3nzh.fsf@codeaurora.org>
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
 <1598287470-1871-4-git-send-email-akolli@codeaurora.org>
 <87y2ll3nzh.fsf@codeaurora.org>
Message-ID: <01010174683ab719-82f5c599-a2e0-4697-9c14-9ce1c64608d5-000000@us-west-2.amazonses.com>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.07-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-07 15:30, Kalle Valo wrote:
> Anilkumar Kolli <akolli@codeaurora.org> writes:
> 
>> IPQ6018 has one 5G and one 2G radio with 2x2,
>> shares ipq8074 configurations.
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> 
> [...]
> 
>> @@ -890,9 +995,15 @@ static int ath11k_ahb_probe(struct 
>> platform_device *pdev)
>>  		goto err_hal_srng_deinit;
>>  	}
>> 
>> -	ab->hw_params.svc_to_ce_map_len =
>> +	if (ab->hw_rev == ATH11K_HW_IPQ8074) {
>> +		ab->hw_params.svc_to_ce_map_len =
>>  			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
>> -	ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
>> +		ab->hw_params.svc_to_ce_map = 
>> target_service_to_ce_map_wlan_ipq8074;
>> +	} else if (ab->hw_rev == ATH11K_HW_IPQ6018) {
>> +		ab->hw_params.svc_to_ce_map_len =
>> +			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018);
>> +		ab->hw_params.svc_to_ce_map = 
>> target_service_to_ce_map_wlan_ipq6018;
>> +	}
> 
> The idea of having ab->hw_params is to avoid the need for hw_rev
> sprinkled all over the code, this here defeats the purpose. I recommend
> checking if my proposal from an earlier version is implementable:
> 
> "You could copy the map arrays to hw.c, as an example see how
>  ath11k_hw_ring_mask_ipq8074 is implemented. That way we don't need any
>  new hw_rev checks."

Thanks for the details, will address and send in next patch set.

Thanks
Anil
