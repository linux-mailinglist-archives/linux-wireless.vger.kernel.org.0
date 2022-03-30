Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2987A4EBA03
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 07:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbiC3FU4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 01:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiC3FUz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 01:20:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28595A27C0;
        Tue, 29 Mar 2022 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648617551; x=1680153551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DrQrBtnuoEiDhYwrgeogj26bXxENzzF7ytxPr/um6/Q=;
  b=LfsrbPUYK2B3joipYyBFPqhTkMd80QIz01h8Eys0Lzj9PFQKOhAFnmxY
   aiNIOQOMn7vJWVgyLyHBM/pYRnQhb62oP75L6erzLPM/TM7KzNEpoGixg
   PIlUOMownozLvRyhZnyG0m9TMZr5D3iEM7zZatILZIwXyWCF1JZ5bNJmB
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Mar 2022 22:19:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:19:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 22:19:10 -0700
Received: from [10.50.50.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 29 Mar
 2022 22:19:08 -0700
Message-ID: <31ea937d-d1d9-b9ed-c023-8a1ea0eea42c@quicinc.com>
Date:   Wed, 30 Mar 2022 10:49:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 01/12] dt: bindings: net: add bindings of WCN6750 for
 ath11k
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20220328094838.14093-1-quic_mpubbise@quicinc.com>
 <20220328094838.14093-2-quic_mpubbise@quicinc.com>
 <YkOYTpTMXTEx5mAU@robh.at.kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <YkOYTpTMXTEx5mAU@robh.at.kernel.org>
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



On 3/30/2022 5:07 AM, Rob Herring wrote:
> On Mon, 28 Mar 2022 15:18:27 +0530, Manikanta Pubbisetty wrote:
>> WCN6750 is the WLAN chip on Qualcomm Snapdragon SoC SC7280;
>> Though being a PCIe based solution, it is not attached to
>> the APSS processor (Application Processor SubSystem), it is
>> instead attached to another tiny processor called WPSS Q6
>> processor (Wireless Processor SubSystem) on the SC7280 MSM,
>> where the WLAN firmware runs, and it is the WLAN firmware
>> running on the Q6 processor which enumerates WCN6750, as a
>> result APPS processor would never know such a device being
>> present in the system and would not detect the WCN6750
>> hardware unless and otherwise WCN6750 is registered as a
>> platform device. This is the reason behind adding WCN6750
>> WLAN node in the device tree.
>>
>> Add WCN6750 wireless driver support, its based on ath11k driver.
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>> ---
>>   .../bindings/net/wireless/qcom,ath11k.yaml    | 361 ++++++++++++------
>>   1 file changed, 252 insertions(+), 109 deletions(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review Rob!!

Manikanta
