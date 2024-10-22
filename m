Return-Path: <linux-wireless+bounces-14332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459839AB190
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D021F24439
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89319D8A7;
	Tue, 22 Oct 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="odwI68V+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07647199939
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609326; cv=none; b=TPT2on22ARZe64QSXjIjyzS4TnBu4p5jFefdFcP6msOjHWlseecQBIEl4clZHfZ1FtJz3GbcW9lXpM4/nNokmygXAvCl064ksXLAs0KW59VBNdENX23aKTXxTsTm5wyP9j0e/V7QK8e0qLTDQ/OxONZEBhzLEMxJYZAciY+Sw0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609326; c=relaxed/simple;
	bh=+nmH2mDG9OPxZsdHVCZRwcWwY/ukvN4xyFOh2GcJ0Ig=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RkGSwl0fqExFzY7BHq4WD0LtsWVvKl7tXcStdYsOmKTKRJY3Oa1XFs7bzM+f5CmUHhK6+rE9rwWhqnTZxPGFgE6/4zvwHMP46p2rskxNfpx3G303hCkdTcA/SuWUERXHw5SuZWUlBYt2mbZ5PD5uKYlCxwMpsn1F9dxkZ3pKHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=odwI68V+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8cl5E001061;
	Tue, 22 Oct 2024 15:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kFkqlKGvaFMJEMuyKE4i4ASVIdxSo9TRXOQEu6TIIE4=; b=odwI68V+bzgfDIuD
	mGRvO4C7s6XpRsS9AKsIlgZKGJOdU1biamfEBcGDBPmWVaOpvjYCsoyKNBbrmq4X
	kWZ3MuUwmBWzffEIw2/4T5T7m1JvJTuJalcPy6lXvrd3XDJe7j8Dk/pVPIPZxz+7
	/7YbrWiH4v4ufm83s4KQiSSmIvm59hFhsRl1XdsNFILVXMV7FOjs/iNzo/dEQCdZ
	vkfn2SII+JHAxKsLoCIP+5TeZFvJeaVzpFY+kihtRYQOKYHqre+H2kG5w/J3qADp
	HJoO1609lWJst87uiQq4MAXQJKXJZ8K7zjqFRGeh5joJpIZZlOnEnizEcMWleNDv
	bzdWlw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dmj14nsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:01:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MF1t7Q011896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 15:01:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 08:01:55 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <ath12k@lists.infradead.org>, Lingbo Kong <quic_lingbok@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
In-Reply-To: <20241008093039.11076-1-quic_lingbok@quicinc.com>
References: <20241008093039.11076-1-quic_lingbok@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: remove msdu_end structure for WCN7850
Message-ID: <172960931521.3037585.1883780470150742650.b4-ty@quicinc.com>
Date: Tue, 22 Oct 2024 08:01:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R0KYBL0-W0ZVRg6hvwBuSyWakLKME_3s
X-Proofpoint-ORIG-GUID: R0KYBL0-W0ZVRg6hvwBuSyWakLKME_3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=391 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220096


On Tue, 08 Oct 2024 17:30:39 +0800, Lingbo Kong wrote:
> Currently, when ath12k retrieves values from the structure
> rx_msdu_end_wcn7850, the information obtained is incorrect. This is because
> the definition of the rx_msdu_end_wcn7850 structure in ath12k is incorrect.
> In fact, the rx_msdu_end structure used by WCN7850 is the same as the
> rx_msdu_end structure of QCN9274.
> 
> Commit ed823fd113b7 ("wifi: ath12k: add msdu_end structure for WCN7850")
> introduced this structure. The original issue trying to be fixed with that
> commit is that the TID information retrieved from the rx_msdu_end structure
> was incorrect, and it was thought that the structure wasn't correct, so a
> supposedly correct structure was introduced. However it was subsequently
> discovered that the TID information is only guaranteed to be valid in the
> rx_msdu_start structure, so that commit added the logic to retrieve the TID
> from the rx_msdu_start, but unfortunately kept the rx_msdu_end_wcn7850
> structure.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove msdu_end structure for WCN7850
      commit: fd01ace1140476e97f1801a26e8e96a5626e3385

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


