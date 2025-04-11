Return-Path: <linux-wireless+bounces-21434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE1A856D9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A993C7B2CAE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2809293B77;
	Fri, 11 Apr 2025 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IKwoNSg0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A46189B84;
	Fri, 11 Apr 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360784; cv=none; b=q6miVDS1dLTnbvC8GKkHV3IsFlCGaHELT7ObGBRjyogsK/pX8psQS7PgLpbkK1Dgd2WK1fZv/466ZdeVdzVvlrjRYJzHTbO/APePXrkCwL4UIyVXTeu2Vh1YbJMyFVvSoYu7bSf4j8uO9PnI6QlkEPKLOIMdNSfuqvXk2Ku7Fcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360784; c=relaxed/simple;
	bh=cvUnRLkTQUNK6LV3f7i9nx8RlpjLVwCmjS8uqBMZ8ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DLj5JNG6AcuQa5KqwmrGMFAc5FJdWaKBfrYWh9iycvNF2kvbPDQISfxFjbGzIFInT3GdCh8je7e28KYNoqRM+olx2kjMb7zrCjtOCvTEYwNeL7bpueP7UESZy0BSxCrHY2/v6tJB28wfyhq99lnJgMiToJamVMIFEI1O4Nf+CWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IKwoNSg0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5KCDw019674;
	Fri, 11 Apr 2025 08:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TCWt6WEw4JDv4PZNtQ1EhUmj7iwZw5s+q6V6H91MTGg=; b=IKwoNSg0cR9IM1pt
	s/Rqqu+HBCKo7lDy8Zp615QYBYJzLuWnIV0QTEKNGZvqwWgI+YttBC24NNspN6Go
	/skFVWYbIU/wZOSClM9NREms9hJ9FdDKgDoRkrwwMI/MsK2K7CJFou5MmAgtGvsU
	dOhEHSNgzrb4/lJR7pE5TUfGoCSCmrAXI1BlOo6Ws5Fsbd0POxTwK5bQm/dOfzqn
	4fkESsFdFwBrtpUiCvfFhR2RtP8p5zp1yZrERl2VVBDsnPkOX2rnNjIpUPmjflCL
	wvN5JxNqOgUhskuvgDOkL++t8plMn9J8UPwNiwqw+9yMi6Bc64zVLGE//Q4XVEyH
	9FSp5w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrsxdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:39:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B8dKf6006316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:39:20 GMT
