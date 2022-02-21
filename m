Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7994BD7AB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbiBUICv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 03:02:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbiBUICs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:48 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7444F6388;
        Mon, 21 Feb 2022 00:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645430541; x=1676966541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y/cyXO8yRCKsmSfHSbaK7L7wvV6G8gdM36lM+3LriEw=;
  b=cYwssQrwLplTKqtlVQ5v1KPwurDBiauyuzw0MnCx8rck/Z9QrshRoCfG
   qdxgqj2WFmq/rduSCO+nNchXo/9dbtd7jodUwvcXnZGttbyI9xQbp+d1m
   ZTs+eOQILLKmwlfbhJd4ThgAeh4osXoXHa7F7lQey68UNiheUmjGbccGk
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Feb 2022 00:02:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:02:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 21 Feb 2022 00:02:19 -0800
Received: from [10.216.7.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 00:02:16 -0800
Message-ID: <72c74a65-27a7-ad1c-07db-59d478ed8cef@quicinc.com>
Date:   Mon, 21 Feb 2022 13:32:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 10/19] ath11k: Add QMI changes for WCN6750
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
 <1642337235-8618-11-git-send-email-quic_mpubbise@quicinc.com>
 <87o83wf821.fsf@kernel.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <87o83wf821.fsf@kernel.org>
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



On 1/28/2022 4:20 PM, Kalle Valo wrote:
> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
> 
>> In the case of WCN6750, FW doesn't request for DDR memory
>> via QMI, instead it uses a fixed 12MB reserved Memory region
>> in the DDR which is called as MSA region. As a result, QMI
>> message sequence is not same as other ath11k supported devices.
>>
>> Also, M3 firmware will be bundled into the FW and will be
>> downloaded to the target as part of Q6 boot.
>>
>> This is the QMI flow in the case of WCN6750,
>>
>> 1) QMI firmware indication REQ/RESP
>> 2) QMI host capability REQ/RESP
>> 3) QMI target capability REQ/RESP
>> 4) QMI device info REQ/RESP
>> 5) QMI BDF download
>> 6) QMI FW ready
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> [...]
> 
>> @@ -2490,6 +2497,13 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
>>   	struct qmi_txn txn;
>>   	int ret = 0;
>>   
>> +	/* In the case of WCN6750, M3 is bundled into the FW
>> +	 * binary, and will be downloaded as part of Q6 boot.
>> +	 */
>> +	if (!ab->bus_params.m3_fw_support &&
>> +	    ab->bus_params.hybrid_bus_type)
>> +		return 0;
> 
> A check like this makes me think if it's just better to m3_fw_support to
> ath11k_hw_params. That way you could disable m3 for WCN6750 via
> hw_params.
> 

You are right, it's better to have a hw_param instead.
