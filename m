Return-Path: <linux-wireless+bounces-9138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3690C330
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 07:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C42831AF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 05:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A5E63AE;
	Tue, 18 Jun 2024 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eLPEPlo9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B12CAB
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689784; cv=none; b=YXMiinDWfjWmrvuVKSeMu9WIFSno7kzggJ2cW5bgqTPtLKn9Jzos7MaucnVQVwipLp4eteZH6iuX1aRBeW527af0mO9jWXftiJM9Yx33UubKSiAD8kOcU6jyfppOjqRk0eePzX8dXKQFV026rrRPTan3niHR4SGM32wnnOI18f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689784; c=relaxed/simple;
	bh=L1yfRy73zK7fhC+ibTlAFWbiKqNcTbo0TmHYyetp0vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dCRnT6alOthSHKFh1mStxtXEb0GsdQwmy7vu+bE+7SMVkiRMgkRqdr0kWS1G4VHp27sLsXV96HTqXdFfJA2+Z2SHAv303W+KOQ5HTNAT7mLs8/S5VcW2/98l45eJchJzIpFGrbcXojl2+w7E92wyEenl04HAyvoVldmpXvzbkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eLPEPlo9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I2HgYW000845;
	Tue, 18 Jun 2024 05:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FJWQt3P/f6ssh6oPbuqXdOhkkqHXG+vxc17Pr2YVQ+g=; b=eLPEPlo9/6Uq5cb8
	OT6k3a8RkyMHo53tuxvUEhIe+z2doSYcKDcX+PlzxOrWuYW/xIT+nrKdORX3I0zb
	YykMXIdisBzezX/JylzaEv6CaI5nHOjGIeWlI/FUYMCOFKuR4yRtiWesUDio5gAd
	iydf5RwXEOJoxWK6ddOBcki2ujh3E/IdfxLfXsz5Dd01eVh/6pmOvTCulgRdHDdx
	GF+pb6tdKz5y/Fy++QSHbrpdDbX90xorExcPF3sWi0Z6c5kd/cYAbhPUXxKeyZc8
	R33ph4MnPwFneaEmX/hbfz3BZ9lqI1xBpoFysuQ9E39QICuj7iVZMWztCm6lAucz
	PIpuAg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu1b0rbsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:49:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I5nXco003260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:49:33 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 22:49:32 -0700
Message-ID: <f66c2719-f413-4348-8440-97a169430043@quicinc.com>
Date: Tue, 18 Jun 2024 13:49:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] wifi: ath12k: implement WoW enable and wakeup
 commands
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
 <20240604055407.12506-3-quic_bqiang@quicinc.com> <87msnjn0qs.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87msnjn0qs.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HoFiZzD_QeGLbs4loHUtUqhNG3scUk2d
X-Proofpoint-ORIG-GUID: HoFiZzD_QeGLbs4loHUtUqhNG3scUk2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=741 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180041



On 6/17/2024 9:43 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> Implement WoW enable and WoW wakeup commands which are needed
>> for suspend/resume.
>>
>> Tested-on: WCN7850 hw2.0 PCI
>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]
> 
>> +int ath12k_wow_enable(struct ath12k *ar)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	int i, ret;
>> +
>> +	clear_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
>> +
>> +	for (i = 0; i < ATH12K_WOW_RETRY_NUM; i++) {
>> +		reinit_completion(&ab->htc_suspend);
>> +
>> +		ret = ath12k_wmi_wow_enable(ar);
>> +		if (ret) {
>> +			ath12k_warn(ab, "failed to issue wow enable: %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
>> +		if (ret == 0) {
>> +			ath12k_warn(ab,
>> +				    "timed out while waiting for htc suspend completion\n");
>> +			return -ETIMEDOUT;
>> +		}
>> +
>> +		if (test_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags))
>> +			/* success, suspend complete received */
>> +			return 0;
>> +
>> +		ath12k_warn(ab, "htc suspend not complete, retrying (try %d)\n",
>> +			    i);
>> +		msleep(ATH12K_WOW_RETRY_WAIT_MS);
>> +	}
>> +
>> +	ath12k_warn(ab, "htc suspend not complete, failing after %d tries\n", i);
>> +
>> +	return -ETIMEDOUT;
>> +}
> 
> Why the loop here? Looks really odd to me and no explanation why it's
> needed. ATH12K_WOW_RETRY_NUM seems to be 10 so this can loop a lot.
Host asks firmware to enter WoW mode using a WMI command. While receiving it, firmware might be busy so that can not enter WoW immediately. In that case firmware notifies host of ATH12K_HTC_MSG_NACK_SUSPEND message, asking host to try again later. Per firmware team there could be up to 10 loops.

> 
> ath11k seems to have a similar loop and no comments there either. I
> clearly missed that in review.
> 

