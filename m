Return-Path: <linux-wireless+bounces-2995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D584685F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 07:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F779B26EBE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3018635;
	Fri,  2 Feb 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GraVUJlr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4023FB09;
	Fri,  2 Feb 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856197; cv=none; b=LD8gc7MjMqRQjq0diSl82suKVAoPL+Wg55YPOHoQLsST0ACVCIxEfY4KHnQcU2Qjdd+qXV5hNj5uyeQ+FUZ/s6GhWeyzKDf7KQ3AChhY70EJs2qJg69UQvNPw9Jx6B3LOTVBoBvhsaXYKghUK6B5HLqrPuY0evfbe5M7K05FhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856197; c=relaxed/simple;
	bh=mmlc8p8smhEKnKiYd+av/xpaD/zOATj/BRUaWFx+7ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZuOPu2VN9G5U9jBn6c52xikSKnCciEBRfCV8UO8avzykJSlXNvY9S5qx0O8/10J1JlIsLRojnYdevJC1uXA6rxVdb+s2APtFWQ3jykYKsIgE9VN+kgMFzLW06qVvULR4cKpyKRlpuk/9Jq/n76IYK3UZBotyFM3MB3J/dGAG90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GraVUJlr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124StBF009248;
	Fri, 2 Feb 2024 06:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VQ21D6DYaEzTRzM+PTQY/6FppcYBpN3bpSpWebxCWZg=; b=Gr
	aVUJlrq8OQ3EfLXr4AcHumjuzTMrAobbBU5j4nepN081z35HfBVn1VEQX30K0la7
	/NwNcEwq2eQG2pgRGNyUZvBWLFBU4A3Rpa1gOuRFHXeM1NJF+ou9qPdgxUp5X7WR
	LrwbBSUw4VmAlrlRlQwMQ8fE9ocQchLUSs6qTr9Vw9u34CrTmidyBZWRZ0GpGh+p
	XpeoB1YXdQ0cF/0KNReP547/nsYH6ThP4MFIssaWRC2FHT9yQ3T1H6GoU1VKQStm
	gguFOXO6H1X1UixV1370o5sPz3GUu0KVetS2UD1+eXAfbxT9gLqb7HleoqcbXMUQ
	bldVgWMZIfqiJYLNrJtQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1rnjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:43:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126h2Nn016933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:43:02 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 22:43:00 -0800
Message-ID: <07668be1-8366-43b5-83ca-bf66d0d8087b@quicinc.com>
Date: Fri, 2 Feb 2024 14:42:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/8] bus: mhi: host: add new interfaces to handle
 MHI channels directly
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-3-kvalo@kernel.org> <20240130181938.GB4218@thinkpad>
 <d002afe9-3c01-413c-82d2-353db0356802@quicinc.com>
 <20240201100040.GB17027@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240201100040.GB17027@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YvUoWlUF-buj43Pb1CTbil_0bQoAofEp
X-Proofpoint-ORIG-GUID: YvUoWlUF-buj43Pb1CTbil_0bQoAofEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=773 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047



On 2/1/2024 6:00 PM, Manivannan Sadhasivam wrote:
> On Wed, Jan 31, 2024 at 03:39:26PM +0800, Baochen Qiang wrote:
>>
>>
>> On 1/31/2024 2:19 AM, Manivannan Sadhasivam wrote:
>>> On Mon, Nov 27, 2023 at 06:20:16PM +0200, Kalle Valo wrote:
>>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>
>>>> When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
>>>> by themselves.  Similarly, MHI stack will also not create new MHI device since
>>>> old devices were not destroyed, so MHI hosts need to prepare channels as well.
>>>> Hence add these two interfaces to make that possible.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>
>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>> ---
>>>>    drivers/bus/mhi/host/main.c | 107 ++++++++++++++++++++++++++++++++++++
>>>>    include/linux/mhi.h         |  20 ++++++-
>>>>    2 files changed, 126 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>> index d80975f4bba8..3f677fc628ad 100644
>>>> --- a/drivers/bus/mhi/host/main.c
>>>> +++ b/drivers/bus/mhi/host/main.c
>>>> @@ -1669,6 +1669,58 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
>>>> +static int ____mhi_prepare_for_transfer(struct device *dev, void *data)
>>>
>>> "__mhi_prepare_all_for_transfer"
>>
>> This is to prepare one single child device, I don't think a name like
>> __mhi_prepare_all_for_transfer (with 'all' inside) make sense, right?
>> How about changing to "mhi_prepare_dev_for_transfer" or
>> "mhi_prepare_single_for_transfer"?
>>
> 
> I think most of the checks in this function can be moved inside
> mhi_prepare_for_transfer() API. With that you can just reuse the API without
> adding a new helper.
> 
> For autoqueue channels, you can add another API
> mhi_prepare_all_for_transfer_autoqueue() just like
> mhi_prepare_for_transfer_autoqueue() to maintain uniformity.
> 
> - Mani
If we do that, we need to call two APIs together, does it make sense? 
 From the view of an MHI user, what we want is an API to prepare all 
channels, no matter whether a channel is configured as autoqueue or 
non-autoqueue, we don't care about it.

And besides, I don't think there is a scenario where we need to use them 
separately. So if we always need to use them together, why not merge 
them in a single API?

