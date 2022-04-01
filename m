Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8E4EFA41
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiDATIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiDATIg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 15:08:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00F28A012
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648840006; x=1680376006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BmSH22NnDtVbiQhBZhwGhDzGiNVDa1XzVcMrc/H0d2s=;
  b=AlSoFThzDPYITwOxBNmmmjtvxPUaOR+YS2d5kUDY4vx/DtPPuJMe9o0L
   MnuPAc7EjE8TTyxuQ0lqDFGOO2p35jP26IZQidQmdlpbgBr7gQeWWp7Ol
   LdJb/XGh0CUsn9GQhCY9vXqJhJvdvdjMPuSJ4ygPuM2evy75UvWpPA1Q6
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Apr 2022 12:06:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:06:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 12:06:46 -0700
Received: from [10.110.67.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 12:06:45 -0700
Message-ID: <cb07aa82-2971-69dd-bf80-ff7f0cff4569@quicinc.com>
Date:   Fri, 1 Apr 2022 12:06:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/2] ath11k: Add support for SAR
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220401120948.1312956-1-quic_bqiang@quicinc.com>
 <20220401120948.1312956-3-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220401120948.1312956-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/1/2022 5:09 AM, Baochen Qiang wrote:
> ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops,
> and this function is called when user space application
> calls NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR
> type and frequency ranges to wiphy so user space can query
> SAR capabilities.

I find this commit text very confusing since it uses "present simple" 
tense instead of "imperative" tense so it comes across as describing 
what the driver did prior to the patch instead of what the driver is 
supposed to do after the patch is applied.

The patch itself LGTM.
