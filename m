Return-Path: <linux-wireless+bounces-1143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8F81B4A4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3F4284F3C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD536A34B;
	Thu, 21 Dec 2023 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W7CGFNr9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A36720B;
	Thu, 21 Dec 2023 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL65DX8003047;
	Thu, 21 Dec 2023 11:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cwyLE3ONTL0QWnPBxD1H4N27lQJtWFsVt/zVs1TVX+w=; b=W7
	CGFNr9Bq1Fg262PU8MyeHVVZVfvPKPuJvk/pBsuXk3RECnUthc0K6RRaEbAobvmd
	DcK1CASMbrlRAoEWW/VDWkgoD1bW8Es4Vlp/1OO8Bv3cJGxF/2e/CL1T2C1PtSgt
	Kvyb8Nz4ZtIN0O2UXUPT4uCt20PofoNIXKdbr9rmOlbcbZh8/jx0wMl6WlkSKJi2
	ckFQnvltvt9tbPliNJsb8puPgoc1IcYimE0p0a0FDsvpX/R904Eod1dv+YJobQvf
	Fv/DzwRLSBtD48G8eyFXO9Armj14/gtk53pOD7omD4BuwuHhEQuHmmQFTKMpkqQD
	NRqCKSZTz2LtFQTEFPpA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4eg9hehx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 11:05:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLB5Eu0025252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 11:05:14 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 03:05:12 -0800
Message-ID: <7a31696b-cf2b-48c0-bad3-327e9ce47172@quicinc.com>
Date: Thu, 21 Dec 2023 19:05:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/8] bus: mhi: host: add
 mhi_power_down_no_destroy()
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: <mhi@lists.linux.dev>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-2-kvalo@kernel.org> <20231130054250.GC3043@thinkpad>
 <87v89cq1ci.fsf@kernel.org> <20231220163209.GJ3544@thinkpad>
 <20231220165113.GK3544@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20231220165113.GK3544@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HWLgVgY4eUPgeBZ-9OOk4Ifvy6beLB3e
X-Proofpoint-ORIG-GUID: HWLgVgY4eUPgeBZ-9OOk4Ifvy6beLB3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312210082



On 12/21/2023 12:51 AM, Manivannan Sadhasivam wrote:
> On Wed, Dec 20, 2023 at 10:02:25PM +0530, Manivannan Sadhasivam wrote:
>> On Tue, Dec 05, 2023 at 02:29:33PM +0200, Kalle Valo wrote:
>>> Manivannan Sadhasivam <mani@kernel.org> writes:
>>>
>>>> On Mon, Nov 27, 2023 at 06:20:15PM +0200, Kalle Valo wrote:
>>>>
>>>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>>
>>>>> If ath11k tries to call mhi_power_up() during resume it fails:
>>>>>
>>>>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>>>>>
>>>>> This happens because when calling mhi_power_up() the MHI subsystem eventually
>>>>> calls device_add() from mhi_create_devices() but the device creation is
>>>>> deferred:
>>>>>
>>>>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>>>>>
>>>>> The reason for deferring device creation is explained in dpm_prepare():
>>>>>
>>>>> 	/*
>>>>> 	 * It is unsafe if probing of devices will happen during suspend or
>>>>> 	 * hibernation and system behavior will be unpredictable in this case.
>>>>> 	 * So, let's prohibit device's probing here and defer their probes
>>>>> 	 * instead. The normal behavior will be restored in dpm_complete().
>>>>> 	 */
>>>>>
>>>>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
>>>>> qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:
>>>>>
>>>>> static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
>>>>> 				      struct mhi_result *mhi_res)
>>>>> {
>>>>> 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
>>>>> 	int rc;
>>>>>
>>>>> 	if (!qdev || mhi_res->transaction_status)
>>>>> 		return;
>>>>>
>>>>> So what this means that QRTR is not delivering messages and the QMI connection
>>>>> is not working between ath11k and the firmware, resulting a failure in firmware
>>>>> initialisation.
>>>>>
>>>>> To fix this add new function mhi_power_down_no_destroy() which does not destroy
>>>>> the devices during power down. This way mhi_power_up() can be called during
>>>>> resume and we can get ath11k hibernation working with the following patches.
>>>>>
>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>>
>>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>>
>>>> Any reason for reposting this series without discussing the suggestion from
>>>> Mayank?
>>>
>>> Baochen quickly sent me fixes for the v1 review comments, as I have been
>>> out of office for some time I didn't want to sit on Baochen's fixes for
>>> too long. Better to get them out of the door as soon as possible. I will
>>> definitely look at Mayank's proposal but that will take longer.
>>>
>>>> As I said in the internal thread, this patch breaks the Linux device
>>>> driver model by not destroying the "struct device" when the actual
>>>> device gets removed.
>>>
>>> This patchset has been tested by several people, I'm even using this
>>> patchset on main laptop every day, and we haven't noticed any issues.
>>>
>>> Can you elaborate more about this driver model? We are not removing any
>>> ath11k devices, we just want to power down the ath11k (and in the future
>>> ath12k) devices for suspend and power up during resume.
>>>
>>
>> Devices (struct dev) for each channels are created once the device (WLAN) enters
>> runtime mode such as (MISSION, SBL etc...). During hibernation, ath11k stack
>> calls mhi_power_down() which essentially resets the device to POR and also the
>> stack powers down the device properly.
>>
>> In that case, MHI channels do not exist as the device (WLAN) itself is powered
>> down. As per kernel driver model, each struct device is tied to its reference
>> count. And the reference count should be decremented whenever the actual device
>> is not in use. Once the actual device is removed from the system, then the
>> respective struct device has to be destroyed altogether.
>>
>> So in this case, even though the channels are not active (present) in the
>> device, the device itself gets powered off, you want MHI stack to keep the
>> struct device active, which is against the model I referenced above.
>>
>> To fix this issue properly, we need to investigate on how other subsystems are
>> handling this situation (device getting powered down during hibernation), like
>> USB.
>>
> 
> To me it all sounds like the probe deferral is not handled properly in mac80211
> stack. As you mentioned in the commit message that the dpm_prepare() blocks
> probing of devices. It gets unblocked and trigerred in dpm_complete():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/main.c#n1131
> 
> So if mac80211/ath11k cannot probe the devices at the dpm_complete() stage, then
> it is definitely an issue that needs to be fixed properly.
To clarify, ath11k CAN probe the devices at dpm_complete() stage. The 
problem is kernel does not wait for all probes to finish, and in that 
way we will face the issue that user space applications are likely to 
fail because they get thawed BEFORE WLAN is ready.

> 
> - Mani
> 
>> - Mani
>>
>>>> We should try to explore alternate options instead of persisting with
>>>> this solution.
>>>
>>> What other options we have here? At least Baochen is not optimistic that
>>> using PM_POST_HIBERNATION as a workaround would work. The issue we have
>>> here is that mhi_power_up() doesn't work in the resume handler and
>>> that's what we should try to fix, not make workarounds.
>>>
>>> -- 
>>> https://patchwork.kernel.org/project/linux-wireless/list/
>>>
>>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
> 