> 
>>>
>>>> +{
>>>> +	struct mhi_device *mhi_dev;
>>>> +	struct mhi_chan *ul_chan, *dl_chan;
>>>> +	enum mhi_ee_type ee = MHI_EE_MAX;
>>>
>>> Reverse Xmas order, please.
>>>
>>>> +
>>>> +	if (dev->bus != &mhi_bus_type)
>>>> +		return 0;
>>>> +
>>>> +	mhi_dev = to_mhi_device(dev);
>>>> +
>>>> +	/* Only prepare virtual devices that are attached to bus */
>>>
>>> "Only prepare virtual devices for the channels". Here and below.
>>>
>>>> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>>>> +		return 0;
>>>> +
>>>> +	/* There are cases where there is no MHI client driver matches
>>>> +	 * this device, we are not allowed to do prepare for it.
>>>> +	 */
>>>
>>> Use the preferred style for comment:
>>>
>>> 	/*
>>> 	 * ...
>>> 	 */
>>>
>>>> +	if (!mhi_dev->id)
>>>> +		return 0;
>>>> +
>>>> +	ul_chan = mhi_dev->ul_chan;
>>>> +	dl_chan = mhi_dev->dl_chan;
>>>> +
>>>> +	/*
>>>> +	 * If execution environment is specified, remove only those devices that
>>>> +	 * started in them based on ee_mask for the channels as we move on to a
>>>> +	 * different execution environment
>>>> +	 */
>>>> +	if (data)
>>>> +		ee = *(enum mhi_ee_type *)data;
>>>> +
>>>> +	if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
>>>> +		return 0;
>>>> +
>>>> +
>>>
>>> Remove extra newline.
>>>
>>>> +	if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
>>>> +		return 0;
>>>> +
>>>> +	if (dl_chan->pre_alloc)
>>>> +		return mhi_prepare_for_transfer_autoqueue(mhi_dev);
>>>> +	else
>>>> +		return mhi_prepare_for_transfer(mhi_dev);
>>>> +}
>>>> +
>>>> +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl)
>>>> +{
>>>> +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
>>>> +				     ____mhi_prepare_for_transfer);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer);
>>>> +
>>>>    void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>>>>    {
>>>>    	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>>>> @@ -1684,3 +1736,58 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>>>>    	}
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
>>>> +
>>>> +static int ____mhi_unprepare_from_transfer(struct device *dev, void *data)
>>>
>>> __mhi_unprepare_all_from_transfer
>>
>> same as above.
>>
>>>
>>>> +{
>>>> +	struct mhi_device *mhi_dev;
>>>> +	struct mhi_chan *ul_chan, *dl_chan;
>>>> +	enum mhi_ee_type ee = MHI_EE_MAX;
>>>> +
>>>> +	if (dev->bus != &mhi_bus_type)
>>>> +		return 0;
>>>> +
>>>> +	mhi_dev = to_mhi_device(dev);
>>>> +
>>>> +	/* Only unprepare virtual devices that are attached to bus */
>>>> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>>>> +		return 0;
>>>> +
>>>> +	/* There are cases where there is no MHI client driver matches
>>>> +	 * this device, so it is not probed or prepared, no need to
>>>> +	 * do unprepare for it.
>>>> +	 */
>>>> +	if (!mhi_dev->id)
>>>> +		return 0;
>>>> +
>>>> +	ul_chan = mhi_dev->ul_chan;
>>>> +	dl_chan = mhi_dev->dl_chan;
>>>> +
>>>> +	/*
>>>> +	 * If execution environment is specified, remove only those devices that
>>>> +	 * started in them based on ee_mask for the channels as we move on to a
>>>> +	 * different execution environment
>>>> +	 */
>>>> +	if (data)
>>>> +		ee = *(enum mhi_ee_type *)data;
>>>> +
>>>> +	if (ul_chan) {
>>>> +		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
>>>> +			return 0;
>>>> +	}
>>>> +
>>>> +	if (dl_chan) {
>>>> +		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
>>>> +			return 0;
>>>> +	}
>>>> +
>>>> +	mhi_unprepare_from_transfer(mhi_dev);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl)
>>>> +{
>>>> +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
>>>> +				     ____mhi_unprepare_from_transfer);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(mhi_unprepare_all_from_transfer);
>>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>>>> index ae092bc8b97e..dcf62a57056a 100644
>>>> --- a/include/linux/mhi.h
>>>> +++ b/include/linux/mhi.h
>>>> @@ -668,7 +668,7 @@ static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool gracefu
>>>>     * destroy struct devices. This is a variant for mhi_power_down() and is a
>>>>     * workaround to make it possible to use mhi_power_up() in a resume
>>>>     * handler. When using this variant the caller must also call
>>>> - * mhi_prepare_all_for_transfer_autoqueue() and
>>>> + * mhi_prepare_all_for_transfer() and
>>>
>>> This change belongs to previous patch.
>>>
>>>>     * mhi_unprepare_all_from_transfer().
>>>>     *
>>>>     * @mhi_cntrl: MHI controller
>>>> @@ -842,4 +842,22 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>>>>     */
>>>>    bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
>>>> +/**
>>>> + * mhi_prepare_all_for_transfer - if you are using
>>>> + * mhi_power_down_no_destroy() variant this needs to be called after
>>>> + * calling mhi_power_up().
>>>
>>> Add info about what this API does also.
>>>
>>>> + *
>>>> + * @mhi_cntrl: MHI controller
>>>> + */
>>>> +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl);
>>>> +
>>>> +/**
>>>> + * mhi_unprepare_all_from_transfer - if you are using
>>>> + * mhi_power_down_no_destroy() variant this function needs to be called
>>>> + * before calling mhi_power_down_no_destroy().
>>>
>>> Same as above.
>>>
>>> - Mani
>>>
>>>> + *
>>>> + * @mhi_cntrl: MHI controller
>>>> + */
>>>> +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl);
>>>> +
>>>>    #endif /* _MHI_H_ */
>>>> -- 
>>>> 2.39.2
>>>>
>>>>
>>>
> 

