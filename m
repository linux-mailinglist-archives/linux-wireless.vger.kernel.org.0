Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905B4E725C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349104AbiCYLim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiCYLil (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 07:38:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895FD3AE9
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648208228; x=1679744228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nPYVk9arwWFvU+RIobR85FG3FuDaKZfRncLXiNUgpOU=;
  b=JxEnBNu9SGVEiutsj0WjS1NNSeDvmXpVHPEd2ohn/6islRE7RTJVmsgm
   z24xU5kk5SFRM03RVyrCS9LDqILkMQ/mzGPRmn3QkIMgvG+yGilTt6n4i
   3q08CLMbOBE3O8dmDaApwyjQlEORwFDMZ3XcsXTnEpABKrI3/6l1xGCBX
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Mar 2022 04:37:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:37:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:37:07 -0700
Received: from [10.253.13.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 25 Mar
 2022 04:37:06 -0700
Message-ID: <8d5afd24-71d6-d57b-960a-24d3858d295b@quicinc.com>
Date:   Fri, 25 Mar 2022 19:37:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ath11k: reduce the wait time of 11d scan and hw scan
 while add interface
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220322124226.18347-1-quic_wgong@quicinc.com>
 <164820512408.2234.13144214774407671269.kvalo@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <164820512408.2234.13144214774407671269.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 3/25/2022 6:45 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> wrote:
>
...
> I see new warnings in my regression tests:

Hi Kalle,

May I know what is your regression test do?

>
> [  755.217708] ath11k_pci 0000:06:00.0: failed to receive 11d scan complete: timed out
> [  794.641670] ath11k_pci 0000:06:00.0: failed to receive 11d scan complete: timed out
>
> Didn't investigate the patch in detail, gave up after seeing these warnings.
>
> Patch set to Changes Requested.
>
