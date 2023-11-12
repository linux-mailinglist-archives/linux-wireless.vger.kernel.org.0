Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AB7E8E1E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 05:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjKLEAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 23:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLEAj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 23:00:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08230C5
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 20:00:35 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC406ZD001214;
        Sun, 12 Nov 2023 04:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aCuIZgL5EG6kolftN0ohAVfP2R8AwZnVGsAyCQfuiQY=;
 b=c4n7oeEFARRUka8ositA4o/VCohwIPrA3hn5jM/0nfGuPZUe/nBApQL9jgjW2bfKAUfz
 H13vKE2qUezxlYmEaVgCAR80uEtHuv7kvsMYvFmy2DvAOoDzLMugYomKZ3gh+px8qxbF
 XD+MHA4dGprQlplZY6MkETDUQYmnsVKKKn3pi5iEixHqL3Vg2298ZCCNVhb+HnIgBq3F
 mogl66LwsCNUHlBrJ12xjKfRUAEJxlV8IHSdHL797AiHk5ablNBifViYKXDPplQc5C94
 j8fw/omwRPB+VhC1Z1fqU0e/zVgJ7guhYiH562pRAjzJMI7aDsFfx2yeaJU9Em2OVtij Hg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua1q1he4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 04:00:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AC404Rl010199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 04:00:04 GMT
Received: from [10.253.35.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sat, 11 Nov
 2023 20:00:02 -0800
Message-ID: <a822b44b-68ac-4383-b837-623dc86c8882@quicinc.com>
Date:   Sun, 12 Nov 2023 11:59:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] bus: mhi: host: add new interfaces to handle MHI
 channels directly
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231110102202.3168243-1-kvalo@kernel.org>
 <20231110102202.3168243-3-kvalo@kernel.org>
 <2cb885fa-ab21-dd54-22ff-d23abfc7ea03@quicinc.com>
From:   Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <2cb885fa-ab21-dd54-22ff-d23abfc7ea03@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B0Fr4Ed9EwO8y_ld4ylcMYJ1aK0J-M_I
X-Proofpoint-ORIG-GUID: B0Fr4Ed9EwO8y_ld4ylcMYJ1aK0J-M_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxlogscore=891
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311120034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11/11/2023 1:14 AM, Jeffrey Hugo wrote:
> On 11/10/2023 3:21 AM, Kalle Valo wrote:
>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>
>> When using mhi_power_down_no_destroy() MHI hosts need to unprepare 
>> MHI channels
>> by themselves.  Similarly, MHI stack will also not create new MHI 
>> device since
>> old devices were not destroyed, so MHI hosts need to prepare channels 
>> as well.
>> Hence add these two interfaces to make that possible.
>>
>> Tested-on: WCN6855 hw2.0 PCI 
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/main.c | 91 +++++++++++++++++++++++++++++++++++++
>>   include/linux/mhi.h         | 18 ++++++++
>>   2 files changed, 109 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index dcf627b36e82..9bcf8a49c000 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -1667,6 +1667,49 @@ int mhi_prepare_for_transfer_autoqueue(struct 
>> mhi_device *mhi_dev)
>>   }
>>   EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
>>   +static int __mhi_prepare_for_transfer_autoqueue(struct device 
>> *dev, void *data)
>> +{
>> +    struct mhi_device *mhi_dev;
>> +    struct mhi_chan *ul_chan, *dl_chan;
>> +    enum mhi_ee_type ee = MHI_EE_MAX;
>> +
>> +    if (dev->bus != &mhi_bus_type)
>> +        return 0;
>> +
>> +    mhi_dev = to_mhi_device(dev);
>> +
>> +    /* Only prepare virtual devices thats attached to bus */
>
> "that are"?
>
It means MHI devices with a type of MHI_DEVICE_XFER. See also 
mhi_destroy_device();


>> +    if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>> +        return 0;
>> +
>> +    ul_chan = mhi_dev->ul_chan;
>> +    dl_chan = mhi_dev->dl_chan;
>> +
>> +    /*
>> +     * If execution environment is specified, remove only those 
>> devices that
>> +     * started in them based on ee_mask for the channels as we move 
>> on to a
>> +     * different execution environment
>> +     */
>> +    if (data)
>> +        ee = *(enum mhi_ee_type *)data;
>> +
>> +    if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
>> +        return 0;
>> +
>> +
>> +    if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
>> +        return 0;
>> +
>> +    return mhi_prepare_for_transfer_autoqueue(mhi_dev);
>> +}
>> +
>> +int mhi_prepare_all_for_transfer_autoqueue(struct mhi_controller 
>> *mhi_cntrl)
>> +{
>> +    return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
>> +                     __mhi_prepare_for_transfer_autoqueue);
>> +}
>> +EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer_autoqueue);
>
> This seems broken.  It appears to configure all channels as autoqueue, 
> regardless of how the controller initially configured them.  This 
> would only be safe to use if all channels were configured for 
> autoqueue, but would silently cause issues otherwise.

Thanks for pointing that. Yes, it is not correct to treat all channels 
as autoqueue regardless of its initial configuration. So how about 
change as below:

/* The difference between mhi_prepare_for_transfer_autoqueue() and 
mhi_prepare_for_transfer() comes from how to treat downlink channel */

mhi_prepare_for_transfer_dev(struct device *dev, ...)

{

...

dl_chan = mhi_dev->dl_chan;

...

if (dl_chan->pre_alloc)

        mhi_prepare_for_transfer_autoqueue(dev);

else

        mhi_prepare_for_transfer(dev);

}

/* And then iterate all devices and call mhi_prepare_for_transfer_dev() 
for each. */

int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl)
{
     return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
                      mhi_prepare_for_transfer_dev);
}
EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer);

