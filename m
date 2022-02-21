Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684994BD7A9
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 09:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbiBUIBO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 03:01:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiBUIBN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 03:01:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EF51163;
        Mon, 21 Feb 2022 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645430447; x=1676966447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vCMIU2GDHpexi3NGarDhvGuLbC22KSrHMRfsgun8RRs=;
  b=PxKypCHBuS6+KHtlRVPray9tTTF/Zp7Z4MAvjHxHGH4E9zmROo9ar/vr
   Y2IkuksxJZpgpA8ZjehRgp6o2tGsXSEcNFbeq9HrniToRkY0HQKR1oaLx
   N8PYW5EfPDzJWSo+iZB92aI7k/qBSCgcUMRUSmxZuZMWTdbyj+6AWDgDT
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 00:00:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:00:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 00:00:47 -0800
Received: from [10.216.7.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 00:00:43 -0800
Message-ID: <4b847295-4840-4fa5-f234-a368fcfcadb4@quicinc.com>
Date:   Mon, 21 Feb 2022 13:30:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 18/19] ath11k: Add support for targets without
 trustzone
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
 <1642337235-8618-19-git-send-email-quic_mpubbise@quicinc.com>
 <87sft8f8g3.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87sft8f8g3.fsf@kernel.org>
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



On 1/28/2022 4:12 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> Add the support to attach WCN6750 and map iommu domain
>> for targets which do not have the support of TrustZone.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> Is this not needed in the initial WCN6750 support? If yes, please submit
> this patch after WCN6750 support has been commited. That way we can
> reduce patchset size.
> 

Sure, we can do that.
