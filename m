Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97167E7F7A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 18:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjKJRyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 12:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKJRx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1968643F0A
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 09:14:39 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAFGPhe027150;
        Fri, 10 Nov 2023 17:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ig5Vw96F0OxafDv/SWcV6z8b6PUkEIHMQvGS1FNffPo=;
 b=dsN2ZyGD8Zn/9jCUDC36/3oQ24Gm7Xhf3w6OYvimdl9ZqELLrgFaJGjtagBJkhfhe5E7
 cBwbqdxc9qSNtWeWiiq+dKYkuPPAoOgqspv7nYlivE4ivWqAzlGNVOeS1ROBOqCjNMp7
 ee18YwljDb3wrRt+WdKReaWnHuomy+i3ov8s/b5dLlhbjyJlooiIIQoM17DyyUyptbbO
 ccAVIXHwY3QCRBObnSDyo+pgItadQ/tMd4beThm98Ngxem2I/+Ywcs3s5KpvUFlzXrmt
 tEnrzA+m4W5EAzaXDw2hLNUjFiJUQt1fxlyYvGUyE+CM7/K9SAADe5R5pUyRzPkRbS8V oQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9q0w095s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 17:14:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AAHED0u022533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 17:14:13 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 09:14:12 -0800
Message-ID: <2cb885fa-ab21-dd54-22ff-d23abfc7ea03@quicinc.com>
Date:   Fri, 10 Nov 2023 10:14:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH RFC 2/8] bus: mhi: host: add new interfaces to handle MHI
 channels directly
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
 <20231110102202.3168243-3-kvalo@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20231110102202.3168243-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KwQN-2gxg8tssZI4HZeLMt-Ahyvb5Bou
X-Proofpoint-ORIG-GUID: KwQN-2gxg8tssZI4HZeLMt-Ahyvb5Bou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 mlxlogscore=732 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100144
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/2023 3:21 AM, Kalle Valo wrote:
> From: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
> by themselves.  Similarly, MHI stack will also not create new MHI device since
> old devices were not destroyed, so MHI hosts need to prepare channels as well.
> Hence add these two interfaces to make that possible.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/bus/mhi/host/main.c | 91 +++++++++++++++++++++++++++++++++++++
>   include/linux/mhi.h         | 18 ++++++++
>   2 files changed, 109 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index dcf627b36e82..9bcf8a49c000 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1667,6 +1667,49 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
>   }
>   EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
>   
> +static int __mhi_prepare_for_transfer_autoqueue(struct device *dev, void *data)
> +{
> +	struct mhi_device *mhi_dev;
> +	struct mhi_chan *ul_chan, *dl_chan;
> +	enum mhi_ee_type ee = MHI_EE_MAX;
> +
> +	if (dev->bus != &mhi_bus_type)
> +		return 0;
> +
> +	mhi_dev = to_mhi_device(dev);
> +
> +	/* Only prepare virtual devices thats attached to bus */

"that are"?

> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> +		return 0;
> +
> +	ul_chan = mhi_dev->ul_chan;
> +	dl_chan = mhi_dev->dl_chan;
> +
> +	/*
> +	 * If execution environment is specified, remove only those devices that
> +	 * started in them based on ee_mask for the channels as we move on to a
> +	 * different execution environment
> +	 */
> +	if (data)
> +		ee = *(enum mhi_ee_type *)data;
> +
> +	if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
> +		return 0;
> +
> +
> +	if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
> +		return 0;
> +
> +	return mhi_prepare_for_transfer_autoqueue(mhi_dev);
> +}
> +
> +int mhi_prepare_all_for_transfer_autoqueue(struct mhi_controller *mhi_cntrl)
> +{
> +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
> +				     __mhi_prepare_for_transfer_autoqueue);
> +}
> +EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer_autoqueue);

This seems broken.  It appears to configure all channels as autoqueue, 
regardless of how the controller initially configured them.  This would 
only be safe to use if all channels were configured for autoqueue, but 
would silently cause issues otherwise.

