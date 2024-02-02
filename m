Return-Path: <linux-wireless+bounces-3007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB6846E40
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9151F2AE9C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AEA7A73D;
	Fri,  2 Feb 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C48MimFk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4677A732;
	Fri,  2 Feb 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870974; cv=none; b=DCfyjGMag+pc1pmKhqd9QoXYUNp8CET1NRmJWUD1QZbiML3WMv6t1wl1Jy/vYVQYhaYPTNFmOWPYAJk33eW26m8Oe1xvGYM5528GTtPmGnqZ0gcUKWsfcOHKC5LMpr74HsUL26NPPMeskqA+0kNB167elNVhoCegom5e2BCBLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870974; c=relaxed/simple;
	bh=9ZBBSAXrt6kWsx+eqpSYCzasMCfGvJqFbv5Xmg39tzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gk8ruqLSjJVfMOLXbcbioNOc8ZPvW4wG0SeGWthv9LOm72TK02RapYjHD+0jloO2yOl6pwSUUmc4zdplADkSi3iy3mC5M6oBfzNdG7UaelQQcX3IFGZAdVnQgjjiYPVtA9AS/35mLxb7aBMDaz9HidCGG5DM21aVHCEWok9rB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C48MimFk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4128KCue020122;
	Fri, 2 Feb 2024 10:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=r/vYhl3PQI50RWcwzVPq43BmiasixwPxSX7bPMzn85g=; b=C4
	8MimFkG5Abofw3x3Bi8zINHWPAzBOjW/SrpzLL8+fO7HKIBnqicCgxcD5d7rnYoP
	MGfvGsE9+MdWPEQ0cK+rsqDmHMQElSZ17t7W+P5CSoSoWMom6tMNwhfQ1KxWJOVl
	2wNpscxqcppyOqBJhFLuYUAP9z7zROzE54j4Vg79uEM34Br6y5PjMlEZuzCJ4EGx
	YrCyAdD4r3+5kKDHfiK+ECEhWmqsVwIW9TLPHoG7pxFxAmUJ4W+Z8GAUUU3Xguei
	z4hXYJmzmPIoCguj+GKpzVvnAudN4IPq0kgAsySlQ1ioov2M/XG2FComRHHR74tw
	paWxP2qcHvcgB9CBvo8w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptw960j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 10:49:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412AnNJ6007090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 10:49:23 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 02:49:22 -0800
Message-ID: <34e80f19-8804-4505-b134-f099e087b53e@quicinc.com>
Date: Fri, 2 Feb 2024 18:49:19 +0800
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
 <07668be1-8366-43b5-83ca-bf66d0d8087b@quicinc.com>
 <20240202071011.GA2961@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240202071011.GA2961@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mmzq7vdMjELr0zlhXlzEPAkV6tyKqmrK
X-Proofpoint-GUID: Mmzq7vdMjELr0zlhXlzEPAkV6tyKqmrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=740 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020078