Received: from [10.216.48.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Apr
 2025 01:39:14 -0700
Message-ID: <e0159cb8-fe21-7f71-1ebe-744ed26bd698@quicinc.com>
Date: Fri, 11 Apr 2025 14:09:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Youssef Samir
	<quic_yabdulra@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder
	<elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kunwu
 Chan" <chentao@kylinos.cn>
CC: <kernel@collabora.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
 <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5b03attd76ZLwvjFA-XltP6v--DKUWgN
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f8d53a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QX4gbG5DAAAA:8 a=vUAfYKqKNF1bBtrGfecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: 5b03attd76ZLwvjFA-XltP6v--DKUWgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110049



On 4/11/2025 12:32 PM, Muhammad Usama Anjum wrote:
> On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>> allocation. There is a crash report where at resume time, the memory
>>> from the dma doesn't get allocated and MHI fails to re-initialize.
>>> There may be fragmentation of some kind which fails the allocation
>>> call.
>>>
>>> To fix it, don't free the memory at power down during suspend /
>>> hibernation. Instead, use the same allocated memory again after every
>>> resume / hibernation. This patch has been tested with resume and
>>> hibernation both.
>>>
>>> The rddm is of constant size for a given hardware. While the fbc_image
>>> size depends on the firmware. If the firmware changes, we'll free and
>> If firmware image will change between suspend and resume ?
> Yes, correct.
> 
why the firmware image size will change between suspend & resume?
who will update the firmware image after bootup?
It is not expected behaviour.

- Krishna chaitanya.
>>> allocate new memory for it.
>>>
>>> Here are the crash logs:
>>>
>>> [ 3029.338587] mhi mhi0: Requested to power ON
>>> [ 3029.338621] mhi mhi0: Power on setup success
>>> [ 3029.668654] kworker/u33:8: page allocation failure: order:7,
>>> mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>>> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted
>>> 6.11.11-valve10-1-neptune-611-gb69e902b4338
>>> #1ed779c892334112fb968aaa3facf9686b5ff0bd7
>>> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112
>>> 08/01/2024
>>> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
>>> [ 3029.668717] Call Trace:
>>> [ 3029.668722]  <TASK>
>>> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
>>> [ 3029.668738]  warn_alloc+0x164/0x190
>>> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
>>> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
>>> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
>>> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
>>> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
>>> [ 3029.668790]  dma_direct_alloc+0x70/0x270
>>> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi
>>> faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>>> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi
>>> faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>>> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi
>>> faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>>> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
>>> [ 3029.668853]  process_one_work+0x17e/0x330
>>> [ 3029.668861]  worker_thread+0x2ce/0x3f0
>>> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
>>> [ 3029.668873]  kthread+0xd2/0x100
>>> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
>>> [ 3029.668885]  ret_from_fork+0x34/0x50
>>> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
>>> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
>>> [ 3029.668910]  </TASK>
>>>
>>> Tested-on: QCNFA765 WLAN.HSP.1.1-03926.13-
>>> QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes sice v1:
>>> - Don't free bhie tables during suspend/hibernation only
>>> - Handle fbc_image changed size correctly
>>> - Remove fbc_image getting set to NULL in *free_bhie_table()
>>> ---
>>>    drivers/bus/mhi/host/boot.c           | 15 +++++++++++----
>>>    drivers/bus/mhi/host/init.c           | 13 ++++++++++---
>>>    drivers/net/wireless/ath/ath11k/mhi.c |  9 +++++----
>>>    include/linux/mhi.h                   |  7 +++++++
>>>    4 files changed, 33 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>>> index 9dcc7184817d5..0df26100c8f9c 100644
>>> --- a/drivers/bus/mhi/host/boot.c
>>> +++ b/drivers/bus/mhi/host/boot.c
>>> @@ -487,10 +487,17 @@ void mhi_fw_load_handler(struct mhi_controller
>>> *mhi_cntrl)
>>>         * device transitioning into MHI READY state
>>>         */
>>>        if (mhi_cntrl->fbc_download) {
>>> -        ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
>>> fw_sz);
>>> -        if (ret) {
>>> -            release_firmware(firmware);
>>> -            goto error_fw_load;
>>> +        if (mhi_cntrl->fbc_image && fw_sz != mhi_cntrl->prev_fw_sz) {
>>> +            mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
>>> +            mhi_cntrl->fbc_image = NULL;
>>> +        }
>>> +        if (!mhi_cntrl->fbc_image) {
>>> +            ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl-
>>>> fbc_image, fw_sz);
>>> +            if (ret) {
>>> +                release_firmware(firmware);
>>> +                goto error_fw_load;
>>> +            }
>>> +            mhi_cntrl->prev_fw_sz = fw_sz;
>>>            }
>>>              /* Load the firmware into BHIE vec table */
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index a9b1f8beee7bc..09b946b86ac46 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -1173,8 +1173,9 @@ int mhi_prepare_for_power_up(struct
>>> mhi_controller *mhi_cntrl)
>>>            /*
>>>             * Allocate RDDM table for debugging purpose if specified
>>>             */
>>> -        mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
>>> -                     mhi_cntrl->rddm_size);
>>> +        if (!mhi_cntrl->rddm_image)
>>> +            mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
>>> +                         mhi_cntrl->rddm_size);
>>>            if (mhi_cntrl->rddm_image) {
>>>                ret = mhi_rddm_prepare(mhi_cntrl,
>>>                               mhi_cntrl->rddm_image);
>>> @@ -1212,12 +1213,18 @@ void mhi_unprepare_after_power_down(struct
>>> mhi_controller *mhi_cntrl)
>>>            mhi_cntrl->rddm_image = NULL;
>>>        }
>>>    +    mhi_partial_unprepare_after_power_down(mhi_cntrl);
>>> +}
>>> +EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>>> +
>>> +void mhi_partial_unprepare_after_power_down(struct mhi_controller
>>> *mhi_cntrl)
>>> +{
>>>        mhi_cntrl->bhi = NULL;
>>>        mhi_cntrl->bhie = NULL;
>>>          mhi_deinit_dev_ctxt(mhi_cntrl);
>>>    }
>>> -EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>>> +EXPORT_SYMBOL_GPL(mhi_partial_unprepare_after_power_down);
>>>    
>> Instead of adding new API you can free memory from the unregister
>> controller also.
>>
>> - Krishna Chaitanya.
>>>    static void mhi_release_device(struct device *dev)
>>>    {
>>> diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/
>>> wireless/ath/ath11k/mhi.c
>>> index acd76e9392d31..f77cec79b5b80 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mhi.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mhi.c
>>> @@ -460,12 +460,13 @@ void ath11k_mhi_stop(struct ath11k_pci *ab_pci,
>>> bool is_suspend)
>>>         * workaround, otherwise ath11k_core_resume() will timeout
>>>         * during resume.
>>>         */
>>> -    if (is_suspend)
>>> +    if (is_suspend) {
>>>            mhi_power_down_keep_dev(ab_pci->mhi_ctrl, true);
>>> -    else
>>> +        mhi_partial_unprepare_after_power_down(ab_pci->mhi_ctrl);
>>> +    } else {
>>>            mhi_power_down(ab_pci->mhi_ctrl, true);
>>> -
>>> -    mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
>>> +        mhi_unprepare_after_power_down(ab_pci->mhi_ctrl);
>>> +    }
>>>    }
>>>      int ath11k_mhi_suspend(struct ath11k_pci *ab_pci)
>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>>> index 059dc94d20bb6..65a47c712b3a0 100644
>>> --- a/include/linux/mhi.h
>>> +++ b/include/linux/mhi.h
>>> @@ -382,6 +382,7 @@ struct mhi_controller {
>>>        const char *fw_image;
>>>        const u8 *fw_data;
>>>        size_t fw_sz;
>>> +    size_t prev_fw_sz;
>>>        const char *edl_image;
>>>        size_t rddm_size;
>>>        size_t sbl_size;
>>> @@ -662,6 +663,12 @@ void mhi_power_down_keep_dev(struct
>>> mhi_controller *mhi_cntrl, bool graceful);
>>>     */
>>>    void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl);
>>>    +/**
>>> + * mhi_partial_unprepare_after_power_down - Free any allocated memory
>>> after power down partially
>>> + * @mhi_cntrl: MHI controller
>>> + */
>>> +void mhi_partial_unprepare_after_power_down(struct mhi_controller
>>> *mhi_cntrl);
>>> +
>>>    /**
>>>     * mhi_pm_suspend - Move MHI into a suspended state
>>>     * @mhi_cntrl: MHI controller
> 
> 

