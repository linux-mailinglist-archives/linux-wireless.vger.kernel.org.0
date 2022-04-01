Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4D4EF9C4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiDASYh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbiDASYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 14:24:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF93541A5
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648837366; x=1680373366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lgkQgXVDoFRjiy0mawrAnamkzEzLXyahnbv1kgs8nHI=;
  b=RLRjwcnZU43m5JiUoMBxcCmM6fL6P58VEIRchg6B4k5F/LqEYNXb8rJK
   FYpPcK2DSYcEqqXG8I5cpLnhADxdvPUqG/zPAMTHMGkebcd/HQwZjn+Vb
   07u4EiakhROFOjNDnbezWUwGQrkTols7z751B8I0/trzw7Z1zxOqblPen
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Apr 2022 11:22:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 11:22:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 11:22:05 -0700
Received: from [10.110.67.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 11:22:05 -0700
Message-ID: <0ca06ab7-2256-a391-907f-ba597ac211bb@quicinc.com>
Date:   Fri, 1 Apr 2022 11:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/3] ath11k: mhi cleanup
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220401173042.17467-1-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220401173042.17467-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/1/2022 10:30 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Some minor cleanup to mhi.c, please review.
> 
> Kalle Valo (3):
>    ath11k: mhi: remove state machine
>    ath11k: mhi: add error handling for suspend and resume
>    ath11k: mhi: remove unnecessary goto from ath11k_mhi_start()
> 
>   drivers/net/wireless/ath/ath11k/mhi.c | 222 ++++----------------------
>   drivers/net/wireless/ath/ath11k/mhi.h |  17 +-
>   drivers/net/wireless/ath/ath11k/pci.c |   8 +-
>   drivers/net/wireless/ath/ath11k/pci.h |   1 -
>   4 files changed, 38 insertions(+), 210 deletions(-)
> 
> 
> base-commit: 57b7042c114767b7330b14a260f61732e556742e

For entire series:
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
