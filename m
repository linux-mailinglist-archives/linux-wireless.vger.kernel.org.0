Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914A1532F92
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 19:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiEXRYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiEXRYR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 13:24:17 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386BB7CDE2
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653413056; x=1684949056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T5zm1O2oEgLCR2clggqyywPvK9Mai5fRqlMto8pnhJU=;
  b=y8qX4uDoRel207UTZsMBiUYrYjwq4+sOtSvYXSrf+lcQ1EKhHrpK6lh4
   T2tRsZxLmJ/Psckc+mF5fkcvDWBf4Got9LlCDJQWtRBe3QYzl2plXhJJI
   o0qZNdYSBSo2dFboiJxCZzA4OfOie6znfYlXhPcDNECkyWTCcz9imGqYk
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 May 2022 10:24:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 10:24:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 10:24:15 -0700
Received: from [10.110.85.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 10:24:14 -0700
Message-ID: <e5e339a8-30c2-2659-a4a6-7fa424d35f20@quicinc.com>
Date:   Tue, 24 May 2022 10:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 07/96] cl8k: add bf.c
Content-Language: en-US
To:     <viktor.barna@celeno.com>, <linux-wireless@vger.kernel.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        "Maksym Kokhan" <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
 <20220524113502.1094459-8-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-8-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2022 4:33 AM, viktor.barna@celeno.com wrote:
[snip]

> +void cl_bf_sounding_start(struct cl_hw *cl_hw, enum sounding_type type, struct cl_sta **cl_sta_arr,
> +			  u8 sta_num, struct cl_sounding_info *recovery_elem)
> +{
> +#define STA_INDICES_STR_SIZE 64
> +
> +	/* Send request to start sounding */
> +	u8 i, bw = CHNL_BW_MAX;
> +	char sta_indices_str[STA_INDICES_STR_SIZE] = {0};
> +	u8 str_len = 0;
> +
> +	for (i = 0; i < sta_num; i++) {
> +		struct cl_sta *cl_sta = cl_sta_arr[i];
> +		struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
> +
> +		bw = cl_sta->wrs_sta.assoc_bw;
> +		bf_db->synced = false;
> +		bf_db->sounding_start = true;
> +		bf_db->sounding_indications = 0;
> +
> +		str_len += snprintf(sta_indices_str, STA_INDICES_STR_SIZE - str_len, "%u%s",
> +				    cl_sta->sta_idx, (i == sta_num - 1 ? ", " : ""));

note that this may not actually be safe from overflow due to the 
semantics of the snprintf return value.

using scnprintf() is preferred for this usage pattern
