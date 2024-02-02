Return-Path: <linux-wireless+bounces-3041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E662B8471FA
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E4EB2B33E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62018E11;
	Fri,  2 Feb 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kvW+dSTs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DAB2B9BB
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884376; cv=none; b=JXpbUwAmU//qxA5b1POhIg9oQ2adhBD4blQJwQ8i1eRtt2iJ55pjpqb/qPQfDH8jzvid87QAyfEm/bj3tNRyCQBLiBCYXeN+RTDXuPttkm2PgYOXzE2rVe6vBAYaL7i5hDf79LfplXThDRqfc8IT5+tRYrTKu5ESvTEdvx1SzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884376; c=relaxed/simple;
	bh=T5kkIQMu/fbq1looBv0R7PFR5GT2ZctEMErKPwdpwEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e0p+SnTArPi/jNm4B3kWmvCPf8TsU1UOmAl+pNnmszoUgY/IMnv8tqOnTSO7g9qmt4KEogStaeAd5uzMS95DqJF7r9sg/rEVzdT7feRZBNyYBLndEG5orAlUzVlJzwL1V0/3iBdKPlnR9I48c2h4cLf6wmod1Bxx7g3D/1skb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kvW+dSTs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412CkCYs010543;
	Fri, 2 Feb 2024 14:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gMR0f6pPEG9XXumtI/sMRTZYLSfX0HhhNJuMH7nQGYo=; b=kv
	W+dSTsEwpc4dNvIArZWbdecwYPf2Gx0nUmB2Wm0BdYyGx5jMQ50gN6EsP3d6Z6kb
	Nn1gNg9WDJnklh6/ojcW+HdJN+2xtmSZ7Pt7btkh820t6EtPAOo46h6shk6Aqm/D
	yfy6vuhfFtw6DBhwsfSsiWXA4AaxyzTrmV5YSgJNNfGvHlJe/rNfe4CxFbc1s6QD
	IPAyiT3YoUKYYLvbMY6fr8rYfnqdOtfBFqJwUtzCDK8cDpxEkV+uaDhnTP+BmQZT
	o3mdEPGtGU1M87Wjnu1tDn2oWFZhSRu85BRrsMRkaDiRIDXSp3U7bnlRMaVuclY5
	eNf19bOI38p83p36hzKw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptv1ky3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 14:32:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412EWmDW024845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 14:32:48 GMT
Received: from [10.216.55.87] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 06:32:46 -0800
Message-ID: <86e82bb7-eb30-f025-79d6-0fe739255243@quicinc.com>
Date: Fri, 2 Feb 2024 20:02:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 05/13] wifi: ath12k: Add logic to write QRTR node id to
 scratch
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        P Praneesh
	<quic_ppranees@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
 <20240129065724.2310207-6-quic_rajkbhag@quicinc.com>
 <b7a6ad2c-7f28-4758-921e-f77b56b5190e@quicinc.com>
 <87il37t5uh.fsf@kernel.org>
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87il37t5uh.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yyvFFPFrvnsznQ7wpWlAh16gFqLKxzH5
X-Proofpoint-GUID: yyvFFPFrvnsznQ7wpWlAh16gFqLKxzH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=524 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020106

On 2/2/2024 5:50 PM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
>>> From: P Praneesh <quic_ppranees@quicinc.com>
>>>
>>> Currently only one MHI device is registered successfully on platform
>>> having two or more identical MHI devices. This is beacuse QMI service
>>> runs with identical QRTR node ID. And, qrtr-lookup cannot register
>>> more than one QMI service with identical node ID.
>>>
>>> Hence, generate a unique QRTR instance ID from PCIe domain number and
>>> bus number. QMI allows node id to be written on scratch register.
>>> Add logic to write QRTR node id to the register. It is available for
>>> firmware to uniquely identify an instance.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Depends-On: wifi: ath12k: add firmware-2.bin support
>>
>> I would not expect this information to be part of the final commit text,
>> but I suspect Kalle can remove it when it goes into the pending branch
> 
> Yes, I removed Depends-On. In the future, please add it to the cover
> letter or, if there's no cover letter, after "---" line.
> 

Sure Kalle, would follow above for future patches.

