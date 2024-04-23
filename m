Return-Path: <linux-wireless+bounces-6744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB88AF804
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA2728C304
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390D142E70;
	Tue, 23 Apr 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aiJ7tD3x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810191F95E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904239; cv=none; b=NnJ0pjpLyBaYm8tjFjy0pHWyQ/RF8GcD3LPq24jflUCKyVYNmgYy3wlDAKgKqM5LpXxVy794RV8c+3fUpNxirohH3hu/kaAAaCqNzC1IhN296NspF9IhpLuwQRKEb5EiR/kpd5WeGKwPyZpC4Qm2t1UG6y5HKAROKaWvWhvAsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904239; c=relaxed/simple;
	bh=bWL+B5HTV0svjmjhOPN4XXTuczq6M7jJlUWxvcKJ8DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GGHtRThsdiNKNTnuiH9aq2AkJNUcsK8oU2mOwkPsLSDcvLKC8zuLAbLVF9IyjwkRlp54kMpGtLpYgmfyedoj/tGHs31K7BlIFavMuAEaCBc8MJxzfbAVzPpIs9QcfCKB25p6MVT4306cZj8obDC/hj23ujX3VI9HSAZtPJtJAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aiJ7tD3x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NJxqbt011590;
	Tue, 23 Apr 2024 20:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bAhnD3EruFqUAxnb2yYMsg8kMCiCu2z8DkDHiSAByzc=; b=ai
	J7tD3xI9Z3nHQQAEQBjG3WtGj4LTEc9mS9tZrmLanJU92GNvkqkZ79gfAC6ponuZ
	8VqR/+GsNQxOuKlOliI76Xvx6qlpy/KtPWkh5WOhMsoCU4TcDnILTVFTmTfGaYu6
	4Of3dAR0+b2Cjx/4WDgobjYPZMfAn5cF1rOFFAmezGYMEzgXKYPaQxwVIv9Hs9lM
	XLKhgEjhWbFFR/xa2L+Rqr/PWSA7NQkdNJByjuUsG3zL1SB2ZIILOVF5SdZlkVIN
	4OBJ/eVtTpoU6iBbNXHLlJ/Dtw3uPdBmDPIC2co8EHgrk0WICSNmrwi1aFtD6JhV
	WzscSQljIcmEi0DOHo4A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91rt7j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:30:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NKUW2q005635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 20:30:32 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 13:30:31 -0700
Message-ID: <da99c1e1-7d9a-4c7f-b775-119a329fba1b@quicinc.com>
Date: Tue, 23 Apr 2024 13:30:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath12k: pass ath12k_link_vif instead of
 vif/ahvif
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240422125630.1469456-1-quic_ramess@quicinc.com>
 <20240422125630.1469456-3-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422125630.1469456-3-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JR-KCe2CBDSwphwzNLTl-6lD7iEHwiKS
X-Proofpoint-ORIG-GUID: JR-KCe2CBDSwphwzNLTl-6lD7iEHwiKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=713 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230049

On 4/22/2024 5:56 AM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Currently ieee80211_vif/ahvif is passed as argument for all vif
> related control path functions that are being called from
> mac80211 ops. With MLO support being added multiple link vifs can
> be part of an ieee80211_vif/ahvif and all these functions will need
> link id along with ieee80211_vif/ahvif to be passed to fetch the
> corresponding link vif (arvif) to which the control/config applies.
> Also all these functions need to validate the locking dependency before
> dereferencing and start using the link vifs.
> 
> To avoid these redundant link dereferences and validations,
> limit ieee80211_vif/ahvif argument to mac80211 ops unless
> otherwise really required. Do link vif dereference and locking only in
> mac80211 ops.
> Replace vif arg with ath12k_link_vif and internally fetch ath12k_vif(ahvif)
> and vif(ieee80211_vif) if required on other functions.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


