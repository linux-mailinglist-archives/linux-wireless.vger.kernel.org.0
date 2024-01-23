Return-Path: <linux-wireless+bounces-2414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6D839820
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B0A282EB1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D21823DB;
	Tue, 23 Jan 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MEVLSEuC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B10823B3
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035541; cv=none; b=c2Xkis7IA6gGOH3vz1oIERM5MvTpS8OlXwYqlsQpS+VEni4hTjLKa8TKK70YfN49shvg2m7hCPG67NywSwVhQf+KbuFjNz62QObq17Pesx48sfkfGuYxCf5PC698XCzU2ERHQ8HbAZwkVE2MpYnrAwoumnglVumpd9PRHSr1DaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035541; c=relaxed/simple;
	bh=rTf6gY/bbBD3+51ir4Q45D197ZZd5f2BtrPPRRQFLS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YozyS/4FXIP/9afBNV9u/T7EV0EM7k71cguTUUIHZVV1QsGyKr6lqUCNJIUHKZNVoWN8+s+l02zgv/i3TceOTU7B0UHTnAq1hw7x1CII2tNL704xOaSB5mz5kEC+hW5kkmPZLGRnux7njn2ZnEHRSoK4mGgLYWoXfNIh4wVGivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MEVLSEuC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NAdBBu007990;
	Tue, 23 Jan 2024 18:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=f6oMxZZ5pIPccXrHilnARmj9lR6LWAAjPVctC/9fqsc=; b=ME
	VLSEuCJDA0yK6QYP2mp2UIcUe11PyrEjbyigcdpPSlZeA3YsQXZ3bkb8kPvy4FKV
	tdsSqfcTl0l3GAGv6iFrLP/b0pZ4RctMI0iViu1wFvhKbnhGI5Pa2+LfgIlN88MP
	E7ZP5xY438L8tb6pTxTMybo2asmHZ6K+hMeq+ON9vJpP4u5RHtjabLJFWnMnZ+Ak
	WjYH8wfDUTGGmPMDrZB+P3Qkwz5VL8zrsXFWC5ssGSJAmT+VHrlB98o14/rLqsC3
	RrAwPufgZVqlSd7oIEDevhwehaAFG5CxitFBdbJI4E7xOtopdem4cYh3Z3R+qnr7
	vPq/tR9WsYgB5213sAOw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt8141ud9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:45:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NIjU7t002868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 18:45:30 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 10:45:29 -0800
Message-ID: <eef19795-96c1-4608-896a-4a41471be7ff@quicinc.com>
Date: Tue, 23 Jan 2024 10:45:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix issues in channel list update
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Sriram R <quic_srirrama@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240117062628.8260-1-quic_srirrama@quicinc.com>
 <170600237376.3897582.9674673785656987739.kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <170600237376.3897582.9674673785656987739.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mfQiezR4mDVHYASwscv4DL8lwwc_hfAc
X-Proofpoint-ORIG-GUID: mfQiezR4mDVHYASwscv4DL8lwwc_hfAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=879 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230139

On 1/23/2024 1:32 AM, Kalle Valo wrote:
> Sriram R <quic_srirrama@quicinc.com> wrote:
> 
>> Currently, the logic used to select the 6 GHz band is incorrect,
>> which may cause 6 GHz supported channels to not be updated properly.
>> This is because the 6 GHz max frequency supported by the driver is
>> being compared to the max frequency supported on the board. If in
>> some cases, the 6 GHz max frequency supported on the board is less
>> than the defined 6 GHz max frequency, all 6 GHz channels are disabled.
>> To address this, compare the max frequency supported by the board to
>> the defined 6 GHz minimum frequency by the driver.
>>
>> Similarly, when a dual mac card supports both 6 GHz and 5 GHz radios,
>> if the 5 GHz radio gets enumerated first before 6 GHz, the checks in
>> ath12k_mac_setup_channels_rates() can cause the 5 GHz channels which
>> were enabled earlier to get disabled when the 6 GHz channel list is
>> updated. This is because the min 6 GHz frequency defined in the driver
>> is 5945 MHz, which should be 5925 MHz since channel 2 is not considered
>> currently, but the firmware can pass 5925 MHz as the minimum.
>> Hence, update the min frequency supported by the driver to 5925 MHz.
>>
>> In addition, ensure that the channel list update to firmware updates
>> only the channels that the current radio (ar) supports rather than
>> considering the wiphy support. This would be required when multiple pdevs
>> are supported in a wiphy and they support different ranges of frequencies
>> or bands as in single wiphy support.
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> I did because it looks odd for me that these are capitalised (could be wrong though):
> 
> s/Min/min/
> s/Max/max/
> 
> Jeff, what do you think about that the patch and my changes?
> 
Both the patch and your change LGTM
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



