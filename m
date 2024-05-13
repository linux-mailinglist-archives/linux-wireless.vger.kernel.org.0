Return-Path: <linux-wireless+bounces-7619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A18C4A05
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDE21C20C91
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 23:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8682488;
	Mon, 13 May 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oEeYz8DU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22929446BD
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642899; cv=none; b=SNjY/xn3c/QpguhVBTo5lTnRWAtuSkgXwECptv6u10+Z/PBslcANsPunc2CRY+I6PIP9PyDW0p8F8HlB9/fl9iztdxsSDrcxTD794GzzB8W09ZcVQEU/PDIqYXd0/XpRayxlCCfFWD4qcp3oKAA/0EKVgBm0lJ1dyvFXq1dat3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642899; c=relaxed/simple;
	bh=+Dtr6nWG9I8fH7J3ZH4sIm4YmPDT8ugt5AOHz2Tba/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FJT358CBztgrFlI5TMTdceNuhIXOEcBIlYID+Xg9ixa/lfIpH8rE7y0M/t3NBv4aP2v53YDn/Dp1nsTx2RGrY1rmjXFkO8doeoj11ipnb7xZ0iMHF5txTfmKwoM/TTEv516tRa7uNQpagsfypqF+vino6vyZuydL03TiU3avdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oEeYz8DU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8X6r001604;
	Mon, 13 May 2024 23:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u6YShh0aQ68sFU57JRqaHZGjliu20f7Nh9BZfELiT+g=; b=oE
	eYz8DUbVnCg1SkdbKuwM/YYTiXfGrxsyKJ/vOcDVIW0/djBovmCKCA5wNH4eZriX
	nsH4jPRC/qd3RGEckRbP6vnL95W6s69f4XGt74JdK7550SrWVuRDUGbmSiPr1+pN
	WH83bJTQtvAwaHFTED00yxBXanX78xvzgcgpu/7v+5BZd7bRLj2cdpgidla1Bs6h
	urYC7i7ANaAaHLE0BwI0F/BqUX2iAZEgXiLW/Q4HvkqaQZjhd8HV39sCWVZ+wxJU
	5pd1hHXp5eUElsUfEGss0TscF4M3Bt8RsziKqPrpgd+vtdR1wO52uzc9wieSM9jD
	in6v8S+wdIixdaeiHeOw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y21uhcn6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 23:28:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DNSAX8009402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 23:28:10 GMT
Received: from [10.110.0.4] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 16:28:09 -0700
Message-ID: <31dcf319-8a3e-4128-93b1-17b3f900ce81@quicinc.com>
Date: Mon, 13 May 2024 16:28:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: remove duplicate definition of
 MAX_RADIOS
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240511013644.3103905-1-quic_periyasa@quicinc.com>
 <20240511013644.3103905-2-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240511013644.3103905-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B5EvIpy4VSZkZwkD8cEOmNQbdIwu5FJl
X-Proofpoint-GUID: B5EvIpy4VSZkZwkD8cEOmNQbdIwu5FJl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_17,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=761 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130161

On 5/10/2024 6:36 PM, Karthikeyan Periyasamy wrote:
> Remove the duplicate definition of MAX_RADIOS from the core header file.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


