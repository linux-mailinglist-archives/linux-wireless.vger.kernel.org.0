Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC852F052
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351606AbiETQQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351511AbiETQQC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 12:16:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB591AD93
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653063360; x=1684599360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LDi5gAnGJPEKrTp0Xu4ExxEKGXnSOO61AHomJ/Pd5no=;
  b=OcTg0Rj2jWTn2T1Lr+6MnmKyEZZtKtgirgVia3pScnwRFp9/HiUQNjzq
   QOCbYhd7BfokZCD9l/qdDFyLg1OoPHyZLGkxRr7fwn26t5I1/9cX/+NRs
   noqfOk9ILYm+FLXrXgpCyxCZjItGZ87K+WQHlEHEcU2Nfsj+YxZ5/Z1Ht
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 09:15:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:15:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 09:15:58 -0700
Received: from [10.110.24.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 09:15:57 -0700
Message-ID: <a8a3b56b-5e82-28cb-bd61-e338bae25df2@quicinc.com>
Date:   Fri, 20 May 2022 09:15:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] cfg80211: Increase akm_suites array size in
 cfg80211_crypto_settings
Content-Language: en-US
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1653024702-5304-1-git-send-email-quic_vjakkam@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1653024702-5304-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/19/2022 10:31 PM, Veerendranath Jakkam wrote:
> Increase akm_suites array size in struct cfg80211_crypto_settings to 10
> and advertise the capability to userspace. This allows userspace to send
> more than two AKMs to driver in netlink commands such as
> NL80211_CMD_CONNECT.
> 

I have some grammar nits below...
> This capability needed for implementing WPA3-Personal transition mode

capability *is* needed

> correctly with any driver that handles roaming internally. Currently,
> the possible AKMs for multi-AKM connect can include PSK, PSK-SHA-256,
> SAE, FT-PSK and FT-SAE since the count is already 5, Increasing

...and FT-SAE. Since the count is already 5, increasing...

> the akm_suites array size to 10 should be reasonable for future
> usecases.

/jeff
