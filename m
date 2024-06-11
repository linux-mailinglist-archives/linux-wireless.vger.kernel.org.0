Return-Path: <linux-wireless+bounces-8814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386190459C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A923281F34
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCB82490;
	Tue, 11 Jun 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OhCyaolU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462A14EC6B
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136750; cv=none; b=kC4B9aoHJO5whWjT5IgsCtoDRhbIhCyhH2UC6Wz0gcyiNdmWpe+DaJJo7x5HbGNH4GKR4fpUouV0sZm4ovY2hE0ywDg8EJovFNPXnOJcKSfcOOQR7Lvc/Evw2Q9HhAixE2n7H5MBLCIF38JSoh7PjcJZzVV9k0icBzGFD1s1fg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136750; c=relaxed/simple;
	bh=37MkwqE6BwgFCvFqrk72286BZj10s7UGk4T1yCrFqv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CSzdMk3fbdM340yjdnh6A7WwRgV3+ilRWs5hsOCLw4pFxu2p50Fl4jwTS+rz+6K/dnu+YK6fDIYEMYn2i6bpcX0aH9QgAPd2jlm58JQ6OzmRUrtCEKmghFQ8oz30q7BPxLaLMZmjg0L2CTXCgwy7fjV0ZYSyJC8FHn51j2v907I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OhCyaolU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFMbHA025862;
	Tue, 11 Jun 2024 20:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vBn9Atv4yy0F/AkQt7lJZsJ6vAk7WySkQt8MADqcxZc=; b=OhCyaolUISVRAJWD
	aZtnxrWGkFJb5JB2secGAm/qi4bRPDmHp6F/Hg4tWfKsBSLrOaMAyIKWHnAE7AsW
	wNq3Xwe31fnJXElMM2DBTf6mjrhnW/L9Cmveif4f7Zmfn07n8N9Hk7YTKcuGJgM6
	9Vb/r66lzjABhJ0v2Ong9i3TiYotV3Z//eZa9aS8TZtd4hlq+Y75v4Z1RwGjbTnZ
	wNjhdib10CyChvC7rynIeHR6zfPWFYPtL9ko2N0MU+Q63o16sBibobeZPVXSAlHv
	ajvgvZr5ZH4BVZ2omqPy4zng4X1eGw7f9GnYNYjoKKg/e5wouL7pPbrM5P8xJass
	JWo9sA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5x8n5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 20:12:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BKCNif017673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 20:12:23 GMT
Received: from [10.48.243.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 13:12:22 -0700
Message-ID: <ca371484-0d6f-4947-a50a-6b637b834007@quicinc.com>
Date: Tue, 11 Jun 2024 13:12:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix NULL pointer access in
 ath12k_mac_op_get_survey()
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240611031017.297927-1-quic_aarasahu@quicinc.com>
 <20240611031017.297927-2-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611031017.297927-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: odZ2tJaBYCCy2QSxHIFGs-V00uydbXTn
X-Proofpoint-ORIG-GUID: odZ2tJaBYCCy2QSxHIFGs-V00uydbXTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=960
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406110137

On 6/10/2024 8:10 PM, Aaradhana Sahu wrote:
> Smatch throws below error
> 
> drivers/net/wireless/ath/ath12k/mac.c:8318 ath12k_mac_op_get_survey() error: we previously assumed 'sband' could be null
> 
> Currently, we access sband inside the null check of the sband
> in ath12k_mac_op_get_survey().
> 
> Fix this issue by removing the entire if block, because decrement
> idx is unnecessary since there are no more band to test.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 70e3be54bbdd ("wifi: ath12k: fix survey dump collection in 6 GHz")
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


