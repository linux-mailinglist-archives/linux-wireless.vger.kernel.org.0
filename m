Return-Path: <linux-wireless+bounces-6945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCF78B4965
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 05:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC42281F45
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Apr 2024 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA51854;
	Sun, 28 Apr 2024 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MNDSwu7B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCD15A4
	for <linux-wireless@vger.kernel.org>; Sun, 28 Apr 2024 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714275001; cv=none; b=nios6ZYgbvjFAHtA+tTAkoqNCDDSeiqA67BIdcrAWLJyWuGdtbGh05YNDJNNVlSD223MMm3CSTxWVq5AyfIvGW1FQtc0sCf5eMPRS3gnpd8wo7XPyc21bLDOa/VXWncWta9xdWNeEXTX913SVG2k47FP8A+QGrztT0vD+1y4GO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714275001; c=relaxed/simple;
	bh=VBHqlf3W/N9yjKmA06lk5RRxI4feGafU0fk/oxracDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LIU3RBLnPaPvmDuWAhPuVZSp7XewZy2U7HGMyDuBKisdUIyq9GNwYlORgjWLSEY8UCspoJub2pANCRuFChQxSaQDfyEIr6Hg2frgIj95GaBEGnnOKuzh5T+GT1+LqZB0xD6YHFlM/YkQyxjedU9NNoIsgZFHUroeqyyXG9ClkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MNDSwu7B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43S3TsgA018332;
	Sun, 28 Apr 2024 03:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cO8Mvl5OAgu+1BhISJ6VFybtPEk+K+33daikX9jiGX0=; b=MN
	DSwu7Bmv+GoGQFgu8JEhzzWr+GngA2qlIR8IZCuKWGmj6N2r9eNXY3Z4EG2w4f97
	ABibXeTGCka78vK7rzVDYby8vDthjwClamymvSAltNXHPrkMQ8Z7DrowVajZ1T5D
	GNG+wPKwEVtUJ38mReGHulUd/AWUZtfJ5DcSs2WjOr5wjkapkat73vgZOS5IAeSy
	XVVFNu0ERQch1wUXIuigSLmqntdK72LHe9TguQrPDFLY3YIWqnTIa0XrQzJiF95h
	F4zq2viRMdM2vVWjh2eH7gondHh51nUnwDJXKOK7MO0gHWAZPj43OdU1MCYMKNxt
	NgSk79q6ocoMMvalgNFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrrcch970-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 03:29:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43S3Tihv022767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 03:29:44 GMT
Received: from [10.216.63.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 27 Apr
 2024 20:29:42 -0700
Message-ID: <4cea96f8-399c-0974-4d9c-21bf5eda143f@quicinc.com>
Date: Sun, 28 Apr 2024 08:59:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 0/3] wifi: ath12k: Remove unsupported and unused ring
 configurations
Content-Language: en-US
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PXJTaAtXO_19WwF7yoSbqqXVB0ZXAmNH
X-Proofpoint-GUID: PXJTaAtXO_19WwF7yoSbqqXVB0ZXAmNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_24,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=925 clxscore=1011 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404280023



On 4/27/2024 9:56 PM, Tamizh Chelvam Raja wrote:
> Currently in driver doing memory allocation for tx_monitor,
> tcl_cmd_ring and tcl_status ring. Here driver support for
> tx_monitor mode is not there and memory for tcl_cmd and tcl_status
> rings are allocated by firmware and it uses that memory instead of
> host allocated. So avoid these unused ring setup configuration.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Tamizh Chelvam Raja (3):
>    wifi: ath12k: fix calling correct function for rx monitor mode
>    wifi: ath12k: Remove unsupported tx monitor handling
>    wifi: ath12k: Remove unused tcl_*_ring configuration
> 
> v2:
>    * Rebased on top of ToT
> 
>   drivers/net/wireless/ath/ath12k/dp.c     | 16 -------
>   drivers/net/wireless/ath/ath12k/dp.h     |  2 -
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 40 +----------------
>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 56 ------------------------
>   drivers/net/wireless/ath/ath12k/dp_tx.c  | 44 +------------------
>   drivers/net/wireless/ath/ath12k/dp_tx.h  |  1 -
>   6 files changed, 2 insertions(+), 157 deletions(-)
> 
> 

It nice to see code removal in general :)
But I've also seen some concerns internally around code removal
especially when the code will have to be re-added in future while
properly supporting the feature. I guess the cover letter
may need to clarify those concerns at least for internal review.

Other than that, the series LGTM

Vasanth

