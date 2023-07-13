Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C628751609
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 04:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjGMCG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jul 2023 22:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGMCG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jul 2023 22:06:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9419B4
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 19:06:25 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D1qFxS025975;
        Thu, 13 Jul 2023 02:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TooLJz9JQiHkFo9TFNpV0QIA2XF2akLkzzcLNcLtYjs=;
 b=mhCgp5CxAs5piFkPQ3pq8IM6dETQW1YAYkdnRMJ6fxJAx1ZZpR/H+1YFb40fqYFeFosM
 dKav5D/1B1y9d2zUqf+4s8ULVvsJ0HFc55JlijWvu8+bCa/lITpQo0g7An7ViEyLU9z7
 M5NeHNe22OvHY+xBKZ4TBFDmNxmhXHyOCb2JJ4m9WsMUhP5rET5kH92Lh9DCtACVyrTH
 95DA8fNE0ojFeXDn4kbPwvQhyb7kW3S9s5gBg+s+k6zb4JZMYG6VPHsKYxtUan98VuS3
 U2UXqa6f7HnFrrU4UGTQfSV246foHlsJSFQX1B0fGjE2FSdvGtBVZ2jB9Kkch/j+SRJ/ UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgarau74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 02:06:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D265JA002725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 02:06:05 GMT
Received: from [10.111.182.44] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 19:06:04 -0700
Message-ID: <92dbd473-4f39-331c-bfc6-8e423429525e@quicinc.com>
Date:   Wed, 12 Jul 2023 19:06:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v3] wifi: ath11k: Add crash logging
Content-Language: en-US
To:     Arowa Suliman <arowa@chromium.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230713002319.4057612-1-arowa@chromium.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230713002319.4057612-1-arowa@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5sufcARNqBQGmyt8JcYB6j6k_iIqg-fb
X-Proofpoint-ORIG-GUID: 5sufcARNqBQGmyt8JcYB6j6k_iIqg-fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_17,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130018
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/12/2023 5:22 PM, Arowa Suliman wrote:
> Currently, the ath11k driver does not print a crash signature when a
> crash happens. Checked by triggering a simulated crash using the command
> [1] and checking dmesg for logs.
> 
> [1] echo assert > /sys/kernel/debug/ath11k/../simulate_fw_crash
> 
> Change the crash logging from debug to informational and add a warning
> when firmware crash MHI_CB_EE_RDDM happens.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Arowa Suliman <arowa@chromium.org>
> ---
> v3:
> 1- Fixed the error:
> drivers/net/wireless/ath/ath11k/mhi.c:328:25: warning: passing argument 2 of 'ath11k_info' makes pointer from integer without a cast [-Wint-conversion]
> 2- Removed extra spaces in lines 329 and 338
> 3- Updated commit message with correct Tested-on flag and the reason of
> the change.
> ---
>   drivers/net/wireless/ath/ath11k/mhi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
> index 3ac689f1def4..d9783c2e0529 100644
> --- a/drivers/net/wireless/ath/ath11k/mhi.c
> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
> @@ -325,7 +325,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
>   {
>   	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
>   
> -	ath11k_dbg(ab, ATH11K_DBG_BOOT, "notify status reason %s\n",
> +	ath11k_info(ab, "notify status reason %s\n",
>   		   ath11k_mhi_op_callback_to_str(cb));

I would have expected this to line to shift right one space to align on (

>   
>   	switch (cb) {
> @@ -333,6 +333,7 @@ static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
>   		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
>   		break;
>   	case MHI_CB_EE_RDDM:
> +		ath11k_warn(ab, "firmware crashed: MHI_CB_EE_RDDM\n");
>   		if (!(test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)))
>   			queue_work(ab->workqueue_aux, &ab->reset_work);
>   		break;

