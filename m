Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65737DC295
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 23:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjJ3Wn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjJ3Wn4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 18:43:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B5D3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 15:43:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMejZf024124;
        Mon, 30 Oct 2023 22:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WmTD3RQACDGlzHz4bThWJnQgWE+OEHtN11i7WlUp8as=;
 b=Ug1gH1z79pHPwK2qV1HxiM2PsaGpfeX0MATeP7HDyQdMf7eNn9LqzKmReJeFcLDeGRxO
 a+uRAeMBIv0GZCjporP/3edC9XmqBSuEs7Vy9LInwSQ4cW/BY5jv2XF4wAkz3zkvU1Kr
 HiPecQm9kWZdT4ZxdLEOocwT25zkaElMYj38kS0lix4tPCBMYkTJlJqRiv4SyJHhzGRo
 sNui/T0VgZqty6OL+FCjlmLSZdEMv4akcLU3rMD8BglxyU7vw1dZ+1RrOXzRgaMlAP8X
 QWxn59KSpSeNPSCwzjIbE3InQLlFVxpf4txtIfoFw0aMJk775oApjNoD+j1jLOakBfwP fg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2mcyg3y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:43:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UMhmi0025897
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 22:43:48 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 15:43:48 -0700
Message-ID: <75ba20b5-d152-4035-8455-8226698f04c0@quicinc.com>
Date:   Mon, 30 Oct 2023 15:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] wifi: ath12k: Update enum wmi_direct_buffer_module
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rajat Soni <quic_rajson@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-2-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030222700.18914-2-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _BMSRgpZgGUeYqL_N9zIg4aEfMqsPjvZ
X-Proofpoint-ORIG-GUID: _BMSRgpZgGUeYqL_N9zIg4aEfMqsPjvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
> From: Rajat Soni <quic_rajson@quicinc.com>
> 
> Currently firmware is sending module id as 2 that is not supported.
> This causes functional failure in driver.
> Firmware added support for WMI_CONFIG_MODULE_CV_UPLOAD.

I think the above would be more clearly written as something like:
Currently firmware supports sending three different values for enum 
wmi_direct_buffer_module, but the host currently only supports 2; 
support for WMI_DIRECT_BUF_CV_UPLOAD is missing. This cause a functional 
failure on the host because... (what is the problem? the fact that host 
doesn't allocate buffers for CV upload? or does the value of 2 cause a 
buffer overread/write of an array sized with WMI_DIRECT_BUFFER_MAX

> Add enum WMI_CONFIG_MODULE_CV_UPLOAD in wmi_direct_buffer_module to

you actually added WMI_DIRECT_BUF_CV_UPLOAD

> resolve this issue.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 629373d67..8e1eda7aa 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -2230,6 +2230,7 @@ enum wmi_beacon_gen_mode {
>   enum wmi_direct_buffer_module {
>   	WMI_DIRECT_BUF_SPECTRAL = 0,
>   	WMI_DIRECT_BUF_CFR = 1,
> +	WMI_DIRECT_BUF_CV_UPLOAD = 2,
>   
>   	/* keep it last */
>   	WMI_DIRECT_BUF_MAX