On 2/2/2024 3:10 PM, Manivannan Sadhasivam wrote:
> On Fri, Feb 02, 2024 at 02:42:58PM +0800, Baochen Qiang wrote:
>>
>>
>> On 2/1/2024 6:00 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Jan 31, 2024 at 03:39:26PM +0800, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 1/31/2024 2:19 AM, Manivannan Sadhasivam wrote:
>>>>> On Mon, Nov 27, 2023 at 06:20:16PM +0200, Kalle Valo wrote:
>>>>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>>>
>>>>>> When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
>>>>>> by themselves.  Similarly, MHI stack will also not create new MHI device since
>>>>>> old devices were not destroyed, so MHI hosts need to prepare channels as well.
>>>>>> Hence add these two interfaces to make that possible.
>>>>>>
>>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>>>
>>>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>>>> ---
>>>>>>     drivers/bus/mhi/host/main.c | 107 ++++++++++++++++++++++++++++++++++++
>>>>>>     include/linux/mhi.h         |  20 ++++++-
>>>>>>     2 files changed, 126 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>>>>> index d80975f4bba8..3f677fc628ad 100644
>>>>>> --- a/drivers/bus/mhi/host/main.c
>>>>>> +++ b/drivers/bus/mhi/host/main.c
>>>>>> @@ -1669,6 +1669,58 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
>>>>>> +static int ____mhi_prepare_for_transfer(struct device *dev, void *data)
>>>>>
>>>>> "__mhi_prepare_all_for_transfer"
>>>>
>>>> This is to prepare one single child device, I don't think a name like
>>>> __mhi_prepare_all_for_transfer (with 'all' inside) make sense, right?
>>>> How about changing to "mhi_prepare_dev_for_transfer" or
>>>> "mhi_prepare_single_for_transfer"?
>>>>
>>>
>>> I think most of the checks in this function can be moved inside
>>> mhi_prepare_for_transfer() API. With that you can just reuse the API without
>>> adding a new helper.
>>>
>>> For autoqueue channels, you can add another API
>>> mhi_prepare_all_for_transfer_autoqueue() just like
>>> mhi_prepare_for_transfer_autoqueue() to maintain uniformity.
>>>
>>> - Mani
>> If we do that, we need to call two APIs together, does it make sense? From
>> the view of an MHI user, what we want is an API to prepare all channels, no
>> matter whether a channel is configured as autoqueue or non-autoqueue, we
>> don't care about it.
>>
> 
> You are calling this API from a wrong place first up.
> mhi_{prepare/unprepare}_transfer* APIs are meant to be used by the client
> drivers like QRTR. Controller drivers should not call them.
> 
> What you need here is the hibernation support for QRTR itself and call these
> APIs from there.

OK, I got your point. QRTR is the right place to manage MHI channels, 
not ath11k it self.
And we even don't need these two APIs if change to do it in QRTR.

> 
>> And besides, I don't think there is a scenario where we need to use them
>> separately. So if we always need to use them together, why not merge them in
>> a single API?
>>
> 
> A single controller driver may expose multiple channels and those will bind to
> multiple client drivers. So only the client drivers should manage the channels,
> not the controller drivers themselves.
Exactly.

Great thanks for the proposal, Mani. Will change accordingly in next 
version.

