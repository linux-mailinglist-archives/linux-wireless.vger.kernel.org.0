Return-Path: <linux-wireless+bounces-4062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDEE868ADF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 09:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BCB1C21D19
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B59130AFF;
	Tue, 27 Feb 2024 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nNG3nYay"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D75644D;
	Tue, 27 Feb 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023196; cv=none; b=eGnBNnwajQZpeIEz+jqsMyQXFzrdHMfmLIB8A0WhITHx2CX2wjrd2x6oiSYTh1jS/q+VdpliQrcAFOTJPDbeojhKMgykiQm89f6QjjdLdIJc58wj1/6XE8peumwqD75ZtcA1mFidoRyM3XPOXW2RP4U/pOy3gizCu3Q7mEcANXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023196; c=relaxed/simple;
	bh=QgjXUdWRhAiLNVidZKzpjjbJdwxVX9JKUypmz+lJJtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c7SFpxRtJb5I6FnW7RzxwfEQS8kLye+mWRatgGQNDSQJRO8Ihk8ThsVcUHXLCCttvpYLkEUem091BoevEMpVqFq9A7DUDCeEr4Pbo7vLJdlLtmNtBiEjylDCn7+hmL10DvqPXPsnMkYR0/UlQyvbjuYpN1yFRBnzVSmEkElGG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nNG3nYay; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R40dbF017226;
	Tue, 27 Feb 2024 08:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uVGFFRDr9JaBIZ0whrl533f9t1vVl71AvWaZ++sgrSQ=; b=nN
	G3nYayJl2wyroBk/jOjAX/0+N+dUu/XR0YJm/FfbtRX9n4HjfxQNLfESs+ORUEHr
	Mw3qrZJXwRGGku9OKEQoU/iWzH0DkAzeoDHAmgxxugiZbx0H8N8l3r2C/A3qXLao
	JDdHRG4Ofz622iKl1YrtMbN38oaFOUfcD4ajESXgWH9U+DEQBQsZNN7ebYnR2ZUa
	IPR9u/3X0w6HGa+GKZqRdcFXvPiMiN8Qf4sqhrsrvv7i9xJ69blZQ4shAcZ6Eybb
	KwSuhnYdTI9D5DE5CB7UYFCYPMfjF8Ecoha+ALnNrKrNiJdE3ppozIm4X3kXM95o
	kwH7DqjT/xHukBCboS0w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8auggnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 08:39:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R8dkdU022850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 08:39:46 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 00:39:44 -0800
Message-ID: <7b743820-850a-4871-a0d8-aded36e11aba@quicinc.com>
Date: Tue, 27 Feb 2024 16:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: qrtr: support suspend/hibernation
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>
References: <20240227063613.4478-1-quic_bqiang@quicinc.com>
 <20240227063613.4478-3-quic_bqiang@quicinc.com>
 <20240227071531.GD2587@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240227071531.GD2587@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5gsdWGLxCr9R672uuB2L1r9-j4_qo7EH
X-Proofpoint-GUID: 5gsdWGLxCr9R672uuB2L1r9-j4_qo7EH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270067



On 2/27/2024 3:15 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 02:36:12PM +0800, Baochen Qiang wrote:
>> MHI devices may not be destroyed during suspend/hibernation, so need
>> to unprepare/prepare MHI channels throughout the transition, this is
>> done by adding suspend/resume callbacks.
>>
>> The suspend callback is called in the late suspend stage, this means
>> MHI channels are still alive at suspend stage, and that makes it
>> possible for an MHI controller driver to communicate with others over
>> those channels at suspend stage. While the resume callback is called
>> in the early resume stage, for a similar reason.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Could you please confirm if this patch can be applied separately and won't cause
> regression?
Just searched the kernel and found another two drivers using IPCR 
channels, one is pci_epf_mhi_driver in 
drivers/pci/endpoint/functions/pci-epf-mhi.c and the other is 
mhi_pci_driver in drivers/bus/mhi/host/pci_generic.c.

For pci_epf_mhi_driver, this is not impacted because the devices for 
those channels are attached to mhi_ep_bus_type while QRTR MHI driver 
attached to mhi_bus_type.

For mhi_pci_driver, I am afraid there would be regressions caused by 
this patch. The regression is because when system suspends, 
mhi_pci_suspend() is called and then qcom_mhi_qrtr_pm_suspend_late() 
called, however the latter would fail because MHI is moved to M3 state 
by call mhi_pm_suspend() in mhi_pci_suspend(). To address this, there 
might be two options: the first is to move mhi_pci_suspend() to a late 
suspend stage which would be called after 
qcom_mhi_qrtr_pm_suspend_late(). and the second is to avoid whole QRTR 
suspend operation in such cases. I prefer the second one, because if MHI 
is going to suspend, instead of power down, it is pointless to unprepare 
MHI channels and re-prepare them after resume back. We can achieve this 
purpose by adding a status_cb() to QRTR MHI driver which would be called 
when MHI goes to low power mode. And then QRTR MHI driver could decide 
not to suspend/resume if low power mode is notified.

Your thoughts?

> 
> - Mani
> 
>> ---
>>   net/qrtr/mhi.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
>> index 9ced13c0627a..e96b82a6742c 100644
>> --- a/net/qrtr/mhi.c
>> +++ b/net/qrtr/mhi.c
>> @@ -118,6 +118,32 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
>>   
>> +static int __maybe_unused qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
>> +{
>> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
>> +
>> +	mhi_unprepare_from_transfer(mhi_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused qcom_mhi_qrtr_pm_resume_early(struct device *dev)
>> +{
>> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
>> +	int rc;
>> +
>> +	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
>> +	if (rc)
>> +		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
>> +
>> +	return rc;
>> +}
>> +
>> +static const struct dev_pm_ops qcom_mhi_qrtr_pm_ops = {
>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
>> +				     qcom_mhi_qrtr_pm_resume_early)
>> +};
>> +
>>   static struct mhi_driver qcom_mhi_qrtr_driver = {
>>   	.probe = qcom_mhi_qrtr_probe,
>>   	.remove = qcom_mhi_qrtr_remove,
>> @@ -126,6 +152,7 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
>>   	.id_table = qcom_mhi_qrtr_id_table,
>>   	.driver = {
>>   		.name = "qcom_mhi_qrtr",
>> +		.pm = &qcom_mhi_qrtr_pm_ops,
>>   	},
>>   };
>>   
>> -- 
>> 2.25.1
>>
> 

