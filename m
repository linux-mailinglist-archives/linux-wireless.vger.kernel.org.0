Return-Path: <linux-wireless+bounces-6959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBF8B5030
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 06:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885331F21716
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 04:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B338F6E;
	Mon, 29 Apr 2024 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pHLlooPG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032268F6A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714364773; cv=none; b=ado3+fTm0GD2VoQUve+9PP312wNbx8GzTjeG6oTjbLGcsQPSNZxPBUUOEhpTcCpsIv0vxJZ6m65N1MMIf07nybIxeXvU2dwHwdgsitINGJCSz59GaBZOV51XFcGa8pw4clpME1ksoLCb2XWA/fXxxUxV0NjHzgUf5G6oUFR3eMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714364773; c=relaxed/simple;
	bh=DItHKFvS5X7tHsmnH/VJZ2520F30bXr/2KwEitz3R00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pikGk9o/fJDvQLJbZQL8YbWnUmhjbI/tVszwrwNVQbFrf9mdiEzvugj+nIN2YDC5RyouLDTldO+g+xNBzEgT+axTL5NVgBhxL1idsViPQA6t3GF+E2D7tNogJqasZ9PsZGRlsclMyVLF4mRadKmApbziyjrzM81/OYdef7PU2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pHLlooPG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3xNQV018489;
	Mon, 29 Apr 2024 04:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=528m1WBys0h/T5fu3za+Edk+b8XQSJAHr/04TXkqC/g=; b=pH
	LlooPGMkeUlcC+6QtD3VQpt1BnIudcdo+6mTyBHla/R0O+as8IfJzd/jqrvPEVF+
	c553eVmWJbq8BbiHQwJxPKUrrakojMbYNYl1Se5jSF5VOhtyhzRQYBJLBg+3wpfG
	92BJQs1/jXjTw21MFLsixv4T0Ei1xmLJC5sMzjVgt+MWJbCiBvlbzQEfwNbDJi0a
	LxUs2HTQjpXiKhE8hn4O4Rhal8g87hQOod1q/901ftLlies+yUGubp2K1Ml8oEvR
	QiJ0uwEOF5gUek7zZkFF0LMCGbFRDYh1Fy/UY8pc0kzVoEOnFctlj1l0IcAG33em
	Q+mNOllLh3P+XtHzCeiQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrry4jnam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 04:25:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T4PSQR010445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 04:25:28 GMT
Received: from [10.151.41.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 28 Apr
 2024 21:25:27 -0700
Message-ID: <4f567b1a-aebc-709c-5303-ecbeb5cebc30@quicinc.com>
Date: Mon, 29 Apr 2024 09:54:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCHv2 0/3] wifi: ath12k: Remove unsupported and unused ring
 configurations
Content-Language: en-US
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
 <4cea96f8-399c-0974-4d9c-21bf5eda143f@quicinc.com>
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
In-Reply-To: <4cea96f8-399c-0974-4d9c-21bf5eda143f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pVMBjLGJPUUXmAZ0bR6kgFLs-XWnlZic
X-Proofpoint-ORIG-GUID: pVMBjLGJPUUXmAZ0bR6kgFLs-XWnlZic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_01,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=850 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290027

On 4/28/2024 8:59 AM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/27/2024 9:56 PM, Tamizh Chelvam Raja wrote:
>> Currently in driver doing memory allocation for tx_monitor,
>> tcl_cmd_ring and tcl_status ring. Here driver support for
>> tx_monitor mode is not there and memory for tcl_cmd and tcl_status
>> rings are allocated by firmware and it uses that memory instead of
>> host allocated. So avoid these unused ring setup configuration.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Tamizh Chelvam Raja (3):
>>    wifi: ath12k: fix calling correct function for rx monitor mode
>>    wifi: ath12k: Remove unsupported tx monitor handling
>>    wifi: ath12k: Remove unused tcl_*_ring configuration
>>
>> v2:
>>    * Rebased on top of ToT
>>
>>   drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
>>   drivers/net/wireless/ath/ath12k/dp.h     |  2 -
>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
>>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
>>   drivers/net/wireless/ath/ath12k/dp_tx.c  | 44 +------------------
>>   drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
>>   6 files changed, 2 insertions(+), 157 deletions(-)
>>
>>
> 
> It nice to see code removal in general :)
> But I've also seen some concerns internally around code removal
> especially when the code will have to be re-added in future while
> properly supporting the feature. I guess the cover letter
> may need to clarify those concerns at least for internal review.
> 
This is mainly to avoid unnecessary memory allocation for the unused rings.
And this can be added in the future while enabling the feature.
> Other than that, the series LGTM
> > Vasanth
Tamizh

