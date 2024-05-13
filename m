Return-Path: <linux-wireless+bounces-7615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246638C488A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C5F282D8C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B380BF7;
	Mon, 13 May 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NKC7EGaM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD029D02
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633780; cv=none; b=AsQNly5VWJ30FQm+u1BXIzYbxNFtC5aN7PVQloY1EO230PPiU+wAczwNN0pP6yj+eo27oqNNsNlQiFo6rEVJbpygIF2YZXcUPzKXVigarmg1qaSsdj4ZBEAx6np6p6ZYqkebYQvID0QcrP4/lpBrJ5LBgsxEOQLD6ZUxL8gBu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633780; c=relaxed/simple;
	bh=P3fOCsfQAItlT+/mXPDxKaHXs/F+4sQ/DzKW4E5bTQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RqrzSkDWihG61+4yDE9sGAKnR7H41fp2f4pkqPbPRHYL4nn/M9Lrgs7qEGJx2rOOp6B2p46F25FeEKbchZHaTjXoPDQmuoxoAMbrisqkPxEqnNiRZy279JP/H6Cem5Uc5c/bXa8lGTTU1zEstllnd3A5XjYRM6eC2nY/ZVWtsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NKC7EGaM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8vbo021552;
	Mon, 13 May 2024 20:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zTjuj5JDBZneHV80Tm96RWdngRKZ2JXEyDbmE+JokQk=; b=NK
	C7EGaMQk5bFg3iUoFBu9GCtkKPiXDnjvaQ8sREU0Mbq/ptLhmVQIX2bXOi/J/TNP
	9r+j1Aeat2od+oR7HvhY4VIEZ4o9JygYc6h9MpNa4p4C5czwASVZm15HspbSJyiM
	icoIULdU+VmgENMIxSO1FB633WoB+V+jb7GzhJAw3aOxinY6R/b0dKn9Va7HpreK
	Icg5DrA06T4Q8PGN0DTbtM26++39mO3pziO47IgphJrVQBR9DYAGcN2TBe+G1juF
	XZaZsIjSyztexVld5LzrTb0mrDLP5lLcfMCO7lZ0b4OkwQJIZCinHw+zuuMKscKF
	FOJQkTkbrKlzBZHlIHrA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21y7vg1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:56:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKuFVN021928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:56:15 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:56:15 -0700
Message-ID: <15047448-4fb1-4024-8d62-1922e8f15940@quicinc.com>
Date: Mon, 13 May 2024 13:56:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/10] wifi: ath12k: add extended NSS bandwidth support
 for 160 MHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-11-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-11-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gdMFGgMUORq1dkVVBEeV1PXeb_JtvKXU
X-Proofpoint-GUID: gdMFGgMUORq1dkVVBEeV1PXeb_JtvKXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130143

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Currently rx and tx MCS map for 160 MHz under HE capabilities
> are not updating properly, when 160 MHz is configured with NSS
> lesser than max NSS support. Fix this by utilizing
> nss_ratio_enabled and nss_ratio_info fields sent by firmware
> in service ready event.
> 
> However, if firmware advertises EXT NSS BW support in VHT caps
> as 1(1x2) and when nss_ratio_info indicates 1:1, reset the EXT
> NSS BW Support in VHT caps to 0 which indicates 1x1. This is
> to avoid incorrectly chosing 1:2 NSS ratio when using the

s/chosing /choosing /

> default VHT caps advertised by firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


