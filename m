Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97950A3A5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382450AbiDUPIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiDUPIg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 11:08:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1B1AF11
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650553546; x=1682089546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hAyaL+NaPM51l2STf3JbHp0XopDgxDNvlRTMP8uyqBc=;
  b=s8UMA0tOC96pNNORbdFfbydqUOW/TM8npfYDGYByoTNGHINeqmICqhPa
   e4aUYjiUC1MEnfSz/p3f6f1gw8oTywGfHmOwYzycHPn2HOk+V5yCoL18G
   NWb1Mjesi1GVD/eUA1nw9aoDvxzsJgK5gP3KC8grmVBM+A6PaaElscSg0
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Apr 2022 08:05:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:05:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 08:05:45 -0700
Received: from [10.110.114.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 08:05:45 -0700
Message-ID: <f5b266eb-1ea8-1fdd-4c78-dac4c5902b1f@quicinc.com>
Date:   Thu, 21 Apr 2022 08:05:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/2] ath11k: Add support for SAR
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220401120948.1312956-1-quic_bqiang@quicinc.com>
 <20220401120948.1312956-3-quic_bqiang@quicinc.com>
 <cb07aa82-2971-69dd-bf80-ff7f0cff4569@quicinc.com>
 <87czhbogpq.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87czhbogpq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/20/2022 9:35 AM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 4/1/2022 5:09 AM, Baochen Qiang wrote:
>>> ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops,
>>> and this function is called when user space application
>>> calls NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR
>>> type and frequency ranges to wiphy so user space can query
>>> SAR capabilities.
>>
>> I find this commit text very confusing since it uses "present simple"
>> tense instead of "imperative" tense so it comes across as describing
>> what the driver did prior to the patch instead of what the driver is
>> supposed to do after the patch is applied.
>>
>> The patch itself LGTM.
> 
> I tried to improve the commit log, please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6b0778eaea60533a8b48df2d890543a48b590f55
> 

LGTM!
