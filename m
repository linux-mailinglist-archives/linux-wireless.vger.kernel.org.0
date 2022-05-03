Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87F51886C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 May 2022 17:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiECP0E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 May 2022 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiECP0C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 May 2022 11:26:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E013F21
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651591350; x=1683127350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WxAD/mFvo/FjQ3sFtTHpbR+m/rdDXk3zprDa+9cn+Dc=;
  b=HvKVsGm9rG0/rlrDJOKrebYdTLaDsemDrwCW70MiYxRv41Zlxtza5kyV
   eE39WXNKs8hxdXPt8UxF4ob1fu2nSEPcgL0WAP1/5Y/xAfU2NjrtrUFeU
   2HHRAnLml0BSspnv5TBagzMOkj+9G6cHJf9Smd6bN7lXxnTmJipY9UoAn
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 May 2022 08:22:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:22:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 08:22:29 -0700
Received: from [10.110.89.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 08:22:29 -0700
Message-ID: <2bb799aa-0a43-1433-70b2-76b14beee0dd@quicinc.com>
Date:   Tue, 3 May 2022 08:22:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] ath10k: mac: fix too long lines
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220503060415.24499-1-kvalo@kernel.org>
 <20220503060415.24499-2-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220503060415.24499-2-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/2/2022 11:04 PM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> checkpatch warns:
> 
> drivers/net/wireless/ath/ath10k/mac.c:2696: line length of 92 exceeds 90 columns
> drivers/net/wireless/ath/ath10k/mac.c:6942: line length of 94 exceeds 90 columns
> drivers/net/wireless/ath/ath10k/mac.c:6948: line length of 91 exceeds 90 columns
> 
> These were introduced by commit 046d2e7c50e3 ("mac80211: prepare sta handling
> for MLO support").
> 
> Compile tested only.
> 

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath10k/mac.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
