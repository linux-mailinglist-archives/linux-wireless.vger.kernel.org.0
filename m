Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD951CED8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378537AbiEFB22 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 21:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiEFB21 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 21:28:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934512776
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651800286; x=1683336286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZAyW46bDt1XyBpp4qIIkQWPnxgGn42ujUL/CEZ0UftA=;
  b=Itpu/OK6vRm7i0JXAzO0u+rl0WJ3yEjpuMI/Y4WPmqxb+om37Q/TzAxV
   lHNEYjfPo2Nvew4VD7Nw2BovXcHug36bBP8ue9nslqyGN/YWEMQxuGWvY
   lwup6PuBDGH4LHdpm4R3tJhIygDVQiWJkbuXD9vXbYTdoDr9q125CCQGr
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 05 May 2022 18:24:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:24:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 18:24:45 -0700
Received: from [10.253.34.102] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 18:24:44 -0700
Message-ID: <699e4be8-f32e-7cc7-4c38-3c321334245f@quicinc.com>
Date:   Fri, 6 May 2022 09:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ath11k: Handle keepalive during wowlan suspend and resume
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220505014657.1549947-1-quic_bqiang@quicinc.com>
 <f270b2fb-a1c4-9c6b-6eda-c2d0a8c8c190@quicinc.com>
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <f270b2fb-a1c4-9c6b-6eda-c2d0a8c8c190@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/6/2022 3:04 AM, Jeff Johnson wrote:
> On 5/4/2022 6:46 PM, Baochen Qiang wrote:
>> With wowlan enabled and after sleeping for a rather long time,
>
> nit: s/wowlan/WoWLAN/ to conform to common usage (also in subject)
>
already fixed in v2.


>> we are seeing that with some APs, it is not able to wake up
>> the STA though the correct wake up pattern has been configured.
>> This is because the host doesn't send keepalive command to
>> firmware, thus firmware will not send any packet to the AP and
>> after a specific time the AP kicks out the DUT.
>>
>> Fix this issue by enabling keepalive before going to suspend
>> and disabling it after resume back.
>>
>> Tested-on: WCN6855 hw2.0 PCI 
>> WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>
> [...]
>
>> +
>> +enum wmi_sta_keepalive_method {
>> +    WMI_STA_KEEPALIVE_METHOD_NULL_FRAME = 1, /* 802.11 NULL frame */
>> +    WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE = 2, /* ARP 
>> response */
>> +    WMI_STA_KEEPALIVE_METHOD_ETHERNET_LOOPBACK = 3, /*ETHERNET 
>> LOOPBACK*/
>> +    WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST = 4, /* 
>> gratuitous ARP req*/
>
> nit: for the two above consistently have space separating comment from 
> /* and */
>
sure, will address in v3.


>> + WMI_STA_KEEPALIVE_METHOD_MGMT_VENDOR_ACTION = 5, /* vendor action 
>> frame */
>> +};
> [...]
