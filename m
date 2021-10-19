Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5188433B6E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJSQBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 12:01:47 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57601 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhJSQBn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 12:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634659171; x=1666195171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=odVpGGDv15O9wDy9TKdMNrqjQP+X5lRpCkAKPJtlTOY=;
  b=LBKn2gKepKZSt3vLh/MXlRjCgENJcez/RwHpD3np99H8X2CxGJWA3wrt
   iGwzmKVvX66JoUnMZyB2rwZ/XKov4DMt7aAwffckGp6DQ89f3YXmNzPtd
   a29k9R0DfgYsr7q0gy5pzSxxKS7cdhoRNpdGorcG9OhrOYdciZHlsWn5K
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 19 Oct 2021 08:59:30 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:59:30 -0700
Received: from [10.48.244.108] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 19 Oct 2021
 08:59:28 -0700
Message-ID: <9ac46348-23da-7180-3f80-6a223de97d0e@quicinc.com>
Date:   Tue, 19 Oct 2021 08:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v2 0/5] wcn36xx: Fix DMA buffer allocation and free logic
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <wcn36xx@lists.infradead.org>
CC:     <loic.poulain@linaro.org>, <benl@squareup.com>,
        <daniel.thompson@linaro.org>, <johannes@sipsolutions.net>
References: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/18/2021 4:17 PM, Bryan O'Donoghue wrote:
> V2:
> - Functionally decomposes the DXE reset in an additional patch.
>    Since we call this logic more than once, it should be in a function.
> 
> - Leaves as-is the DXE reset write.
> 
>    Johannes Berg asked me if we are sure by the time the write to the reset
>    register completes that DXE transactions will be suitably quiesced.
> 
>    The answer is:
>    1. I believe these writes are non-posted writes
>    2. Downstream doesn't poll for DXE reset completion
> 
>    So on #2 I have no real data for or against a polling operation, my tests
>    indicate the reset indication in the register is atomic and as far as I
>    can discern that also means DMA transactions are terminated.
> 
> V1:
> Digging around through some bugs reported from an extensive testing cycle
> we've found that wcn36xx has a number of unexplained RX related oopses.
> 
> In at least one case we appear to have DMA'd data to an unmapped region.
> The written data appears to be a correctly formed DMA buffer descriptor - a
> DXE BD in WCNSS parlance, with an AP beacon inside of it.
> 
> Reasoning about how such a situation might come about and reviewing the
> run-time code, there was no obvious path where we might free a BD or an
> skbuff pointed to by a BD, which DXE might not be aware of.
> 
> However looking at the ieee80211_ops.start and ieee80211_ops.stop callbacks
> in wcn36xx we can see a number of bugs associated with BD allocation, error
> handling and leaving the DMA engine active, despite freeing SKBs on the MSM
> side.
> 
> This last mention - failure to quiesce potential DMA from the downstream
> agent - WCNSS DXE despite freeing the memory @ the skbuffs is a decent
> candidate for our unexplained upstream DMA transaction to unmapped memory.
> 
> Since wcn36xx_stop and wcn36xx_start can be called a number of times by the
> controlling upper layers it means there is a potential gap between
> wcn36xx_stop and wcn36xx_start which could leave WCNSS in a state where it
> will try to DMA to memory we have freed.
> 
> This series addresses the obvious bugs that jump out on the start()/stop()
> path.
> 
> Patch #1
>    In order to make it easier to read the DXE code, I've moved all of the
>    lock taking and freeing for DXE into dxe.c
> 
> Patch #2
>    Fixes a very obviously broken channel enable/disable cycle
> 
> Patch #3
>    Fixes a very obvious memory leak with dma_alloc_coherent()
> 
> Patch #4
>    Makes sure before we release skbuffs which we assigned to the RX channels
>    that we ensure the DXE block is put into reset
> 
> Bryan O'Donoghue (5):
>    wcn36xx: Fix dxe lock layering violation
>    wcn36xx: Fix DMA channel enable/disable cycle
>    wcn36xx: Release DMA channel descriptor allocations
>    wcn36xx: Functionally decompose DXE reset
>    wcn36xx: Put DXE block into reset before freeing memory
> 
>   drivers/net/wireless/ath/wcn36xx/dxe.c  | 83 +++++++++++++++++++++----
>   drivers/net/wireless/ath/wcn36xx/dxe.h  |  2 +
>   drivers/net/wireless/ath/wcn36xx/txrx.c | 15 +----
>   3 files changed, 74 insertions(+), 26 deletions(-)
> 

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
