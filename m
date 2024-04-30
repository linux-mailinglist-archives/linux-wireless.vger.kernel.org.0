Return-Path: <linux-wireless+bounces-7069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A608B7FF5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 20:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F1B1C2232B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570AE18412A;
	Tue, 30 Apr 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="prCAWFPf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441C17F363
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502603; cv=none; b=MTQntWlg9IUvhzb2TauxA4CQ+2A0BvKTXlDRS+wtKJ4s0znkbeGdbuUNizLFp3HyrEz/0GYLx2/YikfDPRlDqpm5NCSU/IN1bWH6dfpfT7rkFc7HIi0UMHOaQANn6J4qfm/tNe35eN7Dgb2vwdOwKcMT4E55MVN++6MCh/mHKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502603; c=relaxed/simple;
	bh=iCkLtDInbbiKCADWmEEsrydE11b8xRaEk4hhBZqNXxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=se9Z7d1GdfmNn2CJGkyc76glPdpSq0Pz2NL0fVV5xLHXdra/GrLISbRo1ZTq894VNbjFqyr6YzCzunMriafGrggE2aEupgdkqhhlo+ETTyTKE4gNc7jEJ6vdJRItWQKxUTAqYoKAwpL3K5Px6W4LaKauCSha9+qTmAxwXcnvx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=prCAWFPf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UELvQA012575;
	Tue, 30 Apr 2024 18:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TYbhv4+itN+J+L2rEkVGp8EGBVowo6xyD1fsVvmZsjw=; b=pr
	CAWFPfvXbbvPH91xshTGOR7THiak8uKijyFKU7cubYxO/juUN1OYq8aOfhUnjh2l
	XqFpUy+UZPcD+uHtvQlEMEHGo7QYMyLIIvN/i6pty3eDLEcXAlSwMb1CqaiEev+5
	cqyo25CJLhl5GmXi0jMbKMuYjAcFsIKuSTBOuEqu0EWsEk/4ivuGfXjTbmUZSedG
	QETrVdyDqmwBDpFmEDs8AgSRcrwHbqeS/rOiw6JuWwaZHirnfygVOFPrOrdMr+bT
	PHlITLiGJE9XmIq9AABOu+a8Nv7p7dRZtQX2hOtr9//wDqqedtRfTj6oUijJSrMT
	QYNGEkTNcZzq7cbIQXAA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtsnma85h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:43:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UIhI5D028966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 18:43:18 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 11:43:17 -0700
Message-ID: <047ecf09-fe6a-451d-b94f-7a3e89d74fe3@quicinc.com>
Date: Tue, 30 Apr 2024 11:43:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath12k: Refactor idle ring descriptor setup
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
 <20240430165811.1377182-3-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240430165811.1377182-3-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -R8stK28NTF-s4sg1DtMU-5ZCEKe3gzQ
X-Proofpoint-ORIG-GUID: -R8stK28NTF-s4sg1DtMU-5ZCEKe3gzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=528 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300135

On 4/30/2024 9:58 AM, Karthikeyan Periyasamy wrote:
> Currently, the WBM idle ring descriptor setup uses implicit value
> HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST for the return buffer manager
> parameter. To support inter-device MLO (Multi-link operation), this
> parameter needs to be configure dynamically based on the device identifier
> within the MLO group. Therefore, introduce a new argument to the helper
> function ath12k_hal_set_link_desc_addr().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


