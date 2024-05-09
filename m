Return-Path: <linux-wireless+bounces-7400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C28C1423
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 19:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F5EB20ECF
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21946364A5;
	Thu,  9 May 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RNJr5Uz4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934023611D
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275981; cv=none; b=J42mOlyp7PyqRQ0vgts1LbBP5J1lK08yGIcLHcAjjEgBaAgHV1SFoTSlszGq88sj4OFA9gLiEQpEasp5iDLYo5JfCvsL1SYOM6cwExUsB6gyveJZFOFVrEsOl0AoHVj8r4BowEgruuN2D2C3b5y+ypYBX3xxVZPDs8VHnbXEmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275981; c=relaxed/simple;
	bh=hGhlYYMkE6EEQUkImt5bUmMJAw+zzPezAGduNWNo6/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FPSRS7kKdXJGAk4qTHeM6cNGkMZW6RIqbxkz++s5iugxQJKmV1fAkMaDBhYW71dVdC0hhvZFmhaH47s+keE847Nf8Oxlo89RHLIROXLswa2tuldNrsoIXgkZGwmmQZsy74OGXmqOo5zMkhq4OxjEf2sEPKrVSp0QXkwtquE4s3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RNJr5Uz4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449EfmhI011743;
	Thu, 9 May 2024 17:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hGhlYYMkE6EEQUkImt5bUmMJAw+zzPezAGduNWNo6/4=; b=RN
	Jr5Uz43/6Lz5gscCb3FenkBz7ODS3SesXLn5KNPZ2Nod31uw3LpRkzH6oB3OZVTk
	H/JGgg3iiWfH61vqa4a+64+H4Glnrjwy5nB9z99q0uGMT5Y2O95rpZLkMbXNaiN/
	ras1lDzywIYEf+iuH3MU/orjxpeDA9Nkz2dkGbEqiIL3Ql8tW0t16Z1mLitoG4Ej
	2M2NKwr7+A2YTvMhOy+Vq55k+krNl2n8ragc9mVhNkEDiy6TUzxzHhci3LwBAtxd
	2CXQdyWIfCbjYPSddFxaTtS+2SZvvXqT8cJV87HhSzQqF7OCVyPEC4NXXwWvr3HP
	F0GSQb4iDeRSx4lakQMg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07u0kfem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 17:32:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449HWsMF005846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 17:32:54 GMT
Received: from [10.110.102.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 10:32:53 -0700
Message-ID: <7153876e-2270-4bca-a47a-d45ca165fa34@quicinc.com>
Date: Thu, 9 May 2024 10:32:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240509161631.3520506-1-quic_nithp@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240509161631.3520506-1-quic_nithp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0UP56Y_jhbZ5ndXUSV3mz-bA1HpXwewl
X-Proofpoint-ORIG-GUID: 0UP56Y_jhbZ5ndXUSV3mz-bA1HpXwewl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_09,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=656
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090121

you need to version your patches

