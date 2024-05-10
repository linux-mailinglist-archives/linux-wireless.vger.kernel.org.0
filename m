Return-Path: <linux-wireless+bounces-7452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EF8C247E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D920B248EB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462E16F0C9;
	Fri, 10 May 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hQGzcViU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64D16EBE7;
	Fri, 10 May 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342624; cv=none; b=OqU7HwDR7S1y+ymHEbjn7rtJSIlF2+errlRqw5dXipD5zonJpzFxdwHGbl8bz8DnjzD4uj4VbWkQ9ctykM+grmvPb23wY2b1hJCdi0kfP58r1JBZSikJgQvdLyPxswtMr5+HKGpOAeaxLN16zWD8Yxv/BDUj74DPd7iWQc73DOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342624; c=relaxed/simple;
	bh=lZzwUo0bwUgqt4Np6zfyJqvXBSlDh919/DhD5L4C3tY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n/R2IGrZ6e+SRFyi3+l4sK8s6UQ5KHStVHsMxQFpCfrmfbXfaSc2Z691zTuKj5irBUaLFnhKjla6EnsTo1rgJuxiEGCYZ4vtARY5VKp7/9H/R3/iiKaD2JVkgMPHHTDwXe6annVbpXvB+zw6Ah6uNaY4JDqFHzRRThAAAKAJ/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hQGzcViU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tgTv019365;
	Fri, 10 May 2024 12:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:cc:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IpWL2Qh0aMjo1WaIYGgO3U1+9lnd/brvjGGL4nzpegk=; b=hQ
	GzcViU1y2EBdlys/W937YUgY5/ox4IatHkRTxmPgJDZJjAcriRv5IAADNP1JcgO0
	U0Xuv3R0zjc/G6pxNy9IbzPmtoYvMgZ5lLFhSXy+KEwaM/OTxl7+LwhJ3r3QMRdF
	ZOx/I8Ku3JPfeEcYu+fGgC8rFYVGnWUGLI3Z8on/cTsLt2VajgwtL+kk57PJ+5ht
	TrV2q73zH5T6LdFWE0cCpMWROqUxSpMNPgAdoFMl0TegynRTjMrqyxgzif+laiIh
	qSUMPaa4rvAunCOBF6ZHsyMi9twwsimoSi1fiamuSxkY6/qS0Eqj2PJORPUdnrCU
	2qWFeorSYfAcYnFC+YgQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w1hdah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 12:03:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AC3Wmb004709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 12:03:32 GMT
Received: from [10.231.194.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 05:03:30 -0700
Message-ID: <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
Date: Fri, 10 May 2024 20:03:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <quic_cjhuang@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Kalle Valo <kvalo@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
Content-Language: en-US
From: Carl Huang <quic_cjhuang@quicinc.com>
In-Reply-To: <87jzk2km0g.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WpqhGkbN2SNsR2PjoniTs9OiVDwz47s3
X-Proofpoint-GUID: WpqhGkbN2SNsR2PjoniTs9OiVDwz47s3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100085



On 2024/5/10 18:18, Kalle Valo wrote:
> "Luca Weiss" <luca.weiss@fairphone.com> writes:
> 
>> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>>> Add hardware parameter support_dual_stations to indicate
>>> whether 2 station interfaces are supported. For chips which
>>> support this feature, limit total number of AP interface and
>>> mesh point to 1. The max interfaces are 3 for such chips.
>>>
>>> The chips affected are:
>>>   QCA6390 hw2.0
>>>   WCN6855 hw2.0
>>>   WCN6855 hw2.1
>>> Other chips are not affected.
>>>
>>> For affected chips, remove radar_detect_widths because now
>>> num_different_channels is set to 2. radar_detect_widths can
>>> be set only when num_different_channels is 1. See mac80211
>>> function wiphy_verify_combinations for details.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>
>> Hi Carl,
>>
>> Unfortunately this commit breaks wifi on a QCM6490 smartphone
>> (qcm6490-fairphone-fp5) and makes the board crash.
>>
>> Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi:
>> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
>> provide address list if chip supports 2 stations")) makes wifi work
>> again.
> 
> Thanks for the report. So the broken commit is:
> 
> f019f4dff2e4 wifi: ath11k: support 2 station interfaces
> 
> This went into v6.9-rc1 so I'm guessing that WCN6750 support will be
> fully broken in v6.9? Not good. And most likely Linus will release v6.9
> on Sunday so it's too late to get a fix included in the final release.
> 
> Carl, can you fix this ASAP? Or should we just revert the broken
> commits?
> 
> Adding this to our regression tracking:
> 
> #regzbot introduced: f019f4dff2e4 ^
> #regzbot title: ath11k: WCN6750 firmware crashes during initialisation
> 
Kalle, looks we're not able to fix it before Sunday as I don't have 
WCN6750 setup to verify the fix. The fix could be to define a dedicated 
function ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the 
patch out so others like Luca can have a try.


