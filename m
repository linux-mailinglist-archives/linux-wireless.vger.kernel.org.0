Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F091F4F7548
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbiDGFXs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiDGFXr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 01:23:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54FC10BD17;
        Wed,  6 Apr 2022 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649308907; x=1680844907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1EpOUVY650Sk0li7cGYf29RiOHs7Ea9JKGbs8flcp4w=;
  b=oUJe+UUGtpocRiG1lgQqZ/dI12WkrByTuCSk5MxElI2viQr2C45iX6/T
   JUOMnw4plimM2dvRq7b/N/IH/Sh0ms9hIf5Gol0nwflOeB4KvWurEOGRW
   F1c0Gg+KtuIE6E8r4TAuBUPS26JwJqyCneu3P4166kt4P5tvYnTF1ZH0k
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 22:21:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 22:21:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 22:21:46 -0700
Received: from [10.50.10.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 22:21:43 -0700
Message-ID: <e2fd6542-38fe-a855-1d8f-65799970727e@quicinc.com>
Date:   Thu, 7 Apr 2022 10:51:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 01/12] dt: bindings: net: add bindings of WCN6750 for
 ath11k
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <mka@chromium.org>,
        <ath11k@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
 <20220406094107.17878-2-quic_mpubbise@quicinc.com>
 <Yk2s+srO9DKP7xW1@robh.at.kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <Yk2s+srO9DKP7xW1@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/6/2022 8:38 PM, Rob Herring wrote:
> On Wed, 06 Apr 2022 15:10:55 +0530, Manikanta Pubbisetty wrote:
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
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 

There are changes in V4 but nothing significant, I have missed adding 
the tag, will make sure to add relevant tags going forward.

Thanks,
Manikanta