> 
> - Mani
> 
>>>
>>>>>
>>>>>> +{
>>>>>> +	struct mhi_device *mhi_dev;
>>>>>> +	struct mhi_chan *ul_chan, *dl_chan;
>>>>>> +	enum mhi_ee_type ee = MHI_EE_MAX;
>>>>>
>>>>> Reverse Xmas order, please.
>>>>>
>>>>>> +
>>>>>> +	if (dev->bus != &mhi_bus_type)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	mhi_dev = to_mhi_device(dev);
>>>>>> +
>>>>>> +	/* Only prepare virtual devices that are attached to bus */
>>>>>
>>>>> "Only prepare virtual devices for the channels". Here and below.
>>>>>
>>>>>> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* There are cases where there is no MHI client driver matches
>>>>>> +	 * this device, we are not allowed to do prepare for it.
>>>>>> +	 */
>>>>>
>>>>> Use the preferred style for comment:
>>>>>
>>>>> 	/*
>>>>> 	 * ...
>>>>> 	 */
>>>>>
>>>>>> +	if (!mhi_dev->id)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	ul_chan = mhi_dev->ul_chan;
>>>>>> +	dl_chan = mhi_dev->dl_chan;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * If execution environment is specified, remove only those devices that
>>>>>> +	 * started in them based on ee_mask for the channels as we move on to a
>>>>>> +	 * different execution environment
>>>>>> +	 */
>>>>>> +	if (data)
>>>>>> +		ee = *(enum mhi_ee_type *)data;
>>>>>> +
>>>>>> +	if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +
>>>>>
>>>>> Remove extra newline.
>>>>>
>>>>>> +	if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	if (dl_chan->pre_alloc)
>>>>>> +		return mhi_prepare_for_transfer_autoqueue(mhi_dev);
>>>>>> +	else
>>>>>> +		return mhi_prepare_for_transfer(mhi_dev);
>>>>>> +}
>>>>>> +
>>>>>> +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl)
>>>>>> +{
>>>>>> +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
>>>>>> +				     ____mhi_prepare_for_transfer);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer);
>>>>>> +
>>>>>>     void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>>>>>>     {
>>>>>>     	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>>>>>> @@ -1684,3 +1736,58 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>>>>>>     	}
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
>>>>>> +
>>>>>> +static int ____mhi_unprepare_from_transfer(struct device *dev, void *data)
>>>>>
>>>>> __mhi_unprepare_all_from_transfer
>>>>
>>>> same as above.
>>>>
>>>>>
>>>>>> +{
>>>>>> +	struct mhi_device *mhi_dev;
>>>>>> +	struct mhi_chan *ul_chan, *dl_chan;
>>>>>> +	enum mhi_ee_type ee = MHI_EE_MAX;
>>>>>> +
>>>>>> +	if (dev->bus != &mhi_bus_type)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	mhi_dev = to_mhi_device(dev);
>>>>>> +
>>>>>> +	/* Only unprepare virtual devices that are attached to bus */
>>>>>> +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	/* There are cases where there is no MHI client driver matches
>>>>>> +	 * this device, so it is not probed or prepared, no need to
>>>>>> +	 * do unprepare for it.
>>>>>> +	 */
>>>>>> +	if (!mhi_dev->id)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	ul_chan = mhi_dev->ul_chan;
>>>>>> +	dl_chan = mhi_dev->dl_chan;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * If execution environment is specified, remove only those devices that
>>>>>> +	 * started in them based on ee_mask for the channels as we move on to a
>>>>>> +	 * different execution environment
>>>>>> +	 */
>>>>>> +	if (data)
>>>>>> +		ee = *(enum mhi_ee_type *)data;
>>>>>> +
>>>>>> +	if (ul_chan) {
>>>>>> +		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
>>>>>> +			return 0;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (dl_chan) {
>>>>>> +		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
>>>>>> +			return 0;
>>>>>> +	}
>>>>>> +
>>>>>> +	mhi_unprepare_from_transfer(mhi_dev);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl)
>>>>>> +{
>>>>>> +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
>>>>>> +				     ____mhi_unprepare_from_transfer);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(mhi_unprepare_all_from_transfer);
>>>>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>>>>>> index ae092bc8b97e..dcf62a57056a 100644
>>>>>> --- a/include/linux/mhi.h
>>>>>> +++ b/include/linux/mhi.h
>>>>>> @@ -668,7 +668,7 @@ static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool gracefu
>>>>>>      * destroy struct devices. This is a variant for mhi_power_down() and is a
>>>>>>      * workaround to make it possible to use mhi_power_up() in a resume
>>>>>>      * handler. When using this variant the caller must also call
>>>>>> - * mhi_prepare_all_for_transfer_autoqueue() and
>>>>>> + * mhi_prepare_all_for_transfer() and
>>>>>
>>>>> This change belongs to previous patch.
>>>>>
>>>>>>      * mhi_unprepare_all_from_transfer().
>>>>>>      *
>>>>>>      * @mhi_cntrl: MHI controller
>>>>>> @@ -842,4 +842,22 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
>>>>>>      */
>>>>>>     bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
>>>>>> +/**
>>>>>> + * mhi_prepare_all_for_transfer - if you are using
>>>>>> + * mhi_power_down_no_destroy() variant this needs to be called after
>>>>>> + * calling mhi_power_up().
>>>>>
>>>>> Add info about what this API does also.
>>>>>
>>>>>> + *
>>>>>> + * @mhi_cntrl: MHI controller
>>>>>> + */
>>>>>> +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl);
>>>>>> +
>>>>>> +/**
>>>>>> + * mhi_unprepare_all_from_transfer - if you are using
>>>>>> + * mhi_power_down_no_destroy() variant this function needs to be called
>>>>>> + * before calling mhi_power_down_no_destroy().
>>>>>
>>>>> Same as above.
>>>>>
>>>>> - Mani
>>>>>
>>>>>> + *
>>>>>> + * @mhi_cntrl: MHI controller
>>>>>> + */
>>>>>> +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl);
>>>>>> +
>>>>>>     #endif /* _MHI_H_ */
>>>>>> -- 
>>>>>> 2.39.2
>>>>>>
>>>>>>
>>>>>
>>>
> 

