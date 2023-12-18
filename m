Return-Path: <linux-wireless+bounces-936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48A817749
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B591F2503D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBF4988B;
	Mon, 18 Dec 2023 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GHKQ48H/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D449887;
	Mon, 18 Dec 2023 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BICShi2013722;
	Mon, 18 Dec 2023 16:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oh6WOAgMbRlFvpoY5zeQ+UPwLxf/DsG3j8pELKI+vs4=; b=GH
	KQ48H/pOcKWoD9M+yHT0AyOscPmOOdMJ1vNdSTHZjaDXZiHaNQcmzUU0wIEEHIfd
	Wy/xrE+itM9sXS1AD0FbBFvdvUuC6yl5lYUluRkKI5hEaRX64+lVpHu2qkTKdltc
	mOn+OUNWOiHUPasKicRN6nBOQQq0Q2sXqk3qlRF70sdvlr0w/B+SezY3j+m5Ha/l
	yFp46fBJws6cwrWLo9BduJYnKY4mLJFWm22XHOFhw52CzTuDR+6cYwMcJWGDfY7m
	gJ3cpxlbjiX8zQcDkdyGT3dDbG8+uKSdcU1+8fbV+NHWEaaxcnA5jn0/HyPKTuTm
	JsfnIa9OajPWMjOH1BBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mfe0vpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:20:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIGK1Rd025655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:20:01 GMT
Received: from [10.110.4.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 08:19:57 -0800
Message-ID: <6cf3e5aa-411b-4c6c-a67b-6e61c1258b9c@quicinc.com>
Date: Mon, 18 Dec 2023 08:19:56 -0800
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
To: Kalle Valo <kvalo@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
        Mayank Rana <quic_mrana@quicinc.com>
CC: <mhi@lists.linux.dev>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        "kernel@quicinc.com" <kernel@quicinc.com>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-2-kvalo@kernel.org> <20231130054250.GC3043@thinkpad>
 <87v89cq1ci.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87v89cq1ci.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K4MNfyV7sWdzA1R_VX3VNoL1TKeXcZmS
X-Proofpoint-GUID: K4MNfyV7sWdzA1R_VX3VNoL1TKeXcZmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=876 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180120

On 12/5/2023 4:29 AM, Kalle Valo wrote:
> Manivannan Sadhasivam <mani@kernel.org> writes:
> 
>> On Mon, Nov 27, 2023 at 06:20:15PM +0200, Kalle Valo wrote:
>>
>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>
>>> If ath11k tries to call mhi_power_up() during resume it fails:
>>>
>>> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
>>>
>>> This happens because when calling mhi_power_up() the MHI subsystem eventually
>>> calls device_add() from mhi_create_devices() but the device creation is
>>> deferred:
>>>
>>> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
>>>
>>> The reason for deferring device creation is explained in dpm_prepare():
>>>
>>> 	/*
>>> 	 * It is unsafe if probing of devices will happen during suspend or
>>> 	 * hibernation and system behavior will be unpredictable in this case.
>>> 	 * So, let's prohibit device's probing here and defer their probes
>>> 	 * instead. The normal behavior will be restored in dpm_complete().
>>> 	 */
>>>
>>> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
>>> qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:
>>>
>>> static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
>>> 				      struct mhi_result *mhi_res)
>>> {
>>> 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
>>> 	int rc;
>>>
>>> 	if (!qdev || mhi_res->transaction_status)
>>> 		return;
>>>
>>> So what this means that QRTR is not delivering messages and the QMI connection
>>> is not working between ath11k and the firmware, resulting a failure in firmware
>>> initialisation.
>>>
>>> To fix this add new function mhi_power_down_no_destroy() which does not destroy
>>> the devices during power down. This way mhi_power_up() can be called during
>>> resume and we can get ath11k hibernation working with the following patches.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> Any reason for reposting this series without discussing the suggestion from
>> Mayank?
> 
> Baochen quickly sent me fixes for the v1 review comments, as I have been
> out of office for some time I didn't want to sit on Baochen's fixes for
> too long. Better to get them out of the door as soon as possible. I will
> definitely look at Mayank's proposal but that will take longer.
> 
>> As I said in the internal thread, this patch breaks the Linux device
>> driver model by not destroying the "struct device" when the actual
>> device gets removed.
> 
> This patchset has been tested by several people, I'm even using this
> patchset on main laptop every day, and we haven't noticed any issues.
> 
> Can you elaborate more about this driver model? We are not removing any
> ath11k devices, we just want to power down the ath11k (and in the future
> ath12k) devices for suspend and power up during resume.
> 
>> We should try to explore alternate options instead of persisting with
>> this solution.
> 
> What other options we have here? At least Baochen is not optimistic that
> using PM_POST_HIBERNATION as a workaround would work. The issue we have
> here is that mhi_power_up() doesn't work in the resume handler and
> that's what we should try to fix, not make workarounds.
> 

Adding Mayank directly plus others to this discussion since we need a
solution to have proper hibernation support for devices containing
ath11k (and in the near future ath12k).

/jeff
/jeff


